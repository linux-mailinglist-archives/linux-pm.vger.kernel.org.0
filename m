Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3399A546CCE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbiFJS4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350378AbiFJS4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 14:56:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0422C3687
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 11:56:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d14so63467eda.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tu0fTzyqzrDJCvJGCoSzfL+uIt2SiB12w9Df3WqdSV0=;
        b=ILPRMvLcgdxn/DJNTX08x1h2h3sgKMyHcZtrB0IEbwm4hz9uSYatcWVJtnDpcfS8IX
         3UNkjqU2QEwLI2xDs2BoFuu81wU+NJ5abcvTGRNZQxPzK87bsS1K1mXl7M2rpkSsPfAi
         kLRW+sbic7AqBlS8DWLRz/s978b5Hu1HTvHwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tu0fTzyqzrDJCvJGCoSzfL+uIt2SiB12w9Df3WqdSV0=;
        b=r49C3LrtMDravNFKlb6xfZkGZINV1Zz8pf9Smeq4kr69ZZfFUMiUPk8dR9bnv+xejJ
         sNWGhbyK9Isd3vp5zlBIA2uydmmBYMB88pCRjNu3wAetJ6XXX0BtES7qpI6AiykrZTKX
         Hnkc0hDNTYCtayCStTfTadLs4YFj2qVOz3oCSjifbZ+yBDW6udpew6lgVsiIW4m0QASC
         dHaWlvVV22ljSNM7s/9q5mZ9Y9aK3C7eA9sQ3EhjwN0DHMsgGs0csxM/TvpJX+UesM3W
         Yb/w8er6rJqEy7EfuP6pbPewapbZajS5SCh53FI9YrEslTXXC5fL9yRaALauk1LbxaoE
         Zpcw==
X-Gm-Message-State: AOAM530OCpdLfakNrs8zvOh4nrMyKxopPhODnGAQ+j6sdHCZMYUmXWEW
        BiIiARJr7wNCa8UnUBM9IR4XOtH90QGilXvNPnk=
X-Google-Smtp-Source: ABdhPJwM1NKOtjrC++hy7kMO+8PxnX/HErN3t8e1nsf2P91RrMnp4nUstkyPlhIaDQhw8HZrdlaSIg==
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id b14-20020a056402350e00b0042fb2c19393mr42463560edd.11.1654887367206;
        Fri, 10 Jun 2022 11:56:07 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id i9-20020a05640242c900b0042dce73168csm27379edc.13.2022.06.10.11.56.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:56:06 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so98471wmz.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 11:56:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr1123490wmq.8.1654887366093; Fri, 10 Jun
 2022 11:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
 <CAJZ5v0i-BD=00qDK_mZ1=BF3DJeGA5CPLV+tUpEd2iEz0YHmsw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-BD=00qDK_mZ1=BF3DJeGA5CPLV+tUpEd2iEz0YHmsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 11:55:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whN=JSrmOGURKTXZLjn=dwmhXw1_BfWazNA6-idK1mVqg@mail.gmail.com>
Message-ID: <CAHk-=whN=JSrmOGURKTXZLjn=dwmhXw1_BfWazNA6-idK1mVqg@mail.gmail.com>
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 10, 2022 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Fri, Jun 10, 2022 at 8:47 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> =
wrote:
>
> This was sent from my personal e-mail address again, hopefully that's
> not a problem.

Not a problem, the signature on the tag clarifies this.

It meant that I initially copied your name as "Rafa=C5=82", but then I had
this dim memory that you at some point said you actually preferred the
kernel using the Westernized "Rafael" that you use in your kernel.org
emails (and in your sign-offs), so I ended up editing that up.

But just so you know - I randomly copy the names either from the email
or from the signature block depending on the phase of the moon, and if
you use your personal email you might end up being "Rafa=C5=82 Wysocki" as
a result..

                Linus
