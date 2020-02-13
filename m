Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6481315BDC6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgBMLiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:38:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45321 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgBMLiU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 06:38:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so5410172oic.12;
        Thu, 13 Feb 2020 03:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMCJGVjckFT5lzjUBU3Ii43bx1kX7tib7kx2TUtQs7I=;
        b=nAxjxADh8+aDc6d75bAz62nBtUAjydtN9yOnI/2+DqDoXy1a2Jbd2zQKNcX8ChAFLP
         LIx7AI8be/EqzeiKWqj+c1LhxsWs6bQut02ngsSC6Y4YZX0xrjeqfLR7GiPFCUnFPzhB
         wPcvqYhZKVJtvSveZc5hFPFvDZPkrwP0XI8TRHMq8df3cgSCiGKNLyHp9/9uautqlwbx
         4/Gm986TsCRnANPPnRcmEwPQOS/QFY1XGMAR2rhtgARAC4mG81iF7NvVj7QxaMz09cMu
         x+4iFab7N25XOqU0Rc5vGUO3VDltMAa1vRysnaDZSMABUEKLh/OXKpw5isE0mlcw0IXj
         g6XA==
X-Gm-Message-State: APjAAAWtF25EzNPd3k6+PTCa4obHCf7+mg4EZKrAXgzhSXdp2ghS5qx9
        g8FhbVMC2wEZhDRRL1nnvY+jq3+SU04mwuSNg0k=
X-Google-Smtp-Source: APXvYqwiasPNFJUgvsPmDRxPLHGEgQkGyr2VOj+V2NjdxLfERU7nmmyxbIasFELYXJ6LNsX+qL3oCm9LoZAxU7DLFe4=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr2666110oiy.110.1581593899702;
 Thu, 13 Feb 2020 03:38:19 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
 <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
 <CAJZ5v0hrOma52rocMsitvYUK6WxHAa0702_8XJn1UJZVyhz=rQ@mail.gmail.com> <877e0qj4bm.fsf@riseup.net>
In-Reply-To: <877e0qj4bm.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 12:38:08 +0100
Message-ID: <CAJZ5v0hH1XiphdakYFPmHLL+hFKw2U3YNU9HSRxsdRUV6ZtM5g@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 9:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, Feb 13, 2020 at 1:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >> >

[cut]

> >
> > And BTW, posting patches as RFC is fine even if they have not been
> > tested.  At least you let people know that you work on something this
> > way, so if they work on changes in the same area, they may take that
> > into consideration.
> >
>
> Sure, that was going to be the first RFC.
>
> > Also if there are objections to your proposal, you may save quite a
> > bit of time by sending it early.
> >
> > It is unfortunate that this series has clashed with the changes that
> > you were about to propose, but in this particular case in my view it
> > is better to clean up things and start over.
> >
>
> Luckily it doesn't clash with the second RFC I was meaning to send,
> maybe we should just skip the first?

Yes, please.

> Or maybe it's valuable as a curiosity anyway?

No, let's just focus on the latest one.

Thanks!
