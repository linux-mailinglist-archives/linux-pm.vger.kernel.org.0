Return-Path: <linux-pm+bounces-39695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CCCCE623
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 04:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57FD930184CC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6723E342;
	Fri, 19 Dec 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBCm6SDd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E21531C8
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766115809; cv=none; b=EoQhep5ciM2AF4WgH94kf8+LTo7uFiy0OxOhipaU3CR+EwTo2f/wz2gx0dOI0SM6A9VJy4sFayNATzDkdH08P4XOfjxF5bJfSH5Ln/GV2iDxSXv+1NbgiDTrgnmddlisNDUmsoHVjqYrHC3WSl/wFTx1cRJowhPeKtPKL3WhXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766115809; c=relaxed/simple;
	bh=/+/02mHb1HrL6AKHtg45bGwV92oQ3hIXvxlv4YXwEwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaaoO1/4ebGXhv0nMr4rSJGLH4oEOUu4K8Ym+eCzDflxlZdp4XAcCAmdtFMW7bLmLcoUlnTxhpC4mHwt2Pvv/R/z7+C61iXOMYdQvvWouWCYTrRPUr+IU7uBTalMAW1TQCCPO+xeaSgM781ptWO4kwx24P6g+JN8Ovn1Wuf6L4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBCm6SDd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09757004cso15123365ad.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 19:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766115807; x=1766720607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZGEygBcsO/oKCwageSM2DRt3G4KImaNzRFkbQxZiig=;
        b=gBCm6SDdVjZKrL2G5hm6zWrAlk11r7W2K/zxk5Oh6AhJQEQ/A22QnhPCX2LPriOWfy
         4dv78C/E77UjAIXAd0KDwVHTT2T6TRur/Nvbg5FlFCFkLae9V4cQ6uCNBVsk4sW0TElT
         RMt/vPHuWkHDv5eyWLqf8kgyM29IYbCLxFTTUE7HskD+wTpTy0QjA0qNeC+Ehgm6i9Gz
         DTyOtpBYJQSjv0aAdN/5LqkWoami8B1uB6cXGpyLhKzxsBsxhSUmpgjRjgVKpUbRnkCn
         z5pC9sPESh3F+1pXiK+yZqxOV32Q+CZC4oBBX2kK/EC4Of8Vq8MnHTXDtYKUiq3oAETG
         wFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766115807; x=1766720607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZGEygBcsO/oKCwageSM2DRt3G4KImaNzRFkbQxZiig=;
        b=klqm3NFIJ7OYXYDJPUGpkWfjMr3Dtv/ZyanMnoJvmbaE8U5ZqVdi2fjBwBqdvRSAsX
         hKrNDARINfCs9yinC4vxj8O9wF/yy6Cui9UNORYsmxgm4fd8z8ZVxKmbqo4KFkh4c3Eu
         amu9Ljur3c6g3Q5etRz6gS/A+R6Zeflg+Y/eDt/gwTAfoQ2Map8IWYj7uB5ujwk2FM91
         NzjT5BruyXzCEXjhXzw/B/siUjOJDoHUNPQi1oVYu5qGtM/LTTS/jG8Z7Egcgdg029sD
         +Uj7QNKrArqw+QzhleF8ePuBJK5Z3hof7p9aLoEpNi/bbgrTmvoxGJb7hhZyqek2vD6Q
         6aow==
X-Forwarded-Encrypted: i=1; AJvYcCWw3AKVeCX6oKirPpZd3o1Fz85gHcKOuAdSgopKh/cdufGAsdwRLa1wM+AwhM/IrWXD8RAEolkLRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XhKglNjADdS3yQYQnTKm9atzEareoPKQzk46mc9Qq2EGFGsm
	LC+36n/CYrW3rO0SodQLi8qW6NlX/bBgXkp4V6839gJkz+ZTPlkV6VO5WDVe8x5mGp4=
X-Gm-Gg: AY/fxX4z+G0XQIJBkUshCcv1naD3T98PbR2Xz4Bof40nrqi3NPMTdyWNxuHatMpjSjj
	kmf/MjimBHGgnl9GPnvOFr3wiYsew2TOpKikxMHS91IaZiKeWMzBSEpt9RVLmIWvfF2UWTzt+Vw
	pEIvzJEcQ+7Pb4TiqzSG8FFQaKGrthF9uf8ouPLVpM4qre+w8drWg3OMygz+sWEV20tzmj+uoyL
	13T22KO5OApxg0T969mt3WlBNfP2MKCZ+op58EP3xTRpFnk15TMWQoRWwukaUcCRJrm9Z5VLRxu
	1830SVVtlv1/zPJ+AxNuTdhdX16MeYn+G7skW32IJyQIHhbi/NUN1r8mFzjdsUhpWpnvRixbCv5
	YwTzgiEAvyqv9jzb011n1drETwHbEsbsZCxJotYbIv1hInLrqZPntnXPGCCRIACGeZ64Nx0JzSd
	bcfMj4SLHdCnY=
X-Google-Smtp-Source: AGHT+IGlsoNHEL8i59q9qEj6kjvjsFab0APaIoFYUZRGCJsJZ1UYOg7o+SgOqkSQbAhrh6ORS774rw==
X-Received: by 2002:a05:6a20:244c:b0:361:3bdd:65f7 with SMTP id adf61e73a8af0-376a75ef393mr1708530637.13.1766115806838;
        Thu, 18 Dec 2025 19:43:26 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7a018eb5sm701846a12.16.2025.12.18.19.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:43:26 -0800 (PST)
Date: Fri, 19 Dec 2025 09:13:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev
 blocklist
Message-ID: <pnei5i25rmjf72lro7ehwcsjyu5yfu27t2kesy2f6ufy25fx7j@fn43nh4pofb5>
References: <20251218-cpufreq-dt-block-tegra186-194-v1-1-24adeea10b86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-cpufreq-dt-block-tegra186-194-v1-1-24adeea10b86@gmail.com>

On 18-12-25, 15:39, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> These have platform specific drivers.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b06a43143d23c6365e1e0b26d4299ef4b0c3482f..1708179b2610bca6035d10f0f4766eee6f73912e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -147,6 +147,8 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "nvidia,tegra30", },
>  	{ .compatible = "nvidia,tegra114", },
>  	{ .compatible = "nvidia,tegra124", },
> +	{ .compatible = "nvidia,tegra186", },
> +	{ .compatible = "nvidia,tegra194", },
>  	{ .compatible = "nvidia,tegra210", },
>  	{ .compatible = "nvidia,tegra234", },

Applied. Thanks.

-- 
viresh

