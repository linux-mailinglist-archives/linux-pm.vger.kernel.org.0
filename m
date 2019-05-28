Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F22CA46
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfE1PWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 11:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfE1PWC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 May 2019 11:22:02 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8697220665;
        Tue, 28 May 2019 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559056921;
        bh=PalDUvKBMeq6uuZipz24GPUGFzG5XkO+thRy1zun59M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VziaK6AGw22sF91IPVjUlLI7s8SEbHlbbR1CSpa1YqBT8UxDZoOWojiMM3382H+JT
         +MZcVPm1TwlQSpEFl0F1+rKWz7a9M3QCnT8QhNJXNH6pAr0zp3c4xRsuQ4szoKw6Am
         aaStj644mgDbJhWmtR/8ipXC9RtNt1dVev24xfLI=
Date:   Tue, 28 May 2019 17:21:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1 regression]:
 nvme vs. hibernation)
In-Reply-To: <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain> <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm> <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 May 2019, Jiri Kosina wrote:

> > Looks this has been discussed in the past.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> > 
> > I created a fix for a case but not good enough.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html
> 
> That removes the warning, but I still seem to have ~1:1 chance of reboot 
> (triple fault?) immediately after hibernation image is read from disk. 

[ some x86/PM folks added ]

I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.

For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
breaks resume from hibernation; after the image is read out from disk and 
attempt is made to jump to the old kernel, machine reboots.

I verified that it succesfully makes it to the point where restore_image() 
is called from swsusp_arch_resume() (and verified that only BSP is alive 
at that time), but the old kernel never comes back and triplefault-like 
reboot happens.

It's sufficient to remove "nosmt" from the *resuming* kernel, and that 
makes the issue go away (and we resume to the old kernel that has SMT 
correctly disabled). So it has something to do with enabling & disabling 
the siblings before we do the CR3 dance and jump to the old kernel.

I haven't yet been able to isolate this to being (or not being) relevant 
to the pending nvme CQS warning above.

Any ideas how to debug this welcome. I haven't been able to reproduce it 
in a VM, so it's either something specific to that machine in general, or 
to nvme specifically.

Dongli Zhang, could you please try hibernation with "nosmt" on the system 
where you originally saw the initial pending CQS warning? Are you by any 
chance seeing the issue as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs

