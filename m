Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BA23E5FB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHGCoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 22:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGCoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 22:44:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC8C061575
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 19:44:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so212997lfe.10
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p73U8e1ovm8Oc1EqA5iQZyfM2pjvXY3OFxbeoRQJG2I=;
        b=KLp1Ds8eG5JRlnSSwdEN+OnGNAs7kXb02mDvWX8rcYTRjEvSHW36G9/e6bxOrVCPde
         s7tb1TfadHk6CAR9hQzubkDScrM6Pld2nYc6tZGNyuCsQQUXlsgFZXGodc1jpkDiCprO
         2e9Jun2EFHdByneIomAeVOp02/+vpN3r8tCN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p73U8e1ovm8Oc1EqA5iQZyfM2pjvXY3OFxbeoRQJG2I=;
        b=V7xBKRJ+ozu59TNN6nBUXvd4tND4WH13WFW8bgT0F5UgRSd00dCUFKdHHeThQCoAMe
         pPppmP2Y9OhWc1L5Kkkgym9XH2DVxMarlTG9nNdYMDKlSyp/LWJHkrBPY20JMU2xDf71
         G4CPQnpVafSLSdRR4dZFDDF5pdkMRwjQ36SGqRuRv4ytXAtgGGOE27Ig3LLSLBzBNBgt
         Fif9/IodgBihRsPnVE2p3Esn0t775PdWLYVwJ0lCHhrJxJmhdXJJGYtgGdhxVqsraH+d
         JvDNbz0ybq+fvplc958vjKHr/mxAkk5Z7UYn3tQuhlKJBTfYFqLRC8FCK3SRqTp3FqdL
         4pdQ==
X-Gm-Message-State: AOAM530KWqPgRL6LxQ2IufxOVqhzs2KhQL7r2Y4M+PCCqN+Sa/WY34fg
        Yw4zyCvmqgogF6WmWJHlc5Q4sG0ry5k=
X-Google-Smtp-Source: ABdhPJyXBGXq/sheMRtI5sfxRHXpNsBHnBeOefBHFKIzAkWqHPWmWcpAFIAIwjaLIAB8aHF1KP4tHg==
X-Received: by 2002:a19:c3d0:: with SMTP id t199mr5184095lff.56.1596768253678;
        Thu, 06 Aug 2020 19:44:13 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z15sm3845716lfg.81.2020.08.06.19.44.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 19:44:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i10so593693ljn.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 19:44:11 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr3024241ljp.312.1596768251568;
 Thu, 06 Aug 2020 19:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
In-Reply-To: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 19:43:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Message-ID: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
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

On Thu, Aug 6, 2020 at 1:19 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> - Add generic netlink support for userspace notifications: events,
> temperature
>   and discovery commands (Daniel Lezcano)

This is "default y".

Why?

The help text doesn't explain either.

Please explain, or remove the default y. We don't add new features and
then try to force people to use them by enabling them by default.

"default y" is mainly for when something unconditional gets split up
and becomes conditional (so now "default y" means that you don't break
peoples setups when they don't even know what it is).

Alternatively, "default y" is for things that are make peoples lives
immeasurably better somehow, and it would be a crime to not enable it
because it's _so_ wonderful.

So far, I'm not convinced we've ever hit that second case.

Convince me that the thermal layer is so magical that it really
warrants it. Tell me why and how my life is improved by enabling it.

             Linus
