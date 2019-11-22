Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD334105DAE
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 01:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKVA2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 19:28:06 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:50003 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKVA2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Nov 2019 19:28:06 -0500
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 19:28:06 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 47Jxgf28wFzDxl
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 19:11:58 -0500 (EST)
Received: from hp-x360n.router (unknown [107.72.99.23])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Jxgd08lkz1M1M;
        Thu, 21 Nov 2019 19:11:56 -0500 (EST)
Date:   Thu, 21 Nov 2019 16:11:55 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     rafael.j.wysocki@intel.com
cc:     linux-pm@vger.kernel.org
Subject: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
Message-ID: <alpine.DEB.2.21.1911211549500.3167@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


I've been running Linus' tip for a while, mostly to get the PM improvements
on s2idle (I hate this mode so much- I'm tired of taking a warm laptop out
of my bag) and I'd reported after a previous merge to Linus' tip from pm-next:

On Wed, 18 Sep 2019, Kenneth R. Crudup wrote:

> - Randomly, if left suspended, nothing other than a hard power off will get
>   it back  ...  It appears "ec_no_wakeup=1" doesn't have this issue

So I noticed this bug seems to only happen if the laptop is plugged in and
charging- but only if the battery is < 100%; now that I had a real failure
mode I started bisecting, and I traced it to 56b991849, "PM: sleep: Simplify
suspend-to-idle control flow".

What happens is I'll initiate a suspend, then when I try to resume the power
LED doesn't come on, and the machine is completely unresponsive. I have to
force a reset by holding the power key.

I'd like to help you fix this issue; I figure if it's affecting my device
it's affecting others, too. I'm quite proficient with the kernel overall,
but know very little about ACPI or the EC. I'm assuming- totally wild guess-
that when we get some of those EC GPEs(?) while suspended(?) we're panic()ing
or hanging somewhere so the BIOS is getting hung up and the whole system is
stalled out.

Where should I begin to help debug this? I have EFI store set up so BUG_ON()s
et al.  will dump there for retrival later if inserting those at critical
places could help.

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
