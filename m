Return-Path: <linux-pm+bounces-28054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C9ACCD10
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE111897017
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB15288CA8;
	Tue,  3 Jun 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vkf4K+Nn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E30288C9D
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975402; cv=none; b=tE71wU7d+5Y/0ALet7iMo3GVj0/nu5wpZHsjENsK7P6xVUeYFHqOxh18sfoYzF8A6lBNZEyN5jScxqxGeMIwg22JZGyPxOzt5aMODe3peHm/8z2eIe5PldcsWcMPt3bekSvRE3oLOBiGCUDaipF2JbzAUilAYIkVBSB6QkO8UjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975402; c=relaxed/simple;
	bh=y1ZpJ75hRulr5OCrdwCCKe86Qj833y9l6fdMFUcMWXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=afoYfhgxx+YaIwiq8tiNRpKk3eVkBRxXQwaYL4DZNYl5YVhBSMiEZrnkh6fHcPXCTPiTS84wbfzlp7mUgzMHT/V9Jqp5wk9Ntod7Zucuhq1XCcUtLRW5dwJe9BSgz6UFwPkJ9Gv8XrdDe8coi8INHsvLmFxGagx23oHvjBUgBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vkf4K+Nn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250603182958euoutp028bb80bbee114817763e0f44ea6dbdc41~Fm9vX5XhJ1075410754euoutp02H
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:29:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250603182958euoutp028bb80bbee114817763e0f44ea6dbdc41~Fm9vX5XhJ1075410754euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748975398;
	bh=Q3UHhcvNg9ZUzuZPlUDNEg5b/5o+/vY1pkJ8HrgEMqE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Vkf4K+NnAWakwW+l5clmnHU0d5flDuEKOS1rfOm5nh5RXqFPGbAtb7sekDIYLLHQw
	 bkrYCcDsXavwkWoTKBsVdIEGo3+CTnzgOygn+1ftLlinfSyzhEVIkpMzsvmH/Yqg+p
	 mk047vU+F4qkth72Ngdq4HIWzByUVZJLwxWgZGwA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250603182958eucas1p2fcaf0880cbecd666386f03a525781254~Fm9usPXYJ2435224352eucas1p2F;
	Tue,  3 Jun 2025 18:29:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250603182957eusmtip1ac2a95b29e9017eb56f62c082e9dbfcc~Fm9tvR43j1164311643eusmtip1N;
	Tue,  3 Jun 2025 18:29:57 +0000 (GMT)
Message-ID: <00abf302-cc8c-47c7-8444-ea3791f70436@samsung.com>
Date: Tue, 3 Jun 2025 20:29:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add TH1520 GPU support with power sequencing
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFqL9Xpau1BDnaa828s066zj=aVOAQOy1tCS=ztKN0ZsfA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250603182958eucas1p2fcaf0880cbecd666386f03a525781254
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
X-EPHeader: CA
X-CMS-RootMailID: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
References: <CGME20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58@eucas1p1.samsung.com>
	<20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CAPDyKFqL9Xpau1BDnaa828s066zj=aVOAQOy1tCS=ztKN0ZsfA@mail.gmail.com>



On 6/3/25 14:25, Ulf Hansson wrote:
> On Fri, 30 May 2025 at 00:24, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> This patch series introduces support for the Imagination IMG BXM-4-64
>> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
>> managing the GPU's complex power-up and power-down sequence, which
>> involves multiple clocks and resets.
>>
>> The TH1520 GPU requires a specific sequence to be followed for its
>> clocks and resets to ensure correct operation. Initial discussions and
>> an earlier version of this series explored managing this via the generic
>> power domain (genpd) framework. However, following further discussions
>> with kernel maintainers [1], the approach has been reworked to utilize
>> the dedicated power sequencing (pwrseq) framework.
>>
>> This revised series now employs a new pwrseq provider driver
>> (pwrseq-thead-gpu.c) specifically for the TH1520 GPU. This driver
>> encapsulates the SoC specific power sequence details. The Imagination
>> GPU driver (pvr_device.c) is updated to act as a consumer of this power
>> sequencer, requesting the "gpu-power" target. The sequencer driver,
>> during its match phase with the GPU device, acquires the necessary clock
>> and reset handles from the GPU device node to perform the full sequence.
>>
>> This approach aligns with the goal of abstracting SoC specific power
>> management details away from generic device drivers and leverages the
>> pwrseq framework as recommended.
> 
> Just wanted to share my view. I have looked through the series and to
> me this seems like the correct approach, nice work!
> 
> Feel free to add my Reviewed-by tag for the series, even if I think
> there may be some comments to address from Bartosz etc.

Thanks for providing the direction and reviewing the code, the pwrseq
API seems to be perfect to achieve the goals of this series. Appreciate
your help !

> 
> [...]
> 
> Kind regards
> Uffe
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

