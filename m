Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA6189912
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 11:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRKRP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 06:17:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKRP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 06:17:15 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 8f5f7f5efe089b69; Wed, 18 Mar 2020 11:17:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@kernel.org
Subject: Re: [PATCH RFC] cpuidle: consolidate calls to time capture
Date:   Wed, 18 Mar 2020 11:17:12 +0100
Message-ID: <2605374.f08NWHE4iP@kreacher>
In-Reply-To: <20200316210843.11678-1-daniel.lezcano@linaro.org>
References: <20200316210843.11678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, March 16, 2020 10:08:43 PM CET Daniel Lezcano wrote:
> A few years ago, we changed the code in cpuidle to replace ktime_get()
> by a local_clock() to get rid of potential seq lock in the path and an
> extra latency.
> 
> Meanwhile, the code evolved and we are getting the time in some other
> places like the power domain governor and in the future break even
> deadline proposal.

Hmm?

Have any patches been posted for that?

> Unfortunately, as the time must be compared across the CPU, we have no
> other option than using the ktime_get() again. Hopefully, we can
> factor out all the calls to local_clock() and ktime_get() into a
> single one when the CPU is entering idle as the value will be reuse in
> different places.

So there are cases in which it is not necessary to synchronize the time
between CPUs and those would take the overhead unnecessarily.

This change looks premature to me at least.

Thanks!



