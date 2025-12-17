Return-Path: <linux-pm+bounces-39655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F77CC86AD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5D9A3084AF6
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7D32FA2D;
	Wed, 17 Dec 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9IO0nff"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C431A570;
	Wed, 17 Dec 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984518; cv=none; b=PoIGdc5L29wKmjgyZ5HEuiR2AE7tws6VCDDc+5XUkJIe8ILAKBrOr3qiEdSR8hY6P4jVwtRr0u5imGV5+D3UJVykfshEoyc2qcoGrUb7Vq6DdW+MvbM0CsMvxeTEBucYe4FK2C0VwuQussbBG+Pe8kNG8XEaCaPJQj5KP2Tb4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984518; c=relaxed/simple;
	bh=Btj100b3qkTo3KVBNV7TQ3iQV1z8JP2xG/b9a6lKJlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHK2V4nwzUBmUdpzIEYvVu3xR/H3rPS+ISqyonyBrT2jo2afbdBMUb00Tpgq5EkvKPl5KJFjx5d6XafxHdvGCTQJtt60jdKJxVnvy6NCFrVE3DX2C5EYy5oa6uKqk5tNMAeVfSdOMvw7AoWKl08az/iG59TpPxLPWidzvAbZhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9IO0nff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D111C4CEF5;
	Wed, 17 Dec 2025 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765984517;
	bh=Btj100b3qkTo3KVBNV7TQ3iQV1z8JP2xG/b9a6lKJlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9IO0nffzR1Xj1UJDqh+wM8FYdD8qSTPTIFeF2CBrSppZFGiKU1kdaujFy84JJYUk
	 2ecEsTnwnhOgSWAIya984+zazXy9Wpua+vQf9IMcJ6GhdVG0u2WCl4R4y2Cs8DIlL5
	 moKN+issr9WJTfHOzCtzemJxt+8Oz2HtiyT29+sKNrnJ2WzT5GSJeWjVm7dZRziXkq
	 h4VpAYQV42W8yDd9rjbgg4hag6xKWlHqogy/7R6yWi3qEHEyCe10Qyne4CeGI99qZV
	 OeW+cZaVUanK8H54VAC2RPliN86O6xnr0tx2GTM7UJEDWKybNCmI6aBBFoMe7emrH7
	 sfZ6LBhsJSknA==
Date: Wed, 17 Dec 2025 09:15:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix
 incorrectly added reg and clocks
Message-ID: <176598451440.1188733.3632841442234617513.robh@kernel.org>
References: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>


On Sat, 29 Nov 2025 10:46:13 +0100, Krzysztof Kozlowski wrote:
> Commit 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks
> properties to enable QoS on sa8775p") claims that all interconnects have
> clocks and MMIO address space, but that is just not true.  Only few
> have.  Bindings should restrict properties and should not allow
> specifying non-existing hardware description, so fix missing constraints
> for 'reg' and 'clocks'.
> 
> Fixes: 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


