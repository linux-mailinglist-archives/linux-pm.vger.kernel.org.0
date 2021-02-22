Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15157321E71
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 18:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhBVRqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 12:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhBVRqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 12:46:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CDC061786
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 09:45:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e8so21111686ljj.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZNyTfd7nEmv+pShZaPJz7a0abWIzHWs8Ubs4x96pL0=;
        b=Qmddt36uLRlJvP0NWVHc7Q1qsFp7aZYSa6RpBiY+6gzP1pNbGUfOor+3oTyHVV2CJU
         OeBIML9y9Npk6n9ttYD5G/VcljRzknXMC2S/W4ZEG4lzquP8r5A5qevSDimdNgvg2f+H
         uyvWz9zOVCyQBhBslydfDfhMBMeCebD6cX6kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZNyTfd7nEmv+pShZaPJz7a0abWIzHWs8Ubs4x96pL0=;
        b=ZPRxsXVV+Z9CA9dLqMO6ZyNLGEz1nUck2Shw3kMKlzooCatgFpP5/sqNg0NO7gcIoo
         UyYBFyOOwXkadpFcGIs5T3iTfhFsmoMJe+GeFcK0vw5b+WPcvpLrDawc+CgOKAF4NHsh
         HytUzXp9IxYfhJUkhCp46qu89bmrMQpo0ZKO+EzJFxOW/4lh/EDIPG9GA7BjgC4elGL8
         TTZnHB95vzt6tiRCmVVfct6Kvo61TSnZ2XMmM8dw1AUi1gXkR6iJfwhnA9Q4Y8lGs/tG
         mYtgqtol5R1Xw4An8epUs40e8kmHCwANhQOTBeW0J73wqGXXuADf88KiPporQMXDvkLp
         nygQ==
X-Gm-Message-State: AOAM532jPqS9ZCuP4kPcQS9giWcEX6SmR54eq/gHPrN+8Jv+sS1D/Ua2
        9HC1nLK/9bJZvffM61himCiHK4oT45HBIA==
X-Google-Smtp-Source: ABdhPJxsvvNtpHolhePwxfK9cyIxGTnKyyrHDfe02S8x8MeA1Xhnkm3d8xFHm0oVRKHcoTo4FEKndA==
X-Received: by 2002:a2e:a404:: with SMTP id p4mr9203157ljn.286.1614015910074;
        Mon, 22 Feb 2021 09:45:10 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v3sm921118lji.104.2021.02.22.09.45.09
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 09:45:09 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id g1so53995894ljj.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 09:45:09 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr15068444ljb.465.1614015908831;
 Mon, 22 Feb 2021 09:45:08 -0800 (PST)
MIME-Version: 1.0
References: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
In-Reply-To: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 09:44:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
Message-ID: <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.12-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 19, 2021 at 3:54 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Note a set of changes for the qcom adc driver rely on an immutable
> branch from the iio tree:

That part is fine, but what _isn't_ great is the merge commit message.

This is the message in its entirety:

   "Merge remote-tracking branch
'iio-thermal-5.11-rc1/ib-iio-thermal-5.11-rc1' into testing"

Notice how it doesn't say _anything_ useful.

Merges are commits, and they should have commit messages with
*explanation* the same way all regular commits should. In fact, they
generally should have *more* explanation, since they are fundamentally
more interesting and subtle than some one-liner obvious bug-fix.

So this all looks otherwise fine, and I like how you were clearly
aware of the whole cross-tree merge, and how you let me kn0ow about
it. I appreciate that part, and I've pulled your branch.

But I wanted to really take this moment to point out that merge
commits really should have messages explaining *why* and *what* got
merged. Not just the technical "I merged that tree".

           Linus
