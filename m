Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B735D10E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 21:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhDLT2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 15:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237367AbhDLT2a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Apr 2021 15:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A362611F2;
        Mon, 12 Apr 2021 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618255692;
        bh=ztmSoUUYp+tzmYLUNhcN82H/6tE7mQJ4p7iORncV1X8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VKNHhgjW6LaBhuF/c8DtwNqwnQbI5TlmjpaOmk6jiLG+qqU1HNPVbUd0Zcm86+SQx
         AbHTkDlghSUIWAO7uMj8xvPs0Yn+qvetG/pa5gEWEoYuwAZkI5NFuytgbG6J0H86dv
         3sFTHNOLZGNXjf31S88IblEHEKt7j4jv0Fg5R129/9rJxAz0YBdyCEHLbi5vzIby/9
         g7IT44MvU7KbKsuXEXvS3qZOYuDdnHLrILCmnAeJO0DfdRutO9uBvrdDn2q3VYkWUC
         n2/QtUcTYl9UR6dSBNUDAQZjuiHwOKQJybjjqsP0vkB/3Uq2Yih7KlSXdBaik1mLfT
         mPQpr0W4D/20A==
Received: by mail-ot1-f47.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso3261036oto.3;
        Mon, 12 Apr 2021 12:28:12 -0700 (PDT)
X-Gm-Message-State: AOAM532/C32JhwYlN89LDVh8UPzqq+EgWiXUW8Y8h2QqqBoP7YGSomTV
        DgFBOF1ZEg6RfiS86bfcreIDNn3Wst75I/OMQAU=
X-Google-Smtp-Source: ABdhPJx46Mf1tFyIIDxHyAr5R875mb1ks/eZGyeNp1w11WcAfOyLMYcyFYxNMaTE5mFDQIc1P2pSXIJdMCcEAud1SzQ=
X-Received: by 2002:a9d:12e:: with SMTP id 43mr1719379otu.90.1618255691225;
 Mon, 12 Apr 2021 12:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210412140932.31162-1-crecklin@redhat.com> <YHSHPIXLhHjOu0jw@gmail.com>
 <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com> <YHSdgV6LIqSVxk+i@gmail.com>
In-Reply-To: <YHSdgV6LIqSVxk+i@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Apr 2021 21:27:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
Message-ID: <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Apr 2021 at 21:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 03:04:58PM -0400, Chris von Recklinghausen wrote:
> > On 4/12/21 1:45 PM, Eric Biggers wrote:
> > > On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
> > > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > > integrity check and is not available. Use crc32 instead.
> > > >
> > > > This patch changes the integrity check algorithm from md5 to crc32.
> > > >
> > > > The purpose of the integrity check is to detect possible differences
> > > > between the memory map used at the time when the hibernation image is
> > > > about to be loaded into memory and the memory map used at the image
> > > > creation time, because it is generally unsafe to load the image if the
> > > > current memory map doesn't match the one used when it was created. so
> > > > it is not intended as a cryptographic integrity check.
> > > This still doesn't actually explain why a non-cryptographic checksum is
> > > sufficient.  "Detection of possible differences" could very well require
> > > cryptographic authentication; it depends on whether malicious changes need to be
> > > detected or not.
> >
> > Hi Eric,
> >
> > The cases that the commit comments for 62a03defeabd mention are the same as
> > for this patch, e.g.
> >
> >     1. Without this patch applied, it is possible that BIOS has
> >        provided an inconsistent memory map, but the resume kernel is still
> >        able to restore the image anyway(e.g, E820_RAM region is the superset
> >        of the previous one), although the system might be unstable. So this
> >        patch tries to treat any inconsistent e820 as illegal.
> >
> >     2. Another case is, this patch replies on comparing the e820_saved, but
> >        currently the e820_save might not be strictly the same across
> >        hibernation, even if BIOS has provided consistent e820 map - In
> >        theory mptable might modify the BIOS-provided e820_saved dynamically
> >        in early_reserve_e820_mpc_new, which would allocate a buffer from
> >        E820_RAM, and marks it from E820_RAM to E820_RESERVED).
> >        This is a potential and rare case we need to deal with in OS in
> >        the future.
> >
> > Maybe they should be added to the comments with this patch as well? In any
> > case, the above comments only mention detecting consequences of BIOS
> > issues/actions on the e820 map and not intrusions from attackers requiring
> > cryptographic protection. Does that seem to be a reasonable explanation to
> > you? If so I can add these to the commit comments.
> >
> > I'll make the other changes you suggest below.
> >
> > Thanks,
> >
>
> Those details are still missing the high-level point.  Is this just meant to
> detect non-malicious changes (presumably caused by BIOS bugs), or is it meant to
> detect malicious changes?  That's all that really needs to be mentioned.
>

This is not about BIOS bugs. Hibernation is deep suspend/resume
grafted onto cold boot, and it is perfectly legal for the firmware to
present a different memory map to the OS after a cold boot. It is
Linux that decides that it can restore the entire system state from a
swap file, and carry on as if the cold boot was just a [firmware
assisted] suspend/resume.

So forging collisions is *not* a concern here. Let's avoid accidental
or malicious, as those adjectives seem to confuse some people. The
bottom line is that there is no need to protect against deliberate
attempts to hide the fact that the memory map has changed, and so
there is no reason to use cryptographic hashes here.
