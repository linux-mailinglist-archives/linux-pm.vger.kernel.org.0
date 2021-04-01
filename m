Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49817351C2F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhDASN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhDASHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:07:39 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2429C08EBAF;
        Thu,  1 Apr 2021 06:38:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2140917otr.4;
        Thu, 01 Apr 2021 06:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8G7y9c30KfRlKihNXRgoauoQW97JeaTkhUBkRBHJtk=;
        b=bc4CWHskETvuX+z488KGBvudmdIYxCdrwoMjD/F74lcuHFiSQCbnF50DmyjcxI1eX0
         5O6nYBAXuOJ8smFhaL384YoOYvVWfamu/HRg3cg4+PgXKbjOcDsZRdQe73LsWFD3uGgG
         HmojeDE9mzXyMcQIBY0ORnzpjLfWORkI8YjsVQydsHXgaGb/iLYbDe+eO5PxZibvb7oh
         Usywp+iWQm2yd20V3SGEqoWibPxOGACwKGagfchCrXhtFjxH2qpgWA1OqNztRczOXJsf
         PXpV46H+OuI3KnrlklNPqGj4PSzHdVfyeRxmvL1/stofoo1o/2/OyJJyX2WE58IQgzJ5
         jqsQ==
X-Gm-Message-State: AOAM531W4RdkUPmXQtOMHCBGYoleIUZj2MaGXRC4Xn6gUO0jpygXVBW4
        rINiaCykIBjCOA6vglbc02EZcqvidh10yOUkkqs=
X-Google-Smtp-Source: ABdhPJzCR0gDaubIVEpSXyh38pTht2H8Xfn5MxhmAKQTle86XqlnC5JMvjkSxFajcAamy+BrTpyqyOx6AAJsCd/h+T8=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr6322628otb.260.1617284306011;
 Thu, 01 Apr 2021 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com> <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
In-Reply-To: <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 15:38:12 +0200
Message-ID: <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> >
> > On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > > Hi,
> > > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > > >
> > > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > > due to the 2018 patch:
> > > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > > >
> > > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > > >
> > > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > > FIPS-compliant algorithm like SHA-1?
> > > > >
> > > > > I would say yes, it should.
> > > > >
> > > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > > >
> > > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > > constructions and only for specified uses. If you need to change
> > > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > > >
> > >
> > > What is the reason for using a [broken] cryptographic hash here? if
> > > this is just an integrity check, better use CRC32

Not really.

CRC32 is not really sufficient for integrity checking here AFAICS.  It
might be made a fallback option if MD5 is not available, but making it
the default would be somewhat over the top IMO.

> > If the integrity check is used exclusively to verify there were no
> > accidental changes and is not used as a security measure, by all means
> > I agree that using crc32 is a better idea.
> >
>
> Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
> this, it is only a best effort check which is simply omitted if md5
> happens to be unavailable, so there is definitely no need for crypto
> here.

Yes, it is about integrity checking only.  No, CRC32 is not equivalent
to MD5 in that respect AFAICS.

Thanks!
