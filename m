Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD931C465
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfENIIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 04:08:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46707 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfENIIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 04:08:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id j49so6730966otc.13;
        Tue, 14 May 2019 01:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWm6mMU5ntuV/CqseYpvApqEUMSFpmgOWSwc60Tv2bc=;
        b=F0EjUCJiIB5F4D3GoURhu1AKUGjpkk46fDdHYFlkokF9DiEJMIMpv/BRGUyDBIS/m7
         AP6nbqZFFdzjqSNeavAZO/jPxladFV8wGTQ9jjtvOOkiTNoPrp5af8t7YPY0NRKlscSX
         XI4ZXJfUwqBLhOmVmIB2/uXeuDUiQmglywy5uheDyB5u9A7nWuBLoAqqn7XiOqKh8soN
         em5FWotejBvIcgKtgUorxlKR3ZlqXuqRWFDpKPxJEzhksI98Srft9pfLAx3952ihI+uu
         SrI+qqYG9QQES3O3iNbROGOFqv2nat9/SJZ6w8oqzC7SQbGzoCTJ5MgbEn7hYzRIfn+o
         5XcA==
X-Gm-Message-State: APjAAAXubFhT1189GjduEsXjuS3mgLsEQN/pVfeBlYaeJBVAqGMK0kFb
        weHkBjlkYqyZYkNFgP30J4b5iYd7XO5u4OYCkvU=
X-Google-Smtp-Source: APXvYqwTEraX14mcZPt1vimtoi25THN+ixAWY1ha+9DfuEBICcJUnLm2RU77VIBddQdQK8nrMAM+2KXW8YeAocOii18=
X-Received: by 2002:a9d:5912:: with SMTP id t18mr14870864oth.252.1557821333611;
 Tue, 14 May 2019 01:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org>
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 May 2019 10:08:42 +0200
Message-ID: <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This series enables support for hierarchical CPU arrangement, managed by PSCI
> for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> recently was extended to manage devices belonging to CPUs.

ACK for the patches touching cpuidle in this series (from the
framework perspective), but I'm assuming it to be taken care of by
ARM/ARM64 maintainers.
