Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BEC6A76EB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCAWkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAWkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 17:40:21 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A54FA8B
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 14:40:19 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o8so9327685ilt.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P9KlPRdN24U2nZifrh47RGztoR1RSBxdmlJs02laf8=;
        b=d4/myq9vduzzfqGKUrqatHviSOUeyfGXpmI1wLVtbkU4eLFrheTw9Jay/aWkkAqcIQ
         lrVJ1ygEX23dReHZKRse+tyC0N0jsJPrhKg+ZPVMerXand+RXspxh0OSYNmmhGbSaoRU
         jDGcG8u2dBXbZc7ICYCAadTkuohw55nv0o54s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P9KlPRdN24U2nZifrh47RGztoR1RSBxdmlJs02laf8=;
        b=udI75c93XOow5DFsNdhTrDKjE0pL2aOoy8ofSabNIgYLAa2FB61hz8XwYp700R+DxG
         NIeyGgHGQvf99htT3fXElbJHL03tYX1eUVSdq5jU1jG2Et6JQfY6NVMGGGW0nj/hgEMt
         ekwgQtS6GBWtJ8yl8DHUx53iZE0IbkRrLNirk52spIQsEXSYWujO0kI8dBtV9I2EsBqI
         OA4JEVVb6ax7E4xeCHMqKbqq4FahVW6Bvi+EzldMoR707VcxRhjNAcBkPxYuMs8yhlXr
         RnMlMmYKPlDw5L2mYvE5vUP4f/ncS/VHnt2pZwLZHyCAFyysawNd6RnddL/y6bTWaK+x
         aaww==
X-Gm-Message-State: AO0yUKXr1xPsXLLgoXZLTiRhApkUg/4VBew5CSFmyOR5sLkRYZyy8dAm
        7DFx/R/z6A0EIpaM5ZkMUyE74aTJ49kmfPYn
X-Google-Smtp-Source: AK7set+emvRdJRUNLFepEJ2xLUJJi+tLpzPrYtVx5jx54+M4erHqvKxGL9JPaUZqBdjkZRwKZ2l/CQ==
X-Received: by 2002:a05:6e02:1ba8:b0:316:ed77:df8f with SMTP id n8-20020a056e021ba800b00316ed77df8fmr7335830ili.7.1677710418398;
        Wed, 01 Mar 2023 14:40:18 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id p3-20020a056e02104300b003157696c04esm3971954ilj.46.2023.03.01.14.40.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 14:40:17 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id g6so6015467iov.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 14:40:17 -0800 (PST)
X-Received: by 2002:a5d:8919:0:b0:74a:f35:ca88 with SMTP id
 b25-20020a5d8919000000b0074a0f35ca88mr3594955ion.2.1677710416683; Wed, 01 Mar
 2023 14:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org> <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
 <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
 <CAD=FV=WG1v4U5iQirG=-ECZFtXE=hwL=oY+6zjsu6TWCiBX=QA@mail.gmail.com> <20230220171550.43a3h56gznfc3gec@ripper>
In-Reply-To: <20230220171550.43a3h56gznfc3gec@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Mar 2023 14:40:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UmbBOPAg6d-G=XpEyf0Sk=dmrp7wuthn1Cx+DmB1gvGQ@mail.gmail.com>
Message-ID: <CAD=FV=UmbBOPAg6d-G=XpEyf0Sk=dmrp7wuthn1Cx+DmB1gvGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 9:12=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> > I suspect that here we'll have to agree to disagree. IMO it's a
> > non-goal to expect hardware to work for which there is no driver. So
> > making the backlight work without a backlight driver isn't really
> > something we should strive for.
> >
>
> Without trying to make you agree ;)
>
> How can you differentiate between "the driver wasn't built" and "the
> driver isn't yet available"?

BTW, when I was responding to Saravana's series [1], I realized that
you _can_ differentiate between these two cases, at least from a
practical point of view. Specifically, when the
"deferred_probe_timeout" expires then you should assume that "the
driver wasn't built". Said another way, once the
"deferred_probe_timeout" expires then you should assume that the
driver won't be available in the future. While you still could try
loading it, in general once that timeout has expired the kernel has
made decisions (like making -EPROBE_DEFER non-retriable) that make it
very awkward to load new drivers.

Of course, one could say "hey, let's get rid of the
deferred_probe_timeout". That might be a tough sell unless you can
come up with an equivalent solution for those currently using this
feature.

[1] https://lore.kernel.org/r/CAD=3DFV=3DXQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgy=
Zc5JCzvOtw@mail.gmail.com


> Consider the case where I boot my laptop, I have some set of builtin
> drivers, some set of drivers in the ramdisk and some set of drivers in
> the root filesystem.
>
> In the event that something goes wrong mounting the rootfs, I will now
> be in the ramdisk console. Given the current timer-based disabling of
> regulators, I have ~25 seconds to solve my problem before the backlight
> goes blank.

I personally don't love the timeout. It feels like the kind of thing
that userspace knows and should be able to tell the kernel. I know we
don't like to put impositions on userspace, but userspace is pretty
definitely involved in things like loading modules. It just makes
sense (in my mind) for userspace to say when it's done and all modules
for cold-plugged devices have been loaded...

-Doug
