Return-Path: <linux-pm+bounces-27136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7120AB6D02
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19183A620A
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED82A27A451;
	Wed, 14 May 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RlY0MAC1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099335970;
	Wed, 14 May 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230240; cv=none; b=ebHuqXfV/JiCgAG486KROjPlAh2Mj2K1JXf6wmX93/8UyXrQjaUrgn+2m+W03QUAPyy22P0dmgCe445xXxQNmDCO+zURf0i0uPbeMrm8z/6b+f38AAbCUsl0mEkYOua5/PDH/tA1s72B71IOY6icogl6eLWRvWtBNUnI7rPumDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230240; c=relaxed/simple;
	bh=jhvYh/l6FiXcGjp04Rwh3X1CLo9llYiEmQf5JBD/Kf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiplUa0/Np2TLckx0aelS/xRDLKUGJIkmJG/9OK3ih2T/vQqjbojn5W/EE4yWRIoP0/Ub+b01Mw49xdgGLMFSZFtxlJXcTPV7eW/CTNFZ4rgGl90mdH3NTtjG6xz0CCj+xckDdZzTQq5yFYaNe6vMk9TBVSylq3UQyS114zxZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RlY0MAC1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747230237;
	bh=jhvYh/l6FiXcGjp04Rwh3X1CLo9llYiEmQf5JBD/Kf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlY0MAC16U67eamGI5lpVkLGVIjqsUpw9q7ecO3jcwQw2aExIhcaen14DlGvFdR01
	 oroEDNOK1JaRGBIqz+l8x2ZFdxUu+ytw3oT7h3DjeNQx3QRnl4n84ezpEEmzUd14je
	 MjuSRwAj6OL4IO2bUaUqaqN5s8sEZpoW2fGUhG/zmFhG6e4rO2t3Z18Qfb4nh9jyX0
	 Kl8JBQGVCiMifSDe07wa4In7HUrWCWpfrbvTD21WuAV7rwkx33xK5orSGX8bGdZXUh
	 lU9PAlao3Tw09FF94MjtAKpM3ozVmjy3Lihmb0naFMYNQa3obHTEoX0J/JVyDtUxv3
	 QAWD64rvgX3xg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C17F17E07C9;
	Wed, 14 May 2025 15:43:56 +0200 (CEST)
Message-ID: <6fc2027b-2afc-433f-a9af-c458221c96ce@collabora.com>
Date: Wed, 14 May 2025 15:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: mt6359: Rename RTC node to match
 binding expectations
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/05/25 10:19, Julien Massot ha scritto:
> Rename the node 'mt6359rtc' to 'rtc', as required by the binding.
> 
> Fix the following dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
> any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



