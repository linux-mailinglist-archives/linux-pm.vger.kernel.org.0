Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD821DA02
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgGMPYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:24:33 -0400
Received: from cmta18.telus.net ([209.171.16.91]:44612 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgGMPYb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 11:24:31 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id v0Jgjp1dOqUs3v0JhjVBE5; Mon, 13 Jul 2020 09:24:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594653870; bh=EuZO7CFPDzNNBjUIZ2RUbulvDa77FVqXvjv9ClSqdwc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=3BXATCgn7BNCvGXv5uIYrSMIHf4OkQ+UrfdXCSVMATU64bpKziz49GN9+N71K3hUm
         /SRS55T9J7xjafPYnCZQ0j7AlcYe05D0PTTYN1jVVmuo0n9X5oxkL+zyNCryICKihm
         xM4h6/N+BV5c8sHV/uh50KBHQsID/fFrfl/gan2AE/hoRTjJjOaeZ5rnJ2A5hSnX8k
         flwIFaDdMbCG9MAATZViriBV6rvbojXIb81nqku2Upjj7NCLAePjuB5tAd5NEMJWPO
         sUBdyU1sJHX1/pj6GSVzVQOlzT8pvbeS/DSBvRhZKIiL+J9DpgA1vCe/McpezKCNBG
         WkCAUqoFUz0rw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=aatUQebYAAAA:8 a=uNwrE8Qp8GfIG1_g5dMA:9 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2265724.DSYBgs0BIW@kreacher>
In-Reply-To: <2265724.DSYBgs0BIW@kreacher>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix active mode setting from command line
Date:   Mon, 13 Jul 2020 08:24:27 -0700
Message-ID: <000e01d65929$b3e29330$1ba7b990$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZZHbdoRlNWaI7SSRGgqypVEYfOXwACbO6A
X-CMAE-Envelope: MS4wfNlKPqzUvfW0YkT93wSWJoXcjSTVBP3cze7Khw1r7SbC4V6gP+VM47ihwjLK/6/him1Z1hsGKDZa+XIuApgtZJfMxQLCyGrVodj/IZNPjSzHCj2V57ls
 jPl7sdBoZ+p/7geUfifZxlefl6JzOut2NfX1eM8mu8fkQOvRSrO432dVFkKOH5RSeEvaJRSVGiugtdIhHuz8KLDtK6j525Pqnc8yyFoKgPK1JTj+dsH3NT3B
 YpqvzUaApMqfjcH6sQB6wSyAoYpq+zCgVNFtF41AzOT2B/5R4Gvm5J8XQO4kPFUB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you.

On 2020.07.13 06:59 Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If intel_pstate starts in the passive mode by default (that happens
> when the processor in the system doesn't support HWP), passing
> intel_pstate=active in the kernel command line doesn't work, so
> fix that.
> 
> Fixes: 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Doug Smythies <dsmythies@telus.net>

> ---
>  drivers/cpufreq/intel_pstate.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2534,7 +2534,7 @@ static struct cpufreq_driver intel_cpufr
>  	.name		= "intel_cpufreq",
>  };
> 
> -static struct cpufreq_driver *default_driver = &intel_pstate;
> +static struct cpufreq_driver *default_driver;
> 
>  static void intel_pstate_driver_cleanup(void)
>  {
> @@ -2828,6 +2828,7 @@ static int __init intel_pstate_init(void
>  			hwp_active++;
>  			hwp_mode_bdw = id->driver_data;
>  			intel_pstate.attr = hwp_cpufreq_attrs;
> +			default_driver = &intel_pstate;
>  			goto hwp_cpu_matched;
>  		}
>  	} else {
> @@ -2845,7 +2846,8 @@ static int __init intel_pstate_init(void
>  		return -ENODEV;
>  	}
>  	/* Without HWP start in the passive mode. */
> -	default_driver = &intel_cpufreq;
> +	if (!default_driver)
> +		default_driver = &intel_cpufreq;
> 
>  hwp_cpu_matched:
>  	/*
> @@ -2899,6 +2901,8 @@ static int __init intel_pstate_setup(cha
> 
>  	if (!strcmp(str, "disable")) {
>  		no_load = 1;
> +	} else if (!strcmp(str, "active")) {
> +		default_driver = &intel_pstate;
>  	} else if (!strcmp(str, "passive")) {
>  		default_driver = &intel_cpufreq;
>  		no_hwp = 1;
> 


