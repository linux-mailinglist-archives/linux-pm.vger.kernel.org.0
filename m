Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF5126448
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSOI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:08:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36235 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSOI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 09:08:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5769755wma.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uR6rr15BRHMymaEFYOUXLS9zgKBwEyVcNbBJdvAbQc=;
        b=Bb/L/S4fYQHASJ/GdXo2WT5fJmxkJwntmSjTgOnG3+zZcI5Inm1M4YpVkMBVINC447
         IfX53PW8aolujo8C+oDe/WQFZRBFDvSSCKxuoilufndGobxRIW13C55Ls5EsvTlumWkt
         TfifHFX7AHMgDG+dyhSfhxm1eZBrN1Hmc833PZ61Euvt+gNSx0IIDmTwGkQs46ZLu0D/
         jSL89fr1i82fYvyLu+cUse8kyKakmF77ARE/ml9D0Nlay0nXVacdn1Ad9UbEDfqe4rit
         xBGhucfXL1oHToSnyCoemqSuD4qER98uHVsb0376+D30EMWxDw9T+w9iyC0Kj8LdjVBz
         wmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uR6rr15BRHMymaEFYOUXLS9zgKBwEyVcNbBJdvAbQc=;
        b=c6qmxZPUCwgbbqCqono6tKP7vxlWSntZy/mdRpZWzWfbTK3WuoNV9W2WUfZK/44rAc
         XOeYvg8w9zCZNeQB+PL+EthXZMY8uaY1NhUr7ELmzenLBEc2NVObO17kPUPV9VWwo5ht
         SBTwipGyvyNZ94aFYzUnS4Ij+YOsmQQW87h++7n5WiBjv/7ZmApAZJIomacHi8qP1Nal
         hzboNAuxAisre8+qmVvtYUmPy1+sw0N7Gunsg6HhCtVJ8DErzGlfMAct3BYekEn6pxrY
         49+eTTjGbqv80XIDCgI7sUqTDd+7MGXKcY8mCwZqlLu5AOAnxw/1rFdnYMt0JjyA8gAY
         lwig==
X-Gm-Message-State: APjAAAVENir3GOSo+9nw9NrM+yCPxwPOvs4CUtQjw+NOMwmG4hDK9Gjv
        i+gFknR/3X3UJIL6J9/BtZZn5GlMSRzB9I0XeCo=
X-Google-Smtp-Source: APXvYqwzp9AGIa8WY6Dkv+xFw3jIexVWORQiJf5K1b78kyjD9mbfmE8s22yFWllpEuzfJdDbiazXoE8m0qNUg95Ryjk=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr10734150wmc.30.1576764536436;
 Thu, 19 Dec 2019 06:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com> <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
In-Reply-To: <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Dec 2019 09:08:44 -0500
Message-ID: <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 16, 2019 at 4:00 AM Daniel Drake <drake@endlessm.com> wrote:
>
> Hi Alex,
>
> On Mon, Nov 25, 2019 at 1:17 PM Daniel Drake <drake@endlessm.com> wrote:
> > Unfortunately not. The original issue still exists (dead gfx after
> > resume from s2idle) and also when I trigger execution of the suspend
> > or runtime suspend routines the power usage increases around 1.5W as
> > before.
> >
> > Have you confirmed that amdgpu s2idle is working on platforms you have in hand?
>
> Any further ideas here? Or any workarounds that you would consider?

I think there may be some AMD specific handling needed in
drivers/acpi/sleep.c.  My understanding from reading the modern
standby documents from MS is that each vendor needs to provide a
platform specific PEP driver.  I'm not sure how much of that current
code is Intel specific or not.

Alex

>
> This platform has been rather tricky but all of the other problems are
> now solved:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f897e60a12f0b9146357780d317879bce2a877dc
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21b8adbd475dba19ac2086d3306327b4a297418
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406857f773b082bc88edfd24967facf4ed07ac85
> https://patchwork.kernel.org/patch/11263477/
>
> amdgpu is the only breakage left before Linux can be shipped on this
> family of products.
>
> Thanks
> Daniel
