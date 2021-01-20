Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A12FC559
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 01:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbhATAH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbhATAHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 19:07:22 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE9C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 16:06:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k132so10622045ybf.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPds4149Ii9ZN0uT6CUuEhZc+NUZK0Fbq1Fvt2T7erE=;
        b=FyG+VhVd8j8mIriGM+ZjsD2t4gLyQSPBycqtpE2rEEGNF2DnG9J5V34zlFD83PWtbl
         aibtFeThs5VI22jiR+Btbkyu8OFdSkW2Q7sKcfEqx7giim20GPvzZE92NS+1J+4Qrc5A
         Q13JT1r5wrwkMtzfPlunHkr5F449q3WqYbmp1ZLCuGbznkVi6YSGqLk1WAspOtnnNZJh
         tYRvnbVfaxEzrHx25xoFYXOFxb0pU7qQ1PbGIz4+lo8HGBMSK5arX3EL9is4tRin50/3
         8KRXdQoEAllNn8Geyu4Ff54sd/DWUndxQaEr8R4Q3+JLdeEH7fRa3yuevOA+oO1+4Zpy
         HR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPds4149Ii9ZN0uT6CUuEhZc+NUZK0Fbq1Fvt2T7erE=;
        b=kykYZrXZwvqa1MUfZCKsaMEdywBa/FueaDYjY7jGw1bs4sCHQNYabwBVeyBdJcJAjD
         EhurQbaEH3COt4qgjFVAU4q8NL7XJ5NRMVDoZ72UMSAcKChC/hbBvW+MRzpmWnqtnCXP
         jdD86vZiFitxxyInCOsPHwjDokBCjgWEWf4fY+r9GMW3CcstJFlHkXfI4npKpVAlWcE5
         vzbCPYjREhRyxUP7svg8f6rfSl+3d12KX6RCEzR2TuhJVx6viaDikllouYl6uAhLliji
         bnJf+xOC+tx23TjKXFSucRTn6TmtDAiIwnSD+p0McNG6GvJchaGtZwcX7J83oKvlj2BE
         nV1A==
X-Gm-Message-State: AOAM532W/4Q6sOziYanmgE+yArXYCSPtSTebvh9qQAsIJ+kNN/tOAyw7
        yoC6CA7VeRazn+16GY6uUw6DQG1FfbLrRO9avxKZnA==
X-Google-Smtp-Source: ABdhPJwXrFPX2kf1mS4F5MWV0Diby2MtGPN9/zapoN4VRfuwOy8R7cKXeIestXLk3lbQFIizBfUWrNUhbynB9sbc4JU=
X-Received: by 2002:a25:b703:: with SMTP id t3mr10549313ybj.96.1611101191670;
 Tue, 19 Jan 2021 16:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org> <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
 <20210118073430.a6lr3ynkd2duv34l@vireshk-i7> <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
In-Reply-To: <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 Jan 2021 16:05:55 -0800
Message-ID: <CAGETcx80vQroV+HX0ppRN+apYVzOoKaxyrqMjCPfuQ5z16q0wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 17, 2021 at 11:40 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Mon, Jan 18, 2021 at 3:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-01-21, 15:21, Hsin-Yi Wang wrote:
> > > Do you still have plans to push this? I've tested on mt8183 cci with:
> >
> > I was never able to get Saravana to test this, if you are interested
> > in this stuff then I can rebase this and resend and we can see if it
> > works.
> >

Yeah, got caught up with some other work. Sorry Viresh.

>
> Thanks. I can test this with the mt8183-cci series.

Thanks Hsin-Yi for offering to test this.

-Saravana
