Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D866159E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2019 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGGRCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 13:02:36 -0400
Received: from cmta17.telus.net ([209.171.16.90]:42398 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfGGRCg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Jul 2019 13:02:36 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id kAYZh0BnhzEP4kAYah9Sy0; Sun, 07 Jul 2019 11:02:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1562518954; bh=ziWafZ+lt82+u/sMNbjV3tTwr8KJUQ1KoqPEgByOp6U=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=t6UDm7RdjsSssvvszNixRcYGgB21LloNxniDCAJvZLyl+cWqujMkZq3Reb77nS21y
         tf6liq5dlAYpZLlE1Qx42EBdW7NgmCA8HMojTOOYK3vR6hOkETKJa4v4vX8WgidfXn
         2MVH+9VtZG3aTPZKhZwaZU2Lfy+3wQ6PzxHRXj/pNb74rAxCL7RwbihDqwD904Ji9F
         kSFVd8fH7FxVvB38p8xGVWq/7c7qy/pCuvxDT069JtI3MSnEsOvgArbuaIGaVWjknq
         DehN1/DhmFk/68AyB0dwdVxDD8g/RLoDpap5qmnLyMo7JVqXsBYi44ZrMhPoGnhbbx
         OPCI6N4dqQowg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=cYmsUULM c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8 a=yPBhtU7W74RIm9p7gY0A:9 a=QEXdDO2ut3YA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'open list:CPU IDLE TIME MANAGEMENT FRAMEWORK'" 
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org> <000101d531aa$e00987e0$a01c97a0$@net> <6589a058-c538-fbf3-7761-d43ab8434654@linaro.org> <000a01d531d3$3471a060$9d54e120$@net>
In-Reply-To: <000a01d531d3$3471a060$9d54e120$@net>
Subject: RE: [PATCH] cpuidle/drivers/mobile: Add new governor for mobile/embedded systems
Date:   Sun, 7 Jul 2019 10:02:29 -0700
Message-ID: <000301d534e5$c43217b0$4c964710$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUxskNHh9ahYXCXQ82aPBZqjRxmngAFv0oAAMatxrA=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfPQTbe6Gr2O5xhM0q1Z47ItKI19CjQruPFMEXY/ZK8zCYL9nTAbzQINCZXOPsHxonJBlwO1sjzDAMXvQN9RO0lYddhBGIfPUti5VRPVZTdXUUIyrf3gh
 2fvTl5zUQOxv+CMeCm+Tt4SotVPBiOwjLy2jLTKOT/NRUEHnVNHUHASXzsi0aqe6fOM5Tc/XbmWeEDazZu9Bs7kTeOkIaJrzPexm/GMCQ9YV3VTExX5dCwT+
 HWpLWJRsB11gcGx49aYpDw7h/7cmT9uPxxKXy6LmV4nz7DejEkXuqrKaQoXpvycgTlce35ER1W26gW5hzQ7u2ZfcAtUoR0PNbQLQUQbEEbpQvqDowHD0bTN6
 Z/K5NdpjtHeIlObESaTAgguEXX6UtA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.07.03 12:12 Doug Smythies wrote:
> On 2019.07.03 08:16 Daniel Lezcano wrote:
>> On 03/07/2019 16:23, Doug Smythies wrote:
>>> On 2019.06.20 04:58 Daniel Lezcano wrote:

> ...
>>> Anyway, I did a bunch of tests and such, but have deleted
>>> most from this e-mail, because it's just noise. I'll
>>> include just one set:
>>> 
>>> For a work load that would normally result in a lot of use
>>> of shallow idle states (single core pipe-test * 2 cores).
>>
>> Can you share the tests and the command lines?
>
> Yes, give me a few days to repeat the tests and write
> it up properly. I am leaving town in an hour and for a day.

O.K. I re-did the tests and made a new web page with, I think,
everything I used.

...

>> The governor can be better by selecting the shallow states, the
>> scheduler has to interact with the governor to give clues about the
>> load, that is identified and will be the next step.
>>
>> Is it possible to check with the schedutil governor instead?
>
> Oh, I already have some data, just didn't include it before:
>
> Idle governor, teo; CPU frequency scaling: intel-cpufreq/schedutil;
> Processor package power: 40.4 watts; 4.9 uSec/loop
>
> Idle governor, mobile; CPU frequency scaling: intel-cpufreq/schedutil;
> Processor package power: 12.7 watts; 19.7 uSec/loop
>
> Idle governor, teo; CPU frequency scaling: intel-cpufreq/schedutil;
> Idle states 0-3 disabled (note: Idle state 4 is the deepest on my system)
> Processor package power: 36.9 watts; 8.3 uSec/loop
> In my notes I wrote: "Huh?? I do not understand this result, as I had
> expected more similar to the mobile governor". But I did not investigate.

The reason for the big difference was/is that with the "mobile"
governor the CPU frequency never scales up for this test. It can be
sluggish to scale up with the teo and the menu governors, but always
eventually does. I also tried the acpi-cpufreq driver with similar results.

> Anyway, the schedutil test is the one I'll repeat and write up better.

New summary (similar to old):

governor 		usec/loop	watts
mobile		19.8		12.67
teo			4.87		40.28
menu			4.85		40.25
teo-idle-0-3-dis	8.30		36.85

Graphs, details and source codes:
http://www.smythies.com/~doug/linux/idle/mobile/index.html

... Doug


