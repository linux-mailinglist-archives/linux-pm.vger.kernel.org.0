Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F07290970
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409799AbgJPQNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:13:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45459 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409711AbgJPQNY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 12:13:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id f37so2850888otf.12;
        Fri, 16 Oct 2020 09:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPxHTzD8/iEuAZA1Yzf7Cm0jlzb7zJo79bF0l0zeZDY=;
        b=cGIBYihQDv0dazAJJWzUn06m4XgNn0zGfB0mMFln5Wq+3PKqiD2ZrblQQm6P224oJU
         MwsPHT17FI9EyeQg6L4xDX7kAy8AULdhgkW9rDGj4YkNQtMKBuAczdO4O+uAw6v93uu4
         vIrH8vO1aTWtmD671rjanPTLtU7bKwO2Dg3di7psfSp6rXa9uF4u7G1IYiH+Fzjvu8yP
         OXkIWLfkACnIo73wXof6iIpIKNCwRI95qFLTYGeARaR13Svn6aFBZC5QqQVs1BN0sY95
         pR4qVesIYiMKPKybOdr65h4AcYCQ/TKGEyog1s2SDzDO612jtBQN8l7i6FvbflsAwKQU
         Kajw==
X-Gm-Message-State: AOAM530WIYotap3r7bl5hJ/TL15k720P30Il1OqZYtKKrNDu7ac8dWyH
        47RqBeXEhrEKGOS6ym5pLshblw49q820Xzmhovc=
X-Google-Smtp-Source: ABdhPJwWFowQRtA3kR7/LGCeiMdlojlTu8g3NXr9PZ9lxOYAyL76FVxfg1wTtA9atqz+K9rY1/X5vuPG0S9/Lj7f46I=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3344092otk.260.1602864801772;
 Fri, 16 Oct 2020 09:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201015204722.18764-1-ilina@codeaurora.org> <CAJZ5v0ifjHRomAxEKTW5z+VEZLGeM5MN-NcRxUUgrFQvtB0seQ@mail.gmail.com>
 <20201016160724.GB16756@codeaurora.org>
In-Reply-To: <20201016160724.GB16756@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:13:10 +0200
Message-ID: <CAJZ5v0gBb91rFHne26zLrMPOKcHTmcDERBRLiPAuVJo+H6BAzA@mail.gmail.com>
Subject: Re: [PATCH v3] PM / Domains: enable domain idle state accounting
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 6:07 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Fri, Oct 16 2020 at 09:55 -0600, Rafael J. Wysocki wrote:
> >On Thu, Oct 15, 2020 at 10:47 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> To enable better debug of PM domains, let's keep a track of the success
> >> and rejections in entering each domain idle state.
> >>
> >> This statistics is exported in debugfs when reading the idle_states
> >> node, associated with each PM domain.
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >> Changes in v3:
> >>         - Rebased on top of mainline
> >
> >I still needed to rebase it to apply it to my tree, so please double
> >check the result in the bleeding-edge branch.
> >
> Okay, will rebase on that branch and post shortly.

No need, it's been applied already, just please check the result in
bleeding-edge.

Thanks!
