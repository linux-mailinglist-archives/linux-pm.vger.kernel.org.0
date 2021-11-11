Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41644DB27
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 18:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhKKRfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 12:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 12:35:29 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE90AC061767
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 09:32:39 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s139so12776267oie.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 09:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gvvpWtzRmL17H6APsk6foj0/Vw/9Xnyncdy1bzuH63E=;
        b=ArHl0YD2sgGiqJA1jV5y67ZYH9Uy0uYV8uVc+pPadvjgkveVO/zIXqjmpqtXWcbQpC
         H+scsvp9xhog2WQdWi/JwDT6cD1oAkcN1/RhtSg4heLhtbohjs+QCyKbeD68JBctX8at
         Xi/Txfoh5rRwuVNEfj+lZzks7mUMDg7fV5+zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gvvpWtzRmL17H6APsk6foj0/Vw/9Xnyncdy1bzuH63E=;
        b=56WdqqY+cZ31uIaxbIwUSOGLXAnzpJOltKbqRzze5+/qkhtenqTztudTC7I3Ql8QDA
         uMHZ3tLam343kGRpwh7xzwmO5Eyo3w6kJfbvs2OhUkuVGiwKpB+GholFX+dZdJAp87zj
         CPteKwXQcrZDG+c9qYkNPehA6RT7iBYf9HjJLjXUsPRZY8gNJxYQDv3ecutCWM1D4t7H
         NcF6OycWBZrCgkMIvGRrarZYUbIaPut7j40JC5oR6refhF/yOJ8d9I3/RY65l43bupHO
         ja+9eK4Ui8mmoPuw4+PJT0MPzWMEEOCKvxg9H/ygida3G6pEzpGIjYNZuJLeSShbwhzp
         93PA==
X-Gm-Message-State: AOAM530YlxZtuxK9kl3w5Lo+Bt9ymGGP+o5MNZrqH/APzra2EClhhTc0
        3MmGtDT/xJ450/Qfxfp4ObRtHPKSPTqGSfM74Tn8Cg==
X-Google-Smtp-Source: ABdhPJwbwnS0fHxon9yEvzcN7GX7OpMG1W6/SL6pJLUI39uxNyfgiOX+nJQSNOeHQfM/3hzqnezJ43G7n8q8i1NJ7nY=
X-Received: by 2002:aca:d989:: with SMTP id q131mr7308053oig.167.1636651959329;
 Thu, 11 Nov 2021 09:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20211110211905.GA1261732@bhelgaas> <20211111170127.GA1336355@bhelgaas>
In-Reply-To: <20211111170127.GA1336355@bhelgaas>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Thu, 11 Nov 2021 18:32:28 +0100
Message-ID: <CAP145piKqyVepa7wnuqwntycdq6tU3ZeoUV10+nweqaXNyvs=Q@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

> > Thank you very much for testing this.  The patch changed the way we
> > use runtime PM, and the dmesg snippets below look like they could be
> > related to runtime PM issues.
> >
> > I think the conclusion is that we need to revert these commits:
> >
> >   b5f9c644eb1b ("PCI: Remove struct pci_dev->driver")
> >   2a4d9408c9e8 ("PCI: Use to_pci_driver() instead of pci_dev->driver")
> >
> > from Linus' tree.  I queued up those reverts on
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=
=3Dfor-linus
>
> These reverts appeared in the Nov 11 linux-next tree.  Any chance you
> could verify that they solve the i2c_dw_pci_resume() issue?  If it's
> easier, you can apply them from:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=3D=
for-linus
> instead.

Looks good with the most recent 3 commits from for-linus applied on
the top of the current linus' tree.

No problematic dmesg entries, my Win11/vfio/kvm/qemu boots fine.



--=20
Robert =C5=9Awi=C4=99cki
