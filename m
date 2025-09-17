Return-Path: <linux-pm+bounces-34867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E37B7EA56
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAAD3ACB5A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C48328983;
	Wed, 17 Sep 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G5lj8mwg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AB328965;
	Wed, 17 Sep 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113413; cv=none; b=HVNxptdd+Yv3gDRaa0t4lPVHdFXEsYPGOQqt9ltcuLjbK2NMpYP3Jer/zDpPjPzRZNPx3PULEbgGN33s/Ay3pZCOtGQdEBP1qNfXb/gWWC7ZNMFibXqWWgDjTXyHdBuyWycjxB8B2XBJNKf+aWMma/WKy6NQ4cI5KVxIg6oBeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113413; c=relaxed/simple;
	bh=Zzu47Spqkx9PBO3hTkWFHeC/kbz1j4gqkoIEVOrafyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr9oXXfPDDHFkaXl9N2gaTpFPyYWU6m/fAxsRNvApf6oiPn+enywYU2weRVxfgHnwjJ6c1ShRBmK9UaxGdqXj3vLb0GElJW8dpr44UsGp6ShRZTXz+EFMop6ZuYYTet6GvvyVFgKxmUd2VjqiZ5cQeecET7RnTqCjc7FeYU9lvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G5lj8mwg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758113409;
	bh=Zzu47Spqkx9PBO3hTkWFHeC/kbz1j4gqkoIEVOrafyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G5lj8mwgzYOBKZYPa16TeMLmQUonfUg5YrBUoPVrg1u+zpcWnBixbqS0A3wcteZC8
	 +f9vEcVBBcOdwb8XhfXP07lARnpxRBKk+nCwEfUNt6lvMjXRbKn2TMP/ouU41jdp/w
	 6Qm/t6yanrmwQYQfYFdBBrlTqtyEuckkxt4xwjClQXw+6UWyssj8czCufSj7ynhIwR
	 8KnOs7UskI/UiQkPiIwOP6GnOY6t4JzXmqraLWuhyQMgkHoOteDxEpnMXYwJiSTV2d
	 1JTi68Nm95/eE8tHh6YXbzhlDvdk/lWvkvPxotYnguOZ9RPk7/1gadXKh+7nOmGHAN
	 F9f4M++sZDsFQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A0D3217E0A49;
	Wed, 17 Sep 2025 14:50:08 +0200 (CEST)
Message-ID: <69c4f96b-8f47-493f-a236-5338c34dc100@collabora.com>
Date: Wed, 17 Sep 2025 14:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] mailbox: add MediaTek GPUEB IPI mailbox
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-5-c4ede4b4399e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917-mt8196-gpufreq-v3-5-c4ede4b4399e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 14:22, Nicolas Frattaroli ha scritto:
> The MT8196 SoC uses an embedded MCU to control frequencies and power of
> the GPU. This controller is referred to as "GPUEB".
> 
> It communicates to the application processor, among other ways, through
> a mailbox.
> 
> The mailbox exposes one interrupt, which appears to only be fired when a
> response is received, rather than a transaction is completed. For us,
> this means we unfortunately need to poll for txdone.
> 
> The mailbox also requires the EB clock to be on when touching any of the
> mailbox registers.
> 
> Add a simple driver for it based on the common mailbox framework.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



