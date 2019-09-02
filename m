Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08086A5D26
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfIBUjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 16:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfIBUjB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 16:39:01 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2511121897;
        Mon,  2 Sep 2019 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567456740;
        bh=mCIlhOliA5oIMWPZ2XHqEIy4O8f+2xKB8vmwAyjxstQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3X/8L4+3pzmLygVmJGNDd+KWEl274G69dCBpvGB1uVovX2s4NKQTGE5WWZt/JI1+
         WPUmIeaL5XcwNmIudftUGjsxiAbjierPFn1fl2jOkZTXfyWj/mSgZBFMiXUxknp+ZK
         X8MzlJX14nl2elnVeKRnMW+PByNbRDrmf0Mjsm7A=
Received: by earth.universe (Postfix, from userid 1000)
        id B4C073C0CFA; Mon,  2 Sep 2019 22:38:57 +0200 (CEST)
Date:   Mon, 2 Sep 2019 22:38:57 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nandor Han <nandor.han@vaisala.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: make reboot-mode user selectable
Message-ID: <20190902203857.zusvlv3yv5arel6y@earth.universe>
References: <20190805075812.1056069-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksifvg4rkvnzzokt"
Content-Disposition: inline
In-Reply-To: <20190805075812.1056069-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ksifvg4rkvnzzokt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd and Nandor,

On Mon, Aug 05, 2019 at 09:57:15AM +0200, Arnd Bergmann wrote:
> Nandor Han points out that there might be drivers that can use
> the reboot-mode interfaces but might also be usable on configurations
> without device tree.
>=20
> Move the 'depends on OF' dependency into CONFIG_REBOOT_MODE since
> that is the only thing that truely has a compile-time dependency
> on CONFIG_OF, and make it user visible to make it possible to
> disable it.
>=20
> The drivers that used to 'select REBOOT_MODE' of course now have to
> use 'depends on REBOOT_MODE instead'. With this, we can soften the
> dependency and allow compile-testing the three front-end drivers
> on non-OF platforms.
>=20
> Note: anyone who was using a reboot mode driver in their kernel
> configuration now has to enable CONFIG_REBOOT_MODE as well.
>=20
> Suggested-by: Nandor Han <nandor.han@vaisala.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Nandor, this is so far untested, could you make sure this
> works in all configurations and forward it along with the
> bugfix?
>=20
> Sebastian, I'm not convinced this is a good idea, just sending
> it as Nandor requested. Please decide for yourself.
> ---

(Sorry for late reply)

This patch does not look good to me. Better patch would be to
allow compiling CONFIG_REBOOT_MODE without CONFIG_OF. Obviously
the configuration would not be useful for anything except compile
testing, but that is also true for this patch.

Making the small OF dependent section in reboot_mode_register()
would be a smaller patch with bigger test coverage, without
breakng existing configurations.

-- Sebastian

>  arch/arm/configs/davinci_all_defconfig |  1 +
>  arch/arm64/configs/defconfig           |  1 +
>  drivers/power/reset/Kconfig            | 22 +++++++++++++---------
>  include/linux/reboot-mode.h            | 20 ++++++++++++++++++++
>  4 files changed, 35 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/da=
vinci_all_defconfig
> index b34970ce6b31..ebf506c01899 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -139,6 +139,7 @@ CONFIG_GPIO_PCA953X_IRQ=3Dy
>  CONFIG_RESET_CONTROLLER=3Dy
>  CONFIG_POWER_RESET=3Dy
>  CONFIG_POWER_RESET_GPIO=3Dy
> +CONFIG_REBOOT_MODE=3Dm
>  CONFIG_SYSCON_REBOOT_MODE=3Dm
>  CONFIG_BATTERY_LEGO_EV3=3Dm
>  CONFIG_WATCHDOG=3Dy
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0e58ef02880c..bb7d7bec1413 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -419,6 +419,7 @@ CONFIG_ROCKCHIP_IODOMAIN=3Dy
>  CONFIG_POWER_RESET_MSM=3Dy
>  CONFIG_POWER_RESET_XGENE=3Dy
>  CONFIG_POWER_RESET_SYSCON=3Dy
> +CONFIG_REBOOT_MODE=3Dy
>  CONFIG_SYSCON_REBOOT_MODE=3Dy
>  CONFIG_BATTERY_SBS=3Dm
>  CONFIG_BATTERY_BQ27XXX=3Dy
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a564237278ff..997323d443f5 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -9,6 +9,13 @@ menuconfig POWER_RESET
> =20
>  if POWER_RESET
> =20
> +config REBOOT_MODE
> +	tristate "Pass reboot-mode to firmware"
> +	depends on OF
> +	help
> +	  Some drivers allow setting the reboot mode through a platform
> +	  interface that the boot firmware can read.
> +
>  config POWER_RESET_AS3722
>  	bool "ams AS3722 power-off driver"
>  	depends on MFD_AS3722
> @@ -107,9 +114,9 @@ config POWER_RESET_MSM
> =20
>  config POWER_RESET_QCOM_PON
>  	tristate "Qualcomm power-on driver"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on MFD_SPMI_PMIC
> -	select REBOOT_MODE
> +	depends on REBOOT_MODE || !REBOOT_MODE
>  	help
>  	  Power On support for Qualcomm boards.
>  	  If you have a Qualcomm platform and need support for
> @@ -223,14 +230,11 @@ config POWER_RESET_ZX
>  	help
>  	  Reboot support for ZTE SoCs.
> =20
> -config REBOOT_MODE
> -	tristate
> -
>  config SYSCON_REBOOT_MODE
>  	tristate "Generic SYSCON regmap reboot mode driver"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on MFD_SYSCON
> -	select REBOOT_MODE
> +	depends on REBOOT_MODE || !REBOOT_MODE
>  	help
>  	  Say y here will enable reboot mode driver. This will
>  	  get reboot mode arguments and store it in SYSCON mapped
> @@ -248,8 +252,8 @@ config POWER_RESET_SC27XX
> =20
>  config NVMEM_REBOOT_MODE
>  	tristate "Generic NVMEM reboot mode driver"
> -	depends on OF
> -	select REBOOT_MODE
> +	depends on OF || COMPILE_TEST
> +	depends on REBOOT_MODE || !REBOOT_MODE
>  	help
>  	  Say y here will enable reboot mode driver. This will
>  	  get reboot mode arguments and store it in a NVMEM cell,
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d6..bd002060e3d0 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -9,11 +9,31 @@ struct reboot_mode_driver {
>  	struct notifier_block reboot_notifier;
>  };
> =20
> +#if IS_ENABLED(CONFIG_REBOOT_MODE)
>  int reboot_mode_register(struct reboot_mode_driver *reboot);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>  			      struct reboot_mode_driver *reboot);
>  void devm_reboot_mode_unregister(struct device *dev,
>  				 struct reboot_mode_driver *reboot);
> +#else
> +static inline int reboot_mode_register(struct reboot_mode_driver *reboot)
> +{
> +	return 0;
> +}
> +static inline int reboot_mode_unregister(struct reboot_mode_driver *rebo=
ot)
> +{
> +	return 0;
> +}
> +static inline int devm_reboot_mode_register(struct device *dev,
> +			      struct reboot_mode_driver *reboot)
> +{
> +	return 0;
> +}
> +static inline void devm_reboot_mode_unregister(struct device *dev,
> +				 struct reboot_mode_driver *reboot)
> +{
> +}
> +#endif
> =20
>  #endif
> --=20
> 2.20.0
>=20

--ksifvg4rkvnzzokt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tfd4ACgkQ2O7X88g7
+prQDg/+PXtmhGWKdbFuPNBLtgFN/bevjswq58gIKNKmmot/hlhDt9wKgXi2ksmQ
UUhlIUumLp3n4+w8XfFUEeqa/+qqFI5ji1Fr6e77/R2Y601S95GqXm/BouyuRDdd
SXf3Wo6LGSwiA5dyxZjbsGZLW3iOjhaP5mAnPM5ICYMS3rhO9YezSKxQLhTPslrx
Dg8sZdhHv3dkaG8Dg7prHRk8fvJF2S1EBHuliPgRHLL+Nss/G9VhaSGi4rFZXk8N
F5e6fSBQ3Q6QWRibxEM1iaugC9nE4AzmFCXEMFAMXAsptPGFDsF0AyLG6dA9AMPH
7yunemEtBYzWsffyXVZ+4quCwUS1vGK281tqu6QIvm71tnaHQPayQvY71rUJ/gEN
CCagWGqs8m6AKwfuSKJZCIh/+ViR1PnhUjjYlCitDq31t2E/zpypxz9TqqkCccoG
3jNt/VyA3lbCnBY192SpCZqAIIclwU4T8R6UUAzWRp149uaxyNM0hEWFAov914fa
j5AyER65q8tyYT7OScXpeVAu+p1d66OOFlV5ippIy/iHM1d4I01YbbdHAA35Ho9r
Kk/CTFn3ZDebBTQza00yVzDCNSetl064/ecMEuWgkwEQ3fi+GS7ldml21qUl+07q
pthlGMdweqYL1N/QcC44Bb8/m7rmTyYx2IkPi8TcnqOQUlNdnVA=
=Ovrq
-----END PGP SIGNATURE-----

--ksifvg4rkvnzzokt--
