Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69E368C54A
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBFR52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFR51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 12:57:27 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C59746
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 09:57:26 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id i38so1475851eda.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 09:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft4oGxDKuhki2KM3glh+QpoHF5x4xPTD3IWXY3qQQiw=;
        b=U1dfUR/niSpuh22OKeD99Tc6fXyk0tjP59TkQTJZPjqB+F89OgGqWXfIUOH+gcOpTR
         8i0m4WhDR1iImzJTIbIwRwFu/tNXWCE+JwEhyKwoGvANhc1Z7Rjvl3y0a0Z4H9j/Ay6E
         5bKeONkGVgDmJ44w+lvu3Gmzgjh/AuEKB+dEtMxdE6qEU3gPzWl3Zaw8hkxydo77n7Hp
         vxiqDBXiMS9lfs10jMuYbXRrmQzYin8aZaEhvlvJ/iUR+7ILsUt4nrYNN7YCc7gott4z
         OPSAhZ9T9NvJ46xm9OgnciXsqQ8gDMhl6MIw88pzTRsmJ2XQvxuRA2goPUwwoDiT1GiY
         crBg==
X-Gm-Message-State: AO0yUKUn/NszzZLlZ4tgTCd+XDX8yrJxYvIOqlhcD2Xl6rjt/V+/d3PK
        4cnSSuyNEyco2kO3m2x1oxxDvpAPiEzEyHQz8mQ=
X-Google-Smtp-Source: AK7set8TPjxQs0lJYIWkPqdigz8b72E/0IeZBoGorm6q0ldP9Ril6Y6q3nUUVMY9GiwvSFo3CQLS9MXteNIqbh+FLSg=
X-Received: by 2002:a50:d654:0:b0:4aa:a0ee:7ed1 with SMTP id
 c20-20020a50d654000000b004aaa0ee7ed1mr118191edj.58.1675706244804; Mon, 06 Feb
 2023 09:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230206040728.4pla75swp3p4tabb@vireshk-i7>
In-Reply-To: <20230206040728.4pla75swp3p4tabb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 18:57:13 +0100
Message-ID: <CAJZ5v0gz8NaY3ZusUk=j2gMGJzzysrXUQORTKc93AuNs_rkbgA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.2-rc8
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 6, 2023 at 5:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.2
>
> for you to fetch changes up to 51be2fffd65d9f9cb427030ab0ee85d791b4437d:
>
>   cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems (2023-02-06 09:31:38 +0530)
>
> ----------------------------------------------------------------
> This pull request fixes
>
> - the incorrect value returned by cpufreq driver's ->get() callback for
>   Qualcomm platforms (Douglas Anderson).
>
> ----------------------------------------------------------------
> Douglas Anderson (1):
>       cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems
>
>  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> --

Pulled and pushed into the linux-next branch of linux-pm.git.

Thanks!
