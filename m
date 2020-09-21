Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E0272AB0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 17:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgIUPuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 11:50:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43362 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUPuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 11:50:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so12746226ota.10
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 08:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO/ARDft/cks7ZXJorM0gJHERENVGdcO1TPxxlhgkig=;
        b=AfNgt9KYMmZwvflrZCw4LHg4pXP1WmS3BqPPieIIWwzSDWrLVdQBiJMQW7tr0yQQGV
         8iTBsNYvXTLcUiwtDWYdj5fOB83ifJ54QlTJZlsDcATBEMyXoIOK/kzbcLPoGPnNrl3v
         8WJD+0GLySoHcb9dT0CWPprcKOIgnLG3H+mRImNxGTQGAjZLfmJhYGOorCgacBwq1YkI
         RLYqzU7kThzev3yvXkmT3VG0jZvKE9ciKmBRuhEsxrrcFCBJW7VPGUjnxVmeNArWlhGy
         5/oKkJhX801iN9T1mxR1n52L09b8mms62M2zoJ6fdQPTSoyZp53W46S1z+yPiMZCcXtY
         e/7Q==
X-Gm-Message-State: AOAM533Bvl4VaYdvMT77nRg5GNOdnviDDHjaoVSsQ38Vh/HQhr7ePEtq
        n/vRbPGOqt0C2KWF1DaJfU6dkJM3ncdXlacxoMo=
X-Google-Smtp-Source: ABdhPJz1lAeoMlUYT/ZXcQuOOuc/mu3ZY7Mipj9Nz31LlB8KdhrWsyJPPUOYjmEqSDaGm0yDB6aS74uDShwqJq4V5gQ=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr116301otg.118.1600703403285;
 Mon, 21 Sep 2020 08:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123716.61936-1-ulf.hansson@linaro.org>
In-Reply-To: <20200814123716.61936-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 17:49:52 +0200
Message-ID: <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Fri, Aug 14, 2020 at 2:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Extend the file pattern to also include cpuidle-psci.h and
> cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
> particularly to help with the support for PM domains.
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Any objections from the original maintainers?

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f9ae8ea54e27..66821197175e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4556,10 +4556,11 @@ F:      drivers/cpuidle/cpuidle-exynos.c
>  CPUIDLE DRIVER - ARM PSCI
>  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  M:     Sudeep Holla <sudeep.holla@arm.com>
> +M:     Ulf Hansson <ulf.hansson@linaro.org>
>  L:     linux-pm@vger.kernel.org
>  L:     linux-arm-kernel@lists.infradead.org
>  S:     Supported
> -F:     drivers/cpuidle/cpuidle-psci.c
> +F:     drivers/cpuidle/cpuidle-psci*
>
>  CRAMFS FILESYSTEM
>  M:     Nicolas Pitre <nico@fluxnic.net>
> --
> 2.25.1
>
