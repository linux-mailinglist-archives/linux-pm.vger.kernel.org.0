Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF487CFFD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfGaV0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:26:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45840 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaV0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:26:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so6267662otq.12;
        Wed, 31 Jul 2019 14:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY7HXwIot63TGp2osyGwD6oiBom7P9dQMkdrdkS2Nes=;
        b=nDvTGpyX2+z65F3ZwfEFr5h/q+bSSzgg0YD/nn72NgZ8qaBdF5iCJckrxoMsoPYDgU
         tn31BVwMBJHYQkgHMOtDUbeqsfJUKPV5mMZYaf33r9i9kqJo6L1RnCyyJihbNVA5HlG5
         qbhexaqVf7bWcRrRh+ol5MrqGrWl9varNor5xEvXF2XX3LSI1awNADbYIfUP6niccvaD
         VCNbOqDKcFBq9ZQLXOcl6ztlNyBhPgCY1+T63CE8GXQjKm48BkmOnd3TlgUF9iQHvx0C
         WwgGJTxtEl7fJuARdL3EFzOZw/0tWvZRLMg76uV03JIUZT1CCmev7HqwmlHjiiWW0e2w
         +v5g==
X-Gm-Message-State: APjAAAWMJISIXtBpi+wMWoPut/ltRWA0S18KUMJaAqoqvCbveaWx8VAV
        tZpL/jX3sF8VzNwThd4y4HnoEZUMa09j5fpdjvk=
X-Google-Smtp-Source: APXvYqxVGX9+K7Xz5YfWvC/qL8u+R2fzXeqHac2HeS0SiwVZBa8gOPNuLZONFh1YvGWdr401W9asQoBJ7Yn/hXUPwSg=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr10015636oto.118.1564608365363;
 Wed, 31 Jul 2019 14:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <2332799.izEFUvJP67@kreacher> <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM> <20190730213114.GK13948@localhost.localdomain>
In-Reply-To: <20190730213114.GK13948@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Jul 2019 23:25:51 +0200
Message-ID: <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 11:33 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 09:05:22PM +0000, Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Keith Busch <kbusch@kernel.org>
> > > Sent: Tuesday, July 30, 2019 2:20 PM
> > > To: Kai-Heng Feng
> > > Cc: Limonciello, Mario; rjw@rjwysocki.net; keith.busch@intel.com; hch@lst.de;
> > > sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-pm@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; rajatja@google.com
> > > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > > suspend" has problems
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > On Wed, Jul 31, 2019 at 02:50:01AM +0800, Kai-Heng Feng wrote:
> > > >
> > > > Just did a quick test, this patch regress SK Hynix BC501, the SoC stays at
> > > > PC3 once the patch is applied.
> > >
> > > Okay, I'm afraid device/platform quirks may be required unless there are
> > > any other ideas out there.
> >
> > I think if a quirk goes in for Rafael's SSD it would have to be a quirk specific to this
> > device and FW version per the findings on KH checking the same device with the
> > older FW version.
>
> That's fine, we have the infrastructure in place for fw specific quirks.
> See drivers/nvme/host/core.c:nvme_core_quirk_entry

A couple of remarks if you will.

First, we don't know which case is the majority at this point.  For
now, there is one example of each, but it may very well turn out that
the SK Hynix BC501 above needs to be quirked.

Second, the reference here really is 5.2, so if there are any systems
that are not better off with 5.3-rc than they were with 5.2, well, we
have not made progress.  However, if there are systems that are worse
off with 5.3, that's bad.  In the face of the latest findings the only
way to avoid that is to be backwards compatible with 5.2 and that's
where my patch is going.  That cannot be achieved by quirking all
cases that are reported as "bad", because there still may be
unreported ones.
