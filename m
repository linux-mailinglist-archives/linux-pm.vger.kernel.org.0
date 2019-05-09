Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1118808
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIJ4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 05:56:21 -0400
Received: from verein.lst.de ([213.95.11.211]:44825 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfEIJ4V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 05:56:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 726AE68AFE; Thu,  9 May 2019 11:56:01 +0200 (CEST)
Date:   Thu, 9 May 2019 11:56:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Message-ID: <20190509095601.GA19041@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com> <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM> <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM> <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com> <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com> <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 05:42:30PM +0800, Kai-Heng Feng wrote:
>> That would be a set of 6 new suspend and resume callbacks, mind you,
>> and there's quite a few of them already.  And the majority of drivers
>> would not need to use them anyway.
>
> I think suspend_to_idle() and resume_from_idle() should be enough?
> What are other 4 callbacks?
>
>>
>> Also, please note that, possibly apart from the device power state
>> setting, the S2I and S2R handling really aren't that different at all.
>> You basically need to carry out the same preparations during suspend
>> and reverse them during resume in both cases.
>
> But for this case, it’s quite different to the original suspend and 
> resume callbacks.

Let's think of what cases we needed.

The "classic" suspend in the nvme driver basically shuts down the
device entirely.  This is useful for:

 a) device that have no power management
 b) System power states that eventually power off the entire PCIe bus.
    I think that would:

     - suspend to disk (hibernate)
     - classic suspend to ram

The we have the sequence in your patch.  This seems to be related to
some of the MS wording, but I'm not sure what for example tearing down
the queues buys us.  Can you explain a bit more where those bits
make a difference?

Otherwise I think we should use a "no-op" suspend, just leaving the
power management to the device, or a simple setting the device to the
deepest power state for everything else, where everything else is
suspend, or suspend to idle.

And of course than we have windows modern standby actually mandating
runtime D3 in some case, and vague handwaving mentions of this being
forced on the platforms, which I'm not entirely sure how they fit
into the above picture.
