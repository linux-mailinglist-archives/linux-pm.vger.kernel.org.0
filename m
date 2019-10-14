Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21BD6B39
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfJNV0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbfJNV0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:47 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD39221882;
        Mon, 14 Oct 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088406;
        bh=cClK9PHRvWEw2NnVf5d1dnRD7hL2dOCyNw4YrCukU5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZuAWbu/9a5PfOaBOSQrzHQd82Vi90vTr4xLvxZKvwwpTqsyh8UxPFN4lVqAaDYFx
         ic04FfU1JUbUbXB8yGTgMBbjfcHwDylifYQbAaNLV2Wl9VLb9px40Lo5QvCTPxypMa
         uW8mFSK669v8CVPdJRZLia6mX+Vq1oqOaoHqAx3k=
Received: by earth.universe (Postfix, from userid 1000)
        id DEAE03C0CA1; Mon, 14 Oct 2019 06:22:20 +0200 (CEST)
Date:   Mon, 14 Oct 2019 06:22:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] power: supply: axp20x_usb_power: enable USB BC
 detection on AXP813
Message-ID: <20191014042220.ic6gt7koyr23iq26@earth.universe>
References: <20191002112545.58481-1-icenowy@aosc.io>
 <20191002112545.58481-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pglfpajxaav525ss"
Content-Disposition: inline
In-Reply-To: <20191002112545.58481-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pglfpajxaav525ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 02, 2019 at 07:25:44PM +0800, Icenowy Zheng wrote:
> The AXP813 PMIC has support for detection of USB Battery Charging
> specification, and it will limit the current to 500mA by default when
> the detection is not enabled or the detection result is SDP.
>=20
> Enable the BC detection to allow correctly selection of the current.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index dc4c316eff81..5f0a5722b19e 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -48,6 +48,8 @@
> =20
>  #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
> =20
> +#define AXP813_BC_EN		BIT(0)
> +
>  /*
>   * Note do not raise the debounce time, we must report Vusb high within
>   * 100ms otherwise we get Vbus errors in musb.
> @@ -495,6 +497,12 @@ static int axp20x_usb_power_probe(struct platform_de=
vice *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (power->axp20x_id =3D=3D AXP813_ID) {
> +		/* Enable USB Battery Charging specification detection */
> +		regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
> +				   AXP813_BC_EN, AXP813_BC_EN);
> +	}
> +
>  	psy_cfg.of_node =3D pdev->dev.of_node;
>  	psy_cfg.drv_data =3D power;
> =20
> --=20
> 2.21.0
>=20

--pglfpajxaav525ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j9/kACgkQ2O7X88g7
+ppnbA/9HJLSlyVCAOVgH1vjxftYlXar5opquvDiYU3g7jIrQ0Ql3STydP7e5fKk
ZrYBeS2lVmvsvUQzdcv/7SMds0XdO5EbMV5IctPgcwQ7+CQ7ywIKgxMLhcUSxQVc
HhIKTOqCeuQxwKcMyginSjagatc5hlG9bOKA5UzScAjuAsvBMCSS+Q55Mr/mnXI5
QEPFLGoAW63p3ZeW1bZj1kLBSUkTUtVtJF5JuGHAOTjnbbnQkFDnW7/lTifQFQ04
S1IXiYj8eNSHjrUI/NQvg5wEsAzgp/Xuk166ipB/LM6SCsPSMdb79YYV47dy6UVi
nW4yflK5s16Db0e8YjWogLrkZHrgdZsrmwhkn9oTDRDnsnlmjcIKdVUPvlkbVaXO
LAAsfrlMpuC3zcz/MVbSqob4JgHoQG+mc29DtBfLddhQ8TbY6kTPna5NSMnimNja
/eT0/DQTnGtmGarh3vq1fLUZkkEhg2AkLA1U+7nv+PUAzM9vQkGHbtaEbRvzzW5h
FrAXkvEp1gaF5CPY6VdJkCBJvCDtFPpKvWKaty2WGA+fsstbPfm45xLh47TJLGT9
DTfsRPN7xpUplveKk+CabYJz0F/H/3W5ne8TYXQc5cZlEdj9Fqowxmw8cdqgVrhl
soSVCZoV6bmUEMJWUO0Q+t5IKRYhNGkUOD67pR/CsA7MSziB5iA=
=hHc+
-----END PGP SIGNATURE-----

--pglfpajxaav525ss--
