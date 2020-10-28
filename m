Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41BF29D9DC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbgJ1XE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:04:26 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39777 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732874AbgJ1XD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:03:58 -0400
Received: by mail-yb1-f196.google.com with SMTP id 67so580086ybt.6;
        Wed, 28 Oct 2020 16:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2bISq6eLdcKMjNlJcKgIH+JW7IlvZPJABIB1hmk538=;
        b=Rr+N2aWWFilsMpaK/q/YSaQ0VLQ4L9nAcxY/2dhS8sq455eRRFs1Z/GvsAjN1/Jn1w
         burA/5KTg7SOl074bw8Y1uv/hD+La0PFrwh+6QDnNaYSQsTVP+vz5XcdptPyxHODQO7l
         44OrbOfqBPLg7I2gRKkcKoXYDf+FKLLqkAEOibbpRthtWNHdqGhrVVYB2N8aqHf1jGcD
         4JvhG+KXWl9cTGK6e+NJq4fLHq26N508LW7l5anNJse5g1e36qVnfC5gPSbZTCDfZmAr
         vPgvFQOQvxm1kdPcaabcVZVv4VCoXo7HFHPNYv4Cve1y4Lrm4JXrp8rJi8XO6EoKc39o
         J5pg==
X-Gm-Message-State: AOAM533IjHbJkoIFNDugzmE4Pv0USREtzbPOW+pdJzfElIbOSsVC5NAA
        H3ezkLIqjjQug2F5EuCJZ8DpI+pylw==
X-Google-Smtp-Source: ABdhPJxePufEKBxPy5ldMaGUPclbtmQjjTrYKwN9UnqPeafBvzPio38FSAsVM02kNVp5/lFXZ+YOiw==
X-Received: by 2002:a9d:6aca:: with SMTP id m10mr5654973otq.282.1603899015746;
        Wed, 28 Oct 2020 08:30:15 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x14sm2656085ooo.43.2020.10.28.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:30:14 -0700 (PDT)
Received: (nullmailer pid 4059892 invoked by uid 1000);
        Wed, 28 Oct 2020 15:30:13 -0000
Date:   Wed, 28 Oct 2020 10:30:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel@lists.freedesktop.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: Re: [PATCH v6 14/52] dt-bindings: memory: tegra124: emc: Document
 OPP table and voltage regulator
Message-ID: <20201028153013.GA4059862@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-15-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-15-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:57 +0300, Dmitry Osipenko wrote:
> Document new OPP table and voltage regulator properties which are needed
> for supporting dynamic voltage-frequency scaling of the memory controller.
> Some boards may have a fixed core voltage regulator, hence it's optional
> because frequency scaling still may be desired.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra124-emc.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
