Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3482529DC95
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgJ2AbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 20:31:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39222 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387979AbgJ1Wbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:31:53 -0400
Received: by mail-yb1-f193.google.com with SMTP id 67so523104ybt.6;
        Wed, 28 Oct 2020 15:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tEpfJA/Z9AKrEVaajdL+QptYcnQ05daCxtJhgSiGjgE=;
        b=l9XoN6LYNC3x9xUohLGeJpFhQMXfNr78IAG9g/xgCeXfXelGdJ1YuxaU+fF8PVQ7O0
         YY15sOOW8xDPUeszMqr/18+OmcNwNsfBqCMDcBH6MyOaKV1jhk/bh3uCDjX3Ir/kmoDv
         w5BhDeeVLJ/i9awUuvu2PwIeiTda9+PJJWqpWwSFk2hjhgmfYlyXJW1Tr9FkR+iIWdQV
         3pol5fOp+/YCp3mhpoHBDnICoAxtvGFhwGGFRSzKrIRoKpAILEjL4wEi85xKBDJntFwB
         ONi8GjKqLScCDzE2ixcngT8kdm7laU9gDLvGS76lLXFoVG+blFnOCQ314Wnp1+FGr2jP
         IjUQ==
X-Gm-Message-State: AOAM53370wLcSDgRvL9MqFLCkOR+guyhgtjlXUcPXnqTIEvEW5oxcmjr
        ijVE78JFnQvjqA7kSjQLNnuDLfieCg==
X-Google-Smtp-Source: ABdhPJzMI0qpyEpldPp5Skmtq0XN2ZPZ/0VkR6YRCtR8HrbN2dO6boMbO257rWxdkY/LpYL4aX72Pg==
X-Received: by 2002:a05:6830:1c62:: with SMTP id s2mr5192386otg.177.1603898192374;
        Wed, 28 Oct 2020 08:16:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h135sm2598822oib.23.2020.10.28.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:16:30 -0700 (PDT)
Received: (nullmailer pid 4041362 invoked by uid 1000);
        Wed, 28 Oct 2020 15:16:29 -0000
Date:   Wed, 28 Oct 2020 10:16:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 03/52] dt-bindings: memory: tegra20: emc: Correct
 registers range in example
Message-ID: <20201028151629.GA4041307@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:46 +0300, Dmitry Osipenko wrote:
> There is superfluous zero in the registers base address and registers
> size should be twice bigger.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
