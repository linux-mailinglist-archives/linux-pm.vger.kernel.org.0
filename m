Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15D351116
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 10:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhDAIrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 04:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDAIrL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 04:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF56610A5;
        Thu,  1 Apr 2021 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617266831;
        bh=kIY39xSiWjoF6sZnoaotfSd9UwS1ZraiYATimaHn4q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dthggg8b7dAPmVCaE/dTavdjFa9rPW8UC6EfXQSxSbfgnQ9ohbBnbsZA43xvhJI/s
         z5AUK4v+HYnJ5wBTqGGETFvrn6t7evM30qoWMU4SvAvJis8ig8zAD2M+K3dxU7pRjN
         FvmyysaLIlQ/m4hZkAK1hPCX6sqxtbFEVdVewtBbcYW9KSc+cIBKDRyBb0T3xXdKak
         PydMSo+vl7MDbweuD2w+RK4JAEeWVootOCKB20Rk5gQXPQF4rkAulqJ95gZruqdCYn
         AsM1FKvblH5PGVDShbZ2Q4PDUuXU2qJn8cKgzxqPwv7l3c6SQkGb2dIquF0hgKdRuJ
         Nh9W3nV64Iunw==
Received: by mail-ot1-f48.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so1465812otk.5;
        Thu, 01 Apr 2021 01:47:10 -0700 (PDT)
X-Gm-Message-State: AOAM532c6aKaIx4bB0ecoyi09cpft/YYs0vXQ2FrL8AvMunLTDPP6+Yt
        EBhXL1YiKZwLJh0HvMCMUw3W0jJsbfeOd6YZ1jc=
X-Google-Smtp-Source: ABdhPJxMNssJ30KB6dSY69fDuCOr4LCVZh/D5LIw2zyYA6sUCNNW1VJBb7EkMscKsxoRWI5AjBchYD6rYN1Quvypp1A=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr5843158otg.77.1617266830166;
 Thu, 01 Apr 2021 01:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com> <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
In-Reply-To: <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Apr 2021 10:46:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
Message-ID: <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     Simo Sorce <simo@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
>
> On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > Hi,
> > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > >
> > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > due to the 2018 patch:
> > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > >
> > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > >
> > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > FIPS-compliant algorithm like SHA-1?
> > > >
> > > > I would say yes, it should.
> > > >
> > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > >
> > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > constructions and only for specified uses. If you need to change
> > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > >
> >
> > What is the reason for using a [broken] cryptographic hash here? if
> > this is just an integrity check, better use CRC32
>
> If the integrity check is used exclusively to verify there were no
> accidental changes and is not used as a security measure, by all means
> I agree that using crc32 is a better idea.
>

Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
this, it is only a best effort check which is simply omitted if md5
happens to be unavailable, so there is definitely no need for crypto
here.
