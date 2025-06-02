Return-Path: <linux-pm+bounces-27961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD1ACAD90
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A103161392
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB761FCFE2;
	Mon,  2 Jun 2025 11:52:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DE2B9A9;
	Mon,  2 Jun 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865157; cv=none; b=saV0t5NVOWnGQuJqM55U4YOvNo09TbpowbU1+y9qLuYMDIXIq2A8SQF+8bcunkNZ1HVpD+tCSF/rWrpK6yZ20Wr/nYSSdDlYxDQrRKylLvqO/XFgITWLkFRdwPiAw41cVKqvFxYFxkIYplFBmTfGvmLhPpO4NvdWE021ylsEZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865157; c=relaxed/simple;
	bh=plGt8Yh563wDSFV4rPiQeq0ptmbRS4pwTXkL3tjHuHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmQJouPiq5ENvyTcu1LeWW0prlH3hbplEhdO9op1uNd+WN77c63GlXlPj1jxMOA+fqVPeJYMtQ8sXCle9egTZs/0a/vQZWBWIC8/xwsbFadVZ7wV44WR8OEO25LRVy2fyPIOtNB6bT9DgAf5Xz53kAaozPDdyP0o5ws8LkRODwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4440712FC;
	Mon,  2 Jun 2025 04:52:18 -0700 (PDT)
Received: from [10.57.25.109] (unknown [10.57.25.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB513F59E;
	Mon,  2 Jun 2025 04:52:32 -0700 (PDT)
Message-ID: <94c5c8c7-be07-4c26-ac39-8123410b0402@arm.com>
Date: Mon, 2 Jun 2025 12:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] PM: EM: Add netlink support for the energy model.
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Changwoo,

On 5/29/25 01:13, Changwoo Min wrote:
> There is a need to access the energy model from the userspace. One such
> example is the sched_ext schedulers [1]. The userspace part of the
> sched_ext schedules could feed the (post-processed) energy-model
> information to the BPF part of the scheduler.
> 
> Currently, debugfs is the only way to read the energy model from userspace;
> however, it lacks proper notification mechanisms when a performance domain
> and its associated energy model change.
> 
> This patch set introduces a generic netlink for the energy model, as
> discussed in [2]. It allows a userspace program to read the performance
> domain and its energy model. It notifies the userspace program when a
> performance domain is created or deleted or its energy model is updated
> through a multicast interface.
> 
> Specifically, it supports two commands:
>    - EM_GENL_CMD_PD_GET_ID: Get the list of information for all performance domains.
>    - EM_GENL_CMD_PD_GET_TBL: Get the energy model table of a performance domain.
> 
> Also, it supports three notification events:
>    - EM_GENL_EVENT_PD_CREATE: When a performance domain is created.
>    - EM_GENL_EVENT_PD_DELETE: When a performance domain is deleted.
>    - EM_GENL_EVENT_PD_UPDATE: When the energy model table of a performance domain is updated.
> 
> The userspace code example using the EM netlink interface is at [3].
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com/
> [3] https://github.com/multics69/em-netlink/tree/patch-v1

Thanks for the patch set and for the reference code in user-space.
I will give it a try and then do the review.

Regards,
Lukasz

