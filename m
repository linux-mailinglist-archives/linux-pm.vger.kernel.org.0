Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A932F2508
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhALApT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbhALApQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 19:45:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A3C061786
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 16:44:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a109so744121otc.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bI5isbHsIMG1DeC1iKJ9N4yCisPBZV9Gz2XLsNHbC2k=;
        b=mwRiQ0k3oRDBBm+/k4IoixgEDt7lVzrL9vj+XrAcjPAje6+iJqSyN/uzdnU8gh2L/G
         fNSARI+K1hwhOcRMCYCW+y2JJRldNJgn/XXkoDPp8mZqYc9vMxNmRdxDMEd9QhNpzN0b
         8Y8fnImvsHXN/L8kUTrXnQVYw4kx8PO+RZj/6jG/RFbeSPSa6VEPn08h6s83yA8G1hCA
         lfU3qtbCgtcEN8yGyJW7olfsaHSdVnKx3C8Gz1SHtNWsZZ4F4SuzVu3O4fkDp466Ab2Z
         ykXmx/CeaxEVAgCWue9htyItW8EMkTXscG0mULVJpwWUpESKWijTDuXfpguELSVEtA0B
         F8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bI5isbHsIMG1DeC1iKJ9N4yCisPBZV9Gz2XLsNHbC2k=;
        b=P0t+dY0FdFsj1RY2dv73dlthe0ivL3kUipMAGJo2pPUmryDf0CXBRM0Os4cccnCs/D
         arVnSblcXttBo19QnS/NxelludjbwZuh+9DjSmWqAArn10gp64GAThU+Bz2Dd95acLf/
         Azkb5xgCa4RjRpNZ/HDroQUrJ+czh9LOvl4uiUI8l5Xm1/L2YLI5QoADfpsu0vTQODSA
         pG5Pqz/6SAwAwfJ7AX99JLBcgpFqrEd6GTvvGU+wRBao+4Dh6phcoI/rCQ7xMmO5/Jsx
         T5pwaEbdOB8tbgJAlPhTEkhe7sDfjlUdMaNlIdU18DSDNo7UXk9RcJgDYJLRlFdYu9EC
         UeEQ==
X-Gm-Message-State: AOAM533GVBwmWXByO3sWn/FAW6qUYnYpRXCLOK2IIy7t6SmjhMglPFap
        ydG8apmRr5JOMCFXylOqc66JZg==
X-Google-Smtp-Source: ABdhPJxH59M61dNaafSElROY/MJR04BTorQ9DyF+MbdXoWzA+l2M4L5OIw6uCeRiryKJWBJtv7mkvA==
X-Received: by 2002:a9d:453:: with SMTP id 77mr1153492otc.91.1610412274718;
        Mon, 11 Jan 2021 16:44:34 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e17sm312549otf.32.2021.01.11.16.44.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 Jan 2021 16:44:34 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:44:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Saravana Kannan <saravanak@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
In-Reply-To: <CAGETcx-gPA3HeSKS6XW1zYj_imjDH_86897Jub56b9ctBOqmwg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2101111637330.2964@eggly.anvils>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <X/xV7ZV5jzI7RvAe@ulmo> <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com> <X/x49o3EtrUh6vuO@ulmo> <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com> <alpine.LSU.2.11.2101111539070.2728@eggly.anvils> <CAGETcx-gPA3HeSKS6XW1zYj_imjDH_86897Jub56b9ctBOqmwg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Jan 2021, Saravana Kannan wrote:
> On Mon, Jan 11, 2021 at 3:42 PM Hugh Dickins <hughd@google.com> wrote:
> > On Mon, 11 Jan 2021, Saravana Kannan wrote:
> > >
> > > I happen to have an X1 Carbon (different gen though) lying around and
> > > I poked at its /sys folders. None of the devices in the rmi4_smbus are
> > > considered the grandchildren of the i2c device. I think the real
> > > problem is rmi_register_transport_device() [1] not setting up the
> > > parent for any of the new devices it's adding.
> > >
> > > Hugh, can you try this patch?
> >
> > Just tried, but no, this patch does not help; but I bet
> > you're along the right lines, and something as simple will do it.
> 
> Did you see this patch change the organization of devices under /sys/devices/?
> The rmi* devices need to be under one of the i2c devices after this
> patch. Is that not the case? Or is that the case, but you are still
> seeing suspend/resume issues?

Now that I look, yes, that patch has moved the directory
/sys/devices/rmi4-00
to
/sys/devices/pci0000:00/0000:00:1f.4/i2c-6/6-002c/rmi4-00

But I still see the same suspend issues despite that.

Hugh
