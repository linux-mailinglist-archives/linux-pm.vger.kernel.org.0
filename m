Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9232D505
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhCDOJ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 09:09:56 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34510 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbhCDOJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 09:09:33 -0500
Received: by mail-ot1-f43.google.com with SMTP id h10so16670666otm.1;
        Thu, 04 Mar 2021 06:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgSxJGXhmoJwh0jUczE/nhHvEQDm4MeHs9HGJanWGm4=;
        b=E+bzjfjmsawARNMczW/aSrsskiTe2/3ZoLzXwsSK5Dwnx2cK2XRQdbbWWnsjytGqPW
         W0DKihhAdfkyNhpf5VGbrsPKGLe5HL4DfJdKNn0LC0wOwX//LV3jwPjh9oVg0cPVqbli
         TVPrluWe300JNeHxPSf9UaaW/T+u7ulTl+Y55UopqI6wDJuHSETQAZO3u9JsUPDCkNHi
         e1HlA3N8miSdyfZwxoP1GVAAcDkXyRW/OnuMKDrTVM1cZu8BJbN7eZbkh6cCcL3DK0fY
         tCqQtkZeWQwh9HL2KMkOGZTf6NBkSkorFCGB9aZ7hhgKtQlc5vv1D9aZxIuyAPP87lvD
         dVkg==
X-Gm-Message-State: AOAM530z48a/7BZALP9kmFIAOw0Bpd3st2MAB/vOtIcAO2yOTWtyRRfh
        nWx3HFzmAjGcfkK+yztQHO7myuWyDGidQNt9VDM=
X-Google-Smtp-Source: ABdhPJwaKogP2IU7eACiaGu5IsJ/HSddvG7Bzr95K5Vk8NvJ1uA8mvwduc6KqsyC0S6hbvo5YPdcIQJnLKUtRsEGPOU=
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr3120144otf.321.1614866932506;
 Thu, 04 Mar 2021 06:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20210302095405.28453-1-digetx@gmail.com> <36f5d767-d021-d1cb-dfc1-7b9dd63d7d9f@linaro.org>
 <CAJZ5v0hZKsTnFSrchxo_=jTv7qzoHgsq6W_5Gj4TWWjU5y71jQ@mail.gmail.com> <cd887d44-439c-5a3a-346d-ea88df327782@linaro.org>
In-Reply-To: <cd887d44-439c-5a3a-346d-ea88df327782@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 15:08:41 +0100
Message-ID: <CAJZ5v0jUqtiv7sXOHnDuPzbjxxsqY63Nr-zo-3FnEJOoC85rAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on Tegra114
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 4, 2021 at 3:05 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/03/2021 14:55, Rafael J. Wysocki wrote:
> > On Thu, Mar 4, 2021 at 1:30 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 02/03/2021 10:54, Dmitry Osipenko wrote:
> >>> Trusted Foundation firmware doesn't implement the do_idle call and in
> >>> this case suspending should fall back to the common suspend path. In order
> >>> to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
> >>> firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
> >>> C7 idling, like it was done by the older Tegra114 cpuidle driver.
> >>>
> >>> Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
> >>> Cc: stable@vger.kernel.org # 5.7+
> >>> Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> >>> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> >>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> >>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>
> >> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > So do I gather correctly that I am expected to pick up this series?
>
> I had picked the cpuidle related patches in the past. As the traffic
> became low, I assumed you directly pick them.
>
> But I can take care of them and send a PR at -rc5 like before,
> especially that we have new driver coming. It is not a problem.
>
> Let me know what is you preferred way.

If you can take care of ARM-specific cpuidle changes, that'll help.

Thanks!
