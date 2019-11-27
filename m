Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6403310AB37
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 08:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfK0Hcn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 02:32:43 -0500
Received: from cmta20.telus.net ([209.171.16.93]:60758 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfK0Hcn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 02:32:43 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ZroRi5vCYN5I9ZroSiik5X; Wed, 27 Nov 2019 00:32:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574839960; bh=0ORBH/ZadSHCKZQiUWjIShwLMG7CSdG3H9xgVcazVJU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=q22+IpVAASH+U2XC4w8g/WP4DylYoKoUrCa+ZrfCCIARaAiRcPxqRq5d7UtnIyMVO
         Q9mBDyc4XKS3AadM6fJrbbtxzxXuUqDT3I9xJ11leHzRC6dVlmgcMZ3VT74LiR8vtm
         ApAzKp1ldrxZZILhypUdEu+azketPmv7dvFwFrP0rl73zqnqya4SV96XoyP3Cpq8np
         hSCjobndT7a8tluUQUip/CTOZXJoGTLlu+wbFGfhmTRAvK+Huvh77qJ+YMsBcUZx0V
         pqvcrgGLjEcSSxg+efyHL4z1aQvmWB5L+ex2b6vX18++k+ReKYaCskAq/729E85RLh
         hCBMaUTP1ooRg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=dAj8EvzD0n44Yc48VYEA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Matt Fleming'" <matt@codeblueprint.co.uk>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Paul Turner'" <pjt@google.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Quentin Perret'" <qperret@qperret.net>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Borislav Petkov'" <bp@suse.de>, "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>                 <20191113124654.18122-2-ggherdovich@suse.cz>                 <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz>         <000801d5a41e$a7fce2c0$f7f6a840$@net> <1574781600.7677.2.camel@suse.cz>
In-Reply-To: <1574781600.7677.2.camel@suse.cz>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Tue, 26 Nov 2019 23:32:34 -0800
Message-ID: <001d01d5a4f4$d96b21b0$8c416510$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWkbC8LB/SpP9sCRCWbwO3FO+l3UwAhVS2w
Content-Language: en-ca
X-CMAE-Envelope: MS4wfNRXJHBbT8vjMdPapanEaph3gv4V2+AANKO8BH+eYmR1Nso692Mw0NJl1Q6Yq/wGlZoYcEBt0dX5lbjPw89ZHFUy+HTJlBcHXQs65J2CzkiO2FtVCMHQ
 8qdbInoD2VETmXgk4ekKkZonQQKdAO46hQD9usndH/mEOiD0AH7jjUh7JqiqZuLO3penEF0LiInl2sPX95+rCsZbsCyzdzn4ZFcWkzaFrXbaRjPbyKGQAsTH
 N19Ik0dOoYG4CV/PH65GATgDjKC5uHH5IQWK4QEZS1eBZ4JEhWTr8tW3DD5bs0UMaMespVt3UlZggS8pRgc7K90vD5i+J/LhbdfXk3ljr61n8mTSRRp0ZEqm
 Tb6tV6H4qONGNCJI2OiLs9JxHdxwoUdSg5bZPYun40VAHGxe8P+AQ5GYJ0MKcbEcQ+ZFQ4gzn6br3dhbMmCiLn0AOPvsNqLcsi/uKtR+1IElAhRLS0GvuqXx
 5DMVk9rakujonmx9aSZmCtHPeJeZ+AuMYbLghbOhLS7RR5G8FeIdHz2NZVHuYDTji9jGvakZCto8DpelczMhJ2aPNeP20pnxSkA1NobSiaYApscVe3S8Gb+D
 9lsnwqa8827j5yNeFKxpC4sIG3mJiLLrsgwQdxFzw8BT8zZ/7s27U5h+o3+XZ0bgM9aTs29VlUbpE6QIUwJnlQvH16gf7jhe1pQWdhrfLrjvrqV/DMRk4zoq
 htB7xbjfM51qlUWP9vtjH3lT75ZBEMM4XKUpJQUJAoQoPDSdu3fBag==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.26 07:20 Giovanni Gherdovich wrote:
> On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
>> [...]
>> The issue with the schedutil governor not working properly in the 5.4 RC series
>> appears to be hardware dependant.
>> 
>> My test computer is Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz., Sandy Bridge.
>> On a temporary basis, I acquired a computer with an
>> Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz, Haswell,
>> and schedutil governor behaviour with the exact same kernels is fine:
>> 
>> That "gitsource" test, "make test" 6 times, first run thrown out:
>> 
>> Kernel 5.4 intel_cpufreq/schedutil: 3411.8 seconds
>> Kernel 5.4 + gg 6 intel_cpufreq/schedutil: 1696.7 seconds
>> Ratio: 0.49
>> Recall you got a ratio of 0.49 with 5th generation, Broadwell.
>
> It's good to hear that we're getting the same performance numbers for this
> patchset on all hardware that is not a Sandy Bridge. Thanks for double
> checking, independent verification is always valuable.
> 
> Now, regarding the 5.4 regression for schedutil you see on Sandy Bridge: can
> we move this to the kernel bugzilla? Would you care to open a bug there and CC
> me to it?

O.K., I'll need another day or two to isolate further, then I'll open a bug.
I now understand considerably more, and why my bisection ended up
at a strange spot.

> If it's reproducible we should assess it and see what can be done.

On my Sandy Bridge system if the kernel configuration contains:

CONFIG_UCLAMP_TASK_GROUP=y

Then the intel_cpufreq/schedutil will respond much like the performance
governor.

If the kernel configuration contains:

# CONFIG_UCLAMP_TASK_GROUP is not set

Then the intel_cpufreq/schedutil will respond much like it used to.

On the Haswell computer, it doesn't seem to matter, and your tests
seem to confirm this.

Note: I steal my kernel configuration from the Ubuntu mainline builds,
and they changed this parameter during the 5.4-rc series.

... Doug


