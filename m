Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD8358B75
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHRf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:35:57 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47079 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHRf5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:35:57 -0400
Received: by mail-ot1-f51.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso1165970otb.13;
        Thu, 08 Apr 2021 10:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+fSlnRPEdSZKgHQdXlMbx5JPJdYx/PLPtXPK2wwm7o=;
        b=B8OnKVXy1WpUagAtYco7x+1ZAJYHjbKdt04ShsuuT/eUiFksCBVtP8aWHTSNtNd773
         zPPJDVXc9B2Qpe6WGGuDOkhhOlUTR9Yq8vWzZQYHX8T8ifI9a0J8/jRaQjr+YEaJOMgn
         ASa53vaW/HI5L+m/r636Ae6TyAEAFEAvAhzzZ9BmFmstcXIHyJBGNi+mnac6hC3kyCis
         dw6rFWBXfZW5orH4CtxKW8N02EkvDdADBT7Lje7i5K6FCWNhhUYREBnW+RxCft9wCuzL
         xQm1LY/UtXmWA6UNqTEYfCGrnPMJQLj0e0bcCoETKms6WXekseHaRjTnrsRKCp+CKKPr
         7X4w==
X-Gm-Message-State: AOAM530x/IT9y7e/KNt6v72bwZorLTSmDwn8Wpvy6BaaFkEkKTKc0O0R
        g/Mku6uPCBGfA3LlMLkCIP/WfsWnKiNv533+9zg=
X-Google-Smtp-Source: ABdhPJwa7hG8mV20XkU6Va9EP0WIZMhykAbYJ4c0IDZEo0LKXh5zFFmxI8IDFbRBxlpnPLSxPoxfUxKuCB/AjgpMf6w=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr8627869otb.260.1617903345582;
 Thu, 08 Apr 2021 10:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210408061152epcas1p195531dcfe84ab8d4a8f15f7d550993cf@epcas1p1.samsung.com>
 <3d4f6d28-5d8e-df33-882e-0e5dafe575b9@samsung.com>
In-Reply-To: <3d4f6d28-5d8e-df33-882e-0e5dafe575b9@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:35:34 +0200
Message-ID: <CAJZ5v0h9F9q6i6m40fmZpw79DbtJuzMFddAGfwn0W+-5__ZQCQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.13
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        Chanwoo Choi <cwchoi00@gmail.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 8:12 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.13-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.12
>
> This pull request contains the immutable branch to keep the immutable patch[1]
> between devfreq and drm for gpu driver.
> [1] https://patchwork.kernel.org/project/linux-pm/patch/20210308133041.10516-1-daniel.lezcano@linaro.org/
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:
>
>   Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.13
>
> for you to fetch changes up to 0a7dc8318c2817fb33dc50946f7ca6e0ff28f036:
>
>   PM / devfreq: imx8m-ddrc: Remove unneeded of_match_ptr() (2021-04-08 13:14:51 +0900)

Pulled, thanks!
