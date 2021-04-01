Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226B2351ECE
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDASrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238554AbhDASo7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:44:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D2276127A;
        Thu,  1 Apr 2021 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617285407;
        bh=cxGPfEN00N5O7Ti4m6YVF4l7FI4AFfu9elwFGD41uxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbjY14ZVWYf294l1Sny/rPUo/Bb0kwXjRgovwkQVdYmA6J95Wobl3vzFO/7omrujL
         0W7GOsSr4AglMs6r/HNjJANy6YRFJLUOgyHt6AbJgc6YmdIITDifFiYDDX2b96awgD
         zSl+YJ6iQ/kVPwHKEZH+tkdX/uair86ywgC00G7V4Va5hvdqBwdG51hl37qOR/gjYd
         ImsT6zAectsUsdi61TuNdmK+KVypJgHRMX2QnA4eyuDmBct9Y7D8WlbVJ//HjcFSOQ
         zWW7/hyRxp0A5OR+P94gEpf+O6h2sRoufdExmL2LfOmfn1vWbiAjdeATEsT4VOcmL0
         ZbaE9YZubi1oA==
Received: by mail-ot1-f47.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so2210419otn.1;
        Thu, 01 Apr 2021 06:56:47 -0700 (PDT)
X-Gm-Message-State: AOAM530+BBB8WQTuoW0D5UD3Vxo8orMy/wwFlWOKiG9LsNxuJQ4c4iDM
        fDadYqvWSn6CQ6HjE57Euo2Zc6bs7wg5x3CaS5Q=
X-Google-Smtp-Source: ABdhPJxMskh5x1ZP7reLi/yqjOlcXSJvGQrZ+ItT10RMeApAxHCDIeRXjXTYnk1VOCWvejBfsq6+1ifo+J0eeVkFJXo=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr6815810otg.77.1617285406787;
 Thu, 01 Apr 2021 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
 <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
 <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com> <2b452865-ca6c-892d-f04e-3e6e2a74b598@redhat.com>
In-Reply-To: <2b452865-ca6c-892d-f04e-3e6e2a74b598@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Apr 2021 15:56:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCTxPfPz6ivHL=U9f93MpfJsn223K=1A-Jd0sFi+EbRg@mail.gmail.com>
Message-ID: <CAMj1kXHCTxPfPz6ivHL=U9f93MpfJsn223K=1A-Jd0sFi+EbRg@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     crecklin@redhat.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 1 Apr 2021 at 15:54, Chris von Recklinghausen
<crecklin@redhat.com> wrote:
>
> On 4/1/21 9:38 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> >>> On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> >>>> On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> >>>>> On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> >>>>>> On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> >>>>>>> Hi,
> >>>>>>> MD5 was marked incompliant with FIPS in 2009:
> >>>>>>> a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> >>>>>>> a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> >>>>>>>
> >>>>>>> But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> >>>>>>> due to the 2018 patch:
> >>>>>>> 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> >>>>>>>
> >>>>>>> As a result, hibernation doesn't work when FIPS is on.
> >>>>>>>
> >>>>>>> Do you think if hibernation_e820_save() should be changed to use a
> >>>>>>> FIPS-compliant algorithm like SHA-1?
> >>>>>> I would say yes, it should.
> >>>>>>
> >>>>>>> PS, currently it looks like FIPS mode is broken in the mainline:
> >>>>>>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> >>>>> FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> >>>>> constructions and only for specified uses. If you need to change
> >>>>> algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> >>>>>
> >>>> What is the reason for using a [broken] cryptographic hash here? if
> >>>> this is just an integrity check, better use CRC32
> > Not really.
> >
> > CRC32 is not really sufficient for integrity checking here AFAICS.  It
> > might be made a fallback option if MD5 is not available, but making it
> > the default would be somewhat over the top IMO.
>
>
> Would ghash be a better choice? It produces the same size digest as md5.
>

No, ghash is a MAC not a hash. It should only ever be used with GCM
and nowhere else.

> Does anyone have any other suggestions of algorithms to try?
>

Just use crc32
