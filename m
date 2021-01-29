Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47561308C3A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhA2SOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhA2SO0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 13:14:26 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EEC061574
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u4so10001265ljh.6
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=KC10zSx5MFsfUUjYlG6FRCOeTyTcwX7GVvNaLYrrrt8YFffoMdY92Rh01gJr6XlSmY
         4I2StG06IDQKqqKiAqu88gHc4seS5CORwF959YMHVWmCmchm1b7Bn3A7fg/tBq+MM9y4
         8yDFzSkj9aLzlG6YxJyYupJOThB0naFT27zWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=IOnOFDoKrhYPLsmCG4zX9BIXD5X0ESiR9n56u4ikO9IuIaCTMoXZJ+oYgGHKnEde6s
         rmy3tx1hTMIiDyx0jBZyr2v/cCsEKquIqf9amEJ6Pi7VRxeriCQxd/J705Ifca4D16bI
         7zExpO4ir8hvoStOAa1FWb+OlhapLDBNNxb183f+QBLLL18WWbslKV+GGdXbHOdVb8xX
         HuWniKbrM+pQqGoSeZgYORXV3Z0JndgfANJQik5midlgSx4KGbTnj5ruOaQ6669DSGLj
         KkStoF4KARe+OUVjAQYthRP1Ut+ADm6eJjox7bTI/Esq7RxHUQ9wCt41XWmHuB298Ki3
         uEAQ==
X-Gm-Message-State: AOAM532Kcc51GrLJnI3A6eRm3E6ICPamGopb13HhWrf+4YBRjHLCF2Kt
        9PXuvz4UcAXG5yeS/ST6KoU3fxxj4bHA+A==
X-Google-Smtp-Source: ABdhPJyFXW7rVL+peAPJwtVClX1e5/9Krrd1cmPyWCA1gW0vlAj/dYFeS8OGreCEL/B4SXh8uHR0xA==
X-Received: by 2002:a2e:804d:: with SMTP id p13mr2953742ljg.177.1611944011686;
        Fri, 29 Jan 2021 10:13:31 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y3sm2630820ljc.131.2021.01.29.10.13.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:13:31 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v24so13743541lfr.7
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 10:13:30 -0800 (PST)
X-Received: by 2002:ac2:5502:: with SMTP id j2mr2617310lfk.421.1611944010487;
 Fri, 29 Jan 2021 10:13:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 10:13:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Subject: Re: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 29, 2021 at 10:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [Resending, because it hasn't made it to the mailing lists, not sure why.]

I see it, and I see the cc to the list, so it is likely something
about the list being slow or subtly broken.

There was another pull request a couple of days ago that apparently
had the same problem (and didn't get a pr-tracker-bot reply due to
it). I forget which one.

               Linus
