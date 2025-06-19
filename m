Return-Path: <linux-pm+bounces-29026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B96ADFB0B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601871BC0F5F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7971DA62E;
	Thu, 19 Jun 2025 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="zn0uKbAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2961A238D
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297853; cv=none; b=u3/85Bn6Vf2ozdEyvqic8z/amWw0pJS6sRmUDCFV/+NSuRe/qj+qsVVXuJPnR2xuQ381CuY5x/+XsLwhXm5+s2C8gF6wkSSdkK+BfM8W6ftT6PWjcdOD78lj4ixpeVFEd/Kj8AAbu21ODShgTO+HzT9DfHU41mWq1i9spchg1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297853; c=relaxed/simple;
	bh=LJIIB8Y9KBiJiHVobgfRu8lyn8BY9L9gB/pucGaNm4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU0/CM3Unnhcz8YSENolIkb6CogoGnKg2a/5T9E1VJfvV7rD8iTqpxpUgOOSBBzGCbcy9F96clHBV3r0KzBPy1qDHTmwskWopgzzz5Zqx6G7VLwUAB5hhVdBf5Xb1PiHQ6Pz/DE3CmbP+xR5v9UuOki05tCgEtIfPZ2rQ70W6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=zn0uKbAg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso135574a91.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 18:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1750297851; x=1750902651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77PKh9SalLpybL3AAe7PoOLwMgQqtz9KiJ/uaTkWDSw=;
        b=zn0uKbAgSrLAvfDqV19BsF/Dt/jnN/PCgcpL+67bPnrihGF53lfSk3MyzGmTDP9FHd
         0ixUSsncp8J4U3gYoHVAcjhh1iqIYc/6J92wp45EmGAueHOjViZMFpNA690efLuVqbXw
         qFuYkM8n1oBLBSM/+tKqTB/MlNLM5Cvzuozp2vleI57k1W8WsRMYwr9zAXa5AHatGbvi
         +CrjzEw1U76ydJonHk9DyHLOExOGCntbzhMwUEklcl5LKtLl0xWyFkydOTuOwgw5gAhc
         ZJgNIXWLx6VE52aRN2NbjbzdXN39R2zk5i10bzIy18Rw/SZdIOAA05b/MfADPUJUn0yf
         VJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750297851; x=1750902651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77PKh9SalLpybL3AAe7PoOLwMgQqtz9KiJ/uaTkWDSw=;
        b=SJh3Z0SL3AXsPv5vQ8c0CuAhdGxRnSQqqs2UcS7UZYKmDatJDlmiuMXOI/KHtyv0BP
         Zq+pKvi5F7VgKEtmthhAkSX0iKdbUrnMfBxgbAHDFyBzBVJTpp2v9Dk9E0FkinzlOBRn
         FJHK57P0g2PY730APrUCLRZ6mMQqr3fWYBrLKJIcpSIbm0iWJ4aQqnFZwrFcUATgHzGl
         56mRZ3Ff91UCveDd3o/9xjEONoOomzjrb4z1/m24JVVXio8sUT3/dUdb9vjHSMdLcwU8
         617CA1W2b3Jsq+95aB/p05IHqwYSd5Qret8JaQwC66EJCgXSyKE8R/cN/9skqAbYpe9Y
         vJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLPy4MiE+yc8oWXzwEdGzPEV76X9G7MzQbM7Hh4LG/HWEBkljUOF7rNFEsx1rsSF8eUkXNlO3Bew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7PrLyb3JQWTLFkY7Sg9KdQzf0748uuGCLjqlcy5YXfZ/6NId
	/47y5i8hhYd3B7WlnCC0VdIeOCJ7KK8pW09vXv+gGAKTLm0EAWTEMok6IabAIM7ZJ+M=
X-Gm-Gg: ASbGncuY7ZBy2TFl0UbwCaZjJr4L5hPaE4etLggSIoCU9I+it9nxHm37pFABy62kQCB
	MLpEXAQPOIIj2DLgZ4I6kqr85l2m4xo86KGyM5w5QztUQvVDydv4vlxuI7pxnWI26tooV2hcNP3
	hOjP0Wauia2ikjJ8W6gVs3bMhiXyccQa8d8ncd05XVZZvTktXiKLyRhQLUMWuW4DOR6kK3B7vHX
	cmEfRc5/nyiJmihB1xQowtZL4Umdx+uSt4lyrlq/tvINwJNuOMf65ybHshOyT0EGguspjd5FAM0
	i3ZEja0yEZi0SN6XV9gqgreB3sHBykUes8guOM/ixnsHahcr4hR58hXlbHvKJrOcOiyGJM4=
X-Google-Smtp-Source: AGHT+IEH8ENEIXXiapQFn7dY5pW85bznCSDAM8YeveXgruCVaip94nhm+ZCyfl9XM7JJOLVmNJsDyw==
X-Received: by 2002:a17:90b:586b:b0:312:39c1:c9cf with SMTP id 98e67ed59e1d1-313f1be1c89mr31855817a91.7.1750297850614;
        Wed, 18 Jun 2025 18:50:50 -0700 (PDT)
Received: from x1 (97-120-250-80.ptld.qwest.net. [97.120.250.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226f7asm811267a91.10.2025.06.18.18.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:50:50 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:50:48 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/8] dt-bindings: firmware: thead,th1520: Add resets
 for GPU clkgen
Message-ID: <aFNs+PLgw1jqqiUm@x1>
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
 <CGME20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-2-27ed33ea5c6f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-apr_14_for_sending-v5-2-27ed33ea5c6f@samsung.com>

On Wed, Jun 18, 2025 at 12:22:08PM +0200, Michal Wilczynski wrote:
> Extend the TH1520 AON to describe the GPU clkgen reset line, required
> for proper GPU clock and reset sequencing.
> 
> The T-HEAD TH1520 GPU requires coordinated management of two clocks
> (core and sys) and two resets (GPU core reset and GPU clkgen reset).
> Only the clkgen reset is exposed at the AON level, to support SoC
> specific initialization handled through a dedicated auxiliary power
> sequencing driver. The GPU core reset remains described in the GPU
> device node, as from the GPU driver's perspective, there is only a
> single reset line [1].
> 
> This follows upstream maintainers' recommendations [2] to abstract SoC
> specific details into the PM domain layer rather than exposing them to
> drivers directly.
> 
> Link: https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@imgtec.com/ - [1]
> Link: https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/ - [2]
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> index bbc183200400de7aadbb21fea21911f6f4227b09..3365124c7fd4736922717bd31caa13272f4a4ea6 100644
> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> @@ -32,6 +32,13 @@ properties:
>      items:
>        - const: aon
>  
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: gpu-clkgen
> +
>    "#power-domain-cells":
>      const: 1
>  
> 
> -- 
> 2.34.1
> 

Reviewed-by: Drew Fustini <drew@pdp7.com>

I'm wondering what tree this should go through. Ulf took the original
patch that created the binding.

Thanks,
Drew

