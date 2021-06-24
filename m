Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7183B2608
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhFXEKU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 00:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXEKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 00:10:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60440C061756
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 21:08:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e22so3614859pgv.10
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTKcj1FwASbYIRc1/4RcXOYrrjpE/CHcjYdGKeIf8y0=;
        b=bkARmClXxH+0Yp4W2H7QZckNr5cVnBMFrbJzhhVlZG5Noxtgliy26pRjw39wh/fzKI
         OdF4XXnb/lgKyaNdFP39LECTpsALyNTtV9Ej1xshfgQ+hOStmbb0ouCfgbXvmp1HZvMs
         ae5oskgxJkqX0pHkq5DVfRx4WGmuUzUSVmC/Q5FKluFcWYCg3N1miPMavU6wxJXoxN9d
         0XCSCClYMlBLNx4Pe2JC5u17jWVHquwGcVVQf1gXieZv95/YE2NYv4vJ/3zl4UK+0fIR
         hD0NppjegsjWM8XGTO87IFwWQKYlpXIYJFTKyaRrDNVpQJZ3Kh4NnSj+ZZMFwuCKua5X
         mpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTKcj1FwASbYIRc1/4RcXOYrrjpE/CHcjYdGKeIf8y0=;
        b=ssb6sVzq0BemOiOS56EZuubMZGgo8a6thOImCZRszZ0Zhdq+Y0yZqGbMpWtsQUfF7A
         xZ4NfhzMpBQz8Md8zQtr5xe87sx607p9ttdEU8JhR19xqZmzBI//W1pXa5ymKvSe394h
         e5niNd6FapPf4VYeNy9eTFYkbBoPauhWfuNhrP6EwZqcbCO9kAcrg7izozYvAuYGC95u
         zWKtb17ibeskijEeCODfp+O9hNXzVpy+ET/HLdDSWoVE08SPvRvpARkYuW0n2NV80syG
         uKra61J2UFj3xbRSyfJ+BNDbYIoR+MbMHE+mnpz0t5hTUgrx996ts6Gi1Rayg0fv0Qya
         23tA==
X-Gm-Message-State: AOAM533WQMSH+RRNza0UAsCCScz5M16TAmwqb4TqeA7rzZtMePwckeeo
        TTbMtpCNxuJ4f5MFh5XhUE1Htg==
X-Google-Smtp-Source: ABdhPJzjp/1AjHOU55H1hkl4o3axEnthy6y3MWTgaD7g0SNM61aPxVBFMcFv39k+xyxHoK2yHEFXwQ==
X-Received: by 2002:a62:3344:0:b029:24c:735c:4546 with SMTP id z65-20020a6233440000b029024c735c4546mr3110132pfz.1.1624507679891;
        Wed, 23 Jun 2021 21:07:59 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id m18sm1251125pff.88.2021.06.23.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 21:07:59 -0700 (PDT)
Date:   Thu, 24 Jun 2021 09:37:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up OPP binding node names in
 examples
Message-ID: <20210624040757.svquigqw2tjeb7ij@vireshk-i7>
References: <20210623230722.3545986-1-robh@kernel.org>
 <20210623230722.3545986-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623230722.3545986-2-robh@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 17:07, Rob Herring wrote:
> In preparation to convert OPP bindings to DT schema, clean-up a few OPP
> binding node names in the binding examples.
> 
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml   | 2 +-
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml   | 2 +-
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml       | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
