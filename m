Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85AAA1885F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIKcD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 06:32:03 -0400
Received: from verein.lst.de ([213.95.11.211]:44976 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfEIKcD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 06:32:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9B83E68B20; Thu,  9 May 2019 12:31:42 +0200 (CEST)
Date:   Thu, 9 May 2019 12:31:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20190509103142.GA19550@lst.de>
References: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM> <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM> <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com> <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com> <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com> <20190509095601.GA19041@lst.de> <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 06:28:32PM +0800, Kai-Heng Feng wrote:
> Based on my testing if queues (IRQ) are not disabled, NVMe controller 
> won’t be quiesced.
> Symptoms can be high power drain or system freeze.
>
> I can check with vendors whether this also necessary under Windows.

System freeze sounds odd.  And we had a patch from a person on the
Cc list here that was handed to me through a few indirections that
just skipps the suspend entirely for some cases, which seemd to
work fine with the controllers in question.

>> Otherwise I think we should use a "no-op" suspend, just leaving the
>> power management to the device, or a simple setting the device to the
>> deepest power state for everything else, where everything else is
>> suspend, or suspend to idle.
>
> I am not sure I get your idea. Does this “no-op” suspend happen in NVMe 
> driver or PM core?

no-op means we don't want to do anything in nvme.  If that happens
by not calling nvme or stubbing out the method for that particular
case does not matter.

>> And of course than we have windows modern standby actually mandating
>> runtime D3 in some case, and vague handwaving mentions of this being
>> forced on the platforms, which I'm not entirely sure how they fit
>> into the above picture.
>
> I was told that Windows doesn’t use runtime D3, APST is used exclusively.

As far as I know the default power management modes in the Microsoft
NVMe driver is explicit power management transitions, and in the Intel
RST driver that is commonly used it is APST.  But both could still
be comined with runtime D3 in theory, I'm just not sure if they are.

Microsoft has been pushing for aggressive runtime D3 for a while, but
I don't know if that includes NVMe devices.

>
> Kai-Heng
>
---end quoted text---
