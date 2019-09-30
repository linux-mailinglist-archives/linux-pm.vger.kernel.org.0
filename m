Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83900C1DC0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfI3JQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 05:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbfI3JQB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 05:16:01 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C74985362
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 09:16:00 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id f5so28909224iob.17
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 02:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYALegoGq2x0f4Xpam8g4n/KmRTLzFLFdMWS2x+BRTo=;
        b=mlvT8AoywQZlPWOVMRP0uSnrhQAF2Z7RR6+cIbR0+fFrz0w10SBSQdE8PY7LFnWDcC
         hGSjHtlpLf+qAzojKRxyOutqYMM2vzEreW+1YZ0SVM+k5JFXuRQ9clYs85Zr2/fFeNO5
         wCp+AXMMqVbXq3uf6Ot2kZrbaQftoG237z5ogwAyLdBhGBwuB99V7LbM8bOjJmd5xuqu
         1JZQzHlwwdEGtGTC5jYSMf+L2bDAS/0qqKy56XSbzymg1l8Aiu6IS3UVUjdeYIJVWEDO
         2qRKbVaqSU1p6e2NbQBy37eNp3XSNR2y3qFSdlS+1tdj3512PHUUwcg/Qsf0ey0r5wXk
         O+HA==
X-Gm-Message-State: APjAAAWmX8qNtRauf4sYrLDNk7CZq3Nlkoe0LIBv/n5lAxxWmmbF8N4Y
        /LWQknyJx4EGtFL9fMBNsadfYb4CiWjWLbouNabRMR+8ZztrMluSYzCbyYeQbCyBRauSB6R/gQ1
        RyDd+WEIz+tn0tJ48XTeJGp2AOE+WzJHX+A4=
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr19109717ilb.178.1569834960040;
        Mon, 30 Sep 2019 02:16:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPkXeGqth758z+hZfIc2R8kD4VkXAa/WTJi6BfLuef+qvcqGexqJEgTITxFa30xLqGIhrpPCs116BcIvdOFKY=
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr19109703ilb.178.1569834959772;
 Mon, 30 Sep 2019 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com> <20190930080534.GS2714@lahna.fi.intel.com>
In-Reply-To: <20190930080534.GS2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 30 Sep 2019 11:15:48 +0200
Message-ID: <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 30, 2019 at 10:05 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Karol,
>
> On Fri, Sep 27, 2019 at 11:53:48PM +0200, Karol Herbst wrote:
> > > What exactly is the serious issue?  I guess it's that the rescan
> > > doesn't detect the GPU, which means it's not responding to config
> > > accesses?  Is there any timing component here, e.g., maybe we're
> > > missing some delay like the ones Mika is adding to the reset paths?
> >
> > When I was checking up on some of the PCI registers of the bridge
> > controller, the slot detection told me that there is no device
> > recognized anymore. I don't know which register it was anymore, though
> > I guess one could read it up in the SoC spec document by Intel.
> >
> > My guess is, that the bridge controller fails to detect the GPU being
> > here or actively threw it of the bus or something. But a normal system
> > suspend/resume cycle brings the GPU back online (doing a rescan via
> > sysfs gets the device detected again)
>
> Can you elaborate a bit what kind of scenario the issue happens (e.g
> steps how it reproduces)? It was not 100% clear from the changelog. Also
> what the result when the failure happens?
>

yeah, I already have an updated patch in the works which also does the
rework Bjorn suggested. Had no time yet to test if I didn't mess it
up.

I am also thinking of adding a kernel parameter to enable this
workaround on demand, but not quite sure on that one yet.

> I see there is a script that does something but unfortunately I'm not
> fluent in Python so can't extract the steps how the issue can be
> reproduced ;-)
>
> One thing that I'm working on is that Linux PCI subsystem misses certain
> delays that are needed after D3cold -> D0 transition, otherwise the
> device and/or link may not be ready before we access it. What you are
> experiencing sounds similar. I wonder if you could try the following
> patch and see if it makes any difference?
>
> https://patchwork.kernel.org/patch/11106611/

I think I already tried this path. The problem isn't that the device
isn't accessible too late, but that it seems that the device
completely falls off the bus. But I can retest again just to be sure.
