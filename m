Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29A22A8E5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgGWGZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 02:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgGWGZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 02:25:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6AC0619DC;
        Wed, 22 Jul 2020 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pjr5iP/6E7OeZxRztKUO1s2/ZLCAyytKnlW4zOJ8uI4=; b=iDYVlM2ZhdXKhXn0ZvMLEHaUJw
        laOWedbmPiFJHZTC0btCQKGCljV6+OT+V9tEG07dZfQIxGoUt6xEO6H+TIv7+aCZeAljHRJG/S3rr
        4nwz8MZV+M7YFBXMDnacBGBCKfcHNGghJ+9OlcxBwEfgWfrRHridy/Ly5uYn459gazYqHAmpWba+8
        5kCNpwDiTPOHNdH0gy/6FF5Om9RgjXAqowauFNQqUB/QoSAuasEc7zxiv5w7A3LyvlsdunQFYmCIX
        769JTlvalr2v1PGKHBfobKSH0RC8/ySucxDcpA232H6ec9B+kqHzAuNOfAQv4kg8tHL2P7BoV54zh
        byFp+//A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyUf3-00065W-Dr; Thu, 23 Jul 2020 06:24:57 +0000
Subject: Re: [RFC] cpuidle : Add support for pseudo-cpuidle driver
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com
References: <20200723061339.9747-1-huntbag@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1be8a3d4-52cc-c91c-2560-25e0af41dd5c@infradead.org>
Date:   Wed, 22 Jul 2020 23:24:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723061339.9747-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/22/20 11:13 PM, Abhishek Goel wrote:
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd66f02..1d73153a0e35 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -71,6 +71,15 @@ config HALTPOLL_CPUIDLE
>  	 before halting in the guest (more efficient than polling in the
>  	 host via halt_poll_ns for some scenarios).
>  
> +config TEST_CPUIDLE
> +	tristate "cpuidle test driver"
> +	default m

No default, please.
We don't enable unneeded drivers for the fun of it.

> +	help

Indent the following help text with one tab + 2 spaces.

> +	 This option enables a testing cpuidle driver, which allows to user

	                                                     allows the user  [or a user]

> +	 to define custom idle states with their respective latencies and residencies.
> +	 This is useful for testing the behaviour of governors on different
> +	 set of idle states.

	 sets

> +
>  endif
>  
>  config ARCH_NEEDS_CPU_IDLE_COUPLED

thanks.
-- 
~Randy

