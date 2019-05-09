Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94291858F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIGwn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 02:52:43 -0400
Received: from verein.lst.de ([213.95.11.211]:43907 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfEIGwn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 02:52:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F1B9967358; Thu,  9 May 2019 08:52:23 +0200 (CEST)
Date:   Thu, 9 May 2019 08:52:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@dell.com, Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Message-ID: <20190509065223.GA15984@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com> <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM> <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM> <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 02:48:59PM +0800, Kai-Heng Feng wrote:
> Not really, for hibernation pm_suspend_via_s2idle() evaluates to false so 
> the old code path will be taken.
>
>>
>> And more to the points - if these "modern MS standby" systems are
>> becoming common, which it looks they are, we need support in the PM core
>> for those instead of working around the decisions in low-level drivers.
>
> Rafael, what do you think about this?
> Including this patch, there are five drivers that use 
> pm_suspend_via_{firmware,s2idle}() to differentiate between S2I and S3.
> So I think maybe it’s time to introduce a new suspend callback for S2I?

We also really need something like that to avoid the PCI_DEV_FLAGS_NO_D3
abuse - that flag is a quirk statically set on a device at probe time
to prevent any entering of D3 state.

>> per definition, although they might not be too useful.  I suspect checking
>> APSTA might be safer, but if we don't want to rely on APST we should
>> check for a power state supporting the condition that the MS document
>> quoted in the original document supports.
>
> If Modern Standby or Connected Standby is not supported by servers, I 
> don’t think the design documents mean much here.
> We probably should check if the platform firmware really supports S2I 
> instead.

That too.  As said this really is a platform decision, and needs to
be managed by the platform code through the PM core.  Individual drivers
like nvme can just implement the behavior, but are the absolute wrong
place to make decisions on what kinds of suspend to enter.
