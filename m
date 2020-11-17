Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96952B5F1E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgKQMaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 07:30:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35102 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKQMaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 07:30:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so19222696ota.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 04:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZwFpELin/m3PgbJEBnfE6jFiJ3/LjxvXfLEIkQWq8c=;
        b=BOksJapVFS111aMsiqOOFvqACKmSsKM0Q96Pz7r2zd+1mC45ZWVP1QfCCfc8SfSYh5
         2jQN2FKvaN7i5QoJRa34+FnsyFSHjyGM51Ub4aC+pHe9uEwwxsw1WHlBn0r5Bc/FwjdM
         p0nulQ+UlGBImVXDRXgL/27GbUya8+UVYSjb99QjY0gjpZBdHWL3Dt6pFgZEXDXGnCrK
         vAr8BwpPYrPuCCtG8zNvbVIQS8ZSYps2QR5YujEAAX2m1HuxzhX2LonghaPF5frH7ZhJ
         eL5vM3OjJe3KcocHMlkcfl5qtrNksuetOok24YXlQBsFxvv8o+x0WWsDIWdgDVsYaYwZ
         /AsA==
X-Gm-Message-State: AOAM533inM0MyK2q4h8eh8c++0sOBNvLma9C3kCg+Ngjdy8VH4Wn8w8p
        YInBEfVkfWf+wAqYEH49KHesSA5AFqheHaJn7FlkKgEn
X-Google-Smtp-Source: ABdhPJw2okhBwPBt5DLjyRZxWbqN187Are74jnrsfTLtGAYTFeFPlu3cTCqVrqi+NDFMHEpayz14ExkubzSUrOQP6jc=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr2974972otu.206.1605616209717;
 Tue, 17 Nov 2020 04:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20201117043916.tqs5c2r36inoc2ss@vireshk-i7>
In-Reply-To: <20201117043916.tqs5c2r36inoc2ss@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 13:29:57 +0100
Message-ID: <CAJZ5v0iZfqVH=kpHbvrYaS57Hg8mLEy1BNdeGxv02hhQgKjZzA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq-arm fixes for 5.10-rc5
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 5:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - tegra186: Fix ->get() callback.
> - arm/scmi: Add dummy clock provider to fix failure.
>
> -------------------------8<-------------------------
>
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
>
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes
>
> for you to fetch changes up to 8410e7f3b31e53bfa7a34c282b4313e79ed7ff8d:
>
>   cpufreq: scmi: Fix OPP addition failure with a dummy clock provider (2020-11-17 10:04:28 +0530)
>
> ----------------------------------------------------------------
> Jon Hunter (1):
>       cpufreq: tegra186: Fix get frequency callback
>
> Sudeep Holla (1):
>       cpufreq: scmi: Fix OPP addition failure with a dummy clock provider
>
>  drivers/cpufreq/scmi-cpufreq.c     |  6 ++++++
>  drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>
> --

Pulled, thanks!
