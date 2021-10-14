Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3442D5C4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJNJPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 05:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhJNJPP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 05:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A42516101D;
        Thu, 14 Oct 2021 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634202790;
        bh=yYl0Da99LZ2wsEtdjpplnJ+PZvP2bmgujP9p713SfHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbsBvfj9mNhIXXTmWBp7BoNqP5jY9P95kcPENN+8zlaq4g9zvw5LyZhsxGzanOAON
         py4CPBlxnpjv1PRxFjWNDWpThMx4YWgY9/F9vauetOdN8fLFYhi7/0Da6g4njmoyIy
         Ja1uAt6uHA03UWHwKMIRBO+EKwuHORQcSYWvzTt4BrZrMake/HWE3y1nvfJMOqocPY
         6a1Kfarur0CcD6XVzJZIchzRdvKPh7m/xOKNqocrhZlb9hNKwFugl4MQevSVPNfqMS
         /xe3oI0j35adKbJ7Z6pWxuLOuprTvY1cPIKiQLtoC6GAJUZqIMg9s+MJeGJJFxSqP4
         Ntgm/6iEWR4TA==
Date:   Thu, 14 Oct 2021 10:13:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] freezer,umh: Clean up freezer/initrd interaction
Message-ID: <20211014091304.GB8135@willie-the-truck>
References: <20211009100754.690769957@infradead.org>
 <20211009101444.912374035@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009101444.912374035@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 12:07:56PM +0200, Peter Zijlstra wrote:
> handle_initrd() marks itself as PF_FREEZER_SKIP in order to ensure
> that the UMH, which is going to freeze the system, doesn't
> indefinitely wait for it's caller.
> 
> Rework things by adding UMH_FREEZABLE to indicate the completion is
> freezable.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/umh.h     |    9 +++++----
>  init/do_mounts_initrd.c |   10 +---------
>  kernel/umh.c            |    8 ++++++++
>  3 files changed, 14 insertions(+), 13 deletions(-)

This looks much better to me:

Acked-by: Will Deacon <will@kernel.org>

Just a question on the old code:

> --- a/include/linux/umh.h
> +++ b/include/linux/umh.h
> @@ -11,10 +11,11 @@
>  struct cred;
>  struct file;
>  
> -#define UMH_NO_WAIT	0	/* don't wait at all */
> -#define UMH_WAIT_EXEC	1	/* wait for the exec, but not the process */
> -#define UMH_WAIT_PROC	2	/* wait for the process to complete */
> -#define UMH_KILLABLE	4	/* wait for EXEC/PROC killable */
> +#define UMH_NO_WAIT	0x00	/* don't wait at all */
> +#define UMH_WAIT_EXEC	0x01	/* wait for the exec, but not the process */
> +#define UMH_WAIT_PROC	0x02	/* wait for the process to complete */
> +#define UMH_KILLABLE	0x04	/* wait for EXEC/PROC killable */
> +#define UMH_FREEZABLE	0x08	/* wait for EXEC/PROC freezable */
>  
>  struct subprocess_info {
>  	struct work_struct work;
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -79,19 +79,11 @@ static void __init handle_initrd(void)
>  	init_mkdir("/old", 0700);
>  	init_chdir("/old");
>  
> -	/*
> -	 * In case that a resume from disk is carried out by linuxrc or one of
> -	 * its children, we need to tell the freezer not to wait for us.
> -	 */
> -	current->flags |= PF_FREEZER_SKIP;
> -
>  	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
>  					 GFP_KERNEL, init_linuxrc, NULL, NULL);
>  	if (!info)
>  		return;
> -	call_usermodehelper_exec(info, UMH_WAIT_PROC);
> -
> -	current->flags &= ~PF_FREEZER_SKIP;

How was this supposed to work if it raced with the freezer checking the
flag?

Will
