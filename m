Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B7437E65
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJVTPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhJVTP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 15:15:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E2C061225
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 12:13:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 204so2947362ljf.9
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=Wv8R9T10aobCrs3M+YmRan10VWCF8IcL93mBD4Pf53lVLMeWToKnlOMUFrNogXM3ds
         1y1qbj4mIWnXiy6yih2yRFJuy484nXKvol2id1K4zFAG/wJ5LRY9rMur7DD0N4cACwu/
         773pwmn74KsGp6Id34qu0eLBaOasLOkeN+3kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=fGtvTsltqyx6Pht3gly7WPXJzE5DaD3mqfXbHOq1bW6YfzIuy2mJAqcci3W0mpDezI
         MGCur9SvEEe/Ff8NjMBsYG9o4oxLCjO0Gb1ElXzoFD1nidhOUUUtcpiQNk2H7E5edd8S
         vr0G7WuAudGBrSn6XzX0E4mtR+zRRjgFZU7P+Dk6AqFStsibjZyj0lJ/RRrICMY+IYlq
         5gR2l1u6WFelFcdzTEWVKJ0Sct7fZ+KXOVB6poIt+g4NvpZhytWqGnJ2MENycwy3dXqR
         3YowRMh1dPB611y97PDfwwErx56vnx8NEaE1AOzx8Og++rGYbrSOrq296jvLOFVjFEJv
         p+ug==
X-Gm-Message-State: AOAM530c5HVCAQoBFQWfu6CAD/J8cmXxKqROs0/sTYG76Lu28FVMDbxT
        pi2qhDxzgukwccimUp8/pO/+H2uF1qOzhLgp
X-Google-Smtp-Source: ABdhPJyM0G1TgRB0xzWKxMQAE/yuCcj2DOKNCF14ntRF0qqxbKm2zr/b296NwG+1GIdI7nGH/6QtwQ==
X-Received: by 2002:a2e:3007:: with SMTP id w7mr1904395ljw.152.1634929978882;
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h6sm948487ljc.107.2021.10.22.12.12.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u5so1215766ljo.8
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr1839764ljm.191.1634929977783;
 Fri, 22 Oct 2021 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:12:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.15-rc7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 22, 2021 at 9:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix an ACPI tools build issue introduced recently when the minimal
>    stdarg.h was added (Miguel Bernal Marin).

Hmm. ACPI already has that odd ACPI_USE_BUILTIN_STDARG case in
acgcc.h, which ends up using _exactly_ the same macros as the
<linux/stdarg.h> implementation does, and is basically exactly the
same "minimal stdarg".

Ok, so the macro argument names are different, and there are
whitespace differences, but semantically identical.

So maybe the ACPI code could drop one or the other in favor of the
identical macros?

                 Linus
