Return-Path: <linux-pm+bounces-19373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292F9F4D09
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FEB1671C4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83A1F4732;
	Tue, 17 Dec 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFl+Srr7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC41DA612
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444214; cv=none; b=UUhw2v34roazFMdQ3rlKFvAPYC46uJZtoTb58PnG5+lnJr2gT5Rbc0VB+cSkAurDZDqyTeH0/0iQtg8VFrNy16zPn1LyH4z2yhIFRiPSuUds5QOXdOGCM/Yhm6bYxwwGH5c3zarrnguxAbZ8LJlWB5WutgCHDI42ojMHl8oB27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444214; c=relaxed/simple;
	bh=wCQHu8BwkDT8ncBNm5G4lju6R+6zZnSNztOygT5JKic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Ol6AbuKFNIDxatphmelMyHWWtTfFzVvrz1spQfER01Xx4lfssv0B8yhwTGeHyZcKf0iXXbso4BhPrH8ys1TkSoukoS72sgCafN5+8n98TV+wtDSxpwtdXyVwr8AuE3yI6D5f4TWDQsjCMEWHARC2j7N+feSOS7l+qStfsvo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFl+Srr7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso63319075ad.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 06:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444211; x=1735049011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCZKJMoVvIqoAo0zanWnts+pYSmSp4PD4qrht3efijY=;
        b=nFl+Srr7NmfGflGQDJLkba9e8zs0VPlLRoAJeYS+Jke0NOaEDDf1IHEeSti06bHcSx
         jlt1BQNREwcFWsbkC/HwvcQ/fsOsPkHC58WPEYtyV6alX1HolTudQ4HrH0ezeb0/pn1P
         laadDbFpEHwoRqznR7Wq6VIMPs/hSrlC1HXj7HECr9HsM4p3kiwnIVzvr3t+vTzmbUs3
         CaNrO+eF+vdTqPaU5GwjaHnvT+9/e1odAoFc8RveOrI4P9oZodvl7Gbd+IIlVRHiBkv/
         KdY3JUbPLLuUxZLlu8BBejPRMVbh5y+ILRlq/PH01jjAFed/JSCVFMp3mtIfrQsMwyvK
         uWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444211; x=1735049011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCZKJMoVvIqoAo0zanWnts+pYSmSp4PD4qrht3efijY=;
        b=sfLVtEcDHUShm3C6uMmBdy/Q0/iFAI/B01SK3M9lywTiISx8UdGECbGvs8YkCuzOUx
         8BAyn4NeqWHDLZ4kdQ2n8BnAaMJrV/4hLm01ChMpWq7HwhPhg6JApe/i70gIyYJF4I35
         CQKamdMeTUiyl0zIEwOGLzVBHIvEGo3PWK4T8DtBczU7/3uKUjwoeLTPWslTTFxOGmOK
         L9zHaQcl+a/GJYOIhGlbTBX0chKqKlueTFPb3bXWuHKwda7mEGTmrHVGUCqUSc4YTd6r
         1UmHKt4xdJsJ58pQfQEKITQS/jI3oveQ9XVQLhh5U0vCp+a/3nc40gYNmcWfQxy2b/kz
         avOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVm7JrYw/We/5BHdheYGuGfSuzZoJUp0Y2Fe5LPE/OqH/cYxytazrJ9Qt/pEA7rAQgfB5T42o++A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjKHPwIAlzcQHvhhEmxDW4gi+5xMmyiMXrWn4Ga4jGEczinrE
	yH1z0XqF3OWs84k5IHm695TuJmBka+Xrgdq2CRiJBzHfKE0g7D3UUyEOuCVQQA==
X-Gm-Gg: ASbGncv1icP7WaGpx0MIOQ98VeYgQJZBZLlNdSWeUEvFoE7XaoqJQVYeedPWac7Iw1i
	IFq4XKI1evHIK21YwDB/TNM6QOyybS4n0Go5DbydLLWFHbkIBQR52m1lRUNvTq74FnIdl7GmzUJ
	ctVnRwVvV5zu/ui/bJIcrUIYaKL1rEVf2mKwng0cjtHU+Az+0qYA8s69s5M4Ed12yJuV58v6xh2
	MgXOhzuyz2lmkXlMzDZhXby8DW1cn9YS7h/aBE7wBvGbIWEbWQzE3Ygf3667tkkr26p
X-Google-Smtp-Source: AGHT+IEiVh3IK/cHWgWHyriKw5bPElBDWb9qyZwFCCoIkHMl48UnzDp2xqVg4Uf+zOD9e/YruO5kMg==
X-Received: by 2002:a17:903:186:b0:217:803a:e47a with SMTP id d9443c01a7336-218929f1df7mr242010715ad.4.1734444211179;
        Tue, 17 Dec 2024 06:03:31 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d897sm59814305ad.183.2024.12.17.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:03:30 -0800 (PST)
Date: Tue, 17 Dec 2024 19:33:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: explain why we need the
 WLAN_EN GPIO hack
Message-ID: <20241217140325.qgm6m7qf2fdj35j2@thinkpad>
References: <20241217130714.51406-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217130714.51406-1-brgl@bgdev.pl>

On Tue, Dec 17, 2024 at 02:07:14PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With the recent rework of the PCI power control code, the workaround for
> the wlan-enable GPIO - where we don't set a default (low) state in the
> power sequencing driver, but instead request the pin as-is - should no
> longer be needed but some platforms still fail to probe the WLAN
> controller. This is caused by the Qcom PCIe controller and needs a
> workaround in the controller driver so add a FIXME to eventually remove
> the hack from this driver once this is done.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index cc03b5aaa8f2..9d6a68ac719f 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -396,6 +396,14 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
>  				     "Failed to get the Bluetooth enable GPIO\n");
>  
> +	/*
> +	 * FIXME: This should actually be GPIOD_OUT_LOW. The driver model can
> +	 * correctly handle provider <-> consumer dependencies but there is a
> +	 * known issue with Qcom PCIe controllers where, if the device is
> +	 * powered off abrubtly (without controller driver noticing), the PCIe
> +	 * link moves to link down state. Until the link-down handling is
> +	 * addressed in the controller driver, we need to keep this workaround.

Maybe we should add some info on how GPIOD_OUT_LOW causes link down. Like,

	/*
	 * FIXME: This should actually be GPIOD_OUT_LOW. But doing so would
	 * cause the WLAN power to be toggled, resulting in PCIe link down.
	 * Since the PCIe controller driver is not handling link down currently,
	 * the device becomes unusable. So we need to keep this workaround until
	 * the link down handling is implemented in the controller driver.
	 */

But the comment applies to gpiod_direction_output() call as well, right?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

