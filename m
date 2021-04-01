Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00D351C30
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhDASN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhDASHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:07:53 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC0C02FEB8;
        Thu,  1 Apr 2021 09:31:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2652141otr.4;
        Thu, 01 Apr 2021 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2F3q5wWuoCm7yS9fr79bvLkaWuMidfEWBoEEUWkViQ=;
        b=THpM4wuqdZw1oYyMPgawpvmzSu6KcDdy3WkegQ2vxyeXvcv+oFLsVcUeLSZmOOw243
         nfiLDYWaMpsrFUFf+DNlbf0f91gAE9C4ES7No3Vq1uAbPRhyDypW/NA41nwk4cSTijjG
         pTq3azh47h3UZ0yotB31teS3up66zeXbVgeadgRMgv+NjcNJDhL28LpLBmXfzRQPjLa9
         P3cR7UDAd3L2xeho3gceSrvmELavdYjBZSTYniMA5mospgJocyFWiyv/E7LQBcCgLwC0
         vshqQAY0dAmIafdkwrWYiAwba2261sU3ZPEueSennhF59oNAfgpy84pRHvDGqac0eKw2
         D9LA==
X-Gm-Message-State: AOAM530yjB5/uehPkeVkqghN/Bh3h64HnPipz46GCcDpQKel+j+YCfJI
        un7n1sVYmg7PUjg3swm0QEu2sugCsW7H8DAswic=
X-Google-Smtp-Source: ABdhPJxTDti0FzKjB6ztN9D0lND3xp5qsv0z39MWYOIN+M4jqh4hHB/FI0qJ0QI5p9YT4y4EW2KCpy+Hb802+nmGnPc=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr7844753otf.206.1617294672957;
 Thu, 01 Apr 2021 09:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
 <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
 <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
 <CAMj1kXFrBGTitSNYZC58=UdmfgbbF2MvTcfLVRpkxJ-uYX3piw@mail.gmail.com>
 <CAJZ5v0iPneWK69GTzWigdXjjb6VN6Hyd5=hLCdGasfnTxXCYNg@mail.gmail.com> <44e4e4e62bff778d3b0b59235c793ec84794372b.camel@redhat.com>
In-Reply-To: <44e4e4e62bff778d3b0b59235c793ec84794372b.camel@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 18:31:00 +0200
Message-ID: <CAJZ5v0iHMvZuAifGGLA=Hn9Zb5iiLKfoyuKVyM0HFxzX3=Ht0Q@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     Simo Sorce <simo@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 6:22 PM Simo Sorce <simo@redhat.com> wrote:
>
> On Thu, 2021-04-01 at 18:02 +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 1, 2021 at 3:54 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Thu, 1 Apr 2021 at 15:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> > > > > > On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > > > > > > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > > > > > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > > > > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > > > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > > > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > > > > > > >
> > > > > > > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > > > > > > due to the 2018 patch:
> > > > > > > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > > > > > > >
> > > > > > > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > > > > > > >
> > > > > > > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > > > > > > FIPS-compliant algorithm like SHA-1?
> > > > > > > > >
> > > > > > > > > I would say yes, it should.
> > > > > > > > >
> > > > > > > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > > > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > > > > > > >
> > > > > > > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > > > > > > constructions and only for specified uses. If you need to change
> > > > > > > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > > > > > > >
> > > > > > >
> > > > > > > What is the reason for using a [broken] cryptographic hash here? if
> > > > > > > this is just an integrity check, better use CRC32
> > > >
> > > > Not really.
> > > >
> > > > CRC32 is not really sufficient for integrity checking here AFAICS.  It
> > > > might be made a fallback option if MD5 is not available, but making it
> > > > the default would be somewhat over the top IMO.
> > > >
> > > > > > If the integrity check is used exclusively to verify there were no
> > > > > > accidental changes and is not used as a security measure, by all means
> > > > > > I agree that using crc32 is a better idea.
> > > > > >
> > > > >
> > > > > Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
> > > > > this, it is only a best effort check which is simply omitted if md5
> > > > > happens to be unavailable, so there is definitely no need for crypto
> > > > > here.
> > > >
> > > > Yes, it is about integrity checking only.  No, CRC32 is not equivalent
> > > > to MD5 in that respect AFAICS.
> > > >
> > >
> > > There are two possibilities:
> > > - we care about an adversary attempting to forge a collision, in which
> > > case you need a cryptographic hash which is not broken;
> > > - we only care about integrity, in which case crypto is overkill, and
> > > CRC32 is sufficient. (Note that the likelihood of an honest,
> > > inadvertent modification not being caught by CRC32 is 1 in 4 billion)
> >
> > That depends on how you count.
> >
> > Surely, there are modifications caught by MD5 that will not be caught by CRC32.
>
> This is a technically correct statement, but does it matter in this
> context? (Hint, probably not)
>
> > > MD5 does not meet either requirement, given that it is known to be
> > > broken, and overkill for simple integrity checks. MD5 should be phased
> > > out and removed, and moving this code onto the correct abstraction
> > > would be a reasonable step towards that goal.
> >
> > This clearly is a matter of opinion.
>
> Sorry, but this is not a matter of opinion.
> The only reason to use a cryptographic hash is that you want to protect
> from active tampering, rather than from accidental changes. And if you
> need to protect from active tampering then you cannot use a known
> broken hash, there is no point.
>
> OTOH if you do not care for active tampering but only to catch
> transmission/storage errors then all you care for is error checking. In
> that case a cryptographic hash is overkill because it entails a lot
> more computation than is needed.

But the amount of data in question is not huge in this case.

> > I'm not religious about it though.  If there is a general consensus
> > that CRC32 is sufficient for error detection in hibernation files,
> > then it can be used.  So is there such a consensus and if so, can you
> > give me a pointer to some research that it is based on?
>
> CRC32 is an industry standard to check for accidental modifications of
> a bit stream. The chances of missing an accidental change are 1 in 4
> billion.

This is not about accidental change which basically is my point.

The BIOSes in question change the memory map over hibernation/resume,
because they think that the memory layout is now different, so this is
about detecting a sort of intentional change.  Definitely not random,
though.

But as stated elsewhere, it is just about failing more gracefully at
least in some cases, so let's just go ahead with using CRC32 here
(worst case, it will not fail more gracefully in super-corner cases).
