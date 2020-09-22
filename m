Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8106E273C9C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIVHvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgIVHvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 03:51:53 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD0C061755
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:51:53 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y190so9745648vsy.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbbBAuGsuXTgz5rYuqnraxTJDzDerOKtCQhCUqFHS6U=;
        b=EYaYdIoQRzyEt5y2N/IdFWoknEPPnqHU847BV1zVTV/LlbiIvwHiHOMTHEHgEgp4VP
         bnxmAo+r+PhbupZHumQOU7Y0IZSGOlTATE5Ep4FUP7EdX/hvFKrZjZnGghRwjqw4zwtE
         RaJcnjtuPr6lmfGPkMBVAsNysHmIzvK4VqzYcLtuOfajM0qLXgn+qLBggyLf1l8z5Q+f
         Hvk6RtGw8ckjTtNKYYKbDlG14VYx1jhYEblsftn3eN8fbdHofUKwnAuswdBCheH38m9t
         jDj/WKUBd0+KmRJp1v4KFKKoPTUsuHOlsjsvetsQmKqo9keRvb40IYdv6SgEby5bMys3
         yNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbbBAuGsuXTgz5rYuqnraxTJDzDerOKtCQhCUqFHS6U=;
        b=muMcnINe3zF8ckz9jqDnzoOuVvershPpHpXLKZLyLhcU61VYTQILDVQz841NQ8xr/Y
         W0tqEb4QEgRIQgRHQJbrkkdi+97VyuyD9leSeDz+gZfaXDS+rvaadE5fDxIRAHyQ3QuD
         D0Ump52A0UbWXKlhjn3JJZ5HgQZO+xCydODEGk/hJYuZ/gA4SU1idN1Dv0un0uubHH8L
         XOdWpe+Wdc3BQIAOycV3gWATXG/v7oMkWKgqE4QYDQBKhO1/bkc4H7VTCTR8rQynxyco
         kddwaFhl+QxU2gvRULCtNaNwmIuexMlTdulNVQEoR7l2nMxeON7vpUCFzVGGnoIsMoeD
         GLkg==
X-Gm-Message-State: AOAM532yLeOlUU/KSn28EL2/yvVnr8xX6gcsQ5zSsSSq+3e/LY93kldO
        df2V9a4DsyCCxXGUJkRaMAfVpPDsD3iC4bsKT9AW1Q==
X-Google-Smtp-Source: ABdhPJwRSKbykH1+tw761KaSBQFsMSGbBOgdsV/G0L1tHZ/95J15RR6zytTn6YwBbnn4mWRAeoIvVCntWd8ZUiGbWqU=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr2375913vsh.42.1600761112526;
 Tue, 22 Sep 2020 00:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142859.224381-1-ulf.hansson@linaro.org>
In-Reply-To: <20200901142859.224381-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Sep 2020 09:51:16 +0200
Message-ID: <CAPDyKFrim8D10N46FFE55kuWw68SuRWBD3HBcY5VMkOR1fhybg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpuidle: psci: Always create the PM domains
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 16:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This coverletter is mainly to help keeping track of the patches part in the
> series. Please have a look at each patch for more details.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (2):
>   firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
>   cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 59 ++++++++++++++-------------
>  drivers/firmware/psci/psci.c          | 12 +++---
>  include/linux/psci.h                  |  2 +-
>  3 files changed, 39 insertions(+), 34 deletions(-)
>

Rafael, I guess you may have not seen this one. I think it's ready to
get applied as v5.10 material. Do you want me to resend?

Kind regards
Uffe
