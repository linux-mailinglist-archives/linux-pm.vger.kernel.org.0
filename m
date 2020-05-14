Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E21D2EE3
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENLxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 07:53:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35535 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgENLxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 07:53:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id k110so2103487otc.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 04:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9kxYSPBegJj9bNzOlg4WZIp7HqOgKO2k3B49I539KY=;
        b=TgJ6yK+Lv0zL2+ZVR8QEn3RjLmZ+QtV90AR2Ccy6b4i+94IiAquetbRwpHcdSQfrfK
         3fAog1M9TbiHG0ju5PAPIzSU15eR8JlZU71CHdHmFVLa1tc/ItMIJGAEGYQVe1tdB86V
         mZtEhWxGieE8orWXZ0ImEV7dfmulPlLI7wfknp09G5vPsYRPDAaAMBx0mdDjlv/ehGwE
         Ku2OrbHtEIJvkcxwTyd85UxX/ruWJE17CaL73TFgve7x9WnAzJl5aCWZ3/F+GGlHrZq8
         tkjjz2VGM8ASKgKY+CRq3kp/i12NHlhwoxvnpMRLx+XmVaN5tgNfDum4m0abXhYa/Z9W
         kBGQ==
X-Gm-Message-State: AOAM532qqGltW9gbS2VIThCtPH6xQ8I01Z0fqCiCZSwD3HyM9f9Nox+y
        ewzKAFXdD7+70rGYWruwEHn8ABMy9iGMHkLf0EM=
X-Google-Smtp-Source: ABdhPJxq7/KiIseM0XS2zjxfuqtTApxDSftsbxbJ1OQVkRW1J+7ad2G+/MEUjGiWejpk18IuPQJpmXbE+D5zaE8Y0UI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr3034537oto.118.1589457188524;
 Thu, 14 May 2020 04:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
In-Reply-To: <20200511133346.21706-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 13:52:57 +0200
Message-ID: <CAJZ5v0h0aMKyDfYJTw7TEueXoToEYqM0Qsfsy5nk0cfGUwFn=A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 11, 2020 at 3:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Moving forward, platforms are going to need to execute specific "last-man"
> operations before a domain idle state can be entered. In one way or the
> other, these operations needs to be triggered while walking the
> hierarchical topology via runtime PM and genpd, as it's at that point the
> last-man becomes known.
>
> Moreover, executing last-man operations needs to be done after the CPU PM
> notifications are sent through cpu_pm_enter(), as otherwise it's likely
> that some notifications would fail. Therefore, let's re-order the sequence
> in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
> pm_runtime_put_sync().
>
> Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
> Reported-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I can pick this up provided an ACK from a maintainer of this driver.

> ---
>  drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bae9140a65a5..d0fb585073c6 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         u32 state;
>         int ret;
>
> +       ret = cpu_pm_enter();
> +       if (ret)
> +               return -1;
> +
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
>         pm_runtime_put_sync_suspend(pd_dev);
>
> @@ -65,10 +69,12 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         if (!state)
>                 state = states[idx];
>
> -       ret = psci_enter_state(idx, state);
> +       ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>
>         pm_runtime_get_sync(pd_dev);
>
> +       cpu_pm_exit();
> +
>         /* Clear the domain state to start fresh when back from idle. */
>         psci_set_domain_state(0);
>         return ret;
> --
> 2.20.1
>
