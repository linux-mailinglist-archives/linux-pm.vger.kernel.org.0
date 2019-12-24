Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E67129C57
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLXBQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 20:16:49 -0500
Received: from cmta17.telus.net ([209.171.16.90]:54769 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfLXBQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 20:16:49 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id jYoTi09cHbg38jYoUiySaO; Mon, 23 Dec 2019 18:16:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1577150207; bh=ODYwhfPt6MsqQtLICXCUgpmiQneAod/Apsuhk4WGCHo=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=CtvNc+4euCofzl27ngb+DtU6etJm2HqxrArEbNO9p/SsOH4jAWvGCkRBG4SmmwXex
         bOqnuOGE9DuyoD3Z/dyFz6UrWqxWwgvsQVk9adjIzqAJ/E6AV0Wbu/swFDdIgPBIoP
         D27el1CaI2WlYdk5vu8m5yeHReS7zeXmM/jfL18lB6SzGcriU/j8xp6BOuWrZf3Bax
         bEZ92idlEpeN5xUcOhqF899cdrcAlBW94c8fCEYICWusj4kkyNg7aRGtxSPRZfT/HX
         ehLPauagEBiEbKjlr3YppaZn+i2oTXnOaKShqlVVQSVZ5ckSIaY3TjosVThM+0Olud
         2iNZKNDmDufig==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=njV4EcZ6lGp_ohjWBiQA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Qais Yousef'" <qais.yousef@arm.com>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
References: <1574697961.16378.5.camel@suse.cz> <000801d5a41e$a7fce2c0$f7f6a840$@net> <1574781600.7677.2.camel@suse.cz> <001d01d5a4f4$d96b21b0$8c416510$@net> <003d01d5a63d$f6ab3950$e401abf0$@net> <20191219104813.6fr34qavpaplecoz@e107158-lin> <000701d5b965$361b6c60$a2524520$@net> <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com> <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com> <000301d5b9ae$cd8f5b30$68ae1190$@net> <20191223191014.g7lnxafuadwtcqub@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191223191014.g7lnxafuadwtcqub@e107158-lin.cambridge.arm.com>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Mon, 23 Dec 2019 17:16:39 -0800
Message-ID: <000401d5b9f7$cf3782c0$6da68840$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdW5xJ+eVDznPQtVRyqEVUJp7cpgLgAL7hNA
X-CMAE-Envelope: MS4wfLW1bqXgFcdCQxme3c2zQBvwtsoXAea/u7GIOR0AXN1Dm0TTtTWQTweIHX/qoLPu7TPCRdrMp/L2qPXAHdVYEDHjx1Jqqf7B7BU/kw/ccL1WClkg+rHe
 NIWpDKAAu0MqwJfpLHQcMXzFOaGwsIIyoJWbIeHxQTLH5fWEQp5AofX9bYTPt24DuA3dRZpQMgpYj0H9IFEZ/qLuggfik6hr/FryUt0M8QqznWCu6scf1/U5
 IyKh93PBMcglSb5DVqdzBMWnhd3uAlXLa3w6/4squhasyTfTPDgszgpE4gp1PdIpzWjy6Vrv9yeV1Oh8njlcsJR5qzZhqawDTIyov1BYZRVpgtjkSJf5tY2P
 lC4iA2oDDOcQQP4u2r77e+imoigouFUw1O7wcNTPBaH78w7SU49KSqB+rshCFUbigJyfpZxzJ/znXvZb3Dmsb14csFyD39g0TnOUzK5HjsemRu4ep0bsIXHZ
 avemi0pbySKy/oPcUCWEoA25AsiiR99vZdMwnmx0GFPM9UFT6mgzjneXG4E0xtAA9CgaHUUdotTjFPJvJPyLyOrX2QVrpZT0fqpfIjxaGP3zua1fVjAnlKQ2
 LOLeFpD2Xxe4vWW7WV1xqyzLY1a99P56qhittRqjdSL/1PNsoVowycwai4pFZ4yNpihY1TXZEx+N8TByyYk70cZ7wDUU8q3aAKQK1wP7MpIaDS2KSoDZ7pqZ
 3BZpvqxfKRgTSf5AVOu9ySyJtOJPH3LucsagPERMy35X+OQeDckhqF703p7NQ4EBj4kH8eV0AqU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.12.23 11:10 Qais Yousef wrote:
> On 12/23/19 08:34, Doug Smythies wrote:
>> On 2019.12.23 06:41 Qais Yousef wrote:
>>> On 12/23/19 14:07, Qais Yousef wrote:
>>>>> Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
>>>>> set the schedutil governor.
>>>>> launch test 2 and related monitoring tools.
>>>>> verify performance governor like behavior.
>>>> 
>>>> So as stated above, by default uclamp_{min, max} = (0, 1024). So it wouldn't
>>>> act as performance governor by default unless you explicitly write 1024 to
>>>> uclamp.min.
>>>> 
>>>> Let me go find Ubuntu mainline tree to see if they applied anything extra in
>>>> there. If they modified the default behavior that could explain what you see.
>>>
>>> Actually I see what you were saying now that you copy the config. So I think
>>>  I misunderstood and you are running Linus' 5.5-rc2 + Ubuntu PPA config.
>> 
>> Yes, exactly.
>> I have a clone of the main Linus git branch, but steal the kernel
>> configuration from the Ubuntu mainline PPA.
>
> I think I managed to reproduce it. The below seems to fix it for me, can you
> try it out please?

Yes, it fixes the schedutil governor behaving like the performance governor
problem on my i7-2600K test system.

I re-ran the tests several times, and re-booted back to the stock (problem)
kernel to verify incorrect schedutil governor performance (i.e. I toggled
back and forth, 2 times for each of 2 kernels, tests 1 and 2, total 8 tests).
Kernel 5.5-rc2: 4 tests FAILED (as expected).
Kernel 5.5-rc2 + this patch: 4 tests PASSED.

Accidentally tested:
Kernel 5.5-rc2 + this patch + command line "cgroup_no_v1=all": 1 test PASS.

> I think what's going on is that the child group default util_min value isn't
> propagated correctly after it's created, so we end up using the root_task_group
> values which is 1024 for both min and max.

O.K. thanks.

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90e4b00ace89..cf9d9106d1b5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7100,6 +7100,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
>
>        if (parent)
>                sched_online_group(tg, parent);
> +
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       cpu_util_update_eff(css);
> +#endif
> +
>        return 0;
>  }

... Doug


