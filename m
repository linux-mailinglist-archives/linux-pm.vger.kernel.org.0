Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3795D2B0A39
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgKLQiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 11:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgKLQiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 11:38:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92888C0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 08:38:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l5so7002512edq.11
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 08:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wvi9SDQpkotexOK3zTDKmEDDoudYhTa0aiFc6BJxblY=;
        b=AIeg2+oAl6fNC/qe0Wb5iWTwMoQ3hMa9KNUse3RjC6NgcwHyZ4UGLVzcMD3s7duuDe
         wLc5KifIGv6kHtd0yupulDpHSJn8zsuzKyP26gWN5es9sMX9YlkM2kfYyUyilBVFSwBh
         QwSzkq26DzcJOOrC37eiju2QVaUHHq9nDjtq0Wy5EVhTHKM84VkoF0KTdjO7Oyt1+DjR
         Sf/wG/cX76OYTHfLX81imLzJJW8vArV3+XyZXqbFUJTnNVnBkj/EpYsSev7iUxmPfrnA
         G62LhC9FkklxjWiNxWxhRfxIbihtR7mIW3UHeRLkMhhYr8vr6teHoTmkmlRulwvCrJjP
         h38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wvi9SDQpkotexOK3zTDKmEDDoudYhTa0aiFc6BJxblY=;
        b=gN/DKMFlnI3hm0YSeqvJf5/LLOmzaOrmOAtjpvTXGS2GHv0WM9qFPw76Vk7QgrHXgS
         fZEVDXGE8V+Ne/lG4XiVB92fslgIitPssakAoFIZZZ7usaD3BgYK9T778aiQd1RV2Kt6
         rTEqbON92qHooqO/yTnlFySXmlIjkt9hSU2/8gN04xxdi8QMGL79ac6SuTYcruxh5EDz
         O06tz3BV5IU4RVfLIiJFq75Re3lvWpv6vBryueMPyWu81OCW7yAUMtmtHJ2Nqxd0UpbW
         w3aLRZggQseV3j5xe4TYsxSY6a7dvxkLfbsxddjG7tDclSW84Df2GbpFB3C2i+MkjN94
         5SbQ==
X-Gm-Message-State: AOAM532D5CAMNLNzP46A5Qtii/iDmEg/cet16IBpW9szhjGLhSCUo8Jm
        ZgJZ7+6SNpOthnBApSK37dvlqjAySmLkpfys7cFNtg==
X-Google-Smtp-Source: ABdhPJwjfqH6kVZVIYuxU1tZOvGSqeOcz/sPDQwcp2FOuHVkNNaGfW8m6KqyoZsTCRnttAGEi2O7+AoWhU/AVYUyRII=
X-Received: by 2002:aa7:d54f:: with SMTP id u15mr618477edr.239.1605199133164;
 Thu, 12 Nov 2020 08:38:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu+KK=hm1AmQ78GCCgQTwsRCzyA6WHYR68ozZBzp7USiA@mail.gmail.com>
In-Reply-To: <CA+G9fYu+KK=hm1AmQ78GCCgQTwsRCzyA6WHYR68ozZBzp7USiA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 12 Nov 2020 22:08:41 +0530
Message-ID: <CA+G9fYvokz+rXtQfgjHoPQGP+o+4DVOj4OPufKxVOBrCyEKXBQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 2 at kernel/workqueue.c:4762 workqueue_online_cpu
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>,
        jiangshanlai@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 10 Nov 2020 at 13:11, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> While running CPU hotplug testing on arm64 db410c device the following
> kernel warning
> noticed on linux stable-rc 4.19 branch. I did not bisect this problem yet.

As per the available data the reported issue started happening from 4.19.134
and which is happening intermittently and not found the last good commit.

- Naresh
