Return-Path: <linux-pm+bounces-28925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F32ADDE90
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 00:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241843AA16B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAC293C5C;
	Tue, 17 Jun 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="x/EYJP9/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABC291C15
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198452; cv=none; b=LSFxqF2rEQg+tkFoj/DBsDergLyrQzGMRYdCPD7ysMgmtvzDjoP6lrm5j8342gaupWyQ+NrT3ndX01xPb5HjiCBSe6XdMGDvFISE5pw3sbcd4wkRk+BkrejSRNIkaqCELVwrRtDZi/hA31X0qcWNsO6wCpaR63Q8uUI82tKjjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198452; c=relaxed/simple;
	bh=kwbbyB0B0QuRG9hwjbKdJ2CGL2BZQWPKXY9uBhNi+fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/IrJqEuu/7fp5uffBN15VWfupNyU6iKS+AlQOHsWXCWVad0B5ZrEhMgj4EiZ3+gnnsJ0pfyuWPOnF6X86whJtmtmo2w6I1TW3y7nUZ0Hcg7H807wM328T6NNrFQm2zhZGLMMkP4Dcgc8yIAT56ukbNbJ5dWkbagdH5E7MWKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=x/EYJP9/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so2378240a91.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1750198451; x=1750803251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rht1pWqTVlNemlSkA4kJuYwRKU6KD6oE4FAwP7gkVd8=;
        b=x/EYJP9/iefEds7XCAbKnSIQAYRU1H20zSxIscVIbDQJgscWpLVdS4lUT0BN3CHkOj
         l3lbdmwh0FKmNMiPkohEqrShdqPfVXGqtm6lxpC5wcxR0h6hT7sV76M5Y9SgL3x60ZG0
         KrcG3JnF5Eti4X7c12CXlZ8Jd9Rn4aXKkVs+xQ4jkPO5b4d9EKuHrzYznV2FDRZRDFeq
         xqBLyC0VCY3T0iU9TEP2G/Owa6VuemXofod939Dm925L2UtS+y7U+oXvp2u15wpnRmpJ
         DteB8t4iPbL1H42HifdHmi6626Cvczmy9Pyfpa0SiYAlMkrEkUToRkCX5YuK3ZtCrorf
         Y/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198451; x=1750803251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rht1pWqTVlNemlSkA4kJuYwRKU6KD6oE4FAwP7gkVd8=;
        b=VFsAysB6QfRqXkmlmcrHAlgic8YKkUQQx9OoUrV49CPX94JLZvOkVNwAcCikE9uV3D
         +OKTOr7kfpCAFDxe/Bzm3B3MaKmU2M4n+0qtuEx8hZgWhabd+IGbMSgoFjSNotAWDMiv
         USG70HE9T14i9sgXz0JxajDexbOqckWmqQ9Z4/Y6UUG9cgihXnf56nkFUm9r788+SGQL
         Qgvg5tdTUgR+VK+5bqbCPe4BJfkuQol7UpYQGNx3JndYyp2DwWWHb6FpDX6R1r0FPXqR
         rhFL9OuR4lb8V7ujE54jItdXQVYfNMgUlOgcASEoIFm2758TvSGZ6gIoPSFGG2CEny0N
         lkFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXw7BbG1zesVSAlBnbuoZbvwTZaWJ57s3SxpBpEaO7uzvazkdZ7t9rs2F4No1XjRtQgNEVfq8zFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTTNAX154nZDP4RkjHCEKy3fymwZJ35ayQFY1QhZcItbhV+mT
	jDX9mDb4qx4G4UQ4lcHRL13oy1h2dLFAoqaf/5fiYzDZMghdFt1xd0NQkLzkhGCu8jo=
X-Gm-Gg: ASbGnct5ykiwASs/B+JBGMNIQx96UAw7CRwKPEJffqpdUmNB0xyggfYZbifD3PLumQB
	wcSqH97uM8nFOWuz/eyXkXXj4NK4IbyZCJcT5qvX9GzjCw4gjjdDuhyvyMOMqwmOP+i85gqKhhT
	+A6Whm0AR6iFXUD3kYl2kc6CjjtIvylRY/YUZmaOz8uR6WMbDP0xbSloTQ6UP10+EinJn6bqwx3
	NwTK8MrlQGcFWRUWa/dHICb4G0l3JqTza06y8LB0H1WCRYs8FU6romO+C5c/xvba2wAO6EgPPBc
	kwgA5qav0+CmyqpT/U8Kz51v/inPBHKdK2vuVc3NV75H5qyznp/s8HCh4AG9LPBMvdnDRC4=
X-Google-Smtp-Source: AGHT+IGjtDH8+7Qdmc6DGmjSJpavFXI06zS+xsVxnGKMVqLF3EoMugjqqf5A/sV2C5cZ3H3jbI/Tpg==
X-Received: by 2002:a17:90a:dfc8:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-313f19d2977mr26267870a91.0.1750198450546;
        Tue, 17 Jun 2025 15:14:10 -0700 (PDT)
Received: from x1 (97-120-250-80.ptld.qwest.net. [97.120.250.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb0fabsm85895565ad.181.2025.06.17.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 15:14:10 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:14:08 -0700
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
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/8] Add TH1520 GPU support with power sequencing
Message-ID: <aFHosEvn35Fr3LFv@x1>
References: <CGME20250614180906eucas1p116f8a13a4013edd3bbedfd2e4a8b0aa3@eucas1p1.samsung.com>
 <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>

On Sat, Jun 14, 2025 at 08:06:06PM +0200, Michal Wilczynski wrote:
> This patch series introduces support for the Imagination IMG BXM-4-64
> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
> managing the GPU's complex power-up and power-down sequence, which
> involves multiple clocks and resets.
> 
> The TH1520 GPU requires a specific sequence to be followed for its
> clocks and resets to ensure correct operation. Initial discussions and
> an earlier version of this series explored managing this via the generic
> power domain (genpd) framework. However, following further discussions
> with kernel maintainers [1], the approach has been reworked to utilize
> the dedicated power sequencing (pwrseq) framework.
> 
> This revised series now employs a new pwrseq provider driver
> (pwrseq-thead-gpu.c) specifically for the TH1520 GPU. This driver
> encapsulates the SoC specific power sequence details. The Imagination
> GPU driver (pvr_device.c) is updated to act as a consumer of this power
> sequencer, requesting the "gpu-power" target. The sequencer driver,
> during its match phase with the GPU device, acquires the necessary clock
> and reset handles from the GPU device node to perform the full sequence.
> 
> This approach aligns with the goal of abstracting SoC specific power
> management details away from generic device drivers and leverages the
> pwrseq framework as recommended.
> 
> The series is structured as follows:
> 
> Patch 1: Introduces the pwrseq-thead-gpu auxiliary driver to manage the
>          GPU's power-on/off sequence.
> Patch 2: Adds device tree bindings for the gpu-clkgen reset to the
>          existing thead,th1520-aon binding.
> Patch 3: Extends the pm-domains driver to detect the gpu-clkgen reset
>          and spawn the pwrseq-thead-gpu auxiliary driver.
> Patch 4: Updates the Imagination DRM driver to utilize the pwrseq
>          framework for TH1520 GPU power management.
> Patch 5: Adds the thead,th1520-gpu compatible string to the PowerVR GPU
>          device tree bindings.
> Patch 6: Adds the gpu-clkgen reset property to the aon node in the
>          TH1520 device tree source.
> Patch 7: Adds the device tree node for the IMG BXM-4-64 GPU and its
>          required fixed-clock.
> Patch 8: Enables compilation of the Imagination PowerVR driver on the
>          RISC-V architecture.
> 
> This patchset finishes the work started in bigger series [2] by adding
> all remaining GPU power sequencing piece. After this patchset the GPU
> probes correctly.
> 
> This series supersedes the previous genpd based approach. Testing on
> T-HEAD TH1520 SoC indicates the new pwrseq based solution works
> correctly.
> 
> An open point in Patch 7/8 concerns the GPU memory clock (gpu_mem_clk),
> defined as a fixed-clock. The specific hardware frequency for this clock
> on the TH1520 could not be determined from available public
> documentation. Consequently, clock-frequency = <0>; has been used as a
> placeholder to enable driver functionality.
> 

I don't have any more information that what is in the public PDFs [1],
so I think it is okay to have a placeholder frequency.

Is it the case that the frequency doesn't really matter from the
perspective of the driver?

Thanks,
Drew

[1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs

