Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0813B54E644
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiFPPnZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 11:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiFPPnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 11:43:24 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042AA1759F
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 08:43:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-100eb6f7782so2356064fac.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gQbIaU17eRw5sO/hecNb5FpluiGnQGygV2egDmXIIk=;
        b=ehE/gd4tah9jS/e8Ze0l+xwI3htCbpaNOqoUJX7AbepMSAJB7sjMCvDJmqYls5FM/e
         F+y7gfLeUntwqRbT824JObmT4UsnMPnZepY+gdttD59wtsyHuqRPnFlASHQpgPMKidRb
         BCO5iBlThav5VCTLbd9PY0Av71Kt15RjOCU8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gQbIaU17eRw5sO/hecNb5FpluiGnQGygV2egDmXIIk=;
        b=TDc1rBDCM/rJ93zf92ubpk7h6jVWfiyy5RTmlL9OZcyICF65R/X5+yKom72y1WwcAd
         V+vrWxwH3v/WDJOtFjljnGx+XtuMxt3rDJvfO7BZmI7/VHymiG4l559r8YRIKn7hsDrH
         7IqX51IBAj97qdoiYYHrNClc/E6ZWA+iLD8YUfZPEX42XuA7sR1WPIHMgeqnMXyqHSgG
         1P7qez6xBRrE4Cm818fctaayUXbNxc6z170jJLJ1p+VupRPMyGJAjkAPwMdJj69GVVhM
         CrEx4Jc84F+cbJCtKQ+U4lmrOd3ioFgniwqYYZFaeUaaXdb1SCHci9OM0Du7rvmQnGVi
         60EQ==
X-Gm-Message-State: AJIora9UtAiXC3Vx3C1JQbzis6IML5xmBpmHEYCHeiJ3jrI8DjuqeWir
        MHQ01I5oaso1SY5MvC24vferv6olSN6Hgw==
X-Google-Smtp-Source: AGRyM1t6Y+vfect30s69a+b/EcHxZIb7dKe5y7cJyQUlJwc8/f5iXhGUg6VuYe5n7l05p8gCVG/pAA==
X-Received: by 2002:a05:6870:910b:b0:fb:2841:52bc with SMTP id o11-20020a056870910b00b000fb284152bcmr8394857oae.88.1655394202998;
        Thu, 16 Jun 2022 08:43:22 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id y17-20020a4a9c11000000b0041b768b58basm1212366ooj.22.2022.06.16.08.43.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:43:21 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10113b4c2b5so2342570fac.6
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 08:43:20 -0700 (PDT)
X-Received: by 2002:a05:6870:5247:b0:fb:2e60:26c6 with SMTP id
 o7-20020a056870524700b000fb2e6026c6mr3012759oai.241.1655394200150; Thu, 16
 Jun 2022 08:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
 <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com> <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
In-Reply-To: <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 16 Jun 2022 08:42:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
Message-ID: <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 17, 2022 at 10:34 AM Evan Green <evgreen@chromium.org> wrote:
>
> Hi Rafael,
>
> On Tue, May 17, 2022 at 9:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, May 9, 2022 at 6:44 PM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > Hi!
> > > >
> > > > > We are exploring enabling hibernation in some new scenarios. However,
> > > > > our security team has a few requirements, listed below:
> > > > > 1. The hibernate image must be encrypted with protection derived from
> > > > >    both the platform (eg TPM) and user authentication data (eg
> > > > >    password).
> > > > > 2. Hibernation must not be a vector by which a malicious userspace can
> > > > >    escalate to the kernel.
> > > >
> > > > Can you (or your security team) explain why requirement 2. is needed?
> > > >
> > > > On normal systems, trusted userspace handles kernel upgrades (for example),
> > > > so it can escalate to kernel priviledges.
> > > >
> > >
> > > Our systems are a little more sealed up than a normal distro, we use
> > > Verified Boot [1]. To summarize, RO firmware with an embedded public
> > > key verifies that the kernel+commandline was signed by Google. The
> > > commandline includes the root hash of the rootfs as well (where the
> > > modules live). So when an update is applied (A/B style, including the
> > > whole rootfs), assuming the RO firmware stayed RO (which requires
> > > physical measures to defeat), we can guarantee that the kernel,
> > > commandline, and rootfs have not been tampered with.
> > >
> > > Verified boot gives us confidence that on each boot, we're at least
> > > starting from known code. This makes it more challenging for an
> > > attacker to persist an exploit across reboot. With the kernel and
> > > modules verified, we try to make it non-trivial for someone who does
> > > manage to gain root execution once from escalating to kernel
> > > execution. Hibernation would be one obvious escalation route, so we're
> > > hoping to find a way to enable it without handing out that easy
> > > primitive.
> > >
> > > [1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
> >
> > So I guess this really is an RFC.
>
> Yes, I suppose it is.
>
> >
> > Honestly, I need more time to go through this and there are pieces of
> > it that need to be looked at other people (like the TPM-related
> > changes).
>
> No problem, thanks for the reply to let me know. I expect some back
> and forth in terms of what should be hidden behind abstractions and
> where exactly things should live. But I wanted to get this out to
> upstream as early as I could, just to get initial reactions on the
> overall concept and design. Looking forward to hearing your thoughts
> when you get a chance, and let me know if there are others I should be
> adding that I've missed.

Gentle bump in case this dropped off of radars, I'd still appreciate
any feedback folks had on this series.
-Evan

>
> -Evan
>
> >
> > Thanks!
