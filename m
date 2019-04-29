Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDEDE0F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfD2Ihr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 04:37:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42616 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfD2Ihr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 04:37:47 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id e60fc47b58aa26a3; Mon, 29 Apr 2019 10:37:45 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers in cpufreq_init_policy()
Date:   Mon, 29 Apr 2019 10:37:45 +0200
Message-ID: <4262450.pcLMbF6iK3@kreacher>
In-Reply-To: <20190429155640.00004adb.zbestahu@gmail.com>
References: <20190429072418.7860-1-zbestahu@gmail.com> <CAJZ5v0jLd9gnw_QuD-aK6fFpdDACbKXJOBugrCNtx1tfmBKi5w@mail.gmail.com> <20190429155640.00004adb.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 29, 2019 9:56:40 AM CEST Yue Hu wrote:
> On Mon, 29 Apr 2019 09:37:27 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Mon, Apr 29, 2019 at 9:24 AM Yue Hu <zbestahu@gmail.com> wrote:
> > >
> > > From: Yue Hu <huyue2@yulong.com>
> > >
> > > In cpufreq_init_policy() we will check if there's last_governor for target
> > > and setpolicy type. However last_governor is set only if has_target() is
> > > true in cpufreq_offline(). That means find last_governor for setpolicy
> > > type is pointless. Also new_policy.governor will not be used if ->setpolicy
> > > callback is set in cpufreq_set_policy().
> > >
> > > Moreover, there's duplicate ->setpolicy check in using default policy path.
> > > Let's add a new helper function to avoid it. Also update a little comment.
> > >
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> > 
> > Have you tested this with the intel_pstate driver (in the active mode)?
> 
> No, just tested for ARM. It should be common logic from code perspective.

But it is prudent to test changes on various configurations that may be affected.

Testing intel_pstate shouldn't be too difficult.

> Has any issue in this change?

Not in principle, but I need to check the details.

In general I'm a bit hesitant to take changes that haven't been tested properly.

Thanks,
Rafael



