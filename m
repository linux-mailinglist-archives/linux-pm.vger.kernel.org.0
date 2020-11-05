Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D52A8787
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgKETsr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 14:48:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45764 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 14:48:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id k3so2554385otp.12;
        Thu, 05 Nov 2020 11:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3AlClqo4zPa2hQPAiQZhyszXRgNsf8T2hjWUGDP4o4=;
        b=LRx6tMxLd2H/umahnXoqi/vOiTFdwnizEGgBoiw47k9VCBhugd8CoYMC5HXTuhRZSj
         7BdPwcEmPsYDtYo7/aHa6NfE/GzDBSmyL6gi8XYBA/NnFBajt5PAZ0/lhPGgGeBOZnCs
         08q19CJJTG97Yv3fxcAecu0rJJISnHc8511tjSSSRAyLSR0ckc9HDFC5UM/7cQ7MIwWK
         d+yv+oFxKDFWkEKWmc8iKwjeo6U/RgEa0h3050RoF+wtBlzh7ClbVo6l+xJcyz3uLvVy
         HJ4y/nqCqnnMYzvkAp5676/ROV50N1KcD7Lzut/27Hifxo2sMM5nLWjZ9XNl6ZoU4Jq7
         ZbEg==
X-Gm-Message-State: AOAM5322fDyyNgWH692TLAoXYi/SlnpzimFEkTh2p0F9PzY9yVGhzBkZ
        cSAVH4CPljiLeT2FBsUN7w==
X-Google-Smtp-Source: ABdhPJzRzA3D64elj+tDd0ByzlwywJPSGiowQOvdrEbTMVjqHpwNJiFwtb6dVDRuPY1Hq6DQ3xc0yA==
X-Received: by 2002:a9d:1727:: with SMTP id i39mr2629158ota.96.1604605726134;
        Thu, 05 Nov 2020 11:48:46 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d22sm576191oij.53.2020.11.05.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:48:45 -0800 (PST)
Received: (nullmailer pid 1701068 invoked by uid 1000);
        Thu, 05 Nov 2020 19:48:44 -0000
Date:   Thu, 5 Nov 2020 13:48:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-pm@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v7 08/47] dt-bindings: memory: tegra20: emc: Document OPP
 table and voltage regulator
Message-ID: <20201105194844.GA1700597@bogus>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 04 Nov 2020 19:48:44 +0300, Dmitry Osipenko wrote:
> The SoC core voltage can't be changed without taking into account the
> clock rate of External Memory Controller. Document OPP table that will
> be used for dynamic voltage frequency scaling, taking into account EMC
> voltage requirement. Document optional core voltage regulator, which is
> optional because some boards may have a fixed core regulator and still
> frequency scaling may be desired to have.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
