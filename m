Return-Path: <linux-pm+bounces-36172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D3BDD907
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93BB04F5D51
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B78319609;
	Wed, 15 Oct 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RN3nQiyF"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4D3064AA;
	Wed, 15 Oct 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518731; cv=none; b=Bs4FmCZURfGnbOTYAFnCIhBf3sq6XDewPWysqXuQxbsmxlh8YbugNts2pQJs/+Kx7i9vkDrppyUiy/nUmNO1Ub3rNuIa8cJNs4AmyO1nRXZo2z4OiP5fvpfJodUfYM6PiG+Cg4y8jUWYXsBBsfSNUfDY7c2nejOKLxi7RtJOS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518731; c=relaxed/simple;
	bh=QAdqNSEgBGHVX/qNLhebNe+uGdl6xTXjyZ1RRQvJ4Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbCJXg4tk1pbE4T26nnDrZu5fVI5l2wTwNp7ZYIfxSMKa/YmhRSNPjtIolFMHFd7BO+LOE0cNWz1SLHcSorxUEmNYUX7M4PxVKA7gjZ+sy5W6tyP9Lu56ErzCAPAxVCjoXL5tPHPZvk7VNwokHs4JBGvzrVbMygspCbkGxmF8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RN3nQiyF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518727;
	bh=QAdqNSEgBGHVX/qNLhebNe+uGdl6xTXjyZ1RRQvJ4Vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RN3nQiyFJ6buk9Z+jA8ayDgIoLJGBNukuUNUoK0a7r3RUyYMMrgAt6Cg52FzXVqgp
	 oQfYv2GD7RAdAPwG4zUslrpf1UWlGX4JiJo52kfEbSwd9dEgaohMwQwXn8Y3TzgM5r
	 xzn0asGUn53DL0yH8oHjE+df1ugQc+r1yJQPmLFA9+Z4Yl2uvpasGH7iNjf+RqFavh
	 VEERtTiV5pJSuvqenQTHnzD8gIouNIipLbxtR8CT11S6tTn+d8hzwOUJPGbUgYsT7g
	 U1gjlbxtwF8BTbw0WnLH++6j9gSDVde0PBZM4L0QcH4k0NLvaX9WAfIxduQnJF25h1
	 cmK2NAS6WaAFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D285C17E12EB;
	Wed, 15 Oct 2025 10:58:46 +0200 (CEST)
Message-ID: <21691007-7622-4c45-9c02-011d44c97f15@collabora.com>
Date: Wed, 15 Oct 2025 10:58:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] drm/panthor: Use existing OPP table if present
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
 <20251015-mt8196-gpufreq-v7-4-0a6435da2080@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015-mt8196-gpufreq-v7-4-0a6435da2080@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 10:50, Nicolas Frattaroli ha scritto:
> On SoCs where the GPU's power-domain is in charge of setting performance
> levels, the OPP table of the GPU node will have already been populated
> during said power-domain's attach_dev operation.
> 
> To avoid initialising an OPP table twice, only set the OPP regulator and
> the OPPs from DT if there's no OPP table present.
> 
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



