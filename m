Return-Path: <linux-pm+bounces-31860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C6B19CDD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EDB16FA47
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E501223A9B3;
	Mon,  4 Aug 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YmCZicYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D3239E77
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293479; cv=none; b=DIxPvmuQHQX/SBYWpgbHCSAxdA+hKexFPhon48h93IGcNnZc7ZsAopzTntdk7amE5oHBGoG7EikJwEThOCxzp/9TZYAmuyNfyWKPzPrIR99+BI2uTRjIKli23qh0IQqW9NNqk0To0yLwOoEgnFHHNB7rzzEhx6vP1Oo6e20ypfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293479; c=relaxed/simple;
	bh=+IRGfQCHeM/mGInYuNiU7PP2ZDK4EP2t6bt1SHrDN4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uvVvlJXSsD43KitGqrsoLFH+0xsCACzK08NYfVLzBFvt+8F7iQ7zOWqjtGtA4FPeIaIgWn6+NddhwpgLPvmQlj1LhakFAI4n+HGn0BfoSJI9ofbkDZvx1U2ZLaA/664kjbanTtPrAC8WdrWeUXazHgZW6GJDbEcOS4Y1bN49EW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YmCZicYT; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250804074430euoutp012d9ec465ebce165dcb29ee9e61ee7182~YgJ3Vk_HE2745827458euoutp01Z
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 07:44:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250804074430euoutp012d9ec465ebce165dcb29ee9e61ee7182~YgJ3Vk_HE2745827458euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754293470;
	bh=XCJ4mUS0Zqljxl+0xsR/Xtr1rtJVfd83zF4hgcLgcl0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YmCZicYT5HoZX3M1/LaR+Jmyyq2lLLXBPgiL3pXa9gYoHic8us3f1wyxeFENatqcb
	 KAOKZqN3yiBn66HXbYLOQ+FS6Cs75FPrI+uwYu6gwNYKvezeOxWjtWyTWTXZfuWfNr
	 SbZ8uE4egR1Rj07WFZGDnQAz9P+zYuyDRtuAqGZ4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250804074429eucas1p2e907080fb8c5fb239004bcc0a2bcd7e6~YgJ2oZ12f1992219922eucas1p2x;
	Mon,  4 Aug 2025 07:44:29 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250804074428eusmtip16818df9316fcfbaa64df92efe7047970~YgJ1kJHR50614106141eusmtip1O;
	Mon,  4 Aug 2025 07:44:28 +0000 (GMT)
Message-ID: <6caeecdd-cf9a-41af-a744-40831c81fb96@samsung.com>
Date: Mon, 4 Aug 2025 09:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Add TH1520 GPU support with power sequencing
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Drew Fustini <fustini@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250804-sociable-sceptical-snake-f5ac8d@kuoka>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250804074429eucas1p2e907080fb8c5fb239004bcc0a2bcd7e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250801103104eucas1p1dae57601c48faae879b154f11af8a4f1
X-EPHeader: CA
X-CMS-RootMailID: 20250801103104eucas1p1dae57601c48faae879b154f11af8a4f1
References: <CGME20250801103104eucas1p1dae57601c48faae879b154f11af8a4f1@eucas1p1.samsung.com>
	<20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>
	<20250804-sociable-sceptical-snake-f5ac8d@kuoka>



On 8/4/25 08:13, Krzysztof Kozlowski wrote:
> On Fri, Aug 01, 2025 at 12:31:00PM +0200, Michal Wilczynski wrote:
>>
>> v10:
>>  - Squashed the two dt-binding patches back into a single commit.
>>  - Simplified the B-series GPU rule by removing the not clause.
>>  - Reverted the removal of the items definition from the top-level
>>    power-domain-names property, per maintainer feedback.
>>
> 
> You are using b4, so where are all the lore links for each previous
> version? b4 creates proper changelog, so why are you removing them?

Hi,
When I started this series, I was also just beginning to use b4 and
wasn't aware of that feature. I didn't think it was appropriate to
rework the changelog later, so I continued with the manual method. For
newer series, like the Rust support for PWM, I am doing it as you
suggested.

> 
>> v9:
> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

