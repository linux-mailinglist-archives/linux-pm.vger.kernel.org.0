Return-Path: <linux-pm+bounces-33936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B90B45295
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C01B634FB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B928313B;
	Fri,  5 Sep 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fihQykp9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CA30BBBE;
	Fri,  5 Sep 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062970; cv=none; b=oQmzOf1D5Cr66Le6LhRLdg3/T4OQtsbVtkH/ec5U6QX/LlKjxwDmuha3K7WnjPrY4CaJJzqWlRWKkGNIN2cg2V4kUC5tEaBmSq2ojD9nemN3qPyo53CPD+xcpbrVK2/PxG27sh2PusoCoOComquM0kWWJmUZ1bTT5rz609jspiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062970; c=relaxed/simple;
	bh=htQCVoc2LB/ZnnX+4UcaXgxK1ZhVp38DyEImWWT66k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuLRrlhbiC9fqKLaF15P5BnK3lYfHWRQNPrbVq7EhkrgWlNSaXIfvlBadCWU0fOFgPl3ShhWaSzhCoZIYkDBVh874EY+d41WOBE3QVa7z+vPfnqKABTGQmee7oMxZ0oouXIcw71LdNswasc5z5GXPNZTOKF2tBbuHZmS1MiJ3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fihQykp9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757062968; x=1788598968;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=htQCVoc2LB/ZnnX+4UcaXgxK1ZhVp38DyEImWWT66k0=;
  b=fihQykp9rMh2Df0VkK2sSIg2rz3xJVTsQb98e64ih0RJ4Q8bX10oTDrK
   4+XoV44ikzhRDYsPIaNvB2H5N5FVith3qBUNJL2r31Zx63Gj+8oFBvvlS
   aVNIYDLPzhHg6OEnqJ2lgV4TSIzfXsBE5u5BrmKGZwvXSXBLxBth1JQ+6
   zXBJ8hAWq26bCBkfS0EVNMa4FabtDy5jEpYNtXgL9PtIgLCrLpVyWWlYU
   Q01mypXEWB3VbD+QnF8w5VHvQW7bpLzKu5rGm+HoIW+lbxWLO5EcYeu8e
   JxlnSCRhU3r/3ELoB9qPLsAMzj5xFHrVVlSkrk/LK7R/43ihWbeZDoR5W
   w==;
X-CSE-ConnectionGUID: OMTj4lt5R1iAZ7RTr1c/Lg==
X-CSE-MsgGUID: Xrf8LTIpQwKlpTdG4pKf7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70790573"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70790573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:02:44 -0700
X-CSE-ConnectionGUID: DmcS02mySRiIcT7eRjaRww==
X-CSE-MsgGUID: /vGvNcxbSwGSPkSECRYcOg==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.159])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:02:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
In-Reply-To: <20250904063631.2364995-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250904063631.2364995-1-rdunlap@infradead.org>
Date: Fri, 05 Sep 2025 12:02:37 +0300
Message-ID: <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
> Provide some basic comments about the system_states and what they imply.
> Also convert the comments to kernel-doc format.
>
> However, kernel-doc does not support kernel-doc notation on extern
> struct/union/typedef/enum/etc. So I made this a DOC: block so that
> I can use (insert) it into a Documentation (.rst) file and have it
> look decent.

The simple workaround is to separate the enum type and the variable:

/**
 * kernel-doc for the enum
 */
enum system_states {
	...
};

/**
 * kernel-doc for the variable
 */
extern enum system_states system_state;

BR,
Jani.

>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> ---
> v2: add Rafael's Ack.
> v3: add Andrew
> v4: add DOC: so that this DOC: block can be used in Documentation/
>     add Greg K-H
>     add Jon Corbet, Mauro Chehab, & linux-doc
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/driver-api/pm/devices.rst |    8 ++++++++
>  include/linux/kernel.h                  |   18 ++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> --- linux-next-20250819.orig/include/linux/kernel.h
> +++ linux-next-20250819/include/linux/kernel.h
> @@ -164,8 +164,22 @@ extern int root_mountflags;
>  
>  extern bool early_boot_irqs_disabled;
>  
> -/*
> - * Values used for system_state. Ordering of the states must not be changed
> +/**
> + * DOC: General system_states available for drivers
> + *
> + * enum system_states - Values used for system_state.
> + *
> + * * @SYSTEM_BOOTING:	%0, no init needed
> + * * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
> + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
> + * * @SYSTEM_RUNNING:	system is up and running
> + * * @SYSTEM_HALT:	system entered clean system halt state
> + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
> + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
> + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
> + *
> + * Note:
> + * Ordering of the states must not be changed
>   * as code checks for <, <=, >, >= STATE.
>   */
>  extern enum system_states {
> --- linux-next-20250819.orig/Documentation/driver-api/pm/devices.rst
> +++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
> @@ -241,6 +241,14 @@ before reactivating its class I/O queues
>  More power-aware drivers might prepare the devices for triggering system wakeup
>  events.
>  
> +System states available for drivers
> +-----------------------------------
> +
> +These system states are available for drivers to help them determine how to
> +handle state transitions.
> +
> +.. kernel-doc:: include/linux/kernel.h
> +   :doc: General system_states available for drivers
>  
>  Call Sequence Guarantees
>  ------------------------
>

-- 
Jani Nikula, Intel

