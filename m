Return-Path: <linux-pm+bounces-25754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38819A94536
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4650F7AA350
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9C1E1C22;
	Sat, 19 Apr 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="bdbKUuBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AD1DD866
	for <linux-pm@vger.kernel.org>; Sat, 19 Apr 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745089803; cv=none; b=cLG2exZ9upwEXJjDRPMYHTUmPKiEk8thQqoDDdX44cjpMtzJ8DAhibYovhAmTznr+eIoE1oSoCWgy984H5d0+6mVOMa/B6QIRlxFLmL8YyEkKIzZbvUze0Uv4TUQ5mpi2yLl4DlFQ3PqQnuTl6/XKvw5j6fY7OsAb7K3SRgk5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745089803; c=relaxed/simple;
	bh=CvUo7ZEVGQkRI/Tl+PNYklXAI1DxJ6GpVsoi7Pb4tIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPlFbVWfZfGnEHrUp94zbarKQu3VFuefHG7ZPrCUiZV1a4FSyxYp0Uw5RYeM0zqrokRJKbt70ZF+VMU8Ua7bwkUw2iL8zO4YzDovCnoynwCeP//RkLIM51god7dXwj0wtQfCSzQuLR0MhWzSNC7f2ZOIu5SJZfQvH4xzu4NoTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=bdbKUuBD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7394945d37eso2292965b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 19 Apr 2025 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1745089800; x=1745694600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Deyh+kw6etAKus8FLe7WroHoH3C1oetm0Mie3XbPmnk=;
        b=bdbKUuBDsSWg/MznC+jTbYpxXmuy4oUSs4iSTrcbgRCG4NsinWYtNdCxr+ngxIhcdX
         bYJ8y+x29GSBmxwXKWKIXqQ9V3M9yADuXD1BtBwUv97zqPdkECZltu8j5yigl08iAulx
         e2FcnqL50TZlZKOzRGws5bU5+bCj0E4ICwm+LbbqqS/K86K4JqXAWMk9HGGfrillQVTd
         2iqxQUoeQTlUBUyPToNFBUwSqe/ELiYJjgbjw1yqTjGaJfSv+A+UjhhFqkOUwkyS8ByO
         GvBQL0uHfkiTiNwlT5a8HrAMbQCIQtbekxyRA7P698XNAvC5VEaCG2WStVKTDrcy0Psi
         9nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745089800; x=1745694600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Deyh+kw6etAKus8FLe7WroHoH3C1oetm0Mie3XbPmnk=;
        b=pX3DE1JktWDwsQsH/Hwrp39NJhS7v5DiUY6U5jlbxqKav0kM6oWvqUMvHJO5D7Lf1B
         VMws2X3bh4mYv+DEThVJMYDQuemWScjRyEy/bnfvw3dhaXU5RpppbW+cXiLxGFN9/T/M
         o6xPYWJpHeeoXmpeDzUHlEHdqpM4ow3VqEBXqywqbsWKv9+lE6kFDITXGIntRZtVKyyQ
         +vp0Mjx7WfvrBlSOLzrZbOFOP/rEBzLKt/TKLiIrBG3uRAMu49GECIswhsSyzV4OiB8S
         rL22PAny3uWK1kV7hjInGZvoq+mbr+hKWNur/musoO72JUnv7CQE7eniTSqy0VWNyB8A
         bY4g==
X-Forwarded-Encrypted: i=1; AJvYcCWfznmdLND78KtrazCDhs2lDNbIEqphZ+jLkwZI5Kl591Lrw6wIOcBV5jIJ4UQGJbjk2IMlHZKvBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7v9AT3F0R37fJ4ujj82xVeBlLI5uUHnIK784B8imUQO9fCdF
	E/pIfUNCofDwsqMWfUrUkVEpdGjt7271+ZAIr1VFDWsuhEXVwn0zUL1Se7raAck=
X-Gm-Gg: ASbGncuq1UviuJ5rbSH/MWIFJXfVxrlNm7s2l/UH8fb7I1NkCNjAmC3AfbM/Fi7li/M
	6wZkj61pbJvoEOi4MnUFaevWmUdEqtkz2RMaUZ+LKpNf+M8A/fcyP2m0/u3+sd6UiX3Gu5Dwy65
	D4qJX4BwewSjdm8DK7GZnxuWcWDhoFMBK+JUPAcG1fKSZXfDFG30jDRMRJfWj7dZ1PWm17f8pze
	t5y5p0AVv8smkU+/yQIZGrjeim8sJZGUNhoGM9/Vloyhv3ZQaPCwWJ97nWCfIfBQ/z8zhSus9om
	FlREXA7MDMhtGqqa66xsb6TN9Cz9MKPp4Zxon+Bu2Ion5Dk=
X-Google-Smtp-Source: AGHT+IEulD0uH2vbpuR4f4ZA7Mcq0ByRrFg1az3eKDUNZKezFcapWJg4o30Tvo+Xd7BMD278/s2TCg==
X-Received: by 2002:a05:6a00:9281:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-73dc1442ee6mr9314401b3a.2.1745089799961;
        Sat, 19 Apr 2025 12:09:59 -0700 (PDT)
Received: from x1 (97-120-122-6.ptld.qwest.net. [97.120.122.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7easm3611489b3a.84.2025.04.19.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:09:59 -0700 (PDT)
Date: Sat, 19 Apr 2025 12:09:57 -0700
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
Subject: Re: [PATCH v5 20/21] riscv: dts: thead: Introduce reset controller
 node
Message-ID: <aAP1BW3RmMb/Irya@x1>
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <CGME20250219140316eucas1p29a76023868946f090f261bf78d5103e3@eucas1p2.samsung.com>
 <20250219140239.1378758-21-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219140239.1378758-21-m.wilczynski@samsung.com>

On Wed, Feb 19, 2025 at 03:02:38PM +0100, Michal Wilczynski wrote:
> T-HEAD TH1520 SoC requires to put the GPU out of the reset state as part
> of the power-up sequence.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 474f31576a1b..6b34aab4b455 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>  #include <dt-bindings/power/thead,th1520-power.h>
> +#include <dt-bindings/reset/thead,th1520-reset.h>

Are you okay if I omit this hunk? My thead-dt-for-next branch is based
on 6.15-rc1 but thead,th1520-reset.h only exists in next until the merge
window.

>  
>  / {
>  	compatible = "thead,th1520";
> @@ -497,6 +498,12 @@ clk: clock-controller@ffef010000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		rst: reset-controller@ffef528000 {
> +			compatible = "thead,th1520-reset";
> +			reg = <0xff 0xef528000 0x0 0x4f>;
> +			#reset-cells = <1>;
> +		};
> +
>  		clk_vo: clock-controller@ffef528050 {
>  			compatible = "thead,th1520-clk-vo";
>  			reg = <0xff 0xef528050 0x0 0xfb0>;
> -- 
> 2.34.1
> 

With the above caveat:

Reviewed-by: Drew Fustini <drew@pdp7.com>


-Drew

