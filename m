Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF4E0D88
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfJVU5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 16:57:33 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42050 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJVU5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 16:57:33 -0400
Received: by mail-oi1-f178.google.com with SMTP id i185so15427374oif.9;
        Tue, 22 Oct 2019 13:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GptL/7TorSVDMwb9IC9D0CwrTWrvmemL9jOU1eTDxRw=;
        b=TMmwQrogi0BSNwcV728fP3AUXRLbPOzcZnNesImOvgrdKQr2OmZoUksW6B5CWBJler
         E53YRSajr5xyoAh5asmDCyQuhFn15nG+aGx6Arlx2sh+nuLBPVXgKJ7zuQmhUdiHloC5
         H3mNYZlwplIbGAJ6p5lMLu5O2hcmi7lS/YPWKOW5HVaFN4h6XwqIr3o2mq0tdzAg5huB
         b1ZdRgM6bXUH75wIgHUl8x909+phRrsKnntNOCGwynV9dcdv6R5THUN1y+2Tcd4NggIc
         ZST26Kcbly1DA/C0OGpSLwHIYXfrRf/Lpese6Wp1ItElEwnkRWeOFy4/mGBBTwdDwP2y
         Whhw==
X-Gm-Message-State: APjAAAXKXcsnwCRpDWX5MNn4Fp63UOZJLM7d9H4D9zyqN4XxKSn5YyHU
        NaWxfKUz/plmZyJ+fIJkoxdiIYqztskXQK58A9A=
X-Google-Smtp-Source: APXvYqyk1WrrJhEEyw6GsXZ8C6TlqsHNqLGEfbQ3hHFtSJ/9IiDbsVm4p9PwtvKBd2rEdvAJP5SZ7QtPICfg441YKK4=
X-Received: by 2002:aca:5885:: with SMTP id m127mr4777280oib.110.1571777852342;
 Tue, 22 Oct 2019 13:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9TABY=3C+FQEg8FDyF1rim315G2hmeB1DBWJLn-wG1j0g@mail.gmail.com>
In-Reply-To: <CAA25o9TABY=3C+FQEg8FDyF1rim315G2hmeB1DBWJLn-wG1j0g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Oct 2019 22:57:20 +0200
Message-ID: <CAJZ5v0gJWxLJTi7TjaRP-3aR3f4VnX1n9dRE_jxdS6e3SM46LQ@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Luigi Semenzato <semenzato@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>, Bas Nowaira <bassem@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 22, 2019 at 10:09 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> Following a thread in linux-pm
> (https://marc.info/?l=linux-mm&m=157012300901871) I have some issues
> that may be of general interest.
>
> 1. To the best of my knowledge, Linux hibernation is guaranteed to
> fail if more than 1/2 of total RAM is in use (for instance, by
> anonymous pages).  My knowledge is based on evidence, experiments,
> code inspection, the thread above, and a comment in
> Documentation/swsusp.txt, copied here:

So I use it on a regular basis (i.e. every day) on a system that often
has over 50% or RAM in use and it all works.

I also know about other people using it on a regular basis.

For all of these users, it is usable.

>  "Instead, we load the image into unused memory and then atomically
> copy it back to it original location. This implies, of course, a
> maximum image size of half the amount of memory."

That isn't right any more.  An image that is loaded during resume can,
in fact, be larger than 50% of RAM.  An image that is created during
hibernation, however, cannot.

> 2. There's no simple/general workaround.  Rafael suggested on the
> thread "Whatever doesn't fit into 50% of RAM needs to be swapped out
> before hibernation".  This is a good suggestion: I am actually close
> to achieving this using memcgroups, but it's a fair amount of work,
> and a fairly special case.  Not everybody uses memcgroups, and I don't
> know of other reliable ways of forcing swap from user level.

I don't need to do anything like that.

hibernate_preallocate_memory() manages to free a sufficient amount of
memory on my system every time.

> 3. A feature that works only when 1/2 of total RAM can be allocated
> is, in my opinion, not usable, except possibly under special
> circumstances, such as mine. Most of the available articles and
> documentation do not mention this important fact (but for the excerpt
> I mentioned, which is not in a prominent position).

It can be used with over 1/2 of RAM allocated and that is quite easy
to demonstrate.

Honestly, I'm not sure what your problem is really.

> Two questions then:
>
> A. Should the documentation be changed to reflect this fact more
> clearly?  I feel that the current situation is a disservice to the
> user community.

Propose changes.

> B. Would it be worthwhile to improve the hibernation code to remove
> this limitation?  Is this of interest to anybody (other than me)?

Again, propose specific changes.
