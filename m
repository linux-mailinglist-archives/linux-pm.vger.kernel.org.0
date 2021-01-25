Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C0302961
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbhAYRzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:55:11 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46433 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbhAYRy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 12:54:59 -0500
Received: by mail-oi1-f176.google.com with SMTP id k25so1538210oik.13
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 09:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGJzELMRXctkHmJlmPY5iImraKbY7kx0LIMh08I1Dsc=;
        b=tnGiBKcO0KH6u4F07lGc3/1S/udChv3xLVpzADous2DJsURMacXtBiGKHLC3Tq1e+b
         DJXCplU24k5GwnOiBN4+XDweozrb9DypY+rdSgZeX9NO6Nprjq3LvBUvk+Xmi6yk2xwb
         K9OGONRomHK2pd6pax0UjBWvOwAuGo77w7J2ffmOsIBU3YhbcM7OO12SC+7F5hdsd2uf
         AFEysfBg0ukdgpH6rGIwmRV02yZb8JIGVhph8Xigv2bOHLCc4pjbz2jgWwsOD/EoxvBo
         35i20PZdY44CLEUBTJogf3+00kNUYmweOCNZ2gjLDVHxgWoGNT1cqjUqQWfhJCNVcEdo
         M10w==
X-Gm-Message-State: AOAM532RhAArotwHFUuJpw/eImuFNYXhcjCCP2+N0mDUBlRY8Z5pxMBT
        7TyAxyOQvcSJqn1XJ0vTm5HvYAf3S6hmtoNFF/08cIWw
X-Google-Smtp-Source: ABdhPJzbOq9jo7UZizPbkqgkxTMEQfpVYeBCngIuZgiTUqhhFs/k2+uekfrpAbPkpBKa4VZzdhR4pUBg4j/JUnz96gU=
X-Received: by 2002:aca:308a:: with SMTP id w132mr785767oiw.69.1611596711867;
 Mon, 25 Jan 2021 09:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20210122074214.26583-1-bhe@redhat.com> <CAFgQCTuvh40hOUKS1MLnuUm_14JeKUg_c1rncAFmd1bRXML0xA@mail.gmail.com>
In-Reply-To: <CAFgQCTuvh40hOUKS1MLnuUm_14JeKUg_c1rncAFmd1bRXML0xA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 18:45:00 +0100
Message-ID: <CAJZ5v0gfYJfTUm3aXQvPVoor6nE6a31EnNxxCxDBNVDLBY9ABQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/kexec: remove the lock operation of system_transition_mutex
To:     Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 25, 2021 at 10:05 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 3:42 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Function kernel_kexec() is called with lock system_transition_mutex held
> > in reboot system call. While inside kernel_kexec(), it will acquire
> > system_transition_mutex agin. This will lead to dead lock.
> >
> > The dead lock should be easily triggered, it hasn't caused any failure
> > report just because the feature 'kexec jump' is almost not used by anyone
> > as far as I know. An inquiry can be made about who is using 'kexec jump'
> > and where it's used. Before that, let's simply remove the lock operation
> > inside CONFIG_KEXEC_JUMP ifdeffery scope.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> >  kernel/kexec_core.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 80905e5aa8ae..a0b6780740c8 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
> >
> >  #ifdef CONFIG_KEXEC_JUMP
> >         if (kexec_image->preserve_context) {
> > -               lock_system_sleep();
> >                 pm_prepare_console();
> >                 error = freeze_processes();
> >                 if (error) {
> > @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
> >                 thaw_processes();
> >   Restore_console:
> >                 pm_restore_console();
> > -               unlock_system_sleep();
> >         }
> >  #endif
> >
> > --
> > 2.17.2
> >
> Reviewed-by: Pingfan Liu <kernelfans@gmail.com>

Applied as 5.11-rc material, thanks!
