Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB931EF62
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 20:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhBRTLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 14:11:54 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33166 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhBRRnV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 12:43:21 -0500
Received: by mail-ot1-f42.google.com with SMTP id c16so2655795otp.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 09:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr/oIpuXM4Kj0+wiisIahrgS6K8DuDua6rQltQutEc4=;
        b=SyUxKOEgxGk5pRJ0pDSkZUx3DFFBCzwMsXp8RFAReZ45Qu4o4ahejEsuwQlp5o0WVF
         yy52fejJ2Kjarcs0/y+ycYNNkUps1t5pbcScyuXF1YurKHM05EWjD8YwZeZZLGWEzTYe
         8aFMg1T4WosiHZc7Y+rp7GiXN1oqdB5qLlBX9ldVIk7fvvJ/VtZslg/DSfQMPfFphhK+
         ZScGKoxvcAmsRjQY3uVb8qMpqIWOgUGz+lu25BMEgOaSrS2PmQy8L0IO7smSF1dUxVPQ
         +rQjBoHlffnB+BAM0JJEx0HuAKRIcgoaawHaIJAIKfBfZnIbP+VN6HkoQQ+rJVY46H5o
         Q5Aw==
X-Gm-Message-State: AOAM5325lJ1lSaZDvQfn0xApZ72G7Qa6oNv09vUEuH+iZQqEKQCCPv0a
        mqePbV80Y9k0qaBIqc2x7frnsFHzgA5qqZdYV7nWEDp27Sg=
X-Google-Smtp-Source: ABdhPJwqjNkKJi/fzpj1NIcljhrxtL6NgxMww7+kXFXoSbzR3NW1wObguHzVn+5htUwDKpKbviKba9MMtvdLPYSd83Y=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr3844954otg.321.1613670161378;
 Thu, 18 Feb 2021 09:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20210218091849.6lem2iaags3dsrz3@vireshk-i7>
In-Reply-To: <20210218091849.6lem2iaags3dsrz3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Feb 2021 18:42:30 +0100
Message-ID: <CAJZ5v0h9rs9LQvSN2d881C7oR7VL_PLfDHX5zK8MLeKTyFxcKg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.12
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patch to fix issue with cpu hotplug and
> policy recreation for qcom-cpufreq-hw driver..
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 7114ebffd330bfc5a95b9832a70b6bd857d26fd8:
>
>   cpufreq: remove tango driver (2021-01-21 09:34:46 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to 67fc209b527d023db4d087c68e44e9790aa089ef:
>
>   cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks (2021-02-18 14:35:18 +0530)

Pulled, thanks!

Please note that this will be pushed after the previous PM pull
request has been merged, though.
