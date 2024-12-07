Return-Path: <linux-pm+bounces-18730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05AD9E7E4E
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 06:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A5116B751
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E86381AF;
	Sat,  7 Dec 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GNFVt4gn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9433F7
	for <linux-pm@vger.kernel.org>; Sat,  7 Dec 2024 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548935; cv=none; b=DaItMZaVGgUA6Q+i7GkjS7w4jipzgDKmh8BoCsHcOrHiKSJAbguO1RMmmojzbQHAJ+CYBeRYc0HJMTvQgOtU8HPtIQfJj9FJO8QzdtVw9zzB5pGhkf68SWA8yzyaByIY0HuV/lHooj2YAtLE8pvcZTZI4W3WZSISPrZzeWDCfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548935; c=relaxed/simple;
	bh=zrcTlF0qLVXhLkImc+yMqP9DZOJQ0haUmEV5cjEQFtU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=MRl2UzVzKrc3qVp2STWoU/EB7RT4rUCmBiPj0Ijz2xXgToeg1lQU/zJ1SzN5+NozGf1lnsrMDlpSUmhnLTrRN7domB4gvOj5f7rcSsHkKfT9JKIlNFLxc8mf5R2docKQRse2URdj4LkNWnTO4oJihnTL+D6gwO0upS/xq1sm1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GNFVt4gn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241207052210epoutp048c8df5b5e3f69ed63b9e2a7dc0a9e8b3~OzZFa1-a41581815818epoutp04W
	for <linux-pm@vger.kernel.org>; Sat,  7 Dec 2024 05:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241207052210epoutp048c8df5b5e3f69ed63b9e2a7dc0a9e8b3~OzZFa1-a41581815818epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733548930;
	bh=sTB/Ibdf9VV3DvUuDDRzZSG4Ryd7mNnDpcZrkAkmKkU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=GNFVt4gnDSBNJTWeGzRq8v0aMvghQKlfT3ZkfkDnj1LnABWy9KyB+CiUVmZxuWmHt
	 WFruPkxkJBiLgYWiw3mkcpaZJKZ+HrPc7a5U1ROXL5aFB+5jzIhYQ8Drbqa6NwIDxB
	 ugO6MD2F10a/EClTD0DMW5LS8/JJh1cNzoxhTD+4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20241207052210epcas1p47c59109d74aca5ec07e0864f9342eb9b~OzZE_X9130317603176epcas1p4S;
	Sat,  7 Dec 2024 05:22:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.133]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y4xMP2vFlz4x9Pw; Sat,  7 Dec
	2024 05:22:09 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-5b-6753db81a33f
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.A3.23869.18BD3576; Sat,  7 Dec 2024 14:22:09 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: Remove unused
 devm_devfreq_(un)register_notifier
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Z0iWPCzjv9YQ4kO_@gallifrey>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241207052209epcms1p45818db425ba84821003b6d735bc0e957@epcms1p4>
Date: Sat, 07 Dec 2024 14:22:09 +0900
X-CMS-MailID: 20241207052209epcms1p45818db425ba84821003b6d735bc0e957
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmvm7j7eB0g80XRC2uf3nOanG26Q27
	xcK2JSwWl3fNYbP43HuE0WL98xtMDmwefVtWMXqsXD6B3ePzJrkA5qhsm4zUxJTUIoXUvOT8
	lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
	/NKSVIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwJDx0KtnFVfJ4Q1MDY
	ztnFyMkhIWAisaWjhw3EFhLYwShx559AFyMHB6+AoMTfHcIgYWGBSIlTO7awQ5QoSTTc3McM
	EdeX6HiwjRHEZhPQldi64S4LiC0iYCCx+dd+pi5GLg5mgS4mibPrzzBD7OKVmNH+lAXClpbY
	vnwrWDOngKbElGdroGpEJW6ufssOY78/Np8RwhaRaL13FqpGUOLBz91QcUmJvjt7wZZJCGxj
	lNhxZA4bhLOfUWLKwzaoSfoSZ+aeBPuSV8BX4tGsmUwgNouAqsSLLbehprpIbJ52CqyGWUBe
	YvvbOcygkGAGum79Ln2IMJ/Eu689rDDP7Jj3hAnCVpM4tHsJ1CoZidPTF0KN9JCYvxzkBC5g
	yM1jlNh66jDLBEb5WYgAnoVk2yyEbQsYmVcxiqUWFOempxYbFhjBIzQ5P3cTIzjZaZntYJz0
	9oPeIUYmDsZDjBIczEoivJVhgelCvCmJlVWpRfnxRaU5qcWHGE2B/pzILCWanA9Mt3kl8YYm
	lgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqemFqQWwfQxcXBKNTA5sxcdK2gIX9DyevfxjPOe
	j/9fzzh99eSJ/CWrzIzMgwtu7F+56/zrHQflLFZavW8tvNpb0pZxq+ZT9uEEe/fa71l2/zjE
	g2onv/rYPfGd5kNryciU4An6e6YLzedJVGmakW93yYM9xPxAb0eulezT5yqBN5v2XMv9c+WF
	4sUt/nu0919nUrnwi135/ZUokcxVm+oOxW//luu5fvoB2Vu36yR2Ol8/Y8DUsfLbs5RbB3qf
	vC2/YbB8NefiZTyr9pz4m2l+dfuyeVpyuuapflHtXhVxaUvKU9Z+ZHVbYFv46MUnBflNtzfr
	PF5V8DD4YZvL996uIoGTb9prrx7dsHP6ZZeXi2ru1IY7vVLccTLyoxJLcUaioRZzUXEiANGJ
	lx7/AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128161146epcas1p46768d7685092deaa817119db30fd12f2
References: <Z0iWPCzjv9YQ4kO_@gallifrey>
	<20241028021344.477984-1-linux@treblig.org>
	<CGME20241128161146epcas1p46768d7685092deaa817119db30fd12f2@epcms1p4>

>* linux@treblig.org (linux@treblig.org) wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> 
>> devm_devfreq_register_notifier() and devm_devfreq_unregister_notifier()
>> have been unused since 2019's
>> commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers")
>> 
>> Remove them, and the helpers they used.
>> 
>> Note, devm_devfreq_register_notifier() is still used as an example
>> in Documentation/doc-guide/contributing.rst but that's just
>> an example of an old doc bug rather than anything about the function
>> itself.
>> 
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
>Ping.
>
>Thanks,
>
>Dave

When I search github, it appears that vendors are using this API.


NVIDIA:
https://github.com/NX-Development/android_kernel_nvidia_nvidia/blob/c9ade3b5e32a12b8cf6f33a632dc39209194e4e8/drivers/devfreq/governor_wmark_active.c#L624

Samsung:
https://github.com/Vaz15k/android_kernel_samsung_a54x/blob/8ac517c37c606746213064857dc240e99eba80d2/drivers/soc/samsung/exynos-llcgov.c#L107

Realtek:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/25f5b88ec4ba34029f964693dc34028b26e6c67c/linux-rtk/drivers/devfreq/realtek/governor_rtk_ltl.c#L114



Please don't remove ABIs used by vendors even if
they didn't upstream their drivers.

Cheers,
MyungJoo.

