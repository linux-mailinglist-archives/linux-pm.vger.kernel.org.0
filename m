Return-Path: <linux-pm+bounces-32921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64722B323BA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417B0566BAA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C603C2D836D;
	Fri, 22 Aug 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myyMEVM+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88D2D7DCA;
	Fri, 22 Aug 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895435; cv=none; b=bdh5/Kz74v+U+Y6S+2TYyoWazJJ9yAQIjQChgl5Ty54PP/sMDdT5ucIEh/agN2kopJM03/sxqx0/Io5uBEP0AjF/per3JV7VHo8czh4IAiwLukLfPjmpvpOJ4pgfnEwQxs85r/QpYtRbcaw9aPpkVcwnpucHCcDdLeXsPeUkotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895435; c=relaxed/simple;
	bh=TEdHF9pUX27RDqqMATVQj7+pnf8Vs/Rf6VDbI1qD1Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NModu3fWrNw9/OfbEHozTwZRAduY8Fm1v4DV41mK8OXIJE13kIwDXvzsujZKOaZNi/9YiU0e3rutx70emWU/Gm3gJr2+7jq09t/2TYDlTOCGM2i5fnyl/A7bU71m2xiV5CL60RHLsxwOuOVDseVN2npYxMuD7wchU6n6brWc4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myyMEVM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F9C4CEED;
	Fri, 22 Aug 2025 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895435;
	bh=TEdHF9pUX27RDqqMATVQj7+pnf8Vs/Rf6VDbI1qD1Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myyMEVM+bG7+YSaMj6mY2qSH8azZg5DrqUVeNO5J30SqcakUL1hcNdIoGKP1xJCLX
	 AP3TMdbKHat3PbYVL99dJnb4p3+vvlet5ome8KfpPnNtrQyb5zwncNFGbDAbd0SjdG
	 ydTEvhFHNa5jRrjCjmc7QH8T5SvIPWHy9DYPx7Ik92gJ2Gr5XFcqHHpeV9dnHUDjQ1
	 fFiiNmill6JZ8rsVEWWXVc+5sr9J2iAVRUO4FNc8IF/TpHRxlPfV44lfcxeCQ0Dyif
	 KU7Co8VS4oHGDY8b0ADiAzrRgKiFwNYJueNi8ud5pvOi+fVBRpzfjRB2Fzgwx7nZlS
	 fQ0aLSJ9nKI6Q==
Date: Fri, 22 Aug 2025 13:43:53 -0700
From: Drew Fustini <fustini@kernel.org>
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v13 3/4] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU
 node
Message-ID: <aKjWiU4fQw3k77GR@x1>
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
 <CGME20250821222023eucas1p1805feda41e485de76c2981beb8b9102d@eucas1p1.samsung.com>
 <20250822-apr_14_for_sending-v13-3-af656f7cc6c3@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-apr_14_for_sending-v13-3-af656f7cc6c3@samsung.com>

On Fri, Aug 22, 2025 at 12:20:17AM +0200, Michal Wilczynski wrote:
> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> the GPU using the drm/imagination driver.
> 
> By adding this node, the kernel can recognize and initialize the GPU,
> providing graphics acceleration capabilities on the Lichee Pi 4A and
> other boards based on the TH1520 SoC.
> 
> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> controlled programatically.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Matt Coster <matt.coster@imgtec.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

I've applied this to thead-dt-for-next [1]:

0f78e44fb857 ("riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node")

Thanks,
Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=thead-dt-for-next


