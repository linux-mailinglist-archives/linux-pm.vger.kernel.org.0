Return-Path: <linux-pm+bounces-23350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667DA4D560
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056BB1883269
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7351F7914;
	Tue,  4 Mar 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="adrHId7U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEE1F4C9D
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074773; cv=none; b=d/Gxmo1KGaijWJEyY89QURXRa0WW0n7J/eJVZJEVJhcqS9VocEWWtitDBB0gZCnjib/vMql9hDYj01IPTGSixp93igfuvC2WGHMMR9V3YdT6luBj0Fw0eqY1IwGxMrmhYdHhaenCWhTFG1qwzITEimGIvembNMBnPkBx94d0iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074773; c=relaxed/simple;
	bh=Pdi9LiPW2XDqWccj0IQnT0WEQyNxj1rc9Fh524oc0Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=X0QbKwtEKNvaWU/tTh5glg3aIaNcV8lZS+1hPcff1p1SFR9EybUjo/PjucDUJjIL6dNcUFLnVQNjLfpPscrVQOf6Q6BHY01diT5qHdeFKSJuF67qEymWDSE4Ma+dLHXxUcHhehVl/KWISFFLM4SJwW2je0PAqx9PsiTT2xMvjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=adrHId7U; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250304075250euoutp015bf1d58f520f445ce985c876b92fed4a~pikdnvkn60180301803euoutp01B
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 07:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250304075250euoutp015bf1d58f520f445ce985c876b92fed4a~pikdnvkn60180301803euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741074770;
	bh=lea+ualRj8bz1DmBFIqvryrAEtTAwUiOAMc/0EqaREQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=adrHId7UICeA7/DFlY7GUV1AoEnJjFAoDq05EhUfKMMwLS20bS1fsiFByUDhQQri6
	 LYjDCmonE+4dvus6BOC1a/wq3k8RrYnEDEsvAGwOLJVQliFYXDN1dYgzekgLYkK3D2
	 yW+sKKLwOabTXRG3ZIRVS6pEzELHBObb7jy4E1Og=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250304075249eucas1p233c07fd6fccde4cb2074a8ea69813087~pikdEUWMq0502905029eucas1p2-;
	Tue,  4 Mar 2025 07:52:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.A8.20821.151B6C76; Tue,  4
	Mar 2025 07:52:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250304075248eucas1p193463e8d646ef3fcda680ca785579934~pikcZBp7w0034500345eucas1p1g;
	Tue,  4 Mar 2025 07:52:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250304075248eusmtrp195ba42f7a1a1786cab2e20ffc929430a~pikcX6xRy0401204012eusmtrp1E;
	Tue,  4 Mar 2025 07:52:48 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-7a-67c6b151ec14
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.DC.19920.051B6C76; Tue,  4
	Mar 2025 07:52:48 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250304075247eusmtip19a6fe9a7de8dd05807269c046561fe49~pikbfaLZv2935529355eusmtip1O;
	Tue,  4 Mar 2025 07:52:47 +0000 (GMT)
Message-ID: <08e5ffb9-2187-42b6-8090-9922b349fe2a@samsung.com>
Date: Tue, 4 Mar 2025 08:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: firmware: thead,th1520: Add support
 for firmware node
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <377951ad-341f-4e19-a582-a534567dc466@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7djP87qBG4+lG6x/KWfx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZnD+/gd1i7+ut7BaXd81hs/jce4TR
	YtvnFjaLtUfuslu8vNzDbNE2i9/i/54d7BbH14ZbtOyfwuIg7PHm5UsWj8MdX9g97p2Yxuqx
	aVUnm8eda3vYPDYvqfdoWXuMyeP9vqtsHn1bVjF6XGq+zu7xeZNcAHcUl01Kak5mWWqRvl0C
	V8aTiWYFM7gqPrzzbmBcytHFyMkhIWAi8arrPUsXIxeHkMAKRonFhy6zQzhfGCVmzj7DDFIl
	JPCZUeL33xyYjhtzXzBDFC1nlJjW8RKq/S2jxJ7ui2xdjBwcvAJ2EvPuqoI0sAioSMx48oAN
	xOYVEJQ4OfMJC4gtKiAvcf/WDHYQW1ggQeL2+SawoSICO5gkrrzZA+YwC2xklFh39DVYB7OA
	uMStJ/OZQGw2ASOJB8vns4LYnEDLLh/9xQZRIy+x/e0csGYJgVecEtObH4JdJCHgInFxswXE
	C8ISr45vYYewZSROT+5hgbDzJR5s/cQMYddI7Ow5DmVbS9w59wtsDLOApsT6XfoQYUeJCa/b
	mCCm80nceCsIcQGfxKRt05khwrwSHW1CENVqElN7euGWnluxjWkCo9IspFCZheTHWUh+mYWw
	dwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHn63/FPOxjnvvqod4iRiYPxEKME
	B7OSCO+t9qPpQrwpiZVVqUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgskycXBK
	NTDFGf6VjeLucM/6Vcn0d3GywORVvWonz/dzbvkat0Okb9vxyf165pbO+QEBDcab+c6uefr/
	osFhezmpQ0sny6n6xkhOXPX77hdjac5Sfq65//p14/ss6tKE7p1vmiS24xmrTTzf04qNpkav
	Jm2SSJmceiNy5fad+lt651kLLOaZP+H35++KFXe/7l52XnEyz03h67NehvotLdhbuO65yjzm
	LrNT/7YZBx66KNaxL3+nKtcCvcVRdyInFv3rOfRY3/20W+bd6wLT2gStRK1rt3Vv5DI8qv+y
	qcbg5pVzv7n2aWZlNt/Zo3HZQeLsCxXFhdN73ksK5C3wuCQzUVWoZwsPn8JELU7zai5mx72y
	stVKLMUZiYZazEXFiQAm+R8GBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Xd2AjcfSDT7MNLR4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gszp/fwG6x9/VWdovLu+awWXzuPcJo
	se1zC5vF2iN32S1eXu5htmibxW/xf88Odovja8MtWvZPYXEQ9njz8iWLx+GOL+we905MY/XY
	tKqTzePOtT1sHpuX1Hu0rD3G5PF+31U2j74tqxg9LjVfZ/f4vEkugDtKz6Yov7QkVSEjv7jE
	Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PJRLOCGVwVH955NzAu5ehi
	5OSQEDCRuDH3BXMXIxeHkMBSRomZi5YwQyRkJK51v2SBsIUl/lzrYoMoes0o8XvdZtYuRg4O
	XgE7iXl3VUFqWARUJGY8ecAGYvMKCEqcnPkErFdUQF7i/q0Z7CC2sECCxO3zTWDLRAR2MEkc
	7dsBNpRZYCOjxMLvu9ghNsxgljhxbg1YO7OAuMStJ/OZQGw2ASOJB8vns4LYnECbLx/9xQZy
	BbOAusT6eUIQ5fIS29/OYZ7AKDQLySGzkEyahdAxC0nHAkaWVYwiqaXFuem5xYZ6xYm5xaV5
	6XrJ+bmbGIHpYduxn5t3MM579VHvECMTB+MhRgkOZiUR3lvtR9OFeFMSK6tSi/Lji0pzUosP
	MZoCA2Mis5Rocj4wQeWVxBuaGZgamphZGphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPHxMEp
	1cDEXyi9bJfB3SubL27/eXgeX+ONvfUub1bFWNSvuxG+97F5aWDXUrWZJxZkZxi/+9nt8Xju
	3J/GTIEmDBNXc7au3r6jfXpXZ8PRuRv9Vk8xeOTTf/Km5PI9V7Lzr5i3da5fdPVqsabX27AT
	u3vf2hst28lz693U+uTYVVYrgp54xnWG8MRc2iEQzZDx9cd9aQ7fg5PyWo/GiJ40Wx3/Znav
	cmP7knstR46FvA9WOpdsvObne5WrPjuFtzG+4nu2TzZA/eK5a+4uRtNd3npzvbrwOvT4xynJ
	NldEmouaXNaHe6xIOhG2tTL9x8mVs7csv2qsyHBAq9d+boTamk8LxGKijCWnvdSUuPf+rJj9
	zOnL5yixFGckGmoxFxUnAgBoKA+fmAMAAA==
X-CMS-MailID: 20250304075248eucas1p193463e8d646ef3fcda680ca785579934
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f@eucas1p1.samsung.com>
	<20250303145901.446791-2-m.wilczynski@samsung.com>
	<edb3dd6e-8b56-42b3-8bb2-8ed7ad186b75@kernel.org>
	<8dcdd2ec-e4b6-4fc0-be50-12fe187cd5e0@kernel.org>
	<99fcf36f-7fed-43e8-a94f-47563ab00fc6@samsung.com>
	<377951ad-341f-4e19-a582-a534567dc466@kernel.org>



On 3/4/25 08:45, Krzysztof Kozlowski wrote:
> On 04/03/2025 08:43, Michal Wilczynski wrote:
>>
>>
>> On 3/3/25 18:46, Krzysztof Kozlowski wrote:
>>> On 03/03/2025 18:42, Krzysztof Kozlowski wrote:
>>>> On 03/03/2025 15:58, Michal Wilczynski wrote:
>>>>> The kernel communicates with the E902 core through the mailbox
>>>>> transport using AON firmware protocol. Add dt-bindings to document it
>>>>> the dt node.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>>
>>>> How is this possible? That's v1 and I never review outside of mailing list.
>>>>
>>> OK, I found v5:
>>> https://lore.kernel.org/all/20250219140239.1378758-4-m.wilczynski@samsung.com/
>>>
>>> so is this the same?
>>
>> Yeah, I thought by splitting the patchset and creating new sub-series I
>> should start versioning from v1 again, and leave that bigger patchset as
> 
> What was unclear in my "keep versioning and keep changelog"? How this
> can lead to "start new versioning"?

OK, my bad misunderstood you. I don't want to spam too much so maybe I
should wait if there will be any comments before re-sending with the proper
changelog and version.

> 
>> a reference, I've linked it in each cover letter for each sub-series.
> 
> Best regards,
> Krzysztof
> 

