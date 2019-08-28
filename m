Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0BA09EB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1Stq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 14:49:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Stq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 14:49:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so372016pfl.4
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uZspx4NWx0nFhhtAlnWtEbfBrasNUhrA/Iy70UI7ko=;
        b=aesFtNLZCHVxwTTzHGcziFAJn9W0ws751gL42MQtSB5sT897fV8iCGwBYIeg048n3r
         wfy+sK8h50KhNbMn2BX55hnizK6RYMhsYo3mH6zfxR6SduWeEjvFIHrdmAK/3+rPTInZ
         fmiF0BDWMLuDEB1qH+5PtkyONcnts+vkiY6UD8dp03z/PIunlSU7IDSKMkZIWVD/W5CN
         CTTd7DRpOboL3b4E0ah/0mQoG3QNvHMonSvbivAbig+7MyOjIkpfZDfJnJpedKGQZqNZ
         0DpYu+pQ46NuD29OpjK0AJd/1CXt6NV+P72J1lvAJcUoD59JrNlAfE/XDtrfLwg3qqVA
         UYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uZspx4NWx0nFhhtAlnWtEbfBrasNUhrA/Iy70UI7ko=;
        b=RMl6qBDjN8ig2AlXqspMDptzfiYD13PbBQDyS06XA7XMBTzf1bcStZKNa4Vd+7ZMuJ
         MYvQixhADKJ+Q0suJYFvGvIOM3CPYFHP06avJv9leyP7P2rIjaTHtbrwdy8LkYf4tPt7
         TS+CgixMR8RS7GNpRxGT/2drwtgMRSCLVQdbc/v0VdAyBavScLe/emBxoi+KNBp7gAlO
         0/u3M8yevzGjTcgYiifhB1C3rLKALDLoOGmzFyqQ4btLWtT3rAvRaTnRK0ARGLEVWpKZ
         sIoOpnRsdA3o2FJUXdgTqs8KZGAOjLZ/iNK1wgA480WKpwZdL6E0B6kngi1zuRB0ctWW
         4DaA==
X-Gm-Message-State: APjAAAXVxntq9fek2PhTTVqdtJigE8dImDBBtf1ksZFs9ItAP4BeYaU+
        7PTc5kJR/x7xs30gAoV3lRn4W7KOi8so+Oe3A0BikQ==
X-Google-Smtp-Source: APXvYqzLT/GpLTIf3YXAybRqHLvDBymSGaNqO+J24tjnTmWcTbsfo3oTWe8/j33SPKMkONhxXM2yJh7xYFqJ2XFRkIQ=
X-Received: by 2002:a17:90a:3ae7:: with SMTP id b94mr5745875pjc.73.1567018185100;
 Wed, 28 Aug 2019 11:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190613184923.245935-1-nhuck@google.com> <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
 <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
 <CAKwvOdkEp=q+2B_iqqyHJLwwUaFH2jnO+Ey8t-hn=x4shTbdoA@mail.gmail.com>
 <c2b821f2-545a-9839-3de6-d68dfee5b5dc@linaro.org> <20190819102131.41da667b@xps13>
 <b94af6b2101f436c1bdeec744e164c78ee7c2682.camel@intel.com>
In-Reply-To: <b94af6b2101f436c1bdeec744e164c78ee7c2682.camel@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 11:49:33 -0700
Message-ID: <CAKwvOd=ej156MVjkVHAVbpWEew08YhCWpM-3BPYoLfeXHPJEMQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 28, 2019 at 1:53 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Mon, 2019-08-19 at 10:21 +0200, Miquel Raynal wrote:
> > Hello,
> >
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Thu, 15 Aug 2019
> > 01:06:21 +0200:
> >
> > > On 15/08/2019 00:12, Nick Desaulniers wrote:
> > > > On Tue, Aug 13, 2019 at 10:28 AM 'Nathan Huckleberry' via Clang
> > > > Built
> > > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > >
> > > > > Following up to see if this patch is going to be accepted.
> > > >
> > > > Miquel is listed as the maintainer of this file in MAINTAINERS.
> > > > Miquel, can you please pick this up?  Otherwise Zhang, Eduardo,
> > > > and
> > > > Daniel are listed as maintainers for drivers/thermal/.
> > >
> > > I'm listed as reviewer, it is up to Zhang or Eduardo to take the
> > > patches.
> > >
> > >
> >
> > Sorry for the delay, I don't manage a tree for this driver, I'll let
> > Zhang or Eduardo take the patch with my
> >
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
>
> Patch applied.
>
> thanks,
> rui

Thanks Rui, did you push the branch?  I guess I would have expected it
in https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/log/?h=next?
I'm trying to track where this lands in
https://github.com/ClangBuiltLinux/linux/issues/532.

-- 
Thanks,
~Nick Desaulniers
