Return-Path: <linux-pm+bounces-26978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE7AB2127
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 06:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F9A1C01FC5
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 04:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5E1A317E;
	Sat, 10 May 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I2PmAVQC"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714911712;
	Sat, 10 May 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852056; cv=none; b=Fmtwu/xcUPsm72a/y75ZjU8FvqRWyfSKT1tdL8zmgiKDbDISRyGnk6eybxODPMbQrLHckVre34Gk6ZBVaMbZ/mdNfRLGgR9/iuBz28G5qTj0Foi13Z76fs/jfEGOELvuBM2zgaasUhSgSABqROomhwgAsEXVKgRj0K9dbVf/3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852056; c=relaxed/simple;
	bh=jTHIkAq0vDYW4ceZDtB7fZ4URl3MLSGgA69/Ee18wQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNlQdNXdF2mCEypOmrEzUwZRG9ESLZoziyC6ikpfddJ8HzgxRLod4tb1vIRebL+yhjGnNT3szGDadqPEvrA7o0oqH0TSW82X4Dkh4xneyCDsOIWwmv9dtuc5BySo6rAbu8z/w8NE8s3p05lBs3tYSEZLJuZzT52ZuELBUHIi1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I2PmAVQC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/lN44O3XrR2VBQqL6sjWL92zE4CKd19p9D4vTjvHmnE=; b=I2PmAVQCm7r+Pdy5aIgazKzTik
	/1waYXWzKWOyMRPLlz2iS6Xu10K9bCXtHB/+Vc5k1q0Ep2nJBN+X5KKaExNiES+EBTqDplsJhunrp
	jPbyXujxQQgF5ctd+D/II6df6JYGhxF1GkVn6sCtnmcp7HPjVP+FgqaaN+YUL++XfJVcaaETeUwOd
	qEC4WGnxOEplweG40rFK6nrKP3t3BcEh6Jm6khODE9dEXzue7eQ7uTjTXafXTKw2vGrCHnVYWrd4w
	H4wHJmF1PU2/3VPQUPr4N3SYwLThgVAH79IGnoCiwJA4ZN+RztBcZH9W02Chv4o2F8golE2eC8ADR
	Db2axiDw==;
Received: from [106.101.9.89] (helo=[192.168.6.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uDbwL-0064SW-6U; Sat, 10 May 2025 06:40:43 +0200
Message-ID: <69341122-4c69-446b-9b57-5b69d955edb7@igalia.com>
Date: Sat, 10 May 2025 13:40:35 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, rafael@kernel.org,
 pavel@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, len.brown@intel.com
References: <20250507014728.6094-1-changwoo@igalia.com>
 <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukasz and Rafael,

Thank you for the pointers and guidance.

On 5/9/25 19:55, Lukasz Luba wrote:
> Hi Changwoo,
> 
> On 5/7/25 02:47, Changwoo Min wrote:
>> The sched_ext schedulers [1] currently access the energy model through 
>> the
>> debugfs to make energy-aware scheduling decisions [2]. The userspace part
>> of a sched_ext scheduler feeds the necessary (post-processed) energy- 
>> model
>> information to the BPF part of the scheduler.
>>
>> However, there is a limitation in the current debugfs support of the 
>> energy
>> model. When the energy model is updated (em_dev_update_perf_domain), 
>> there
>> is no way for the userspace part to know such changes (besides polling 
>> the
>> debugfs files).
>>
>> Therefore, add inotify support (IN_MODIFY) when the energy model is 
>> updated.
>> With this inotify support, the directory of an updated performance domain
>> (e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory 
>> (e.g.,
>> /sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
>> scheduler (or any userspace application) monitors the energy model change
>> in userspace using the regular inotify interface.
>>
>> Note that accessing the energy model information from userspace has many
>> advantages over other alternatives, especially adding new BPF kfuncs. The
>> userspace has much more freedom than the BPF code (e.g., using external
>> libraries and floating point arithmetics), which may be infeasible (if 
>> not
>> impossible) in the BPF/kernel code.
>>
>> [1] https://lwn.net/Articles/922405/
>> [2] https://github.com/sched-ext/scx/pull/1624
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>
>> ChangeLog v1 -> v2:
>>    - Change em_debug_update() to only inotify the directory of an updated
>>      performance domain (and its parent directory).
>>    - Move the em_debug_update() call outside of the mutex lock.
>>    - Update the commit message to clarify its motivation and what will be
>>      inotified when updated.
>>
>>   kernel/power/energy_model.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
> 
> I have discussed that with Rafael and we have similar view.
> The EM debugfs is not the right interface for this purpose.
> 
> A better design and mechanism for your purpose would be the netlink
> notification. It is present in the kernel in thermal framework
> and e.g. is used by Intel HFI
> - drivers/thermal/intel/intel_hfi.c
> - drivers/thermal/thermal_netlink.c
> It's able to send to the user space the information from FW about
> the CPUs' efficiency changes, which is similar to this EM modification.


I have considered netlink before. However, I chose the debugfs-inotify
path since it requires fewer changes.

However, if the netlink interface is better for this purpose (I agree
*debugfs* is not ideal), sure let's go with that direction.

> 
> Would you be interested in writing similar mechanism in the EM fwk?

Sure, I will work on it and send another patch set.

> 
> Regards,
> Lukasz
> 
> _______________________________________________
> Kernel-dev mailing list -- kernel-dev@igalia.com
> To unsubscribe send an email to kernel-dev-leave@igalia.com
> 


