Return-Path: <linux-pm+bounces-19703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEC9FB116
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AD91882A9A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0219E98B;
	Mon, 23 Dec 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lnUHAG41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABF19E971
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969757; cv=none; b=pMSPzKO1FmiIxx7YDffUBT/x3K3TtVv32ZH8PXviAn6dypGkSQLcfDGlTzqbFLIcVHKoq/xPwtX6Z62NXQZAZOhWCRB8P40eARi/3xu2rBghvfDYbqqtQoHc3I7IjZqe9jKmrnD/91r0ckLq0IoBAFNG9evAOiZG3Qy60bHei9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969757; c=relaxed/simple;
	bh=qhi03LMsVW4D9q4y026npXfkqwPAwt76OW4tM3c3vvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=M0nkIx5pZDbc9S85pHRzSRx0AywbZHHB9C/zJlcHbY6LjMnx647M8pPd5vxiHYxNV5z5sfu0vReDNFWu6MeOdlhxRHmcxhH8jNZPSmxXbtZk7CpagNHfNfCXEhr0jbs1dNOQzO6p8s1ZCL0GrNpcP3nygouhxp06BWmoWbL+F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lnUHAG41; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241223160233euoutp01f631bf9fcd1f88644757188c438b048d~T2cxz5y7w1079610796euoutp01s
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 16:02:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241223160233euoutp01f631bf9fcd1f88644757188c438b048d~T2cxz5y7w1079610796euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734969753;
	bh=X0CXheQbvp5Sphsquee3Aj3fdrNQ/Cg7QPvl2PzSmdk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lnUHAG41yUYwDKhqNDeoMS5K6PSFK6/gIeEeInPvbAtzAntg49AFUqR0LZf2+bw3k
	 U5PzXx3mtcp4nhQ4AIqoKvHaUtwDQdXJi6GfRqtirsckN16xfP4JSqNIFvOeOrmlri
	 HfVugz0X6yPoxJ0XEbnhwSlDJRW+PGXYA+ejGbu0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241223160233eucas1p1100f123c51fa8c93959d7d47e12d91a3~T2cxQ-7GT1283112831eucas1p1H;
	Mon, 23 Dec 2024 16:02:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 63.AB.20397.89989676; Mon, 23
	Dec 2024 16:02:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241223160232eucas1p25c0b7b3dfcf3f526d97fefd111c48ea8~T2cwvb25U1457614576eucas1p2n;
	Mon, 23 Dec 2024 16:02:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241223160232eusmtrp20225f35ca225352f0dc365b4811c65de~T2cwuYqbV0126101261eusmtrp2T;
	Mon, 23 Dec 2024 16:02:32 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-a5-67698998c9aa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.1A.19920.89989676; Mon, 23
	Dec 2024 16:02:32 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223160230eusmtip27e32a14378ca33e77a1600e122b45abf~T2cvVXHIw1370013700eusmtip2i;
	Mon, 23 Dec 2024 16:02:30 +0000 (GMT)
Message-ID: <3b2fd94a-2b4d-4bdb-9266-203a09369982@samsung.com>
Date: Mon, 23 Dec 2024 17:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/19] dt-bindings: power: thead,th1520: Add
 support for power domains
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: guoren@kernel.org, linux-riscv@lists.infradead.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, sboyd@kernel.org, mripard@kernel.org,
	jassisinghbrar@gmail.com, dri-devel@lists.freedesktop.org,
	m.szyprowski@samsung.com, palmer@dabbelt.com, jszhang@kernel.org,
	aou@eecs.berkeley.edu, airlied@gmail.com, ulf.hansson@linaro.org,
	frank.binns@imgtec.com, linux-pm@vger.kernel.org, paul.walmsley@sifive.com,
	devicetree@vger.kernel.org, p.zabel@pengutronix.de,
	linux-clk@vger.kernel.org, matt.coster@imgtec.com, mturquette@baylibre.com,
	linux-kernel@vger.kernel.org, drew@pdp7.com, tzimmermann@suse.de,
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, wefu@redhat.com
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <173496697225.830201.2249501258776075204.robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BUZRjH5z3XZZvV40LxRhdyGxxABKl0XrIhm8I50wW1D1GW5gZnFhIW
	3AUtMoFEFFhQScpOm5BhIMPKSAvCwooty+5yTdTAHGDXxIklLgPLnRFyOVR8+z2X93n+/2de
	ES6tp3xEccpkTqWUx8soMVFjmftt07nsOMXmTu0WZOu5gKHqBZ5GFcZODBWZO0nUf1OPodtT
	YxS6/OAGjQaNGQTqLvuBRscslRRy8v0UGtf0k+iWQUshV54ZoBpXJoV05j4a/TheTaCSWgNA
	Wdk/k6irNQL19dsI5LylwVEWvxYtNdTSaLH7CoG+H22kkX74DImsuiiU2XiW2P4MO3bnOM0O
	O50E23RykmaN08UEW8f30aymrh2wVeXZFNvb3UCx51t2s/ZcK8b+UpLGZuosGHvq4WZ27Nrv
	FJuvLwfszWM99C7pHvErMVx83CFOFRK+XxybN/03ljTl8Vnu/V4iHZwS5QCRCDIvwcLrO3OA
	WCRlygCsf9BICcEkgOnFLloIXADOzrVjOcBj+UWuvpJys5QpBdBcIBeaRgA0PJwn3WMlTDgc
	vKFw9xCMH7TlmnE3S5h1sOW7AcLNjzO+0H73HO1mTyYaVp7NBG72YgJg66QRd8/EmUskPH6p
	f7mAM97w7kDRsgiKeQE6SotIN3swO2DJQhMu9PjCqyPa5ceQ6RLDdqeOFFS/Aa/9xa+wJxyy
	6mmBn4ZLdUUrzhKho3oCF/gIrNNYV3gb7O2cp9zG8EfqKg0hQvo1qHdOkMIZ18A7I+sECWtg
	Qc23uJCWwJNZUqF7AyzU5P23tLOsBjsNZPyqq/CrTPKrzPD/7y0GRDnw5lLUCQpO/aKSOxys
	lieoU5SK4OjEhCrw6H+3LVqnakHZ0HiwCWAiYAJQhMu8JCZpnEIqiZF/nsqpEj9WpcRzahN4
	SkTIvCV+Mb6clFHIk7kDHJfEqf6tYiIPn3TMrys/wvpeWEmb7sjo2o8m8rf8eVvTkmrLDGoa
	zC947kQaitgxG3nhXYePNOt84VVLwOWXQ/ZI7mX0zMw6ftppcFy/uCllkB2OtIV4LrXbxnsK
	S2P837FG2E2/NtfbtVFbvyz8IlB7MHwD65Ad3QiebEvfV5ynnPewxDokOv/3h1I73vQ7msZP
	++6aGchYfH3A79mwetw4FpYMdMoPPyAOPr+V7/i6+ZuNprflYOpVw955ShH+RJXyLbb7jKWR
	DDicZPXx3/vYPs/QmNb9urYOo/2r7QtB09si7x8Y/bSioePE7uhxr09cXLMk9I97c+RpriLQ
	bL14qG+9dcYr6EqUKkKTJiPUsfLQQFyllv8DryTP4U4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xe7ozOjPTDc5cEbU4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xcKPW1ksluzYxWjR1rmM1eLiKVeLu/dOsFi8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPPr/Gni833eVzaNv
	yypGj0vN19kDhKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
	Uov07RL0Mnq/vWYq+MpZ0f34DksDYz9HFyMnh4SAiUT3lvVsXYxcHEICSxklDq88yQKRkJG4
	1v0SyhaW+HOtC6roNaPEzJYFrF2MHBy8AnYSLy6kg9SwCKhKnOg+wgxi8woISpyc+QSsV1RA
	XuL+rRnsILawQLLE+iktjCC2iICmxKkve5lBZjILrGSVuLd6CzvEglYmiZn/poNVMQuIS9x6
	Mp8JxGYTMJJ4sHw+K4jNKeAmseT3YWaQI5gF1CXWzxOCKJeX2P52DvMERqFZSO6YhWTSLISO
	WUg6FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMWduO/dy8g3Heq496hxiZOBgPMUpw
	MCuJ8B4SykwX4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnApJlXEm9oZmBqaGJmaWBqaWas
	JM7rdvl8mpBAemJJanZqakFqEUwfEwenVAPTlNA2xuIso/iPN55uSW2ZPv1s+VKPA1dOfr5s
	yFn/sfh3mF3H3c1nXU+0OnAUZsw59vX008ePZTK/cqtcyI2+Mbluk/nEg+5ulrX6es/NJDbL
	pWtt1zefU7vt1cR7D3xk7R6uarFb4PLZtTFq9b4UoWyRCVP5D3X9+yypmLTJKax+jqd66eKJ
	z6VCeo1cyoRCIrwSCjivRHhf74+8phjcNe/BNvvzL10WxRza57Fy5WLht87rnsp9D4oNipVc
	f70n+/bJrId/Xi9Z7fvPIctPc0uxH19X2YVXImcOLmCJFf615ODZF6ZLhCMt8plnHXiWv30G
	h8Wm3lfnbq/LSfL/vFnbr8Vo1Zc1rBmvzp/wUmIpzkg01GIuKk4EAKBXf/PiAwAA
X-CMS-MailID: 20241223160232eucas1p25c0b7b3dfcf3f526d97fefd111c48ea8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125604eucas1p26b870756eeaf2a5666b70de3f7554c13
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125604eucas1p26b870756eeaf2a5666b70de3f7554c13
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125604eucas1p26b870756eeaf2a5666b70de3f7554c13@eucas1p2.samsung.com>
	<20241223125553.3527812-4-m.wilczynski@samsung.com>
	<173496697225.830201.2249501258776075204.robh@kernel.org>



On 12/23/24 16:16, Rob Herring (Arm) wrote:
> 
> On Mon, 23 Dec 2024 13:55:37 +0100, Michal Wilczynski wrote:
>> Introduce a device tree binding for the T-HEAD TH1520 power domain
>> controller. This allows devices to specify their power domain
>> dependencies, thereby improving power management for subsystems such as
>> the GPU. The new YAML schema describes the power domain node for the
>> T-HEAD TH1520 SoC.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../bindings/power/thead,th1520-power.yaml    | 42 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  .../dt-bindings/power/thead,th1520-power.h    | 18 ++++++++
>>  3 files changed, 61 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/thead,th1520-power.yaml
>>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/power/thead,th1520-power.example.dtb: /example-0/firmware/aon: failed to match any schema with compatible: ['thead,th1520-aon']

It is introduced in the next commit in this patch series.

