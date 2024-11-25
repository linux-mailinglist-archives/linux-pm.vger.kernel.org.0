Return-Path: <linux-pm+bounces-18070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD09D8824
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953B9B3E6F2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E11B0F02;
	Mon, 25 Nov 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMYr8Gm7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710D1B6CE3;
	Mon, 25 Nov 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543840; cv=none; b=oS9N0CA4dmeFO/LtpyEX1eno4PHgd6pbEa64dxHEFxEJUEryPSiNjGhZklqrFb5X3iEqM1DxvSM18F4V7bomrinjC1sl9CLM+s0U9xXtbDZT6CC0r9BO9IPT1BlM6XkggffDelDm/BsRmHYQpaHzpbeBNPRasq9jD96KSWVsbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543840; c=relaxed/simple;
	bh=bN1vT3x9zxVArM4Cza5XYilQfVfL33GOYfQuhlEcVew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLpDHNdl012NhOePqbH/494WpsdqeNaD3SscO7j75nB+u9LQ7Qlq2x2hlq2uphzYdPeCJD/26u0pnOulyhj6PPBlmwEcquhPtFFAYAf/nzU86UMIbzcjO9eWSCNxEk4Yj4lZ4ZZ8XrcyflfluXMO9q0EdBHnYsbCAHWhkRvMFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMYr8Gm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0B9C4CED2;
	Mon, 25 Nov 2024 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543840;
	bh=bN1vT3x9zxVArM4Cza5XYilQfVfL33GOYfQuhlEcVew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GMYr8Gm7B9kDO+eOxSikz3D5J20Uhu/k2A9UhyNW1v8ZONh9yavxdaiIopo0GDOxR
	 /WUXcilx+26gQLjuITWoYHYnFE1bKsWcjojnWsrmpZyjKuLu+uR8FT3V1Ycp3jgvRI
	 aydkz1Mb2lSR+nvi28f5RQWp9TliuXo0xysFss8SPgLwSYxb/oO21nO2UcTLj06v8M
	 cWkQx7kDAhDwpcylLNsy2ld4ftKk1hqkkD3ztRbuhG9NLEGYIfkVlhtQYOORiiAHKk
	 UJeSjN4yYq0G5G54wyQu1cPAqRXfRdWvkXTp7gDm90ueS67eavXGUl67piIRrhq/wz
	 fWvTRu0o4ICZA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2969ae2c99fso2393244fac.3;
        Mon, 25 Nov 2024 06:10:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbgnVKoEb4ZF1MhYUh2n8oTYVgqviJghQhUaeU4jEXthh1VYZhI5z4gSNzMXZf4HJf+8hiyEeu9wM=@vger.kernel.org, AJvYcCXjKole97uNIeAIu5vST8yWjl5CjoUkgg2hHCZc+QxdHrBB5i4/CoL//rhaowIRFWLZmtCMvJ5PAsa1OZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvwMJAV2T8+/vZ4T1BTwI74cHQbBUGM0vOSHppTLzZ7/3caf2
	CUv0EprJdc80DjHHKyfyEE32Lmq4SWpIrITQjCnRP84KrdEYigrOeDb5AM/z0WM+x1nMtTuLhA+
	WDLFOQ10dsP+S3s3pP46onfJt918=
X-Google-Smtp-Source: AGHT+IGZtSQ5evNeuuOQ8u1WsE6nENodwSlmRKxRYWUWaSKo3BgOcZV2CgPdHpcgjy/R8PlvkAYZFfX0OjT2urK2nPw=
X-Received: by 2002:a05:6871:68a:b0:297:285e:f824 with SMTP id
 586e51a60fabf-297285efa25mr10268908fac.10.1732543839773; Mon, 25 Nov 2024
 06:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-sysfs-const-bin_attr-int340x_thermal-v1-1-2436facf9dae@weissschuh.net>
In-Reply-To: <20241121-sysfs-const-bin_attr-int340x_thermal-v1-1-2436facf9dae@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:10:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jEEAidAEn4C6eb0ShG06+UQRaYhsFCF9uOiMuO-Gn3Jg@mail.gmail.com>
Message-ID: <CAJZ5v0jEEAidAEn4C6eb0ShG06+UQRaYhsFCF9uOiMuO-Gn3Jg@mail.gmail.com>
Subject: Re: [PATCH] thermal: int3400: Remove unneeded data_vault attribute_group
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 5:29=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The group only contains a single entry and the conditionals around its
> lifecycle make clear that this won't change.
> Remove the unnecessary group.
>
> This saves some memory and it's easier to read.
> The removal of a non-const bin_attribute[] instance is also a
> preparation for the constification of struct bin_attributes.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 16 +++--------=
-----
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index b0c0f0ffdcb046607b4478390f39a77ae316a511..558a08f1727fc48c37181f8d3=
45e236f879dab27 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -75,11 +75,6 @@ struct odvp_attr {
>
>  static BIN_ATTR_SIMPLE_RO(data_vault);
>
> -static struct bin_attribute *data_attributes[] =3D {
> -       &bin_attr_data_vault,
> -       NULL,
> -};
> -
>  static ssize_t imok_store(struct device *dev, struct device_attribute *a=
ttr,
>                           const char *buf, size_t count)
>  {
> @@ -108,10 +103,6 @@ static const struct attribute_group imok_attribute_g=
roup =3D {
>         .attrs =3D imok_attr,
>  };
>
> -static const struct attribute_group data_attribute_group =3D {
> -       .bin_attrs =3D data_attributes,
> -};
> -
>  static ssize_t available_uuids_show(struct device *dev,
>                                     struct device_attribute *attr,
>                                     char *buf)
> @@ -624,8 +615,7 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
>         }
>
>         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> -               result =3D sysfs_create_group(&pdev->dev.kobj,
> -                                           &data_attribute_group);
> +               result =3D device_create_bin_file(&pdev->dev, &bin_attr_d=
ata_vault);
>                 if (result)
>                         goto free_uuid;
>         }
> @@ -648,7 +638,7 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
>  free_sysfs:
>         cleanup_odvp(priv);
>         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> -               sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group=
);
> +               device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
>                 kfree(priv->data_vault);
>         }
>  free_uuid:
> @@ -683,7 +673,7 @@ static void int3400_thermal_remove(struct platform_de=
vice *pdev)
>                 acpi_thermal_rel_misc_device_remove(priv->adev->handle);
>
>         if (!ZERO_OR_NULL_PTR(priv->data_vault))
> -               sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group=
);
> +               device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
>         sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
>         sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
>         thermal_zone_device_unregister(priv->thermal);
>
> ---

Applied as 6.13-rc material, thanks!

