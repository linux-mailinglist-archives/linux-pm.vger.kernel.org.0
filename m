Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F003312CC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCHQDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:03:37 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42719 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCHQDF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 11:03:05 -0500
Received: by mail-ot1-f42.google.com with SMTP id e45so9643168ote.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 08:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjU8DkAqqBNl4x/nwSBKlC66w3zKL7dbotZ+4VD+8Tw=;
        b=T8mAcotqhpRSiK3ayGdutCf1S2kdIMztQmLkgfTU6KdsjPgS+iVhRCfLLlyujzAHIX
         IgObc+OnjxUXpJP6ULtaOUWlVzoXqpIK5h1JhZns8qvYxjW2TMl07JOnK6rsu8JgJJzb
         mVBXFK8V+zP+dG6xtemBjtxIg8mx6+auvIA/5tD7AI6fWBBj79mDW0FQTFX5WpjUdf3y
         StqdlMSGSHbG9n9XM/hC+rA6Ipm54yZAVJq43AKSxcLHpgaOW2U99kEEzwym6bIFL2wv
         wIdi3nAHyES4/FDwzSKcsoMEdw0oJk//kQx0r+6P0onDUJJZC9RnQdj9MSwnvy1f/Lys
         IZKw==
X-Gm-Message-State: AOAM53292UwopiCiqtfG6JWMbHCEN1JH2dWDtVOqRldDPD+HkERoM/ZX
        nDHROlCL3SIfLFe5tz+l0gxHpzEYMZ1mhd3fR0vMhkUx
X-Google-Smtp-Source: ABdhPJywv5HhKsXqAkJbsB8lSt2bfypgdyF+sXE7Z5y5n3bdr+FytbYwFTO+hkyZQAURhgfBGUZCHd3zYY/XiYLMStw=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr21023405otp.206.1615219384660;
 Mon, 08 Mar 2021 08:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20210308105601.krfecfcjh6e63bqq@vireshk-i7>
In-Reply-To: <20210308105601.krfecfcjh6e63bqq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 17:02:48 +0100
Message-ID: <CAJZ5v0hA6UuoWD8mBcNh7b_nTHRWZgX8E0+oF3gc129+awjMUw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.12
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 11:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Two patches for qcom-hw driver to fix dereferencing and return value
>   check.
>
> - Add vexpress to cpufreq-dt blacklist.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
>
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes
>
> for you to fetch changes up to fbb31cb805fd3574d3be7defc06a7fd2fd9af7d2:
>
>   cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev (2021-03-08 16:20:07 +0530)
>

Pulled, thanks!
