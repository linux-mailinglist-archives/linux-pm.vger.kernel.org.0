Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA22EB0EE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbhAERET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 12:04:19 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36756 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbhAERES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 12:04:18 -0500
Received: by mail-wm1-f49.google.com with SMTP id y23so222993wmi.1;
        Tue, 05 Jan 2021 09:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6KIIJ9J9dzDzP5DUFlGPnwQ7nEofIeMZEzRkiVgqQM=;
        b=H4MV9vL3a8BjUFOmmmEkWiWStkDk21LRLsZBVpaTg1gguqdBcekChtrnYJYqUSgVz6
         8tj9wpQ46Bo48x5yWdID1+YHCZw8LFu+gzfDi2+98R8KjNZDxTLlEUlxB9ZJKY5efMS/
         fhuwG4fHoZLqFTAhRHmHejyi5oX4XPbT+MhmcxHsuJCMIWwg9Z5W/Z3MjzqL9g9iR3UL
         pdulfqIrE0nbA6M5PwRVhsHQ11EXWj9tnA0O7F+YxTMJ9UXac9gKFF1pjo6tc7qW3BO/
         fUVqtAo3YBGA92tHFmAaWXIZxbQWDNSmLZ7NiNnPAbnSaHRobeHfnd6bu9YV/2QZDVdT
         WHJw==
X-Gm-Message-State: AOAM5306suAhf129tcNqvF7hinbKn+n7+6onnM6CvRTQbjgkkRtrLofu
        ztmlwOJgrwfjCg8dzrg7v4wER8qpYdVnDQ==
X-Google-Smtp-Source: ABdhPJxIvlNTGgGlYnSrfmBt1kSEImmptJoCJfWMJoE92dAAzlqcVazWUcMl6D9BuAaEKCQtH3p/Sg==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr116341wmk.92.1609866215958;
        Tue, 05 Jan 2021 09:03:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v20sm119655wml.34.2021.01.05.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:03:34 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:03:33 +0100
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
Subject: Re: [PATCH v12 3/5] memory: tegra124: Support interconnect framework
Message-ID: <20210105170333.GC20651@kozik-lap>
References: <20201228154920.18846-1-digetx@gmail.com>
 <20201228154920.18846-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228154920.18846-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 28, 2020 at 06:49:18PM +0300, Dmitry Osipenko wrote:
> Now Internal and External memory controllers are memory interconnection
> providers. This allows us to use interconnect API for tuning of memory
> configuration. EMC driver now supports OPPs and DVFS.
> 
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig        |   1 +
>  drivers/memory/tegra/tegra124-emc.c | 320 +++++++++++++++++++++++++++-
>  drivers/memory/tegra/tegra124.c     |  82 ++++++-
>  3 files changed, 391 insertions(+), 12 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

