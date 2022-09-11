Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E45B585D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiILK2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiILK2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 06:28:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C83A140
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 03:28:39 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB2946601FE3;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=iNmBW/pZ5k1lcPoOOq9rLFDlvwD6nReZtUJcntrWTbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfuWxOLm/dMqL4Iln1pEUdxNpZJLoh6ydeqg+K0CZ25w+/9eLby4s32IJMws4TVbw
         IwJQdDsRWYs8Sg1HiWsuAdn1eIcpmL4V1H4G0CMH42DhXxhxRxlOOGJ80xZcJVsEyM
         rMeqfm6+kDQeydz9a3z4l3UGFWdsZdsPHgl5xt1IzuVEvtycFOIJUHPXJwuCHHMipP
         +VBHSb3nhelnyGP5M291toxY2rH913HNBcb6VcbVaWTeQQ+F5JBzNFGsGqivkz0eP+
         CkMgFMBz6bbTa6vD25drO+u0gJqpD0WwxEWzOqHYxwSow5UPXvmQ09OFyeSeFY6As6
         bzZk6FpqbPDxA==
Received: by mercury (Postfix, from userid 1000)
        id CA924106335F; Sun, 11 Sep 2022 14:36:02 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:36:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq25890: Disable PUMPX_EN on errors
Message-ID: <20220911123602.nzti4urhf5th7ulo@mercury.elektranox.org>
References: <20220731100228.32920-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ub7uiy6quoyrep2"
Content-Disposition: inline
In-Reply-To: <20220731100228.32920-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7ub7uiy6quoyrep2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 31, 2022 at 12:02:28PM +0200, Hans de Goede wrote:
> When bq25890_pump_express_work encounters an errors disable
> the PUMPX_EN flag, just like the work does on a successful exit.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 852a6fec4339..056260b2cb76 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -946,6 +946,7 @@ static void bq25890_pump_express_work(struct work_str=
uct *data)
> =20
>  	return;
>  error_print:
> +	bq25890_field_write(bq, F_PUMPX_EN, 0);
>  	dev_err(bq->dev, "Failed to request hi-voltage charging\n");
>  }
> =20
> --=20
> 2.37.1
>=20

--7ub7uiy6quoyrep2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd1jIACgkQ2O7X88g7
+pp0Zg/5AZsqRtgPD86cL7Vzaze8LjaCISEBX/TC9Z6KvH5+QZEmLX7awwL27eQ1
rqKhBfBZUZBy9n0YMjLd0WzxzhS/FEsDKBqy4YXR/jTEIw6x/NgMs2Qr/Y5VsblR
AA81QllcyJme0GaGNjXAuGa25TUcCQH8aJSUXN2+weCe2IYZ4vNfc3oJKmGKABfF
PxrnsSlv2HBgBA8HPXI8wwx0X/3g9s8NlTpbNZEDjlmrbVs2Z/0PI0KyDJAPNFOT
I4x00NC7j0UrnOASEgN/zLiGDVuxegaZ5vEpLa9/NP6xsAlYL6W22d+z8CchVTPY
JBm55KasUEcPjn6//4/gRfD1YMmF8FCAu4F+mWlEMGgzQwNT1G2yXk7bCPy/1OKZ
05nTafJFCh0dFGZtUoXZDnriUH/BVKRWzLcRZ0HaZ7q+RISw+JKcEvDqLhoba/9y
2R39sIsZtzZ2l1qSddllCHIUm7FHfptIqr18YasLeo28Dfpav8FRtqd0jzH/uQVX
QReOWHmWgvCylZW0t5t0kg4EQN6NUe8QrJk5RcUw9B6TrMmPudYqdIOVpKTwbGFf
rsxx6ausBeJYoG6zlsWYqOLEnafILOCcxa/QjL4YEDguFzAQEcmC2a6AXW7vDhm/
r03kSeYYpz7P+jfWj8brUXGgJ0ChIDYYtJsgzEKcmt4wgA16SG8=
=Cz/i
-----END PGP SIGNATURE-----

--7ub7uiy6quoyrep2--
