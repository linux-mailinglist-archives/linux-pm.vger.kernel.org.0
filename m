Return-Path: <linux-pm+bounces-22609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF34A3EFC5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173B63BEFDE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0B204096;
	Fri, 21 Feb 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOvrXnia"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65E203718;
	Fri, 21 Feb 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129177; cv=none; b=HKOr7PpwU2HYA7aUsQ4ZM0b32T0gvwopFynlT9iPrZ1PH5Vx1JcspNovuOOf9VMCwOBC1beCWQPDJklVSzK3ogI/2zBfGozQJJuohSGlzbj6985cMlkOJ2US0cPFQwvbYNj5fcmqJ0T2rLBMliV5dzQRz7WKY3dSptrv9bSipIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129177; c=relaxed/simple;
	bh=mGyruGLf48W9PdHCU/1T2pGmF4R+E3nW6UeeBVAtmrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVOTsU541qMwKuM2NFKASCok2xXBFINj1RVeIyfR6rq0JRLmUci+NiNiz2c2y6ztVi/xLRSleEDkhiCEzcC3F0meMubgQMCkvnWGAgW5Jb5dc2TvELLlh2grclVHyJjcRrKfkIMx0c3LWaz7R25lbine976jhUhOOCrIqJqMXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOvrXnia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF0DC4CED6;
	Fri, 21 Feb 2025 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740129177;
	bh=mGyruGLf48W9PdHCU/1T2pGmF4R+E3nW6UeeBVAtmrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOvrXniaMi5ISUyFw5P3LDYA3GLaau6Z0hBefRURq22U28Gtx89/qJZqaKQAlFjFn
	 NzsqPEeTOS/uB//GvmU2vykTyWBtxHH0fzQMsL9fpmSdqgr4kiX/qreqMIQdIsEilE
	 0gpESbJ1rO+tUsJYxEIkKHiuweHLkPPSQo9UZ7D/Rix6NDr7pNTY5HlzlpDk7+bwe4
	 2dmjKx7HrIYGyUgRWzAwCM31jwcf2L3OScZDa+jKwqi2TiloIutJDvIHu/s7Pw/cQ1
	 rp1f+v5OPY28kaIS5uiLSkMMIqMDOSRqRNEAxfOYqZ67w/rjNERHsYnAN7zXJQKwhu
	 n0zmklCfvEevQ==
Date: Fri, 21 Feb 2025 10:12:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Enable drm/imagination BXM-4-64 Support for
 LicheePi 4A
Message-ID: <20250221-eminent-squirrel-of-honor-dee80d@krzk-bin>
References: <CGME20250219140249eucas1p1291eb86c932373c847a3314ae54789d5@eucas1p1.samsung.com>
 <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>

On Wed, Feb 19, 2025 at 03:02:18PM +0100, Michal Wilczynski wrote:
> The LicheePi 4A board, featuring the T-HEAD TH1520 SoC, includes an Imagination
> Technologies BXM-4-64 GPU. Initial support for this GPU was provided through a
> downstream driver [1]. Recently, efforts have been made to upstream support for
> the Rogue family GPUs, which the BXM-4-64 is part of [2].
> 
> While the initial upstream driver focused on the AXE-1-16 GPU, newer patches
> have introduced support for the BXS-4-64 GPU [3]. The modern upstream
> drm/imagination driver is expected to support the BXM-4-64 as well [4][5]. As
> this support is being developed, it's crucial to upstream the necessary glue
> code including clock and power-domain drivers so they're ready for integration
> with the drm/imagination driver.
> 

This is v5 of big patchset which became huge. I understand you did like
that for v1 which was RFC. But it stopped being RFC.

Split your patchset, keeping versioning and changelog, per subsystem.

Best regards,
Krzysztof


