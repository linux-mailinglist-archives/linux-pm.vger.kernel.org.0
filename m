Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291F6430B1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 19:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiLESn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 13:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiLESnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 13:43:47 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989272FE
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 10:43:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gu23so637366ejb.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wAi9wb/ccr1V0J6asFIl7Azn5bhshYuD4nE6CW5xW+g=;
        b=OPVtqaGQfZNdZ4DF7z8NeObdT3sHluUFseqPw49KCbN+wqTHkRGDlCNAdrUqnU5qq6
         M/dZcdpbg6LMDtINPMHagxvEiD/e+KnOjJz+nt7H4s3lp1pprnp3qe4GMLa/QhYvpUQp
         yZVn5ofbBDCap0LFHONiDAaGYHExRbkxKOdis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAi9wb/ccr1V0J6asFIl7Azn5bhshYuD4nE6CW5xW+g=;
        b=T8aiQLWuS9dIcGixTDMA4S/eBlDDCg1Dds+cjWtTteLdMetDQIm175O3YnQX4jcsW3
         MTtNXNjpa03jZ48NQPkLoVTw2h7tarFW7Jo8ibEOwJwe17yxhRv5O1cj27Ed1Q6KMW46
         Za/0VyOSufZxM3JKM2bk3VHd/zpQU7Ycbp5R3G49qBRzfPlMKdET0NSrGIeOvtQn6lae
         OJ17QrFyBk4KODnxBU4jHCqIsTFhNDPDM2ijXBnJtWVEFBANgmGut74IfmxAjVfqnZHy
         Luzqe95NbG3FmfxYAG+Ww1AGCeMGuHS/VkjaWuKzq058TX+10SYJR723MopqexaaL/RM
         aqLw==
X-Gm-Message-State: ANoB5pmx/niU0sBx7bsDR6OmCVPQOmrBUIjhWuAmxsL77Yp65t47WEF/
        OIs7QArPYSiFFkQgOScSac0X70u4/y9se071
X-Google-Smtp-Source: AA0mqf5gAZuGInSVdgBCaS4KHJG72pCBcr9FHcpK62bkjkP1EPaX10NILCSDmRLDn9x0ucvts5Dfgw==
X-Received: by 2002:a17:907:2058:b0:7c1:5a5:f6c0 with SMTP id pg24-20020a170907205800b007c105a5f6c0mr1424088ejb.253.1670265824051;
        Mon, 05 Dec 2022 10:43:44 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id bv19-20020a170906b1d300b0077016f4c6d4sm6476516ejb.55.2022.12.05.10.43.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:43:41 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so6981719wmb.5
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 10:43:41 -0800 (PST)
X-Received: by 2002:a05:600c:4e4c:b0:3cf:87c6:890b with SMTP id
 e12-20020a05600c4e4c00b003cf87c6890bmr62524251wmq.194.1670265821267; Mon, 05
 Dec 2022 10:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <Y3FfhrgvBNey6T7V@sol.localdomain> <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
 <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
 <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
 <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
 <95ffac38780bf0ec6084cb354bfcb3b7bee686b9.camel@linux.ibm.com> <6f66f174af92a9b23bddd72945e94e888b0c9420.camel@linux.ibm.com>
In-Reply-To: <6f66f174af92a9b23bddd72945e94e888b0c9420.camel@linux.ibm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 5 Dec 2022 10:43:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft4wvxOZ4CS2hJzYANRNbCtYUznmsEE-3n4=EDx-+L_f9Q@mail.gmail.com>
Message-ID: <CAE=gft4wvxOZ4CS2hJzYANRNbCtYUznmsEE-3n4=EDx-+L_f9Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 2, 2022 at 1:03 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2022-11-14 at 13:00 -0500, James Bottomley wrote:
> > On Mon, 2022-11-14 at 09:43 -0800, Evan Green wrote:
> > > On Mon, Nov 14, 2022 at 8:56 AM James Bottomley
> > > <jejb@linux.ibm.com>
> > > wrote:
> > [...]
> > > > Of course, since openssl_tpm2_engine is the complete reference
> > > > implementation that means I'll have to add the creation PCRs
> > > > implementation to it ... unless you'd like to do it?
> > >
> > > I am willing to help as I'm the one making the mess. How does it
> > > sequence along with your draft submission (before, after,
> > > simultaneous)?
> >
> > At the moment, just send patches.  The openssl_tpm2_engine is
> > developed on a groups.io mailing list:
> >
> > https://groups.io/g/openssl-tpm2-engine/
> >
> > You need an IETF specific tool (xml2rfc) to build the rfc from the
> > xml, but it's available in most distros as python3-xml2rfc.  If you
> > don't want to learn the IETF XML I can help you code up the patch to
> > add that to the draft spec.
>
> Just as a heads up, the patch series implementing signed policy (and
> thus taking option [3]) is on the mailing list for review:
>
> https://groups.io/g/openssl-tpm2-engine/message/296
>
> With apologies for the awful lack of threading in the groups.io
> interface.
>
> So you don't have to build the RFC yourself, I published the proposed
> update on my website:
>
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
>
> If you want to use option [4] for the creation data, it's available.

Perfect, thanks James!
-Evan
