Return-Path: <linux-pm+bounces-21022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D258A20DD7
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941403A61C4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF91D90DB;
	Tue, 28 Jan 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eKfbjJF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D71D63FD
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079989; cv=none; b=Kj30WKaAQ+Vr8ChP2xOYgkSBnw3wdZPqphtLzeUhJEC3eqVreFh8ME5//mhI847c1E3Hf4vOJLOrtZeR15Au+hSsoHwcio8eql5CJRpBEdNypi0pNSz6enQS0VnBlxyNeJNO6hHwSC4nyCTb1pytipkcj3/PyKaYN3M9octMSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079989; c=relaxed/simple;
	bh=AyGYx44x/LxsX+GE0pirsfezoMh4jSTmt8+h1nxcqFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QWgj88zjFibcOAWJctws2fVHT5mkGmLa9UJSVyUknKpZdaxMwhUlcDNNE0L/jcIqW46Np+5XYYmTlalcTJjfkZeFkCVAG6/dQY4tQh3/nORLEWn4U5hFSqkFqyBVeRLkF7evi7gmUelFH1kUjBh68/fhcLy0j+GBpOP5paLl7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eKfbjJF3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250128155944euoutp029fc112d9ad6582abffc00f34e460dc8a~e5omVSQR_2663826638euoutp02K
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 15:59:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250128155944euoutp029fc112d9ad6582abffc00f34e460dc8a~e5omVSQR_2663826638euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738079984;
	bh=iwJ+epY4nSd+sLjdpwzOYTKuCc1d7Es+yGTdW2i3PBc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eKfbjJF3lyf5iEGiWw8QUA/EOlL4r6JQPwua64OaPT4xTF6Po1YRMHp+GiLPxUeyz
	 LN9skB1H+8gcw4TNhrRhPJRqEao6/oEeS8CA/8OqoIsDhmG90RbrIoRr7sB6jBYhqy
	 oyntdtYJpp0x99FurAb3VtvHbCyMn1x6bWe0DoP0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250128155944eucas1p2d96354f049a647c89aa1e1cd9abac150~e5ol2hEv-0796807968eucas1p2h;
	Tue, 28 Jan 2025 15:59:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.1E.20397.0FEF8976; Tue, 28
	Jan 2025 15:59:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250128155943eucas1p2a013a245dc7ebb3789dbd935ac4227fc~e5olaK1XY1919719197eucas1p2t;
	Tue, 28 Jan 2025 15:59:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250128155943eusmtrp2555de54ab9e83820cf9f12f834b2aa38~e5olZJVJW0160501605eusmtrp2L;
	Tue, 28 Jan 2025 15:59:43 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-45-6798fef0b33c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.CF.19654.FEEF8976; Tue, 28
	Jan 2025 15:59:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250128155942eusmtip272ccc759c57bd6953e7f8d3ee7843ec4~e5okLEtjt3036030360eusmtip2b;
	Tue, 28 Jan 2025 15:59:42 +0000 (GMT)
Message-ID: <4c8a5979-c0e0-460f-9809-4cf8b10e40ce@samsung.com>
Date: Tue, 28 Jan 2025 16:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 05/18] pmdomain: thead: Add power-domain driver for
 TH1520
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFrKKZ4RL5y+sCKAOK71ap7O3aTTc6rY9NrvcHt4hh6EVQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVRTdRj2d+/dvWOewWWg/DKLwr6wAo04/lIOSgc696gds0g9Hg1W3IbJ
	19lAjegEOBaDUYAIY0AzQOXQAMOBgOOjSQwIl2IC6YYrlQJBvqTEjOV2qfjved/3ed/nfd7z
	8nGRgVzFPxCXyErjxDE+pIBo7Jo3vzy1oJasO3l9OeoeLMdQw18aCulazRjSdpp5aLhfj6Gf
	5iZJVHv7EoV+b00j0EBVGYWOdtWRaFQzTKJp1TAPXWkpJdFsTidAjbNyEtV0Win09XQDgSqb
	WgBSKE/x0OXeMGQd7ibQ6BUVjhQaN2Q3NFFoYeBbApXcbaeQfjyPh0w1u5G8vYDY8gQzOZRB
	MeOjowRzIfMexbT+cYJgmjVWilE19wGmvlpJMpYBA8l81bOTuZFtwpizlZ8x8poujPny73XM
	ZNtVkvlCXw2Y/qOD1FuivYKgKDbmwCFW6h8cKYi+WlRPJqQJjxjn2olUMCPIAnw+pF+FXWfC
	s4CAL6KrAPx54TLOBfcAvDtowrhgFsCC+WqQBVycHb35ZQRXOA2gvWhokTUBoPXSQ56DJaSD
	odJi4Dk0CPpZaFQncWl32FN8i3DgFbQ3vHFNTTmwB70TXuyxObEn/QI0/PIjzzETp8t5sKeh
	wtmA017w2i0t5sAk/Qq0ndY6tVweNVsqCjGO4w3PTZQ6PUD6ogB+YzmFc2uHwtJ8yyL2gGMm
	PcXh1dDezA2FdDy0NcwsclJgs8q0iDdBi/kB6TCD076wrsWfS4fAC2NlOHdHVzg04c6t4Arz
	G4sW00KYqRBx7OfgcVXOf6LmqkYsF/hollxFs8SkZokZzf+6JwBRDbzYJFmshJUFxLGH/WTi
	WFlSnMTvg/jYevDowX9YMM01gaqxaT8jwPjACCAf9/EU7jerJSJhlPjjZFYaHyFNimFlRvA4
	n/DxEpa3Z0hEtEScyB5k2QRW+m8V47usSsUKYCWw2cZRtlUZ5Jr34YRvX2FH8p0QccV+a1t3
	WGim3GNj8tanttP3w4LTjjw85oUpI6OeH9p2faDwpcCPXH5zT10ZUGL/lNQF5q5+cYtQTeii
	ff3k3zfalqUff1sYuSbjcGyYfSHFl8mZcuvNDdq348yDKa1i2yevu54XpJzsdzMa1kzq1r6W
	oE3X1itaSLbcs26lPq9u3H1X4tMl9zePzC/L/jwsZLdufQQ2dqe2f+sbEcKUd2qbdxQvrx0p
	OD81s2Gj/x5cFv5Yeltivzr1zxXjN29vPjQTGZgYcI4OfWbq5tnvijtG3uO9v/dg3Lv1bb9u
	wjdgu/pC3yzs0Hc/6R0+uW+PDyGLFq9fi0tl4n8A4DKPEk8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xe7rv/81IN1j0VcvixPVFTBZbf89i
	t1iz9xyTxfwj51gt7l3awmRx5et7Not1Ty+wW7zY28hicW3FXHaL5mPr2SxezrrHZvGx5x6r
	xeVdc9gsPvceYbTY9rmFzWLtkbvsFgs/bmWxWLJjF6NFW+cyVouLp1wt7t47wWLx8nIPs0Xb
	LH6L/3t2sFv8u7aRxWL2u/3sFlveTGS1OL423KJl/xQWB1mP9zda2T3evHzJ4nG44wu7x95v
	C1g8ds66y+7Rs/MMo8emVZ1sHneu7WHzmHcy0ON+93Emj81L6j1a1h5j8uj/a+Dxft9VNo++
	LasYPS41X2cPEIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcks
	Sy3St0vQy7g6fRNbQSNvxaGv+1kaGD9xdTFyckgImEicmjSXpYuRi0NIYCmjxMJ9T5ghEjIS
	17pfskDYwhJ/rnWxQRS9ZpS4erqfCSTBK2An0XlnD2sXIwcHi4CqxKEZpRBhQYmTM5+A9YoK
	yEvcvzWDHcQWFgiUOHvyAZgtIqAhsefheVaQmcwCi1glthzazw6xYAKTRN/+c2wgVcwC4hK3
	nswHW8YmYCTxYPl8VhCbE2jSncXTmEAWMwuoS6yfJwRRLi+x/e0c5gmMQrOQ3DELyaRZCB2z
	kHQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZiyth37uWUH48pXH/UOMTJxMB5ilOBg
	VhLhjT03I12INyWxsiq1KD++qDQntfgQoykwKCYyS4km5wOTZl5JvKGZgamhiZmlgamlmbGS
	OC/blfNpQgLpiSWp2ampBalFMH1MHJxSDUy54RXrPb37FvAFxDRwFD9ccahDuchNarN4smz7
	EfkSpRwZB8Y911dEiyXs0HeMXFksxjuv2fJW4G+eK/rHBfPZxTPcmi7uYBetnBVwee1yxg9f
	t/k2vdKyYiysOOe/Q3XuhL/CRwUquLqi376e7eQY9v75tH0+exZHKa2f09l/47nTDfX6cE1p
	vvvGgrF/L37Rt+Z/bagZ+pXz1o70JAdfo7n/Qssq1if+/aBy0mjCnRnL+Rne+fluWXBc3CYw
	dP+LHJE0Hx0J/mn/M9R7r0+J+CL0zvTp8xmNCaJpS2tVXZW2u4cdVH0yrVyy1OtGgm7DxwKB
	Df3OXHHNO6/Uxl78wnVvlaRUzO2mbS4flFiKMxINtZiLihMBosuwKuIDAAA=
X-CMS-MailID: 20250128155943eucas1p2a013a245dc7ebb3789dbd935ac4227fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0
References: <CGME20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0@eucas1p1.samsung.com>
	<20250120172111.3492708-1-m.wilczynski@samsung.com>
	<20250120172111.3492708-6-m.wilczynski@samsung.com>
	<CAPDyKFrKKZ4RL5y+sCKAOK71ap7O3aTTc6rY9NrvcHt4hh6EVQ@mail.gmail.com>



On 1/21/25 10:55, Ulf Hansson wrote:
> On Mon, 20 Jan 2025 at 18:21, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> The T-Head TH1520 SoC contains multiple power islands that can be
>> programmatically turned on and off using the AON (Always-On) protocol
>> and a hardware mailbox [1]. The relevant mailbox driver has already been
>> merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
>> Introduce support for T-head TH1520 Mailbox driver");
>>
>> This commit introduces a power-domain driver for the TH1520 SoC, which
>> is using AON firmware protocol to communicate with E902 core through the
>> hardware mailbox. This way it can send power on/off commands to the E902
>> core.
>>
>> Link: https://protect2.fireeye.com/v1/url?k=aca9147a-cd220149-aca89f35-000babff9bb7-dfbb0fd97ae06334&q=1&e=7a720b7b-4489-48b9-b901-404180e7bc23&u=https%3A%2F%2Fopenbeagle.org%2Fbeaglev-ahead%2Fbeaglev-ahead%2F-%2Fblob%2Fmain%2Fdocs%2FTH1520%2520System%2520User%2520Manual.pdf [1]
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> I guess this depends on patch2 and patch3. Not sure what's the best
> way to merge this, but I can certainly funnel them all three through
> my pmdomain tree if that sounds feasible. Just let me know.
> 
> Kind regards
> Uffe

Thanks Ulf. I've made some changes based on my discussion with
Krzysztof, so I'll hold off on adding your Reviewed-by tag until v4.
Once we've addressed any remaining comments, it would be great if you
could take the firmware and power-domain patches through your tree.

> 
>> ---


