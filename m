Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF41069B3
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVKMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 05:12:53 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36024 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVKMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 05:12:53 -0500
Received: by mail-oi1-f171.google.com with SMTP id j7so6052669oib.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 02:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kastVHhagzRBS2jF1vY5Xy9GzDog5t2lB64T5jmZDOQ=;
        b=Zsnzck9UuOcwg17T4vcADVjyfp1myXVSEWPVEgIS5Z/6fhzaNYMulp/IMPbBjpIdMP
         p+go/wsj4gJmnWNTC/0d0H5gcK/djcu8OheRkrlXozwL2ti6RruNHoU43i3R4NJlRnMB
         LrGvNpPQqQLHe1d9lnu08z6zjRIMHPAXcTFuyg4KdseXf6NkdBYWB5yR+OXgIPRFiNA8
         CWbM2WwzrS+zw9VSAy1ap5qJeTHKu5kM/xYIrdu/daWh2k9OKZB0phBKDrZVA5r1OjwT
         A0JTdAfb5E8JNLh7UZKJiBk2kYLjTUZzDQK6AXn+B7CQ1i099NeUoJE758PqjgeSCGDc
         abjg==
X-Gm-Message-State: APjAAAVM+ZpIGaOKOO4mj2bHVwhOp+Nl3yzZXx4D5ZIgVmRqkyqwjiZl
        JBVA2rfG8FX+Rdkxhrlgk/Wih2FpyToSGNElpOc=
X-Google-Smtp-Source: APXvYqyNe4N5b3jrCEDALzivA/ktFgOKd+59EDpdw7ay58Aq1fqtem6gByDyyR80VuHnBZfy+crKnO3kZ67V8UwWAwA=
X-Received: by 2002:aca:c753:: with SMTP id x80mr11019685oif.115.1574417572681;
 Fri, 22 Nov 2019 02:12:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911211549500.3167@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 11:12:41 +0100
Message-ID: <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
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

On Fri, Nov 22, 2019 at 1:28 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> I've been running Linus' tip for a while, mostly to get the PM improvements
> on s2idle (I hate this mode so much- I'm tired of taking a warm laptop out
> of my bag) and I'd reported after a previous merge to Linus' tip from pm-next:
>
> On Wed, 18 Sep 2019, Kenneth R. Crudup wrote:
>
> > - Randomly, if left suspended, nothing other than a hard power off will get
> >   it back  ...  It appears "ec_no_wakeup=1" doesn't have this issue
>
> So I noticed this bug seems to only happen if the laptop is plugged in and
> charging- but only if the battery is < 100%; now that I had a real failure
> mode I started bisecting, and I traced it to 56b991849, "PM: sleep: Simplify
> suspend-to-idle control flow".
>
> What happens is I'll initiate a suspend, then when I try to resume the power
> LED doesn't come on, and the machine is completely unresponsive. I have to
> force a reset by holding the power key.
>
> I'd like to help you fix this issue; I figure if it's affecting my device
> it's affecting others, too. I'm quite proficient with the kernel overall,
> but know very little about ACPI or the EC. I'm assuming- totally wild guess-
> that when we get some of those EC GPEs(?) while suspended(?) we're panic()ing
> or hanging somewhere so the BIOS is getting hung up and the whole system is
> stalled out.
>
> Where should I begin to help debug this? I have EFI store set up so BUG_ON()s
> et al.  will dump there for retrival later if inserting those at critical
> places could help.

First off, please try to change the sleep_no_lps0 ACPI module
parameter (/sys/module/acpi/parameters/sleep_no_lps0) to 1 and see if
that makes any difference.  If it helps, I don't think we can do much
except for blacklisting your machine.
