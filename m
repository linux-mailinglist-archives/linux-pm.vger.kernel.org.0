Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3217C2971B0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375850AbgJWOss (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 10:48:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375546AbgJWOss (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 10:48:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF27A113E;
        Fri, 23 Oct 2020 07:48:47 -0700 (PDT)
Received: from bogus (unknown [10.57.15.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC673F66E;
        Fri, 23 Oct 2020 07:48:45 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:48:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     claude yen <claude.yen@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
Message-ID: <20201023144842.zos4pvpwv4r3rv4j@bogus>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
 <20201022061748.13730-2-claude.yen@mediatek.com>
 <20201022070154.hqvksoj4nss3er2e@bogus>
 <1603427300.7573.6.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603427300.7573.6.camel@mtkswgap22>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 12:28:20PM +0800, claude yen wrote:
> On Thu, 2020-10-22 at 08:02 +0100, Sudeep Holla wrote:
> > On Thu, Oct 22, 2020 at 02:17:48PM +0800, Claude Yen wrote:
> > > As suspend_set_ops is exported in commit a5e4fd8783a2
> > > ("PM / Suspend: Export suspend_set_ops, suspend_valid_only_mem"),
> > > exporting s2idle_set_ops to make kernel module setup s2idle ops too.
> > > 
> > > In this way, kernel module can hook platform suspend
> > > functions regardless of Suspend-to-Ram(S2R) or
> > > Suspend-to-Idle(S2I)
> > >
> > 
> > If this is for arm64 platform, then NACK. You must use PSCI and it will
> > set the ops and it can't be module.
> > 
> 
> PSCI uses suspend_set_ops instead. And suspend_set_ops has been
> exported years ago.
> 
> Suspend-to_Idle(S2I) is another suspend method supported by linux
> kernel. The corresponding s2idle_ops can be hooked by s2idle_set_ops
> by underlying platforms.  For example, S2I is now introduced into
> Mediatek SoC platforms. Besides, power management driver is built as
> kernel module.
> 
> Mobile platforms are now call for kernel drivers to be kernel modules.
> This could help drivers easier to migrate to newer linux kernel.
> Ref: https://linuxplumbersconf.org/event/7/contributions/790/
> 

I understand that. But I am interested in looking at the module you want
to use this and how that interacts with PSCI. If this is arm64, you must
use PSCI for system suspend and cpu suspend. What does this module do on
top of those is what I want to know. Please post that module or point
me if it is already present in the tree.

-- 
Regards,
Sudeep
