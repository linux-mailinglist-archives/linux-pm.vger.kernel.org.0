Return-Path: <linux-pm+bounces-28018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6ADACC78E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB947A62CE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA422F152;
	Tue,  3 Jun 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCx2Ves8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22C13C8E8;
	Tue,  3 Jun 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956779; cv=none; b=GfWHk/MY4YXOoy1NLniGIcemG+uDWXpi+885dYaw3DXmfUjfiOLqfOGQ6ZjzxwBSp/XOnYf6Gg+b4YYQU/O7hX1qies4jEC2VA0LsCwbA/DOVNd8yLh93w8X3wnhO2M6yKGCzraYxK5HWTUcI6KkGP9wYxv8iHiNF41rQXYC6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956779; c=relaxed/simple;
	bh=BUb2QW21yeqzM051GOhES0gqoIL4Rmp0XJ1cLsKkkFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3Gy3fKX4NjUO+aIfoUerlTWb/kDAqk3uNtEmn59MJBYw8mBZkMQn2Q97QS6anUe3QHFY6nJAcxlaMvTJtmR/sqF5ZedEF5AviioRLuCT2dLkRuaB0QEvNqPE4Z6MmNSJ6By7NDtGAx4M+9FXNm1ZMfovl5IXcTYJLl3W/9itxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCx2Ves8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42966C4CEED;
	Tue,  3 Jun 2025 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748956779;
	bh=BUb2QW21yeqzM051GOhES0gqoIL4Rmp0XJ1cLsKkkFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCx2Ves8w9qYxM4hUda/RJyzKt5LpAysbiddLfiCtysyBkpuf3XPKrS89PpbxCWfF
	 TFHL0qTmoQizeffzo7MOchIdzhidrICVIOPN8GsxW31h6I0iGXWsLbEB4OQRtMrSXC
	 XBXlUaS4Zuh7W4Qj+IMHPSE8jbNRMookwpZXMWflFATq6HN0WfhOPguKV6NSQHrdKE
	 tUZXz4TJNXQZMH0NU5lCDjPG3Fc4CkfcnQ7oXNLNWAnzJjSLCyRPUKHOthYYZ5t+t+
	 Qaaj5iolJa15f+Vr4drY8reSk6s7Kt6X3vBsPMOxGMnAT/bqxBoJ9zST0GO70cncyI
	 /EdpFNYfZdEFw==
Date: Tue, 3 Jun 2025 15:19:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power
 sequencer
Message-ID: <20250603-cuddly-certain-mussel-4fbe96@kuoka>
References: <CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
 <CAMRc=Me9cWfe2mL=Q6JQbAFjpd55MOBZuAWC793Us0criiQr4Q@mail.gmail.com>
 <4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com>

On Mon, Jun 02, 2025 at 10:29:13PM GMT, Michal Wilczynski wrote:
> >> +description: |
> >> +  This binding describes the power sequencer for the T-HEAD TH1520 GPU.
> >> +  This sequencer handles the specific power-up and power-down sequences
> >> +  required by the GPU, including managing clocks and resets from both the
> >> +  sequencer and the GPU device itself.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: thead,th1520-gpu-pwrseq
> >> +
> > 
> > Before I review the rest: is this actually a physical device that
> > takes care of the power sequencing? Some kind of a power management
> > unit for the GPU? If so, I bet it's not called "power sequencer" so
> > let's use its actual name as per the datasheet?
> 
> Hi Bart,
> Thanks for your feedback. 
> 
> The hardware block responsible for powering up the components in the
> TH1520 SoC datasheet is called AON (Always On). However, we already have
> a DT node named aon that serves as a power domain provider
> (Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml).

So no. One device, one device node (sometimes with cildren nodes). You
do not get another device node just because someone wrote incomplete
binding or because driver looks differently.

> 
> Following the discussion [1] about needing a separate DT node for the
> power sequencing capabilities of this AON block, and thinking further
> about it, I think the binding should be more generic. The AON block can
> manage power sequences for more than just the GPU (e.g. NPU, AUDIO,
> DSP).
> 
> The compatible string could be updated like so:
> "thead,th1520-aon-pwrseq"

Should not be separate node, you already have one for AON.

Best regards,
Krzysztof


