Return-Path: <linux-pm+bounces-38239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E6C7183B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4B6682996E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A7883F;
	Thu, 20 Nov 2025 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3kk9/Nx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2363846F;
	Thu, 20 Nov 2025 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597505; cv=none; b=D8k35Nczwnye60xlG5mTYnKIPvOLg5n1yNluuFmnml0xQw0sQvRDsGhwqlugXuG/mp2pN5fQfsmbhKCkXvb3A/m7+prAdCmXYHvTGV8Yo5J1CqDZhspcnq5J9XJ6Px6XLD0+r2Bnb+rzAnqfNfNlnBDN1k1encnfexxDOi4HuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597505; c=relaxed/simple;
	bh=BJXgWOV8ilrXkWcqiCBuYjzC9vId9KOVewUanGTI5AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1yUgKPqC6MSbgIh2yqjKgxfnxV0xA8t+Zb4HjLYtpUBfV9PJXvE/79HlZMigFxkD+DtwSEh9NdSbcKIvfCE6cwxJ7fleedzxtZSNNSEt7Gk2ggr4jDnwmsc5o6LznQewbCq8LcMseBVThTw7fEzHlJUhPXvGte40B5DCrsK6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3kk9/Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF39C4CEF5;
	Thu, 20 Nov 2025 00:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763597504;
	bh=BJXgWOV8ilrXkWcqiCBuYjzC9vId9KOVewUanGTI5AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3kk9/Nxp/DO5l6FwrufqoasWCnTaPs+yanQIOr3qixcWop2otdgPZTMQE6f/Wrvu
	 nnCKtR/+npDlAJBxplDQ/BcJw31Y619hrnwJ8UNh+xSbkdTuJqu0d3roN4dE2o+K4w
	 1aXOpaHRzWI3aPJ3PjsVTow/sTS288ppZuANK1PR6TCY3I0n9/wZRrkc+nGrddYpOt
	 PT4/T9Acq/r81e0ZmY4OuBGE4Lu5s1YeflOsIld55Dozqdsh28CMqpfeSlSYaJovPf
	 T6mw26E9kU94Qn0KI1wh6SisdegAE6oNaEmqUCWFiIqyCLZyDK+Tj+XnQXNl/gyTMl
	 a5zVlgv0dbzaw==
Date: Wed, 19 Nov 2025 18:11:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	Georgi Djakov <djakov@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Henry Chen <henryc.chen@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 03/13] dt-bindings: interconnect: mt8183-emi: Add support
 for MT8196 EMI
Message-ID: <176359750213.3605847.582811616705438270.robh@kernel.org>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-3-b956d4631468@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-mt8196-dvfsrc-v1-3-b956d4631468@collabora.com>


On Fri, 14 Nov 2025 17:53:57 +0100, Nicolas Frattaroli wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a new compatible for the External Memory Interface Interconnect
> found on the MediaTek MT8196 Chromebook SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/interconnect/mediatek,mt8183-emi.yaml |  1 +
>  include/dt-bindings/interconnect/mediatek,mt8196.h | 48 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


