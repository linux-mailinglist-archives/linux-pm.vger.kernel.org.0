Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD612A9D6F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgKFTGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:06:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33165 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgKFTFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:05:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id v4so2350378edi.0;
        Fri, 06 Nov 2020 11:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MXPmT1NGSQgsd3xirj8ip4/fNyUlJygAvFJgBo8pUw=;
        b=P13LfQxii9kBBQjfenTsnIGYQ5vhGCNAiijBrmMWlJMe6ee5gl4poKQ31vvcNdH588
         TeDRXcSuVZjFEBbBruhfeuXPIryB1VJabU5PUUxXz39cJN+CVhlFU0rf1bbiQlnRbL1f
         zCu3bOOQ6iYv6FIUYj9w9v0Hao+w9xfTWhQf2kpeZ2mL3DDIqp8AiDa9wG+QtpOgLmGJ
         ktXbpFSe4goOjC2fle4rcR+ExF8/1WzH2YBTGV876/8M7TqzE6qtgEf5SsRd2R+LJWeV
         zwbptCfMJxPPCFqSsP/PUecKNg7rjGU3vej7ocjgt9TtJO/LowpxUJUXnFKGBWtbADFp
         D9jg==
X-Gm-Message-State: AOAM532UAZuMXXRYFi3dyvpuEXuFpH1jtOF4wU6Jsp6CBE0/gMntRDLP
        S4HODoxOmygNAgLIKfCqSQk=
X-Google-Smtp-Source: ABdhPJz69R2gdRFIosU2NLTVPnddKtDP+M+uLghaYEtmdn2y8rrTOtAPAwVEj93zlI+Mhji4/oFSTQ==
X-Received: by 2002:aa7:da81:: with SMTP id q1mr3541263eds.14.1604689549687;
        Fri, 06 Nov 2020 11:05:49 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h23sm1542924ejf.120.2020.11.06.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:05:48 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:05:46 +0100
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
Subject: Re: [PATCH v7 31/47] memory: tegra: Add missing latency allowness
 entry for Page Table Cache
Message-ID: <20201106190546.GW65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-32-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-32-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:07PM +0300, Dmitry Osipenko wrote:
> Add missing PTC memory client latency allowness entry to the Tegra MC
> drivers.
> 
> This prevents erroneous clearing of MC_INTSTATUS 0x0 register during
> of the LA programming in tegra_mc_setup_latency_allowance() due to the
> missing entry. Note that this patch doesn't fix any known problems.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra114.c | 6 ++++++
>  drivers/memory/tegra/tegra124.c | 6 ++++++
>  drivers/memory/tegra/tegra30.c  | 6 ++++++
>  3 files changed, 18 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

