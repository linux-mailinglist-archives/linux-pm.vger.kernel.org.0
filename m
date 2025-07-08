Return-Path: <linux-pm+bounces-30331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF38AFC03E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 03:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ABB3AF238
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774C1F63F9;
	Tue,  8 Jul 2025 01:56:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2223DE;
	Tue,  8 Jul 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939817; cv=none; b=Yy70g72FnMFUojtXyeyFaWOl3urLfO5ohGp82gC9PDIw/igICaQ86ExGFopsbRAce9FbxKKFOAuf+4/gMqk5xa1Rt5ET2MmZlpFfxhuJBDb9gCA6LrnPapyMWXjvjISrYdqsGYFkdKmTRxfuw4x0bkggKIWGwL4TJhCiqMUv4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939817; c=relaxed/simple;
	bh=ZiEG/+sS9CVb4WOXTTlpz1LpcT0PmfrKAFJ0I1BLFKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgnI46vgKN1uJK4AeiQoiEpcH8mxw+ddC+pmQ/zjHSgzSjHXI3pqxSaNHjhisS+8kL0aNTSY6NdToVJ9IfcEoBE5mf5kTiJUGRToz7Nt81BsYanxZJ1xi/2APTGNYdw9dGt/+TzD0fhJUSmcivSb39QXPkMxVf/s6qLaCGnMYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbkJg2gmYzKHLvw;
	Tue,  8 Jul 2025 09:38:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CFCA31A0C57;
	Tue,  8 Jul 2025 09:38:09 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBnFSOAdmxoCxT_Aw--.28712S2;
	Tue, 08 Jul 2025 09:38:09 +0800 (CST)
Message-ID: <ae4bd50f-b3ac-45b8-8c95-f246e0c19641@huaweicloud.com>
Date: Tue, 8 Jul 2025 09:38:07 +0800
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
 Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <3omgn6ualvnncessgeuc27nmrqmn7ufjvuqfy7v3ppc6irp5xg@unvxbtff3qor>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3omgn6ualvnncessgeuc27nmrqmn7ufjvuqfy7v3ppc6irp5xg@unvxbtff3qor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnFSOAdmxoCxT_Aw--.28712S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1rGF1UWw13Kw17KFyxGrg_yoW8KrW8pF
	Z5G34jkw4ktrWSyrsrAa1UXFs8XrZ7AFyUKrWDKr4UXa1Ygas2qr47Z3y5KF12vrsFgr1U
	ZFnIgw1fA3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/8 0:38, Michal Koutný wrote:
> On Fri, Jul 04, 2025 at 11:02:52AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> Regarding your question: Did you mean that the task was frozen, received
>> another signal to wake up, but should have remained frozen instead of
>> entering the running state?
> 
> My response was a knee-jerk after seeing the move inside the loop.
> Since the task is in __refrigerator(), it would've been already frozen,
> so the 2nd (and more) checks should be OK and it wouldn't escape
> freezing despite the concurrent reader.
> 
> A task in __refrigerator() shouldn't be woken up by a signal, no? So
> your original conservative fix might have been sufficient afterall.
> (A conservative fix is what I'd strive for here, given it's the legacy
> cgroup freezer.)
> 
> Thanks,
> Michal

Thank you, Michal.

try_to_freeze
  if (likely(!freezing(current))) // This guarantees cgroup is not frozen.
	return false;
  __refrigerator
    freezing(current) // The cgroup can't be frozen unless 'current' is frozen.
		      // With the original logic, 'current' cannot escape freezing.

I agree that the original conservative fix is indeed sufficient

However, I'd like to highlight a behavioral change introduced by commit cff5f49d433f
("cgroup_freezer: cgroup_freezing: Check if not frozen"). Before this change, most callers of
freezing(p) would receive true when the cgroup was frozen, whereas now they receive false.

My concern is that the state where freezing(p) returns true (i.e., the cgroup is freezing but not
yet frozen) should be transient. I'm not entirely sure whether all callers of freezing(p) (except
__thaw_task) expect or handle this state correctly. Do the callers want the intermediate freezing
state? I am not sure...

For example, patch 37fb58a7273726e59f9429c89ade5116083a213d ("cgroup,freezer: fix incomplete
freezing when attaching tasks") appears to address an issue that might also be related to commit
cff5f49d433f. This makes me wonder if other callers of freezing(p) could be affected in ways we
haven't yet identified.

Given this, I'm considering whether we should revert commit cff5f49d433f, provided we can safely
remove the WARN_ON_ONCE(freezing(p)) check in __thaw_task. I'd appreciate your thoughts on this
approach.

Best regards,
Ridong


