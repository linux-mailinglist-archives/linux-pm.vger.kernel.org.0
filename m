Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB91F22ED87
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG0NiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 09:38:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42994 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0NiO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 09:38:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id v21so5038867otj.9;
        Mon, 27 Jul 2020 06:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDgvxbFtjoqaUGPEDtkInSIpJVJqkW3IcV+Wtsu5ITc=;
        b=jhprwpJIoQNfyotKw7z1LMzWKpQo7AV2X/QKY3t2H76Hwhu7eN/1HnzYjb2qh0HDI4
         CplFkvXn/D3yoviIItBgSxzuAmpst3iBWRHn6zp0WsOVFbvBnXCkpvt4oqP5Vb8LqFnl
         NQSkw33fARMF841U/77bLsva5Yom0l/k01jZPZPyPQ/T11Cn5s05mYcuoB2faXzUDyPd
         eIMLFblkpv2PWkmoMarPoJrGoj/Md1oAtrMCx5lxktzoG3wMItCwW4TkFQ7FKdk4wWPI
         ijV0lWpKg/wzFSCWjj9DPla0Y5ypTH1dbwxubJUYASwrTNHFQbmAwePk9PmOeGvhZfok
         lmAA==
X-Gm-Message-State: AOAM5329GVgf1plMyji0Aph1G7BKFPeOmoxxUSeevX50toVbMWXTXEm5
        Ms5rvLHWvDFB3XCPmzl4w8xXD6iqxbdsSIie1Ys=
X-Google-Smtp-Source: ABdhPJy3txxI99b+fWzbhQVo+HWM4RYjrP2BIU1Ci2RDTj9GPs21eK4gnxtDjDTfKgLqwvw2gVDmbZ5VIuYYJXomKTc=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr2285084otj.118.1595857093698;
 Mon, 27 Jul 2020 06:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200707172845.4177903-1-abhishekpandit@chromium.org>
 <20200707102823.v5.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid> <20200723183235.GA3445384@kroah.com>
In-Reply-To: <20200723183235.GA3445384@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:38:02 +0200
Message-ID: <CAJZ5v0jXcfO3YiMgkc7u=qqZy+jyT=RGagF3yAFnAhiJfyfcuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 23, 2020 at 8:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 07, 2020 at 10:28:44AM -0700, Abhishek Pandit-Subedi wrote:
> > Udev rules that depend on the power/wakeup attribute don't get triggered
> > correctly if device_set_wakeup_capable is called after the device is
> > created. This can happen for several reasons (driver sets wakeup after
> > device is created, wakeup is changed on parent device, etc) and it seems
> > reasonable to emit a changed event when adding or removing attributes on
> > the device.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Rafael, any objection to this?  Do you want me to take it through my
> tree, or are you going to take it through yours?  Either is fine for me.

It's already there in my tree with the R-by tag from you.

Cheers!
