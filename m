Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9F313346
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBHN2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 08:28:55 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41248 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhBHN1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 08:27:02 -0500
Received: by mail-oi1-f179.google.com with SMTP id v193so10106215oie.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2021 05:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBwt6nCyLc8uPU1icvs5m8klumkCOmgz6lkETmd4PPY=;
        b=WjWDVv8ZqOIwXeHzAQ3vgaTP9ZNSa//WJA6F43YdJyVmBtDr+yJOWPv/4TqQVxqvg1
         8Fo4DWJkKaF1Nmp8QZtpIzpd7EpATyNiYfy0iQeojWXxJfSDGd+AD6ZUkAqR6m2gTn7l
         yWvOUH0RR5XRDQV1bo3H/CjGzz71di1t+9udQUVup8KcpsvckuZKGTB3KOdqHhn+UjBE
         NGElj1UJuzonUGict3Tooi2bZOXPatviYiVMqqM+UTxH7FK9ev+pJfQeDmPKFTDTAZ4w
         7YpP6XdyQTWuTD3KVwUJwApVIK868biIvkyEnn7QcpsEp3M67RkLI2EYHI2xcA8Ia0gq
         YjjQ==
X-Gm-Message-State: AOAM530Ozy4Kzig7aEeN3cYjyCg/92q2Vy4Wki+40jymLfArZk2ZlVo1
        mpce6Cd8BQx7a4KiTH5ZN+2787vjDcWBquW+K3U=
X-Google-Smtp-Source: ABdhPJyyaOP2mWD7L/nuGCzsXlejaRAtMqAxAx/ytOmMNdKMZBY+cFaz7BeOIcZzIfh4trIMzNGHXi4p2nNsEt26xSY=
X-Received: by 2002:a54:400b:: with SMTP id x11mr4567821oie.71.1612790781823;
 Mon, 08 Feb 2021 05:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20210208060027.kzqxscpceb7l6656@vireshk-i7>
In-Reply-To: <20210208060027.kzqxscpceb7l6656@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Feb 2021 14:26:06 +0100
Message-ID: <CAJZ5v0iApR0WUmNB6QU2G9XfwwErbY7AyRcpu4wrOc9nFuy+vA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.12
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 8, 2021 at 7:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Generic cleanups across the OPP core (Dmitry Osipenko, Viresh
>   Kumar).
>
> - New OPP helpers dev_pm_opp_find_level_ceil(),
>   dev_pm_opp_get_required_pstate(), dev_pm_opp_sync_regulators(),
>   devm_pm_opp_register_set_opp_helper(),
>   dev_pm_opp_of_add_table_noclk() and devm_pm_opp_attach_genpd()
>   (Dmitry Osipenko, Viresh Kumar).
>
> - Allow required OPPs to be used for devfreq devices and related
>   changes to devfreq governor (Saravana Kannan).
>
> - Significant code changes to allow a new OPP helper,
>   dev_pm_opp_set_opp() (Viresh Kumar).
>
> - Remove dev_pm_opp_set_bw() and update related drivers (Viresh
>   Kumar).
>
> - Allow lazy linking of required-OPPs (Viresh Kumar).
>
> -------------------------8<-------------------------
>
> The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:
>
>   Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 86ad9a24f21ea7aac7deed06fe9556392568d88a:
>
>   PM / devfreq: Add required OPPs support to passive governor (2021-02-04 16:48:16 +0530)
>

Pulled, thanks!
