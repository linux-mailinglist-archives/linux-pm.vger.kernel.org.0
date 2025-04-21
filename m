Return-Path: <linux-pm+bounces-25815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21431A955E5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE78F188F89A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F31E8326;
	Mon, 21 Apr 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtVCiZzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B91E5B60;
	Mon, 21 Apr 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260116; cv=none; b=uGGtpb38r/OMUHAqu/ndcrsj0marf2bsB9VnreH6SX/IlBfMACBn79cE1CRhJqNGhm+He0fTChf3cBNhNM6RAaf/dAk/nSmBOblQxS6NhvtSkRABWlVZGstf3iYg/mfb6A0JaKXnb/AxQf1Fc2jq5pAgZh5iC1uUEjkrhlBmYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260116; c=relaxed/simple;
	bh=Vmtqno/d3qgsFMGiFqBLYpJ2lKOac8MEr3Jk3QpAofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqwvwJCiclPxnu6Sq8Tfeq/klqDaPbV5sjnGiZEhdByN7dHiLM9EGqmN3dydsSfCXhLa6NTEmAz27CttIf6A9ZHLLYFnQO1IBksmXXhDpK3fjA+7kJ6AgzrDMYAlu2AXtKwxnuDlzlxh+K7qzJdyqhlgkdjy/3HPhQ1EpNKBrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtVCiZzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9603AC4CEE4;
	Mon, 21 Apr 2025 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260115;
	bh=Vmtqno/d3qgsFMGiFqBLYpJ2lKOac8MEr3Jk3QpAofc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtVCiZzMuw4JfoJXQ6RiriRGaQjVarGrsrAXBB3MHs6VkXXmFQfQZlSI1O6dWJFSq
	 WFMjIyduyxG1WpWNzmUHJldjDbCuXUw7MJq1+Kio/r/AwCmBZWBbhA/O7WGaq74EUG
	 sfoEwqmkim5SgAOltHtnAHjYHf6ZjpxCHb70Pj+m+gF9xcP3P3A5/Mbu8MpzDTiMer
	 SMY4vrqxfv290r0cd9VpDWnTPI+pv82F1662ZGpexCyUNAHIOBy89oplvAMST9tbo9
	 xG84mqcEPQ8ZkzKKGpKySiUMGUOdTGZQvb28d6GjhOM3I95S10wEpwncNnbuql5+fO
	 +IRn1TbZchAIg==
Date: Mon, 21 Apr 2025 13:28:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, heiko@sntech.de,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Zhang Rui <rui.zhang@intel.com>, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip-thermal: Support the RK3562
 SoC compatible
Message-ID: <174526011307.2579990.5987087257843200731.robh@kernel.org>
References: <20250415033940.47914-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415033940.47914-1-kever.yang@rock-chips.com>


On Tue, 15 Apr 2025 11:39:39 +0800, Kever Yang wrote:
> Add a new compatible for tsadc on RK3562 SoCs.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


