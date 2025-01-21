Return-Path: <linux-pm+bounces-20777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A60A1874E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7DF167091
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E81F708D;
	Tue, 21 Jan 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="asdrDcVW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A591F4E2C
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495076; cv=none; b=J55FCciosVcPJcnljV5WwES59MD/3/YZnM1cLKLJe0uBzQIDpHzbRxwAy+J4zBH5Xwd3K+QE2rT8piKsxgUc6sUsXncLB+WY5l0rg6rZZqe0bUMyPiJJ9AmOmdOadwN2cl2iEu+6Fc+B4nyvhnTIlsLDin1LVDbTE+r8bPk7ny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495076; c=relaxed/simple;
	bh=67VHbVLNXMLlxPgriTUJCACZmdMUCtOR5oi4DOaNwl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Gb6fGO+B+8LNolBpLPBLxuvlO7FlM5/IEL58tOogqG04ESpP3OItMuLd9HgZeEFjYiIyyErkJScuncIke/lGs14n5OwAgz19Fx8grJBgFw4TUWES9KAYKRhmq7uxzqj/G9QxLC6DdM7JnfhOfniqeUhWZXo6doQb7Cipp9nP9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=asdrDcVW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250121213113euoutp02988a917f21dff653c3879e501f06da13~c0pBEkuzk0551205512euoutp02h
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 21:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250121213113euoutp02988a917f21dff653c3879e501f06da13~c0pBEkuzk0551205512euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737495073;
	bh=6DlcL65m0GoSpeRzrPmCw8urC7s7mkdu2598cv8NIWU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=asdrDcVWGpV5hF5nTWvhrz29+VaCdb+u9GTPHVATKNZK6alRIzHdbKHZwcBlETOXe
	 3wmcnIVBwxAix2rWZo7jqyQO6/Ha+LpfDJPw8UlWz4yQ923QAEXNCbtx+1qyYxqxUM
	 VCxDqHQqmjdujps7HKTslz2cd/4u+oUBoUi+zfO4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250121213112eucas1p16125565a8f8a6a1f95c5eb1b9831619d~c0pAc8UQL1607816078eucas1p1a;
	Tue, 21 Jan 2025 21:31:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.63.20409.02210976; Tue, 21
	Jan 2025 21:31:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250121213112eucas1p2d1c316dc254cebf0bd605338f8ae2c1a~c0o--8CrX1448914489eucas1p2l;
	Tue, 21 Jan 2025 21:31:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250121213112eusmtrp23f40ffba434e51a1b9a66b813d1e2e86~c0o-9s8P01186611866eusmtrp2c;
	Tue, 21 Jan 2025 21:31:12 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-d8-67901220c9b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.08.19920.F1210976; Tue, 21
	Jan 2025 21:31:11 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121213110eusmtip1250f49899c5da0cbe275ca295c862def~c0o_rfH-_0471104711eusmtip1N;
	Tue, 21 Jan 2025 21:31:10 +0000 (GMT)
Message-ID: <167cdd54-895d-4ecf-873a-b5a1bbc11eb8@samsung.com>
Date: Tue, 21 Jan 2025 22:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 03/18] dt-bindings: firmware: thead,th1520: Add support
 for firmware node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250121-lively-cocky-lorikeet-e0a3db@krzk-bin>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHc25v7y2NhWvBcSIDSTMwmKw4M7JjnGYaHFclThIQtrloI3eF
	CK1pZYIQRUHGowwkqNDieARHg1JYBdYSHlmHVASpDwbMQGlIRct4jBVkPtBRbt347/v7/L6/
	18nhcYQmYiMvUXaKUcgkSSKCj7f2vLB8GCgslm6tKAtEd4ZrMNTySk2imx0DGKrsHuAi68Nm
	DA0uzhFI9+Q+iZ51nMfRkPYaibJ6GgnkUFsJZLE0kWheZeWiR20VBHIWdgPU6swmUEP3GImq
	51twVGtoAygn7ycuenB3Lxqz3sGR45GKg3LUXuhtu4FEb4Z+xpFmtotEzdOXuMjcEIuyu0rx
	zwLouZGLJD3tcOD0b7kLJN3xvAqnjeoxklYZ+wGtr88j6NGhdoL+sTeKHi8wY/St2nN0dkMP
	Rhctb6XnOn8n6B+a6wH9MGuYPCT8iv9pPJOU+B2jCN11jJ9Qa+nETrYIU/OzSvFM8MIrH3jw
	IPUxvF43guUDPk9IaQFsuHUDZ4MFAGse9AM2cAL4x+wgeFdinSx1l9QB+KTwPMkGMwDadTWk
	yyWgdsGJzBzcpXEqCN7TOwHL18Pecvsq30BtguOPy1b93tQxWPV90ar2oULg8PIS19WUQ7Vz
	4ZXSJq4rwaF84WN7JebSBLUN2uoqV7kHtRM+fWolWM8m+MtMBYdd9R4f9k/GsDoc5tp1GKu9
	4ZS5mWT1+/CtsdLN5dDW8re7NgMaVWa33gFHB16u9Oet9A+BjW2hLN4Ni4tyOC4MKU84MrOe
	3cATlrRedWMBzM0Rsu5geFlV+N/QAW0rVgxE6jWPol5zo3rNLer/51YBvB74MinKZCmj3CZj
	TouVkmRlikwqPi5P1oOVb973xrxgAHVT82ITwHjABCCPI/IRbPhLJRUK4iVpZxiF/KgiJYlR
	moAfDxf5Cmq6LkqFlFRyijnBMCcZxbssxvPYmIkZjtzWW+KcdMTE9T9nUju6Y+v2pmkOV6l7
	w4PE64yau42TsTd2NxhmDGOdiT6R1VB+cHPTUXG6r78tyKbfs0O0dLjkH+4og6VGnctNjzwT
	sz2elu0fgV+eVWpEmfvjpDs3+70si422vrYYxm12/wPNoiuJuqi4dQXLmi1crc1X/mu5180C
	z5gDfSdMwxGtr2MzPGFIWERTX0L0hW/bq0IDih3+n09/jfX228Li9nlfSr+/57a88lqeXnHV
	P7pcZ7VHVpjjP1g8nsS1BE8tVYTPvfeN55TfJ8+nDx3ZdzYvM+yLEqXlwtjs9meBwSWyxvCh
	wVcBg6czqifMi7zJy/7aNBGuTJB8tIWjUEr+BeN/N99VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsVy+t/xu7oKQhPSDa53MlqcuL6IyWLr71ns
	Fmv2nmOymH/kHKvFvUtbmCyufH3PZrHu6QV2ixd7G1ksrq2Yy27RfGw9m8XLWffYLM6f38Bu
	8bHnHqvF5V1z2Cw+9x5htNj2uYXNYu2Ru+wWCz9uZbFYsmMXo0Vb5zJWi4unXC3u3jvBYvHy
	cg+zRdssfov/e3awW/y7tpHFYva7/ewWW95MZLU4vjbcomX/FBYHOY/3N1rZPd68fMnicbjj
	C7vH3m8LWDx2zrrL7tGz8wyjx6ZVnWwed67tYfOYdzLQ4373cSaPzUvqPVrWHmPy6P9r4PF+
	31U2j74tqxg9LjVfZw8QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
	SUnNySxLLdK3S9DLWHJ+H1PBVqGKruYpLA2MP/m7GDk5JARMJO49m8LUxcjFISSwlFFi5+2P
	TBAJGYlr3S9ZIGxhiT/Xutggil4zSnyfeBwswStgJ/GooQ3MZhFQlTi76TMjRFxQ4uTMJ2Bx
	UQF5ifu3ZrCD2MICCRIL2vvBbBEBTYnrf7+zggxlFtjDKnF482eoDX8YJV42fwWrYhYQl7j1
	ZD7YSWwCRhIPls9nBbE5BWwlnj+/B9TAAVSjLrF+nhBEubzE9rdzmCcwCs1CcscsJJNmIXTM
	QtKxgJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmD62nbs5+YdjPNefdQ7xMjEwXiIUYKD
	WUmEV/RDT7oQb0piZVVqUX58UWlOavEhRlNgWExklhJNzgcm0LySeEMzA1NDEzNLA1NLM2Ml
	cV63y+fThATSE0tSs1NTC1KLYPqYODilGpjUOiLajnNLPpqz0Od8nuSNI/vV/QVmfeoV+sYn
	Z/j+b+SqWQG8K5TNxef33an8lRTiY/Mm25/t9B5pzrgnjkzmN9a/P8ZSHnZllT1vxZHAuO1O
	d69FZc7Y5Bb/o/mG9pqN/lFxk0KsCv1029/v++Cdp36GZdLqr5W88RE6h2yDenesSJwb5hO1
	i18pXcx/x9/0iR1H7WMr+TZeOKzQpfjTb+M6nvUc9z2+MLWdqDlyoukHF3/dLYdDlhfCRA1K
	nR9m7D53prdo2yrRXP5Lc49P+PP5J9N3txazjg8t9ysmVO9n1RD28N3Fzf7GgPuIMf+Dn9my
	XfliT9OvT/3XZ+Je/f9Z0dIPCZVym2Q9uZVYijMSDbWYi4oTAetkVgXoAwAA
X-CMS-MailID: 20250121213112eucas1p2d1c316dc254cebf0bd605338f8ae2c1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172123eucas1p13564bf2d07000506caf44cf55bda7fd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172123eucas1p13564bf2d07000506caf44cf55bda7fd9
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172123eucas1p13564bf2d07000506caf44cf55bda7fd9@eucas1p1.samsung.com>
	<20250120172111.3492708-4-m.wilczynski@samsung.com>
	<20250121-lively-cocky-lorikeet-e0a3db@krzk-bin>



On 1/21/25 10:52, Krzysztof Kozlowski wrote:
> On Mon, Jan 20, 2025 at 06:20:56PM +0100, Michal Wilczynski wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0fa7c5728f1e..c56a1fb6e02a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20184,6 +20184,7 @@ M:	Fu Wei <wefu@redhat.com>
>>  L:	linux-riscv@lists.infradead.org
>>  S:	Maintained
>>  T:	git https://protect2.fireeye.com/v1/url?k=ea660594-8a8498c9-ea678edb-000babd9f1ba-8d70d4b62a370592&q=1&e=48951848-cf32-4505-a50e-0bcb822a20b7&u=https%3A%2F%2Fgithub.com%2Fpdp7%2Flinux.git
>> +F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>  F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> 
> Misordered.
> 
>>  F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>>  F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>> @@ -20194,6 +20195,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>>  F:	drivers/pinctrl/pinctrl-th1520.c
>>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>> +F:	include/dt-bindings/firmware/thead,th1520-aon.h
>>  
>>  RNBD BLOCK DRIVERS
>>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>> diff --git a/include/dt-bindings/firmware/thead,th1520-aon.h b/include/dt-bindings/firmware/thead,th1520-aon.h
>> new file mode 100644
>> index 000000000000..7607522289f7
>> --- /dev/null
>> +++ b/include/dt-bindings/firmware/thead,th1520-aon.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) 2022 Alibaba Group Holding Limited.
>> + * Copyright (c) 2024 Samsung Electronics Co., Ltd.
>> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_AON_TH1520_H
>> +#define __DT_BINDINGS_AON_TH1520_H
>> +
>> +#define TH1520_AON_VDEC_PD	1
>> +#define TH1520_AON_NPU_PD	2
>> +#define TH1520_AON_VENC_PD	3
>> +#define TH1520_AON_GPU_PD	4
>> +#define TH1520_AON_DSP0_PD	5
>> +#define TH1520_AON_DSP1_PD	6
> 
> I don't see these being used in the driver. Can you point me?

Those are used in the power-domain driver
[RFC v3 05/18] pmdomain: thead: Add power-domain driver for TH1520:
https://lore.kernel.org/all/20250120172111.3492708-6-m.wilczynski@samsung.com/

> 
> Best regards,
> Krzysztof
> 
> 

