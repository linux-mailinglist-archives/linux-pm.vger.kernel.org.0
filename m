Return-Path: <linux-pm+bounces-8626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7288FC879
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE881F22D0B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23890190069;
	Wed,  5 Jun 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHEzxeB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237A19147B
	for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581496; cv=none; b=ctuuJr9UDP8fodV750ak/Ft/IuxwNlcfuEB8p33rgwOWRWdMbsWsb2qvk+jUinThISrOpqTdtVBOCvhemR3+cSj9QMtPJbZMnhZvQaycviwYxpEU5278I4lQu/a91OUOp5xulzmQpgqVZ+Vjp+9AHTkArFJ5UShN3XvvDm1LTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581496; c=relaxed/simple;
	bh=hDA71fRwtUYEBuYxCMd/F/n8HA3nU7ezWt1QeUFZ3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL+hwST6bTveenO4LGEvCGdQ+i3bxKZmy/B0nuC3fc7ii9gxm+alMynE2qTqNcammVh9ddkdolSVG6K6CK0T6Wftgd7bINQ8qu4LJaAl7AD27h51b77RkZDNHzF7fpNoARu/NrJng+sueRaNuf6Id8jaLNBOXAVDHfL+1apkuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHEzxeB+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df78b040314so2180338276.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717581493; x=1718186293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaOO1MZ5brJXt2IuBE79MJkWfpJ44KhCLFOE62rdqkI=;
        b=uHEzxeB+YaaHMrf7crpk9SxBfCJ6MsmoFqEY49wnjbe+Tpp2Pv+fzIQt2mlKF5WJWg
         0SZgm35+vzZmJmRVkfHu1CDUqUzgLnyOtApr6ebAxGwZUEJGBdaVemla3Ew6+hnORTwu
         waUb80yGK0pSx4ijx2CI6cCmDoZsa2+0HHUHi/QPIrqgG/sLBlbvD76qX3myZagPl5qs
         Mz/Nii+XmPERh6lsBkjRm/chGpLz887W1XpdTjVdAx05EpE6uvy3oSC9WxAF++kX2LC1
         PB5WDH27zG+9d+O5u3rIzu/j187yJqtjJpt1AwKpyMf8SfzuLxbzxFojPUp+b/y82FJH
         Lrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581493; x=1718186293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaOO1MZ5brJXt2IuBE79MJkWfpJ44KhCLFOE62rdqkI=;
        b=a8oBSHrAxttCBMuNIbAqxFg6Bjcs0cXTudC+OmrY2PJc6YEOxEEBHJBhGamRlRxfLN
         ycF+W7FQAooccTyKvgS4cdv1LKivWFRjfWrvFcNfLLDP0YMol8acJJ5WjL96q0glZTWl
         iIeobNkvYZ2Fk30/pZvA0lM4ZB8DUzp/5snfnMHnsf4VdVyiUHdu3z8RHztJtNb6fjLd
         gjRucPPvUr04YrrzbsdDSfNBN8QpnrAglYI9noOxAkAbjp5JwgEvIOcVDnmTx/5C0nRw
         UXd/HUpJIotXhTcp0PnJPhadtkCoHi4aIXSdGB8qQj9yLeHfCrnGk22bctccfjYhZB/y
         Em2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVbg9e4Za2zl0CukqEzwofGf/VklBwOQI8xhuEUNzPbFBlRvCgBELh3DFXLWft3mKzIdQ78QJCdk023tVQgLDBKrH4yM7wcGc=
X-Gm-Message-State: AOJu0YxCD4O2gwfaGZItXtKlRl/n5QPlFeg6jPUYB3kxNnExhIqLgnIK
	gNvIU5OTXIbld17LwQvrsM2IwdApe5w1Sa/O6WL9uM14nR9ZY+B1N62qF41B3cpH39uRfezgP4s
	sAlBjV4ic4vWQ6zeC1xYF6OQdiSvuRAeBI8jDXg==
X-Google-Smtp-Source: AGHT+IEdBB7S8dTAffaTqVKyoAg42mxePBAC5qgCxYIc7hXyLIMAXwcRWrwgP4N3N9dB3leYuKj1mXl+ldO5b05Fl/Q=
X-Received: by 2002:a25:c544:0:b0:df7:955f:9b99 with SMTP id
 3f1490d57ef6-dfacaced9aamr1925384276.47.1717581493556; Wed, 05 Jun 2024
 02:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514131833.911703-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240514131833.911703-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:57:37 +0200
Message-ID: <CAPDyKFrs1YjPOEW9eVa4HK+Ct-gnBWB6nRCAvNGvmwBYqnCPZA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: set flag GENPD_FLAG_ACTIVE_WAKEUP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 15:10, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to scmi genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 0e05a79de82d..a7784a8bb5db 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -102,6 +102,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>                 scmi_pd->genpd.name = scmi_pd->name;
>                 scmi_pd->genpd.power_off = scmi_pd_power_off;
>                 scmi_pd->genpd.power_on = scmi_pd_power_on;
> +               scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>
>                 pm_genpd_init(&scmi_pd->genpd, NULL,
>                               state == SCMI_POWER_STATE_GENERIC_OFF);
> --
> 2.37.1
>

