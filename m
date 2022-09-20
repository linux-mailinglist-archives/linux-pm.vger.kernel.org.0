Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC85BEB50
	for <lists+linux-pm@lfdr.de>; Tue, 20 Sep 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiITQqS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Sep 2022 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiITQqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2022 12:46:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E82CE17
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 09:46:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z13so4651713edb.13
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JMNdVTN29xxheNQ60C0UdJixTzdS2o/Kn71ZSUiC498=;
        b=O0fQbt4HqeW76QZSC/Cs+vdBiibzuNSAXu1nr7RuuSsmrTy2AMjiQo3cT9tlr/Oyd3
         ToPPH5FZQ40YZ5T/oTqZGvi1FWZELBe65b4byLzhgcbnc/UxHw8t6p1iNUSwOlJRs8oD
         P3hieH4mgO56j5uNyt13K0pknu/i8ckWVrxjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JMNdVTN29xxheNQ60C0UdJixTzdS2o/Kn71ZSUiC498=;
        b=T/6QgGqIY5liyyM0kzeaCTylCCPsB20Z5irG9J20s6XCodsmICI1FsviinXt01OzLk
         kjzsd1JGzGm09xMgyf31E5Bm1/KEnu87/9i59BY8zjNW0lsLBu1AUx6UO0eqcHbtOyXl
         slvzxbKZ8g0RI0WSShuoTSeTN9wEcluCqLM697Q2XWrzZ8VrZkbasgAQk1D4z0f6zmVK
         Pfs7fWKbqFJZhUbZxMyPjDkgbYvqoPQzxD3t8V1ZFipDo6d+Fow2oi9TyeOOIPIh0BQX
         iDpEkRfyIJo4dZNwLcuzn0JqApIeHCJLxzXijHrU/YT9Ho2InSNmuT9vA9bJxMSuiW8M
         ZEAg==
X-Gm-Message-State: ACrzQf0ZOUWV165Yd8jVOD5cWl7hEbzaBTQz+Ij0JitUAFmgmIGxyZML
        oJQzFohi3lG7YSuOr9gj1qHsJ+1RrtxJuP/p
X-Google-Smtp-Source: AMsMyM5fdgznBBEc6PhfQAzvze6UvSDe785izte1QiIuPTbiz/oKlLUDL0PmOIgO71neBJjIwRcZ1g==
X-Received: by 2002:a05:6402:1e92:b0:451:dcf:641d with SMTP id f18-20020a0564021e9200b004510dcf641dmr21256544edf.335.1663692374016;
        Tue, 20 Sep 2022 09:46:14 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ay4-20020a170906d28400b00777249e951bsm143846ejb.51.2022.09.20.09.46.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:46:13 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id y5so5309588wrh.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 09:46:13 -0700 (PDT)
X-Received: by 2002:adf:a4ce:0:b0:22a:f5e8:6dcc with SMTP id
 h14-20020adfa4ce000000b0022af5e86dccmr9099428wrb.445.1663692002281; Tue, 20
 Sep 2022 09:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org> <20220920084648.GA17087@duo.ucw.cz>
In-Reply-To: <20220920084648.GA17087@duo.ucw.cz>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 20 Sep 2022 09:39:25 -0700
X-Gmail-Original-Message-ID: <CAE=gft65bdcoU-oF1=QK2Pg1-kO5gSXk7jxa99fErHK3osytCQ@mail.gmail.com>
Message-ID: <CAE=gft65bdcoU-oF1=QK2Pg1-kO5gSXk7jxa99fErHK3osytCQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Encrypted Hibernation
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, apronin@chromium.org,
        Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 20, 2022 at 1:46 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > We are exploring enabling hibernation in some new scenarios. However,
> > our security team has a few requirements, listed below:
> > 1. The hibernate image must be encrypted with protection derived from
> >    both the platform (eg TPM) and user authentication data (eg
> >    password).
> > 2. Hibernation must not be a vector by which a malicious userspace can
> >    escalate to the kernel.
>
> Why is #2 reasonable requirement?
>
> We normally allow userspace with appropriate permissions to update the
> kernel, for example.

I'll take a stab at answering this. I've also CCed one of our security
folks to keep me honest and add any needed additional context.

ChromeOS takes an approach of attempting to limit the blast radius of
any given vulnerability as much as possible. A vulnerable system
service may be running as root, but may also still be fairly
constrained by sandboxing: it may not have access to all processes,
the entire file system, or all capability bits. With Verified Boot
[1], our kernel and rootfs are statically signed by Google (or
yourself if firmware has been reflashed). Even if a full root
compromise occurs, it's difficult for the attacker to persist across a
reboot, since they cannot update the kernel or init flow on disk
without the signing key.

We do our best to lock down other escalation vectors from root to
kernel as well. For instance, features like LoadPin help prevent a
malicious root from simply loading up a payload via insmod.

So in cases like ours, jumping from root execution to kernel execution
represents a real escalation in privilege. Hibernate as it exists
today represents a wide open door for root to become kernel, so we're
forced to disable the Kconfigs for it. This series, along with another
patch to restrict unencrypted resume, would add the guardrails we need
to prevent arbitrary code from moving into the kernel via resume.

-Evan

[1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
