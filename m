Return-Path: <linux-pm+bounces-28019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B005ACC797
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4E6189449C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3922FE02;
	Tue,  3 Jun 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0ReAnAt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A21A08AF;
	Tue,  3 Jun 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956845; cv=none; b=hR6XDoWy1aX5rjm2ruwRVZPAVIkRkOHdI3grkjWxxL1G9LFndK7qlWMpON7COcNBj9iuzkHXGGD0RSYDY9nDPgB4Jaj/yWdfuBTwdua6lI6Rv2/6XKALPfNykFjdwcIL+8gW3CgK8NOB/iNpjrasRxHpuDATW3SeiXWjUhuKEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956845; c=relaxed/simple;
	bh=RLET0vNHW12fPEu2WD0/7IfHIEMQvJ29hvwt3raNVWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzzRqfHeIWkTpaMXlWDMRmXWnqfR+u8T6P4Rr5K137/u7+Ly6GjnuNBh1gm3SGGwzUlHTK/dL0Qs+EQmEE9aVcvAfJ+sfDUylXcjbe+NJyQI7dohd72a6/kMNbE7XHUaV24gvXbwXtPyhOFjeb8scW+DKlbmWwDVbprADT/E1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0ReAnAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F34C4CEED;
	Tue,  3 Jun 2025 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748956844;
	bh=RLET0vNHW12fPEu2WD0/7IfHIEMQvJ29hvwt3raNVWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0ReAnAt9ELewq8mhN1MKu8QAhUBd75lgYpwe/y0CJrqDw6NT+FXDbtF9D5Urf8+R
	 cekywChSI4uLND1SK0Bn5LKBsmUdSS4y9xooQ7sbIx3t2UFvuhYAetxGCfRiWyarSw
	 lpxtLwTHqkGlISZNDoK76o5Vyma7W6+nyM83Oc/lw55lo8umALKXhAERYZ6daDB54F
	 idE2D7diFj8XpVZD1B8ScJiRh/wByJt2+wAFDq9xdFPySNqJzdiycQs17Z+3URIQus
	 HxbKBuAXer5DK+Psal5gAlH0jurXXkKKNylzOyRRnplJRWgdg27xzMHqt69B0Mfwzd
	 GMuFGku2QmpwQ==
Date: Tue, 3 Jun 2025 15:20:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 5/8] riscv: dts: thead: th1520: Add missing reset
 controller header include
Message-ID: <20250603-tactful-valiant-mackerel-bfb6be@kuoka>
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265@eucas1p2.samsung.com>
 <20250530-apr_14_for_sending-v3-5-83d5744d997c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530-apr_14_for_sending-v3-5-83d5744d997c@samsung.com>

On Fri, May 30, 2025 at 12:23:52AM GMT, Michal Wilczynski wrote:
> TH1520_RESET_ID_GPU_CLKGEN and TH1520_RESET_ID_GPU are required for GPU
> power sequencing to work.  To make these symbols available, add the
> necessary include for the T-HEAD TH1520 reset controller bindings.

How would it compile/build without it? If there are no users, then do
not add unused header just to add it.

Best regards,
Krzysztof


