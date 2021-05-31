Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30292395AE7
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEaMvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 08:51:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F5C061574;
        Mon, 31 May 2021 05:50:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so10875793wrm.0;
        Mon, 31 May 2021 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9YDySThKVV8UwnHyQVkaDaNxnxUaN/PzESp5d7RpUy4=;
        b=doFYDKPrEtfJrvYp6ATC2RMU3jwujsQvl3FKjWH7wCgE2NrBSkw+kS1d1jq5Icx7jP
         MlL2oRtpl9vGw0Fu3iY1txVMhPRPupbnS7WP1v4lciJUa4eZRma68jCPBeB10O7P42P1
         9/CbL2do+qes34GNQaZZXjuPLBk9FEs3hrMq+QsR2XqOsObCH/fhSrVK9QHVnaPp1D5U
         UcLa5uikB8MwTWRbGDSce+IcaIXE/JG/Hqs2dtwJ/nFjMF66HXFHinTLfpBYkv2r5BiM
         1lC957Jsby0jJfWlHcLe19gaOgsM38KTcBIF1Id6SOlGKmwY/EliT+plI3TYN/cVNXuh
         zyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YDySThKVV8UwnHyQVkaDaNxnxUaN/PzESp5d7RpUy4=;
        b=JdBx6LY0c3lQsepE13ATSztM/U97FNxKdnmrPWK+BMaIBVeyNujUAmv1zULNu1Y8A8
         tRsJVvPAWH+ogPznCh82qoIueDlRoiCMhCru39r0kFRlkyKVdt7sFpG2oLWNuWzmldsN
         mqhv6+1Fjs32pxvwpOJFnWGJ/PYblERy4F85R0MsXzsW9T82Usnmgo1l9YR9vjQ2dSCJ
         pYhN811Q/0vRFUqqG+wMWuvcerEDQLfiu+SbWhRHsQUEtlSF10q7OVjMfBjXD2m3KkUL
         nnlCEI8IA+Ij0Kt6GgMGFJXlYySKzHzKeGGadF3nY/KFrMzn22hRqvjy2mYSZ9jnk5vt
         UCaA==
X-Gm-Message-State: AOAM531kesAWlHEQB7nvIhyBwNv2bbyllN0lHkui8r/NaApbyOLxsED7
        BWB1owjemlow1uSzW7mTWaA=
X-Google-Smtp-Source: ABdhPJzGCfHhTTs/45g7ekCkQRXgyGBaTh81GeyB8pBe4M4AeqoLBc+vc+tDTmiL2utiCf9r6xE6oQ==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr21972604wry.271.1622465411230;
        Mon, 31 May 2021 05:50:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u8sm21483881wmq.29.2021.05.31.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:50:09 -0700 (PDT)
Date:   Mon, 31 May 2021 14:51:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
Message-ID: <YLTb4LUK55Oj4yAt@orome.fritz.box>
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ckQWfJgw/VZRiwBs"
Content-Disposition: inline
In-Reply-To: <20210529170955.32574-5-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ckQWfJgw/VZRiwBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 29, 2021 at 08:09:52PM +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
> monitors temperature and voltage of the SoC. Sensors control CPU frequency
> throttling, which is activated by hardware once preprogrammed temperature
> level is breached, they also send signal to Power Management controller to
> perform emergency shutdown on a critical overheat of the SoC die. Add
> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
> and a cooling device.
>=20
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # Asus TF700T
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201T
> Tested-by: Ihor Didenko <tailormoon@rambler.ru> # Asus TF300T
> Tested-by: Ion Agorria <ion@agorria.com> # Asus TF201T
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/thermal/tegra/Kconfig           |   7 +
>  drivers/thermal/tegra/Makefile          |   1 +
>  drivers/thermal/tegra/tegra30-tsensor.c | 736 ++++++++++++++++++++++++
>  3 files changed, 744 insertions(+)
>  create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c

Acked-by: Thierry Reding <treding@nvidia.com>

--ckQWfJgw/VZRiwBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC0294ACgkQ3SOs138+
s6G9MQ//bnkil2zXowpCSG7HaLo9NcOXtx3wXjSmpy7WGER7nmLPCdLFAfBTaSxI
ROvELNMVHmHnyl8ZqDIj3o3rlVP3Le0tpE59eH+1lPSy0WKpjFAjX3g7ziw8mIWz
nxuQfSM6h5YJET5tK3Z3LWeg06OWLN62gF34Zi0nj2kcB6H0lgxxmmGB0ODmu+Vt
Tx+2fnt1q254lqfMV1Qph12iNt9vaq9k+/h/7c07b0KRM63zjY2vQjt4U+c/C9v6
up/oOsVGq7tD0NRNgTm5TtuaoUJ73aAbcMqUzYELh+QCcT2QxtnQukvT0IgAb1xV
CDXb3J5pfUaPqrwl+v74ybopypCajIcjHIT79HtyTWww+77/bC/l3fP9/2BYRDsj
qBeFUEc+BHHQaDA2bnVUkYh7IV5dv/1yV61y2uXXKf8/S/A4xxIgs4mHyZB0hoZY
xyHSzDEvW6f9CykmwwloiobRP+euRWyq7keTtrt4x+4kQaXm9PnkfQjDr4OMctWZ
/yfD8+XMxoUVM/SnPQFqRqT6gRtzfEcMzO0CPDDkwQqqh6HLPI/kvTfJ+PQNcbYD
1dw6pEogk+DtgbbaH8ud52J6q44cPTFFcz9RwjJJcD+URDYYqwVPmXHeW1FSOTMt
jLwVisXsErDH5fkcXe1mvmCHPDizAcWXOsaxLnmhFAaDQhJGABI=
=/bda
-----END PGP SIGNATURE-----

--ckQWfJgw/VZRiwBs--
