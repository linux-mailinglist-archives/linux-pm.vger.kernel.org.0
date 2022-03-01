Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F94C8B75
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 13:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiCAMWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 07:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiCAMWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 07:22:52 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524378AE7E
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 04:22:09 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f38so14958872ybi.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeU/XCqBauiiFbzw1sK2VEGHHTBe8GTbZd92Ok0rm8Q=;
        b=aACN6l+cOlMU/ZYfblRjGja0AsZrkNJeTifB0UdezOnHNNdWYD8WTIU2P4sKf4H/dW
         ohYxZ88yx1wns76H8TorEabi7MAMmC/1aWITw+6kzbEij03TmiChwTxluLq7RGdmsChe
         o8PPvs93sZ0dUuOn4B5sQl3QPQlQ0k2Y4F3GwfKj/DyX2Bap/6eJNwL58mlOAwdP6sa8
         yF4R7H/bjMtwUMNCChamFEIntllKv4FrwnQ/nFTpMFSr2BUvziG8kASqL27ITBrgqGZi
         8UHA6ch9L9xLqOG2A82pU7jMUCYpWZ1+UbttluKnxoxmySJo9Fwg8Ss50cQXI+OFpOJr
         hsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeU/XCqBauiiFbzw1sK2VEGHHTBe8GTbZd92Ok0rm8Q=;
        b=K4o7jBu7RdK6/eYsxOqdbiwkfg2Vzg6vFSdpe6PLnqzn1IiODEGT8m7P8qhX/RAjNH
         0h7zKCvUMUYIk7HRPBLMEFv16lSL/lrct5o3nszmGphR+qv1EjeOLv/xpsBvqnP4dpQ0
         qO05PCR4wfdgb7Go6af/5qMvoAvjfgBM+eJHkuDYz6akfnwAwhJjqI4IIT4hxq0nKib6
         dQxqMc6hvZ9z9xfZB8BZnzZLFYFGa9OsFivup19l8XG9jEcfFI4Y2nu/aowFfyfRJjgl
         c+77pivOI4sa0b9pR2xi+DKr5XCGCXRIAz6URlOvX8kq4ho5MZMXzz9u+YXgkG4GvuN4
         bbIA==
X-Gm-Message-State: AOAM530NaDasA6nJQymgkGqhnDYeyz5wLJ26NeqZm/4HqqqdV9JxzSJq
        8tt4OolBSoWQxVYK7zc9eyIO/3bj2F9kdkej4Eod1A==
X-Google-Smtp-Source: ABdhPJwXiI/nuKQ+OqDAQ4DKVmuZsUIPHwvnGQTDzTmtjPovp2Ie3kIvftk3xVMnUU+dyCCcmfGgZvRbScFKA+QM2Zs=
X-Received: by 2002:a25:aae2:0:b0:624:43f0:ec66 with SMTP id
 t89-20020a25aae2000000b0062443f0ec66mr22929352ybi.626.1646137328544; Tue, 01
 Mar 2022 04:22:08 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
In-Reply-To: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Mar 2022 13:21:57 +0100
Message-ID: <CACRpkdZfYh2Oyemvwkc0SCki_V-YBX21RFjT6ppCQdT-SPBs+A@mail.gmail.com>
Subject: Re: Question on expiring HRtimer in-kernel
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for top posting, the helpful autocomplete in gmail think Rohm Europe
is better to address than linux-pm@vger...

On Tue, Mar 1, 2022 at 1:19 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> I have a problem with a premature expiring HRtimer.
>
> The HRtimer hrtimer_set_expires_range() is used in two places in
> the upstream kernel:
> kernel/futex/core.c
> drivers/power/supply/ab8500_chargalg.c
>
> Now I am testing the code in the latter, and it has seen some
> bitrot since merged in 2012. Maybe it was correct at one point.
> The timer is started like this:
>
>     hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
> (...)
>     hrtimer_set_expires_range(&di->safety_timer,
>         ktime_set(timer_expiration * ONE_HOUR_IN_SECONDS, 0),
>         ktime_set(FIVE_MINUTES_IN_SECONDS, 0));
>     hrtimer_start_expires(&di->safety_timer, HRTIMER_MODE_REL);
>
> What the author wanted to achieve is a very definitive callback in one
> hour relative to now +/- 5 min, and that is one hour later in the
> physical world,
> as this deals with battery charging.
>
> However sometimes this fires almost immediately rather than in an hour.
>
> My first thought is to pass HRTIMER_MODE_REL also to init as
> hrtimer_set_expires_range() could make things happen immediately
> if we have ABS set, but this is all just intuitive.
>
> Any hints? Better ways to create a definitive event in one hour?
>
> Yours,
> Linus Walleij
