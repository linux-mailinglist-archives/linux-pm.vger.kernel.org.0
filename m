Return-Path: <linux-pm+bounces-10365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D1924490
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272B11C21E6A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365CD1BE234;
	Tue,  2 Jul 2024 17:12:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA315218A;
	Tue,  2 Jul 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940328; cv=none; b=SE8v9ekHpwtjLeuqiddzB9W978U7Ti4CL1ecNpoUBzV/PxzBgAen1Chm5tMiPS48JNtjD5wMzYvB0IjlEv2HlA511CqgOB63CaVNgWVj+75ZhA18Ex4pd+lH6YDGhJ9zS4OxsSLmvGqwL5RSGLYq7K+Slebg8s/z35pMzj2VY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940328; c=relaxed/simple;
	bh=OO4RDTbDrd5/pF3NmruVBtYwZwqibJ+oqEtHhjEtSs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg0otu6E1yL1h1Ivb5uz1asN8BWZwk/G6vwbR77ad4xPDb2pFmp3frNuf1xUf9qqKudHfDpLEwTWWoDA5UYh6DSyRuOFMdegC5z3THGCOBTDdUsjndbmlq4maMA2X0N8IxaL/K09kFdxZEYgo+QQ8dyPsansy1aezQfMNHfrgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A22D339;
	Tue,  2 Jul 2024 10:12:30 -0700 (PDT)
Received: from [10.1.34.77] (e133649.arm.com [10.1.34.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2BF3F73B;
	Tue,  2 Jul 2024 10:12:02 -0700 (PDT)
Message-ID: <940a41d0-2660-4a7a-ad07-581b3ac24cca@arm.com>
Date: Tue, 2 Jul 2024 18:12:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
 <ZoQs384bAMuaeDEs@slm.duckdns.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <ZoQs384bAMuaeDEs@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2024 17:37, Tejun Heo wrote:
> Hello, Hongyan.
> 
> On Tue, Jul 02, 2024 at 11:23:58AM +0100, Hongyan Xia wrote:
>> What would be really nice is to have cpufreq support in sched_ext but not
>> force uclamp_enabled. But, I also think there will be people who are happy
>> with the current uclamp implementation and want to just reuse it. The best
>> thing is to let the loaded scheduler decide, somehow, which I don't know if
>> there's an easy way to do this yet.
> 
> I don't know much about uclamp but at least from sched_ext side, it's
> trivial add an ops flag for it and because we know that no tasks are on the
> ext class before BPF scheduler is loaded, as long as we switch the
> uclamp_enabled value while the BPF scheduler is not loaded, the uclamp
> buckets should stay balanced. AFAICS, the only core change we need to make
> is mooving the uclamp_enabled bool outside sched_class so that it can be
> changed runtime. Is that the case or am I missing something?
> 

Pretty much. Just to clarify what I meant, it would be fantastic if for 
ext, sched_class->uclamp_enabled is decided the moment we load the 
custom scheduler, not globally enabled all the time for all ext 
schedulers, in case the custom scheduler wants to ignore uclamp or has 
its own uclamp implementation. During ext_ops->init(), it would be great 
if the loaded scheduler could decide whether its 
sched_class->uclamp_enabled should be enabled.

However, sched_class->uclamp_enabled is just a normal struct variable, 
so I cannot immediately see a clean way to let the loaded scheduler 
program this field. We might be able to expose a function from the 
kernel side to write sched_class->uclamp_enabled during ext_ops->init(), 
although that looks a bit messy.

