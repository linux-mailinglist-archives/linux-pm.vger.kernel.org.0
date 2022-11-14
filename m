Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8F628591
	for <lists+linux-pm@lfdr.de>; Mon, 14 Nov 2022 17:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiKNQiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Nov 2022 11:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiKNQih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2022 11:38:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E644762CB
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2022 08:33:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a5so18103759edb.11
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2022 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=Ck1gj2RHs6kKr8eo0lLZILNZm9cTLBmDBgd3gbZIiMsgfnGD3JCQsqadXh2xLzzWDB
         1lPmOGx9KUAFcKRtzpsAkB/jzN2nyVsb7J2RGxm+IgmxzSWRs+xzhCPqnycw71njMhHU
         0JqDeR+Ls0TsMcPMDlQtzx7Tuxw277l1DoPnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=WW2xTJVy3tI6CPqiVT1R5tznFSlEEQbVNc+TMu//jymCd86RRrxy29hkyhJmhP70vZ
         oHOge2ohdhDVh/giuJs8Y+4wagpyJnGwTBayL06LWbfZ87pyuikLSrLrhuzo+YaA0K8C
         0c7nAJQqzM0McELHNF1dnBamefaxqBcJgWFCzWJDGcJpX5d6RoAEDyUXFd5cgArZABLj
         5rJCeNsIL/SCTU196i5eblYlgWyUsBuqyZp3fTRmb3QyQCl0voqx/AOPFwTpcJQH63Xd
         thX57urV3v/kfVI4YVhFw4vZ0ruvE1fbvVEc0Z47deJLpX0/ZzozA2QruOUrqIdqWZa0
         dykw==
X-Gm-Message-State: ANoB5pmPRdFkfHKubpstO2SoINtk7c+Vd59ZOjPMH1BbTMgUrqTUzc11
        Dec2i08oXuQrJ71716uk9xW/2VXM0TlBQw==
X-Google-Smtp-Source: AA0mqf5J1yZxsQz2NyEPBBZNj0NhLkcH9FO3ujWiX/Y1rOYfOZ/fBk1BFsqYIOTBHeg8gku4kT1z/Q==
X-Received: by 2002:a05:6402:370a:b0:467:9384:a7be with SMTP id ek10-20020a056402370a00b004679384a7bemr8215630edb.141.1668443613060;
        Mon, 14 Nov 2022 08:33:33 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id sz15-20020a1709078b0f00b0073cf6ec3276sm4332811ejc.207.2022.11.14.08.33.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:33:32 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id h126-20020a1c2184000000b003cfdd569507so510720wmh.4
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2022 08:33:32 -0800 (PST)
X-Received: by 2002:a05:600c:4e0e:b0:3cf:87c6:890b with SMTP id
 b14-20020a05600c4e0e00b003cf87c6890bmr8708365wmq.194.1668443611668; Mon, 14
 Nov 2022 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <Y3FfhrgvBNey6T7V@sol.localdomain> <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
In-Reply-To: <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Nov 2022 08:32:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation data
To:     jejb@linux.ibm.com
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        gwendal@chromium.org, dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 13, 2022 at 7:32 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> > On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > > b/security/keys/trusted-keys/tpm2key.asn1
> > > index f57f869ad60068..608f8d9ca95fa8 100644
> > > --- a/security/keys/trusted-keys/tpm2key.asn1
> > > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> > >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> > >         parent          INTEGER ({tpm2_key_parent}),
> > >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > > -       privkey         OCTET STRING ({tpm2_key_priv})
> > > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > > +       ---
> > > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_data}),
> > > +       ---
> > > +       --- A TPM2B_DIGEST of the creationHash as returned from the
> > > TPM2_Create
> > > +       --- command.
> > > +       ---
> > > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_hash}),
> > > +       ---
> > > +       --- A TPMT_TK_CREATION ticket as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_tk})
> > >         }
> >
> > The commit that added this file claimed:
> >
> >         "The benefit of the ASN.1 format is that it's a standard and
> > thus the
> >         exported key can be used by userspace tools
> > (openssl_tpm2_engine,
> >         openconnect and tpm2-tss-engine"
> >
> > Are these new fields in compliance with whatever standard that was
> > referring to?
>
> Not really, no.  The current use case (and draft standard) is already
> using [1] for policies and [2] for importable keys:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml
>
> I'm actually planning to use [3] for signed policies.  There's no
> reason why you can't use [4] though.  Since the creation data, hash and
> ticket are likely used as a job lot, it strikes me they should be a
> single numbered optional sequence instead of individually numbered,
> since you're unlikely to have one without the others.

Thanks, I was hoping James might pipe up and tell me what to do.
Grouping them as a single numbered optional sequence sounds reasonable
to me. Is your draft too far along to squeeze this in? If it is and
I'm on my own to draft up and submit this, I would definitely
appreciate any pointers on getting started you might have.

I notice the draft and the code seem to be out of alignment. I'm
unfamiliar with this process, is the idea to get through all the
iterations and land the standard, then fix up the code? What happens
to existing data handed out in the old format?

-Evan
