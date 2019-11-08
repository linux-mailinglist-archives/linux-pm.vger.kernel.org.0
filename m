Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46924F3D17
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 01:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKHAx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 19:53:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57212 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfKHAx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 19:53:28 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id ce3d5ac9ff617bdc; Fri, 8 Nov 2019 01:53:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH V6 1/3] cpuidle: play_idle: Make play_idle more flexible
Date:   Fri, 08 Nov 2019 01:53:25 +0100
Message-ID: <11162801.HHDnLhZHqx@kreacher>
In-Reply-To: <d185fdf8-8398-c8f5-b49a-47e5bb00607c@linaro.org>
References: <20191030075141.1039-1-daniel.lezcano@linaro.org> <d185fdf8-8398-c8f5-b49a-47e5bb00607c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, November 6, 2019 7:27:47 PM CET Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> 
> On 30/10/2019 08:51, Daniel Lezcano wrote:
> > The play_idle function has two users, the intel powerclamp and the
> > idle_injection.
> > 
> > The idle injection cooling device uses the function via the
> > idle_injection powercap's APIs. Unfortunately, play_idle is currently
> > limited by the idle state depth: by default the deepest idle state is
> > selected. On the ARM[64] platforms, most of the time it is the cluster
> > idle state, the exit latency and the residency can be very high. That
> > reduces the scope of the idle injection usage because the impact on
> > the performances can be very significant.
> > 
> > If the idle injection cycles can be done with a shallow state like a
> > retention state, the cooling effect would eventually give similar
> > results than the cpufreq cooling device.
> > 
> > In order to prepare the function to receive an idle state parameter,
> > let's replace the 'use_deepest_state' boolean field with 'use_state'
> > and use this value to enter the specific idle state.
> > 
> > The current code keeps the default behavior which is go to the deepest
> > idle state.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Is it possible to merge this series so I can make some progress on
> upstreaming the idle cooling device which depends on these three patches?

That would be possible if the series had no problems, but it appears to have
some.

Let me reply to the patches.



