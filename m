Return-Path: <linux-pm+bounces-36891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC775C0D092
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EC324EA85B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524A2F12CE;
	Mon, 27 Oct 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ft/HPJ7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B22BEFF2
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562933; cv=none; b=bELHfFpmi4NCYraeVWVzyorNqjXhDZnbTz79b2gEvqSGwkq9/ZS0HsftjW7V3Q7uHjVd+TT93LpAEkVNNDu/e/4VIo9yGURrOoqL+b2GXp4EbqQGNLoIbYWTm7zRgrwHdZXBOC123l1eD2ag0Q45+fqXeIdnLIcoqKJTEH6Xksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562933; c=relaxed/simple;
	bh=IexYyBUFGVqj56nMhFW49UCXf1rGo+YKZA9koYJgDw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UJvQJmGu8IV0oC9PKwtVKssGpoipaaQ6Yj97nXG956ZBD1hn7a6u0t1FYDQBOKs3JsN1FlTZZlIeONlBaZ8X66hqPWSizwHtNdSJ0bOeCuAIAY77fZfF0rfudt1XUaCYHwVBYMqCVjorl4BCm9h50n/+mzN2C1LVhphkh685K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ft/HPJ7Y; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251027110208euoutp010054286b7e64f02399cfca6b94098239~yVCaNbPQV1334113341euoutp01H
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251027110208euoutp010054286b7e64f02399cfca6b94098239~yVCaNbPQV1334113341euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761562928;
	bh=yKSoAYzsAkTVdUSfjeRUX+gYObcTUR5Pslm7NwedGLM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Ft/HPJ7YNwWECRELAlNw73YWWzq6in5prpYBuO6h2fEBag/XEuSTD2F/wi8lzofkY
	 8Nn8MpgwTetmr+S1fezmkqr2ahNNoVxEkPC73syjCGHAZ6kXNdq0WnT/T9euTVqCPn
	 u4ZWWOT56noIZokQuA0pbXM/4OU+ar42B4C+tWOc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251027110208eucas1p21dcf1e224465db221933aca7bae65cc0~yVCaBvSuz1350613506eucas1p2f;
	Mon, 27 Oct 2025 11:02:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251027110208eusmtip2811a11738e88ccd4f87527e549aa16de~yVCZn64751647516475eusmtip2o;
	Mon, 27 Oct 2025 11:02:08 +0000 (GMT)
Message-ID: <d376f705-bed3-4ca7-8448-b364e243f8b7@samsung.com>
Date: Mon, 27 Oct 2025 12:02:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] pmdomain: samsung: Rework legacy splash-screen handover
 workaround
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
	<andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <75884c14-8063-43cd-b0f8-da3db1ca3dc4@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251027110208eucas1p21dcf1e224465db221933aca7bae65cc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
X-EPHeader: CA
X-CMS-RootMailID: 20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9
References: <CGME20251024093617eucas1p2a84deaa88e39692fd4933d14684aaeb9@eucas1p2.samsung.com>
	<20251024093603.3484783-1-m.szyprowski@samsung.com>
	<cf9bc771-78a0-4439-a913-dfb8bd62c46c@kernel.org>
	<deeeba6b-af85-44ad-ad78-efa7e923621a@samsung.com>
	<8efa8233-6f55-4df7-9625-a7addc101ea3@kernel.org>
	<e8362b57-ffc8-4f2b-af03-ed37882844ef@samsung.com>
	<75884c14-8063-43cd-b0f8-da3db1ca3dc4@kernel.org>

On 27.10.2025 11:37, Krzysztof Kozlowski wrote:
> On 27/10/2025 11:33, Marek Szyprowski wrote:
>> On 27.10.2025 11:18, Krzysztof Kozlowski wrote:
>>>> If this sounds like a bit rude hack, then we can use
>>>> GENPD_FLAG_NO_STAY_ON workaround (like Rockchip and Renesas).
>>>>
>>>>> If these were different devices, we would need front compatibles, but
>>>>> since this is purely a bootloader stage, then we need a property for
>>>>> that. Something like regulator-boot-on.
>>>> Just to clarify - this splash screen issue has not much with power
>>>> domain driver itself, but a side-effect of old genpd behavior has hidden
>>>> this issue deep enough that it was ignored for years.
>>>>
>>> Issue is still in the bootloader and how the handover should work, so
>>> for me, since we do not have dedicated front compatible, property sounds
>>> reasonable.
>> The problem is that such hypothetical property would be rather a
>> properly of display controller, so it would be really hard to find it by
>> the power domain driver.
> No, just regulator-boot-on is not a property of the regulator consumer.

But regulator-style (regulator-boot-on) analogy is completely wrong here.

We force turning power domain off just to reset everything and ignore 
the proper hand-over protocol.

For product-like target one might want to have the splash screen 
displayed properly until userspace starts and such case would need 
completely different handling by the all relevant hardware drivers 
(display controller, IOMMU, power domains, etc).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


