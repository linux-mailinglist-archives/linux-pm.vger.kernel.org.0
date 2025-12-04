Return-Path: <linux-pm+bounces-39212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4749CA4EDE
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A6B3163B17
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482B264617;
	Thu,  4 Dec 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtUevZnH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250C7E0FF;
	Thu,  4 Dec 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871913; cv=none; b=TYlMcF0DAEaqFVsb3eq7ayb18EuDsoVwo5MTNDkhDMDghUozmzaxvdxGwoFWRq4JR4FO9AmEFYQ6iiyebKEpp5EsRTiX1rsSCukr6csX4T7b5n+YxxbJVNkWRjtVoJDwNhLe/hdrzg+6zA8CrK8Zp7andMKB2Rkoau2iCfufB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871913; c=relaxed/simple;
	bh=YGqSHCukN44MtRAA840rsVjxdK53+EwKH0OSFzHnSOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv7DzC5zsvGXmxIU3rWWHQr4Krji6kk1C8swBOTwG7k4xC0AMX611z0M7JgYA97vslfYq8f8RA5LfpORiiw0ZfPGoe3GtaFZqXUe14jTVWmYlvrLm9dvTZLlqk/Ze+eRwjyadUlWIX6BvE2wXr0Mm3KOeg5p28yAY55+aytFqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtUevZnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BFC4CEFB;
	Thu,  4 Dec 2025 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764871912;
	bh=YGqSHCukN44MtRAA840rsVjxdK53+EwKH0OSFzHnSOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtUevZnH9RyvYMwzl477YFL5aNO4tBDkZ7lPcYx+0FpgBO1r42u230DnuXmNz2C+0
	 te/oUqwKp2gliIPEB/KHHGgPcftaCabfOpcC2i+pl+2Xd0pV4iA4CudTktvHhe/gl0
	 1gyc0VaX436WtYq7jR7EAO/qlH6Cx867DVjrGd79okmFzGn1lITdoWhnqvjWmnNprI
	 ESTGJs9WZkYplqJdCCMZLNCPv+nnJRtebqbCGxSyMlPOhaeobI+E59XMXuNwR9p+gp
	 tos+AGU5KSFED2q0L/bUVmM8Y+mfKL2pScbvZMQUMMqp+BHPpomUgFi7UmaKUdR9pl
	 wxiKVIAIxP/Qw==
Date: Thu, 4 Dec 2025 12:11:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-clk@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 03/12] dt-bindings: memory: Document Tegra114 Memory
 Controller
Message-ID: <176487190886.1928350.15840507391980964576.robh@kernel.org>
References: <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125120559.158860-4-clamor95@gmail.com>


On Tue, 25 Nov 2025 14:05:50 +0200, Svyatoslav Ryhel wrote:
> Add Tegra114 support into existing Tegra124 MC schema with the most
> notable difference in the amount of EMEM timings.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../nvidia,tegra124-mc.yaml                   | 31 +++++--------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


