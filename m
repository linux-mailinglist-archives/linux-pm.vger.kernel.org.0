Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78B26412CC
	for <lists+linux-pm@lfdr.de>; Sat,  3 Dec 2022 01:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiLCAxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 19:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiLCAwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 19:52:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F182105EB7
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 16:45:12 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 026446602BC4;
        Sat,  3 Dec 2022 00:45:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670028311;
        bh=8+5IC0gTaYRrlg9h3H7vn8fJLCDf+5vX+jKbgzkm7/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N17ChmFENiCuFvreeuhpYCCKswwETPkbk3TPnCBOhYWObdzyI95KZG8tosM8vii32
         LwhV4hrgMASClDI5em6XSmlvtHAII3oIBPrqA8eDaHT0l3ypM4Dnxa0ZsqwSqA+VJ3
         Be1PsgKhUw1Sb2Z6/62+NI3mXuLnyNGGXQLiVp3Z5NluynOofbgxMB+fLcLOuNOdcc
         3IwCsiYUMhD/5cvgrpCnoqBMDKAjMIcEJLGUWGwP0kAgn2/izC1Tfe9P2R7CzvxXnU
         JlBkzusCWRjyFVlONpVNwrpslgpm1vZYGVrXGQtrrkKH3z94N1mxmYmfmq1IKY3WQ7
         lm+HB4Odry/7g==
Received: by mercury (Postfix, from userid 1000)
        id 8680E1060E96; Sat,  3 Dec 2022 01:45:08 +0100 (CET)
Date:   Sat, 3 Dec 2022 01:45:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     rafael.j.wysocki@intel.com, swboyd@chromium.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: fix missing device_del() in
 __power_supply_register()
Message-ID: <20221203004508.an3uf7wfcl3xjoib@mercury.elektranox.org>
References: <20221202094239.2130443-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="samwlflettv3qh5c"
Content-Disposition: inline
In-Reply-To: <20221202094239.2130443-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--samwlflettv3qh5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Dec 02, 2022 at 05:42:39PM +0800, Yang Yingliang wrote:
> I got the a UAF and some warning reports while doing fault injection test:
> ...

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=5b79480ce1978864ac3f06f2134dfa3b6691fe74

-- Sebastian

--samwlflettv3qh5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKnBQACgkQ2O7X88g7
+ppAQxAAqW2cVgiLwcYG6PJOL4FUhEzDp1XX1xotSuauN6WjGcshj2ovivmpgaxQ
N2H9Oa0q3HHwXGVnMgxeVGrzWMIzPryuoPWq2Uu7HN1jXz/63oJPJsDeCuc92Ekl
kr9WATlxsA2hBzhgVf53EOJV7N3C/20vCMYV7V7r0YF01BSCoOHnLMg0jdMwqzKk
y1f1TvVJJ81Fg9Vqhp/NdKtNTVxBfar7Ndt/tXBtw5LVAcTxVOmWwtEq/wIn2qpe
8hf7zkDIfTzLOsZesSdPjv1LYD/0eNC9TxQlbsSOiTwuDEuRgqTiu26m50+ooQM9
apXfITkc3ahbccW1x1pG/kBP6OMyf0xgw20VKmLDFwunSJH18+2nNB8f4RrzCLDk
kOtNqJEZuud1X7MuywzNpiSYdV4v5zUu5hM0UD5/fB98CElasM9VwapxNfvJWfbh
G2hQy32Tw0V+wBa92ZbGNZPfHTBHI32DQ39npgDflvGHM1bh1q9nd8vnoPRkLNSR
DeIeYbWxuGTLotQFceFhsTiPMvIMAFTdt1XKiMWSNRg2vKiuZlVJz/bHDuwO1AaE
cWiU8d065Y574ei300CiqfJzAmd4bwvNbemavIxQGLSZHOd6eL0siL0ojefwBhz0
x4FY5Xm+8yDExZM7ZSsh3GqFcaoFLr9rb/Cqvx9YoXQ1uw2ghpQ=
=as5I
-----END PGP SIGNATURE-----

--samwlflettv3qh5c--
