Return-Path: <linux-pm+bounces-30650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88AB0105E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB865A5BD3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFD111BF;
	Fri, 11 Jul 2025 00:51:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD462539A;
	Fri, 11 Jul 2025 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195098; cv=none; b=uSVM/K+SNMIvJrRRiqsMxkF3zhOho9y8EIKRvreAr1BXiutymQXH1jCTyiMq/7zEgK0OTZbjG+lQPSqL8mHP/XJKCD/OmzafwNrKhf0e5I6gHiXy5g9VHlAoEM7ITaS0pHsUmyMRzqLuOtQfj1k0nAf6Cc1sygEFjriPuZxnZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195098; c=relaxed/simple;
	bh=oG/czHYAJAFofXdXeatPMIcCvpv6wBP7+ILq7Dt5cnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWHp52jGhVZpooIxxeyhyYNamDCK8/Tr/M8WiFyUthKEbMwr3A6MaMyv1eW0BqbEuGfR/3gr/7+xSoKPBAGinnfUtk8z0knUvg0NTwdkWtwUWXI9lhPbNgPcS5esbYwawSUP+1yGywVNWZ26gezu4buYlYrQw2S5qPNfW/YmlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bdY7P0ztczKHN7f;
	Fri, 11 Jul 2025 08:51:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A21961A1651;
	Fri, 11 Jul 2025 08:51:27 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAn3r4OYHBoBndVBQ--.60650S2;
	Fri, 11 Jul 2025 08:51:27 +0800 (CST)
Message-ID: <9c1a5188-5eb9-4169-afa4-2e4d1819e423@huaweicloud.com>
Date: Fri, 11 Jul 2025 08:51:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, timvp@google.com,
 rafael@kernel.org, pavel@kernel.org, tj@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
 <2v47s2xlbmuz2mgxk2p7o2q4t343nde6hkyqxpmfgmrjygmrz7@alrwuxvupe36>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2v47s2xlbmuz2mgxk2p7o2q4t343nde6hkyqxpmfgmrjygmrz7@alrwuxvupe36>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn3r4OYHBoBndVBQ--.60650S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDJw47uw4Dtr13WF1rZwb_yoWDAwcE93
	y3trn3Aws3GF4rKFnF939xWrW7Ca12gr15Jr1kXrZxury2va1ruFnrKr9xJFnxXw1DXr9r
	Z3s5KFZruwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/10 23:44, Michal Koutný wrote:
> On Mon, Jul 07, 2025 at 12:02:47PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task and started wondering: since we
>> already have !frozen(p) check, is this warning still needed? If we can remove it, maybe reverting
>> commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen") would be a better approach.
> 
> I think freezing(p) (the part of global freezer) and cgroup_freezing(p)
> should be consistent with each other. AFAICS, the former predicate is
> derived from pm_freezing and that is set all the time between
> freeze_processes() and thaw_processes(), i.e. it stands for both the
> transition (freezing) and goal (frozen).
> With that, the warning in __thaw_task() is incorrect and the solution
> might be the revert + drop the warning.
> 

I'd suggest reverting the commit and dropping the warning. What are your thoughts on this, Peter?

Best regards,
Ridong


