Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128A14B8F0D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiBPRVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 12:21:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiBPRVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 12:21:48 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0547F22B05
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:21:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d7so293966ilf.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jieIWT6FT4bLoUaa3Mb3Usj/bynv3zx0Z4wW8RvTfsk=;
        b=O+gPJszUY4gMydUN6T17bxf9YrJsSN2JGPvPYspIkDcDT6xa/cBHSZoZM3DleEqYoO
         SU5sA/uVXJze9UFXNyyOYK78aO8P5OzXOpxkQa8+jZXwy3JmFa9GytjwiKAIlnZ4dRBF
         pwiPmlf/pazGRyp9nnaB7FUPUgMl97ZRLkyYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jieIWT6FT4bLoUaa3Mb3Usj/bynv3zx0Z4wW8RvTfsk=;
        b=JyHU7IfDURyUkqdP5yety22CIcw/1YtuT9tu+XIsmZ4sRRn6BlpDgW5NXmW6InWMlM
         iMwMN/laY0K7Txe7J4o8ZQ0Awiv4XGt7WSdRIpWiRHmkv41luC/bnVIJayxS7ywenyci
         hzzrdWGwKlPG7+7yfwoN2WmM+DvTq/9YKJkHo4t+6+VG9ibS22LPx1e2pKSPDH9+3Mr6
         prJJojRr/cT9OaQ7nD079THVundIhSkudZu7T08nxi8x2Fth1sjosnPlI9Vwq2aT48ib
         rf0EyAyTsBgS/W1MjITxjtXMMG1n+wfqPLR8TVMuu0Iz5igR6AhG1O7bgUwyTDciS4TR
         FTNQ==
X-Gm-Message-State: AOAM531d2KBsYUgZGuDuiJp3oTOi4aClSwWH/F3ZZNW4fHrxGMbhKMfO
        xRQtBAGDDvcrjVVYJOmytCwUt7K1gdJiSQ==
X-Google-Smtp-Source: ABdhPJwXck97nVlwPUwJKwIlfzt67TDk/sB3x9nYPoSL8ruqo3+bdR8O5e4za8Y7pUunontHoZiWzg==
X-Received: by 2002:a92:cdaf:0:b0:2bf:53d7:d37b with SMTP id g15-20020a92cdaf000000b002bf53d7d37bmr2388547ild.300.1645032094238;
        Wed, 16 Feb 2022 09:21:34 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id j14sm187386ilk.38.2022.02.16.09.21.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 09:21:32 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id y20so528867iod.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:21:32 -0800 (PST)
X-Received: by 2002:a05:6638:25cf:b0:314:5652:b95d with SMTP id
 u15-20020a05663825cf00b003145652b95dmr2344965jat.207.1645032091709; Wed, 16
 Feb 2022 09:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20220207073036.14901-1-lukasz.luba@arm.com> <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com> <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
In-Reply-To: <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Feb 2022 09:21:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
Message-ID: <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Feb 8, 2022 at 1:32 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> >    Another important thing is the consistent scale of the power values
> >    provided by the cooling devices. All of the cooling devices in a single
> >    thermal zone should have power values reported either in milli-Watts
> >    or scaled to the same 'abstract scale'.
>
> This can change. We have removed the userspace governor from kernel
> recently. The trend is to implement thermal policy in FW. Dealing with
> some intermediate configurations are causing complicated design, support
> of the algorithm logic is also more complex.

One thing that didn't get addressed is the whole "The trend is to
implement thermal policy in FW". I'm not sure I can get on board with
that trend. IMO "moving to FW" isn't a super great trend. FW is harder
to update than kernel and trying to keep it in sync with the kernel
isn't wonderful. Unless something _has_ to be in FW I personally
prefer it to be in the kernel.

...although now that I re-read this, I'm not sure which firmware you
might be talking about. Is this the AP firmware, or some companion
chip / coprocessor? Even so, I'd still rather see things done in the
kernel when possible...

-Doug
