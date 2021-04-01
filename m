Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD273519E8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhDAR4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhDARyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:54:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF11C02FEAC;
        Thu,  1 Apr 2021 09:20:10 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id k25so2313666oic.4;
        Thu, 01 Apr 2021 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hoy9JWbZpNKKgJwwAmTLHFplX2rUrxGqNdm9v8L9dMU=;
        b=j7/QkXhOpGVwzChbSZ94wE8RHL2qth7PoVtFxL9ypQ7Vb4OtJEQ1qVfN4jQdIBxToB
         m6lH/8CiEitgkAtDGLyHGbRGF0fEEBnPAOband/GhQSBE0gfA9zKIqvzRu6PwOdyMU+e
         fxhXQoauxr8naE+uZ2rxkne3vV6faJCtU70NYGjB3BPzkuih+X4qQz3M4FZYmxUX0AyK
         nF4prV0jkQGEu7a61eu57DXJn8qIsPf5ZGkA3rWrJ/cYw+dcuPs78sBtXALAYKzxw6gd
         7scwNxYKLJ24HXOonS6RAaSZo9C0NkoWKbDXj40YTyFlBdrzs/3O5sytibKbZ5INduQe
         bs8Q==
X-Gm-Message-State: AOAM530w6bpgKVrlctRqrinAk3YimROJYkJnvtku35h3BHAB6YOzAlmn
        71rcB/9JtVIlPTS+b1sL+uc54Jjl923+W+HKCuM=
X-Google-Smtp-Source: ABdhPJwLLFe8AN0azUamchJsJA2GytFp8mOWOLpmp56AWSXoBEUHQmtJLTpZhJIOrc4IiBnN23gOPVFKYY4e5y8xWD8=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6329836oib.69.1617294008998;
 Thu, 01 Apr 2021 09:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210401122458.12663-1-crecklin@redhat.com> <20210401122458.12663-2-crecklin@redhat.com>
 <CAJZ5v0gCkhoKC_81WP6wdehZBYpEpmNhHwDygYawFdrWk3K6vg@mail.gmail.com> <CAMj1kXFKRtB_YNGCKAGmRfvZTERCYJHR3hRdZ9-vyiRrB67rdg@mail.gmail.com>
In-Reply-To: <CAMj1kXFKRtB_YNGCKAGmRfvZTERCYJHR3hRdZ9-vyiRrB67rdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 18:19:57 +0200
Message-ID: <CAJZ5v0iqB7h1i_wuHTHTV-cvX+uQsbuae8W7wcFS8QffitD4aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 3:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 1 Apr 2021 at 15:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Apr 1, 2021 at 2:25 PM Chris von Recklinghausen
> > <crecklin@redhat.com> wrote:
> > >
> > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > integrity check and is not available. Use crc32 instead.
> > >
> > > Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
> > >        by md5 digest")
> > > Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> > > ---
> > >  arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
> > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > > index cd3914fc9f3d..6a3f4e32e49c 100644
> > > --- a/arch/x86/power/hibernate.c
> > > +++ b/arch/x86/power/hibernate.c
> > > @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
> > >  }
> > >
> > >
> > > -#define MD5_DIGEST_SIZE 16
> > > +#define CRC32_DIGEST_SIZE 16
> > >
> > >  struct restore_data_record {
> > >         unsigned long jump_address;
> > >         unsigned long jump_address_phys;
> > >         unsigned long cr3;
> > >         unsigned long magic;
> > > -       u8 e820_digest[MD5_DIGEST_SIZE];
> > > +       u8 e820_digest[CRC32_DIGEST_SIZE];
> > >  };
> >
> > No.
> >
> > CRC32 was used here before and it was deemed insufficient.
> >
>
> Why? The git commit log does not have an explanation of this.

IIRC there was an example of a memory map that would produce the same
CRC32 value as the original or something like that.

But that said this code is all about failing more gracefully, so I
guess it isn't a big deal if the failure is more graceful in fewer
cases ...
