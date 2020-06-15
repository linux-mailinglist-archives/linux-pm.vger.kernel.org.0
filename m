Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D301F9EFF
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgFOSGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 14:06:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F6C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 11:06:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e5so13790667ote.11
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koqz947/4ofhNDsYETzq1HT03gn3YLhhwudgLxsVf/Q=;
        b=JoQjzNQJFe7PEiNGhyduxVSFmvWVquXangim5wrQDm1bgmdTLQHtm00vxmoNNsLArl
         nA/yVOHmVJPO0eSd7JddjU+57VukYASVYKvQ+Mx2GIdgVoY+NmYkUvhZ3XwM30LPif4v
         wCNYQsBDnYtZIFIMum2ib7Jdmd+wUgT82H19bbMpW1hP95nZ+K7BkpIW964i1QeoyNP9
         9DSj2Zod1fM/IxHVx6VtKfJ+gQ0lcCUEN16NOqmsqd7rht+dbVkPWO+ncyeC+nGNiEPS
         e2JpP1RZ13qWySGXWgsqWyk0/umXJDt74a3KG9dALEmS6h8WdaMektWoliBFmr8zPVWj
         eQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koqz947/4ofhNDsYETzq1HT03gn3YLhhwudgLxsVf/Q=;
        b=iJ0hbjn5hAi2HJKrFMTeJkdBwOtjwOtaEfuJaSLqIFCzJUxk86LHbJfn0pQaxzdVYv
         0BuiN/2RDkEaLFUh1t0tQW/OXyVZp2M9K2+ggHLR3me7Ysje4s6u/81yf6PypPyfVUB8
         5A/fhbglKnqbMoWO+bZ7r5VSTh6i6LBJnDlSViW80MqimCU82usJLk3OyJI/+hqu+3iA
         CFr2OMtTqog25FQCOjWf/JhEJNQcOQPbHxIVpMblSFyTg3TmJ5URak//aRk4UIHPf7wu
         T7iam+GVehZGu8K0e7/foTXGRRNsGf8b5PItg+MqGClvE5BnS/VYvc17CJDS1YgBLTnc
         fATA==
X-Gm-Message-State: AOAM532OAoAA8BKgeSUxj9FoGhocRUI1G/Y+9av105CYOXDlNkRKdRiv
        wYo+IuB6YabT7OY5ct0UM4LSgXlGIzWIcvdALTcxPw==
X-Google-Smtp-Source: ABdhPJy5xHM0q4eYRqF4wvHSVzFhsd2AraqkemjfAdD7yYDByUDxsB+VwlY6hpM282WUuPOnt3nDIYkxJgaD3VmC7Mo=
X-Received: by 2002:a9d:2253:: with SMTP id o77mr22295636ota.236.1592244361920;
 Mon, 15 Jun 2020 11:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <20200615152054.6819-6-ulf.hansson@linaro.org>
In-Reply-To: <20200615152054.6819-6-ulf.hansson@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Jun 2020 11:05:26 -0700
Message-ID: <CAGETcx9bbhW6NoHmjcx3h2y-b8eS_NLwGSyh_scX=CnTpujDNA@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpuidle: psci: Prevent domain idlestates until
 consumers are ready
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 8:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Depending on the SoC/platform, additional devices may be part of the PSCI
> PM domain topology. This is the case with 'qcom,rpmh-rsc' device, for
> example, even if this is not yet visible in the corresponding DTS-files.
>
> Without going into too much details, a device like the 'qcom,rpmh-rsc' may
> have HW constraints that needs to be obeyed to, before a domain idlestate
> can be picked.
>
> Therefore, let's implement the ->sync_state() callback to receive a
> notification when all consumers of the PSCI PM domain providers have been
> attached/probed to it. In this way, we can make sure all constraints from
> all relevant devices, are taken into account before allowing a domain
> idlestate to be picked.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index bf527d2bb4b6..b6e9649ab0da 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -27,6 +27,7 @@ struct psci_pd_provider {
>  };
>
>  static LIST_HEAD(psci_pd_providers);
> +static bool psci_pd_allow_domain_state;

Is there ever only 1 device that's probed by this driver? If yes, this
is okay. Otherwise, you'll need to handle this on a per device basis.

-Saravana
