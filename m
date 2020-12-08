Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC42D30EF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgLHRZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:25:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33602 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgLHRZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:25:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so16535593ots.0;
        Tue, 08 Dec 2020 09:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQS5OFe9izfgSGxospoin4vY6mXLHFVlaFPlttkOIi8=;
        b=fAgis2LLv6wlqFsLO0svweupkYRZU0xYpZKlHeMDzpJR2vLtsIcsl9ymOKq5IV7UtH
         03rFE7P/RkJ0UbUGWhbwJlOHJ2qTS9qzVsIN75bUf5rhfbi8rmD3VtelOBXaQ1ER5+WU
         hi/un34d80K1e9PhbUIg57lORDNY+0pSxOmgqD3iwJo5P8fDV7lzgzox0LAqjEDkaSuz
         p9wceAmwV/czLl/pzRF3pUXcHLqiGYyUrzVftQ3OD5kWPzrk48yA/+29imH0DjojxHSH
         XrJfBWnvJCVki9wuvWBfETC+c4WgbFwq8zQAidOdDLKAAoEVeaZssYg34w+dgE4dz487
         8Tow==
X-Gm-Message-State: AOAM531YsqPNUlQ/kzPJAcUmNxBT6VM4JH0kxO7ziHapyByHHLVx+Qyk
        SU0ne4Ztzwn8uvxVCA7eqS8FUS163vxC0ed3tVnQyhsd
X-Google-Smtp-Source: ABdhPJwQnV9P9sZCCXYirI7XMYqn8fjHTzP+I6n4ERN1+s68p4wdP7C24F7wchE1YDyXH1ysSUilU/xXZKzTlUAMv5c=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr18282930otk.206.1607448271094;
 Tue, 08 Dec 2020 09:24:31 -0800 (PST)
MIME-Version: 1.0
References: <671427cc-2abb-68eb-5e54-0851785efa84@intel.com> <1606527564-27238-1-git-send-email-pkondeti@codeaurora.org>
In-Reply-To: <1606527564-27238-1-git-send-email-pkondeti@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 18:24:19 +0100
Message-ID: <CAJZ5v0g0WkzJkO8GAa_XrNFNmzRw6aVeS+DLLyTVRXnp9mq65w@mail.gmail.com>
Subject: Re: [RESEND PATCH V3] PM / EM: Micro optimization in em_cpu_energy
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 28, 2020 at 3:21 AM Pavankumar Kondeti
<pkondeti@codeaurora.org> wrote:
>
> When the sum of the utilization of CPUs in a power domain is zero,
> return the energy as 0 without doing any computations.
>
> Acked-by: Quentin Perret <qperret@google.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  include/linux/energy_model.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b67a51c..8810f1f 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>         struct em_perf_state *ps;
>         int i, cpu;
>
> +       if (!sum_util)
> +               return 0;
> +
>         /*
>          * In order to predict the performance state, map the utilization of
>          * the most utilized CPU of the performance domain to a requested
> --

Applied as 5.11 material, thanks!
