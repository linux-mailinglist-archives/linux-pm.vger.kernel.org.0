Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962C82E885A
	for <lists+linux-pm@lfdr.de>; Sat,  2 Jan 2021 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhABT5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 14:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbhABT5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2021 14:57:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C7C0613C1
        for <linux-pm@vger.kernel.org>; Sat,  2 Jan 2021 11:56:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y19so54698081lfa.13
        for <linux-pm@vger.kernel.org>; Sat, 02 Jan 2021 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE+VAh0BTaBdR4cAH/pHpELHZjB0ILoKk6QrjLdeBTo=;
        b=hWgFCOcZcvb5hSCxT56O0m20hBRbZtMDA3QiLFzkAjGbnRnP5lrZYAR6+4/H5sUQUc
         t1PwylJ1YTO4rGnGh56Pb2fvxyB+ykr7oa5g9tFabW2wnFYngIVild8e+0FgJwqvRwIa
         Y5zHyqWeTY1W0XwqStOrf20Oir8tAS01IP434=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE+VAh0BTaBdR4cAH/pHpELHZjB0ILoKk6QrjLdeBTo=;
        b=CP2NpYQR62Ygoz8aasaFvFIjxKLom+l4CXGmT+H5zrwCNJhjqpflDmDs67t+0iA9TG
         utECvc2uWolMpBA85HkrZzyeia1TZMpeRovwSIYoDHoSpASjI/o++Ij3sGrBTFXKVHwh
         JJ35ctmN1GxeM/ndN/+su+DyOA+364qkVA0tWSqZAizM60H8F6EmvX0eEu96g+rZlkPT
         VKV6l7msbhkmrW3xlygI92CY1UIawpb86jcwxMidZ3DaAge3I36NKhV1A9mpQ7jeA6s4
         uJiK6oLnue/4yHuSRV6YpuMBCDrs7M8LeV/KhATODyy0d8H0EeSosRt3eT3Ww4a0knsz
         icjA==
X-Gm-Message-State: AOAM5315VRUPfVa2BtvL/4OOpkHI5lnVAA3Wt2u5TM0/cwvnr8NbEwMU
        ezGkrqePQmp8/8KMIuOMZoQ3kzLVNd0LpQ==
X-Google-Smtp-Source: ABdhPJxlFcB0MGTQ3USKf90mK47CKPI4EmWPQQpNdgEdDuA61NlWwNwcV7eewwsHJlDqa4BseZ8Hvg==
X-Received: by 2002:a19:3806:: with SMTP id f6mr31043056lfa.242.1609617383635;
        Sat, 02 Jan 2021 11:56:23 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x2sm6828747lff.207.2021.01.02.11.56.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 11:56:23 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so54811194lfg.10
        for <linux-pm@vger.kernel.org>; Sat, 02 Jan 2021 11:56:22 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr31301149ljm.507.1609617382520;
 Sat, 02 Jan 2021 11:56:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Jan 2021 11:56:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHbmzJO4NTsk=_pChcdXYP7bjNFmYhKR4Lh4-iKN-soA@mail.gmail.com>
Message-ID: <CAHk-=wjHbmzJO4NTsk=_pChcdXYP7bjNFmYhKR4Lh4-iKN-soA@mail.gmail.com>
Subject: Re: [GIT PULL][Resend] Power management updates for v5.11-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 2, 2021 at 1:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These fix a crash in intel_pstate during resume from suspend-to-RAM
> that may occur after recent changes and two resource leaks in error
> paths in the operating performance points (OPP) framework, add a new
> C-states table to intel_idle and update the cpuidle MAINTAINERS entry
> to cover the governors too.

Thanks.

Note that I might have been willing to pull your bigger request too,
because thie merge window was obviously somewhat truncated, and the
rc2 week has been very very quiet because of the whole xmas and new
year thing.

But I would _really_ have wanted the explanations up-front about why
new features came in after the merge window.

And admittedly I do prefer it this way,

               Linus
