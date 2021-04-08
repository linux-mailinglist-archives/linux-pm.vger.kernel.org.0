Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D6358B5A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhDHR2q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:28:46 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40862 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhDHR2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:28:42 -0400
Received: by mail-ot1-f46.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so3051599otb.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFxfofckR+xJjPfRTF1dAqAqmYnNKAadcXq/0MJsC3w=;
        b=osRteitUzqDwpsyoyShROog8cuy7S1bD91KfJNnARYOJ+HgXNw8N8Nm+wSw8YazlPo
         sQW+u2Nke5fg9kkhEC97JTaNA5kjA0V+E+D8Jxnrl6+US08znZfPbCNU2yQzoqeQn3HR
         v6zZNTKlqlc0r+cwRu2S6ps09ECeyzjtrfH+wCz4qaCGv0RDY9UYF8Ydfg8AohvmWqy/
         eF/VBbW7jHdAht4/VVWqZpb3a+T68PJLucfBmbw4TfpFAv9CkUcPkHcXXXOdVa5UO3A6
         eNtq7U76iQkWmhBt/ouS6aD7FC7TGm467lCuBPBKBILK7U9vR3Dg6J6i99JT9+ToNpXS
         ex9A==
X-Gm-Message-State: AOAM532cQCnABjiyEfjjSgxJvW8ln+3Y+6nSzPAXQceCFkj8BvJ7B/Nm
        a/II93RY+PwxYQNSWugvkwJofa+Shlg//80KABY=
X-Google-Smtp-Source: ABdhPJxX7A4aAaazAFTTs0RFKofJsU9DOsy8L5OkKWaLFjIz3LFyRtM7Ao4BaDCYzf9L0EEsXZ88lEO7Y0QNXk+1LTY=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr8598377otb.260.1617902910982;
 Thu, 08 Apr 2021 10:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <1617692459-35670-1-git-send-email-zhangshaokun@hisilicon.com> <20210406070645.73l2oeqrdlwzxxi4@vireshk-i7>
In-Reply-To: <20210406070645.73l2oeqrdlwzxxi4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:28:20 +0200
Message-ID: <CAJZ5v0hdKEwsgLvFkUAqMq61hFiGt68XcGzq5YNMcMtzKFRnUA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove unused for_each_policy macro
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 6, 2021 at 9:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-04-21, 15:00, Shaokun Zhang wrote:
> > macro 'for_each_policy' has become unused since commit
> > f963735a3ca3 ("cpufreq: Create for_each_{in}active_policy()"),
> > Remove it.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 1d1b563cea4b..802abc925b2a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -42,9 +42,6 @@ static LIST_HEAD(cpufreq_policy_list);
> >  #define for_each_inactive_policy(__policy)           \
> >       for_each_suitable_policy(__policy, false)
> >
> > -#define for_each_policy(__policy)                    \
> > -     list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
> > -
> >  /* Iterate over governors */
> >  static LIST_HEAD(cpufreq_governor_list);
> >  #define for_each_governor(__governor)                                \
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.13 material, thanks!
