Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45542A9CD3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFTCl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:02:41 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46265 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFTCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:02:40 -0500
Received: by mail-ej1-f67.google.com with SMTP id w13so3347802eju.13;
        Fri, 06 Nov 2020 11:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8fJ6aT95U2Kr2dF0nwO3w//9X26eAmb1JExBHrLZmo=;
        b=Fv+YjQaej7SE19oRqknTs66YJFx7Rd+IiR/yk+E9LZM0Ox18KF8sRZITlV0mQFc4Pd
         gG4wN0GdIPQfgCI9+Cz4g2JB6ALAOv75KCLfR3Nz/6kkLZoVAwkZkni42IqLfK/1EV7P
         tIqk1HRITmScaqbjEzKYTtOYnmf0WhXMVqfq+H1Gp9jT46cApTEVmJxZR4I9N/+ltvYI
         D9COJWUJwis2dik47QLe2e3qZH7jOeTTK9+Ysakbqot+g8gFNbtPMopPEVTJilH2kaGL
         55dw0SVa1eEgOSrViAZYU57ekY2JzjWO5IfSRHcakaBatDqlmsocZNRl7y690zFtMuEC
         Janw==
X-Gm-Message-State: AOAM533FIOcGvc9DgXbdzI3ozBd3W9V1QbEauFFq+UJKoJAGTXOKFaCB
        0Bl3mINe472U6DD+fzoVzYM=
X-Google-Smtp-Source: ABdhPJwqfVAOUVIAC5jm3/QiJARCUlh+nQ9bk1fbmTNCT4ukaRUQooVXOHfg0xXjKColincTj8d/Tg==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr3610847ejb.114.1604689358401;
        Fri, 06 Nov 2020 11:02:38 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id rp13sm1529896ejb.79.2020.11.06.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:02:35 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:02:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 28/47] memory: tegra: Add and use
 devm_tegra_memory_controller_get()
Message-ID: <20201106190234.GT65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-29-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-29-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:04PM +0300, Dmitry Osipenko wrote:
> Multiple Tegra drivers need to retrieve Memory Controller and there is
> duplication of the retrieval code among the drivers.
> 
> Add new devm_tegra_memory_controller_get() helper to remove the code's
> duplication and to fix put_device() which was missed in the duplicated
> code. Make EMC drivers to use the new helper.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c                | 48 ++++++++++++++++++++++++
>  drivers/memory/tegra/tegra124-emc.c      | 18 ++-------
>  drivers/memory/tegra/tegra210-emc-core.c | 39 +++++--------------
>  drivers/memory/tegra/tegra30-emc.c       | 18 ++-------
>  include/soc/tegra/mc.h                   | 10 +++++
>  5 files changed, 74 insertions(+), 59 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

