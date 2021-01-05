Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438D2EB0CC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAERBS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 12:01:18 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54490 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAERBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 12:01:18 -0500
Received: by mail-wm1-f47.google.com with SMTP id c133so181755wme.4;
        Tue, 05 Jan 2021 09:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rC/3bBxHEIoV+vCWk7wHGZGDIhbhtvFgEsPrKfdLoY=;
        b=hw8SjIn7ZZAiQg+KPj+0sr42fp7WBCNyjq4dSLVZ5WKQBRW6kUReeUc/y9f2V1ekQh
         wAkP+VIOD1nHg4QRnrWtLyWqsqyLdIO5QBUKQAL5EzN9dGAocH163bQVh4Ub1Df+N9md
         rCJsbQALshUulrECHD5X1eKhS5E8nlCcr0lWOO3Fcw4wjWgOFc9u5wSWbJRuHr/x+hqg
         rEi3nqCf/Txjt/udJwFfrQMEWiX2rNJwQVNgd74agabzuoOuutNTxpUE9PDri9O4xOA0
         9b9/j2H5xPzS5d1WUwK7pxVTHkNvAUewB/fdoxKZF3OybeJK4YB3uYKEaIhg6ndqO64j
         kRaw==
X-Gm-Message-State: AOAM531NKZCkKdZonCOs7lQsT+Z+WioBx+zzIPXn2Xor0h6/0UnsOblK
        2OQ8FnaQUpSG3aitLjKEm04=
X-Google-Smtp-Source: ABdhPJxdVH4thBYworKTK5cQ7fRcnmHTI41liWkhfpAJUMLfKGjI41wNdUX5PAVtai0yLCgciW3qMw==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr53095wmk.139.1609866036070;
        Tue, 05 Jan 2021 09:00:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b127sm119430wmc.45.2021.01.05.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:00:35 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:00:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 1/5] memory: tegra124-emc: Make driver modular
Message-ID: <20210105170033.GA20651@kozik-lap>
References: <20201228154920.18846-1-digetx@gmail.com>
 <20201228154920.18846-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228154920.18846-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 28, 2020 at 06:49:16PM +0300, Dmitry Osipenko wrote:
> Add modularization support to the Tegra124 EMC driver, which now can be
> compiled as a loadable kernel module.
> 
> Note that EMC clock must be registered at clk-init time, otherwise PLLM
> will be disabled as unused clock at boot time if EMC driver is compiled
> as a module. Hence add a prepare/complete callbacks. similarly to what is
> done for the Tegra20/30 EMC drivers.
> 
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Kconfig            |  3 ++
>  drivers/clk/tegra/Makefile           |  2 +-
>  drivers/clk/tegra/clk-tegra124-emc.c | 41 ++++++++++++++++++++++++----
>  drivers/clk/tegra/clk-tegra124.c     | 26 ++++++++++++++++--
>  drivers/clk/tegra/clk.h              | 18 ++++++++----
>  drivers/memory/tegra/Kconfig         |  3 +-
>  drivers/memory/tegra/tegra124-emc.c  | 31 ++++++++++++++-------
>  include/linux/clk/tegra.h            |  8 ++++++
>  include/soc/tegra/emc.h              | 16 -----------
>  9 files changed, 106 insertions(+), 42 deletions(-)
>  delete mode 100644 include/soc/tegra/emc.h

Thanks, applied.

Best regards,
Krzysztof

