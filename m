Return-Path: <linux-pm+bounces-30869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BFBB06135
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4780A5A2A0C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5B29550F;
	Tue, 15 Jul 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLO5cj2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D2293C7D
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588580; cv=none; b=f4RC4HICtp2WtN36zPXOa5uR9jFsJhL09odfTGX1x19HBFItmxDG6Kg8uYZv9e2w4oU9Y+rvumcbLrVP1r60X7D3JERSVBEDPYyylXRetaCSgyPjAzTKq1nHDu06cCjOndVHcHAuBU88nObx1en8qDSgOS6/z/zE6IPNfedfLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588580; c=relaxed/simple;
	bh=8IsG4LWjsZ/JSPgVdpO6Ex9/9B06kDxYohYOARb8H5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baHL0ghFcsPUkfSa5tH/0gCLmdkpgI0F5e/X4/h0D9eUdTFnfPuPmuUQq9ji0J8bluxAlRTLJxVrDaUOiVFV/Z1TqpUEwtrBtBBRDCIpf980vQ+nxNwarxWFiMBDTMWJarwpBrVQydqmXqdODkjThX7x6k2VJSvOwPba4iMa64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLO5cj2w; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e81a7d90835so4353416276.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752588578; x=1753193378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmzfIS791V99d1Ua1vhHPiiIrS0ff5q5gbk/6URD+qs=;
        b=CLO5cj2wfse0XNLaTx3EvoiTqeJjvXRHfFNFE9VyVN7e3PjYTU1BG0jrGVmShOFhVk
         RNa33q9us0CjfpeFrJ5rhsxkupLKmxevaN3sbt25POxZE8+Be+nuECzi9CelFOrpj+Qk
         sWwovx771dasqJbBpesoj9CXfmpZ59i+5hN5DJiWptPxutTSbzLr5vLm9uoHTW8QDDX0
         f/XVrm/OenSK4cQ/E7VHSm0KIf/oK/+1SbDFGTdo/OQscLCQS7HmQm0ErbFYUx4pH4KJ
         hXHaS2eKf0zKOOFRPsYQkO2IUdqY2pGuDWxI5kUTPEjaZS2uhMEKcsA000hiimgymhIL
         7qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588578; x=1753193378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmzfIS791V99d1Ua1vhHPiiIrS0ff5q5gbk/6URD+qs=;
        b=iAKeQ5pLoE6kalYtBwWSDcPTjzEXEaQYvWMyKi7OVwtf7tdWkepkAo7io0rS6+ZxQA
         fEpLF1tzZeOLnhe7JA4zfTzCO/H29yiDrG+0RrwbEckPBcHfc7KU49VGe4Zpvq8Ds0ax
         i67XaR4Lc7iGP99nSzjo7U3b6mKu0UjH8ursDxu2bEpNP3rB1zDbY38UPQd2u4HHRCOB
         bBlO5Grll8MsdmKg7Z0C27jVw3MbSr41/O1cGq9OwjU2zBlCT22RukGAYl0JTAWN7wnR
         wOcleh/oK0m4Q7VnLA0zYYG0hyf77Q0kOdNFvxgc4qgd0oaW112CPpjan6OsbWZgTu3Y
         mixw==
X-Forwarded-Encrypted: i=1; AJvYcCXqIrrJCsKrKQEEj9IN64lPbYUAEV2qymh+9zaIxbX4pM8+YpHwDJpeM9lzg1WQcon0raPlOUolTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNiTWQPXAynSzInC0j2cXLOdILhkSI7MFDAsXGlFu+UP8qm4y
	Q2uHjyjeXJsmicq7eicMdSoQGtprE2bET/2EjVJEY4UKHGYjELsgh1Ikakwl3lQoC68OJX9+COK
	QDOFm1SfVoms9fXGM2ObEJrfyFA2rxzX+zbqfnokjIA==
X-Gm-Gg: ASbGncv5Ew2zA5jbdbVnTszTi8iAFZvM/+UCSItJJ2MimTgd4GIBnKD5sSpFx/Xov8u
	tFPsaTTfPiLyoqFLvxosntpQrVDiguIbiw3BF6TDaTMlxUEH073g5pBhUojGPeFf7qglehuYYIn
	p3rqnoanyxqCdCtG65soYMj9kp8G5r0OMwgs8BZ107wsLRY0RLcOwa348B50cYSYCza7HyTaKXV
	hzEoRfN
X-Google-Smtp-Source: AGHT+IE98901gEcrRNSUihoeT/4rQ7pCPgteeZyh+KNnxIQiEUnJhDDaQ4hcLxAbANGBHie7GXLCAxvDvoVssfzciBU=
X-Received: by 2002:a05:690c:fcc:b0:70e:29d2:fba1 with SMTP id
 00721157ae682-717d79eb927mr253244047b3.23.1752588578209; Tue, 15 Jul 2025
 07:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
In-Reply-To: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:09:02 +0200
X-Gm-Features: Ac12FXzWeXj4G9w6y6bRUIiRIIfhiACwSOMXyZAJepX0VKpzYw_PeSt2K2xdbqw
Message-ID: <CAPDyKFoqeh+-TwSR1_J3976LGmVZ1WYH6gBeuhwWpaq9HO4umA@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: ti: Select PM_GENERIC_DOMAINS
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: vigneshr@ti.com, nm@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vishalm@ti.com, 
	matthias.schiffer@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 10:50, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected.
> Since PM_GENERIC_DOMAINS is an implicit symbol, it can only be enabled
> through 'select' and cannot be explicitly enabled in configuration.
> This simplifies the dependency chain and prevents build issues
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - update commit message
> - fix select rules
> - Link to v1: https://lore.kernel.org/r/20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com
> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..5386b362a7ab 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>         tristate "TI SCI PM Domains Driver"
>         depends on TI_SCI_PROTOCOL
> -       depends on PM_GENERIC_DOMAINS
> +       select PM_GENERIC_DOMAINS if PM
>         help
>           Generic power domain implementation for TI device implementing
>           the TI SCI protocol.
>
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
>
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
>

