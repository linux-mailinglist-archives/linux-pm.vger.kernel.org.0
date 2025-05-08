Return-Path: <linux-pm+bounces-26872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B678AAAF351
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 08:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059121BA392B
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72B20458A;
	Thu,  8 May 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="In1EvUYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2E1D63F2;
	Thu,  8 May 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684224; cv=none; b=P9VcAOmEKIueV4/QAcNdf39LZKa/Y6cSPFMerAVJSHM5ENeL6P07dW6hfm7Q+r6UdxV+ltGfH9sQfT70cOERYdHvaeZYD1y0pcb6jFhB+EYSUdawjYfjVLBKKHgZl49ZSfdl2awDkeeHt1Az22ZwEw3tluFolRaO+TR9pTAKImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684224; c=relaxed/simple;
	bh=bRnW3Rj42dmu+MSemV2pmY3BVeTfBhC2aWro+Kc8JoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAKqlNG1qkAgDISvxS1bdVX/tM28Q7xkEjizcbPD4cdfyZM/WMR2XkErw5Y4RHByayG6vTIyQai/nRZOpTi1oLyCdzmP46jsif+NWi1MC+3B4bWp/cZW+nFAFmnTptgUFEWfqopaBRqpMDhiIUvYJlyG7nz7g49H+umyGOcDexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=In1EvUYW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KDm/eb1w/UbVninGwxnaQ5D1cU9RrPF0qzkMZk+NDtA=; b=In1EvUYWwSlBUHGPzPd5ScsBxd
	Ux4HfkkG9NfWidls4TlsX1zEPl6/wz/plB+D9/qFTngrGlLdMENGAYp856Vij5TEPYqgBtVOV0XzO
	OUk5P5PVtLM10SAB+AWuthbZwMMWrT6wd+lOqhuVowe/M0gF7b4fiDaFwjfb9bocx9cppb7+6MRQQ
	Pza+UuhdpGSD0lJkjSdNf+MFeNDHfkJfq4matwkFuDFn7QAfKsyGlbc164lUICd7MtabaoF/co/uy
	5QNMdio53ujxjcLmEj5wV8NUFDlz8ESmPMwx5BQdQizbTGsscyFyyfrTPTpGgid2Gdy2lhrfoFrZi
	QMmeo7mA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uCuHl-0053La-DO; Thu, 08 May 2025 08:03:19 +0200
Message-ID: <98552c3b-4cd5-4dfe-8439-e8cc0cd99e39@igalia.com>
Date: Thu, 8 May 2025 15:03:13 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: Tejun Heo <tj@kernel.org>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, christian.loehle@arm.com, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507014728.6094-1-changwoo@igalia.com>
 <aBuSmITszR9AdoyL@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aBuSmITszR9AdoyL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

Thanks for the comments!

On 5/8/25 02:04, Tejun Heo wrote:
> Hello,
> 
> On Wed, May 07, 2025 at 10:47:28AM +0900, Changwoo Min wrote:
>> The sched_ext schedulers [1] currently access the energy model through the
>> debugfs to make energy-aware scheduling decisions [2]. The userspace part
>> of a sched_ext scheduler feeds the necessary (post-processed) energy-model
>> information to the BPF part of the scheduler.
>>
>> However, there is a limitation in the current debugfs support of the energy
>> model. When the energy model is updated (em_dev_update_perf_domain), there
>> is no way for the userspace part to know such changes (besides polling the
>> debugfs files).
>>
>> Therefore, add inotify support (IN_MODIFY) when the energy model is updated.
>> With this inotify support, the directory of an updated performance domain
>> (e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory (e.g.,
>> /sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
>> scheduler (or any userspace application) monitors the energy model change
>> in userspace using the regular inotify interface.
>>
>> Note that accessing the energy model information from userspace has many
>> advantages over other alternatives, especially adding new BPF kfuncs. The
>> userspace has much more freedom than the BPF code (e.g., using external
>> libraries and floating point arithmetics), which may be infeasible (if not
>> impossible) in the BPF/kernel code.
>>
>> [1] https://lwn.net/Articles/922405/
>> [2] https://github.com/sched-ext/scx/pull/1624
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> 
> FWIW, this looks simple enough and workable to me. Just a nit below:
> 
>> +static void em_debug_update(struct device *dev)
>> +{
>> +	struct dentry *d;
>> +
>> +	d = debugfs_lookup(dev_name(dev), rootdir);
>> +	fsnotify_dentry(d, FS_MODIFY);
>> +}
> 
> Would something like em_debug_notify_updated() or em_debug_updated() be
> better? em_debug_update() sounds like it's actively updating something.

I agree that em_debug_update() sounds misleading.
em_debug_notify_updated() delivers clear meaning, so I will change it as
you suggested.

Regards,
Changwoo Min

> 
> Thanks.
> 


