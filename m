Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A590D6EA3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfJOFbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 01:31:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46165 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfJOFbp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 01:31:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so18049985qkd.13
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkUYIQrFeSBLqGy7kb2UjD77Gr4MwhmK+uQo8Mo0ues=;
        b=yPaPz3tDiXMJAuc62IkcJj45LMcrS3vEGqAW+2DDcsgJJC4MHcvR1tBbyPLz7qBcjg
         njB4MMXQc3ZN534oNTmQHlSh6WIALRzXgBFm5cHD6dBf7zBclo8TeC1ve8PPCYb+sOgO
         wDljU0/J3KkkDuNSClJ98h330hS5MrmWfFbU5XyqES3/qKqQJ6e2Q//Czmubwv0kGLHO
         2f6xvpl9dKjLdkEn6whAt3Y/6G+xUZuYOytW/zKYa0doUCq/nHdSiLEILqzEIFA2Xwd5
         735IuyTkHmY/rdd7qI6EMgG+j0eIAmnKgk/JDKWTq1M/zT/dr4nx/Hr8y1HbnbZLmKDN
         WLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkUYIQrFeSBLqGy7kb2UjD77Gr4MwhmK+uQo8Mo0ues=;
        b=uRH/hrAjRnaLO700Co+U0v4AcvICADNmLm922vLNsRP4WBtJtBQFP2VS1T98w9QEsN
         kntPK1yfJKcBN1hjAo9oJa85E9iZYMTauczgACNnsYOPx5WNzidp319lIinBoqkLK6o2
         Dojgg48Za8Cm0YduqVegt93SnvG+7qJglBfNtpyhDTudZa4A5CTUSVsl6oqyDg5b/X+o
         a2TDPh5RrmQiQw2LlzGxxEoE2hpI5k0rO20xK3xHdIimurIxiQw1TxqtwIlxPYABld+F
         wpDovgd+iwgxcEwX9uu31CLoZnE3/d+vFvzRMkOUMDw8JzJpleyi3x8xv94eq/57vkFj
         8auQ==
X-Gm-Message-State: APjAAAUY+EDMxWwxQFWoXvJPW1XaxAACEOSE7cpDfrtfSx4NGw0nifUR
        EGKC0TanQrrqz0YBhSnnAtApJa934Zq2F/TOkAMC8w==
X-Google-Smtp-Source: APXvYqy4Ya1IWH8Dz6OGUC7y+6+/tUFfNPOGmG8eoZzpNUDarvOmGOQAWPLa7A8qtUHaiqnI47PjCgA4sUWu5TI/p+s=
X-Received: by 2002:a37:c41:: with SMTP id 62mr32266901qkm.445.1571117504037;
 Mon, 14 Oct 2019 22:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061355.29072-1-drake@endlessm.com> <20191014154322.GA190693@google.com>
In-Reply-To: <20191014154322.GA190693@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 15 Oct 2019 13:31:32 +0800
Message-ID: <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 14, 2019 at 11:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Can you tell if this is because the Ryzen7 XHCI controller is out of
> spec, or is the Linux PCI core missing some delay?  If the latter,
> fixing the core might fix other devices as well.
>
> Mika has this patch:
> https://lore.kernel.org/r/20190821124519.71594-1-mika.westerberg@linux.intel.com
> for similar issues, but I think that patch fixes D3cold->D0
> transitions, and your patch appears to be concerned with D3hot->D0
> transitions.

It's actually coming out of D3cold here, however what happens right
before this is that __pci_start_power_transition() calls
pci_platform_power_transition(D0) to leave D3cold state, then
pci_update_current_state() reads PMCSR and updates dev->current_state
to D3hot.

The 20ms delay for these XHCI controllers is needed precisely at this
point - after writing PMCSR to move to D0, and before reading it back
to check the result.
I tried moving the delay immediately before writing PMCSR, but that
doesn't work. Based on that, it seems like it's just a little out of
spec.

With Mika's patch, pcie_wait_downstream_accessible() is called for
these devices after the state transition has already failed. It also
doesn't do any delaying at that point because pci_pcie_type(pdev) ==
0.

Daniel
