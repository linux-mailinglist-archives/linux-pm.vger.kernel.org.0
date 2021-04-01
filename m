Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60112351EBD
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhDASqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235585AbhDASnD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42B006127B;
        Thu,  1 Apr 2021 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617285276;
        bh=E1MzlRBNIUjGJaXAAgyCF+55RPXojah69hWzY81rL8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pBk4gX5rfgrUemMy5yDME4Jyw/HzyUy3oVmxgTnxb79E871sCtPVOAnWY/vjCptNL
         SIaj7j2dZpzqpv7eYCA4iUZMUR8qeGTsZKw4RRqI7t01LFvG4lSs9dZPU0EwL1bZY5
         T9ep+vhTQXFOVsK2lVLLqSLt8eBw8sxWL7mhpj8FOXSo1FFmO53pT5/IFHBn+f8Di5
         bgbquLapdAAP0PL9xSH7Gj6sTrYHUKZ+kmhq+aKkBfULJo6XQBJxcKs+MGDZbDwW0F
         oMcolbp01BacVr4vANlxD8gQZRGJNX4GXndu2EcQb5jH7fkg/sDQR6qK3IkFrMmo+l
         QXUCQygpm/OBw==
Received: by mail-oo1-f51.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so569315ooe.9;
        Thu, 01 Apr 2021 06:54:36 -0700 (PDT)
X-Gm-Message-State: AOAM530+kgodvJ8gJ77+FkpKsizkHPfrLwQ2rK5D1drvtTIjKH8BzmT7
        ilq23soBUwH6WNKj1Qkenuv8BTtGO9FxUdLvOQk=
X-Google-Smtp-Source: ABdhPJwzloTq4sU/egDltze4DIJ8ibhKd4oREk2yk3c6I9Xx/E9U8vV4YNUsd5xZRqEUpIiJowZjREkRVdjmkO6xHLg=
X-Received: by 2002:a4a:395d:: with SMTP id x29mr7229111oog.41.1617285275577;
 Thu, 01 Apr 2021 06:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
 <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com> <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Apr 2021 15:54:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrBGTitSNYZC58=UdmfgbbF2MvTcfLVRpkxJ-uYX3piw@mail.gmail.com>
Message-ID: <CAMj1kXFrBGTitSNYZC58=UdmfgbbF2MvTcfLVRpkxJ-uYX3piw@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 1 Apr 2021 at 15:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> > >
> > > On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > > > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > > > Hi,
> > > > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > > > >
> > > > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > > > due to the 2018 patch:
> > > > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > > > >
> > > > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > > > >
> > > > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > > > FIPS-compliant algorithm like SHA-1?
> > > > > >
> > > > > > I would say yes, it should.
> > > > > >
> > > > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > > > >
> > > > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > > > constructions and only for specified uses. If you need to change
> > > > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > > > >
> > > >
> > > > What is the reason for using a [broken] cryptographic hash here? if
> > > > this is just an integrity check, better use CRC32
>
> Not really.
>
> CRC32 is not really sufficient for integrity checking here AFAICS.  It
> might be made a fallback option if MD5 is not available, but making it
> the default would be somewhat over the top IMO.
>
> > > If the integrity check is used exclusively to verify there were no
> > > accidental changes and is not used as a security measure, by all means
> > > I agree that using crc32 is a better idea.
> > >
> >
> > Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
> > this, it is only a best effort check which is simply omitted if md5
> > happens to be unavailable, so there is definitely no need for crypto
> > here.
>
> Yes, it is about integrity checking only.  No, CRC32 is not equivalent
> to MD5 in that respect AFAICS.
>

There are two possibilities:
- we care about an adversary attempting to forge a collision, in which
case you need a cryptographic hash which is not broken;
- we only care about integrity, in which case crypto is overkill, and
CRC32 is sufficient. (Note that the likelihood of an honest,
inadvertent modification not being caught by CRC32 is 1 in 4 billion)

MD5 does not meet either requirement, given that it is known to be
broken, and overkill for simple integrity checks. MD5 should be phased
out and removed, and moving this code onto the correct abstraction
would be a reasonable step towards that goal.
