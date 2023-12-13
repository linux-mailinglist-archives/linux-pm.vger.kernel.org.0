Return-Path: <linux-pm+bounces-1059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17820811066
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C33281588
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5F24A12;
	Wed, 13 Dec 2023 11:44:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DDF2;
	Wed, 13 Dec 2023 03:43:07 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6da09f8ce35so937565a34.0;
        Wed, 13 Dec 2023 03:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467787; x=1703072587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFX8KgBna94AOXnbpss9Eb/Qd6gXo+veA8DhSkzU7QQ=;
        b=riNB9nlVUNHNJ+SKvIyoHMDEDFzUUyLSyrNhlGAF9GMMi8qW7crahGsXU4MG7hvseh
         I0ZdB5/c+R6Qpkx1GCU0wILYvzXa1L6iEtIvTqtwzg2Uy/NzS+abQ9hyCNDcSyykRmCP
         j16bOqGudcdD2g6J+jOI12bCiZNDtsizM5tyP2vDWTlbP/X3bUr+hkGjwknY7J66Ckh6
         QZf/9E0MN9E9gH059Vck5jkH5ZMhrnBzrU/mTwwwXrl3xc5zhOvjNDh9fi6gSaANziAE
         VPbqih33I5du2PmQoXGKbWbipWylgJuyaNPZ/P3s/s8Xr1yWWdsRZSOdDFrw+7Ro49cE
         l0DA==
X-Gm-Message-State: AOJu0YxQhbbu1HFIpzNwJkLXobMhxeBP/jNROG0CxZwi3qzifWqMyCOz
	eQDWLTn1WYMrHzBOADv7jgRmjCPjzg8JPVwj5sE=
X-Google-Smtp-Source: AGHT+IHKMZQ7YLe2NahSJVfb5JywbxiSIYhH8TulopNfB95zbQyA1nPekWCMIoKHNZHuWE/3pKmC/WmwaDErYU/sMhM=
X-Received: by 2002:a05:6870:9607:b0:1fb:23ec:3318 with SMTP id
 d7-20020a056870960700b001fb23ec3318mr14577032oaq.0.1702467786852; Wed, 13 Dec
 2023 03:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213113305.29098-1-ulf.hansson@linaro.org>
In-Reply-To: <20231213113305.29098-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 12:42:55 +0100
Message-ID: <CAJZ5v0hZPAUDhtzGX7GzdCe=jO63Zby65kgUMUFRShifUKEjZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domains: Move genpd and its governor to the
 pmdomain subsystem
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> It seems reasonable to collect the core parts for the generic PM domain,
> along with its corresponding provider drivers. Therefore let's move the
> files from drivers/base/power/ to drivers/pmdomain/ and while at it, let'=
s
> also rename the files accordingly.
>
> Moreover, let's also update MAINTAINERS to reflect the update.
>
> Cc: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for both patches in the series.

Thanks!

> ---
>  MAINTAINERS                                            | 10 +---------
>  drivers/base/power/Makefile                            |  1 -
>  drivers/pmdomain/Makefile                              |  1 +
>  drivers/{base/power/domain.c =3D> pmdomain/core.c}       |  0
>  .../power/domain_governor.c =3D> pmdomain/governor.c}    |  0
>  5 files changed, 2 insertions(+), 10 deletions(-)
>  rename drivers/{base/power/domain.c =3D> pmdomain/core.c} (100%)
>  rename drivers/{base/power/domain_governor.c =3D> pmdomain/governor.c} (=
100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af79..ab4b0aed34f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8878,21 +8878,13 @@ F:      Documentation/devicetree/bindings/i2c/i2c=
-demux-pinctrl.yaml
>  F:     drivers/i2c/muxes/i2c-demux-pinctrl.c
>
>  GENERIC PM DOMAINS
> -M:     "Rafael J. Wysocki" <rafael@kernel.org>
> -M:     Kevin Hilman <khilman@kernel.org>
>  M:     Ulf Hansson <ulf.hansson@linaro.org>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/power?domain*
> -F:     drivers/base/power/domain*.c
> -F:     include/linux/pm_domain.h
> -
> -GENERIC PM DOMAIN PROVIDERS
> -M:     Ulf Hansson <ulf.hansson@linaro.org>
> -L:     linux-pm@vger.kernel.org
> -S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.g=
it
>  F:     drivers/pmdomain/
> +F:     include/linux/pm_domain.h
>
>  GENERIC RADIX TREE
>  M:     Kent Overstreet <kent.overstreet@linux.dev>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 8fdd0073eeeb..01f11629d241 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,6 @@
>  obj-$(CONFIG_PM)       +=3D sysfs.o generic_ops.o common.o qos.o runtime=
.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP) +=3D main.o wakeup.o wakeup_stats.o
>  obj-$(CONFIG_PM_TRACE_RTC)     +=3D trace.o
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=3D  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK) +=3D clock_ops.o
>  obj-$(CONFIG_PM_QOS_KUNIT_TEST) +=3D qos-test.o
>
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index f0326b27b30b..a68ece2f4c68 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -16,3 +16,4 @@ obj-y                                 +=3D sunxi/
>  obj-y                                  +=3D tegra/
>  obj-y                                  +=3D ti/
>  obj-y                                  +=3D xilinx/
> +obj-y                                  +=3D core.o governor.o
> diff --git a/drivers/base/power/domain.c b/drivers/pmdomain/core.c
> similarity index 100%
> rename from drivers/base/power/domain.c
> rename to drivers/pmdomain/core.c
> diff --git a/drivers/base/power/domain_governor.c b/drivers/pmdomain/gove=
rnor.c
> similarity index 100%
> rename from drivers/base/power/domain_governor.c
> rename to drivers/pmdomain/governor.c
> --
> 2.34.1
>

