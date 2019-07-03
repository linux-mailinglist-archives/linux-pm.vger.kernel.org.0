Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0007E5E67D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCOX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 10:23:28 -0400
Received: from cmta16.telus.net ([209.171.16.89]:53768 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfGCOX1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 10:23:27 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id igAMheaLBJEJsigAOhrMEU; Wed, 03 Jul 2019 08:23:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1562163805; bh=FwIOGSKo/C4MkBroMAyJwpNbnbaRplkoVOhImgKqDU0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=M/ixJmsw7flgaf4UTEOEVJPoyGWtiP6/24MzpTE5D+4GgidiipMlP96tkJe3qlQMe
         VJo8sT2afLnhYo0okeVphGkuUzLRWAp/5rIjYJaIPa9YXq/WHU3PXQDJFBgA4/lDYp
         a9sGyl1YY2cmuZCRn/4iBt7FcziMZhPvBTmzSUYanNleaSah0rzyou7wg9V1YrP2jL
         TpF41wKJZNUPS4An4oo8I/Pn+GCnFhEzF0HHy6H2zxEVVmu9UJ6jB59eMNQT3t/yb/
         CG2UqpL2z5C3vwE3DtzQ60jMFrMaZ9Ct4/Huq4fYDB1lFBjrnppe4YeHwWgsFDcY3d
         8JC/MU4BaGqLQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=S/CnP7kP c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=zXcWA30KZW6HlxqIn7IA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'open list:CPU IDLE TIME MANAGEMENT FRAMEWORK'" 
        <linux-pm@vger.kernel.org>, <rafael@kernel.org>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190620115826.4897-1-daniel.lezcano@linaro.org>
Subject: RE: [PATCH] cpuidle/drivers/mobile: Add new governor for mobile/embedded systems
Date:   Wed, 3 Jul 2019 07:23:22 -0700
Message-ID: <000101d531aa$e00987e0$a01c97a0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdUnX4aMR/4f4gKnR1C+VRSe+MmSrwCgrH+w
X-CMAE-Envelope: MS4wfGGiQmvKIDYzuHZ2TbxQRzcMKbt6tzlkiAyxa/5fNRBo6c9uVX1cI8AtAZ55hnb8muNPVBuKrK1WvCuQf6R5PR8X4+peNBjYkTpFx6EJ0PB3WIlPbUKT
 JaTiaJjV031ucuGgHqRvqyb9VKRH5gredccFcKEIwCj0+8chIdgCu1HCU5y9OjPzkb9T8wa8oXE+9vhRSvYVpFbVE60OSa8NSaNTmyqBviYe1u5heBDXFi9g
 tE2/frp4m8X/p7dODCF7IfLbgUuLeExPSU7YglOsh2NSiGyAspfNVlzWgRn9lmqtsiitkbXYQcAfXPPaKnoFhOjNTl/cJcEf9ChNu7oFrxfswu97qmpXA+1I
 zsdh9bGM9Sl+1enQT8ZNCVQBOiRSTg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

I tried your "mobile" governor, albeit not on a mobile device.

On 2019.06.20 04:58 Daniel Lezcano wrote:

...

> The mobile governor is a new governor targeting embedded systems
> running on battery where the energy saving has a higher priority than
> servers or desktops. This governor aims to save energy as much as
> possible but with a performance degradation tolerance.
>
> In this way, we can optimize the governor for specific mobile workload
> and more generally embedded systems without impacting other platforms.

I just wanted to observe the lower energy, accepting performance
degradation. My workloads may have been inappropriate.

...

> +
> +#define EMA_ALPHA_VAL		64
> +#define EMA_ALPHA_SHIFT		7
> +#define MAX_RESCHED_INTERVAL_MS	100
> +
> +static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
> +
> +static int mobile_ema_new(s64 value, s64 ema_old)
> +{
> +	if (likely(ema_old))
> +		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
> +				  EMA_ALPHA_SHIFT);
> +	return value;
> +}

Do you have any information as to why these numbers?
Without any background, the filter seems overly new value weighted to me.
It is an infinite impulse response type filter, currently at:

output = 0.5 * old + 0.5 * new.

I tried, but didn't get anything conclusive:

output = 0.875 * old + 0.125 * new.

I did it this way:

#define EMA_ALPHA_VAL           7
#define EMA_ALPHA_SHIFT         3
#define MAX_RESCHED_INTERVAL_MS 100

static DEFINE_PER_CPU(struct mobile_device, mobile_devices);

static int mobile_ema_new(s64 value, s64 ema_old)
{
        if (likely(ema_old))
                return ((ema_old * EMA_ALPHA_VAL) + value) >>
                                  EMA_ALPHA_SHIFT;
        return value;
}

...

> +	/*
> +	 * Sum all the residencies in order to compute the total
> +	 * duration of the idle task.
> +	 */
> +	residency = dev->last_residency - s->exit_latency;

What about when the CPU comes out of the idle state before it
even gets fully into it? Under such conditions it seems to hold
much too hard at idle states that are too deep, to the point
where energy goes up while performance goes down.

Anyway, I did a bunch of tests and such, but have deleted
most from this e-mail, because it's just noise. I'll
include just one set:

For a work load that would normally result in a lot of use
of shallow idle states (single core pipe-test * 2 cores).
I got (all kernel 5.2-rc5 + this patch):

Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
Processor package power: 40.4 watts; 4.9 uSec/loop

Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
Processor package power: 34 watts; 5.2 uSec/loop

Idle governor, mobile; CPU frequency scaling: intel-cpufreq/ondemand;
Processor package power: 25.9 watts; 11.1 uSec/loop

Idle governor, menu; CPU frequency scaling: intel-cpufreq/ondemand;
Processor package power: 34.2 watts; 5.23 uSec/loop

Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
Maximum CPU frequency limited to 73% to match mobile energy.
Processor package power: 25.4 watts; 6.4 uSec/loop

... Doug


