Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602AE2A9C06
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgKFSZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:25:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKFSZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:25:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id e18so2233143edy.6;
        Fri, 06 Nov 2020 10:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4e9xxWCUUkemhkYqMYZWqkqTifhMPb66C70SaoRt8w=;
        b=Ie4zVAZ6H24puCxEnsRvXriRhkDAwRu8FWhS+w/Hwi1vLFioAP0rt2jpz5wrKOEmTV
         sm+9JAokWvLeIXpNH7B2Ybq3lU99Pj7KsqnsY2Cou6Pd+i6TR4Kd8lfBEBGx1Dc0APqh
         EbXajrP/Eh6dDT0NVP9nTEYjV7Gq2k//Odxwmr+nI3kkwA9BHyIIsF5qvYuTYVsu68Cl
         G1xdWv9cUkpEEc1aIz9pLc3nT4DO3iC/NglePfwVVYKHUTkN9KkXrDryt5I9MsHhDDij
         vVwsfRUdKoVnffXU5zBD+Rfzcv6o0tZhcNly13JBgK/BzGn380m7q1w0kokGlzoiKQK8
         ShUg==
X-Gm-Message-State: AOAM530U7HMCfGDikRkgcciMiEDwkuvOpIr0CoPvd2CUz1xmnR66Xmiu
        Fk5zl8ioKfKjZovqTEIr3I8=
X-Google-Smtp-Source: ABdhPJwR2qKcQO2sO6AyYIsG/sCwIbE/ol0NFC503Fd5sXYO1Lhak+5D+Y+HdxZ8Y96i3i2KfUiW/w==
X-Received: by 2002:a50:99c3:: with SMTP id n3mr3432007edb.213.1604687139764;
        Fri, 06 Nov 2020 10:25:39 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id cn8sm1580968edb.18.2020.11.06.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:25:38 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:25:37 +0100
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
Subject: Re: [PATCH v7 03/47] soc/tegra: fuse: Add stub for tegra_sku_info
Message-ID: <20201106182537.GC65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:39PM +0300, Dmitry Osipenko wrote:
> Drivers that use tegra_sku_info and have COMPILE_TEST are failing to be
> build due to the missing stub for tegra_sku_info, thus add the missing
> stub.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/soc/tegra/fuse.h | 4 ++++

Thanks, applied.

Best regards,
Krzysztof

