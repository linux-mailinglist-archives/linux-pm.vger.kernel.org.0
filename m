Return-Path: <linux-pm+bounces-33978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B08B45866
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCDB3B3EAC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8699C18DF8D;
	Fri,  5 Sep 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCdRJhVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA6219EB;
	Fri,  5 Sep 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077602; cv=none; b=nqQfGVpvtFoO/Xb5mPyTUPTP9ZFXrj+65BkmuDawfwmOsAWdCBeb7laehOLcaIOvEdFIUBj/90Rwe29jiLIpP1KB2uG6ndUdPRuscql7XgKWntYABCkXmaAUw+q9bT2KK9Yvu5YydsWwdKCU91d348arhecHq8JVsfoD9BtY69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077602; c=relaxed/simple;
	bh=HxiuYgNYwxrIO8dkyKKccGLoa1n3kcaOo11GRqt6NMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKd413d2R3siyemZ+Ahi6/ue84n6zVYcoLq3GfDe+XTrM+mB3u3SNw+zthIbZrY3YvC6CfUa0hkyTkUWnxrI3sFGsgd6YiIIitJMCeCKK+I2CuPZsZXJ/hMOTpieTNCQT4N34SuAUM4Y65YrIHI3QzeveHnXDwSWq21TgzsvwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCdRJhVx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757077600; x=1788613600;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HxiuYgNYwxrIO8dkyKKccGLoa1n3kcaOo11GRqt6NMg=;
  b=nCdRJhVxiEy/tz5o/YTyciE2q6HYqf5865feTSNX3LanPm4QPzOv6/xS
   qwKFgDjP9IVEeZ0qH/Gbo2P0sJp8sDyG+FJxr9UZ7k8LxDvqfqsq4VjyG
   j/ti9pZrFQqkfg2gIQjODXBd1S36S0r+LuDTkhTUEw4//+LhXCZQDoDPW
   Cc33QlVB48m4XSVTvcs4+AJju+ogkp0/1k0vE/C5tioQ1eIqtWKkk+UO2
   90Yx4UavqZGsXQBMGxM3hVKyqe6vQP8r8QsPICfeCcslhFsrGRUq3dVvh
   8gMUHLLU+mPEZiakrw604u4/5XWi56e/7CMRFW/q3D3D/WlJl9DaU87Q6
   Q==;
X-CSE-ConnectionGUID: ExB36ddAQ/edBuX0VJSFBA==
X-CSE-MsgGUID: 3vgb9pdQRzCZjJp3nM25kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59283211"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="59283211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:06:39 -0700
X-CSE-ConnectionGUID: 1QfBFO8xSs2NO+PC9Iu5jQ==
X-CSE-MsgGUID: qhm5jLl2TSS4s014OA3SEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="202978805"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.159])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:06:35 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
In-Reply-To: <20250905140104.42418fba@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
Date: Fri, 05 Sep 2025 16:06:31 +0300
Message-ID: <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Em Fri, 05 Sep 2025 12:02:37 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
>> > Provide some basic comments about the system_states and what they imply.
>> > Also convert the comments to kernel-doc format.
>> >
>> > However, kernel-doc does not support kernel-doc notation on extern
>> > struct/union/typedef/enum/etc. So I made this a DOC: block so that
>> > I can use (insert) it into a Documentation (.rst) file and have it
>> > look decent.  
>> 
>> The simple workaround is to separate the enum type and the variable:
>> 
>> /**
>>  * kernel-doc for the enum
>>  */
>> enum system_states {
>> 	...
>> };
>> 
>> /**
>>  * kernel-doc for the variable
>>  */
>> extern enum system_states system_state;
>> 
>> BR,
>> Jani.
>> 
>> >
>> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
>> > ---
>> > v2: add Rafael's Ack.
>> > v3: add Andrew
>> > v4: add DOC: so that this DOC: block can be used in Documentation/
>> >     add Greg K-H
>> >     add Jon Corbet, Mauro Chehab, & linux-doc
>> >
>> > Cc: Andrew Morton <akpm@linux-foundation.org>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> > Cc: Pavel Machek <pavel@ucw.cz>
>> > Cc: Len Brown <len.brown@intel.com>
>> > Cc: linux-pm@vger.kernel.org
>> > Cc: Jonathan Corbet <corbet@lwn.net>
>> > Cc: linux-doc@vger.kernel.org
>> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> > ---
>> >  Documentation/driver-api/pm/devices.rst |    8 ++++++++
>> >  include/linux/kernel.h                  |   18 ++++++++++++++++--
>> >  2 files changed, 24 insertions(+), 2 deletions(-)
>> >
>> > --- linux-next-20250819.orig/include/linux/kernel.h
>> > +++ linux-next-20250819/include/linux/kernel.h
>> > @@ -164,8 +164,22 @@ extern int root_mountflags;
>> >  
>> >  extern bool early_boot_irqs_disabled;
>> >  
>> > -/*
>> > - * Values used for system_state. Ordering of the states must not be changed
>> > +/**
>> > + * DOC: General system_states available for drivers
>> > + *
>> > + * enum system_states - Values used for system_state.
>> > + *
>> > + * * @SYSTEM_BOOTING:	%0, no init needed
>> > + * * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
>> > + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
>> > + * * @SYSTEM_RUNNING:	system is up and running
>> > + * * @SYSTEM_HALT:	system entered clean system halt state
>> > + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
>> > + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
>> > + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
>> > + *
>> > + * Note:
>> > + * Ordering of the states must not be changed
>> >   * as code checks for <, <=, >, >= STATE.
>> >   */
>> >  extern enum system_states {
>> > --- linux-next-20250819.orig/Documentation/driver-api/pm/devices.rst
>> > +++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
>> > @@ -241,6 +241,14 @@ before reactivating its class I/O queues
>> >  More power-aware drivers might prepare the devices for triggering system wakeup
>> >  events.
>> >  
>> > +System states available for drivers
>> > +-----------------------------------
>> > +
>> > +These system states are available for drivers to help them determine how to
>> > +handle state transitions.
>> > +
>> > +.. kernel-doc:: include/linux/kernel.h
>> > +   :doc: General system_states available for drivers
>> >  
>> >  Call Sequence Guarantees
>> >  ------------------------
>> >  
>> 
>
> If the problem is with "extern" before enum, fixing kdoc be
> fairly trivial.

The non-trivial part is deciding whether you're documenting the enum
type or the variable. Both are equally valid options.

BR,
Jani.

>
> If you see:
>
> 	def dump_function(self, ln, prototype):
> 	
>      	# Prefixes that would be removed
>         sub_prefixes = [
> 	    ...
> 	    (r"^extern +", "", 0),	
> 	    ...
> 	}
>
>         for search, sub, flags in sub_prefixes:
>             prototype = KernRe(search, flags).sub(sub, prototype)
>
>
> we need something similar to that at:
> 	def dump_enum(self, ln, proto):
>
> alternatively, we could use a simpler approach modifying adding a
> non-group optional match for "extern". E.g:
>
> -	r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
> +       r = KernRe(r'(?:extern\s+)?enum\s+(\w*)\s*\{(.*)\}')
>
> (untested)
>
> Regards,
> Mauro
>
>
> Thanks,
> Mauro

-- 
Jani Nikula, Intel

