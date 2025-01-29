Return-Path: <linux-pm+bounces-21080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E897A21833
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 08:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926713A2FE2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114A1990A2;
	Wed, 29 Jan 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjv8wCD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDA1799F;
	Wed, 29 Jan 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135940; cv=none; b=YKdEtl7glr30ireNuLhmFF9oL1KtAbZKyHe7Hk4OnnugoSZ/z7EQZnhJHah9jJuZsvgurmabMCKWy7FFbfXRvIvBycg7lv8NGQOwI7oS0icSBNV2rjaLzDstw6qshoRa4DjJ2WaU+wtBlfDewgVHRLuTSJbT6feMUFGyvBhIllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135940; c=relaxed/simple;
	bh=edf6GahyS4kb1UUMjT6wYRelLIajZBKgtmSAla2YLgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRz1XnbAdxj3Dm3zPI05JgKg4wbHQl5nZNBZja0mgm+kK3k8JpMyNuk1VzXOtQPp9N6zUcHPz6W/RPNOWbo/p3B4l3CT+7k+1lLHeRy9mU3AFS9MqAsKG5O1IFa6Yew5qWYPeqgrv5usULlhAgPQBnn12/6QSvXu2s5BRzHzzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjv8wCD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0791BC4CED3;
	Wed, 29 Jan 2025 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738135939;
	bh=edf6GahyS4kb1UUMjT6wYRelLIajZBKgtmSAla2YLgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjv8wCD2xyOyOzx6Ndz/9YmNXJrbfN0QJI5XzsYL/xBliwLXKzqYaleXdo7ByuVJa
	 QTJBzwtwN46kGOat1zK6Wsg0FRh7OfdUa+IL1j+ZhOtg2Av8dCXtcQSIRpvBUq3vr/
	 zlmXZKObadkO9d7vZsOQLTKC994XxA1LLd0vcwrLTCByse9TaVJWHqdN6Q9CtbKlSm
	 RKDYE8QKFskkBoWsEuHllVQESs5ofolRAZ4cuBoR/gikHpPPfQPeyannm4PXskLZUC
	 7+wAxRXTJxCMaknotTf3cp0QXyN8NESG39PJ81pxKiG4FAfEAo45IFhxsbGIvIXyEu
	 wEzzJqrDpRZFA==
Date: Wed, 29 Jan 2025 08:32:16 +0100
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
Subject: Re: [PATCH v4 08/18] dt-bindings: reset: Add T-HEAD TH1520 SoC Reset
 Controller
Message-ID: <20250129-stereotyped-just-sponge-c8ffab@krzk-bin>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
 <CGME20250128194835eucas1p29b16bee72365f321e1056fc4d9d44345@eucas1p2.samsung.com>
 <20250128194816.2185326-9-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128194816.2185326-9-m.wilczynski@samsung.com>

On Tue, Jan 28, 2025 at 08:48:06PM +0100, Michal Wilczynski wrote:
> Add a YAML schema for the T-HEAD TH1520 SoC reset controller. This
> controller manages resets for subsystems such as the GPU within the
> TH1520 SoC.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  .../dt-bindings/reset/thead,th1520-reset.h    | 15 +++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


