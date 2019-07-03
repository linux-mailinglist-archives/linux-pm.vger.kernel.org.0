Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBFA5EC8C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCTMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 15:12:09 -0400
Received: from cmta17.telus.net ([209.171.16.90]:55970 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfGCTMJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 15:12:09 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ikfkhVmzwzEP4ikflhol97; Wed, 03 Jul 2019 13:12:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1562181127; bh=duuBS6rinMa0pwtOKOVf/BFNNO4Ic1/CAz5zHoIh6XA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=qtI1TSvtcp1usB7XvPwIbPFB+xJblM1BUnwhmuMsmTZqt070RQ3+dwZGMYtjr39oQ
         E4fGlhXQ/bWaYXCQ3aQAyOIkweLECJTWzUPIC952erLEdO0ZBSyMTfJVF0jl0Y/Ag1
         e0N97hTYpcwQ9Me+/yqIUE3ZBrlFd9aJ6dy8inAMT4RaRF1t+2ODzjrcaOnIzOGHdn
         cAudzu7E/Btps+bJnZKPAeXiYaT/NBZK5B/S9Tjhn6Q66N5xS+Aprgj5QL8Be8STc8
         W5HwHEbZO82E4atCv6j5+QPNxLU9yk7mZ7nPvZufcF2jkbV6BAlqmTC8ijMY15k6U/
         ZhLqiJFl1nmzw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=cYmsUULM c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8 a=kWJDoAjU50K2MEyS90sA:9 a=QEXdDO2ut3YA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'open list:CPU IDLE TIME MANAGEMENT FRAMEWORK'" 
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org> <000101d531aa$e00987e0$a01c97a0$@net> <6589a058-c538-fbf3-7761-d43ab8434654@linaro.org>
In-Reply-To: <6589a058-c538-fbf3-7761-d43ab8434654@linaro.org>
Subject: RE: [PATCH] cpuidle/drivers/mobile: Add new governor for mobile/embedded systems
Date:   Wed, 3 Jul 2019 12:12:03 -0700
Message-ID: <000a01d531d3$3471a060$9d54e120$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdUxskNHh9ahYXCXQ82aPBZqjRxmngAFv0oA
X-CMAE-Envelope: MS4wfF7v91g2X7U5hcjl4wllzOJpv6pIkupad2wCk1AC5zpzSc7M92u9y433Q/ErjieDGGPRW9k70rjyMAS3l85uTGBUfzWaT2FHG0xnnYj2zJzSYVcmwTm0
 DAtxBGAb3Dy5Yb4rdiLuyABzbPlfD/imUJy7UlDVcQvkF6uCQQ95vsJbqxey1NqDmpa9XGPvTqEQrvEOJ99ik9aHSr4R9DQZ3A6pkYuo2mgHwyQ8p4LbjXkS
 +UmQk8SJ4Yw2I8UKkeFxTm/odEeZNYSd1B1B21gA39axctRmlNW9Iwl0t8Swp9EN3Ovts22kc6OHFHKgh3qYX8iC3FmcsQAeCcn3QdNPjv39IrLsSUMnxmWH
 y2lmf9yX9IbjwuVFIZ2+zN8DN6yduw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.07.03 08:16 Daniel Lezcano wrote:
> On 03/07/2019 16:23, Doug Smythies wrote:
>> On 2019.06.20 04:58 Daniel Lezcano wrote:

...
>> Anyway, I did a bunch of tests and such, but have deleted
>> most from this e-mail, because it's just noise. I'll
>> include just one set:
>> 
>> For a work load that would normally result in a lot of use
>> of shallow idle states (single core pipe-test * 2 cores).
>
> Can you share the tests and the command lines?

Yes, give me a few days to repeat the tests and write
it up properly. I am leaving town in an hour and for a day.

It'll be similar to this:
http://www.smythies.com/~doug/linux/idle/teo8/pipe/index.html
parent page (which I will do a better version):
http://www.smythies.com/~doug/linux/idle/teo8/index.html
...

>> I got (all kernel 5.2-rc5 + this patch):
>> 
>> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
>> Processor package power: 40.4 watts; 4.9 uSec/loop
>> 
>> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
>> Processor package power: 34 watts; 5.2 uSec/loop
>> 
>> Idle governor, mobile; CPU frequency scaling: intel-cpufreq/ondemand;
>> Processor package power: 25.9 watts; 11.1 uSec/loop
>> 
>> Idle governor, menu; CPU frequency scaling: intel-cpufreq/ondemand;
>> Processor package power: 34.2 watts; 5.23 uSec/loop
>> 
>> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
>> Maximum CPU frequency limited to 73% to match mobile energy.
>> Processor package power: 25.4 watts; 6.4 uSec/loop
>
> Ok that's interesting. Thanks for the values.
>
> The governor can be better by selecting the shallow states, the
> scheduler has to interact with the governor to give clues about the
> load, that is identified and will be the next step.
>
> Is it possible to check with the schedutil governor instead?

Oh, I already have some data, just didn't include it before:

Idle governor, teo; CPU frequency scaling: intel-cpufreq/schedutil;
Processor package power: 40.4 watts; 4.9 uSec/loop

Idle governor, mobile; CPU frequency scaling: intel-cpufreq/schedutil;
Processor package power: 12.7 watts; 19.7 uSec/loop

Idle governor, teo; CPU frequency scaling: intel-cpufreq/schedutil;
Idle states 0-3 disabled (note: Idle state 4 is the deepest on my system)
Processor package power: 36.9 watts; 8.3 uSec/loop
In my notes I wrote: "Huh?? I do not understand this result, as I had
expected more similar to the mobile governor". But I did not investigate.

Anyway, the schedutil test is the one I'll repeat and write up better.

... Doug


