Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326CB29DBF9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgJ1Wq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:46:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39256 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389132AbgJ1Wq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:46:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id u127so1276251oib.6;
        Wed, 28 Oct 2020 15:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CzfvnivIEtvj6xKXXqKUjstXdtKoBRAAdit4qN1a2I=;
        b=TANWwb/Q46eeKQrzUUvsUW5/Wyh401T0N3Ntu7e77muax5MRoSgOhHEBA0pxzS9dK+
         YhOWRsp9ghpY+8RBoSbmjcH9f6/LzX4qJa4hneI/YR/QR9t+lY1xVwnyBtQdAXejK1mQ
         xBy7RKYl1DOCSgyjkAtN/1GmzUqOyWpAI5AgtN0lBnjQQn0gkpBoWhv/Nt95NnDhXiCL
         efpEqCcKQk2JdIz1LtIlNDRIVBsDEy2KPrqC8/OSkEtapnvijPHo1VVF8Q1HaxSMA4iQ
         DK0eLANuK9KE9qKD5dGfvKLiQTpeQ6sdvkVyaiFFRI/PTBl4jB5fzC5CxNK4abL7LxBR
         koKQ==
X-Gm-Message-State: AOAM532/h0OyBvvQbMknI0Q6wEKR1pLREOjUZR32K8jYYPWE3akwYCBA
        t1Jollp86F+8rzW+BFnelSDDRI0X7A==
X-Google-Smtp-Source: ABdhPJxE9oU+7OVIoCWc40SC7yS+EHHKpQBId3YfoudCOvuyyuURrzX+lBd6EBrH1r3aDJcLC8qKgw==
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr5868175oif.60.1603899057838;
        Wed, 28 Oct 2020 08:30:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h14sm2078172otl.0.2020.10.28.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:30:57 -0700 (PDT)
Received: (nullmailer pid 4060952 invoked by uid 1000);
        Wed, 28 Oct 2020 15:30:56 -0000
Date:   Wed, 28 Oct 2020 10:30:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        dri-devel@lists.freedesktop.org, Viresh Kumar <vireshk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v6 15/52] dt-bindings: tegra30-actmon: Document OPP and
 interconnect properties
Message-ID: <20201028153056.GA4060899@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-16-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:58 +0300, Dmitry Osipenko wrote:
> Document EMC DFS OPP table and interconnect paths that will be used
> for scaling of system's memory bandwidth based on memory utilization
> statistics. Previously ACTMON was supposed to drive EMC clock rate
> directly, but now it should do it using interconnect framework in order
> to support shared voltage scaling in addition to the frequency scaling.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
