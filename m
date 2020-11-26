Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63C2C5B32
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404576AbgKZRz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:55:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38155 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgKZRz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:55:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id p8so3033347wrx.5;
        Thu, 26 Nov 2020 09:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nw3y87ME4kLFOBelPCVhRVLaq0rU7AhnhKmSPxT48ss=;
        b=Jeo2lOATOpTN8qT2zBFHe+MFlNZ9MEtsGYKbBMBElkMxYJgIzEiG9smbwLoR3ZOwPu
         yxvWC9qZTHD0cscS75yJcyghqSxhOVI57zT2MD9B+ZT6YzjHECRpqu4XOTpTuEnNrXP8
         COQIFEt06w2QUY9GwQOD9Sufrw0WRCZjVR5gCDb63XM0Gg0kMkgd9ekvEaRUOP+DITNb
         AN41ipH0JWXa/WXfwWv1tQdD7ftS+qoPTUx9zsWBGX9hpC91dsRS+RGmYiOuvmvZKT+2
         2m/eFS577RyLSI5we6ZVOIi5pPlF0brVDBQEbXM8OIVF7en2Kmx9muGl3+CY1gbO0ygP
         3jLg==
X-Gm-Message-State: AOAM533H/pHkxTXP6AvCz6wR0W0H7aRfUhNDX9116evqs8XBn1+QEh3D
        GmM+pNWNzlLI8xTfR2ppPLc=
X-Google-Smtp-Source: ABdhPJyRbSg8O2uAUT0FOGOUqCXGV7l/CoBNIz1DnekSFgyECeihUjeyIMSvsXzxmRR47DGB626VDA==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr5182639wrt.402.1606413354695;
        Thu, 26 Nov 2020 09:55:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y18sm10307692wrr.67.2020.11.26.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:55:53 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:55:51 +0100
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
Subject: Re: [PATCH v7 19/47] dt-bindings: memory: tegra124: Add memory
 client IDs
Message-ID: <20201126175551.GC17141@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-20-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-20-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:55PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra124-mc.h | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
