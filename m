Return-Path: <linux-pm+bounces-31861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8EB19D69
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB701899847
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDF23C8AA;
	Mon,  4 Aug 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET0kbWi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749B23BCE2;
	Mon,  4 Aug 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295225; cv=none; b=g7rApxgQ/mjC4LOAakYWjHn5WY7PBPUnozvHgVf+Z56t4nImKg4vEgLXbqw9en3zaH4Bw1W2w35ru941MclX5J3w2jScwsHTspOHGD5c2CB6JjTZoIugT/WPx6jIOKy1oLBDZhmtw7AFKAcBn3Dg93AbgP1iTyP6yOIQ9pRx/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295225; c=relaxed/simple;
	bh=pCWbIpgPnuJ09TaUynGKBB+FXSeY+nmvlXGp0GR0TH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUxUV/URom4VaBiTBsQRCsEFq4Onz3o0+sIs/6FvFGEhuW/vkbZnYPDJuFJBbEDrzNCJSNcopa0MCddWFuoa4BAMwilnZlai1gO8g2sYl2RBY5RbZpA1z9KyCThXsFAcRlkhcpc2EzZA+Hfl8DE/AdXbYNUdF4h8hmVo1icwfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET0kbWi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECEFC4CEE7;
	Mon,  4 Aug 2025 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754295224;
	bh=pCWbIpgPnuJ09TaUynGKBB+FXSeY+nmvlXGp0GR0TH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ET0kbWi4qW25P3tOSoRFUOJt8XnZewHObdIlNJlRuJ94JG0NaRKexY4mnAszR7eb9
	 HINj0tgw+bxNToY652vYMX/Mz16SCQiPk8zSvlliMcyUig2YmYnBWzWBYsYNNlOcYD
	 GM5oyWDMRrHVmnV5q3w4k21Es90a/HEKWMJ4GSmvBh62t29rXrIfN6y7B9bS5NHhr9
	 f8UN7gt5ZStbllVTVemiz5gbv379G4AASRtQ+y1CEuYjm9qnWCJJcyJB/PGSiVgnCi
	 KkAG1QckA5nEKGM7E/4tg2nzatsLWveiqdzZMJZZMcnvqd30zEkG+fCXsH85QkYWDS
	 AaGn6zONYOsxw==
Date: Mon, 4 Aug 2025 10:13:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520
 GPU support
Message-ID: <20250804-talented-chubby-caiman-9ed7b5@kuoka>
References: <20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>
 <CGME20250801103106eucas1p11c945f612fcf56ad2521151962d745b8@eucas1p1.samsung.com>
 <20250801-apr_14_for_sending-v10-2-e85802902a29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801-apr_14_for_sending-v10-2-e85802902a29@samsung.com>

On Fri, Aug 01, 2025 at 12:31:02PM +0200, Michal Wilczynski wrote:
> Rework the PowerVR Rogue GPU binding to use an explicit, per variant
> style for defining power domain properties and add support for the
> T-HEAD TH1520 SoC's GPU.
> 
> To improve clarity and precision, the binding is refactored so that
> power domain items are listed explicitly for each variant [1]. The
> previous method relied on an implicit, positional mapping between the
> `power-domains` and `power-domain-names` properties. This change
> replaces the generic rules with self contained if/then blocks for each
> GPU variant, making the relationship between power domains and their
> names explicit and unambiguous.
> 
> The generic if block for img,img-rogue, which previously required
> power-domains and power-domain-names for all variants, is removed.
> Instead, each specific GPU variant now defines its own power domain
> requirements within a self-contained if/then block, making the schema
> more explicit.
> 
> This new structure is then used to add support for the
> `thead,th1520-gpu`. While its BXM-4-64 IP has two conceptual power
> domains, the TH1520 SoC integrates them behind a single power gate. The
> new binding models this with a specific rule that enforces a single
> `power-domains` entry and disallows the `power-domain-names` property.
> 
> Link: https://lore.kernel.org/all/4d79c8dd-c5fb-442c-ac65-37e7176b0cdd@linaro.org/ [1]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 33 ++++++++++++++++------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


