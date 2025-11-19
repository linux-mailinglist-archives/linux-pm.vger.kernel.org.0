Return-Path: <linux-pm+bounces-38204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E150FC6D305
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 08:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 96C4E2D308
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820EB2DCF6C;
	Wed, 19 Nov 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVVzonae"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AC2DC35F;
	Wed, 19 Nov 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538086; cv=none; b=IpXEI8BzWSPnHDbqpLnxVhBhonuXy9dwaXaz5fl3JAKrZ+mZ6nLroR7IFsvAubh0ovgtJ5SW8dBI3DQLsoKxgy7iOCRSXuu8o8XSTGbkEN3JG/JIPDz8+5rzayUDL1JEBI+B3/AKLihjg3bNIsFrBeuuxjIL+ejgPSYkNt1hlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538086; c=relaxed/simple;
	bh=4eY06maHYnT5lNFH0eB7O2jDfn5WCtik/H3E/nwjWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTcxnehlcBJWfe5ZlQeHiaIFYNpwSXQ40rS6kUR+NoKVJzERgzjH9yMQq2Jd7CsuyTUQLqM7j++vrxGbTdPQD8hf5YJPKfrUU5u+W8lBlsu8wC5hlUic6vdXhz/1VWWVITFBr5ytG8E3a/pgmcAv7vQi8blIARvvsKo+QHtbDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVVzonae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AACC2BC87;
	Wed, 19 Nov 2025 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763538085;
	bh=4eY06maHYnT5lNFH0eB7O2jDfn5WCtik/H3E/nwjWRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVVzonaeNJKYA8WlG3h55teuPs0ljF/sh6fJ5udPN8grARL4dDzlEQ6AYz2ftwH0o
	 90EuYBY4nJW9wB+6UtAaPZ91jtl/1crtg8fI99FHW3pLbh/cMQ2Qcym+/GYFK7ELHk
	 OBcvFjd/xzefm4YhjO9lMvmJpsDhSzdFkoLySc+cC6J24XHh8Dlo9xAPloiM3l+AqM
	 Ae9bajc2lxXC34Lct1q6x/18XcL8xLnP0SfVnv7UHEGGDz50lJkjpJob8bR6apiO9V
	 xg3me0g97S5O0XFqKIposd/p/tV20k5FBkMyzl035rsCF/YCOu68H2En1lcmWYTHAi
	 929a/i7XneDyA==
Date: Wed, 19 Nov 2025 08:41:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Henry Chen <henryc.chen@mediatek.com>, 
	Georgi Djakov <djakov@kernel.org>, kernel@collabora.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support
 for MT8196
Message-ID: <20251119-alluring-jellyfish-of-chaos-4f5bd8@kuoka>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-1-b956d4631468@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114-mt8196-dvfsrc-v1-1-b956d4631468@collabora.com>

On Fri, Nov 14, 2025 at 05:53:55PM +0100, Nicolas Frattaroli wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a compatible for the MediaTek MT8196 Chromebook SoC's
> DVFSRC hardware, introducing capability to communicate with it.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Incomplete DCO chain.

Best regards,
Krzysztof


