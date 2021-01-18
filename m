Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42462F9AAE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbhARHkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 02:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732737AbhARHkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 02:40:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD9C061573
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:40:05 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e22so31030885iom.5
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lp1dLvmDKcZnq78QX2LN/+VB/27h9qkstT6wTs9Co/M=;
        b=AXZ+UDlpcUVEsr1TOs1+Iqx0klX2cAdzpP3vuabxAlMHqkNou+ncYiWVRL/qWHYdkS
         D540/f7A+/gEYYvK02O3creHTr8mi6VR+SEDwnS+77ry6iuFSYh5L+bgH7FRovbYoxV1
         Mj03oiMGy8ffCZymWsQZMeZ7jdIElyw/fb18Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lp1dLvmDKcZnq78QX2LN/+VB/27h9qkstT6wTs9Co/M=;
        b=RZGaBHH/l4YEAzQqCQ6t/4mdgpqnH+MPt1wvvIynltUyGB5ZlVy8qyz2+uKPAU9dhz
         104oMh3ut6RGQWL1vPMQCPyQW3x5Jc7uVhGE3ergYJitWWgCWeAxGMZwZEZ4BQuW06PO
         41rg4t5nurSf2kjGqa19upjBKayo+ENcFQgevI1hGYpAqSScEn5OhBqPWx2e5DPm4jAs
         eRYj/GO1ZSnrgGAfhvJubMqoqAj/Huitb5qevMFIY8CWs4SvLmgPfUcC4sDBoX+j+lLH
         UTaDCu+Fd48pftPKzhcbgnLvYLKEc+bjZMFwLY7O6gQ3+FGh5dY6ewEmGebuxh0GcEPC
         diGA==
X-Gm-Message-State: AOAM531r5Or97EEkW+FRPgMi5RDOMqZHle3IHl+yZDIUqXOn08bCXnHH
        JIPNgTQ8fgsigSjIBFb/gQUyb8DV2QifNxUKbl8lSw==
X-Google-Smtp-Source: ABdhPJzS19TeWXKY5zhmREk0OObzaydz6aI7NnZ95qAIssnLYXDmmu/hZNZDSxJISl7U9K9UQ59iqZCwFp6plnX6UoA=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr20187777ilv.308.1610955605358;
 Sun, 17 Jan 2021 23:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org> <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com> <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
In-Reply-To: <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 18 Jan 2021 15:39:39 +0800
Message-ID: <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
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

On Mon, Jan 18, 2021 at 3:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-21, 15:21, Hsin-Yi Wang wrote:
> > Do you still have plans to push this? I've tested on mt8183 cci with:
>
> I was never able to get Saravana to test this, if you are interested
> in this stuff then I can rebase this and resend and we can see if it
> works.
>

Thanks. I can test this with the mt8183-cci series.

> --
> viresh
