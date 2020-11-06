Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE62A9CDA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKFTDT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:03:19 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36380 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFTDT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:03:19 -0500
Received: by mail-ej1-f68.google.com with SMTP id o21so3382124ejb.3;
        Fri, 06 Nov 2020 11:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kot8kZc0OoLSIdtPIJkItSeAVUsLH8jfIBWVordG8WA=;
        b=UD1b3jdYou1rh9g0gtHhezPMhL2z2v8Gm0I+0W2WC+YF96jJauPymtmKXSY9dgtfJS
         rNnap+mE52pJKehyjmyv4CWSTkn1YKp9SdUMhRqgG4OaacmghIwnONsFxZZP0TMo2ifm
         54Zg/8GXm33eWIdANqYMp+O44VFf7NI9fSCuRRuRyNsYQmNM9jE1/By/ixZ8kezafU4H
         fLwVKTrlqcSYR5pk7HMMiCdVpslX/MQrSthvYw6xFNdTVJp79kyuQLRbHNOtLwz4UgWX
         UuDbKN379DlfEJSMhDHSq0xU+avEKFpU7qgoxNn5zSONluezAxvDp4EQHQV1AGrugFMm
         WUAQ==
X-Gm-Message-State: AOAM531PVfW4ZjdmAue7B1+2fQq+0aID0QQVgPDvIw9dCBPWBnH30WMe
        11f6lhK6kGI+Q2Kk1RRoqKA=
X-Google-Smtp-Source: ABdhPJyzZFSvKRmos065v7SwqPjBrgmRBmqByQsxDP3z8YoQaaeMcq7BVHk4SgmPCSXtFI9Hjt9bkQ==
X-Received: by 2002:a17:906:934d:: with SMTP id p13mr3387110ejw.245.1604689395474;
        Fri, 06 Nov 2020 11:03:15 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t3sm1636975edv.59.2020.11.06.11.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:03:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:03:09 +0100
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
Subject: Re: [PATCH v7 29/47] memory: tegra: Use
 devm_platform_ioremap_resource()
Message-ID: <20201106190309.GU65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-30-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-30-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:05PM +0300, Dmitry Osipenko wrote:
> Use devm_platform_ioremap_resource() helper which makes code a bit
> cleaner.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 4 +---
>  drivers/memory/tegra/tegra20-emc.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

