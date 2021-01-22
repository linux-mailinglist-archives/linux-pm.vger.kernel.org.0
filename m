Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F894300874
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbhAVQQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:16:12 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42585 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbhAVQPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 11:15:17 -0500
Received: by mail-ot1-f42.google.com with SMTP id f6so5545414ots.9;
        Fri, 22 Jan 2021 08:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXVUkcgQKTis57dU1/4aKMT9u2v6l/Z+YYRm+6h7wzA=;
        b=nI2nq73Eu5+/17sXVt/Ad8MlaH6e4OGMKYlztpdZJOvmnb4oP37e6e0e8pA43jTnFe
         rLpR8+vngd/6O7FhBazvcMYQ6qEZE5OWpP4t/310mcGTRB3VWI1EK5PxhTtwkK4iNf0T
         2WKHYUNWQqerO3WcOUqKUqWpUU66+4yX3TeJTuDViM1L/XHQrESC22GLWUMj4w76o1fl
         J1TnZEAu7kPz3X/nnt5D7YtB35guCCILlZCtSVnhtzJTr38h5+Kozo1P69ljUi46bCvD
         VqoMd3bBFLSkPcGhzNaBX069CevIvU15ZtqsOz60XxiNJa0HA3WFHJkrTpvkDSFYsBES
         Dsyw==
X-Gm-Message-State: AOAM53076E6sgKgV/VV5L+0lzgrosiMSaQD3mRe/0DUaF7cAJO+9P135
        //AEyrINvU7Kj9zJtkOXPFrY2wSt8Jj6ZkdstmQ=
X-Google-Smtp-Source: ABdhPJx1mh+BAevROCoaI//0hwQrXs1y2O4HiWUF7XIGUv+/7ZJTfUrYP4f8KFaWw1EMZsmIvc4eZDmbVabYP2QNEyQ=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr3812195ota.260.1611332076451;
 Fri, 22 Jan 2021 08:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20210120211232.17299-1-digetx@gmail.com>
In-Reply-To: <20210120211232.17299-1-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:14:25 +0100
Message-ID: <CAJZ5v0hct8eUkMtiusP4VLKebVZxdiEoqVjUN5d7EOjH29gSnQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] GENPD API improvements
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 21, 2021 at 12:45 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Hi,
>
> This series is a prerequisite for the power domain driver of NVIDIA Tegra
> SoCs [1]. It extends the GENPD core with a better support of performance
> states and eases linking of child/parent PDs for the PD drivers.
>
> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
>
> Changelog:
>
> v5: - Renamed genpd_xlate_performance_state() and its arguments like it
>       was requested by Ulf Hansson and Viresh Kumar in a v4 review.
>
>     - Added r-b from Ulf Hansson to "Make set_performance_state() callback
>       optional" patch.
>
> v4: - Updated the "Make set_performance_state() callback optional" patch.
>       Now the case where one of intermediate domains doesn't implement
>       the set_performance_state() callback is handled properly, thanks
>       to Viresh and Ulf for catching this drawback and suggesting the fix.
>
>     - Added more r-bs from Ulf Hansson and Viresh Kumar.
>
> v3: - Added r-b from Ulf Hansson.
>
>     - Added new patch "Make of_genpd_add_subdomain() to return -EPROBE_DEFER",
>       which was suggested by Ulf Hansson.
>
>     - Improved "Add "performance" column to debug summary" patch by
>       correcting the formatting of debug output, which had a superfluous
>       whitespace.
>
>
> Dmitry Osipenko (3):
>   PM: domains: Make set_performance_state() callback optional
>   PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
>   PM: domains: Add "performance" column to debug summary
>
>  drivers/base/power/domain.c | 54 +++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
>
> --

All patches applied as 5.12 material, thanks!
