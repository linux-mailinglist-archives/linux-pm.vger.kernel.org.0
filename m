Return-Path: <linux-pm+bounces-33340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF99B3AD1F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 23:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879F17BA1A1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A92BEFFE;
	Thu, 28 Aug 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fShS14ZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214F28153A;
	Thu, 28 Aug 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418199; cv=none; b=isKGGI9IwZ96hKOxu6npZcjFr274L9wMNsfmGopmEF2Sakk8rzaIV4eNrzVCaSeowU2SobesjHAFcMYFhETFpudzA6d/9TobLfb/a+E6rPgR7PfWW7EIbrl5BVuiRb+ZgXuzqlwR0X7MYcMqRPlerxSrCwJktCLcH6hOV5jMw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418199; c=relaxed/simple;
	bh=dSngZWUPELR3QxYM2J7tSWcOG69It00KDI2P68gPg34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEhQqzkOY3Tut5U6L7nsa8NrBFg7vuYqKpmw+i6/PI00lUwZEt890mD8AFzWabv0GMny+EdraunBXcgSX2eWuAtytvb2NfRCErrV53/Rr+iWoTuDY0/LI6aCyhojy+LP9M45XYpr6tdiWavBR32or0qmsyfGmT6R6qDUOrKzCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fShS14ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6786FC4CEEB;
	Thu, 28 Aug 2025 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418199;
	bh=dSngZWUPELR3QxYM2J7tSWcOG69It00KDI2P68gPg34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fShS14ZU9g2uMtlXOdGlNrGxb1FPB+hi/AWsG5ubmCfFyjbAZUU45fSykZZ3AAsKp
	 fdSlH9u5yIumKzKidWWSSxxjE1MvRGOjiRHlQv6+39AlppwStNdKRCJKe8IeubgH3c
	 U1GR7WVWYd7MvEWoOE5wrosQfE5u2i4g9Ayj7gPgSm+or8wxO9hWBhYiTOR1ld9Obe
	 LBJz4uGDnarR22rkrKb+EiBB2c0w4AZ1vEctukS9blJFE8xIsDrmjHJgx5tCw87CUD
	 taZ2ayjCf6oGs/rfbRDftLlw+rrdqfE3jUC8a/lB3BTEODoIpoJHy2aaF5mOz78PrG
	 cM3mHAQFHGcEw==
Date: Thu, 28 Aug 2025 23:56:30 +0200
From: Drew Fustini <fustini@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v13 3/4] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU
 node
Message-ID: <aLDQjq9U_mDvMTJo@gen8>
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
 <CGME20250821222023eucas1p1805feda41e485de76c2981beb8b9102d@eucas1p1.samsung.com>
 <20250822-apr_14_for_sending-v13-3-af656f7cc6c3@samsung.com>
 <aKjWiU4fQw3k77GR@x1>
 <aK-BwY8c-OR_WqNk@thelio>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK-BwY8c-OR_WqNk@thelio>

On Wed, Aug 27, 2025 at 03:08:01PM -0700, Drew Fustini wrote:
> On Fri, Aug 22, 2025 at 01:43:53PM -0700, Drew Fustini wrote:
> > On Fri, Aug 22, 2025 at 12:20:17AM +0200, Michal Wilczynski wrote:
> > > Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> > > TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> > > the GPU using the drm/imagination driver.
> > > 
> > > By adding this node, the kernel can recognize and initialize the GPU,
> > > providing graphics acceleration capabilities on the Lichee Pi 4A and
> > > other boards based on the TH1520 SoC.
> > > 
> > > Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> > > controlled programatically.
> > > 
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Reviewed-by: Drew Fustini <drew@pdp7.com>
> > > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Acked-by: Matt Coster <matt.coster@imgtec.com>
> > > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > > ---
> > >  arch/riscv/boot/dts/thead/th1520.dtsi | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > 
> > I've applied this to thead-dt-for-next [1]:
> > 
> > 0f78e44fb857 ("riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node")
> > 
> > Thanks,
> > Drew
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=thead-dt-for-next
> 
> Hi Matt,
> 
> Do you know when the dt binding patch will be applied to
> the drm-misc/for-linux-next tree?
> 
> I applied the dts patch but it is creating a warning in next right now.
> If the binding won't show up soon in drm-misc, then I'll remove this dts
> patch from next as dtbs_check is now failing in next. I can add it back
> once the binding makes it to next.

I've now removed this patch from thead-dt-for-next and will add it back
once the bindings show up in next.

Thanks,
Drew

