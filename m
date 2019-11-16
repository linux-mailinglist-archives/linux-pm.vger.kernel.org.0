Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358FFECCD
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2019 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfKPPH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Nov 2019 10:07:58 -0500
Received: from cmta16.telus.net ([209.171.16.89]:52290 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKPPH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Nov 2019 10:07:58 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id VzfzizxjdFXoiVzg0iZxUB; Sat, 16 Nov 2019 08:07:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573916876; bh=gfhpbgmjK0Z6cFEsiYiyqlkxUABvV4et9WNwTIgnHR8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wEZ405YQjzJKpJhQ66akCoXMudTp/gWEf+zFV3m1ZVtZKKBHI0/031KGEMPBhKU0u
         ysFwqWOfGB18hbbjyZdGA3nA4ZRZvXLzlfxyUMmbeWMHiV/zy5vDlQBHkYBU+328oQ
         5ame1cxrfI0h8Gc4GsrXncCn6AOwasub91QFaw+Mdclhb5HLIXGnEqCXAOcLlmvVxQ
         PUPhyA2EWhaA3I02rNAzhv9QET8AVB/eR4YmjDIynru6osnw0PO7Q+Yb4aME9a+Qin
         z+2JfpLqL6zlvW4VVFURQKnubRVEgBPjGGzJxq8TJMSKWiAHVpD+Xa/kTVTP7k2xK2
         qHagXtlxrl9uw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=sBVMCQuwt-iZQsn2n_0A:9 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Sargun Dhillon'" <sargun@sargun.me>,
        "'Tejun Heo'" <tj@kernel.org>, "'Xie XiuQi'" <xiexiuqi@huawei.com>,
        <xiezhipeng1@huawei.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115215228.GN3079@worktop.programming.kicks-ass.net> <CAKfTPtDyZ5gom41S-8Nu+BMK7hPijWoZPqo0HFYkRnNmWo1UTA@mail.gmail.com>
In-Reply-To: <CAKfTPtDyZ5gom41S-8Nu+BMK7hPijWoZPqo0HFYkRnNmWo1UTA@mail.gmail.com>
Subject: RE: [PATCH v4] sched/freq: move call to cpufreq_update_util
Date:   Sat, 16 Nov 2019 07:07:49 -0800
Message-ID: <000601d59c8f$9fa191c0$dee4b540$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWcWopiwiZdY0yaRPete3H70UhivQAMM8sw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfG1sLv7HR5WrZlqpjRLUvD9/42QqRTBgrepLsZ3LDn/3VWI7wyyl4ZFDoYZVfFAvxNBJBrZ6WPfCdfRKp13YJGnqKYM+hpVh93k4GMjldDnHo6TmJE9J
 vyFV4tBWOLQduIKik6jHSIfmSnwF7W3yVi8dvdug88C3cGRkeF5sLriO8gIX5V5lZfj4qmYqA6mzN5Qn/a2HxL4lp2IMAR9mo9EwypcyBM+btqe7RYG69nWQ
 fAo1SkFabFm/euDSRU5C9+nSruJYSwy9Xds5iMGkRBxvZVJrfV4O+NB+bbNK+JED24SiDnRMw6czjdyq+07jGm8yYoYoGoCxpQsp5DGJ7fu2Cw4+G95LhkrR
 +QhhXsJaH+dYmnEQUcQghpCWOHdvPLEtAKSxJ0r9H3q/PCudwNSO8b3YWxZqBV9V8W/pBlhJdojRiXsV8N7+wXCmQJScEkporHC91+mEcVFrNUXsjmA3RSmZ
 4nIA0VMVwUl7e4LjrSs/QIAWWbP8zboFfVtNCkQ8B6v/PiTfLpZnPsJH1XaT+ErFhl3w3OpCF7UQ4WIY7g6xEW+FZw8IiXb4gyfieLsjmG/BciXLY2KjDwcg
 6eQXfqtPDiMlsmt/XbcbWUX08nUjiV8U3sJGNUSRBguwjrAkI6Ds/7WMiJtyLctKlzTwME+mdjxmSisf/dddUDJ9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I tested both Vincent's V4 and Peter's, I called it V1.

8000 seconds intel_pstate_tracer on a very idle system.
Everything was fine.

Vincent-V4:

Maximum time between calls to the intel_pstate driver,
per CPU: 4.00813 seconds: GOOD/PASS

Total entries/exits to/from driver: 90,730:
Consistent with previous tests / expectations.

228,600 aperf clocks / second / cpu.  
Consistent with previous tests / expectations.

Peter-V1:

Maximum time between calls to the intel_pstate driver,
per CPU: 4.00407 seconds: GOOD/PASS

Total entries/exits to/from driver: 96,440:
Consistent with previous tests / expectations.

241,310 aperf clocks / second / cpu.  
Consistent with previous tests / expectations.

Baseline reference:

Maximum time between calls to the intel_pstate driver,
per CPU: 225.03 seconds: BAD/FAIL

Number of durations over an arbitrary threshold of
10 seconds: 379.

Total entries/exits to/from driver: 75,969:
Consistent with previous tests / expectations,
when the issue is present.

226,963 aperf clocks / second / cpu.
Consistent with previous tests / expectations.

I did not do the load no-load energy test.
It is not possible for it to be a problem
if the long duration issue is solved.
I'll do the test, if someone wants the proof.

Kernels were 5.4-rc7 + linux next.
Idle governor was TEO, but this isn't actually relevant.

Tested-by: Doug Smythies <dsmythies@telus.net>

... Doug


