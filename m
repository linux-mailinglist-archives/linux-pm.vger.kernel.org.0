Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A842A9BFF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgKFSYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:24:38 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40849 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgKFSYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:24:38 -0500
Received: by mail-ej1-f65.google.com with SMTP id oq3so3216329ejb.7;
        Fri, 06 Nov 2020 10:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxPvn+tRErECnh3tRjRGtBK4eFiK5HVLTI2eNBJW3tI=;
        b=aSL50s9COxThaCTTyt7v0IkqundQg97Vp1vu7qGcPaxAvZyJkoiYTdp9I8t/pkzlyp
         qSzKYQYnXhlv8MV1lkKOnXI6tqIUutmjjFzdfPtQLc/Lf+xU38arLKTLH17OlZEhh9dN
         Qu7lDaO7Eyo8Ri5bld/Oxdw3XRzrAGiAZIcD9gKIEi0M00wa3OKPj9v2GUltBwMjtgRn
         sTyHpg5wZz/XJFG1raQIUCBQwiT3Mh16rUAsF+jIjp+xffKHWkhNjNZDwwjbsRlRQxVP
         tcOphkwAqxqJAWtrIKFHJGY0xB+gi9OaARIXjZSr7WxRRU5eg9K4uJubLDGwyWX40cL7
         jTYw==
X-Gm-Message-State: AOAM532u0k6Q2cbVx2EtlJ5WbIy7H8sYAjHj96s+wEtTmQ0gv8AN7ZW/
        N9omn3QN6+p0ODkYQGM1l1Q=
X-Google-Smtp-Source: ABdhPJyjgo5cj5F+nU/zODSqD5zCt0sBTU4NCkQ3Gvk7fQMeVD8kVRoQuGZ9DreX9sbOHWgb7FGJ3g==
X-Received: by 2002:a17:906:8485:: with SMTP id m5mr3504379ejx.205.1604687075876;
        Fri, 06 Nov 2020 10:24:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k23sm1473606ejo.108.2020.11.06.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:24:34 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:24:32 +0100
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
Subject: Re: [PATCH v7 02/47] soc/tegra: fuse: Export tegra_read_ram_code()
Message-ID: <20201106182432.GB65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:38PM +0300, Dmitry Osipenko wrote:
> The tegra_read_ram_code() is used by EMC drivers and we're going to make
> these driver modular, hence this function needs to be exported.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++

Thanks, applied.

Best regards,
Krzysztof

