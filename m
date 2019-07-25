Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885457550A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfGYREB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 25 Jul 2019 13:04:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34822 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYREB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 13:04:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so13930055otq.2;
        Thu, 25 Jul 2019 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8G44gacPmRhlcyhu/6GsJIvVHd40YjenVn8zxXxswWA=;
        b=QhyhihXv1Z6618u6WrfSQOsJUEj4xGAumxOXRlowwIxbGkbrB0xlgI8xjcHk2tfIfZ
         0sGaQayYy5ZNrZqO/xuNTYWUWHPwNoZ+JTeh0vZetVk3nqvD8uDtFyxfdizRany0RNli
         S2Bw3WJy+KuYiVMVLeBOi0ETsnpZ2o4D7r9Q50MeiSNCKVyOa9Oux5M/IwQKo9uzrCGF
         sF3GOOoRPu3Ovni32v2cJ3+vrJfgbZ5m+tKpAvekTcAxb0ZEkAlZ1wIeRah/TtnIkUm8
         pergCe4dbNAW2+wPkBijaKqHKXgvTCRlh/Pq1GFjrfsFo6DzBJLKo5EcNVcvhqNUWXH0
         E1CA==
X-Gm-Message-State: APjAAAXLoVfhpMb+18SVF8Xj/e5pHu8YR6JIlwyj/2IVABD7G7MOzeup
        GuVEo0u1UtMPUrzp+3t8Aiu60h2jGzZs6iWJqco=
X-Google-Smtp-Source: APXvYqwDu0+fLy73J2/Flv6Watu3GrPu0mjMjW7YrikgMdZCMbyar08W0Nzg9Q45z6Y+GkpP0x1DenMgNvH1tT0T2QU=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr67539409otq.262.1564074240786;
 Thu, 25 Jul 2019 10:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <2332799.izEFUvJP67@kreacher> <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 19:03:49 +0200
Message-ID: <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 25, 2019 at 6:24 PM <Mario.Limonciello@dell.com> wrote:
>
> +Rajat
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Thursday, July 25, 2019 9:03 AM
> > To: Rafael J. Wysocki
> > Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme@lists.infradead.org; Limonciello, Mario; Linux PM; LKML
> > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > suspend" has problems
> >
> >
> > [EXTERNAL EMAIL]
> >
> > Hi Rafael,
> >
> > at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > > Hi Keith,
> > >
> > > Unfortunately,
> > >
> > > commit d916b1be94b6dc8d293abed2451f3062f6af7551
> > > Author: Keith Busch <keith.busch@intel.com>
> > > Date:   Thu May 23 09:27:35 2019 -0600
> > >
> > >     nvme-pci: use host managed power state for suspend
> > >
> > > doesn't universally improve things.  In fact, in some cases it makes
> > > things worse.
> > >
> > > For example, on the Dell XPS13 9380 I have here it prevents the processor
> > > package
> > > from reaching idle states deeper than PC2 in suspend-to-idle (which, of
> > > course, also
> > > prevents the SoC from reaching any kind of S0ix).
> > >
> > > That can be readily explained too.  Namely, with the commit above the
> > > NVMe device
> > > stays in D0 over suspend/resume, so the root port it is connected to also
> > > has to stay in
> > > D0 and that "blocks" package C-states deeper than PC2.
> > >
> > > In order for the root port to be able to go to D3, the device connected
> > > to it also needs
> > > to go into D3, so it looks like (at least on this particular machine, but
> > > maybe in
> > > general), both D3 and the NVMe-specific PM are needed.
>
> Well this is really unfortunate to hear.  I recall that with some disks we were
> seeing problems where NVME specific PM wasn't working when the disk was in D3.
>
> On your specific disk, it would be good to know if just removing the pci_save_state(pdev)
> call helps.

Yes, it does help.

> If so, :
> * that might be a better option to add as a parameter.
> * maybe we should double check all the disks one more time with that tweak.

At this point it seems so.

> > > I'm not sure what to do here, because evidently there are systems where
> > > that commit
> > > helps.  I was thinking about adding a module option allowing the user to
> > > override the
> > > default behavior which in turn should be compatible with 5.2 and earlier
> > > kernels.
> >
> > I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W
> > power consumption so at least I don’t see the issue on XPS 9370.
> >
>
> To me that confirms NVME is down, but it still seems higher than I would have
> expected.  We should be more typically in the order of ~0.3W I think.

It may go to PC10, but not reach S0ix.

Anyway, I run the s2idle tests under turbostat which then tells me
what has happened more precisely.
