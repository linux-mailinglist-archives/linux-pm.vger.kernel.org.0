Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C179A257376
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgHaGAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaGAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:00:21 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF4FC061575
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 23:00:20 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b123so1840465vsd.10
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPR6E22q3UvNsEW0qxCDu2FmZX7UARU+hYhcDGZGweA=;
        b=t3rUgXe/X9VtlQzwBgCEyPm7ABnuByKRqwNbksXDycnu+HFH/DK7iXQgNZxmIbPWLE
         TZdz75AD0/N1v06ZgeKjXZ5yRHjb6Mehm39GJIZ4E8jaB9syZeEBBSgWMghzPZPatTi1
         QMucj1c4u1eveuP3kgRLsTqFdI8CiXA9x8LzpUw66pUgg78FPuEEQsKzJASpDiSdlVKL
         cPn0omDEIwOipWkmNGwYj4muoYZBvyb1aZb/h3hfyYtNXsJlrUye8xiDkE59HHI6sGTg
         U9eEsGA/yuEf9HAxc0t8OQITM0/PBD/CFf2NABRFisOMPKF5WDx0a6RNmRkTkZdFv4dR
         bHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPR6E22q3UvNsEW0qxCDu2FmZX7UARU+hYhcDGZGweA=;
        b=JcGyP4FDHEiT+LKefRaudNgUhHWDT6FTPnQwjiRtZqmsRr5yVFU4QZwyh1KCYKcIQV
         M5hsBl8laC+y+myLnFFkfeXgxlwcSEOMEJNECZc69NndqpVlpoDuLTONnKCZDH/khKxZ
         xvSM5Ez0VNWg4+ADNQbccCzrilqpNomzQ4ESUeazccOI/DklRa70OCTCtKfNGFU7kuwO
         a613uC4YPzplRXng0hv3k9J+Hvp6QNw2QfYn/yza52aZAxgKDFKo1lQFhu7yktQe83WM
         yC7oZGaQ0qNwA88HNytlxXUbkV1NBjx9UbNkDsNH3Gdt0MMaP23T0bfm6VsbDpxIzP3n
         J7Pg==
X-Gm-Message-State: AOAM5314S6ntgm9+hLDkyu/+v+KYjPuig7ZMOC6BBPggsBKd89i8qHhf
        girDdntQkxJuFse6lYdXXucENu5gwQKsQ5gDtvHTbg==
X-Google-Smtp-Source: ABdhPJzabAOw5f4M98Uk3VeYnZHKFFd23UucsW7AqrMhZATJGgyPECIanekf0eYeVulibqH5Joiez/O1Hix+DfthbT0=
X-Received: by 2002:a67:e3cc:: with SMTP id k12mr1468vsm.173.1598853619997;
 Sun, 30 Aug 2020 23:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7> <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7> <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
 <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
In-Reply-To: <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 31 Aug 2020 11:30:08 +0530
Message-ID: <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
Subject: Re: WARNING: at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x4cc/0x5d4
 - on arm x15
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Aug 2020 at 10:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-08-20, 15:42, Naresh Kamboju wrote:
> > Viresh,
> > I have applied the v2 patch series on top of linux next-20200824.
> > and tested again the reported kernel warning is fixed [1]
> >
> > [1] https://lkft.validation.linaro.org/scheduler/job/1717615#L1881
>
> Hi Naresh,
>
> You meant this one ?
>
> [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()

I have not tested individual patches instead applied all v2 of 8 patches
and tested.

This is from my tree.
$ git log --oneline | head -8
574dafbe5e8a qcom-geni-se: remove has_opp_table
6680f35d0cca tty: serial: qcom_geni_serial: Unconditionally call
dev_pm_opp_of_remove_table()
2a3929d0d5e0 spi: spi-qcom-qspi: Unconditionally call
dev_pm_opp_of_remove_table()
617b65175370 spi: spi-geni-qcom: Unconditionally call
dev_pm_opp_of_remove_table()
e736706a4914 mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
afdd91145686 drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
b85668862d92 drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
3ac057e88c7c cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()

>
> Great, thanks a lot for testing these.
Anytime testing  :)

>
> --
> viresh

- Naresh
