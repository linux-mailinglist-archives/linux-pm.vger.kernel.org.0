Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335042C56EF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgKZOTm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 26 Nov 2020 09:19:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45131 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390022AbgKZOTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 09:19:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id k3so1967449otp.12;
        Thu, 26 Nov 2020 06:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GwppLtz9RbhQVBUuzUzdKLtehGW1M1Jg+Up1fL9r49Q=;
        b=JGjbv1SvOWoSeGXIbMYRwBmgytqlFk9VSQw0tlrdNVV0/M1DiRVU+RYKNPu6eGJu22
         aZPdYohR/E//CoG4j9C+BGnbW3R9YUdm8AQ+P53CtpYcpJezCX/EaQsusYs3p3jF4i2B
         U1GzOzCeMdcNJASv7VMAQSOunQ6902vpWPWf6bIyPn1iBTp+97EhaRJ9T0E5QooLG9nk
         m5FZFBm3sOz7EPqeTSIPhrJNVGtliqVRx1eEll3hK1idPR/IbGBb8AqlGRNUzW7PchuY
         AJoUg1puFL21OrIopVBriaIeySEzlzw3fyHWnVulTkJajP+dSJDg0j6MjFQ+hBq7aPo2
         j55Q==
X-Gm-Message-State: AOAM530F7+ADQFwtSacRhFDQwNd9ognybu21c2Jtm9VgHP4Q55i4F2MZ
        DhQv8AoOR5FZlmF2dnqD0N36AY+rMTNmCse5qLw=
X-Google-Smtp-Source: ABdhPJwLAfZXbySWLnLQSnt2tfdU5vqWZ9ViHjQ+x1Q62Sndi1ZEA9cNzW/jMhgVXe9oHodj5ptyp6Qe2dKWheYazSI=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr2425799ots.321.1606400379939;
 Thu, 26 Nov 2020 06:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124060202.776-1-ricky_wu@realtek.com> <20201124204915.GA585306@bjorn-Precision-5520>
 <CAJZ5v0gt4aeC5S6RY2W98vmcMSs9gb_SBA8-eoq1NU3wPptL8g@mail.gmail.com> <6f721ea4d5a84f45b0249b932d742367@realtek.com>
In-Reply-To: <6f721ea4d5a84f45b0249b932d742367@realtek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 15:19:26 +0100
Message-ID: <CAJZ5v0ggtd3+YEo2nERhuTeurRx5OQrvLkAz3aEMPRmEfo_Rnw@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: rts5249 support runtime PM
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        Doug Anderson <dianders@chromium.org>,
        "rmfrfs@gmail.com" <rmfrfs@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 4:07 AM 吳昊澄 Ricky <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rafael@kernel.org]
> > Sent: Wednesday, November 25, 2020 10:04 PM
> > To: Bjorn Helgaas; 吳昊澄 Ricky

[cut]

> > > > +static void rtsx_pci_rtd3_work(struct work_struct *work)
> > > > +{
> > > > +     struct delayed_work *dwork = to_delayed_work(work);
> > > > +     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr,
> > rtd3_work);
> > > > +
> > > > +     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > +
> > > > +     while (pcr->pci->dev.power.usage_count.counter > 0) {
> > > > +             if (pm_runtime_active(&(pcr->pci->dev)))
> > > > +                     pm_runtime_put(&(pcr->pci->dev));
> > >
> > > I'm not a runtime PM expert, but this looks fishy.  AFAICT this is the
> > > only driver in the tree that uses usage_count.counter this way, which
> > > is a pretty big hint that this needs a closer look.  Cc'd Rafael.
> >
> > You are right, this is not correct from the PM-runtime POV.
> >
> > It looks like this attempts to force the PM-runtime usage counter down
> > to 0 and it's kind of hard to say why this is done (and it shouldn't
> > be done in the first place, because it destroys the usage counter
> > balance).
> >
> > Ricky, is this an attempt to work around an issue of some sort?
> >
>
> Thanks Bjorn and Rafael
> I found when we boot up, our dev pcr->pci->dev.power.usage_count.counter always is 2,
> Don’t know how to make it to 0 because we need to support D3 and run runtime_suspended callback function
> Is there something wrong with us to enable runtime PM?

That is possible.

If you want it to be enabled by default, you need to call
pm_runtime_allow() from the driver at probe time, in addition to
pm_runtime_enable(), in the first place, but that only drops one
reference, so question is where the other one comes from.

Are the pm_runtime_get*() and pm_runtime_put*() calls balanced?
