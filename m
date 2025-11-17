Return-Path: <linux-pm+bounces-38121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B7C6422F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAB4ED697
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA5317707;
	Mon, 17 Nov 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lQ05Haa5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4530ACEB;
	Mon, 17 Nov 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383127; cv=none; b=uTnjp29e8zj6+n9u3iSSprJRBoQFkPGeUfMhiymtAIzt6nS9pJ4TC4rbC+frW+o99SumkhJf7ZBKCdfA8tyK7QA5qgsKsXTxpJ072BNkSrY6YyFsI48sRdvz2y1ABB2FBAq6x7y8yOscM2f8TJvLRDRp7gW/L4M+Je70I8DDdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383127; c=relaxed/simple;
	bh=n+whlhVXGNmROQDHpFtUuk6MoZNagUCrrAscIOv6pMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvlDGeJhZDDq7DYbBRObcHkO5cwft7GiwXCSTIBpEdWlbCnNJaHWpNfYsLKe81gmGWUUY8StnzSNtyjfUw3O4IuGs49a6uW65VVXW9vOnDgiBKlvTW0gkJXg4qkteKAxFXov8Akb/QQE2IBRhyOj63+DvMv2y17hEfp3dMWGMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lQ05Haa5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763383123;
	bh=n+whlhVXGNmROQDHpFtUuk6MoZNagUCrrAscIOv6pMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQ05Haa58fPVLNVCR1XlSb8ov0bHY6rJxrvBg/wn4n+wcriVuIiExdEWtT2WUG1jl
	 dg4bug40KDpd6wp0hoFqE7d33SgxVd9GaFIxlcfIeAWmAZ5GWgmhLCVCP15NRDdtdR
	 Hl1FVirpj8eGOk5TfWm9kvRjK1ihWmEb7c7K+TsMVI0+tKXDHTI6+Zry+cjxiOUAQQ
	 4dguhNic9duRUhLoUtWVDWeD1uFYFn3ZpQgJSI0kiqvgBm8fhCF75SvDrxhuJNqLQn
	 TGzvhhNrF/TLH9VkLQbUZjVZ7o5i0HnRA1DgpIHVtLy3GcjJTuxSKbzqxvYfTokLq2
	 obgvmBaWKvUGQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D78FA17E1249;
	Mon, 17 Nov 2025 13:38:42 +0100 (CET)
Message-ID: <f63c1702-e847-4c45-bf9a-a4985baff1b7@collabora.com>
Date: Mon, 17 Nov 2025 13:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] soc: mediatek: mtk-dvfsrc: Get and Enable DVFSRC
 clock
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-9-b956d4631468@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251114-mt8196-dvfsrc-v1-9-b956d4631468@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/25 17:54, Nicolas Frattaroli ha scritto:
> The DVFSRC has a clock on all platforms.
> 
> Get and enable it in the probe function, so that Linux's common clock
> framework knows we're a user of it.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


