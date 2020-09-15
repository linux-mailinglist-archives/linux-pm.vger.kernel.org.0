Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008C26AC18
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgIOSgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgIOSg2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 14:36:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAEEC06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 11:36:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so4189675lfl.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zoHbkMZFFhAGDLD6+oRaQAq0ZiYfkwGQ2rEJMY8yX0=;
        b=f1T9mNnu6S7dphLok7aD+ocpHnqQmx7NNA4OT7K8lwQBOq9Xw1nXpHsEd1Dk3wFWJB
         54MeFRG6bYhxz2+mBnevnCkrNt7WaN0r85esfwMhDLdkpbP7TSVT6+1YqLtIKRtHLhNH
         nPbQEGok1fA0j7AygUwMDGUHt3GRZIZ7lIxTWdVu+wxvvcsVoUmV7P9hBIcGQTY7mdvv
         eEs9z432gLG8QWQ2TRp0Lm3x/IcE7/Rz8XJzh0et9cLYjEm7etRjLEkSFfXwwG0weRBJ
         7gcEdYRVj5pyDc/uvU5rErejQqgiwa5I7FsjPnUx+HC9+M7LTAYZJZjqYSLdwDRN4M7T
         5ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zoHbkMZFFhAGDLD6+oRaQAq0ZiYfkwGQ2rEJMY8yX0=;
        b=q1hBfH+3y5TIKCJGHBZGrUaEGoOfho5J/vBX0ZQhiVXVG3iqv1nI2wgSOMqMNxFY7a
         lzIFkkhsbnN3zRzxW7SGpOq8FSZVhMjDcKbxg8oT6xkN5xUUuFejiMyZDb39lJjvz41E
         +BEYUF2/1j0kLZJXS3rACIApG2KYfNbllDXDW7SADjI77FfcMn7jU5ZpTDFZMuebTOfk
         WuSSMvIQDHjQzdcb0b7sYvcd/r9aZEdPSt23WsXlMBGEGWbzxY4CIDl+CcOLPid+L9Hf
         jBI5M0thrtWiiMduObhp1JYD9ER8+6IYV9fVitF7u/HsMtsHL/M5FhTRq0H1j+5PX3h6
         FU8A==
X-Gm-Message-State: AOAM531imhExJa0CuNwMQ6N4/B1tjrH2EkChCxcZtH9BuDUeSF8BWpFt
        5z2/Kg0ixbSPl2Fa1cfwT5e5w0L+bqM+KeUikflqzQ==
X-Google-Smtp-Source: ABdhPJxPRpIb3Z3FDCHy2rc8ihRoSisSIyjn1j13LORsg2VWCauuLLlokK2U412Qi098EJrS+PhYXwW9R7T3BkqZ724=
X-Received: by 2002:ac2:511c:: with SMTP id q28mr6128023lfb.411.1600194985320;
 Tue, 15 Sep 2020 11:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com> <20200915182730.GW14436@zn.tnic>
In-Reply-To: <20200915182730.GW14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 11:36:13 -0700
Message-ID: <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27 AM Borislav Petkov <bp@alien8.de> wrote:
> > I believe the kernel makes a questionable assumption on how clang
> > uses registers (gs will not be used if stack protection is disabled).
> > Both kernel and clang behaves unfortunate here.
>
> If the kernel is at fault here and this same thing happens with GCC,
> sure, but this is a clang-specific fix.

This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
(maybe some more registers) before "jmp restore_processor_state".

Regards,
Roman.
