Return-Path: <linux-pm+bounces-30272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87662AFB1A1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98F33AD7D4
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96535293C50;
	Mon,  7 Jul 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oz8v7duM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60621CA1D;
	Mon,  7 Jul 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885396; cv=none; b=EqMofoGK80gJxIZvnsKlR+0ZjDvTqLDkativnXkIVmw8+Z350eXJsI3IdA0y8oz68kiYzqaptEDwwrB+8PJfrLL7EzjMbQDqz7iTv1CYdYOH+Mzh3s+6HiyKx0exleP7VV1Sat6Egv7xl6rL5SKnGHYjjOyo3TRcv0I3mTqGDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885396; c=relaxed/simple;
	bh=utlkw0o5NARZFk83JwXbp9lywwmgReSbAqfiKiWu4X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYMUrI6Caz3hmlb+MbnV6Et8TYGg5sRESqJVBmS1mr2WCzOaA6wBMkDT75/q/YNo1b5sgyyZBXwuihX/jGD0kUiQJiECeCw2sDnsyh62jSGTfYsORPYOIPx94zM4e4iR8O5LNnpZChtFbwMutwUO3hgXrdhLVjfhtBm1UPWkSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oz8v7duM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885392;
	bh=utlkw0o5NARZFk83JwXbp9lywwmgReSbAqfiKiWu4X0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oz8v7duMOV+G+tHbirtD/TgsoaVCm/SBdJXqX0p0ME6pE/uG9hl2Gx8g81dhEP2pg
	 5Ptd7ycGg754PAl23h2yWs7NhLW5sip1kvKL2cRUe0BSvBP1j4i/GOx04Cxwu1uG4E
	 fujalaUTbE9aEAMNP4s5sDJY4A+cPfEA9OrAgpEHX6YcJ1/zDjh9VX1M74RMbz0SR+
	 /UuWnlvw5F29HFVj7EIuxcXqzssN4EPFIa6CkJLLDkb527++3XPGFnTU9YFJbOSc3h
	 jE061XUCbiuFsosE1XDZoxEu9gR5DkwwazcHtt53BVwsI1Wm7q+eFX1phnLk59vdk+
	 UA5xhFzFB1z3A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0089017E04EE;
	Mon,  7 Jul 2025 12:49:51 +0200 (CEST)
Message-ID: <36353ccd-07fc-4415-9db2-54977b25054a@collabora.com>
Date: Mon, 7 Jul 2025 12:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] pmdomain: Partial refactor, support modem and RTFF
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, ulf.hansson@linaro.org, y.oudjana@protonmail.com,
 fshao@chromium.org, wenst@chromium.org, lihongbo22@huawei.com,
 mandyjh.liu@mediatek.com, mbrugger@suse.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
 <5bfcd5e059e86a96807426bfc6543209d09b557f.camel@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <5bfcd5e059e86a96807426bfc6543209d09b557f.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 03/07/25 20:27, Nícolas F. R. A. Prado ha scritto:
> On Thu, 2025-07-03 at 13:02 +0200, AngeloGioacchino Del Regno wrote:
>> This series is a subset of [1], leaving out the Hardware Voter
>> specific
>> bits for MT8196 until the discussion around it reaches a conclusion.
> [..]
>> Compared to v1 in [1]:
>>   - Changed mediatek,bus-protection to access-controllers
>>     as suggested by Rob (thanks!)
>>   - Added commits to document #access-controller-cells on all of
>>     the access control providers
> [..]
>> [1]
>> https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com
>>
>> AngeloGioacchino Del Regno (10):
>>    dt-bindings: memory: mtk-smi: Document #access-controller-cells
>>    dt-bindings: clock: mediatek: Document #access-controller-cells
>>    dt-bindings: power: mediatek: Document access-controllers property
>>    pmdomain: mediatek: Refactor bus protection regmaps retrieval
>>    pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
>>    pmdomain: mediatek: Move ctl sequences out of power_on/off
>> functions
>>    pmdomain: mediatek: Add support for modem power sequences
>>    pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
>>    pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
>>    arm64: dts: mediatek: Convert all SoCs to use access-controllers
> 
> As already pointed out by rob's bot you're missing adding the
> properties to
> 
> mediatek,mt8195-sys-clock.yaml
> mediatek,mt8188-sys-clock.yaml
> 
> on patch 2. But other than that, for the whole series (since the tag
> wasn't added from the previous version):
> 

Oh I did, trust me I did.
But then I forgot to squash the changes in the patch that I've sent.

This all means that I need more coffee: fixing that now (both the patches
and getting more coffee :-P).

Thanks btw!
Angelo

> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 



