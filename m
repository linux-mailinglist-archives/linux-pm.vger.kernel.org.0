Return-Path: <linux-pm+bounces-34045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E70B46A4E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FBF1C202B1
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A142C0F97;
	Sat,  6 Sep 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/V7t4+w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF242405EC;
	Sat,  6 Sep 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149138; cv=none; b=Wx+cju5hKWc7ObDqcUIzDsiV7G5PSfvMIYFYxYaKysKbBRD8jhI9Y+gLUaCzXsmkjANUMFUIV7SQRTe7P2vCLUncZPLFlv2B2jgZ3XUylCYJTGWw+3Zi+jwmRW4YZS1y6AsJWzxtAddo62JIyNB926m3sj06uFkcKwp2WYn+6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149138; c=relaxed/simple;
	bh=S6l82ubjGQ2QK0QX4FzJH8TH/F2OpmVSYr6x9ZyGaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWgkgCuJKoPI93WIE2B9xkwqwLbSa1tUz0FI86PmP+2er0k+Ozw13Hb/NHcs3/aCChSOeFNGtKp293yndW4X6/D+QfvAx+Ite46yzFuXS7EPdwrzLOH26j1zV5dk1hQ70qeklGEFujyi6+wtZXynl5iPtZWVSXGGuhdXPOwkVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/V7t4+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2C6C4CEE7;
	Sat,  6 Sep 2025 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757149137;
	bh=S6l82ubjGQ2QK0QX4FzJH8TH/F2OpmVSYr6x9ZyGaHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i/V7t4+wqW/sqTOvx8PGGNPWLcnRoN3LhP7vRqojtAlrjfvYRiRFhY1Eu3bwFJUNt
	 SLYKSEjPEda5iFVeRfQ5Fe0lPjve6I4ULgX6Hf8Ngoy/UznpEx7r/i2eirEbXc3UDJ
	 qMy7mPDINHhMyySj9Fgc7vVbU6R8y8la/1KgQGlWns9toGRUf9Nkljil/u7rbkSNyq
	 3Lc2iLFvxRAwxD+/5v9ffrs/dTjD/tr+0+E3hvEm40lHZwHP1MGLWjYMKqqMBO3YGv
	 CLS4j5WzqdtlDp+CRFM+CPGUHiGLucrWV8W5auispExp2mT3hd7etiU2w6IYXIOLx6
	 9J/iB+pAfzm6Q==
Date: Sat, 6 Sep 2025 10:58:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v5] kernel.h: add comments for enum system_states
Message-ID: <20250906105851.7c28416c@foz.lan>
In-Reply-To: <20250906052758.2767832-1-rdunlap@infradead.org>
References: <20250906052758.2767832-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri,  5 Sep 2025 22:27:58 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Provide some basic comments about the system_states and what they imply.
> Also convert the comments to kernel-doc format.
> 
> Split the enum declaration from the definition of the system_state
> variable so that kernel-doc notation works cleanly with it.
> This is picked up by Documentation/driver-api/basics.rst so it
> does not need further inclusion in the kernel docbooks.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> ---
> v2: add Rafael's Ack.
> v3: add Andrew
> v4: add DOC: so that this DOC: block can be used in Documentation/
>     add Greg K-H
>     add Jon Corbet, Mauro Chehab, & linux-doc
> v5: split enum declaration and definition (Jani Nikula)
>     drop the DOC: block since it is no longer needed
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/kernel.h |   21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> --- linux-next-20250819.orig/include/linux/kernel.h
> +++ linux-next-20250819/include/linux/kernel.h
> @@ -164,11 +164,23 @@ extern int root_mountflags;
>  
>  extern bool early_boot_irqs_disabled;
>  
> -/*
> - * Values used for system_state. Ordering of the states must not be changed
> +/**
> + * enum system_states - Values used for system_state.
> + *

> + * * @SYSTEM_BOOTING:	%0, no init needed
> + * * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
> + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
> + * * @SYSTEM_RUNNING:	system is up and running
> + * * @SYSTEM_HALT:	system entered clean system halt state
> + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
> + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
> + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state

You forgot to drop the extra asterisk at the above. definitions.

Fixing it, feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> + *
> + * Note:
> + * Ordering of the states must not be changed
>   * as code checks for <, <=, >, >= STATE.
>   */
> -extern enum system_states {
> +enum system_states {
>  	SYSTEM_BOOTING,
>  	SYSTEM_SCHEDULING,
>  	SYSTEM_FREEING_INITMEM,
> @@ -177,7 +189,8 @@ extern enum system_states {
>  	SYSTEM_POWER_OFF,
>  	SYSTEM_RESTART,
>  	SYSTEM_SUSPEND,
> -} system_state;
> +};
> +extern enum system_states system_state;
>  
>  /*
>   * General tracing related utility functions - trace_printk(),



Thanks,
Mauro

