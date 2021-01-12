Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6332F262C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbhALCRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 21:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbhALCRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 21:17:54 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F86C061786
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 18:17:13 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id r63so745649ybf.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujbfpSeu9ErQ/pUTWFlws8N4jsyVnjyJCXYrvwVYCCo=;
        b=JvkqNlpt6m0qIVjHw0czJhS++ZK7b4BRGcwBHDvGUCt+HM8a4A0I5ZcGcGdcI5iDtu
         x20OZBkv+ith8aVnzrFcPsPlJBUIjV7BGFxwB8yFfm5FWAqtr2HVWymHWhQv1zkMCeNY
         BiYU0v9vLUMb+Zja/IlcUnCUSwTzzqafy3M9GlrwXaGfqwBuIynIk45k2G5oHRQ9ET7W
         ZZCCtKHIfZYld7g94t0f/Ld2tkfWJvgmhDD9KNb0o9a1BTlp4W91kBAmK4njIQAMopB1
         ONHpE37XGidfsZ2Y8W06zFhYiP3kTcoKDEdDu0NFm4v3F/GO4BhT0H4cIt9mY1YJD+Ls
         Ww3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujbfpSeu9ErQ/pUTWFlws8N4jsyVnjyJCXYrvwVYCCo=;
        b=jZGAgNqnNuhTjTK7+Xv89kE0wB4JFfD3e7cKDhm7L7c35TadRNmwfi9NB1vLSpWNH4
         b9Ri6NTXTKtMm76VAIar0RBKh25sRYCiyIQo81pZIg8xkvx6GEX/NMp0HFCQTGNzmYg3
         x0aoMYEj/GLgWIMWisInIo95OUcROObCKmWLkBnxi8ggH9ic5gN/ypfp9JHmnwLjS5Dx
         IQGKIqLWL36vhsg9b4bf4znYNwGDAFzZ44ebQtR7T8lBvjsuzrj1VdIoNsUfi/4N5OYO
         zfFSCYncmikz5fWL2+REPxM1v0m4U/2khw/085+tOwVSBvOTkCV/Lkwi8AWNWPk2DeV2
         Ldig==
X-Gm-Message-State: AOAM5338HRNPYC7bU6rrfDZGo/1FYU/vQwojJaCu6rVCgppF8I5DoFs+
        XWn/LUSmcR6DtMv9wiJ7zuTm9IVKoMarTTMLDfbsuA==
X-Google-Smtp-Source: ABdhPJyJyT7aeDxo+KqSJ8e6wPGnmoMaQcDT686Uj+jeZdRtmbS1QU4/iktgAnxjbp7y0NxDVGYwhlZpm7InkSgzIu8=
X-Received: by 2002:a25:b703:: with SMTP id t3mr4207762ybj.96.1610417832969;
 Mon, 11 Jan 2021 18:17:12 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo> <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
 <X/x49o3EtrUh6vuO@ulmo> <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com>
 <alpine.LSU.2.11.2101111539070.2728@eggly.anvils> <CAGETcx-gPA3HeSKS6XW1zYj_imjDH_86897Jub56b9ctBOqmwg@mail.gmail.com>
 <alpine.LSU.2.11.2101111637330.2964@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101111637330.2964@eggly.anvils>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 11 Jan 2021 18:16:37 -0800
Message-ID: <CAGETcx8mNW=skm-2W6tS20wG1BxJW6ROMqDaktN5udKTeZtNrQ@mail.gmail.com>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
To:     Hugh Dickins <hughd@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 4:44 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 11 Jan 2021, Saravana Kannan wrote:
> > On Mon, Jan 11, 2021 at 3:42 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Mon, 11 Jan 2021, Saravana Kannan wrote:
> > > >
> > > > I happen to have an X1 Carbon (different gen though) lying around and
> > > > I poked at its /sys folders. None of the devices in the rmi4_smbus are
> > > > considered the grandchildren of the i2c device. I think the real
> > > > problem is rmi_register_transport_device() [1] not setting up the
> > > > parent for any of the new devices it's adding.
> > > >
> > > > Hugh, can you try this patch?
> > >
> > > Just tried, but no, this patch does not help; but I bet
> > > you're along the right lines, and something as simple will do it.
> >
> > Did you see this patch change the organization of devices under /sys/devices/?
> > The rmi* devices need to be under one of the i2c devices after this
> > patch. Is that not the case? Or is that the case, but you are still
> > seeing suspend/resume issues?
>
> Now that I look, yes, that patch has moved the directory
> /sys/devices/rmi4-00
> to
> /sys/devices/pci0000:00/0000:00:1f.4/i2c-6/6-002c/rmi4-00

What about child devices of rmi4-00? Does it still have the
rmi4-00.fn* devices as children? I'd think so, but just double
checking.

>
> But I still see the same suspend issues despite that.

Can you please get new logs to see if the failure reasons are still
the same? I'd think this parent/child relationship would at least
avoid the "Failed to read irqs" errors that seem to be due to I2C
dependency.

-Saravana
