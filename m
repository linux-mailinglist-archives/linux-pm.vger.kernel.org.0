Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66381C18D0
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgEAOya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 10:54:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32818 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgEAOy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 10:54:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id j26so2774264ots.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2020 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pmjrv5qPvKOPeFLJljuTHlccBG/WcgupC+vQ1RcE9Y4=;
        b=p1FLRGHD5IE01JfdnlkkSWs9lV880/WC32CRxxuks/P8slWfYJ7NFgaGBWVrH/3kFT
         tS4/IVp8C0apPfbbh07Z6lQd9xyvtHZJaGT+IFzTGa6rFkYXUKN0vJseUosIp4CHr4vL
         d83rplypJXZzu0KMOcexyKeGfp8QnQL138vW97tKByeBLvR+vtWr3X/6ManhUfZDGBbh
         VHjDLbZkPkhIoi81AnpKpMFFjxLW7XKucpMM90fmxmKeGrBYUlieR3SmnM+MQvzVxzLx
         yJTqwO+DfZxBaR3fSKJ+4si2XCfNcbI/WOcXKyy9wMz+jqgs6360MAJ0UQGaTO9zsESm
         9Fag==
X-Gm-Message-State: AGi0PuaWzEN5cJY73cl/WHklBtDEBZuT/z5cWbagIHDuWcJM4ADeYXKR
        Iwif1o9m+daonI8vmx/xHbFFbFIaosSvFFbZgnhijA==
X-Google-Smtp-Source: APiQypIofkrNeM8CqcEO9KjlBxTesezBbJsnEXoizmYFN9TI14vTWRqsSAkMmiDuaNBPU2KZ5BV18/wTKMfaCCKHetw=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr3916497otq.262.1588344868215;
 Fri, 01 May 2020 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200413190843.044112674@gmail.com> <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher> <20200427094840.GA29259@dumbo>
 <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com> <20200501071052.GA20585@dumbo>
In-Reply-To: <20200501071052.GA20585@dumbo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 May 2020 16:54:13 +0200
Message-ID: <CAJZ5v0itdtHTsMhbrgThR76YRDv-BBH2VSiU413d+K9K0VFyAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 1, 2020 at 9:10 AM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> On Wed, Apr 29, 2020 at 01:20:53PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Apr 27, 2020 at 11:48 AM Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > >
> > > On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> > > >
>
> [...]
>
> > > >
> > > > It is possible in theory that two processes write "disk" to /sys/power/state
> > > > concurrently.
> > > >
> > > > Is there enough mutual exclusion in place to handle this gracefully after the
> > > > above change?
> > >
> > > No, indeed.
> > >
> > > It looks like hibernate.c needs the mutual exclusion and user.c could
> > > just use it. Should I move snapshot_device_available to hibernate.c
> > > and rename it hibernate_available?
> >
> > There is hibernation_available() already.
> >
> > Maybe switch over to the refcount_t API, call the variable
> > hibernate_refcount and use refcount_add_not_zero() on it for the
> > mutual exclusion.
>
> I'm doing as you ask but I'm not understanding what we actually gain
> from using the refcount_t API.
>
> I'm reading about relaxation of memory ordering and there is no mention
> on what this implies for the add_not_zero operation that we use.

The details probably don't matter, but what we use here effectively is
a refcount which is not allowed to grow above 1,

That's why it'd be reasonable to explicitly define it as a refcount,
now that there is a suitable API.
