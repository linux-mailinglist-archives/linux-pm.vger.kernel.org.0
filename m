Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510CF191C89
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCXWHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 18:07:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42606 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXWHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 18:07:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id s18so86557otr.9;
        Tue, 24 Mar 2020 15:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDJSZpzFwpVT/O1jCQRTBFHmVA+P37ZccabTXzq6UPI=;
        b=U19r1nC9bPxbId9SACnyZiL6Qrl6xRqSEWDM9mGsR12tZDeBFPprR+XLM1f4CCuGPn
         2CO/S+PxSlr7cmsignYKMiriFezU+/6tvg/+EaQPp64DBAS7TMQyBgpr4AIGbAqZvXn/
         CYbz8KBhmKBiSpzGdE8l9KtWFldAPd1NrZHPOb7y3nQrlSgfGrLGX9JzdB2RjutJbOZo
         my6iJlr3pl4e8pfwGn3rCSaEEoBCLZwFoaK/UMvsHVgn/843h2Jdh9Cv6KZULMbdFY9P
         us3pTzPBEbM+2qvptDw3QjJqqb0zdpErjNKlurkFoY0LY29Nji9nsd5ITqgxOwSOVZva
         i/3A==
X-Gm-Message-State: ANhLgQ0RoI7ZAkISoJcgqg982DEQ5/Dhfl43EJZqeJIhncUgIAdxQmyP
        GOu85414/hv0rIPodMK3FhyIh+kRTb1jFWcnBbo=
X-Google-Smtp-Source: ADFU+vtOe1JNh0VtHDNLNJFdUcHDzagDQE4/GOCdvU4Y5JmryKd0ZROoys9KGxv8gRElcssrndfCZBZ4TovExBARyZM=
X-Received: by 2002:a4a:7555:: with SMTP id g21mr183055oof.46.1585087658733;
 Tue, 24 Mar 2020 15:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200323181245.GJ4288@osiris> <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
 <20200324191128.GA3822@osiris>
In-Reply-To: <20200324191128.GA3822@osiris>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 23:07:27 +0100
Message-ID: <CAJZ5v0jiz-YmULR+T3k38=WYkx83F=JAmNpc3r7=+N398FQOkQ@mail.gmail.com>
Subject: Re: s390: removal of hibernate support
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 8:11 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> Hi Rafael,
>
> > On Mon, Mar 23, 2020 at 7:12 PM Heiko Carstens
> > <heiko.carstens@de.ibm.com> wrote:
> > > we are going to remove hibernate support on s390, since it is
> > > - broken since many years
> > > - there is no real use case which justifies keeping and maintaining
> > >   the code
> > >
> > > See also https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=394216275c7d503d966317da9a01ad6626a6091d
> > >
> > > This in turn allows also to remove s390 specific hooks in generic
> > > power management code (see patch below). The patch below is currently
> > > also on the same features branch.
> > > I silently assume(d) that you don't mind to get rid of otherwise dead
> > > code, or do you have any objections?
> > >
> > > From 086b2d78375cffe58f5341359bebec0650793811 Mon Sep 17 00:00:00 2001
> > > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Date: Wed, 18 Mar 2020 20:55:20 +0100
> > > Subject: [PATCH] PM: remove s390 specific callbacks
> > >
> > > ARCH_SAVE_PAGE_KEYS has been introduced in order to be able to save
> > > and restore s390 specific storage keys into a hibernation image.
> > > With hibernation support removed from s390 there is no point in
> > > keeping the callbacks.
> > >
> > > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> >
> > Can I take this patch or would it be better to route it differently?
>
> The patch is already on the s390 features branch and is supposed to be
> part of the first pull request for the next merge window (actually the
> patch is already in linux-next).
> So I'd say the easiest thing would be to route it through the s390 tree.

OK
