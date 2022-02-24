Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA424C2B6C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiBXMIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiBXMIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 07:08:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F815F347
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 04:08:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1C6DB82189
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B3C340E9;
        Thu, 24 Feb 2022 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645704497;
        bh=JLTw2z/tH0dEudxqoxWLYPw7QsyhZBC4z8VwWwki0gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDnWtXd4MZeHiSZwWR7rMp1tDg+0P/RMhxLTsTrg7gcdJrTG/Jf31mLz4v52eIF0y
         2wZgzhyQMom1T0RrOHGPjl5LA0BuRz+jc0vg3UcsIjCiZxhMhOnnDZHAmuf98pI9ws
         zSRO9tcVaXDl1kJC0AoJQGGGRnP6mxNGoRtuD7ATz4H/6B4twbVqQ+xD97p7Mv21Nf
         mRIay0wyP+igFTQfVvloPCLZKSsTF0OgkkWaz5irerOjcCJ7hG7ZqH5qPHuhGhVnMl
         HcpvRIunRaV0MhUExy0vgvBB6Zz/O5f/ClqP74D/HdOGsasKoi6qr5MUKAxEwwzLgR
         KAisg7jzUnAVQ==
Date:   Thu, 24 Feb 2022 12:08:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Message-ID: <Yhd1LV9OPD/slCV8@sirena.org.uk>
References: <20220222214331.1557723-1-broonie@kernel.org>
 <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
 <666e7ad7-1eb2-f8bb-8ef8-d92d5e18d01b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XeO6c8hXkLP/RbWG"
Content-Disposition: inline
In-Reply-To: <666e7ad7-1eb2-f8bb-8ef8-d92d5e18d01b@gmail.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XeO6c8hXkLP/RbWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 24, 2022 at 02:35:42PM +0300, Dmitry Osipenko wrote:

> To make it more clear.. there was no problem with "suppressing a write",
> the problem was that regmap reads are done from the cache, and if cache
> isn't per-initialized, then you read zeros from the cache until write is
> made.

With update_bits() that can result in an attempt to set a bit to zero
not actually taking effect if it believes that the bit was already set
to zero and there has been no change in the value of the register.

--XeO6c8hXkLP/RbWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIXdSwACgkQJNaLcl1U
h9D4ywf/St6nKhFT/xeeP1SmEIm5Romffx6rU3zJvxJ8B04hyM3nK4hr7qTXW1Ed
nFnKw5MyADazBwxZyonEMUcC4c4xW9BbNj0WpGDhpOk8bPc1JXVkcqKcsiOmlsbI
TSNf0QFS/B/K3c3oYdjk1onewsuWGR2Ew4EKuvgSLO+qhwEu3rVdcX/06UIXeNeW
ydrCwRE7wj3eLYSbv3NPHYUQPmh2v4xijQxBEQPWMTquuFn5h6ltYYzg6J1caldv
sJjkgk3IOYjJdz0BaMAZX9fLZob9c4jdROCSg3wSWdehyETcEokAtOP+Zmo5Ck+D
zacC/9EbBmJCYywmuhw1qPdLsioCQw==
=6iZi
-----END PGP SIGNATURE-----

--XeO6c8hXkLP/RbWG--
