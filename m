Return-Path: <linux-pm+bounces-23630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FADA56866
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481A71889ED4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41112940B;
	Fri,  7 Mar 2025 13:02:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16E219EAD;
	Fri,  7 Mar 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352577; cv=none; b=DYfkS3as1/eKP7f98ZyB67eoHL9X5vU5OF5CcBjclXOKUsDHaLEgiHJFAFN454cyZFtMl1QlmsYgt9vyCudOgd3nScvNyDu/lzjIHNXdHRbpua8XLxzSKWMOpJsh9SbEZhW0jpdrvGaHD01jes5VMMNUdxk8QAKuRzx8Mx7AS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352577; c=relaxed/simple;
	bh=WEqfAtflcOZXdqVx77syZFjRqAPFCh/u0vjErVeCWYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPwilvuq9EMfZsUXbuMtQTdetoBwywMdZb7kz2/Vbmhzhq/craVbE/rxDssbv0L+UO7c5FNEoa4o/9GaIVBz4YgSDCiAA5yKYffozjfAvTaJmR1I60sVqFrElZ414JDAyVh5jo0H+y2CHNBvBWTE2z4w272RvKAqZ10Qt4chkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6491477;
	Fri,  7 Mar 2025 05:03:06 -0800 (PST)
Received: from [10.57.84.65] (unknown [10.57.84.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E3483F66E;
	Fri,  7 Mar 2025 05:02:52 -0800 (PST)
Message-ID: <4a538376-bf74-4c51-bfa8-a86f67790662@arm.com>
Date: Fri, 7 Mar 2025 13:02:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Address RCU-related sparse warnings
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <5885405.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5885405.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/25 16:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The usage of __rcu in the Energy Model code is quite inconsistent
> which causes the following sparse warnings to trigger:
> 
> kernel/power/energy_model.c:169:15: warning: incorrect type in assignment (different address spaces)
> kernel/power/energy_model.c:169:15:    expected struct em_perf_table [noderef] __rcu *table
> kernel/power/energy_model.c:169:15:    got struct em_perf_table *
> kernel/power/energy_model.c:171:9: warning: incorrect type in argument 1 (different address spaces)
> kernel/power/energy_model.c:171:9:    expected struct callback_head *head
> kernel/power/energy_model.c:171:9:    got struct callback_head [noderef] __rcu *
> kernel/power/energy_model.c:171:9: warning: cast removes address space '__rcu' of expression
> kernel/power/energy_model.c:182:19: warning: incorrect type in argument 1 (different address spaces)
> kernel/power/energy_model.c:182:19:    expected struct kref *kref
> kernel/power/energy_model.c:182:19:    got struct kref [noderef] __rcu *
> kernel/power/energy_model.c:200:15: warning: incorrect type in assignment (different address spaces)
> kernel/power/energy_model.c:200:15:    expected struct em_perf_table [noderef] __rcu *table
> kernel/power/energy_model.c:200:15:    got void *[assigned] _res
> kernel/power/energy_model.c:204:20: warning: incorrect type in argument 1 (different address spaces)
> kernel/power/energy_model.c:204:20:    expected struct kref *kref
> kernel/power/energy_model.c:204:20:    got struct kref [noderef] __rcu *
> kernel/power/energy_model.c:320:19: warning: incorrect type in argument 1 (different address spaces)
> kernel/power/energy_model.c:320:19:    expected struct kref *kref
> kernel/power/energy_model.c:320:19:    got struct kref [noderef] __rcu *
> kernel/power/energy_model.c:325:45: warning: incorrect type in argument 2 (different address spaces)
> kernel/power/energy_model.c:325:45:    expected struct em_perf_state *table
> kernel/power/energy_model.c:325:45:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:425:45: warning: incorrect type in argument 3 (different address spaces)
> kernel/power/energy_model.c:425:45:    expected struct em_perf_state *table
> kernel/power/energy_model.c:425:45:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:442:15: warning: incorrect type in argument 1 (different address spaces)
> kernel/power/energy_model.c:442:15:    expected void const *objp
> kernel/power/energy_model.c:442:15:    got struct em_perf_table [noderef] __rcu *[assigned] em_table
> kernel/power/energy_model.c:626:55: warning: incorrect type in argument 2 (different address spaces)
> kernel/power/energy_model.c:626:55:    expected struct em_perf_state *table
> kernel/power/energy_model.c:626:55:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:681:16: warning: incorrect type in assignment (different address spaces)
> kernel/power/energy_model.c:681:16:    expected struct em_perf_state *new_ps
> kernel/power/energy_model.c:681:16:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:699:37: warning: incorrect type in argument 2 (different address spaces)
> kernel/power/energy_model.c:699:37:    expected struct em_perf_state *table
> kernel/power/energy_model.c:699:37:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:733:38: warning: incorrect type in argument 3 (different address spaces)
> kernel/power/energy_model.c:733:38:    expected struct em_perf_state *table
> kernel/power/energy_model.c:733:38:    got struct em_perf_state [noderef] __rcu *
> kernel/power/energy_model.c:855:53: warning: dereference of noderef expression
> kernel/power/energy_model.c:864:32: warning: dereference of noderef expression
> 
> This is because the __rcu annotation for sparse is only applicable to
> pointers that need rcu_dereference() or equivalent for protection, which
> basically means pointers assigned with rcu_assign_pointer().
> 
> Make all of the above sparse warnings go away by cleaning up the usage
> of __rcu and using rcu_dereference_protected() where applicable.
> 
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This replaces
> 
> https://lore.kernel.org/linux-pm/1929404.tdWV9SEqCh@rjwysocki.net/
> 
> and
> 
> https://lore.kernel.org/linux-pm/13728396.uLZWGnKmhe@rjwysocki.net/
> 
> ---
>   include/linux/energy_model.h |   12 ++++++------
>   kernel/power/energy_model.c  |   39 ++++++++++++++++++++-------------------
>   2 files changed, 26 insertions(+), 25 deletions(-)
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

