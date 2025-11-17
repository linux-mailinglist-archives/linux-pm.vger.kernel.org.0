Return-Path: <linux-pm+bounces-38123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5755C642FC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7D47365540
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDCF330321;
	Mon, 17 Nov 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZP7xUdZn"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C0330307;
	Mon, 17 Nov 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383191; cv=none; b=CujIRuPWS7az78n03QGfPg3CkVEkowXzrk5dV4+yX4mMrzh0eDc9hEZACZ6nUeWd+YoYDkl+IMwBfRLN6eEppg1Yk8lAjO95iF3XEyWQBKD0K3p1ktnVNiwjen9u0gyQHnyx4e4cwk00I7F8MmXoHvTlsYp1VmC+sBH3XRvfsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383191; c=relaxed/simple;
	bh=PB0+E1D0L9+GU+4xrKEDPFnH7XAiL88Ghkuup4edRvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqbdWyU4ecevh6aoo+zaAqQo28Lpb81diWvbuUcYIaOHC1MATv/J247QsSM7IFr58Wd5jqYnSwUucMgK79lguYjroiOqgGS1CpEdlY9uVleTBxWIn+gkQbGy5kEkDmuM5DCqmD/xvDGGJ2hFSvBsWF2OJhIuGPUqZMjI6WTOSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZP7xUdZn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763383185;
	bh=PB0+E1D0L9+GU+4xrKEDPFnH7XAiL88Ghkuup4edRvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZP7xUdZnA+iY2xvQ8ruQCK64QTmNTmonLAj+Vbid/uSAR+6FRmf5Eq0BP5K31uPGT
	 rqUcz219GgcDxiw+FxHk1dZY2YBIdkMK54oQNItk8i7dc64jZeOXpdCAqh1CmCy+NT
	 5hFZMneqk/XMQ3B/GuBmDwgLET0MaI481++oUiS2z2623N73G1UyjbvOzdqPdHFxom
	 ZY0CYo9c/18qEsBGpQHAVV6jy/psfKck9AwYTgTToI3uydfMJRoNqaKaXF+WMswgJ4
	 EB//qy4LohQqYIm9zJPersg7sfaP8GTc12OKs+Syew73dJNJXMCBJJ2Whdtwdg3aSA
	 KAL5YuMdDH9kA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3CF917E009B;
	Mon, 17 Nov 2025 13:39:44 +0100 (CET)
Message-ID: <0e3c692f-a6ef-4d1a-a412-a57b0a0ee8ee@collabora.com>
Date: Mon, 17 Nov 2025 13:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] interconnect: mediatek: Don't hijack parent device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-12-b956d4631468@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251114-mt8196-dvfsrc-v1-12-b956d4631468@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/25 17:54, Nicolas Frattaroli ha scritto:
> If the intention is that users of the interconnect declare their
> relationship to the child icc_emi node of the dvfsrc controller, then
> this code never worked. That's because it uses the parent dvfsrc device
> as the device it passes to the interconnect core framework, which means
> all the OF parsing is broken.
> 
> Use the actual device instead, and pass the dvfsrc parent into the
> dvfsrc calls.
> 
> Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



