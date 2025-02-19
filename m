Return-Path: <linux-pm+bounces-22418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F41A3BDAF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1516EBD9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE41DED4C;
	Wed, 19 Feb 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pau3xtXW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EF1C3C1D
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966502; cv=none; b=TXTz5lN7g6Lw8eLYvaI9K85WnkDMCc7D4YwaKi+/a+aelKVJsUe4AA4yihtihPWPUUQR/HfRe/YYPBimsRhIEfUcIWteVAw3rO9p61hhnBN+fqrCno8Lyj7mPiueS/JLyzyPoWKvWK7AwCSqyzGfzmNgovQSq9UEOCsxr3gU8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966502; c=relaxed/simple;
	bh=wcsXtdgQQL4VCUgznJrOnipwQmYIc9S+M6D4qteZ+tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itLAB+KxMf4tHk2ntXTS18hBMO7p4Pp5UB6hSkIniLS6O9eSUsZpWL0UkezijJdPublpqJ6xC43kSHcRe4mH9I6VMGO0DQ4nzRSQmnIYFbLZGEYnGbn2VXSkyS6GgKxxx4vck2rdckTgZzAFMRYC0aytmi8hw4OyX/bOtCEAc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pau3xtXW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dcea5ab3eso682773276.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966500; x=1740571300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xe0n90tbsq5x/xPm1Llh+2RuD6r7msq/tuY+Ym3TsA=;
        b=pau3xtXWvcHV/N/aolWv4okCW4Bvv7aos+tfJcokETECbzduPTP/t4s5xok9swS4Hb
         zrweubnff8o/sP+48kM9pyzsVh4ABc89tSz5h/ZXpHtsxj+53c5P69tEmW1DoWWAnuKg
         LUDQf/L0deKnN+P0nMcE8tWCxb0pZCoBov5aYmjbNIoAG3Dj7PihtbJKJycnINIM5jGv
         Oc0389vqXjx7rxrouQq0XrLTiHPu9XJZYF/4vQtlSlur8g7qdbztC5p+Ket4vqmnezqZ
         VAeuxLsji94Ti5PmvPmbt6EcaVzWdCzPgWgFT6mXyP8B9/GFM2iP//kgSiNTuAEcS1sU
         gOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966500; x=1740571300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xe0n90tbsq5x/xPm1Llh+2RuD6r7msq/tuY+Ym3TsA=;
        b=eFSJTEnA1hoo6TziYw3AGggYDtKUFvUQOdUVjZAhZgI/japxx5SsIRpzGBlwZqv1lF
         GipVEohC9sfHbVl0qeNsWuuzwnn0b+pl9Nu2zMvHLHcQumgHlrBip8UjK1tDGrqMYPsj
         EdE3Hh6HYhBzK48rv5hfl8hRplZZtr7ajPNNwPje2Z8+EjcswQtLPrUWP4yTWLh+y2ix
         XHMbBDbSzDwYL3wANl+l0OEYX6T+YCOecFeXJIsfZGIqZXT0AXEtZyxKvo059pmb+JwE
         9nFjqau+mCGvwzBZq57I6zxTXS5aaj49paotbyfNsH0DrZJ4UizhQ8HJCf+EMf6h+bRP
         Jyeg==
X-Forwarded-Encrypted: i=1; AJvYcCXnG+y4uYo0F3n1tpR/6XnS4i0o6qVtpj6vKP9GLFXo4sx2pSRGljv2iz83zFkNNkftN5JAWYGsYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8hzAC/+UOfdx4rPSlPqr5czkucwUUWsVkNoTBGoeIgoMozfi
	h/AgmPoj3Wf2WJEHpbZ57+iBmNQngl+Yz78J1aWdrA4D34jqmVMxlzeuqMLoT4U8smbfpxzR/m8
	w/1VTA4+i2AbEQjlg7Red5I1dknVdxzZXIMOMbg==
X-Gm-Gg: ASbGncssgg5vPEBqmkvXHChwiMp3dQmuWZoLiZkHa+sMu6kCE3x0RlBlAsysOLkEy+7
	MMUUqElp3wKvMjZ2RfBDUdbtgoyTGTKz7EhGetmuX8uKTU5JUwx2L6YCBs7ZmjIg+XASrBZEiYA
	==
X-Google-Smtp-Source: AGHT+IGZ/+8xQ6gwL9boFRNAF7KVM22iCnqEax+j9Sk0drg1U/1wYEwbpzOiKk0ZPA6neRnIXD7xoQxd3GTjDpsqxfA=
X-Received: by 2002:a05:6902:1027:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e5e09a34021mr2671796276.10.1739966496117; Wed, 19 Feb 2025
 04:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-gpcv2-of-property-present-v1-1-3bb1a9789654@pengutronix.de>
In-Reply-To: <20250218-gpcv2-of-property-present-v1-1-3bb1a9789654@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Feb 2025 13:01:00 +0100
X-Gm-Features: AWEUYZkq7YJtxfAEssq6nuztkZ1WzoS_qm-UMarQYj6y8mBUO7XjlBb-t9JXEpQ
Message-ID: <CAPDyKFrEHXhb42rnpjv0KqaUtRzKhX11w70ZoTM8+u9rYDJyuA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpcv2: use proper helper for property detection
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 20:18, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Starting with commit c141ecc3cecd7 ("of: Warn when of_property_read_bool()
> is used on non-boolean properties"), probing the gpcv2 device on i.MX8M
> SoCs leads to warnings when LOCKDEP is enabled.
>
> Fix this by checking property presence with of_property_present as
> intended.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpcv2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 958d34d4821b1be68d730ad345037b8f0a56c45a..105fcaf13a34c787b2d568bc64e7fee9bfc23393 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1361,7 +1361,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>         }
>
>         if (IS_ENABLED(CONFIG_LOCKDEP) &&
> -           of_property_read_bool(domain->dev->of_node, "power-domains"))
> +           of_property_present(domain->dev->of_node, "power-domains"))
>                 lockdep_set_subclass(&domain->genpd.mlock, 1);
>
>         ret = of_genpd_add_provider_simple(domain->dev->of_node,
>
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250218-gpcv2-of-property-present-158f8dbfe2dc
>
> Best regards,
> --
> Ahmad Fatoum <a.fatoum@pengutronix.de>
>

