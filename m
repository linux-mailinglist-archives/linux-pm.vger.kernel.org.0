Return-Path: <linux-pm+bounces-21076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56BEA2181A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 08:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195291885B6A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE198A1A;
	Wed, 29 Jan 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbAqTznq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B6195FE5;
	Wed, 29 Jan 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135772; cv=none; b=sLEmMKXoXyReQJgPvdehzncpC3Fnth/8wfzWRmw1ej9dUi4EbWzRcKBcR08e+FP8MXGeZC+zboExdDPLZgD9sSCAo8/MCl6rL3Kh2AWzVBNdxEA2gEgRG5IGJrkGOJmp0dCkjTR95WkSmnK68n2b6Oe1yBTVb7XbZSwPem8PcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135772; c=relaxed/simple;
	bh=DXSINqkmFSvNXZ9ZgNUdpFLZfOy0cstu/Nnpuqu30vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRLTNqqJ7h/UNNIMakLNlj012UeIw0UgGSOc9G+INVt/ZV7YoMzl2lPqKISp97UMdshroR9vZP36y8qEfnkxh8Gsy0Ly3IUyL7MEIVG8Y+R/BbaREQyEbm5vOrs4J+IDW9Sb4I66gNZOMwFvSqDSymjKfH8spXBGm4ZiI3wBk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbAqTznq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9843C4CED3;
	Wed, 29 Jan 2025 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738135771;
	bh=DXSINqkmFSvNXZ9ZgNUdpFLZfOy0cstu/Nnpuqu30vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbAqTznqG2RKyauAP1Wo2Hfs0x+2I4RrU4O0/QclXgYFjHcLHbkvro8MU29Md7BgN
	 4EKO6LxIPLbNhal3n0geqjJZcHN0QTKRzx4WAmz9QiT5oP0YvRyGegdHt8rLjprf8N
	 QuldEFKC0Q2l1InZM/Sf8nqHe8D5OaTfX0odhd5Lfs65sGTzmTVlNrsThkgOCG4b88
	 jhBEEQEa4K0pcp+iIqwr98ddocM5ECQZ1LWvaiqI+qSPQlOM1QNriV0RkSmG4RZa+X
	 RLOGYDqnfVVllxCcZNDUNpDz6T0QkxcX64DI5hJS1WfeAzZJbnVQD+jKSoyE1A5X+E
	 Z1jGiHO/+CTxw==
Date: Wed, 29 Jan 2025 08:29:28 +0100
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
Subject: Re: [PATCH v4 01/18] dt-bindings: clock: thead: Add TH1520 VO clock
 controller
Message-ID: <20250129-outstanding-golden-taipan-d3fff5@krzk-bin>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
 <CGME20250128194826eucas1p1b18e5af64e66b06da985b194d022273c@eucas1p1.samsung.com>
 <20250128194816.2185326-2-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128194816.2185326-2-m.wilczynski@samsung.com>

On Tue, Jan 28, 2025 at 08:47:59PM +0100, Michal Wilczynski wrote:
> Add device tree bindings for the TH1520 Video Output (VO) subsystem
> clock controller. The VO sub-system manages clock gates for multimedia
> components including HDMI, MIPI, and GPU.
> 
> Document the VIDEO_PLL requirements for the VO clock controller, which
> receives its input from the AP clock controller. The VIDEO_PLL is a
> Silicon Creations Sigma-Delta (integer) PLL typically running at 792 MHz
> with maximum FOUTVCO of 2376 MHz.
> 
> This binding complements the existing AP sub-system clock controller
> which manages CPU, DPU, GMAC and TEE PLLs.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/clock/thead,th1520-clk-ap.yaml   | 17 ++++++++--
>  .../dt-bindings/clock/thead,th1520-clk-ap.h   | 33 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


