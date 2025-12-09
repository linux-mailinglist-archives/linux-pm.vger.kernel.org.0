Return-Path: <linux-pm+bounces-39326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E543BCAED2B
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 04:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3539300941F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFD301026;
	Tue,  9 Dec 2025 03:40:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B34301012;
	Tue,  9 Dec 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251637; cv=none; b=scWWSWURQYjdHsU5kwSyoOI7laK5kN+g4y2Yc++7m+yeWPVndnVi7y72BNBe4A6Lqc8gcx3DTV+K5MBfED3NPz8m9J3VZEzBwgCZ6gtaFPzTeQeedq4mmLzUo8ofT4eV6sHeOKD1TWCojyk0FUv8GI32jodJ0zOHlq9ZmjWhqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251637; c=relaxed/simple;
	bh=//QYSpLRCVv+1hgJeyl9oPQfEr6HmP7rKh9n0l4B/8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nE1ApvpRth2i471HZ3wsPkOGCRFsvQCsS9DPfMJV9VzA+xZ8xIwI18IJtQ1pSs9x6/6yKYlD1UPZ1QImXHLLfm1kZkWNd/D8dl/GcE+CKuMvaIm7KUCX8EF2XwZhPSvnTnFfwKKa9vxfoEcxZnXW+/tbzCUQv4JxmEIqpTXDCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dQPkb0hQgz1BGBb;
	Tue,  9 Dec 2025 11:40:23 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dQPhL6hzDzLlVy;
	Tue,  9 Dec 2025 11:38:26 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4372A180043;
	Tue,  9 Dec 2025 11:40:22 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Dec
 2025 11:40:21 +0800
Message-ID: <3f1d0292-3ac9-48ff-a87e-00fafe638ad3@hisilicon.com>
Date: Tue, 9 Dec 2025 11:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20251205083724.4068896-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20251205083724.4068896-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 12/5/2025 4:37 PM, Pengjie Zhang wrote:
> Previously, non-generic attributes (polling_interval, timer) used separate
> create/delete logic, leading to race conditions during concurrent access in
> creation/deletion. Multi-threaded operations also caused inconsistencies
> between governor capabilities and attribute states.
> 
> 1.Use is_visible + sysfs_update_group() to unify management of these
> attributes, eliminating creation/deletion races.
> 2.Add locks and validation to these attributes, ensuring consistency
> between current governor capabilities and attribute operations in
> multi-threaded environments.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
Other than a few minor things that Jonathan posted,
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>

Thanks!
> ---
> changes in v4:
> -Remove the DEFINE_SYSFS_GROUP_VISIBLE macro and directly set the is_visible function.
> -Remove unnecessary ret variables
> Link to v3:https://lore.kernel.org/lkml/20251107031706.1698396-1-zhangpengjie2@huawei.com/
> 
> changes in v3:
> - Use guard() to simplify lock acquisition and destruction.
> - Eliminate redundant checks for df.
> Link to v2:https://lore.kernel.org/lkml/20251028022458.2824872-1-zhangpengjie2@huawei.com/
> 
> Changes in v2: 
> - Fix one problem reported by the kernel test robot.
> - Redirect all error paths in timer_store() to out to ensure locks are not 
>  left unReleased.
> Link to v1:https://lore.kernel.org/lkml/20251025135238.3576861-1-zhangpengjie2@huawei.com/
> 
>  drivers/devfreq/devfreq.c | 99 +++++++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 41 deletions(-)
...

