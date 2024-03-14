Return-Path: <linux-pm+bounces-4932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EE87BCC3
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 13:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F6B1F22956
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3D6F52A;
	Thu, 14 Mar 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MEkMQYs0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8626F507
	for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419329; cv=none; b=jVQCOqFE31LozjtjffkW8a83E6P9i9sPVhQLHjR1V40PfNglpgFaJERuYyi5esH/69hns52lUDa4gRv5DHulf5cUmep4sI84PtwgMEyZUfCMmlX8XJxvwjOeYswgAxl8Bgqsfi1gz5rsFisnVTp+aEDOE3XQMfnvcNuUsXPvAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419329; c=relaxed/simple;
	bh=QdQfhYEro/NY6bBHiGnSatWRYO56g6kjIIj/lZtSvEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Fgohc64/CzxRfqHdDZRwgeMQPF0DTTa143B3jFLhLxHvQtUsnNnAbVRPCp4VMFpsQ1Mm6Ijo4nT/QbpEOEG7cL9iLmd2GzS7smQziQ7BdcbIQ8TcEqIQFHAdHtvZiit97RFLBxaFu7utSuxLnNtl/BOIdxXdkZKcnSKyr0i6PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MEkMQYs0; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240314122844euoutp0261220802b4324deca7c22bbf7ace99cc~8oVBBK2Oq0256202562euoutp02W
	for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 12:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240314122844euoutp0261220802b4324deca7c22bbf7ace99cc~8oVBBK2Oq0256202562euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710419324;
	bh=1kh7I+S2C9P5Kz44btTniuxhDXte7vdYgTUP0g8alRo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MEkMQYs0BTGf/LyJr9ZWVWx+0XeRk8vUBmaTXr4XIc27UMyIPlHTGnT3gPWCtBMio
	 UmEgyFEuq4vhQERxUBljnlC9VxdPpaFOzmAB8epoXYkuj8UsPhOaLlFlnBCyU+pomz
	 HYt9cZhA3VdypUYvy/XENaZS5eF7nuBkqKiuwLsM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240314122844eucas1p1165738a2ef81c5182ae5085ca199fc3a~8oVAidxed0475704757eucas1p1b;
	Thu, 14 Mar 2024 12:28:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2A.71.09539.B7DE2F56; Thu, 14
	Mar 2024 12:28:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240314122843eucas1p231a57588b81f9eb3d53129c0f68bc43c~8oVAHGC6o2694326943eucas1p2f;
	Thu, 14 Mar 2024 12:28:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240314122843eusmtrp2b6faf98297797ce5e8847bb9b0e4eb1e~8oVAF7IDi2786227862eusmtrp2p;
	Thu, 14 Mar 2024 12:28:43 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-0c-65f2ed7bcb7f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.EE.10702.B7DE2F56; Thu, 14
	Mar 2024 12:28:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240314122841eusmtip1e6cbf991d35b9407fd86a548d6f9b99f~8oU_l5CfA2959929599eusmtip1X;
	Thu, 14 Mar 2024 12:28:41 +0000 (GMT)
Message-ID: <a210104f-a3af-4554-b734-097cfa77a470@samsung.com>
Date: Thu, 14 Mar 2024 13:28:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Christoph Lameter (Ampere)"
	<cl@linux.com>, Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Will Deacon
	<will@kernel.org>, Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, Nishanth
	Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZfK30r8M6zx2aWU6@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxj29N7elkr1Utl65jaaNTLdFnEsNjvEhcy4H9cxE0kWZjY3aOSK
	hlJJS93UbUKGwjqryIJAhfIRhK5rYBSk2Aw2OtLyIQypq9BUwFEQquhaEBBIHe3FjX/PeT7O
	874nh4sJfiS2co/Ls2iFXCoTEzy8xfa0f+eZGT/9dmsgDpU1GAnU3nUEPa69ANCd+YcA/T45
	iKGJQC0HGaqcBDKNO9nIYSkj0IjxGRvNajoBsha1AXTtzi0WWq5dYKGHi30sVD5XhKGOfzxs
	FHA24qiupxVH5oqnGJp2uXHUNGYjUK5bgjQ13Zz3IWXUGQHlcN7CqNzOGTZlMnxPUCZ/IYfq
	KlnGKc/tYhbVVHOW8k24cOoHxxCHsg+ZWdSsKepg+Ke891Jp2fGTtGJXfArv2FWNA8s8t/mr
	e/6fsWzwS7gahHEhuRvezM9jqwGPKyD1AI79ZmUHBQE5B+DckzVhFsDiVhv2PLFcdBlnTHUA
	TkyJGJMPwGsd11lBgU/Gw6qSsVAAJ6Ph8PkhDsNHwO5STyj8AimCo66SEL+FlEKvuTLkx0gh
	dHkqQvdEkilw9MplLFiAkX+zYfMDOxEUCDIWqmfUIRxGbocXHvUTTFgEv7t+NRSApJoHqydd
	ODP2B7BtoJvD4C3Qa29ew6/AZzeCbcFAHoCVy6NrhwIAs++7AOPaA939S6sV3NWKN2CDZRdD
	74Xeiw2cIA3JTXBoJoIZYhMsbCnGGJoP888LGPfrUGuv/6+2Y2AQKwBi7bp30a7bX7tuHe3/
	vZUANwAhrVJmpNHKWDn9ZYxSmqFUydNijpzIMIHVf9sbsPtbQbnXF2MFLC6wAsjFxJH8b1/z
	0QJ+qvTUaVpxIlmhktFKK3iZi4uF/OhUES0g06RZdDpNZ9KK5yqLG7Y1m1VeXZvkK9vco5ny
	VNzmpedWSlWaLF17gtvAM2ZiXQOu06Xl+4RHq3Yn7xg+sKJNfLCR3NCcZIkOyPJS9BcTa+qc
	kVnfHEiH3VHeBNWrhfqv95v+gPfPxtmiDjeKCnwVZYLeqb3pSZIwXfzGQlNRb/LdP1cGd0b3
	jc9+viRczNNr9fLwg9skJ033zuF0zuJP+XP74qf55s7kQ/V9bxks/vF6h8om65OgHPmCe3i+
	LX8lblFy6UbLSxFPREfrX1y4+0XjX+06TP145HCJ6tGcY8+Szvxh2qXJm5+M6Oart3M+7uzn
	ez9qyhlMLH1XaEloH/hVwJ4+tX+DpQfIzryz4zMxrjwmjX0TUyil/wL/3Kl6JgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7rVbz+lGvT1SlvMWb+GzWLfiWSL
	98t6GC2uf3vDaHHg2SVmi6f/lrFbrFp4jc1i0+NrrBaXd81hs7i35j+rxefeI4wWh6buZbRY
	ev0ik8XvZd+ZLN78OMtkMffLVGaLgx+esFr8u7aRxWL5qR0sFtvn/2S2eHnrDovF5gfH2Cxa
	7pha9C45ye4g4bFm3hpGj8vXLjJ7tBx5y+qxaVUnm8emT5PYPU7M+M3i8eTKdCaPzUvqPT4+
	vcXi0X35BrvH8RvbmTw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIy
	VdK3s0lJzcksSy3St0vQy5jde5m5oJW/4uGn1cwNjBt4uhg5OSQETCR+T53I0sXIxSEksJRR
	Ys3xu2wQCRmJk9MaWCFsYYk/17rYIIreM0pse3eKESTBK2AnsXDGA2YQm0VAVeJm2w12iLig
	xMmZT1hAbFEBeYn7t2aAxYUFEiVebV8AVs8sIC5x68l8JhBbRCBBYu4/CJtZ4BmrxOGZwSC2
	kMA3Zombbw1BbDYBQ4mut11gx3EKqEv0vDvHBlFvJtG1tYsRwpaXaN46m3kCo9AsJGfMQrJu
	FpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhML9uO/dyyg3Hlq496hxiZOBgP
	MUpwMCuJ8NYpfkwV4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnABJdXEm9oZmBqaGJmaWBq
	aWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAkmbHyI4NlWvfl5YdUvh235T3V0XVPzbrw
	TppT5yKu4I/Ln6WdYO/Nkv75/pKn3i0R3ejafUxbz6d9K8zfvWRDb0EX03o7r4gfb2VEdmf5
	Bn9fHml04ha32OQHU2Q8Pmz8pnxon7XC/pCt9XfmOby7+0dZYYv54pt/IsxsXlpcv+c+/e0U
	3VOrpwXUygtlssuvWJrScH2zkMPi31pFEz/M8xCpnHAxv3rb9alP+4rkPzzfdW9NyebznAq+
	9/xZ5atcTBYuZPbftDbqzcGmAA+ulXJLX+zPWLE3WNb2UsGnv4ci9nZmMk3q/n/bac8m0Xuv
	Hh5rONuzveT91OnPtMKu8dxcc9/hZnJMzO6c/R/U85VYijMSDbWYi4oTAab48Y+4AwAA
X-CMS-MailID: 20240314122843eucas1p231a57588b81f9eb3d53129c0f68bc43c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
	<c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
	<Ze9TsQ-qVCZMazfI@arm.com> <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
	<bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com> <ZfCXJRJSMK4tt_Cm@arm.com>
	<ZfG5oyrgGOkpHYD6@bogus> <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
	<ZfHevcKpcb6i1fn5@shell.armlinux.org.uk> <ZfK30r8M6zx2aWU6@arm.com>

Dear All,

On 14.03.2024 09:39, Catalin Marinas wrote:
> On Wed, Mar 13, 2024 at 05:13:33PM +0000, Russell King wrote:
>> So, I wonder whether what you're seeing is a latent bug which is
>> being tickled by the presence of the CPU masks being off-stack
>> changing the kernel timing.
>>
>> I would suggest the printk debug approach may help here to see when
>> the OPPs are begun to be parsed, when they're created etc and their
>> timing relationship to being used. Given the suspicion, it's possible
>> that the mere addition of printk() may "fix" the problem, which again
>> would be another semi-useful data point.
> It might be an init order problem. Passing "initcall_debug" on the
> cmdline might help a bit.
>
> It would also be useful in dev_pm_opp_set_config(), in the WARN_ON
> block, to print opp_table->opp_list.next to get an idea whether it looks
> like a valid pointer or memory corruption.

I've finally found some time to do the step-by-step printk-based 
debugging of this issue and finally found what's broken!

Here is the fix:

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8bd6e5e8f121..2d83bbc65dd0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, 
int cpu)
         if (!priv)
                 return -ENOMEM;

-       if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+       if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
                 return -ENOMEM;

         cpumask_set_cpu(cpu, priv->cpus);


It is really surprising that this didn't blow up for anyone else so 
far... This means that the $subject patch is fine.

I will send a proper patch fixing this issue in a few minutes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


