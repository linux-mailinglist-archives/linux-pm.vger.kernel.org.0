Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB684A25
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfHGKyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 06:54:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35229 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGKyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 06:54:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so25805474otq.2;
        Wed, 07 Aug 2019 03:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxw3EVVU0xzOlP4s3CysSd2AtPlOWNcCQsYcbdOHfjQ=;
        b=ONPWXEs6oWT+qMb/aZz3x0zLLalgu+Dj43A4gSwBLKuKKAmmKrjzuUzhiDC84HxTUj
         frmYLhr1se+sQjwzaMyJSGpZmITST+xTd5QvfexUa+PNwuUAti+ZJygNL4VZXUUqJ1JB
         uYd+RYcv0OWsfGIuTcVeWP3Sm1aLUya8noPQ1H4vAETowzi7hfIaCY7Z012eYRw7wqZy
         CHOYT6e7Fv4MXd5wHoyvE5+TuiGfjcF6xF18dAGnwIgwy3XXk+FiXJ3teI3OAnE3LZ8h
         DeHs+NNtDZhVrfgW5ctf4gLOoi9nRQycQs/wrqQmXFM/ZFKn+G3NNd4EhqayVVOJxuJ0
         C/Rg==
X-Gm-Message-State: APjAAAVhsOOxFtnzEiWhzjSPdEuwfzqNdCcB0fd0DwqvqFtaZ9gmqqXP
        ecafg9qTGo6zIkbmrEejXzVjQzAXHAZ+ulV7uPM=
X-Google-Smtp-Source: APXvYqxDuPzwIiSna5umdxZjXPi87WcSCTODOBv6ItZIqSnL3x2U+otA38McqxhlujmUrNjhLhaVyLy2i5tERoxxacU=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr6970595otp.189.1565175259873;
 Wed, 07 Aug 2019 03:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <2763495.NmdaWeg79L@kreacher> <20190807104500.GB11356@lst.de>
In-Reply-To: <20190807104500.GB11356@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Aug 2019 12:54:08 +0200
Message-ID: <CAJZ5v0hsLqugkep9JTzUpErUoBdFbEqmHEXqSzdfPk8D1ZvHdg@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
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

On Wed, Aug 7, 2019 at 12:45 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 07, 2019 at 11:48:33AM +0200, Rafael J. Wysocki wrote:
> > So I think I know what the problem is here.
> >
> > If ASPM is disabled for the NVMe device (which is the case on my machine by default),
> > skipping the bus-level PM in nvme_suspend() causes the PCIe link of it to stay up and
> > that prevents the SoC from getting into deeper package C-states.
> >
> > If I change the ASPM policy to "powersave" (through the module parameter in there),
> > ASPM gets enabled for the NVMe drive and I can get into PC10 via S2Idle with plain 5.3-rc3.
> >
> > However, that's a bit less than straightforward, so I'm going to post a patch to make
> > nvme_suspend() fall back to the "old ways" if ASPM is not enabled for the target device.
>
> Sounds sensibel.
>
> FYI your mail is not properly formatted and has way too long lines.

Sorry about that.
