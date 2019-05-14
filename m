Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8291D159
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 23:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfENVeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 17:34:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58132 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENVeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 17:34:25 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id d20e61f057c9bf41; Tue, 14 May 2019 23:34:22 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers in cpufreq_init_policy()
Date:   Tue, 14 May 2019 23:34:21 +0200
Message-ID: <5419807.rnaO30Ka2M@kreacher>
In-Reply-To: <20190513101140.00002e59.zbestahu@gmail.com>
References: <20190429072418.7860-1-zbestahu@gmail.com> <4262450.pcLMbF6iK3@kreacher> <20190513101140.00002e59.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, May 13, 2019 4:11:40 AM CEST Yue Hu wrote:
> On Mon, 29 Apr 2019 10:37:45 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Monday, April 29, 2019 9:56:40 AM CEST Yue Hu wrote:
> > > On Mon, 29 Apr 2019 09:37:27 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >   
> > > > On Mon, Apr 29, 2019 at 9:24 AM Yue Hu <zbestahu@gmail.com> wrote:  
> > > > >
> > > > > From: Yue Hu <huyue2@yulong.com>
> > > > >
> > > > > In cpufreq_init_policy() we will check if there's last_governor for target
> > > > > and setpolicy type. However last_governor is set only if has_target() is
> > > > > true in cpufreq_offline(). That means find last_governor for setpolicy
> > > > > type is pointless. Also new_policy.governor will not be used if ->setpolicy
> > > > > callback is set in cpufreq_set_policy().
> > > > >
> > > > > Moreover, there's duplicate ->setpolicy check in using default policy path.
> > > > > Let's add a new helper function to avoid it. Also update a little comment.
> > > > >
> > > > > Signed-off-by: Yue Hu <huyue2@yulong.com>    
> > > > 
> > > > Have you tested this with the intel_pstate driver (in the active mode)?  
> > > 
> > > No, just tested for ARM. It should be common logic from code perspective.  
> > 
> > But it is prudent to test changes on various configurations that may be affected.
> > 
> > Testing intel_pstate shouldn't be too difficult.
> 
> Hi Rafael,
> 
> Sorry for late test since i take time to emulate/find the board with Sandy brigdge
> processor.
> 
> I'm sure intel_pstate setpolicy driver is working fine by tests containing policy init,
> hotplug and changing scaling_governor.

Now applied, thanks!



