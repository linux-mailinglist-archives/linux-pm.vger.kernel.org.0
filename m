Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD72CE26D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgLCXNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 18:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgLCXNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 18:13:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09AC061A51;
        Thu,  3 Dec 2020 15:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LkH9yYrAqwwR4m0f5kCV5720LcGNbT3VnZkkdHwo4lo=; b=AQ4FERtumqedwUotGOZEy/Fc9G
        /0LpOp4E6PGIdZd6NJS9UYpub+7AUlNOKfTeaD678NTcF116C44I13bTV7A+tZ3ZTIcyZYNneNCc7
        FW2D+W5SEy9gbK1syvENhMMqhgCP32IsQ4UkTn9XaW9XYdmB7eUtG3HS76v89nMCD5k8eGFXUOR0m
        A73XN0GvB0Tn8xuS0PkgNWdu6Go9jzp3Vif2NB5S6gEHOfBtl+2zOy0Qqj3QWcthdoJuW1N2p7dQb
        wnquU9nOERPOXHgol1FdJpnjttLw+fRtWtJDISQ1opN8f1jPq2tIZoam1wWamlMKUs/8zSTcbmq3x
        anbBFVBQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkxm3-0000d8-Be; Thu, 03 Dec 2020 23:12:31 +0000
Subject: Re: [PATCH] intel_idle: fix intel_idle_state_needs_timer_stop build
 failure
To:     Arnd Bergmann <arnd@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen Yu <yu.c.chen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201203223020.1173185-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f5a56dc-d558-b63b-9ebe-5b935a46ba8b@infradead.org>
Date:   Thu, 3 Dec 2020 15:12:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203223020.1173185-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/3/20 2:30 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function is defined inside of an #ifdef section but
> used outside, leading to a build failure:
> 
> drivers/idle/intel_idle.c:1510:7: error: implicit declaration of function 'intel_idle_state_needs_timer_stop' [-Werror,-Wimplicit-function-declaration]
>                 if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
>                     ^
> 
> Move it ahead of the CONFIG_ACPI_PROCESSOR_CSTATE check.
> 
> Fixes: 6e1d2bc675bd ("intel_idle: Fix intel_idle() vs tracing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/idle/intel_idle.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 

Peter has already fixed this one.

thanks.
-- 
~Randy

