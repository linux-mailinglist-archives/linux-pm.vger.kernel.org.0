Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8189A26AB4A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIOR6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgIOR5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:57:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FEFC061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:57:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z19so4077878lfr.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zC/SbxYzkjp6OcGCx+rUfTP966C1m59d2H5efDgrVWA=;
        b=gOM8yiiLag62BKZvBU1Ld3EaS+uEABdHMAHOQYXp4gYgK6MWnEoBDMAH46BUf5TmB+
         TeiK1flI2V9KV9iTOku256yuojEHjYQL/SAkqm8hwmwq348GzbP3X55WgpJgFyA65Dwa
         edcbkgZ7rYAClxokvf5Qgc9mIXDGstbDigyxRjuqO7KfNRieXo/v1P7K4TScxYmUoSs/
         P5aQPFH6A9jxovWESXl9bVN6Ub7fP+bQIlsS7BGzFm5YRBD0C9sMWEkCH4yqIaNadUgv
         YKZB3sxoc01LhnoKnY5chFTddDEGyKupJziTRTxccKqSUBlHJWEQp9W6um13MiR3jbSm
         I+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zC/SbxYzkjp6OcGCx+rUfTP966C1m59d2H5efDgrVWA=;
        b=aqsl9Ss6Lk74zF568bUS3EsxZMIyMDswQfEgPVp+Lg2JIgSdAXsk3PXOR7xeoR4nAY
         dPi5WzrQWB4oG7dazFTNRANDADzZHP+5EMwb/MMMnYFHPwi5kcxQ2V1HMIR4KhYeJMpP
         S4cxCRLQTOHBQACfIXWagvQ6BOVvLByHn99QQ2qdMOJqfdUxZ30f2KaJbEM71Hkmu3yd
         k3d9TyQT+5+twa8hTvt26uaOEaGW7syYPnn6dUC1pGbTSQ5lR/EOYFCG/aiiiKCJClmR
         qqibWZL8cGgKDCn/oqLqJCXGAZYONjyz7vgnE78B0RZkJc/BnedEjFmXKdmECAUc1unn
         utqQ==
X-Gm-Message-State: AOAM532ka2e7qbLQ1UbMUA7s4rdOh1g8IWLPXD1V7OevyVZbeoQs2vDH
        r1weNVqHtShseEbzU0ZS2ksXfapx6zci9Aothzdf+Q==
X-Google-Smtp-Source: ABdhPJxiAfjaIb5OwsUu7wWgQQUH27aiEppISRg5ojFfZ2j3xreHT6y4fAfiPh/OE+XTn7Y+z1CPhpz3d5Jsez3n8n4=
X-Received: by 2002:ac2:511c:: with SMTP id q28mr6086175lfb.411.1600192647744;
 Tue, 15 Sep 2020 10:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
In-Reply-To: <20200915174643.GT14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 10:57:16 -0700
Message-ID: <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:

Hi Borislav, thank you for a quick response.

> Ok, google guys, pls make sure you Cc LKML too as this is where *all*
> patches and discussions are archived. Adding it now to Cc.

Thank you, I did not know this.

> Ok, so why is the kernel supposed to take yet another ugly workaround
> because there's a bug in the compiler?

I believe the kernel makes a questionable assumption on how clang
uses registers (gs will not be used if stack protection is disabled).
Both kernel and clang behaves unfortunate here.

> disable LTO

CFI depends on LTO.
