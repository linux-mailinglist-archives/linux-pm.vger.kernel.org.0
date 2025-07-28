Return-Path: <linux-pm+bounces-31452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C4B1335C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 05:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BC01894EDD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8A1F5434;
	Mon, 28 Jul 2025 03:11:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F779478;
	Mon, 28 Jul 2025 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672315; cv=none; b=ZpBoQ3lTNosMcKhbmcmGm9rRgKP4C0uExEWXiGSSclQQR3m/ODfnFnLAVFwcJGm8n0FhZgUVB3nWFov0wlCiU/l+0T9cEuCP6BgObkdOxi9DQJmrTYWI9Ss5dDszuGszemaRZVEukFFf6fFbTKLCpAoGVAIJLsMeuCcLmtnoHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672315; c=relaxed/simple;
	bh=lA9byzcRh6Vdns9wF11fA5f3gou2BCb++icUIzWPVFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GIGuLyuq0Rvr5EoF0HnSnV6Y5WeJAiC1udpclT1MjHf6WGxSMu3djVUEqFA9NHj5jqpQHdkQFcAQuHMRrVmqlHgpt46gxj/kaBW4YZyXUEyvjQs3IwWIgn3rluwGEKwVsmytoA+ROHs87oKksLu/lvlVz3iTZKF8blQRsEnOn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4br3RX5zZMzKHMfW;
	Mon, 28 Jul 2025 11:11:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A846A1A111F;
	Mon, 28 Jul 2025 11:11:51 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAn7dd06oZo80TLBg--.27709S2;
	Mon, 28 Jul 2025 11:11:49 +0800 (CST)
Message-ID: <e2f593ea-fec0-4e81-b470-453eee3bc47e@huaweicloud.com>
Date: Mon, 28 Jul 2025 11:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/5] [Backport] sched,freezer: Remove unnecessary
 warning in __thaw_task
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, rafael@kernel.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728024121.33864-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250728024121.33864-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAn7dd06oZo80TLBg--.27709S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtw1kuw1kur1Uur18Ar47Arb_yoW8JrWxpa
	nxurW3Cr1jyr17Gr4fAw4akr15tws3JryUCr42vw18JryYya4Ygr97uF4FgFWjgryvkryU
	tF15uwn2kF4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/28 10:41, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> To fix the [1] issue, it needs to backport:
> 9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...")
> 14a67b42cb6f ("Revert 'cgroup_freezer: cgroup freezing: Check if not...'").
> 
> This series aims to backport 9beb8c5e77dc. To avoid conflicts, backport the
> missing patches[2].
> 
> [1] https://lore.kernel.org/lkml/20250717085550.3828781-1-chenridong@huaweicloud.com/
> [2] https://lore.kernel.org/stable/2025072421-deviate-skintight-bbd5@gregkh/
> 
> Chen Ridong (1):
>   sched,freezer: Remove unnecessary warning in __thaw_task
> 
> Elliot Berman (4):
>   sched/core: Remove ifdeffery for saved_state
>   freezer,sched: Use saved_state to reduce some spurious wakeups
>   freezer,sched: Do not restore saved_state of a thawed task
>   freezer,sched: Clean saved_state when restoring it during thaw
> 
>  include/linux/sched.h |  2 --
>  kernel/freezer.c      | 51 +++++++++++++++++--------------------------
>  kernel/sched/core.c   | 31 +++++++++++++-------------
>  3 files changed, 35 insertions(+), 49 deletions(-)
> 

Please, ignore this, I should send this patches to the stable branch.

Best regards,
Ridong


