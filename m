Return-Path: <linux-pm+bounces-36652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679BBFC162
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBD6E0D65
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542C34844D;
	Wed, 22 Oct 2025 13:02:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EB34844B;
	Wed, 22 Oct 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138148; cv=none; b=YMAtyZ/P4ssZDr8046F9HJV0BgmpvcqNr3xwBXscpsF1fT1lVDNefkavupELSO8/tJgwfu3zMErYTUeK8366C87CkggxY9zShh331yOHX+qdpA6SdvIxkWHLXDjXENNnmbmZ5uaJxIm/DO+Yv56P2avTPj5ur8uWUwv6Z9wm1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138148; c=relaxed/simple;
	bh=Oda9TZtpxUpreGTD3UlQdCQSW0MTkjACPrygaQlBWME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNwQo3BIDd1rHYtzxgnkXakMLT7sax2hlwn4M55Rukjkxle0+Gge4G0yQwf4HcnK2wQsM4TtsUD/HbiMRCB17LvIfr9OSMayGbRYr8jSi1zBckDLHtd3teWQAulb18zOKDt2SNflTVZsdHA8I4DKlGQbXqQ8isGW8DEdhaEq/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D7741655;
	Wed, 22 Oct 2025 06:02:16 -0700 (PDT)
Received: from [10.57.6.1] (unknown [10.57.6.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18AF33F59E;
	Wed, 22 Oct 2025 06:02:21 -0700 (PDT)
Message-ID: <58c06505-7227-4985-b3d0-e12022ef9876@arm.com>
Date: Wed, 22 Oct 2025 14:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] PM: EM: Add netlink support for the energy model
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251020220914.320832-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251020220914.320832-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Changwoo,

On 10/20/25 23:09, Changwoo Min wrote:
> Addressed all the comments from Lukasz and rebased the code to the head
> of the linus tree.
> 
> There is a need to access the energy model from the userspace. One such
> example is the sched_ext schedulers [1]. The userspace part of the
> sched_ext schedules could feed the (post-processed) energy-model
> information to the BPF part of the scheduler.
> 

[snip]

> 
> ChangeLog v5 -> v6:
>    - Fix two problems reported by the kernel test robot.
>    - Conditionally include the iterator/accessor code for the performance
>      domain when both CONFIG_ENERGY_MODEL and CONFIG_NET are set to avoid
>      the compilation errors (patch 5).
>    - Remove an unused variable, `ret`, in em_notify_pd_deleted() to avoid
>      a warning (patch 8).
> 

[snip]

> 
> Changwoo Min (10):
>    PM: EM: Assign a unique ID when creating a performance domain
>    PM: EM: Expose the ID of a performance domain via debugfs
>    PM: EM: Add em.yaml and autogen files
>    PM: EM: Add a skeleton code for netlink notification
>    PM: EM: Add an iterator and accessor for the performance domain
>    PM: EM: Implement em_nl_get_pds_doit()
>    PM: EM: Implement em_nl_get_pd_table_doit()
>    PM: EM: Implement em_notify_pd_deleted()
>    PM: EM: Implement em_notify_pd_created/updated()
>    PM: EM: Notify an event when the performance domain changes
> 
>   Documentation/netlink/specs/em.yaml | 113 ++++++++++
>   MAINTAINERS                         |   3 +
>   include/linux/energy_model.h        |   4 +
>   include/uapi/linux/energy_model.h   |  62 ++++++
>   kernel/power/Makefile               |   5 +-
>   kernel/power/em_netlink.c           | 309 ++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h           |  39 ++++
>   kernel/power/em_netlink_autogen.c   |  48 +++++
>   kernel/power/em_netlink_autogen.h   |  23 +++
>   kernel/power/energy_model.c         |  85 +++++++-
>   10 files changed, 689 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/netlink/specs/em.yaml
>   create mode 100644 include/uapi/linux/energy_model.h
>   create mode 100644 kernel/power/em_netlink.c
>   create mode 100644 kernel/power/em_netlink.h
>   create mode 100644 kernel/power/em_netlink_autogen.c
>   create mode 100644 kernel/power/em_netlink_autogen.h
> 

You could still keep my review tags for this v6. The minor
issues reported by the testing robots and your fixes
didn't impact that.
(BTW, I suspected there might be those tricky build configurations
where something might pop up)

So fill free to add in all patches (like it was in v5):

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

