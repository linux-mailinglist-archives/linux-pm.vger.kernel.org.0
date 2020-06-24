Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F699207085
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgFXJ5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 05:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbgFXJ5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 05:57:50 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADEC061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 02:57:50 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 190so1032768vsr.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnuyRqpJmjH92KdSrwmGI2zdl8jmTsHHh8ofByCDAOg=;
        b=dIGLxviZuMXujNKOVZwmKpK9fCRCa3KNvdXoT1fJrI1vecB0oxSgoa0D4OFWYK/MKm
         biZPVLFcg9SKmzu3SeHjbgpQ7gYxdF6GVNVjfR/0AJUibijdeQycrLORqKzgkAJqTs1L
         3H3p5qR0zjPy8t8i3SjZsp+lN01cll2MF6BGyzy1pejOC398UsQzMsZBGCzxw9RdeJdD
         mw7XRiqKhH1rif26QZ/mG/h+K2TKzr3PiEjQqyBbKPtNoNfy3g5JWvvjXYjX/S/KZ8OZ
         0n177rIMt6291Yy0LdYpDRAX5RDHMOnN5sjSUmGET0oeC222boMa9Jnhl14YYbjNQc4t
         lldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnuyRqpJmjH92KdSrwmGI2zdl8jmTsHHh8ofByCDAOg=;
        b=te4B7i74kk+XaOXj67PeCAtYHqZE+Thc9ktoqRv7Maju3PECmSXQfPvUbSyMLi+rEE
         9kld7M+q/psBI1KPV1qJkVU1frEfR6AAOUHdSg8hFtGb6S/XkphIocPvcc2n2dR+O0XA
         JMNYXksio1xgT9ju1Sxg7bYuf9FQKUp1YLNyZpgtFj9n8g4uO+btJeUwn4f/lPP98CtS
         A0PNm8fEEhorB5vI2lQGb3mxbW4OinbIfTO4OPVZ4ZInEiFLmROrHKIe8xoQEH0/bibV
         4mq15VKIGjMb57qcbLshQzoesxU/q9Pu0GmE0ZZwqwaVYsp8CQ7m01bv9LeZATIxSWhJ
         b6zg==
X-Gm-Message-State: AOAM531EQX6UtJZNUZgYagr+G4lDxJKK8pTWxzhLPkZ09JihWWyN/ZRW
        YecG6ZFhjF5vnkQWEjgJu7d7OSuoB6DBc1Fr6PeS3A==
X-Google-Smtp-Source: ABdhPJxstpeIZ/fKCGQFMME/6aJsNmw3UXIGvUtGK7TSEeht9by6TolTXo34kt28nQoMfqCd6QM/3e4yR6ng2den3gU=
X-Received: by 2002:a67:ee1b:: with SMTP id f27mr22657195vsp.34.1592992669154;
 Wed, 24 Jun 2020 02:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jun 2020 11:57:12 +0200
Message-ID: <CAPDyKFr3T-H50CHAPaDRxoTyPgh6B3N9ABk4=v2re+EGDzfGzw@mail.gmail.com>
Subject: Re: [PATCH 0/5] cpuidle: psci: Various improvements for PSCI PM domains
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 15 Jun 2020 at 17:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The main change in this series is done in patch 5/5, which implements support
> to prevent domain idlestates until all PSCI PM domain consumers are ready for
> it. To reach that point the corresponding code for cpuidle-psci and
> cpuidle-psci-domain, needed to be converted into platform drivers, which is
> done by the earlier changes in the series.
>
> Additionally, some improvements have been made to the error path, which becomes
> easier when the code gets converted to platform drivers.
>
> Deployment for a Qcom SoC, which actually takes full benefit of these changes
> are also in the pipe, but deferring then a bit until $subject series have been
> discussed.

Sudeep, Lorenzo,

Would you mind sharing your opinions on this series please?

Kind regards
Uffe

>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (5):
>   cpuidle: psci: Fail cpuidle registration if set OSI mode failed
>   cpuidle: psci: Fix error path via converting to a platform driver
>   cpuidle: psci: Split into two separate build objects
>   cpuidle: psci: Convert PM domain to platform driver
>   cpuidle: psci: Prevent domain idlestates until consumers are ready
>
>  drivers/cpuidle/Kconfig.arm           |  10 ++
>  drivers/cpuidle/Makefile              |   5 +-
>  drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
>  drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
>  drivers/cpuidle/cpuidle-psci.h        |  11 +-
>  5 files changed, 150 insertions(+), 91 deletions(-)
>
> --
> 2.20.1
>
