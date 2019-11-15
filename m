Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4617EFD25D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 02:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKOBYI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 20:24:08 -0500
Received: from cmta19.telus.net ([209.171.16.92]:38883 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfKOBYI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Nov 2019 20:24:08 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id VQLDisIdVhFQMVQLEiZoU0; Thu, 14 Nov 2019 18:24:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573781045; bh=SaaZOxWPpA1oUIgRGITBL2YkfVbqvLtRxZDaYbwOsck=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=pULEYqD8gGrEOfTQzYJtff0HcPdC3fS90+rgtHOeUv468FBmIKnrldXsw5H9qiR2u
         Jd2lRSr3LqPTLJTHOMUEsQd7OdANyjMRguNTsrPO8bZkuk1dJC2fQeoFxrInVFLr63
         /SPZiRdSVd9EBEgv5v3tmuwIKyeMZXO8Hysk0ze8rQB+UxiseCxUMDBbphtD3MtFDZ
         uzA6U/TOcThAiqpreXWZnU3G7+n4mpU7Ux0Obrw9yQkOn6Wpu4Y0k3tQkGn11FGq8F
         dQOcpNo5+PPxZQstGlQups50iQmB3AQJvaje7amiE87OOhpreStH31NZ1sYLAMkK1S
         J5zCixlyXwXRg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=FGbulvE0AAAA:8
 a=FDqIjB1zuNXgCgwSOjIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
 a=XN2wCei03jY4uMu7D0Wg:22 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <13588000.TfE7eV4KYW@kreacher> <3144686.I8R4d9A2JO@kreacher> <CAJZ5v0jiBrx2xxf2EdvGrqke0ByK5YWXEw0R2rpHZYAJjgwJmg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiBrx2xxf2EdvGrqke0ByK5YWXEw0R2rpHZYAJjgwJmg@mail.gmail.com>
Subject: RE: [PATCH 2/3] cpuidle: teo: Avoid expecting unrealistic idle times
Date:   Thu, 14 Nov 2019 17:24:02 -0800
Message-ID: <001a01d59b53$5eb8ae10$1c2a0a30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWbRmV8IOJacMpNQga2PAxrKUg3RwACM+RQ
X-CMAE-Envelope: MS4wfAbD9LyVp0ZamvLOqcHUZr+po31sWiKJxtFCEo+UxAjx3hpDS/vAjwGSFxWayjkTUo9ee8o3snR4/lTa3U4/esOjqRUTbsQ15u1tdsQ2Vs2Mx4eiw5D8
 Rv+3ghq8VoThZ0Nb6OeaH3T+ZuZqPop5EhLITmx+4e+WxzZB3+pvL3G5tWQG1paMCOW/xpRZBnEFGyAPtdBhnwG2dmsw2ZrRGiqz+qgRT8YvlcdU4zY0heBL
 HbwM4LrrEPZovQj9pBxNLzyrlqwB5k4Vje4u4fh46k4=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.11.14 15:51 Rafael J. Wysocki wrote:
> On Wed, Nov 13, 2019 at 1:11 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If an idle state shallower than the one "matching" the time till the
>> next timer event is considered for selection, expect the idle duration
>> to fall in the middle of the "bin" corresponding to that state rather
>> than at the beginning of it which is unrealistic.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpuidle/governors/teo.c |    9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpuidle/governors/teo.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
>> +++ linux-pm/drivers/cpuidle/governors/teo.c
>> @@ -360,7 +360,14 @@ static int teo_select(struct cpuidle_dri
>>
>>                 if (max_early_idx >= 0) {
>>                         idx = max_early_idx;
>> -                       duration_ns = drv->states[idx].target_residency_ns;
>> +                       /*
>> +                        * Expect the idle duration to fall in the middle of the
>> +                        * "bin" corresponding to idx (note that the maximum
>> +                        * state index is guaranteed to be greater than idx at
>> +                        * this point).
>> +                        */
>> +                       duration_ns = (drv->states[idx].target_residency_ns +
>> +                               drv->states[idx+1].target_residency_ns) / 2;
>>                 }
>>         }
>
> This change turns out to cause the governor to choose idle states that
> are too deep or too shallow too often, so I'm withdrawing it.

O.K. thanks for letting us know.
I did see some differences in the testing I did so far, but hadn't drilled down
into it yet.
I am somewhat wondering about the above and below stats in general.

By the way, I had a daft mistake in my post processing program, such that the
"below" graph for idle state 0 was always plotting 0.

Reference for that sweep test that I do (which is as far I got so far):
http://www.smythies.com/~doug/linux/idle/teo-2019-11/sweep/index.html

Legend:

teo-v2: re-run of previous teo-v2 so that I could get non-zero idle state "below" data
linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks +
[PATCH v2] cpuidle: Use nanoseconds as the unit of time

teo-v3: teo-v2 + cpuidle: teo: Exclude cpuidle overhead from computations

teo-v4: linux-pm + linux-next 2019.11.12 +
cpuidle: teo: Avoid code duplication in conditionals
cpuidle: teo: Avoid expecting unrealistic idle times
cpuidle: teo: Avoid using "early hits" incorrectly

teo-v5: teo-v4 + cpuidle: teo: Exclude cpuidle overhead from computations

... Doug


