Return-Path: <linux-pm+bounces-18525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112CB9E37AB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53FD285DDF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AA1B4139;
	Wed,  4 Dec 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="niQgSedU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222119049A
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308495; cv=none; b=Bc3WMXXFEe5KltrFG4gj0paW3IoipkrS4P9L8CbErZRu3f0O4TcjYEM2E9rvMmTwUUFwPgoydJjveyLI/HzKkncHEdxPUEBooOLq3qj4vm0p0ZGVm1SV/vhJrkxmstvnchh8vzf+2Deb9BCf0uc946qEGU001yj3g4WJPsX6JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308495; c=relaxed/simple;
	bh=ThPPkK3Bt2gs0BoLGsQNUcJDtqUraUqu6Ng+2ewBOuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KLlCgtrJnVa/N0om//8EYyAA0HI5/JqQrRMaHpQUXFHUlwiFApmSZ62butVtmmT7XWWi1bUOKF2r595MSTP/teAoSROldyVsuE+uQ9YAQBRCpRynTxQuu4n88bYAPJC/znvCoPDgLKIwcgURkRwqCNx/ujv1t2olqYo/0B6/g9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=niQgSedU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241204103451euoutp020037916441f3c6ffe63296389657002a~N8uOigkz61109711097euoutp02L
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 10:34:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241204103451euoutp020037916441f3c6ffe63296389657002a~N8uOigkz61109711097euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733308491;
	bh=+l4e4Tyx2I1+OfNbhG6k6rLroWYsZg5fA2FLlIaEGO8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=niQgSedUrpFLE7LRUETDJiXrPBx5Jjiz5Q9jVIw3QZ5AwXbr3ZUog4id/+OC9tbwR
	 uQwpLQRVGX/SHJKoatTqiJCnSBDFsWzAjUuKLBHo7GHN79gp9Mmu2hlXuqqY2fpsvm
	 39T7fBgG5HSeP2pQ43MRkUyoPAFj8rUekSLTzDM4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241204103448eucas1p2787f6ba041d5859d798f8a0fe36e5869~N8uL0vWCQ1075110751eucas1p2M;
	Wed,  4 Dec 2024 10:34:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.27.20821.84030576; Wed,  4
	Dec 2024 10:34:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241204103447eucas1p1290a8da81821da986015bef31ccf0e3c~N8uLKQQUG1362813628eucas1p1r;
	Wed,  4 Dec 2024 10:34:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241204103447eusmtrp2cae4b6f1f36a5e73397910cd66cdf731~N8uLJMXGw1364613646eusmtrp2t;
	Wed,  4 Dec 2024 10:34:47 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-fe-675030486f50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.BB.19654.74030576; Wed,  4
	Dec 2024 10:34:47 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241204103446eusmtip11cf57501b24c5ce7d747834870a33315~N8uJ2BqPW0744207442eusmtip1a;
	Wed,  4 Dec 2024 10:34:46 +0000 (GMT)
Message-ID: <17df9341-e299-40bb-81ae-f4c7296d73ac@samsung.com>
Date: Wed, 4 Dec 2024 11:34:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 13/14] riscv: dts: Introduce power domain node
 with simple-bus compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	frank.binns@imgtec.com, matt.coster@imgtec.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
	airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
	jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <9b75bc06-2a28-4c16-8e2b-90f824f7f79f@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+693FtK6i6FjRPKhjbqhM0C0y0nmTFKht7plqAzTkjc1oy7
	goNiWnCbOkVgDKEQcBi2FikiswRhfLOWFVlaQhFYmSAgFRA3PqwDS6UaRcFRLm7893s/zvO+
	z5vDw4W/kf68OHkSq5BL48Ukn2hqf2LdzIRGykILCwnUMViKocanagpVtlgxpG2zeqDR3gYM
	3XjoINEvE39S6G7LGQINlF+gUFp7NYns6lES9fTUUMipGvVAfc1FJJrLaQOoaS6dRFVtIxS6
	6GwkUJm+GaCMs5c90PXOCGTvU+EoQ/0Sem7UU2hxoJZAmvutFGqYzvdAlqqPUXprAbHjVcZx
	8zuKmbbbCcac6aKYlkclBGNQj1CMytANmLqKsyQzPGAkmeJr+5jb2RaMqS87zaRXtWOM42o/
	yeQ2VACmN22QYuq7TkR6R/O3xbDxccdYRcj2z/ixw/n51NH+V77uzAlPAQZhFvDkQXorbF5w
	EFmAzxPS5QA6OswYF7gAnC45Q3LBHIAL2iyPF0++r7lEuFlI6wDsnvyEa5oB8GqnGbgLAno7
	TBkswtxM0Ovh5Zw7GJf3htd+Gl9+/DIdCG/bfqTc7EN/Aa3TRuAW8qULCPi4tAV3F3D6VwA7
	ugUc+0HbuHZZiKTfgmM67fJGnkvDJjLSMa4nEKY1anC3EKT/4MNUzf0lD7yl4D04mUtzDnzg
	PUsDxXEAfG7gNCGdCMcaH+Acn4QGlWWF34XD1vllGZwOgtXNIVx6JzTdGMM59TXw5ow3t8Ea
	eK6pcCUtgJkZK5feCM+rcv4bai1vwvKAWL3qKOpVHtWrvKj/n1sCiArgxyYrE2SsMkzOfiVR
	ShOUyXKZ5PPEhDqw9L+7Fi0P9ODCPafEBDAeMAHIw8W+gv1vRMqEghjpN8dZReKniuR4VmkC
	Ih4h9hNsiAlkhbRMmsR+ybJHWcWLKsbz9E/BNGtPHyYLiwcroxxvjxzhRWvG+tcNhn14ULAr
	fMelqFvG2oX5Ge/wLQGS3N3PNMWWouy4U2al0EUaNpTeUYrq19rvnkg2TlHOpLnAlCsx62d2
	NpuGrlQeqXk0tMlLFHqovriosLog9dRj0Lfb1v/zROytzOzyLVZzmmeDLejZ3pI83WuVXnsj
	giW2YP1+L/zJlP5Y42amurd2q8/TqbzFvyt0hz6qfF2Hr0s9f2D6uGzW/2H8NtX7Q3SF9EDZ
	fJ7zr+vmtoN73gyV/+OaDZuM3hQlAnPqD3b5iuS6i++IZ0/WHdaJkgP0feO/72F7vnX5au2t
	o3muH7pmtRE6m3+IM2hATChjpWHBuEIp/RevMK9jTgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsVy+t/xu7ruBgHpBq3XRS1OXF/EZLH19yx2
	izV7zzFZzD9yjtXi3qUtTBZXvr5ns1j39AK7xYu9jSwW11bMZbdoPraezeLlrHtsFufPb2C3
	+Nhzj9Xi8q45bBafe48wWmz73MJmsfbIXXaLhR+3slgs2bGL0aKtcxmrxcVTrhYvL/cwW7TN
	4rf4v2cHu8W/axtZLGa/289useXNRFaL42vDLVr2T2FxkPV4f6OV3ePNy5csHoc7vrB77P22
	gMVj56y77B49O88wemxa1cnmcefaHjaPeScDPe53H2fy2Lyk3qNl7TEmj/f7rrJ59G1Zxehx
	qfk6u8fm09UBglF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
	qUX6dgl6GXcmTmQvuCpWcarXqYFxp1AXIyeHhICJRPuGxSxdjFwcQgJLGSW+PvrCBJGQkbjW
	/ZIFwhaW+HOtiw2i6DWjxI5pjWAJXgE7iYbrc8AaWARUJJb1PmSCiAtKnJz5BKxGVEBe4v6t
	GewgtrBAmsT0LW+YQAaJCExhkVj96B8ziMMssJ1RYsPMqYwQK/4xSrw6uooNpIVZQFzi1pP5
	YGPZBIwkHiyfzwpicwKtftrWAhTnAKpRl1g/TwiiXF6ieets5gmMQrOQHDILyaRZCB2zkHQs
	YGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZi0th37uWUH48pXH/UOMTJxMB5ilOBgVhLh
	DdIOSBfiTUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ+cC0mVcSb2hmYGpoYmZpYGppZqwkzst2
	5XyakEB6YklqdmpqQWoRTB8TB6dUA9Omyf9PFs306Fn62kAy+BOLoUpJnqbZmRzrxB/yn4N8
	InJWFNytqhBdli2bsEI+PPpmWviHH7czDjTcjQptmulfNE/9ldGMn4bnxZN9j0uvO863SnXP
	7Wlb57wsfZOV171aaanMJK3vi6SKGaKr0zpW9/Fsy/8iUJ1xdq1MkKeGwbsIhyqn7yWr115y
	me8hKHj+1oaEdy6N8oqCC+a2iTZZCv49FdW0jT1u2cngmx93TT7ftudNJtvXrduFzgtJ5scs
	Nkh6bnxg8sVfOppXtus6XUnPX5gvlfrfSC/pqE/9opctF5sfB/zpvTtp3/cbdqWPHPS+unAw
	HMz/cSHX1+yIwo0LvySNtFadVkwUb1FiKc5INNRiLipOBAAdHNKv4wMAAA==
X-CMS-MailID: 20241204103447eucas1p1290a8da81821da986015bef31ccf0e3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd@eucas1p1.samsung.com>
	<20241203134137.2114847-14-m.wilczynski@samsung.com>
	<9b75bc06-2a28-4c16-8e2b-90f824f7f79f@kernel.org>



On 12/3/24 16:52, Krzysztof Kozlowski wrote:
> On 03/12/2024 14:41, Michal Wilczynski wrote:
>> The DRM Imagination GPU requires a power-domain driver, but the driver
>> for "thead,th1520-aon" is not yet available. To ensure that the 'aon'
>> node and its child 'pd' node are properly recognized and probed by the
>> kernel, add "simple-bus" to the compatible property of the 'aon' node.
>>
>> This change allows the kernel to treat the 'aon' node as a simple bus,
>> enabling the child nodes to be probed and initialized independently. It
>> ensures that the power domain can be managed appropriately until the
>> specific AON driver is developed.
>>
>> This commit introduces some errors while running dtbs_check, as the aon
>> doesn't have the dt-bindings yet.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index 39d39059160d..58f93ad3eb6e 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -6,6 +6,7 @@
>>  
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/clock/thead,th1520-clk.h>
>> +#include <dt-bindings/power/thead,th1520-power.h>
>>  
>>  / {
>>  	compatible = "thead,th1520";
>> @@ -229,6 +230,16 @@ stmmac_axi_config: stmmac-axi-config {
>>  		snps,blen = <0 0 64 32 0 0 0>;
>>  	};
>>  
>> +	aon {
>> +		compatible = "thead,th1520-aon", "simple-bus";
> 
> 1. No, that's not a bus.

I understand that using "simple-bus" for the 'aon' node was not
appropriate. Since the 'aon' node isn't needed for testing this
patchset, I will remove it and move the power-domain device tree node to
the SoC. Future changes to the 'aon' node will be handled in a separate
patchset.

> 2. Please run scripts/checkpatch.pl and fix reported warnings. Then
> please run `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.
> 
> Sorry, this patchset is not ready, unless by RFC you meant - do not
> review, because it is not ready. Then it is fine. But then *clearly
> express* this in cover letter, so we know what you expect from us (and I
> would not waste my time to go through all this).

My intention with this patchset was to gather feedback on the overall
direction of the changes. I understand that clearer communication in the
cover letter would have been beneficial. Moving forward, I will ensure
that the patch's readiness and expectations are explicitly stated.

Thanks a lot for your review.
Michał

> 
> Best regards,
> Krzysztof
> 

