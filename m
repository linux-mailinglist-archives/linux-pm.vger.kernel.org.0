Return-Path: <linux-pm+bounces-29027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DCADFB2A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 04:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A761F17FD29
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA1227EA8;
	Thu, 19 Jun 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="g2CwFCi6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6E1CBEB9
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299641; cv=none; b=gOMXyJz1+Kj2WvEkrQRR7BqHjQy5klovtBqgz7xnNNBJoeXkFy4g2PI4jMSzWBEbGszlvxjUKKgmE0c8kDWpb8kCYtD4QUauixse4zmyrCbxj0I8gNg0wwmt+CeawAkLCgn72S7Pf6L/f4vNO4QdxClOlPV6PsaS6tNZ7T6w7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299641; c=relaxed/simple;
	bh=fbHwj/6Mc7LjY4LJrhtl5037k7Ipk80XNh/vyQkqCi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0SkuWKEFIRkee0kJI4zXBXFpHtKPkOeurtaUpA/iGCRCNXfsSgKmVFvGsPGeCZNVqkv30ShTseEdlH3XCFMYx2c2pgm1VQbiuhahbbTGhVvqQ4VLF7SivjoqsticLOWzFlWRCvCIZr2ptQjSq7crgzBieSEivUJ9TDZlEYZH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=g2CwFCi6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso182994b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1750299638; x=1750904438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aB+z+oapAeIvD/LMQC0pA+9Dvh98i3pYzrLPX5UVNgs=;
        b=g2CwFCi6sq6bYsGW56STu/fdSElwcbEqRmqpOgT+x6/oQ4HJlBBqJw7823cKPGAnn8
         quYuYv5opcB/hsTq0mT3zTvnupthMsWM8LLCPQSj8tsJNlq7BGSNLKV9o4i21u7ibsT8
         3kV3etSW9CXZ6jZWxt1ddGgA4VUBxNvkgbzNPGz4DEtAHxdfSOJDtdinDRFMFDpXmIzu
         XxXHvKt9wyxQS1Spg4UWayJjuwrlKOfKsvU+HngTZEatK8ABBlvF1NHfsGjA80tCOSuC
         jAVwNfeUS21qD2p1bH2eR8qwbtpiUSv6MTszxks7l6vYTtJHC19vJY0ZykxoBLAk04Qn
         iNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750299638; x=1750904438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB+z+oapAeIvD/LMQC0pA+9Dvh98i3pYzrLPX5UVNgs=;
        b=LDoA8+lYpNS3ulb40YwUaEXiqGvbvZai0Yg8uIPtUArnRGD71SUc+YzKHxHGzynu5d
         30iZLcCZI5YazGzG8dqWp+O1bcBf/nYL78ZRzqAAG+q99vEgbI5tDAC9qYIM9aymyWjw
         Oj+2Dk3BLUtHXAGdaUk34sQCRjY32tmicm06sDjUnaBQkD0BRRVIHPNofUMr8SZiUymZ
         XUJiW0V5PlqOdEzmj+Ri2R4D1U9GNTuG440e9eGc9Kjpg6zxEWiO7HWNgz60jHwPs8YF
         w+lEU8j7BEGQEvpFADT9udD03f1YYTDHqLqw6Mx5v5x2+4Wr5m8Uj+wTvJBtVJT+8moh
         Herw==
X-Forwarded-Encrypted: i=1; AJvYcCXAXCBwGsreWpivG1btUFzhANyezEJGcyPsmIwV6n8nqdrounc8XzVc2+Ridp9XIjdUiSu2wxck+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MHgKDCcT9jyCKBxFyw9FGbZoNZb78aaSRphes61rCcvTM5t5
	2mMOjV+foe4/F/Pyl7H3g05sLmmQn9K8oRgyheZfwAHeWt/WCGIT1IN8tSKyXZPYTRI=
X-Gm-Gg: ASbGncsu5PI+fF/JDvBND8XSs8J+u7yFHBEEEE5hnFWXXHc0V/omk2dq3P1L6GRDGZN
	N58m8SNR+86CMFelCItAWthyv23cuksEcTXIXtWib+zO1OD9zGUCXg9kNuLhvUuwVuyaFvKQwKq
	UTUXRzMGr03I7QumG5WOqskC6zFU3jffsyHUB6ncbjkA27wNlvIONNaL6pTDMNDNj2Hh5XK7Kls
	0YnBq5xLxvgc8LwamdqDUmp0GW0rikq0uVCCC44x3721Y0EfCwVmHLDrLSyyF3spa0RYwRiW+xl
	glM7ryNabyI5KVTuWwwrsT4kUj/ETLscTrLPCLj4N3S6Ptuq84aROOzjgGLEegHOluHFTU4=
X-Google-Smtp-Source: AGHT+IGjSSZuolaUpbJOSDgxdNJ2rz6g6jIUWqfE+ln3NvBoOq+EqOxlPwszxtc7pzssoDHlu8HO3g==
X-Received: by 2002:a05:6a21:62c9:b0:1f5:7366:2a01 with SMTP id adf61e73a8af0-21fbd6925a5mr30398731637.37.1750299638092;
        Wed, 18 Jun 2025 19:20:38 -0700 (PDT)
Received: from x1 (97-120-250-80.ptld.qwest.net. [97.120.250.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31c84be11fsm2584945a12.78.2025.06.18.19.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:20:37 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:20:35 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 6/8] riscv: dts: thead: th1520: Add GPU clkgen reset
 to AON node
Message-ID: <aFNz8/m7q4T2qSHd@x1>
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
 <CGME20250618102231eucas1p1ec99058179825cb1250a1f189313b3eb@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-6-27ed33ea5c6f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-apr_14_for_sending-v5-6-27ed33ea5c6f@samsung.com>

On Wed, Jun 18, 2025 at 12:22:12PM +0200, Michal Wilczynski wrote:
> Add the "gpu-clkgen" reset property to the AON device tree node. This
> allows the AON power domain driver to detect the capability to power
> sequence the GPU and spawn the necessary pwrseq-thead-gpu auxiliary
> driver for managing the GPU's complex power sequence.
> 
> This commit also adds the prerequisite
> dt-bindings/reset/thead,th1520-reset.h include to make the
> TH1520_RESET_ID_GPU_CLKGEN available. This include was previously
> dropped during a conflict resolution [1].
> 
> Link: https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/ [1]
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..f3f5db0201ab8c0306d4d63072a1573431e51893 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>  #include <dt-bindings/power/thead,th1520-power.h>
> +#include <dt-bindings/reset/thead,th1520-reset.h>
>  
>  / {
>  	compatible = "thead,th1520";
> @@ -234,6 +235,8 @@ aon: aon {
>  		compatible = "thead,th1520-aon";
>  		mboxes = <&mbox_910t 1>;
>  		mbox-names = "aon";
> +		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
> +		reset-names = "gpu-clkgen";
>  		#power-domain-cells = <1>;
>  	};
>  
> 
> -- 
> 2.34.1
> 

Reviewed-by: Drew Fustini <drew@pdp7.com>

