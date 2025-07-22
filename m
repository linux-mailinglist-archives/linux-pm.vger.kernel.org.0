Return-Path: <linux-pm+bounces-31275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54FB0D777
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F25A1C25217
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7B2DE6F4;
	Tue, 22 Jul 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eXdbux7Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58A28A725;
	Tue, 22 Jul 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180702; cv=none; b=eNSPc0ptoaYgxK7u4pTjQ0BuVeK8PuZ1Mg8SSagTpGmspUWw0Kazu/kjC+/RoyP1J7oOqwkkyNWnwOJ7fug3ZkBCP13Wmqm25jBAaGr2XNo3wv67swfi+ZK4EIl0VyBDyUvQuhU50LfqDn6wwPF9PomvE/A1RVcGETzPn2ceiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180702; c=relaxed/simple;
	bh=bkY2GEXAbZCEgimSdKFm2IARS0ffaAm1hymKFyKVnv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZfNGvrpuBK7oJlfsbGG6QeZyd8AOfsq6qTegUKezeRXoga585kr0hNO9Feg/eE6WxCuW7E4z7FW/CWxSLUed0vzTRKsQ8v+kAOV64C5H/ZW3D8+X2xQUv8Z2JnL+tSMkVBmP58w/RiYyQq83U4ORzcy5dykZCnqLXHyUFnb3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eXdbux7Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753180698;
	bh=bkY2GEXAbZCEgimSdKFm2IARS0ffaAm1hymKFyKVnv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXdbux7QGObp+HZOOdFAxjOZIbimZVtKUGpGttgN9rUum33zjv7HhTR3SrOKrEJdi
	 2DtVVJqbiPby5tbabC6G6tSXm49COXRayntenGTka9I05bOYpYLKwyowdvpVqeC/T4
	 a5QWU2DOjmMPRGcdWi6e4eEyMhcjVLwKrwGYpMXs0W/rBHeNhImne8tCTdALWPExtX
	 0/VrL/Cg24AdWQ8LOZotmViIrpd+bTCF/U705jqr4NM5p9r6ZYaAmnqjFWTiPi21fX
	 nseJPXOlNyRwyo79RS6rdTSxGO138uwH58XH/W/m0AfQmAl2YptMjpXf0174UX+iGy
	 wPtOhZacXN/Wg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bd9c:eae9:88b0:783c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22DF017E0B72;
	Tue, 22 Jul 2025 12:38:17 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: angelogioacchino.delregno@collabora.com
Cc: andrew-ct.chen@mediatek.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	frank-w@public-files.de,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Tue, 22 Jul 2025 12:37:18 +0200
Message-Id: <20250722103718.31804-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <24c65ecf-ab89-4970-b2ae-00185259d359@collabora.com>
References: <24c65ecf-ab89-4970-b2ae-00185259d359@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 7/22/25 11:04, AngeloGioacchino Del Regno wrote:
> Il 21/07/25 10:14, Laura Nao ha scritto:
>> Add compatible for MT8196 SoC.
>>
>
> This is compatible with MT8186's layout - not with the others - and
> besides: "mediatek,efuse" is deprecated.
>
> Adding something to deprecated bindings is not even really permitted (unless
> there's a *very* good reason to, which you definitely don't have in this case).
>
> Also, this commit has no description - repeating the same as the title adds
> no information and doesn't help at all.
>
> NACK.
>

Got it, thanks both for the feedback - I'll fix this in the next 
revision.

Best,

Laura

> Regards,
> Angelo
>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> index 32b8c1eb4e80..e209a1132a26 100644
>> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> @@ -37,6 +37,7 @@ properties:
>>                 - mediatek,mt8188-efuse
>>                 - mediatek,mt8192-efuse
>>                 - mediatek,mt8195-efuse
>> +              - mediatek,mt8196-efuse
>>                 - mediatek,mt8516-efuse
>>             - const: mediatek,efuse
>>         - const: mediatek,mt8173-efuse 
>
>
>


