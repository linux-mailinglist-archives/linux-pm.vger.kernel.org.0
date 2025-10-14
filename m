Return-Path: <linux-pm+bounces-36051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9366BD84B0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E933A3F4A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934712DA760;
	Tue, 14 Oct 2025 08:54:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEE2D248E;
	Tue, 14 Oct 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432062; cv=none; b=SRuLhA25BcL53CfuX7JiSYleF8oY9KOjKamnFmROprIsMpbrtwhrmLz0J098qPxxHYd5Vh8H63NjCQBMwfaTljL//khyhRENgZqfmcUbx+5ItfoIGxVPiyOgg2rLfIUdN6WV1zE0uQt42XQUzjUwSPpBwQvO5XNtgLNkU2bxBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432062; c=relaxed/simple;
	bh=ldoVgEtLTSuT2PC8rBrTT5l7e+FwKnT/6v0P27C0KVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHh9QxdN1iFo7NbMPic1AmHVfnpOaU4xwk+KRvAwspk++/NpRaYXCBSTCQL+h40huKhjBSw7oKvgPsDMcBMEsuZVbwgcPCpkd3WhPux3AwD4wTTyzInUSxv7f9DLn57rnhn+W2xvmvo7M8inXdW/7Nu4JL2AIbfkCvqjMhyMqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817801A9A;
	Tue, 14 Oct 2025 01:54:12 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2AF3F66E;
	Tue, 14 Oct 2025 01:54:18 -0700 (PDT)
Message-ID: <80611bb8-2ea4-4f6c-9dad-774cb65abcf1@arm.com>
Date: Tue, 14 Oct 2025 09:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] PM: EM: Add netlink support for the energy model
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 01:10, Changwoo Min wrote:
> Addressed all the comments from Lukasz and rebased the code to the head
> of the linus tree.
> 
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
>    - EM_CMD_GET_PDS: Get the list of information for all performance
>      domains.
>    - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
>      domain.
> 
> Also, it supports three notification events:
>    - EM_CMD_PD_CREATED: When a performance domain is created.
>    - EM_CMD_PD_DELETED: When a performance domain is deleted.
>    - EM_CMD_PD_UPDATED: When the energy model table of a performance domain
>      is updated.
> 
> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
> with the following commands:
> 
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --do get-pds
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --do get-pd-table --json '{"pd-id": 0}'
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --subscribe event  --sleep 10
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com/
> [3] https://lore.kernel.org/lkml/202506140306.tuIoz8rN-lkp@intel.com/#t

Thank you Changwoo, it looks good.

The patches can go now into some PM testing branches so we can check the
integration/testing in wider configurations.

Regards,
Lukasz

