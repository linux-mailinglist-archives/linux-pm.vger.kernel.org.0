Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073442F9A6D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 08:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbhARHXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 02:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbhARHXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 02:23:07 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF1C061575
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:22:26 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w18so31008187iot.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK2Uk6nXhuZCzlt00zwjkdQRevtTzU05tpGbVxLJ6ao=;
        b=UegXOHZTJSTiww7wd2FJffN1N01VLLcsHb28vxNh93VaYKTqvn4aXVP/tWC7+8qTrd
         U1XlmwOAYU5bvAecgtubtW3CXsPakUhSd4mIVRGUDDe2LjkX9htpO6OFK0ZzWzuYncvp
         Yb0vXA03Mjxrsx9besnUObZ3XK0WqRNxPTOeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK2Uk6nXhuZCzlt00zwjkdQRevtTzU05tpGbVxLJ6ao=;
        b=D4FZwKnzHcT85Cc6feYcGaLTeZUBIiWbrF/avI8MyVZtm+qsD6hGNphhTcmrHN97Uf
         V3LBD1UTPC+8X0CH+b3pwOInWqWhN1PmAWr+Rl2JJxyrFmO97zAJ8q2y4lijmT9sUMoe
         gkYIIBQ8z3FbQpR9Hcd+zC7Qtdlw48nZbeNKMddn+KmTJ76L53Qb78knxs/nIWWd2EGn
         uyCus+irdB8Bi65GszsAYTy+ZDr8bcFXLbeHGweW8860Z9xWAhEQnq1oR+7V299KuUMz
         itUUwWBdqLdPz9V0Q9gFzfNRJy2/9nEIv6fuECSvm2PlsdKmyzN0JZsff8x22s/oi7yp
         1MQg==
X-Gm-Message-State: AOAM531pCbIAUBEeMjuU18xa+TyQ0Wr/bduRoWrpQZk+Y++n+cxMFQ19
        oNzY3XQmcuJ6/JY37q62UOdDs7ErTYdIagTVxB8VFQ==
X-Google-Smtp-Source: ABdhPJy8hW+k8dY0Z11ZlJ/Da53ypr2ffvz6Xxmn232BYZcHkvYiQDtcD3m+FhNFrV+E3carWfNsr36oKvW463w+WQs=
X-Received: by 2002:a02:a498:: with SMTP id d24mr18775197jam.4.1610954545480;
 Sun, 17 Jan 2021 23:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org> <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
In-Reply-To: <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 18 Jan 2021 15:21:59 +0800
Message-ID: <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
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

On Thu, Jan 30, 2020 at 12:21 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-01-20, 19:04, Sibi Sankar wrote:
> > I don't have a gen-pd use case to test against but with the is_genpd
> > check removed it works as expected when I used it against this
> > series: https://patchwork.kernel.org/cover/11353185/
> >
> > In the lazy_link_required_opps fn shouldn't we skip the dynamic
> > opps in the the opp list?
>
> Tables with dynamic OPPs should not be there in pending_opp_tables
> list and so that function shall never get called for them.
>
> > With ^^ addressed:
> > Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> > Tested-by: Sibi Sankar <sibis@codeaurora.org>
>
> Thanks Sibi.
>
> @Saravana: Can you please give your feedback as well? I don't want to
> push something that may end up breaking something else :)
>

Hi Viresh and Saravana,

Do you still have plans to push this? I've tested on mt8183 cci with:

1. [v4,0/5] Add required-opps support to devfreq passive gov
(https://patchwork.kernel.org/project/linux-pm/cover/20190724014222.110767-1-saravanak@google.com/):
patch 2, 4, 5

2. opp: Allow lazy-linking of required-opps
(https://patchwork.kernel.org/project/linux-pm/patch/20190717222340.137578-4-saravanak@google.com/#23020727),
with minor diff to let non genpd use required-opp as well:
@@ -474,13 +474,6 @@ static void lazy_link_required_opp_table(struct
opp_table *required_opp_table)
        struct device_node *required_np, *opp_np, *required_table_np;
        int i, ret;

-       /*
-        * We only support genpd's OPPs in the "required-opps" for now,
-        * as we don't know much about other cases.
-        */
-       if (!required_opp_table->is_genpd)
-               return;
-
        mutex_lock(&opp_table_lock);

        list_for_each_entry_safe(opp_table, temp, &pending_opp_tables,
pending) {

3. PM / devfreq: Add cpu based scaling support to passive_governor and
mt8183 cci, cpufreq series
(https://patchwork.kernel.org/project/linux-mediatek/cover/1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com/)

Thanks

> --
> viresh
