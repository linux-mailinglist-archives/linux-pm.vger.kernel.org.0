Return-Path: <linux-pm+bounces-24826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1863A7C352
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7CE1B603F8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74FE195B1A;
	Fri,  4 Apr 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="DOLIei0e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E31A5B8E
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792923; cv=none; b=pY36GkveU58Btrwk748s5TlNMEAzHhAKvXV5i/pDDx6CNfh2sXSZGREzgePOSRE/HC926rjTYv5O0JPq2pH6F5y/4pECxgTxZyY6NRLDTsnHeYtCECZd8GzB5JOkl11QgrG7hSetCYvBFsHPtmcFio4aYQH4Ou96KdK76V9UuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792923; c=relaxed/simple;
	bh=VfeedzAG7UGtPpSXuBMYVnF8aSHrgVbQjdxnN8frKgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRBF/hadlmed3aMsxu21m06NLA7hmmudwbLX2f/cALeHLCG38/hsf4IcYf+btW/Iy9IFcY4KYyJ0AGDk9wKrXlTITq7Ty73vVioanPW6p8FFXo1XkTYzIpRYYFhEKuIvbXTXXwIdSYTv9sZ3jiqTUQDq4ROSlIxBS6Gyg9fLiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=DOLIei0e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227b650504fso23565125ad.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Apr 2025 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1743792921; x=1744397721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32troSjWvB/PDlVrpO70BnGFukXnYd/0VAcsVL2VxIE=;
        b=DOLIei0ecBYGFmicWeKfI87N/P67NqV9YEsJR1Nc7HvTZqxxIhVEpIo1lsB0YKg5qa
         L/BxUwXOuJvF0/LV5vxUjG30mMi5XHqiGguC8u3bg0d+HOF6ADEbYnPaOqf/HRrnLxCj
         hy/9t4Of0LEas01mlWuodDDJnqlZIIO2/y56CPaiob5Fh8d4n/GbIAYC/p1WMfKuvsZy
         wqk4VaAbqlD0luES9CaXDhDNG/56ytgbPBUENTxl/585/D7g1OfoHu52dH9YCSBCwSy4
         2Zcm/8hWDjlUMpQ8ms/Zl3BtPFrgChehC7iirN3Ej0iZ8EqQS4QPpPOE7aoNHvNrIys/
         IM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743792921; x=1744397721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32troSjWvB/PDlVrpO70BnGFukXnYd/0VAcsVL2VxIE=;
        b=nJfUP6EUSb3p7gNS7T5184h7JzwFnYzO6Z/8aMoRi7E58QivQUuDW1j5gI3JTJ4neQ
         RN4+ttKHZ/pNKDF4sP7vQzjEaee5RE/o2JBGBJZm+XWJVPAQu5Ar+JrlEK2pv4iFHj/5
         CQaxtz9BIg4lgML3YqZ3jWfPCdqSRYlc9Qg8iVMWzG339jWL1N5llSZcPEkrvHI/H7aY
         EZaJtuDk65lYyIB892RhWRxws7PkHHqfMW56nl/95aRpmFNhTskj1WLyvh5R1Q+/v0Su
         1vKrsavIqrxn5SLTy6x14RB/+EJR0zk+JaauT0JXNQe6LDJwFL2Pvdw7vAlG+mEx2tJN
         84tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3W4rY1gLLz51Lhr3BH3VAYUMTJa09MTf7TRtrRA3hLMrRU3hcWP/X6hNYflad+7YSL3neT12o5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYOLAIAs/PR4ZJgNP9UX80+cQU9ACjWLwFhugzm51XdDHwCje
	/U/6Yk9HftgaiDrObVuiXp/S7pN9F9rfKiKeGpYYa8L5Q61Rp6p4mX0OsStzfio=
X-Gm-Gg: ASbGncsZfAt2adO6JnZX1+6+OlnSf7nLX/SeR6CvjX3saKiSuoBagrn+vGDx7hFjuG5
	GccI6m9qusvhTYcaMOSwS3Fhk0wvO6npz2pCCFltRz0J8fCbEnlJ8F6yKAsUN0dauSU5InU19IM
	bZu3DLNtiJq8oIAXI+tYsNyje8ZQaesyMMlKE+aQ92uMiYufjk9p0mbGO6Eoi3lqRrNNyBwrC3W
	mjg94evdXBGN7/jNdc5tO7cskJwPVIYZvYeV7pl+JC8KLfMg9oZ/0AN2FgFQqsEGJomBnrMHUoW
	O2fG2TR7ECc/ixKLiwakGQPmNR4ZJOMDX24=
X-Google-Smtp-Source: AGHT+IECmYP3SjonjrfaeQPGWit3y+M9U7cHmSeJkMMAtjCbnPOJUL/PaAkD08+LqlcqZzBhgLpMMw==
X-Received: by 2002:a17:902:ef10:b0:216:53fa:634f with SMTP id d9443c01a7336-22a8a1d4617mr66236245ad.48.1743792921190;
        Fri, 04 Apr 2025 11:55:21 -0700 (PDT)
Received: from x1 ([97.115.235.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e4c2sm35763515ad.199.2025.04.04.11.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:55:20 -0700 (PDT)
Date: Fri, 4 Apr 2025 11:55:17 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Conor Dooley <conor@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Message-ID: <Z/ArFVx6l5Urh9KV@x1>
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
 <CGME20250311172035eucas1p104dcbae706bec735194a1dc4a30db969@eucas1p1.samsung.com>
 <20250311171900.1549916-6-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311171900.1549916-6-m.wilczynski@samsung.com>

On Tue, Mar 11, 2025 at 06:19:00PM +0100, Michal Wilczynski wrote:
> T-Head SoCs feature separate power domains (power islands) for major
> components like the GPU, Audio, and NPU. To manage the power states of
> these components effectively, the kernel requires generic power domain
> support.
> 
> This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
> allowing the power domain driver for these components to be compiled and
> integrated. This ensures proper power management and energy efficiency
> on T-Head platforms.
> 
> By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
> for the power domain drivers to function correctly on RISC-V
> architecture with T-Head SoCs.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/Kconfig.socs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1916cf7ba450..83833ded8908 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -53,6 +53,7 @@ config ARCH_THEAD
>  	bool "T-HEAD RISC-V SoCs"
>  	depends on MMU && !XIP_KERNEL
>  	select ERRATA_THEAD
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  This enables support for the RISC-V based T-HEAD SoCs.
>  
> -- 
> 2.34.1
> 

Reviewed-by: Drew Fustini <drew@pdp7.com>

Conor - would you be able to take this Kconfig.socs patch?

Thanks,
Drew

