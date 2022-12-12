Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD764A9BB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiLLVtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 16:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiLLVtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 16:49:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EE1A045
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 13:49:24 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j16so10256007qtv.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm5LPHSgYM9xIUawQXpRV3gt1/XB5UGwiqZUgZf9G0=;
        b=LbrNyZXHaOXAy+bQv/etbIYZ6VZoVPUi2kRpqwN6E+F/8a9V2FyFOqw87rg8zkpx6A
         KWKB8da+Sp646sBYb4v/MUPjndRmHI+KOjVPKVdtrGt6fRTcp91l2koXjnApcd+mFyEJ
         Xc63/McYW91ONI2KZvYwCGQk+pFyjTkIyGNE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdm5LPHSgYM9xIUawQXpRV3gt1/XB5UGwiqZUgZf9G0=;
        b=U8Iomtw6axIci/VXc1yMsQVOT0/Ol8mut2+rj9hNN2+dcFB88/1FKABO2Z8/dBoiio
         vIA6H4OsPgDspjbQqRj4PEcmcwr/1JU4cajAJUxPXYp1u80aRgqQaQJc2DosB+5ul745
         zaiMPplmuVkleT350Q/uF7mxvVUYAPgUp/HSdB+1AG4yq/feoTFIs3LVvYMn+1sBF2oh
         KWyWycQS5txrNThJomyjOktuRMzmjFvC+hKpsND1tejNCTO0f0/h8z+Ds3BQXD5gpAxX
         jBYqx7mhM4uONo9GB6oufYFYqx9d1bSInHq8NaGmRmDZSoYULVKACU5XDrDWRp+Ual4G
         EcLg==
X-Gm-Message-State: ANoB5pnQ2skseLjtdFD1zVW4La2StEs0Z4x9xAayjQSjuI4LTwPcPtwO
        1m09zASdm5mnSKAf43EIzI70KN7ybLvX7j9j
X-Google-Smtp-Source: AA0mqf6rluRwrFVd/0Ly+bdcEpPTRvA+cx50WsHx61YJ3tdE4KQuUJmdiC8GlcBVP4ZMvjqTtb88RA==
X-Received: by 2002:ac8:6607:0:b0:3a6:a43a:8ba9 with SMTP id c7-20020ac86607000000b003a6a43a8ba9mr24206350qtp.3.1670881762685;
        Mon, 12 Dec 2022 13:49:22 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006fae7e6204bsm6514026qkb.108.2022.12.12.13.49.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 13:49:22 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id c14so9162527qvq.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 13:49:22 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr70612302qvp.129.1670881761832; Mon, 12
 Dec 2022 13:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 13:49:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
Message-ID: <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.2-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 12, 2022 at 9:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> I would really appreciate it if you please give me your recommendation
> regarding the extra thermal control material.  Would you like to
> receive a pull request with it later during this merge window, or
> would you prefer it to wait for the 6.3 one?

If you are happy with it, and feel like you can review it and get it
to me in a couple of days, then fine. But I really don't want to deal
with it after that point - I'm on the road over the weekend, and then
the week after that is xmas week. So at that point I'm solidly in the
"it can wait until next release..

            Linus
