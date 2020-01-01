Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5803D12E0A3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgAAWCU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 17:02:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32794 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgAAWCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 17:02:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so33649755qto.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jan 2020 14:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSAH0evlJoolUg87ShH4FeC0OktYI7yfMEPySwsd/b8=;
        b=kNzFC2zq2jVyayEiCm2cd4o0F6BR7IlP8Va+bVQKPiq/CEhUeqyqRItdtQoNOM4ewm
         OWAW2zqenChAUlMr8pqkFnGY8EolCxcaa/Wfm3cpTQGDVZIBY+rn3TkbxTTmInYhAU40
         l8zNu6g/OYnIDwixdm652WnyoqomC3BOJJkTGP3tV9eAxu82KAegfKZwpJv4Sytu2Rq9
         1MPmZ4+F9KdzZL9J1I054nt7y2qb3YAvAfr3lgUoGocdtqU6zbZpjaj4e5C7BVzanMcu
         j/5taaEkYhzkrZy+JS3gdQH+yuQ7WIZ0qXTNpdqkCL1caM7yXWG9HJkBLjEU2IlmvK/n
         JWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSAH0evlJoolUg87ShH4FeC0OktYI7yfMEPySwsd/b8=;
        b=SGPzXGmt6V/06GzjiSCONxPOh41qAmxYFxWu0OCAE0OBd/HPdCeqjiNgBgb9beHPqv
         fDafGBSGEACsw29PoyCl0VDa9NGYDtGuJmnFFwxtTH6C9MroDkX07yQijHaDfdQ6Yg89
         G8/0kiGz0v2WGzjwkgii1jIgAa/mrso2qg8N/MLMW6sRg8BjFLbeGzFRdTn8oxhExPDA
         +r04leHSwCfkTfCkeUUDLXyw8js6TzxgUv9R8p2Zs15x1dxeMK1bWXldQsbp767i4Iy0
         IgK7K3Ly/3QPXvqfg13NuP8YNN1E8P02oiL7R9DHTjBygDPBFRHP7J/Ytbt2Xq+UKIIY
         PlPg==
X-Gm-Message-State: APjAAAUM5gPm+Dj8tgnSwy78rlytUw+rgMJuURZ3QJCY+XiWqM3ivAC2
        csmMy5wdzu+A4v5iITcvlwvkE2Oko+ugLS0irKV8Lg==
X-Google-Smtp-Source: APXvYqx29giRIfb/J5Ll9wzRWiEijGwOJsbRuTySE2FESqx85g1GgxWW5fjeubtW4Lpvwq624vg1S5WejKNLgJ6xyjA=
X-Received: by 2002:aed:2584:: with SMTP id x4mr59867591qtc.343.1577916136881;
 Wed, 01 Jan 2020 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576146898.git.amit.kucheria@linaro.org>
 <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
 <be07b05d-421f-35a7-0582-a04a226c8c2c@linaro.org> <CAHLCerMYkEBs7HfYV0WNfypNPCRBEeU3w7ye=4+VxiiXVZT9GQ@mail.gmail.com>
 <5458f285-ec7e-0dc6-ab61-e5d05c76f013@linaro.org>
In-Reply-To: <5458f285-ec7e-0dc6-ab61-e5d05c76f013@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 2 Jan 2020 03:32:05 +0530
Message-ID: <CAP245DV+x-Lpo-SyyzZbK3AVSHkpFpWKSKPngxgLGTwdNxHANg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: thermal: tsens: Work with old DTBs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Olof Johansson <olof@lixom.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 2, 2020 at 3:14 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/01/2020 22:15, Amit Kucheria wrote:
> > On Mon, Dec 16, 2019 at 2:58 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 12/12/2019 11:38, Amit Kucheria wrote:
> >>> In order for the old DTBs to continue working, the new interrupt code
> >>> must not return an error if interrupts are not defined. Don't return an
> >>> error in case of -ENXIO.
> >>>
> >>> Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> >>> Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> >>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >>
> >> Applied.
> >
> > Hi Daniel,
> >
> > I haven't seen this fix until -rc4. Do you plan to send it?
>
> Hi Amit,
>
> right, I've put it in the thermal/linux-next branch. I'll move it to
> thermal/fixes and send a PR tomorrow.

Thanks.
