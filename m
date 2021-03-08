Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C83331230
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHPaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 10:30:19 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:43548 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCHP3r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 10:29:47 -0500
Received: by mail-oo1-f48.google.com with SMTP id x19so2265174ooj.10
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 07:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b33vIw8FmSxzmMsw3ioiLCKyAdVHiIfPOiP82/VWC/8=;
        b=RsmB+6pYLf0vvKiN8dAdMqeVvZWGp4C+kD3WOY/oJ2l46F/VpAMdRX4twQo66WFOD5
         s5rfOb5LjoN4TEyWlpnBRr+zmPWZYloEF0tH5QE0gDxCCTZDCxOISSbCwIo5RM6A8uel
         Usasj/vmaNavT3WTRbJseZkavpO6gXDaGcHtAYGwykmiZUSzFjK8ZqFor8HFfVnCPCmK
         pWYwyfVDErh6YLI7FmKgqYRTMoBU0r7gXOCbwF8/CHGjCfEveT9kQmGcoX234i1sq9vJ
         +6IfG2suu+G/xuxadeL/XZ5pfERaCgEEzgDb274rpbo0kTCK83SQNExFH+VMAfVSX7Rb
         40Ww==
X-Gm-Message-State: AOAM532WTt+w3Xji8BPvlreVOWk60HCqKP9Li3c+0HTXfv/SoG5vnPkj
        mYqx5o2TMCalBtrHSqU974Jz79zYXDuad+SmfhU=
X-Google-Smtp-Source: ABdhPJzuuJzP4p2wbUlJcpCjQ8OfAz7K9ViTMSQ52E7JRPCigjcHNKyHYB9yHnFp9oZ+c5ExM0irIY4flwsDzTevLIo=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr19010936oop.1.1615217386854;
 Mon, 08 Mar 2021 07:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20210305080748.GA17954@lst.de> <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
 <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com> <20210308075048.GA983@lst.de>
In-Reply-To: <20210308075048.GA983@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 16:29:31 +0100
Message-ID: <CAJZ5v0hRef89EyU8nvbU0UXYHcd7gjk1e4BLDYCzKH7WSNBsWw@mail.gmail.com>
Subject: Re: driver notification when switching between battery vs AC power?
To:     Christoph Hellwig <hch@lst.de>, Sebastian Reichel <sre@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Mar 07, 2021 at 09:53:06PM +0800, Zhang Rui wrote:
> > Thanks for adding me in the loop.
> >
> > Yes, an ACPI notifier callback should be sufficient for this purpose.
> >
> > Usually, we get an ACPI notification upon AC plug/unplug, so what we
> > need in the NVMe driver is to get the notification and then get the
> > status of AC adapter. As ACPI AC driver always sends the AC events to
> > acpi notifier chain, what we need is
> > a) define a notifier callback, and in the notifier callback
> >    1. ignore non-AC devices,
> >    2. get AC status, you can refer to acpi_ac_get_state()
> > b) register the notifier cb to ACPI notifier chain, by invoking
> >    register_acpi_notifier()
>
> Not my direct priority now, but would there be any objections to
> wire up a power_source_notifier method in struct dev_pm_ops to
> avoid boilerplate code and ACPI dependencies in drivers?

That would work for me, unless there is something more generic than
the ACPI-based notification mechanism already in the power supply
framework.  Sebastian?
