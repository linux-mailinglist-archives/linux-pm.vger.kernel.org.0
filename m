Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A92D7F43
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 20:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392806AbgLKTQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 14:16:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40700 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392722AbgLKTQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 14:16:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id j12so9214009ota.7;
        Fri, 11 Dec 2020 11:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xb5kc10vkM8dae1+GQbeQe8Yxiquajq/zv40ysf09E=;
        b=ODJcj02Sj32x6hXbgLFmm0J67l3vXWF8DTOZLH9mynvidEfBjO26K571owfnW8AJ/1
         6HBKi2FSPXBLUPtrFUiQgm0iif0kX4chGE6FmP8gvgj9mzGXM73kWuJs5QFheGq5UPw3
         ZJwQ3E9rFkBCxq8+i5xVzQTZVw2LTQpjtE0U5bcGgnb8fIASP24cLbktIWvvPzXF4s2S
         xc4nwHTRj/QwhlG2Ic8wjAIenJJNmStRvD4XWS+lvonkEHd/EM9eJDck4syE4eAnq5tc
         xPAreOlzArgqJ/fFyIruYgcRiyemKUNNHQiqG3GPQWschVaGWK/NwgBUXKT/qWOhY7qJ
         Z/xw==
X-Gm-Message-State: AOAM532nyy/njTx4cYddee8C6rswk6i5GhvNusn6wd5OkLixbSHmKicI
        jwyxekY/ypYGi/ITH0ZhjFuIEdV4jV6choorQew=
X-Google-Smtp-Source: ABdhPJzRDR6GG3eZV2qJ1AJS21py7Hw4lkBANMjZcns4OwLpfEx7tM60fIIZ2oMaPhpOXxAR29Z/OEYTHKMjtO9wNfs=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr9220961ota.260.1607714165855;
 Fri, 11 Dec 2020 11:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20201208164145.19493-1-daniel.lezcano@linaro.org> <ba9c6f75-3964-3ee9-c849-17db5ae51501@linaro.org>
In-Reply-To: <ba9c6f75-3964-3ee9-c849-17db5ae51501@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Dec 2020 20:15:54 +0100
Message-ID: <CAJZ5v0infKumCmn77nzAN80G4bmF+_ZzgGkdaeMvczC_VyjyGg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 11:41 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> I believe I took into account all the comments, do you think it is
> possible to merge this series ?

It should be, unless more changes are requested.

I will be taking care of it next week and, if all goes well, it should
be possible to push it during the second half of the merge window.

Thanks!
