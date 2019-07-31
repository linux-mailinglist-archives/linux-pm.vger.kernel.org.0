Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3426F7D135
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGaWde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 18:33:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41006 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaWde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 18:33:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so52028763oia.8;
        Wed, 31 Jul 2019 15:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaXwfXqQ6zKWmX/DQNzZhY9vhSL25uLPNg24lm+Z3A8=;
        b=qqP7ZFZtQ6JT3+hg8eNhjVot7m2hsHFL3UZ/+bnuky4q/W6XmrH7Qjty/NOLBCjEsf
         G0FT3CfVc49impsdoBb7pyG5KdiuU/8/VbXYf1q/GRw+1g61wzIrngXiS0cUdBxVqPy3
         mIARvZG65jB4a1P00lnUxgGI3A86ODkmrl/MfFfd34FdNQH56ShowCSHUnBGUOWNdirQ
         Qyt7XKvqyPrlWmwHRTDPRvG3lDC1FBLQ/VjLV4ZzA7dByvRrN1DDb9miOJHqxQtxQDcM
         G53++U4k0/DLCxZ1ULVlxi6QSva5kbkYq1lK+4Hr9tEKKNyYbRBcsXVmtVgQ8HxauX8l
         4pcQ==
X-Gm-Message-State: APjAAAU8Q+RYSfJkG/LSlSMbJGpzPoXiKStyrtiHL/eo2Nqy7kGwAXo8
        X5ljywLlEq9U7WmKSdYhDynU3RXTQoChRGGZISo=
X-Google-Smtp-Source: APXvYqy8K7rZdrHVIEm+dsJBeW1kcKphsprmEu9CobF2YPMA7ZXivzELY8vw8GCI9RouGZeDmDxamMQKdzwozZVARMY=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr60704040oib.110.1564612412985;
 Wed, 31 Jul 2019 15:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 00:33:20 +0200
Message-ID: <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
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

On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> >
> > A couple of remarks if you will.
> >
> > First, we don't know which case is the majority at this point.  For
> > now, there is one example of each, but it may very well turn out that
> > the SK Hynix BC501 above needs to be quirked.
> >
> > Second, the reference here really is 5.2, so if there are any systems
> > that are not better off with 5.3-rc than they were with 5.2, well, we
> > have not made progress.  However, if there are systems that are worse
> > off with 5.3, that's bad.  In the face of the latest findings the only
> > way to avoid that is to be backwards compatible with 5.2 and that's
> > where my patch is going.  That cannot be achieved by quirking all
> > cases that are reported as "bad", because there still may be
> > unreported ones.
>
> I have to agree. I think your proposal may allow PCI D3cold,

Yes, it may.

> In which case we do need to reintroduce the HMB handling.

Right.
