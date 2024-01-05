Return-Path: <linux-pm+bounces-1906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D0825C4A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 22:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B65E288279
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4B021A11;
	Fri,  5 Jan 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPe6m5h9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FB22EEA
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bbbe7b1b36so96840939f.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jan 2024 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704491974; x=1705096774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6rZpkw2Ym1c5fqwTeBK9U1azUZTx22ltTG//VlM2Jw=;
        b=SPe6m5h9diFo4AV4vOQzJ/6Sf8aQP2Dwwh5FgZoYeU1sp8shz55gJD+DNssMNSltyS
         VXqb9o1b331HS6+Q4MemQUMn30vDZShsre6jDV5yQnX0CKR4i+sJRENVc9xw+2o6zTnT
         CQG/wLu8/FHohO0W5KHJwadrtI8ugkUWnATi8gzAN2OslnaISZQ0NNali9I2iLVlPU61
         sa+6tse0ajyPouQf0/LAqZX9nPDHd7xU+lmRO6R1K3+dtQ/dxI8Dqx95y7jPU9qsUr2q
         TLqcVeReODO8hKcXq5X/8My4EZTEojxlyk4sFB3/PRazkRg9B4jUFL4c8l1aCRAPaK2v
         EY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491974; x=1705096774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6rZpkw2Ym1c5fqwTeBK9U1azUZTx22ltTG//VlM2Jw=;
        b=wnskKwiIn/hnSQokwJHIponNh3p2fK40U8YmmEvxemsy8K8rx57m9X5HfnwySp9NW8
         ArP1DTuUeTFwIBlioWRHjal7WsbtAeOKXFdmmpqUu7dSzAUhU4yyqDfKEoV05jqJZpS6
         a3J3d/Ys81yLXnOdhFQ7InhtIXYZTr/RPYiHPMdU1lIHSIAgn6rYWZZmBAZeddXWoHA4
         vwHB49V9mR5SNd2sweC/dvo+kdOZ6JXhICGdb/4jSm0iOvqHGpvQh31xWI7TEjksNUMm
         Zcw31PJFfIi/XNTvuqeVYAyJzr6xUHauqN7UI6HyRJ0imnlifA5WyTvLghAlghYlxOHs
         kKsw==
X-Gm-Message-State: AOJu0Yx8kASl9VLhr5GPc3a6rT5qPQ+xNRHfYJ2KoVZhE0nT3wW0Skir
	BCja8Jx/ftaOFIHrx998+S0snUmB2QGK
X-Google-Smtp-Source: AGHT+IHuLYZFNRa1aPYhtyIaQJQtiGusNCzi0ck4yHX30YnY6uYgkV+3YFPS7Fsp1/oiBLxrFgPjtA==
X-Received: by 2002:a5e:8e41:0:b0:7ba:a10f:fa41 with SMTP id r1-20020a5e8e41000000b007baa10ffa41mr162756ioo.18.1704491974248;
        Fri, 05 Jan 2024 13:59:34 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id i43-20020a056638402b00b0046b83875cd5sm629253jai.168.2024.01.05.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:59:33 -0800 (PST)
Date: Fri, 5 Jan 2024 21:59:30 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: sre@kernel.org, chenhuiz@axis.com, linux-pm@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] power: supply: bq24190_charger: Fix "initializer element
 is not constant" error
Message-ID: <20240105215930.usi2yicruah5kecl@google.com>
References: <20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org>

On Wed, Jan 03, 2024 at 09:57:07AM -0700, Nathan Chancellor wrote:
> When building with a version of GCC prior to 8.x, there is an error
> around non-constant initializer elements:
>
>   drivers/power/supply/bq24190_charger.c:1978:16: error: initializer element is not constant
>      .vbus_desc = bq24190_vbus_desc,
>                   ^~~~~~~~~~~~~~~~~
>   drivers/power/supply/bq24190_charger.c:1978:16: note: (near initialization for 'bq24190_chip_info_tbl[0].vbus_desc')
>   drivers/power/supply/bq24190_charger.c:1989:16: error: initializer element is not constant
>      .vbus_desc = bq24190_vbus_desc,
>                   ^~~~~~~~~~~~~~~~~
>   drivers/power/supply/bq24190_charger.c:1989:16: note: (near initialization for 'bq24190_chip_info_tbl[1].vbus_desc')
>   drivers/power/supply/bq24190_charger.c:2000:16: error: initializer element is not constant
>      .vbus_desc = bq24190_vbus_desc,
>                   ^~~~~~~~~~~~~~~~~
>   drivers/power/supply/bq24190_charger.c:2000:16: note: (near initialization for 'bq24190_chip_info_tbl[2].vbus_desc')
>   drivers/power/supply/bq24190_charger.c:2011:16: error: initializer element is not constant
>      .vbus_desc = bq24190_vbus_desc,
>                   ^~~~~~~~~~~~~~~~~
>   drivers/power/supply/bq24190_charger.c:2011:16: note: (near initialization for 'bq24190_chip_info_tbl[3].vbus_desc')
>   drivers/power/supply/bq24190_charger.c:2022:16: error: initializer element is not constant
>      .vbus_desc = bq24296_vbus_desc,
>                   ^~~~~~~~~~~~~~~~~
>   drivers/power/supply/bq24190_charger.c:2022:16: note: (near initialization for 'bq24190_chip_info_tbl[4].vbus_desc')
>
> Clang versions prior to 17.x show a similar error:
>
>   drivers/power/supply/bq24190_charger.c:1978:16: error: initializer element is not a compile-time constant
>                   .vbus_desc = bq24190_vbus_desc,
>                                ^~~~~~~~~~~~~~~~~
>   1 error generated.
>
> Newer compilers have decided to accept these structures as compile time
> constants as an extension. To resolve this issue for all supported
> compilers, change the vbus_desc member in 'struct bq24190_chip_info' to
> a pointer, as it is only ever passed by reference anyways, and adjust
> the assignments accordingly.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1973
> Fixes: b150a703b56f ("power: supply: bq24190_charger: Add support for BQ24296")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
Since vbus_desc is only ever used as a reference this change to a
pointer is valid and shouldn't require any further changes other than
the ones present in this patch.

Reviewed-by: Justin Stitt <justinstitt@google.com>
>  drivers/power/supply/bq24190_charger.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index a8995a21fadb..2b393eb5c282 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -246,7 +246,7 @@ struct bq24190_dev_info {
>  struct bq24190_chip_info {
>  	int ichg_array_size;
>  #ifdef CONFIG_REGULATOR
> -	const struct regulator_desc vbus_desc;
> +	const struct regulator_desc *vbus_desc;
>  #endif
>  	int (*check_chip)(struct bq24190_dev_info *bdi);
>  	int (*set_chg_config)(struct bq24190_dev_info *bdi, const u8 chg_config);
> @@ -728,7 +728,7 @@ static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
>  	else
>  		cfg.init_data = &bq24190_vbus_init_data;
>  	cfg.driver_data = bdi;
> -	reg = devm_regulator_register(bdi->dev, &bdi->info->vbus_desc, &cfg);
> +	reg = devm_regulator_register(bdi->dev, bdi->info->vbus_desc, &cfg);
>  	if (IS_ERR(reg)) {
>  		ret = PTR_ERR(reg);
>  		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
> @@ -1975,7 +1975,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
>  	[BQ24190] = {
>  		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
>  #ifdef CONFIG_REGULATOR
> -		.vbus_desc = bq24190_vbus_desc,
> +		.vbus_desc = &bq24190_vbus_desc,
>  #endif
>  		.check_chip = bq24190_check_chip,
>  		.set_chg_config = bq24190_battery_set_chg_config,
> @@ -1986,7 +1986,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
>  	[BQ24192] = {
>  		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
>  #ifdef CONFIG_REGULATOR
> -		.vbus_desc = bq24190_vbus_desc,
> +		.vbus_desc = &bq24190_vbus_desc,
>  #endif
>  		.check_chip = bq24190_check_chip,
>  		.set_chg_config = bq24190_battery_set_chg_config,
> @@ -1997,7 +1997,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
>  	[BQ24192i] = {
>  		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
>  #ifdef CONFIG_REGULATOR
> -		.vbus_desc = bq24190_vbus_desc,
> +		.vbus_desc = &bq24190_vbus_desc,
>  #endif
>  		.check_chip = bq24190_check_chip,
>  		.set_chg_config = bq24190_battery_set_chg_config,
> @@ -2008,7 +2008,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
>  	[BQ24196] = {
>  		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
>  #ifdef CONFIG_REGULATOR
> -		.vbus_desc = bq24190_vbus_desc,
> +		.vbus_desc = &bq24190_vbus_desc,
>  #endif
>  		.check_chip = bq24190_check_chip,
>  		.set_chg_config = bq24190_battery_set_chg_config,
> @@ -2019,7 +2019,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
>  	[BQ24296] = {
>  		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
>  #ifdef CONFIG_REGULATOR
> -		.vbus_desc = bq24296_vbus_desc,
> +		.vbus_desc = &bq24296_vbus_desc,
>  #endif
>  		.check_chip = bq24296_check_chip,
>  		.set_chg_config = bq24296_battery_set_chg_config,
>
> ---
> base-commit: b150a703b56fb6eb282d059b421652ccd9155c23
> change-id: 20240103-fix-bq24190_charger-vbus_desc-non-const-c6bf001dc69d
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

Thanks
Justin

