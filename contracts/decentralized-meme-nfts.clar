;; Decentralized Meme NFTs
;; Only two main functions: mint-meme and get-meme-uri

(define-non-fungible-token meme-nft uint)

;; Store meme metadata URIs
(define-map meme-uris uint (string-ascii 256))

;; Track the last minted token ID
(define-data-var last-token-id uint u0)

;; Mint a new meme NFT
(define-public (mint-meme (uri (string-ascii 256)))
  (let (
        (new-id (+ (var-get last-token-id) u1))
       )
    (try! (nft-mint? meme-nft new-id tx-sender))
    (map-set meme-uris new-id uri)
    (var-set last-token-id new-id)
    (ok new-id)
  )
)

;; Get meme URI by token ID
(define-read-only (get-meme-uri (token-id uint))
  (ok (map-get? meme-uris token-id))
)
