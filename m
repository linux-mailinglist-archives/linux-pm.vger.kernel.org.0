Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3252A8C59
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 02:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgKFB6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 20:58:07 -0500
Received: from cmta19.telus.net ([209.171.16.92]:57709 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbgKFB6H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 20:58:07 -0500
Received: from dougxps ([173.180.45.3])
        by cmsmtp with SMTP
        id aqt0kwPg7dLkEaqt1kZKc4; Thu, 05 Nov 2020 18:49:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1604627397; bh=EQ2VgUbGgV+uFwLbFWhleNcbVstRS/kO5xtYuUuBq24=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=YK1ZmjXW5mhpM+I0VP6mno26vEh3v016ESNf5CQhoPBNDclhNCxwvPUaA+fGenvNl
         adS2nDJTZA95HanowQ0AsUG3mTaYDUTKwGO0DSHyF0/sFdiGVr4/RCxxjKxjSmGqO+
         a1Tp767cLvRZUiKq6NEn20ubsopYSxrhMc+6iQGIwFwurAr4F5f+fs0S0KL9xacm8w
         2h5u6RGWbW03BQi6PUCZCxNiyi81LYsNV/BDI8svtCS4RFpLb5qtzrAI5VypmyQ62O
         6z6X/6VGReTjHTG6alMn58ZHA6sjwWaZpXqxAl/atDMq4s+BDvo6kTr6Vd+mVY1UkL
         +7OpSr5YQn+xw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=WPm64lgR c=1 sm=1 tr=0 ts=5fa4abc5
 a=ZeVyObKPoMU90SgYCeSZ1g==:117 a=ZeVyObKPoMU90SgYCeSZ1g==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=8THPvSkuJoZwLrQ9cBcA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Zhang Rui'" <rui.zhang@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <7417968.Ghue05m4RV@kreacher> <2233690.N3OVLkotou@kreacher>
In-Reply-To: <2233690.N3OVLkotou@kreacher>
Subject: RE: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
Date:   Thu, 5 Nov 2020 17:49:53 -0800
Message-ID: <001b01d6b3df$21165940$63430bc0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdazoQzOa64DtwxHQV2ivz0yvkdgTgAM4bQw
X-CMAE-Envelope: MS4xfOnrGS/Thze5mEGyKkwj5SyTIuz7k6xioMBYgNxOS3r1kTiTTBoQHV/3fPgx5sDCTVmwN5AqW+TL2VAoRyjciQd389sWRFRcFPfuXto90COudkUsNIQB
 vWfHuai3mED8GwYSRWjD0E8wrb15q/bOUnvyb9D+A/3dOOxe1zRdLI7prRMmG4MXEB9GtbqquDdm7B4N7ifyfAeWX7yJxvgwDOj51M4f6DwSCqxcgslXJ5RD
 PdNvvTWhZSSiZPleL+BQp2s+tSY4eCvDVSaWhdn8sweclJA8mL/dEQxZ31lradvz5aOjac+CSnvqHFHctWcTF14X7rr1iU8dLqdY9W2b8TwioxLiQjlg9DCv
 q0R5+k50wfsIicLcLqICdWrKMt8YedaItQHEHZFMkzvlWfuhBKI=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael:

Thank you for this patch set.

I can not get the patch to apply.
I was trying on top on 5.10-rc2, and have been unable to determine
what other patches might need to be applied first.

On 2020.11.05 10:24 Rafael J. Wysocki wrote:

...

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c             |    3 +++
>  drivers/cpufreq/cpufreq_performance.c |    4 ++++
>  drivers/cpufreq/cpufreq_powersave.c   |    4 ++++
>  include/linux/cpufreq.h               |   16 ++++++++++++++++

I do not understand why this part says to look for 16
differences, but I can only find 2.

>  4 files changed, 27 insertions(+)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -63,6 +63,8 @@ struct cpufreq_policy {
> 
>  	unsigned int		min;    /* in kHz */
>  	unsigned int		max;    /* in kHz */
> +	unsigned int		target_min; /* in kHz */
> +	unsigned int		target_max; /* in kHz */
>  	unsigned int		cur;    /* in kHz, only needed if cpufreq
>  					 * governors are used */
>  	unsigned int		suspend_freq; /* freq to set during suspend */
> Index: linux-pm/drivers/cpufreq/cpufreq.c

...

Anyway, I edited the patch, deleting the include/linux/cpufreq.h part,
then it applied, as did patch 2 of 2.
I edited include/linux/cpufreq.h manually.

Issues with the powersave governor reported in [1] and [2]
are fixed. Relevant part quoted and updated below:

> In early September Doug wrote:
>> powersave governor:
>> acpi-cpufreq: good
>> intel_cpufreq hwp: bad

Now good, with this patch set.

>> intel_cpufreq no hwp: good

...

> For the powersave governor, this is what we have now:
> 
> intel_cpufreq hwp == intel_pstate hwp
> intel_cpufreq no hwp == acpi-cpufreq == always minimum freq
> intel_pstate no hwp ~= acpi-cpufreq/ondemand

...

> My expectation was/is:
> 
> intel_cpufreq hwp == intel_cpufreq no hwp == acpi-cpufreq == always minimum freq

And this is what we now have, with this patch set.

> intel_pstate no hwp ~= acpi-cpufreq/ondemand
> intel_pstate hwp == Unique. Say, extremely course version of ondemand.

[1] https://marc.info/?l=linux-pm&m=159769839401767&w=2
[2] https://marc.info/?l=linux-pm&m=159943780220923&w=2

... Doug


