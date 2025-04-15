Return-Path: <linux-pm+bounces-25422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898EA891C4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 04:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4801E17CA7F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C9205AB8;
	Tue, 15 Apr 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="v7IVIRgi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1933DF
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682676; cv=none; b=C+giIpweV5jIfk/Wpc/j7CkNFCWsyg5PvoBp5U08eYa144ytNYhf2p/5EYxfnOZa23bOr5GzpzrcKHqoXw5wom2kjf6IrM+BMgzPfEx4fTxDGExQbD5ScIX1RWEIEic7btP1/vVAB1gQRIB4KtsWfguhPS1GjrRRsEQ0nonf0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682676; c=relaxed/simple;
	bh=tEDXzDkWlHgvvbX/JljUt2UxkVPnnZQtkQIAfB5Q7M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRtuEtkE9/wO7cmOQ1FTH2k8qLvMNpDEtB5ztgc/P5vStee4c6JEKLDRVUt1huqNvB/2uWhrC+OAZWppTfll0TroOEfLX965Ztjvewlq9UAuueb5zm6qhf5YgPZ+e5V4O3S4R8JVZeue722jsj/B/evv2fCcR0t7SXUtDxdeUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=v7IVIRgi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af59c920d32so3667968a12.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2025 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1744682672; x=1745287472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVKNwOsV5XMrSrMJnf19rxwG/iaJAJwZinmx64BUP7k=;
        b=v7IVIRgiEm06f5Sl1Ma+KA1tWciebQ/fDrAGee/jEludo/aWshcp+MAoUaXs0iL+qZ
         30kgwwr1ZxNS/fqcNP3IpW06bYrHW/q/4yeFRsO83bbi36t0YOnkwP8DbwPG/VsWd9Zk
         pY197cus+iTFVu8j6vM2XV0j38nZ3thbMBn+jMLL+Ey5vR/MmbQaCTTXCiJ+NYweXWPi
         r0BtIVbEDQjWa0dyeyv4+Lewf4QOZMVb+l9DQFhfgm+yxwb1qNM7973/RkPL2JULbUa2
         23XmYrMMMbzxa5IGhZvaxx1YmkK2bMU0ZNE071W/yY9OMkshH1ojP7IJTUlYxZIUwhdZ
         n9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744682672; x=1745287472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVKNwOsV5XMrSrMJnf19rxwG/iaJAJwZinmx64BUP7k=;
        b=jzLIP1YG6M+XM0GFuyV7ixah+P+WqX7tfjmxOphUYkxCC7HZFI7OQMhYtCxhpy7Yy6
         tbBLbm5q/fSR8v9Jf0olK45gk3nDreakPX/JSHL+mUZTo6u4pIT4ZZa50D6Bi5x1X7rs
         20Q0X1+XyXpLI5wd6rAMatdjvZyw2+3YvxYFvo9qNIf5yPhkC+F9Ah/KsD9lIpf2qcK0
         q/lwyCNraesgh/URcRoVSy1wOQ50fIOC9MRFWWuW0n8MjEF1IGm+/YjpumaH8ihqyAse
         M2BztONpPQjxXRnzxBK/3YAreABNvfPOJkgmHdXnISPym/ZfFphplitSGJDX8Al/uJVP
         fu+g==
X-Forwarded-Encrypted: i=1; AJvYcCWitlOeExXGrg5MPz8xZMBVjekBY5WQCLqgun2aW+zJYIxKE9qLWoHuktTIa4mB7PYVtLDPRBLkQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGchYbneVYu1LNfCWh2wYshUwrRHcf08kdmhoIATBtiFiapdP
	vVmQg5AFEbYRTSW31whoTP0rzzOvTwAqLLQ/4+yrPfNwAZvfvmu45H8sSdOirBc=
X-Gm-Gg: ASbGncteAjdJdvdCnhRQwdPpB1uNA7ECekBa5Q8tEy8omYWhfjWJgsKSC4thmRTEiCh
	OMDXGUCm4n0voUj99JJurHWeX2E0i9jjP6mwCDWt8d5H4XjPn2q/i/jPVN0qH8+D8U3dLpNboKG
	f3MMoXkc0yixTMvx+xd+5FLO3OX7SeKjl0NjiK5j2gy+Lt55EfNtFdfbRSZQ59RjjiOyAzrtDiY
	tycRetrc7qOimxZ0+2DKkG6dCIx8lQiir6arI0jOeSGGSqidmi6XrM/G3HYYJuPFLUNrZ2QjKZI
	9CBhexS7AUB+tGag5CeSnUQv5qc3SAdMbDMK1S2Jo9vwjp8=
X-Google-Smtp-Source: AGHT+IEGINtwuIIvAG2vOyy+05/hzxGzcyCN3rLg9V0W9dc2TsjoIN0MbhxjBGLcyWirEoR5Ps2qpQ==
X-Received: by 2002:a17:90a:d64d:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-308237b9f43mr17682243a91.24.1744682672433;
        Mon, 14 Apr 2025 19:04:32 -0700 (PDT)
Received: from x1 (97-120-122-6.ptld.qwest.net. [97.120.122.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b4d5sm13372486a91.25.2025.04.14.19.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 19:04:31 -0700 (PDT)
Date: Mon, 14 Apr 2025 19:04:29 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, ulf.hansson@linaro.org, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 19/21] riscv: dts: thead: Introduce power domain nodes
 with aon firmware
Message-ID: <Z/2+rbhsaBP0DQop@x1>
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <CGME20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d@eucas1p1.samsung.com>
 <20250219140239.1378758-20-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219140239.1378758-20-m.wilczynski@samsung.com>

On Wed, Feb 19, 2025 at 03:02:37PM +0100, Michal Wilczynski wrote:
> The DRM Imagination GPU requires a power-domain driver. In the T-HEAD
> TH1520 SoC implements power management capabilities through the E902
> core, which can be communicated with through the mailbox, using firmware
> protocol.
> 
> Add AON node, which servers as a power-domain controller.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 197df1f32b25..474f31576a1b 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> +#include <dt-bindings/power/thead,th1520-power.h>
>  
>  / {
>  	compatible = "thead,th1520";
> @@ -229,6 +230,13 @@ stmmac_axi_config: stmmac-axi-config {
>  		snps,blen = <0 0 64 32 0 0 0>;
>  	};
>  
> +	aon: aon {
> +		compatible = "thead,th1520-aon";
> +		mboxes = <&mbox_910t 1>;
> +		mbox-names = "aon";
> +		#power-domain-cells = <1>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> -- 
> 2.34.1
> 

Reviewed-by: Drew Fustini <drew@pdp7.com>

I tested this on top of 6.15-rc1 and found no issues.

-Drew

