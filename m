Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEB2FFD86
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 08:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAVHkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 02:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726919AbhAVHki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 02:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611301151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9lvA5UDm4oX9uf5clHSyw8y7oQMIw3ieGwQZk1aJOw=;
        b=VMCn5kyqPGf8pGFQmMhqUqFfwYIgwP4NvK4XMcZmEv/9YkISV7vwZnFwFea6gUZ3ymfQVY
        xPRxB+zRdJ0OI8cd+l5+Ip/SuUn7SF5/Ar9k3/Uyiu3RixRkNKr8lzZccXgHhMEy2nOGnZ
        nxwcUR5xKx3p6CQwT0AqsZg+naOysrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-Y9ZXzACiMKquMwXmK7Y2qw-1; Fri, 22 Jan 2021 02:39:07 -0500
X-MC-Unique: Y9ZXzACiMKquMwXmK7Y2qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 039AA1005504;
        Fri, 22 Jan 2021 07:39:06 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6DC5100238C;
        Fri, 22 Jan 2021 07:39:01 +0000 (UTC)
Date:   Fri, 22 Jan 2021 15:38:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and
 suspend
Message-ID: <20210122073859.GA4797@MiWiFi-R3L-srv>
References: <20201118185917.GA433776@mwanda>
 <20210120093015.GE20161@MiWiFi-R3L-srv>
 <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
 <CAJZ5v0jgTyXQxPVQoM4nykk7gcWfNw9bXTQO8856vkYD8TJOCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgTyXQxPVQoM4nykk7gcWfNw9bXTQO8856vkYD8TJOCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/21/21 at 03:42pm, Rafael J. Wysocki wrote:
> On Thu, Jan 21, 2021 at 10:14 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Wed, Jan 20, 2021 at 5:30 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> > > > Hello Pingfan Liu,
> > > >
> > > > The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> > > > and suspend" from Jul 31, 2018, leads to the following static checker
> > > > warning:
> > > >
> > > >       kernel/power/main.c:27 lock_system_sleep()
> > > >       warn: called with lock held.  '&system_transition_mutex'
> > >
> > > This is a good finding. I think we can simply remove the lock/unlock
> > > pair of system_transition_mutex in kernel_kexec() function. The dead
> > > lock should be easily triggered, but it hasn't caused any failure report
> > > because the feature 'kexec jump' is almost not used by anyone as far as
> > > I know. We may need to find out who is using it and where it's used
> > > through an inquiry. Before that, we can just remove the lock operation
> > > inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks.
> > >
> > >
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 80905e5aa8ae..a0b6780740c8 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
> > >
> > >  #ifdef CONFIG_KEXEC_JUMP
> > >         if (kexec_image->preserve_context) {
> > > -               lock_system_sleep();
> > >                 pm_prepare_console();
> > >                 error = freeze_processes();
> > >                 if (error) {
> > > @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
> > >                 thaw_processes();
> > >   Restore_console:
> > >                 pm_restore_console();
> > > -               unlock_system_sleep();
> >
> > This should work since the only caller syscall_reboot has already
> > placed kernel_kexec() under the protection of system_transition_mutex.
> >
> > Thanks for the fix.
> >
> > Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
> 
> OK, so can anyone please submit that patch formally (Cc linux-pm, please)?

I will submit a patch with Pingfan's ack, thanks.

