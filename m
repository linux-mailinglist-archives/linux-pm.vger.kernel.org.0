Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809B5873F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiHAWde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiHAWdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 18:33:31 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854EF220F5
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 15:33:29 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10ea30a098bso10430834fac.8
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI7JfBTHXcIfr/9UgMaMzqcZcXHkE1NiQIHzTU9OMbY=;
        b=cF+PM2YAd/AUT5qzQ0nJgW7ok1vFg9j5ZWOyJvGxFUYr7Zvy6AanzGkLbB529Gl+Qc
         YO0AcazHdcSnFyDrtq047WoUQLzvGI1DZh5TKK7xC0VpxBOn4CICGP0cnP5x/zklP9Qi
         99CZwd4H+SfwuCwqCcvmMHs1IXVcieCMIfit0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI7JfBTHXcIfr/9UgMaMzqcZcXHkE1NiQIHzTU9OMbY=;
        b=YWAKbfQXJf2MDIwFycNXCW/+MILj8VwDZ57bPbGKALip/po98wbt/VeAowHqjOp8D5
         dSuSluBFTPiUANZGalyHNb3PkJbJorqoGFaSfg158/uMY2Whay1Li4+5PJQRjjOlC/95
         LkwpuYv/TvJNLGMT3Ogb98V4fOrR46P6/jzUkcPpk893jisBYfOmtXzNafJ5yie2L3pO
         pRgAh+wxkrFFZmwlXIdto0OsqREnWXbZLPc+5cmb7ajsoaPbnPzZTiiLLTdRtL/G42KE
         sWY5N+R718GsnZnZV5fCQFN9fQPZOgGzU6eAE8B3dYzNf6nAYugUUv/wUD49a0D/JyDA
         ZjMw==
X-Gm-Message-State: AJIora+NQbpmWInVVa0rWor/mpI9VfljD0LJLsb2XU3Dg59P/ZBqVti4
        NGdzm3vrQ6A1ZbNP9THGgaH5id4yLSy+RA==
X-Google-Smtp-Source: AGRyM1sNo02egZMU0O33ESe/et/iW/6REFd9ZwFCpEnh46VUph+1sHyr3FDlSgmrvFmoL726hkIPmA==
X-Received: by 2002:a05:6870:8314:b0:10c:cc1a:57fc with SMTP id p20-20020a056870831400b0010ccc1a57fcmr8850752oae.153.1659393208644;
        Mon, 01 Aug 2022 15:33:28 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id i8-20020a4ad388000000b0035eb4e5a6cbsm2974119oos.33.2022.08.01.15.33.27
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 15:33:27 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id n133so14709609oib.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 15:33:27 -0700 (PDT)
X-Received: by 2002:a05:6808:14d4:b0:33b:1489:8752 with SMTP id
 f20-20020a05680814d400b0033b14898752mr7607300oiw.174.1659393206929; Mon, 01
 Aug 2022 15:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
 <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
 <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com> <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
In-Reply-To: <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 1 Aug 2022 15:32:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
Message-ID: <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 16, 2022 at 8:42 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, May 17, 2022 at 10:34 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, May 17, 2022 at 9:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 9, 2022 at 6:44 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > > We are exploring enabling hibernation in some new scenarios. However,
> > > > > > our security team has a few requirements, listed below:
> > > > > > 1. The hibernate image must be encrypted with protection derived from
> > > > > >    both the platform (eg TPM) and user authentication data (eg
> > > > > >    password).
> > > > > > 2. Hibernation must not be a vector by which a malicious userspace can
> > > > > >    escalate to the kernel.
> > > > >
> > > > > Can you (or your security team) explain why requirement 2. is needed?
> > > > >
> > > > > On normal systems, trusted userspace handles kernel upgrades (for example),
> > > > > so it can escalate to kernel priviledges.
> > > > >
> > > >
> > > > Our systems are a little more sealed up than a normal distro, we use
> > > > Verified Boot [1]. To summarize, RO firmware with an embedded public
> > > > key verifies that the kernel+commandline was signed by Google. The
> > > > commandline includes the root hash of the rootfs as well (where the
> > > > modules live). So when an update is applied (A/B style, including the
> > > > whole rootfs), assuming the RO firmware stayed RO (which requires
> > > > physical measures to defeat), we can guarantee that the kernel,
> > > > commandline, and rootfs have not been tampered with.
> > > >
> > > > Verified boot gives us confidence that on each boot, we're at least
> > > > starting from known code. This makes it more challenging for an
> > > > attacker to persist an exploit across reboot. With the kernel and
> > > > modules verified, we try to make it non-trivial for someone who does
> > > > manage to gain root execution once from escalating to kernel
> > > > execution. Hibernation would be one obvious escalation route, so we're
> > > > hoping to find a way to enable it without handing out that easy
> > > > primitive.
> > > >
> > > > [1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
> > >
> > > So I guess this really is an RFC.
> >
> > Yes, I suppose it is.
> >
> > >
> > > Honestly, I need more time to go through this and there are pieces of
> > > it that need to be looked at other people (like the TPM-related
> > > changes).
> >
> > No problem, thanks for the reply to let me know. I expect some back
> > and forth in terms of what should be hidden behind abstractions and
> > where exactly things should live. But I wanted to get this out to
> > upstream as early as I could, just to get initial reactions on the
> > overall concept and design. Looking forward to hearing your thoughts
> > when you get a chance, and let me know if there are others I should be
> > adding that I've missed.
>
> Gentle bump in case this dropped off of radars, I'd still appreciate
> any feedback folks had on this series.

One more bump here, as we'd really love to get encrypted hibernation
to a form upstream would accept if at all possible. We were
considering landing this in our Chrome OS tree for now, then coming
back in a couple months with a "we've been baking this ourselves and
it's going so great, oooh yeah". I'm not sure if upstream would find
that compelling or not. But in any case, some guidance towards making
this more upstream friendly would be well appreciated.

One thing I realized in attempting to pick this myself is that the
trusted key blob format has moved to ASN.1. So I should really move
the creation ticket to the new ASN.1 format (if I can figure out the
right OID for that piece), which would allow me to drop a lot of the
ugly stuff in tpm2_unpack_blob(). Maybe if I get no other comments
I'll work on that and resend.

-Evan
