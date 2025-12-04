Return-Path: <linux-pm+bounces-39213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC17CA4EA8
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CCBA30D2E2F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C133508A;
	Thu,  4 Dec 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5ihQe7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE310221F17;
	Thu,  4 Dec 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871933; cv=none; b=Ans1F6SNQ2xZqbA9mBBqMTcBr0M1+t0YLzd87AL1FD266ccWoKh7cmg74+eOCQkvMTjRyTGPxlflAu7wDuyqi4OMULXmdjBOgZt2+sQiGvPoYGg5jfjlVIhdCS00MWs3GQWBOSXS1mdXZC5sn87XcjKy7HLoJbiFNw5Lbmop1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871933; c=relaxed/simple;
	bh=8PHs28SqzWjfJzL9JIh6ooHYIVc9VF2o6WfZK+qg9+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8iOXLGRrM7pVb2YZJmEn2Q2fgm60dqcwf6tqq44UUHjsfuXjz/ApqtudzQRKBop7ge3l6tA/e2ZBWR25oERu7gkYphz9oy9ZQAGEZWqC88WrDmfR0c00aT0wz/gSrhcxmk7iU6dBUzlfCV1ihOjzkyq8kMtDU7slxo3SACE7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5ihQe7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3281C116B1;
	Thu,  4 Dec 2025 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764871933;
	bh=8PHs28SqzWjfJzL9JIh6ooHYIVc9VF2o6WfZK+qg9+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5ihQe7hpcGsdrB7QLUdYntN1ezpVQF8awkoMGAmHsi8lj789c5/vXZzMMUVQDDnk
	 iIPQOeodS5lM0Lap2gE9wOSHGlbCsTwCxML4AgnMJMqhU1YOw7CFWrqN+fYXXYvC5V
	 Kqdm6m+jEj+pJgvJg1D0w8t3GbFr1kd6Bro6Lu1NOWHBdkyp7FiGFzDeoRTZkMHTz7
	 yEdPnljw6u7TSC5ZKkdhgKPdD3wau3S9oHgZl7OzqtsrisqNglc0zQodgBqbeHm0er
	 1YhLBqAmPh6F0zg3sHin363hF/1kSFpuGMxuKa58/QNfpEh04S7OqDyDnKDwiT3GOe
	 3pG0EJZOhAgYg==
Date: Thu, 4 Dec 2025 12:12:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 07/12] dt-bindings: memory: Document Tegra114 External
 Memory Controller
Message-ID: <176487193022.1928847.1387771027394340435.robh@kernel.org>
References: <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125120559.158860-8-clamor95@gmail.com>


On Tue, 25 Nov 2025 14:05:54 +0200, Svyatoslav Ryhel wrote:
> Include Tegra114 support into existing Tegra124 EMC schema with the most
> notable difference being the amount of EMC timings and a few SoC unique
> entries.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../nvidia,tegra124-emc.yaml                  | 174 +++---------------
>  1 file changed, 26 insertions(+), 148 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


