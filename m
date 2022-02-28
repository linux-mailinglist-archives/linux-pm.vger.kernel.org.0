Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F304C79A4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Feb 2022 21:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiB1UEs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 15:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiB1UEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 15:04:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BB4665E
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 12:04:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so27137416ejc.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uod9R4vPcpqIjzHofeC96qXcIXUlGW+U5alvKq7K0ZA=;
        b=Y+K+LAchMzIcesbCiqrzhisJgvbUIKYh3oFG/AlZJTKul1K9rRfHylHsN/EgM8hdwz
         P3hABFpC0Wcw+/0V4cKR5X0P787Wy9QwMeL5ORY50P9+oNZqmMp6NkFq4yV6NAIkP79C
         0bvk8ZnwfFSPqzKfD7Qqea+fs2YLRTaNcLanw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uod9R4vPcpqIjzHofeC96qXcIXUlGW+U5alvKq7K0ZA=;
        b=YH9qziNlBGakMx1Pd3jWNivruBcgsr1K3QsQ3KmMtva06wZlRhUMoIuDqqFEkwnA6W
         hbYdEOP35/rB+McYC8j+2j6QYNjYUUTWZFuB/laznnLrTHjmK/6YFyxZFSgJCpyk/x83
         P3mI4FGm9uk0W4na+At58CZJWmKByVPHQ+EQDiG4bsdyKBiV0osHA2SPd2ATUxFBjvaE
         9O2HXjlvV3JQqx0majq7bCg97U/8j1nuUoDxF6FWRA7L2sYa1czXFAHeRuu6LVl6Ko91
         WbZtd7FuPyledey7ZRjUSvifC/vhaC8Dbl1lZhIh4fQT8zuei2ce/Khn/MjFPfNUWajj
         ChVw==
X-Gm-Message-State: AOAM530HQaWM7yy6NdcdCbCuNEOeEuRCz6As3wZANVyn2jvEjSOZpR9G
        diPfu+QkzROunUGYycRXn0WLDqv9kVW2O4MdEQs=
X-Google-Smtp-Source: ABdhPJyMhY0Rh2KEBYtzOS2UIjG2dNgh8OC/6Zdu2sKNwdHXKV+1nI+tMuDtOvELC70s1xkQGL2lzw==
X-Received: by 2002:a17:906:b2c6:b0:6a9:4bc4:2ec2 with SMTP id cf6-20020a170906b2c600b006a94bc42ec2mr16631120ejb.718.1646078643387;
        Mon, 28 Feb 2022 12:04:03 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id hz20-20020a1709072cf400b006d1b5df5c1fsm4668864ejc.17.2022.02.28.12.04.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:04:01 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id d3so17214397wrf.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 12:04:01 -0800 (PST)
X-Received: by 2002:ac2:44a4:0:b0:445:8fc5:a12a with SMTP id
 c4-20020ac244a4000000b004458fc5a12amr7653619lfm.27.1646078630855; Mon, 28 Feb
 2022 12:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
In-Reply-To: <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 12:03:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
Message-ID: <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 28, 2022 at 11:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do wish we could actually poison the 'pos' value after the loop
> somehow - but clearly the "might be uninitialized" I was hoping for
> isn't the way to do it.

Side note: we do need *some* way to do it.

Because if we make that change, and only set it to another pointer
when not the head, then we very much change the semantics of
"list_for_each_head()". The "list was empty" case would now exit with
'pos' not set at all (or set to NULL if we add that). Or it would be
set to the last entry.

And regardless, that means that all the

        if (pos == head)

kinds of checks after the loop would be fundamentally broken.

Darn. I really hoped for (and naively expected) that we could actually
have the compiler warn about the use-after-loop case. That whole
"compiler will now complain about bad use" was integral to my clever
plan to use the C99 feature of declaring the iterator inside the loop.

But my "clever plan" was apparently some ACME-level Wile E. Coyote sh*t.

Darn.

                   Linus
