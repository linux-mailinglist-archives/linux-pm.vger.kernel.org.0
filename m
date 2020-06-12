Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066301F794C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLOLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 10:11:05 -0400
Received: from cmta17.telus.net ([209.171.16.90]:55319 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFLOLF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Jun 2020 10:11:05 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id jkOaj19TfmjwfjkOcjvol2; Fri, 12 Jun 2020 08:11:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1591971063; bh=SG/wpeS+dKg9fv0MxZ1Zm15eP51A4pXKFTzxeSulBUo=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=t3q1dyHO50+iQRbBD8/ryg5WamqRuZdr9tu56qJaXeMACbhoeKcIoEhTTM/HYacYo
         m774a3BYxIZRLG0R0cQFyh3xDFkHzpig/MSx8mPVDPdbX2vcg/SoP29ZYwr9WJvKJ2
         mhyiVX1aCk3XdDL9a12xpVZqAcGmA9vDjqmDkqlEp+XDCXowoc7H6d3kC5OAIidNI3
         Yr17rcrQPMuSq1ftGPT19rn4+ADkLSf0EglUtF7nlQl5cuWU9kflr5mArx5Z6n5Xzh
         1vBepQOi4Qc6uBqlfkD6NwNWTE+xRNcp/McpezbWMYczEgvn5MxusluaCE9YZoL1Mp
         k91/YNmsvWhlA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ea5DgIMH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=RW1HiHj9obChybWJIagA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200611174838.2822533-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200611174838.2822533-1-srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Add additional OOB enabling bit
Date:   Fri, 12 Jun 2020 07:11:00 -0700
Message-ID: <000301d640c3$4e6d61c0$eb482540$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZAGJu5Ay3KbrRgRI6H2FbqMrzlzgAqI0Hw
X-CMAE-Envelope: MS4wfMjRQ3BDC+xdOcaCKok5AjVKMSRru3PpbJCCoEsyQbLM7tXg/QOx0ukUmUDRdJVNxkg9zBJMttmCKPYqi++Ryb4P3gtEgp1EFruwUDaeYaewvKayBKIw
 qbr9OeBndF3Iv1tKBw4FybuThQLFGuNeO26cS7QcEw7eUXEsjOmt8LeMB4O5v0Wo2DbfUvIqjBgZtm3Uo5O7eupilzzy2JNhQZMafsWIoMKoR299XFrEEbg4
 FfXwjqYzvcwxsBMs7BXUbscjpVZ+/PQoEwjMvNjM1hiqD2hfjStaZTRsEgto1flbypmwH/scP0sNUH1qiBn8ITm9afHTiF1ByO/dwlOEsY7gJXDQ6ukUt0Ed
 GRz9cdvp
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.06.11 10:49 Srinivas Pandruvada wrote:

> Add additional bit for OOB (Out of band) enabling of P-states. In this
> case intel_pstate shouldn't load. Currently, only "BIT(8) == 1" of the
> MSR MSR_MISC_PWR_MGMT is considered as OOB. Also add "BIT(18) == 1" as
> OOB condition.

Shouldn't those bits be defined in these files:
arch/x86/include/asm/msr-index.h
and
tools/arch/x86/include/asm/msr-index.h

?

By the way, I couldn't find those bits defined in Intel docs that I have.
 
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8e23a698ce04..f21761443c90 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2686,8 +2686,8 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
>  	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
>  	if (id) {
>  		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
> -		if (misc_pwr & (1 << 8)) {
> -			pr_debug("Bit 8 in the MISC_PWR_MGMT MSR set\n");
> +		if ((misc_pwr & BIT(8)) || (misc_pwr & BIT(18))) {

And then those bit definitions used above.

> +			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");

And then some insight also printed  with the debug message.
At least say "Out of Band".

>  			return true;
>  		}
>  	}
> --
> 2.24.1


