Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A493C29513A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503292AbgJUQ7L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503290AbgJUQ7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 12:59:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69187C0613CE;
        Wed, 21 Oct 2020 09:59:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so3362566wma.4;
        Wed, 21 Oct 2020 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOAwZaaZ/beDzvPjh4DfLLmuqS+BF1EdS0841cgpzLs=;
        b=KrcsCvPHQglJCf7oeEF5m7FV7XdFHt9x7F3gW8Rhm9Z1S0QRti2sdPhJRUd8nmCeIQ
         3nz8sdNk6BgUkY8f1F5JlMV1K0uL8nFfwxgu05ZF+h8mNRaCen+I8fHu2qwMEhXuoHxQ
         JTFVDgrFTd80wy7wECZ8QX6wcnuGl9kt13IUQGXxcIPJSeOsOY5kwp/AW1iyvLdjBvlE
         jfDbRMYRgpFMEECXiY7u070ca2FPFZbUC3+HpA7VTRRHbRF3eJzCfaBym6LyQzle5fXa
         WaSBCbwTh+MoUYuuOsfK7FkiK03/r7t6PaZbFWgBBPbVE14yW1uU1GbLQtr2syg0vJUc
         CNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOAwZaaZ/beDzvPjh4DfLLmuqS+BF1EdS0841cgpzLs=;
        b=iB2R1K7JXYlyT2k9TSrEiHIWv31cg2SFk9Fplt7alzw4/P8ChSTbzQA75brvk9ErSn
         PnOv6TtX5z4NhY93SfeEYo55a7ly55Ls4HVQV0xW1ZG2goEVnOZv15sllXJ4g7vo6/QL
         C9XNBTN0hXzjFiKPlMSI6RC4UdMEr4juLhAw2/Gq2aL1Q25KFULuWXIHmVtPYRAQMcn5
         7q0dPJ2mhcI9lcnG8uKa/9JrC4nfEx9v+t3Xg1S71F+cVWuL9DLzUQMGTG5yGEQ1Oi64
         0PjFlVI3ST5Sw5uYphgkLBHf0L4oXXX1By3SzF8Yya+niz8OBtjnLyCumzvkWRnUezGk
         2Rpw==
X-Gm-Message-State: AOAM530AO6RkDHjpSdp4iBjwlqTp6kM/Umw0TprW4tM0qn/Dvie65xdK
        Kq1FqsO+IzgUTzneUiPxHMLCtrW9bYcNrqtoa0Y=
X-Google-Smtp-Source: ABdhPJwu3PAB+EK3ul320vHDvWKoXxQTAQwJyBX44XCUJZtWcWL6PCNBwIxZExqEpwyJy/GoRVJba0GldZXaq6LR/GQ=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr4787948wmm.49.1603299549106;
 Wed, 21 Oct 2020 09:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598594714.git.viresh.kumar@linaro.org> <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
 <20201005062633.ejpehkpeuwksrx3e@vireshk-i7> <20201021072404.y43tjzd2ehclrejp@vireshk-i7>
In-Reply-To: <20201021072404.y43tjzd2ehclrejp@vireshk-i7>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 21 Oct 2020 09:58:57 -0700
Message-ID: <CAF6AEGvAK_mAxJB32vvPOD3jumpYprRtUBPT8GRBV8gty7fxFQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 21, 2020 at 12:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-10-20, 11:56, Viresh Kumar wrote:
> > On 28-08-20, 11:37, Viresh Kumar wrote:
> > > dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> > > find the OPP table with error -ENODEV (i.e. OPP table not present for
> > > the device). And we can call dev_pm_opp_of_remove_table()
> > > unconditionally here.
> > >
> > > While at it, also create a label to put clkname.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Can someone please apply this and the other drm patch (2/8) ?
>
> Rob/Rajendra, can someone please have a look at these patches ?

Oh, sorry I missed that, could someone re-send it and CC
freedreno@lists.freedesktop.org so it shows up in patchworks.. that is
more reliable counting on me to not overlook something in my mail

BR,
-R
