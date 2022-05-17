Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7F52A97C
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiEQRmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbiEQRmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 13:42:18 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35CDD109
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 10:42:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f17f1acffeso12538643fac.4
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg7EH5Vrvb2fKjVFmkcCg9Zq9x2kct9i+zNiZ3Rb9nE=;
        b=e1JvkQ93rAtCK7sn488U3SuJf4AoUESglxHXrKJTTMMkNeQNcU7i/nTgft7PxtzV81
         JTZb2e0ArclXtYmdxk/G5BmXdnm+y8WTIxYFtmcmGcWKgMQy1d7RhscLPElAzT1nXsHj
         Xd2uFtRkYUUKQb5Cxhh1Wdfsp9NSTDDMoVQRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg7EH5Vrvb2fKjVFmkcCg9Zq9x2kct9i+zNiZ3Rb9nE=;
        b=oWlbv7lkXsNZxR+wymvxniv7T+tSuXJJTq0WJhBlGvae6l3NskCGpxrwpavPVzJfKg
         BYhx/2CwwV9sjuDjvExEwQnfiu1qfUzpauwO4I2DVFa4GmAthaHj6uk5HPWMXEDg95Z1
         T+xv9Bs508/FVRGiJcGlhDPewRJHCio+LIRYEZkGdFU0GeFz3y9nS4/khcdSXe2oryS0
         UL05XmPxGz3zSCneE/kcXGLpLqfA1q70ayi1STFxrm3Vx02rJweEiSdpQmv++HLZBl6m
         yIbKkJyPfQyInLdpbbHUwm8mnD2Db143jKOxfUecU5iIVPfffRNeQiYNrmdSTYWyln2o
         iHJw==
X-Gm-Message-State: AOAM530k9VipudFKuZVIeEIFONzYVkyO8fkt0u5MMirtxToyJk8+G7Vs
        NW2/aIuFLE/uhZvfwwwW92XotU7UL9tILA==
X-Google-Smtp-Source: ABdhPJx5hDtElGp3FhUQJC494zZcfHa8LIlA0xziB4QjxBMjDsj8ohcO+TGjQmkudIH6DW5q12gbCA==
X-Received: by 2002:a05:6870:630d:b0:e2:6498:6734 with SMTP id s13-20020a056870630d00b000e264986734mr13071396oao.3.1652809335971;
        Tue, 17 May 2022 10:42:15 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id o185-20020acabec2000000b00325cda1ff95sm68893oif.20.2022.05.17.10.42.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 10:42:15 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id q10so23156919oia.9
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 10:42:15 -0700 (PDT)
X-Received: by 2002:a05:6808:d52:b0:328:acfc:d274 with SMTP id
 w18-20020a0568080d5200b00328acfcd274mr11183218oik.174.1652808882898; Tue, 17
 May 2022 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com> <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 17 May 2022 10:34:05 -0700
X-Gmail-Original-Message-ID: <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
Message-ID: <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
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
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, May 17, 2022 at 9:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 9, 2022 at 6:44 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > We are exploring enabling hibernation in some new scenarios. However,
> > > > our security team has a few requirements, listed below:
> > > > 1. The hibernate image must be encrypted with protection derived from
> > > >    both the platform (eg TPM) and user authentication data (eg
> > > >    password).
> > > > 2. Hibernation must not be a vector by which a malicious userspace can
> > > >    escalate to the kernel.
> > >
> > > Can you (or your security team) explain why requirement 2. is needed?
> > >
> > > On normal systems, trusted userspace handles kernel upgrades (for example),
> > > so it can escalate to kernel priviledges.
> > >
> >
> > Our systems are a little more sealed up than a normal distro, we use
> > Verified Boot [1]. To summarize, RO firmware with an embedded public
> > key verifies that the kernel+commandline was signed by Google. The
> > commandline includes the root hash of the rootfs as well (where the
> > modules live). So when an update is applied (A/B style, including the
> > whole rootfs), assuming the RO firmware stayed RO (which requires
> > physical measures to defeat), we can guarantee that the kernel,
> > commandline, and rootfs have not been tampered with.
> >
> > Verified boot gives us confidence that on each boot, we're at least
> > starting from known code. This makes it more challenging for an
> > attacker to persist an exploit across reboot. With the kernel and
> > modules verified, we try to make it non-trivial for someone who does
> > manage to gain root execution once from escalating to kernel
> > execution. Hibernation would be one obvious escalation route, so we're
> > hoping to find a way to enable it without handing out that easy
> > primitive.
> >
> > [1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
>
> So I guess this really is an RFC.

Yes, I suppose it is.

>
> Honestly, I need more time to go through this and there are pieces of
> it that need to be looked at other people (like the TPM-related
> changes).

No problem, thanks for the reply to let me know. I expect some back
and forth in terms of what should be hidden behind abstractions and
where exactly things should live. But I wanted to get this out to
upstream as early as I could, just to get initial reactions on the
overall concept and design. Looking forward to hearing your thoughts
when you get a chance, and let me know if there are others I should be
adding that I've missed.

-Evan

>
> Thanks!
