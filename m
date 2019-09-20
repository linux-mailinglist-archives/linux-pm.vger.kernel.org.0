Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE703B9507
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfITQO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 12:14:59 -0400
Received: from cmta19.telus.net ([209.171.16.92]:33984 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfITQO7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 12:14:59 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id BLYcixrqHhFQMBLYdizcmK; Fri, 20 Sep 2019 10:14:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1568996097; bh=RUYhuh03AWpyXrhe36YHbc9Kzkl3FxGlHeWE+9arW5s=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=BYn5cL8kXXsMBbimMbVvsi1YUzMRFdsEoVgf0pb3xYbVPEZgDff0WbBkPRl3FgsOk
         t8t/rieWlwULkZLXjIFnHQbO3duHGigopDC+lx5UscCxkBih1Vdng+CXsU8/DHN3XB
         Jgg1Ls2XWkatJrdCkRvEpeiNtiXrW9DmG6u/YJ8ggfzzejUAWdgdUiYOg6/cToXL4O
         peMNvRDwh9wjQpk3yjwuAblyNgBqUYeWh9RR3cyNWRWsOL8/c0Ru1IskAP/QJN8Eep
         ItDvsMY1hO0OlArovvimc+sH09N7aqnVlScX8WYd69dhszxm1BF3wu0oKdoIq/PPzJ
         Dhmm6KYTLX1tg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=EQAEwcx4HyKEWR1RinsA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2136682.Ujdk25Y4fk@kreacher>
In-Reply-To: <2136682.Ujdk25Y4fk@kreacher>
Subject: RE: [RFC][PATCH] cpuidle: Consolidate disabled state checks
Date:   Fri, 20 Sep 2019 09:14:53 -0700
Message-ID: <000301d56fce$8b291850$a17b48f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVjDXz9qGdpowVdSemrfaiLLN1WhwMu3Lfw
X-CMAE-Envelope: MS4wfJz4ySQGglB5wBKGXOKy3q6Yw7VXSZ6LDI+PfvxhtBVBxaPEk6/xeJA+1azcLGAjEqeV4JmgwcREu4F7M5gYAnojlgr+jS6+M2kZV3twwHIWHfv4n7Xs
 krToC2dYEumMAQevyJH7PwlfhEcPiV11FE5ytmCAtGUWe2KzurGvruZ9Wh6jObp+U8H1BvgNCLoBMt/OD1qR+DLZZtswSsJRii6vi2ylkWD7WR5JuiOOZkiQ
 +VXXhAgcN4qDNLx2IyJ+m0Wpje7kKQBDRVd6QP5QE0w=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

To be able to try this patch (and the nanosecond as unit of time one),
I simply waited until it would apply properly in the main git tree, which it now does.

However it does not compile:

On 2019.09.04 03:41 Rafael J. Wysocki wrote:

...

> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -298,7 +298,7 @@ static int menu_select(struct cpuidle_dr
>  	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
>  	    ((data->next_timer_us < drv->states[1].target_residency ||
>  	      latency_req < drv->states[1].exit_latency) &&
> -	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
> +	     !dev->states_usage[0].disable)) {
> 		/*
> 		 * In this case state[0] will be used no matter what, so return
> 		 * it right away and keep the tick running if state[0] is a
> @@ -349,9 +349,8 @@ static int menu_select(struct cpuidle_dr
> 	idx = -1;
> 	for (i = 0; i < drv->state_count; i++) {
> 		struct cpuidle_state *s = &drv->states[i];
> -		struct cpuidle_state_usage *su = &dev->states_usage[i];
> 
> -		if (s->disabled || su->disable)
> +		if (dev->states_usage[i]->disable)
                                ^^^^^^^^^^
Should be (I think):
+		if (dev->states_usage[i].disable)

... Doug


