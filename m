Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4086C332E9F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCIS6Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhCIS6J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 13:58:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF9E6522D;
        Tue,  9 Mar 2021 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316289;
        bh=YzBB5bEhRSo54FO1BVgaQmgjAQ9wDLBR0C4pJBCU6RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUbmw5dqoCbknXqr2XY66z3g1T0Dpyx+JMwh/6KR4BpKRLL14gruhkSv/I42xiPDk
         dzD7at5ygSXcSv7sCxvcEbfa8v83/KOh0uwWuR5Cy3PobkB5KW0LW2VNRuNJLbYuaz
         gtIux0Ilj7wHSC3QxfiXNd7veQ0FNo7hGn2iZyIm2C/hM6vDwFolpLUPAuEXxRGgzb
         9j/4GGB9GyHOoKvNpE/MbRm+3JPp+K3wmChgIxfqLkNdm9GY7I481v+RZPB04mh4k9
         TgvNjRc5CEzx7MIpo6hSHSumSu+0zVdGnd1I+R5V+K/xIVJCTROcPQtalUARek7Xyo
         wITpF9QQ8pGEA==
Received: by earth.universe (Postfix, from userid 1000)
        id 33D0B3C0C95; Tue,  9 Mar 2021 19:58:07 +0100 (CET)
Date:   Tue, 9 Mar 2021 19:58:07 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ray Chi <raychi@google.com>, gregkh@linuxfoundation.org
Cc:     naresh.kamboju@linaro.org, kyletso@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not
 enabled
Message-ID: <20210309185807.ka4iljasq5cmpmil@earth.universe>
References: <20210308133146.3168995-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfopcmcru3tynrsq"
Content-Disposition: inline
In-Reply-To: <20210308133146.3168995-1-raychi@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kfopcmcru3tynrsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 08, 2021 at 09:31:46PM +0800, Ray Chi wrote:
> Fix build error when CONFIG_POWER_SUPPLY is not enabled.
>=20
> The build error occurs in mips (cavium_octeon_defconfig).
>=20
> mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_remove':
> drivers/usb/dwc3/core.c:1657: undefined reference to `power_supply_put'
> mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_propert=
ies':
> drivers/usb/dwc3/core.c:1270: undefined reference to `power_supply_get_by=
_name'
> mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_probe':
> drivers/usb/dwc3/core.c:1632: undefined reference to `power_supply_put'
>=20
> Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Ray Chi <raychi@google.com>
> ---

While I'm fine with merging this after fixing up the subject, the
original patch for dwc3 [0] looks completly incorrect to me.

First of all it uses wrong scale (power-supply uses uA, not mA),
so you are charging 1000x slower than expected. Then the patchset
introduces a new DT property to get the power-supply device, but
does not update the DT binding documentation and does not Cc the
DT binding maintainer. Next the property itself looks not very
smart to me. Usually one would use a device reference, not the
Linux device name.

Finally all existing devices solve this by registering a usb
notifier from the charger, so why are you going the other way
around? This is going to break once you want to use one of the
existing chargers with dwc3.

I suggest to drop/revert the whole patchset.

[0] https://lore.kernel.org/linux-usb/20210222115149.3606776-1-raychi@googl=
e.com/

-- Sebastian

>  include/linux/power_supply.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 81a55e974feb..6e776be5bfa0 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -381,8 +381,14 @@ struct power_supply_battery_info {
>  extern struct atomic_notifier_head power_supply_notifier;
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);
> +#if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern struct power_supply *power_supply_get_by_name(const char *name);
>  extern void power_supply_put(struct power_supply *psy);
> +#else
> +static inline void power_supply_put(struct power_supply *psy) {}
> +static inline struct power_supply *power_supply_get_by_name(const char *=
name)
> +{ return NULL; }
> +#endif
>  #ifdef CONFIG_OF
>  extern struct power_supply *power_supply_get_by_phandle(struct device_no=
de *np,
>  							const char *property);
> --=20
> 2.30.1.766.gb4fecdf3b7-goog
>=20

--kfopcmcru3tynrsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBHxTYACgkQ2O7X88g7
+pqlmRAAnXOIZfMaJuPiHMiZAIJwikHY9XrWdvTNgznGGGQaaKqKI4BO6mbv8ZKn
ULnBghQacHe9CIJSyT68KkS4E6DKfPrt+D37tzWmdhN36uJZpdFBTbS2ysOBo1S0
tToMSYEf6arwt4ZMvWMTaa0em4jDQWfM3rTvt6/oURsKf1ei3bczmNHTfpmnY8Az
Z0TEXKID3jkBqGtwM7kNCiif499j+7UZ1iOlFpE9sfodJZ7LnC1atcn0DF2anm5L
7fbG4U6K+YiZfZPKkOkNfj/oLXHuw0Dw6napokKluUyEPsuw8B9Q895SZELzlm1H
u/sQpPWMG6U1lsSvnMlnLZhpPo6vq9Yh2esyZAr0byn817xqd1UCqhOPRlC4EZOA
GdhTwEhjytOv7Bp7d0fjqC6CzsYCPL+6bxWBaVkuFY2TPMD1VAAP5YDaBkaWE3AL
o2Dd/liTanSsn+x5WTx3OuOrfiz1VFLZvL08UUfp1ZvPzgCyrYboIhZ2k027PHV9
j32u1exlVhp8G3Zlt2b+aYBYq/VOa8j8wOWofZEUa+rvyp+KhQ3TkKOQwMDTuHBJ
PuewAEsO330l3PNac0ElQEg6FU/WuG8Vsq/ikv1W4HJCIwbIm8Je3/UkNCTNpGV4
mT/UqqMr3//VAGQV5nTQ44O6ZuTN6v3UhhMTIlKk/Qzf2i/kB7Q=
=E+h3
-----END PGP SIGNATURE-----

--kfopcmcru3tynrsq--
