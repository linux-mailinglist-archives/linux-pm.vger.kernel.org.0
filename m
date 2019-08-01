Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8B7E118
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfHAR3t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 1 Aug 2019 13:29:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41431 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfHAR3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 13:29:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so54587743oia.8;
        Thu, 01 Aug 2019 10:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FlAECG5/+5coEo/CjVaCFJOXDP9zeTSn6ojRsQSIqyU=;
        b=LFQL8tK0sf4EtmKUUDRbUGxRZEWXQh3hBLebBAF0aYxc91w6Gdbr/CvEdh8wvNbVbm
         AGA12sVy0cTEGth3haDkqjVosQKP8MkAyKStYaScEWHZFQ9W15WmOSEVpAGMo/1KXU4T
         js6yyts7eg5sXUovIBPJLf7+fFPLmxRF4T7yoXiWl4yUbwkwGQ6gFjForcnGn04aRhCT
         D0B0PLILd3pUI8Fs9IaDsLw/uGn9MSDU8VqeNDX+kVbfd5O7saWFF8BcceKXsoaN4sD0
         qIubqehbBqecr30xy7AQGnmQ8UWkRmjuQpvg41nCo/EfDCjomO9HkPA4lLwwoZebudfm
         +DLw==
X-Gm-Message-State: APjAAAU0P7xEs1rssgcAev6ts/uJXMy1aXlC7UxbY3PGapp2p2P3SgDP
        XrHEHM/yGRRRe3W3f/U9lKhWCzb2WH+FaGg+3JA=
X-Google-Smtp-Source: APXvYqxaH+sKeRvD+5hyEnyw5rpGmJLEjgUdeKjhvkwhBRYJxDnCZTNH67B7lhnbIPRo89CHiLMxfxZNitO0U7ZpdIg=
X-Received: by 2002:aca:d907:: with SMTP id q7mr62673623oig.68.1564680587738;
 Thu, 01 Aug 2019 10:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
In-Reply-To: <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 19:29:36 +0200
Message-ID: <CAJZ5v0hFYEv_+vFkrxaCn_pNAbyqmO_cLb5GOLNn_xxRRwjh2g@mail.gmail.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Keith Busch <keith.busch@intel.com>,
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

On Thu, Aug 1, 2019 at 11:06 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org> wrote:
> >> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> >>> A couple of remarks if you will.
> >>>
> >>> First, we don't know which case is the majority at this point.  For
> >>> now, there is one example of each, but it may very well turn out that
> >>> the SK Hynix BC501 above needs to be quirked.
> >>>
> >>> Second, the reference here really is 5.2, so if there are any systems
> >>> that are not better off with 5.3-rc than they were with 5.2, well, we
> >>> have not made progress.  However, if there are systems that are worse
> >>> off with 5.3, that's bad.  In the face of the latest findings the only
> >>> way to avoid that is to be backwards compatible with 5.2 and that's
> >>> where my patch is going.  That cannot be achieved by quirking all
> >>> cases that are reported as "bad", because there still may be
> >>> unreported ones.
> >>
> >> I have to agree. I think your proposal may allow PCI D3cold,
> >
> > Yes, it may.
>
> Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or without
> Rafael’s patch.
> But the “real” s2idle power consumption does improve with the patch.

Do you mean this patch:

https://lore.kernel.org/linux-pm/70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com/T/#m456aa5c69973a3b68f2cdd4713a1ce83be51458f

or the $subject one without the above?

> Can we use a DMI based quirk for this platform? It seems like a platform
> specific issue.

We seem to see too many "platform-specific issues" here. :-)

To me, the status quo (ie. what we have in 5.3-rc2) is not defensible.
Something needs to be done to improve the situation.

> >
> >> In which case we do need to reintroduce the HMB handling.
> >
> > Right.
>
> The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think it’s
> still safer to do proper HMB handling.

Well, so can anyone please propose something specific?  Like an
alternative patch?
