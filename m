Return-Path: <linux-pm+bounces-38122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D01C642BF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1FA136356D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6970333424;
	Mon, 17 Nov 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d49lZmHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AA32ED44;
	Mon, 17 Nov 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383153; cv=none; b=m0JNh+ZAQp+iTEBwitFaN/pF0aDuOrufXSgaKGGD7AoPUcY/NxD+olRZV1LzgwmnhxTYVHjXw89QlLicesAhQdl+CP1ibyfYhxB7n5Ll6mXCiChjCYmydnDD/9i+hNXwG8KwifGvFKS+fD4y+mNCJNf9i6vvxn2O6sIWU+x07ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383153; c=relaxed/simple;
	bh=ierKwIIuey+KBX9hw2bltCwqXrLhrQJwTN42mjY84yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm4El95VKebz5qtasJ+1indsVo8L5RARtRjccn3S2Hcu6kAYn9ONhb8aWx7Az+bhjSMiq01nqNAxIqU6g3f37iIoISKD3IGiN7hgAxXisgv0GufDPMHnvphWYeAX+rg2HBYhKKmd3ISF/i2oR8rKTnlvdAGBFf/GIbBtlQoeGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d49lZmHl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763383149;
	bh=ierKwIIuey+KBX9hw2bltCwqXrLhrQJwTN42mjY84yI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d49lZmHlRM17eRcwy37ucduJi/6vt5S30qFVQ1rDXMn58KPiAZu+PV3X9mnSE7m2q
	 zzhhe/mOUDd1XpBzlvkkbT5hUeiKSvNGGuSf2dkb7XNV1pc9i0yPHFjpBsd5lKj8kX
	 /uWx3veA3PYYRhRw2qtCWLyaqy4HVh5zPYsCw+wi3POyszvaOM2Va32XYS53IOLXuF
	 ow9K9pRbJCse9FujAdNkqAHLGqUVmrNPUjy16cwDDdj99SN+pcUL+Eeq6QV3q6nbkB
	 eTvC45gEekK9fC4qDarD8Xs0bF0QBFK5s619StKPVkUVfAbV+al2HXmAgGB+B2z1Oz
	 twtyJGWTWpuJg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C23917E1249;
	Mon, 17 Nov 2025 13:39:09 +0100 (CET)
Message-ID: <2dd6857c-5895-4a53-8ccf-7407e454fd1d@collabora.com>
Date: Mon, 17 Nov 2025 13:39:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] soc: mediatek: mtk-dvfsrc: Rework bandwidth
 calculations
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-10-b956d4631468@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251114-mt8196-dvfsrc-v1-10-b956d4631468@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/25 17:54, Nicolas Frattaroli ha scritto:
> The code, as it is, plays fast and loose with bandwidth units. It also
> doesn't specify its constraints in the actual maximum hardware value,
> but as some roundabout thing that then ends up multiplied into the
> actual hardware value constraint after some indirections. In part, this
> is due to the use of individual members for storing each limit, instead
> of making it possible to index them by type.
> 
> Rework all of this by adding const array members indexed by the
> bandwidth type enum to the soc_data struct. This array expresses the
> actual hardware value limitations, not a factor thereof.
> 
> Use the clamp function macro to clamp the values between the minimum and
> maximum constraints after all the calculations, which also means the
> code doesn't write nonsense to a hardware register when the math is
> wrong, as it'll constrain after all the calculations.
> 
> Pass the type as the actual enum type as well, and not as an int. If
> there's some type checking that can be extracted from the function
> signature, then we may as well use it.
> 
> Don't needlessly explicitly cast return values to the return type
> either; this is both unnecessary and makes it harder to spot type safety
> issues.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



