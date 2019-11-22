Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCF107257
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 13:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKVMpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 07:45:21 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36389 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKVMpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 07:45:21 -0500
Received: by mail-oi1-f175.google.com with SMTP id j7so6387488oib.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 04:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6D3qbowcLqgqfuxBXnJWiB2jEEAUP/PftFC1bKDTvTY=;
        b=jXwumvfvtin5i6lKac8Y+8hRcHKeq89QtsIc20qVjujM/ap4QdgrYRCjUfi3XL6GtM
         UJQWU955gOn2IDTpluYt742WSbiM6tlpjzVkvQU0HUG2KZVxrHoSsTQfnlZtB1+b4jHz
         uawC3EdAdpjA6wNsPM0zrflBOLBzWK1ZeubTyZWhie6j4AKIk++TcHAoqCONRkQCMMOs
         2ZNQfwt7EVBz/vUtI44W6ASDdPQcymWIDrVd2vi7tV8wuzl0/QKAiPbH82FQLBA+uppu
         fJ8Ok08Xkc0jvJfolPoISl8iZ+eDBwinq2CDFLjqPxRMSlZkkXVYMfXOUDHaW9xqHPmd
         IQVg==
X-Gm-Message-State: APjAAAW7LjKKOqqsfUBnshMhjJHvX+jyFRa9U5NQeCJoAbqUQmXHSHrD
        3Q7/EXpqkTElB0PC1s9Bc/HfVUo+WsVkkSI6wH0=
X-Google-Smtp-Source: APXvYqzFOMPbBykIODBvKpqm97UUOSCYnD/1fcyu4jwBT4w2SApMObDHX1suAUF3GPwlQagX3tXtjmgjZpuTLgGbsf0=
X-Received: by 2002:aca:1101:: with SMTP id 1mr12339998oir.103.1574426720480;
 Fri, 22 Nov 2019 04:45:20 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 13:45:09 +0100
Message-ID: <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 22, 2019 at 1:28 AM Kenneth R. Crudup <kenny@panix.com> wrote:
> >
> >
> > I've been running Linus' tip for a while, mostly to get the PM improvements
> > on s2idle (I hate this mode so much- I'm tired of taking a warm laptop out
> > of my bag) and I'd reported after a previous merge to Linus' tip from pm-next:
> >
> > On Wed, 18 Sep 2019, Kenneth R. Crudup wrote:
> >
> > > - Randomly, if left suspended, nothing other than a hard power off will get
> > >   it back  ...  It appears "ec_no_wakeup=1" doesn't have this issue

BTW, is the ec_no_wakeup=1 workaround still effective?

If so, does the lid and/or power button wake up the system from
suspend with ec_no_wakeup=1?

> > So I noticed this bug seems to only happen if the laptop is plugged in and
> > charging- but only if the battery is < 100%; now that I had a real failure
> > mode I started bisecting, and I traced it to 56b991849, "PM: sleep: Simplify
> > suspend-to-idle control flow".
> >
> > What happens is I'll initiate a suspend, then when I try to resume the power
> > LED doesn't come on, and the machine is completely unresponsive. I have to
> > force a reset by holding the power key.
> >
> > I'd like to help you fix this issue; I figure if it's affecting my device
> > it's affecting others, too. I'm quite proficient with the kernel overall,
> > but know very little about ACPI or the EC. I'm assuming- totally wild guess-
> > that when we get some of those EC GPEs(?) while suspended(?) we're panic()ing
> > or hanging somewhere so the BIOS is getting hung up and the whole system is
> > stalled out.
> >
> > Where should I begin to help debug this? I have EFI store set up so BUG_ON()s
> > et al.  will dump there for retrival later if inserting those at critical
> > places could help.
>
> First off, please try to change the sleep_no_lps0 ACPI module
> parameter (/sys/module/acpi/parameters/sleep_no_lps0) to 1 and see if
> that makes any difference.  If it helps, I don't think we can do much
> except for blacklisting your machine.
