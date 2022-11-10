Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AB62382A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Nov 2022 01:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiKJAaS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 19:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKJAaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 19:30:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2612633
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 16:30:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so1122256ejb.8
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2022 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=QPh+dXTNNNqvMpbHZ+zyyruTS5AtCQvm6jcqLL2W9v+PwLC7vDe3logqFmZD94dYSP
         j6gODfcUUWJDTpUyk8hmXXMbo328Gv/iEL/11fF5vrLy0rJupS7Hu5DJ6Kbwjs4Fqbwx
         alPJToOLgsVzSGLZWe/LaiY8wv+0RY0qSb1+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=XZudbdHxsKxSFPhVVq1vzLyk/XMwvXF4fLLK7BMV40Op5v1LRaoVFWJmCxPkl/DN1o
         HCpljq/Vk9/KNv1SVj8CBKGEV0+ydD6Hr9FxDnLoKaYLOpjUMwMvp4kBM6oUioIpB5/K
         wdWiANRb5+19sqX6OfcX3zUvc+WwHaGIz9GndysNAp7aFUSNhV6XfZ1WQAM8cCt2uAuo
         zRPrM9l7jm/594a/urHO6dgQYh4zZac9FKZXubYI9RHgo9LGJz6a/gaHNM0tVmWXVA+p
         e8FzFnHlm0I13A4wsADSoWmTsw4R0alax4ZgvVisWt8I7ELFHLMQ75kfoo21l5RkDjkp
         BAZw==
X-Gm-Message-State: ACrzQf3dwMsbtVlcOrcag/iTCh4CpXCvgmind/L0i+od/mPLReMQ+Fwm
        ZmDadcNnsAsBAZP3xeJ3yzBY979x2z8Kuw==
X-Google-Smtp-Source: AMsMyM71ZvxnVEGoyVrf/Mnxv+5jVSV6WSCBpX1Ajmto45bM6QaCb4TmhwtNxxpqxGy0huBk4ZFY3g==
X-Received: by 2002:a17:907:703:b0:78e:25be:5455 with SMTP id xb3-20020a170907070300b0078e25be5455mr56935277ejb.630.1668040213714;
        Wed, 09 Nov 2022 16:30:13 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0078d22b0bcf2sm6511762ejz.168.2022.11.09.16.30.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:30:12 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id l14so158632wrw.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2022 16:30:12 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr41571850wrz.450.1668040212003; Wed, 09
 Nov 2022 16:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <202211041135.EAC889BA08@keescook>
In-Reply-To: <202211041135.EAC889BA08@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PM: hibernate: Add kernel-based encryption
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Nov 4, 2022 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:15AM -0700, Evan Green wrote:
> > [...]
> > +config ENCRYPTED_HIBERNATION
> > +     bool "Encryption support for userspace snapshots"
> > +     depends on HIBERNATION_SNAPSHOT_DEV
> > +     depends on CRYPTO_AEAD2=y
> > +     default n
>
> "default n" is the, err, default, so this line can be left out.
>
> If someone more familiar with the crypto pieces can review the rest,
> that would be good. :)

Eric and I emailed briefly about it a couple weeks ago, he said he
would try to take a look when he could. I'm optimistic.

-Evan

>
> --
> Kees Cook
