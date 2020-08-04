Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6323B341
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgHDD0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 23:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgHDD0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 23:26:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2BC06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 20:26:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so7177223ljn.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0S6wIAy1k59MLOMeNhD5yQSuBj8TSGhfKg4AV6YzCM=;
        b=OvtZm4PLaQk00qzBS8G2+CcWXHzF7p+t/BFg7YcpEJNiKuxwZWP3j06xIQl0nuLvLU
         FdxWptleTj2pfi3DR8NOqN6gSSYUlakIoh2i3lqBiFIDc4S3iAjOs0OdbtcArIUX/v/T
         KURRMaRIqrf0qth5ixscu9IDOTHWWXxEqGC/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0S6wIAy1k59MLOMeNhD5yQSuBj8TSGhfKg4AV6YzCM=;
        b=GSC7QGUXFdfaG/Oh6S63d1lsxc5SZDx0iOUShYxIEdN1HxKxu+1NQ8JMx15YOy1C2x
         5iooF6wT+OqUZiSan0cfsP1u2ORsqqNRaHS/zOOR1Zaj4d+9e8ncs9y4Hn1VVkrawl+l
         9l6M16mkWKnh/m1G8DOcpIHfUh6PoZGwjq1hHu/gKqmsleNGmZKaOS6iP8RRdY7C6ZSb
         6H/2R9/+kRv+r9YTpCe4/Wgu+JLyeesKfYLjigfZxe4mgI2m3Hr99kkxz5Ug7SNov+x7
         sAq9FrgF4KD6dtvCdUcjOaNUgfIP84a4XzbL/hL0udQS5V0a26sEgKPgu006YlBiLVhW
         0muw==
X-Gm-Message-State: AOAM530bAso/L6oJ7jkbRWocP39m4KvonsEjPKhD7m6REwv6W+tWMAFu
        ehEJ7AigW++o9buvm1qkfdoL4+zoOG0=
X-Google-Smtp-Source: ABdhPJwWLCI+rhiU+W/xM4gtIs2A3uf9+HBhEFqlF0LPd9Wizlbl8C1TV06egVsS/3wcUsIXoe8Faw==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr8811797ljy.399.1596511578987;
        Mon, 03 Aug 2020 20:26:18 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q20sm2285714ljj.42.2020.08.03.20.26.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 20:26:18 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id w14so12101571ljj.4
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 20:26:17 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr9565590ljf.285.1596511577146;
 Mon, 03 Aug 2020 20:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
In-Reply-To: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 20:26:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
Message-ID: <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.9-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 3, 2020 at 2:44 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.9-rc1

This was all rebased just an hour before you sent it to me.

Why?

Maybe it's how you commonly work, and I just haven't noticed before,
but it's wrong for all the reasons I've stated about a million times
now.

What makes it so hard for people to understand? What makes that "you
sent me a completely untested pull request and that's not ok" so
difficult a concept to get?

And dammit, if you do it and have a good reason to do this despite
literally *decades* of me telling people not to do that, and why it's
wrong, then  you can spend the five minutes *explaining* why you do
something that is widely documented to be bad.

These commits sure as hell weren't in linux-next either.

                   Linus
