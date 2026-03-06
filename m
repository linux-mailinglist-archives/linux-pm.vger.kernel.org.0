Return-Path: <linux-pm+bounces-43847-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPXRJvbxqmncYwEAu9opvQ
	(envelope-from <linux-pm+bounces-43847-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:25:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10C8223BF1
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EF343069026
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D1364924;
	Fri,  6 Mar 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJQglw1/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CA35BDBB
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810445; cv=pass; b=OgnK844Dnn6tW5yxUHSceqXxXmpgEav6W8TNNuEd5ycWgNoOJ7yMH2W++t30cWrf5bDe6vuR6eV5GCwDPG3JsEc9rsPbqv46ueXrkocMJQQ2oQfZiV+ushoe2J0Cnx8QvgEfTV3zpbOjnJnDr/ebs+fS63Iz7A79NU/sENkUBJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810445; c=relaxed/simple;
	bh=KOsZndq2fxFvV5ZjjA90mg2yR7mJTcoSEakFrOShe1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAbNbBl6gjUeY3mcs+2azCOLa8mGLLM5FEXZDESBdopXRBH1zjZnjlf769FQGshqBsZDsw5EAiNijgA9/SNwqc+dCh3Avk77Euzf1Ra6907qd7RvcTIO0PGX1wmpRuZZELYiv6iYke0XXN1MtjQ7HviaDMn7m3bmDpwH2I4qwHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJQglw1/; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-660d77cacc2so1084010a12.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772810442; cv=none;
        d=google.com; s=arc-20240605;
        b=JKzO3S3tDtbQ1p07U3q/MWqiky901hHnZNXk8GeJOEoQXT0hOi5hn91xVyS+zPdDZN
         5ARV9Bx+E4m+SmY0ovK+OHZyJvi9wLHv4y2JAcYBdh4tN7A+yVOg7TEogSaIXlTB2ZDA
         5RkO5amVju5XFNnyLvMmmLVwmK7KTPVqQVNwQBcYaR35ohaEYDz9rpF+SwGzHvcpMhFs
         LJbBzoRjIbGYW7hG/cDI8+H7T8TirJXLpY4LXthEl0p5yKb0UFJ8mmFqSPdVYVbQpcAF
         dSoMRsP7Acsf7SRJ73HNSLh45UMkMkY1EriIlZRPgVITJ388hB9NHGG9ozgUGVyXrcnE
         uT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPFMUflif2PcoprUWa7OFxGTQSn7UEMXyNiXbjIMxgc=;
        fh=YkUt7KIW1sJ66vDu4L8weValjSIQ+NgKn0lGrExrSTM=;
        b=h+2lrEZD/151GVmoYjLc2m4ChhwKG44qcX6Unyt0nGdtMtx7mvsAph7fYT7+hyNE7p
         hrG/jWJFS4AzOogMZi6frES5mxhWQ1PDUrwihtP1/0CbYOcyklYOugKlGwPNE+u16gw7
         C0Y+e/eaqs2sDHyVvgDUWVvd0r9BWPUfFfHTRprYq7swAZgKBLDWrqSnKADZtlCs57Vt
         Cm1Eqzt7Cd40+cmePilsMgmUaBMZFBMfeyS0Z4qLLq+nFE5VyzhOsy7CLImomjkeSYjJ
         CrYmRWJ6u1xsv2NAIx3zZskUMSw+qY8+k1g+cXgzLYb3qYvc3Uqkr22VAN7qtF601Nsv
         k++w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772810442; x=1773415242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPFMUflif2PcoprUWa7OFxGTQSn7UEMXyNiXbjIMxgc=;
        b=qJQglw1/2i7Vrc/qxZO66X7wS1a+J79HX8FaACL138laP5SjsSG7lOtf9KOeXCH9+9
         NEAfmb3sGqhV2AUDJ1dhlIvwt0xXoEoLrvcAWR9VyXeFXQz8WTk/WRztXF5ZGQPf1yEn
         VSqQokMB0SrfvMs+K17dDWKZnQU/x2UvljL4oHWx6QtB9PAAhMycSJt2fBaKw1l4V5WC
         pMty4HWPLxUFOIpzETbAIumJujnIHPu6xFIU7DU0ok+FNFJrunfGQ515/H7frh+1Iytj
         WplKJgEthW2Q/dhpHmmvHP6cZJ5lYEn9WEpIrfDzhqjJ1jJBg5LI2k4WWmRJyWDsWNBD
         tPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810442; x=1773415242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPFMUflif2PcoprUWa7OFxGTQSn7UEMXyNiXbjIMxgc=;
        b=TwNReTX56nNqLMBz82yF83iMlcDGjnq7BDO1THAxZmrOct8Hn3Oq8WhY18ViqShwS/
         7kXTkSIYw2x+WMNlzpovmgrxBlOoI1hEWaFwvd6+2HOrAfNd7FIAn1VGlnSB48K439Fz
         8RrBKWoz+6UDxqx17te4AZzSE4fHCsU0y4in+Ab66qk/e30+YhhpxFyIH8DJdMpOp8S4
         zJ7jddhgFySFRR/DzhTklcwCE7gUJGJRIFNPMOqg1Cp7lFd1ZdCvb7Q+Q0QIm7h5yNzk
         oijAeYVXUk6eq9Xi0fQDV2ekaCyR904+s/m8HNAplDK/BaXnyWnAg7yNk6OZ00F8a+N9
         Y51A==
X-Forwarded-Encrypted: i=1; AJvYcCX4UcCleL3s9e2TF7UQMYs/GsRgSDyYHDsDnr+WW9BjruwY2q43VB/a5ilxAPH9P9cFbzpl65BXVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxiNh6qBRKWZq8UXIGfcgOavY7yVqcEc4Y+EE+6bWqFE7BiBr
	2lmG6V7b/KKckJkjG4jvGKDoa83m1VOJywaT8g1yG5zon6Iy9Ascre5FulptLcl1HuJJfGhff/V
	sMJZMkAFiNi1Wyvygl6YCmwi8lPCZTmlInpHAjwnUCw==
X-Gm-Gg: ATEYQzwCjfEttRrXK4YZSHV6M0sHUNEGAw5+d4dxWiHHw80Kvq+QLV4i7rWPjB1bPc+
	hv2ZsnqK0Gd3Bw4FfIqxiFfiCfdFr3gDM1PNmoKuTQclUAF9ZxWCvagmNdFSRjRg4Hc4u7AG5in
	lvw0fpj8e8G2cDabf0yMoEJo+1Ea9XmVKzEoKuBSNN5UpXxnRw1zD+b9LfttrKh5I/bluEulezu
	TCUr9qaMApdWUqwRmRrW6uWyfCRcF02P9hybxiNSKZ5I7nrl0ujPXjCTQrXhPumZ64exlMn9iPG
	Ku2SJ06KB+SkX56uYs9kxJb8xCpH1ojcX+P0SpgDjw==
X-Received: by 2002:a05:6402:719:b0:65f:76d7:d507 with SMTP id
 4fb4d7f45d1cf-66142d406c4mr2730888a12.8.1772810441112; Fri, 06 Mar 2026
 07:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-7-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-7-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:20:29 +0000
X-Gm-Features: AaiRm52gkTQ-LvYEyU8OUxVKlY-XzL8CHFqDj2nv7Gqx-ZbbUqON9JYJP7oOtB8
Message-ID: <CADrjBPrAK6-76u1vPUkc5BLTugHCa+Fk=Rvr9uOQDie7Avfd7w@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] pmdomain: samsung: add support for google,gs101-pd
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F10C8223BF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43847-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,samsung.com:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Google gs101, direct mmio register access to the PMU registers
> doesn't work and access must happen via a regmap created by the PMU
> driver instead.
>
> Add a flag to the device match data to denote this case, and obtain
> the regmap using the parent node in DT if true, while keeping to use
> the traditional direct mmio regmap otherwise.
>
> Additionally, the status is just one bit on gs101.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v4:
> - add 'use_parent_regmap' flag instead of going by 'syscon' compatible
>   in parent, as it's not a given that the parent provides a syscon-
>   compatible regmap (it actually doesn't anymore after recent changes
>   on gs101)
>
> I've still kept Marek's Tested-by from v3, as legacy Exynos code
> doesn't change.
> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 66 +++++++++++++++++++---=
------
>  1 file changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 8df46b41f9bc..2214d9f32d59 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/pm_domain.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> @@ -21,6 +22,7 @@
>  struct exynos_pm_domain_config {
>         /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
>         u32 local_pwr_cfg;
> +       bool use_parent_regmap;
>  };
>
>  /*
> @@ -93,8 +95,16 @@ static const struct exynos_pm_domain_config exynos5433=
_cfg =3D {
>         .local_pwr_cfg          =3D 0xf,
>  };
>
> +static const struct exynos_pm_domain_config gs101_cfg =3D {
> +       .local_pwr_cfg          =3D BIT(0),
> +       .use_parent_regmap      =3D true,
> +};
> +
>  static const struct of_device_id exynos_pm_domain_of_match[] =3D {
>         {
> +               .compatible =3D "google,gs101-pd",
> +               .data =3D &gs101_cfg,
> +       }, {
>                 .compatible =3D "samsung,exynos4210-pd",
>                 .data =3D &exynos4210_cfg,
>         }, {
> @@ -122,17 +132,9 @@ static int exynos_pd_probe(struct platform_device *p=
dev)
>         struct of_phandle_args child, parent;
>         struct exynos_pm_domain *pd;
>         struct resource *res;
> -       void __iomem *base;
>         unsigned int val;
>         int on, ret;
>
> -       struct regmap_config reg_config =3D {
> -               .reg_bits =3D 32,
> -               .val_bits =3D 32,
> -               .reg_stride =3D 4,
> -               .use_relaxed_mmio =3D true,
> -       };
> -
>         pm_domain_cfg =3D of_device_get_match_data(dev);
>         pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>         if (!pd)
> @@ -143,25 +145,49 @@ static int exynos_pd_probe(struct platform_device *=
pdev)
>                 return -ENOMEM;
>
>         /*
> -        * The resource typically points into the address space of the PM=
U.
> +        * The resource typically points into the address space of the PM=
U and
> +        * we have to consider two cases:
> +        *   1) some implementations require a custom regmap (from PMU pa=
rent)
> +        *   2) this driver might map the same addresses as the PMU drive=
r
>          * Therefore, avoid using devm_platform_get_and_ioremap_resource(=
) and
> -        * instead use platform_get_resource() and devm_ioremap() to avoi=
d
> +        * instead use platform_get_resource() here, and below for case 1=
) use
> +        * syscon_node_to_regmap() while for case 2) use devm_ioremap() t=
o avoid
>          * conflicts due to address space overlap.
>          */
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res)
>                 return dev_err_probe(dev, -ENXIO, "missing IO resources")=
;
>
> -       base =3D devm_ioremap(dev, res->start, resource_size(res));
> -       if (!base)
> -               return dev_err_probe(dev, -ENOMEM,
> -                                    "failed to ioremap PMU registers");
> -
> -       reg_config.max_register =3D resource_size(res) - reg_config.reg_s=
tride;
> -       pd->regmap =3D devm_regmap_init_mmio(dev, base, &reg_config);
> -       if (IS_ERR(pd->regmap))
> -               return dev_err_probe(dev, PTR_ERR(base),
> -                                    "failed to init regmap");
> +       if (pm_domain_cfg->use_parent_regmap) {
> +               pd->regmap =3D syscon_node_to_regmap(dev->parent->of_node=
);
> +               if (IS_ERR(pd->regmap))
> +                       return dev_err_probe(dev, PTR_ERR(pd->regmap),
> +                                            "failed to acquire PMU regma=
p");
> +
> +               pd->configuration_reg =3D res->start;
> +               pd->status_reg =3D res->start;
> +       } else {
> +               void __iomem *base;
> +
> +               const struct regmap_config reg_config =3D {
> +                       .reg_bits =3D 32,
> +                       .val_bits =3D 32,
> +                       .reg_stride =3D 4,
> +                       .use_relaxed_mmio =3D true,
> +                       .max_register =3D (resource_size(res)
> +                                        - reg_config.reg_stride),
> +               };
> +
> +               base =3D devm_ioremap(dev, res->start, resource_size(res)=
);
> +               if (!base)
> +                       return dev_err_probe(dev, -ENOMEM,
> +                                            "failed to ioremap PMU regis=
ters");
> +
> +               pd->regmap =3D devm_regmap_init_mmio(dev, base, &reg_conf=
ig);
> +               if (IS_ERR(pd->regmap))
> +                       return dev_err_probe(dev, PTR_ERR(base),
> +                                            "failed to init regmap");
> +       }
>
>         pd->pd.power_off =3D exynos_pd_power_off;
>         pd->pd.power_on =3D exynos_pd_power_on;
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

