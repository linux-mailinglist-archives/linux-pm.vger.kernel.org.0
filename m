Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7AEB9506
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfITQPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 12:15:00 -0400
Received: from cmta19.telus.net ([209.171.16.92]:50410 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387607AbfITQPA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 12:15:00 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id BLYcixrqHhFQMBLYfizcmy; Fri, 20 Sep 2019 10:14:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1568996098; bh=aeW5jjgqMzuGpbSTqqcFvfJB2sG1SOju6ifKBt3X4nA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=ut4W5JlRbBs/LfaCZ0cvUtvvEY12iJlMJTI+gVjI9kT8JIbYEpSWjDUQQc1ryzopi
         bbZe40MrKhrsvz2xaDpfZTA85WzCb4e+wZglH1dQfZVZrT+YMkK5dWx8b6zu5NzhCe
         WYplAOXd1Gs6q97qlB7YFwW+WeCrVlKJgyUb/JkPPfiWd5Iyc4dk/kWvKc6q9l4GJS
         VzRrWG033CFISxNIBUn4BU6Bus2IfOzzl0i/VY13aL1EfX+OxzqKHDRU3rztCjHLUF
         R/bbE6W+mOv26zkNOwyOKlPcTWVfWvLdSCYDbwDfio3u0iJvIfG2OtdXjTp2/G/WFF
         Ljbotf6WSDI7w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=lKRXr2rw8dOSno3372cA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4106941.QTENAb3AiO@kreacher>
In-Reply-To: <4106941.QTENAb3AiO@kreacher>
Subject: RE: [RFC][PATCH] cpuidle: Use nanoseconds as the unit of time
Date:   Fri, 20 Sep 2019 09:14:57 -0700
Message-ID: <000401d56fce$8bcb4bc0$a361e340$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVkB9p1OMgD49xWTKubfSRhN7dHwQLxMqHQ
X-CMAE-Envelope: MS4wfEu78SYq01PiaV8mL0V2T30TQXpiU9TA3ipVXHzCMWY7bpW+tCrIZG8nLsi7itIjzDjTUpleMX2fg4yWUSKCoDuWKaIoJ+4fVPH0MHooQlVe/x/l/zqf
 FeqOwszXyyqz43gw7Bjy4jrwnwJl6wSMDAhgIXsyuezUeBeQAowl4GtvI1CozwHt+TbX4aN7nC516mVzYnNu8mjCyQmqbor6PKao1ITLgHl3nbkW8GHFQMZo
 dCLTrOcK9FrKDr3DCldPnhaT/rqxbFoofnnF5/09Csk=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

To be able to try this patch (and the idle disable consolidation one),
I simply waited until it would apply properly in the main git tree, which it now does.

However it does not compile:

On 2019.09.05 09:35 Rafael J. Wysocki wrote:

...

> In addition to that, change
> cpuidle_governor_latency_req() to return the idle state exit
> latency constraint in nanoseconds.

...

> Index: linux-pm/drivers/cpuidle/governors/menu.c

...

> @@ -388,13 +390,13 @@ static int menu_select(struct cpuidle_dr
> 			 * closest timer event, select this one to avoid getting
> 			 * stuck in the shallow one for too long.
> 			 */
> -			if (drv->states[idx].target_residency < TICK_USEC &&
> -			    s->target_residency <= ktime_to_us(delta_next))
> +			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> +			    s->target_residency_ns <= delta_next)
> 				idx = i;
> 
> 			return idx;
> 		}
> -		if (s->exit_latency > latency_req)
> +		if (s->exit_latency_ns > latency_req_ns)
                                     ^^^^^^^^^^^^^^^
Should be (I think):

+		if (s->exit_latency_ns > latency_req)


