Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801C31A473
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 19:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhBLSUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 13:20:32 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38615 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhBLSUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 13:20:19 -0500
Received: by mail-oi1-f176.google.com with SMTP id h6so592351oie.5
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 10:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qniHPk/1CE5Dyn73p25mgrPyhAmrHa9TfgFAtGea62s=;
        b=sGNFiKKKqSeFjXMEfqNzVWlW1lzSFxMWdGFYrEPuFAsyAOF1+7WRtd9ik+WCfX+lnP
         XrhJjttDDs3eTBwdVMqzTyDIesmXajgcXbK/UUJeUzkuqFLl1cel5fATyB8j6RhkDFQ2
         8b0LFHGxERKE3sJnWd+UA0KRiFk/LtLNr4ud70K23ncR/HkYlWQnyADozas9XuabU3xx
         nKIKa7ejDLEQg4v97U7hVpuZ+OSev0QKhDbSJ3Mb7ioswd2jZdDenyLUA86H0qwsRobz
         drGbuV1VTlgWT5huG9ePyc3rcbhQkfP6DlvPTUzJAAiggkFH51x/ZO9idFjUMHKGtD4l
         5i3Q==
X-Gm-Message-State: AOAM531RV635b+EVbB+hTJy6+c2y6RmbfOo7i37xcfFg5pxcfOSzo6uW
        ek5rQInpF732RjfdKsnpBh+ahqeLa77ycFpmBqM=
X-Google-Smtp-Source: ABdhPJyqEL2+ARB7rpx0u6dB1VoaGQZnOWGLa5NVVqjc5Hmt8z7tXvhwcOYN9tHFCMLfpfryJsSzFDLLLsD3pZi0/XY=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr485116oij.69.1613153978558;
 Fri, 12 Feb 2021 10:19:38 -0800 (PST)
MIME-Version: 1.0
References: <bug-211305-137361@https.bugzilla.kernel.org/> <bug-211305-137361-xxZGwJzw8e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211305-137361-xxZGwJzw8e@https.bugzilla.kernel.org/>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 19:19:27 +0100
Message-ID: <CAJZ5v0hWurgg=tMudRopuLkruAwoELOB0KMXF5VPf9K+PLYAhg@mail.gmail.com>
Subject: Re: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
To:     bugzilla-daemon@bugzilla.kernel.org,
        Matt McDonald <gardotd426@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 12, 2021 at 6:29 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=211305
>
> Matt McDonald (gardotd426@gmail.com) changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |gardotd426@gmail.com
>
> --- Comment #6 from Matt McDonald (gardotd426@gmail.com) ---
> So, the replacement patch from Rafael causes Zen 3 frequency reporting to be
> ALL jacked up.
>
> Before the patch, core frequencies in /proc/cpuinfo as well as using tools like
> nmon seemed accurate. After testing Rafael's patch, my core frequencies are all
> up around 6 GHz (!), and even external tools like Geekbench report my 5800X's
> BASE clock as 6.0 GHz (https://browser.geekbench.com/v5/cpu/6466982)
>
> I'm sure this isn't intended behavior.

If the reported frequencies are like that all the time, then it isn't.

What is there in scaling_cur_freq in sysfs if the system is idle?

> The patch was merged like yesterday into
> the mainline kernel, so should I file an actual bug report?

It doesn't particularly matter, because I have seen this comment from you.
