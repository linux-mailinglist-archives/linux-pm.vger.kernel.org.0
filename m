Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBF29D625
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgJ1WL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:11:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35661 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbgJ1WLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:11:55 -0400
Received: by mail-yb1-f195.google.com with SMTP id m188so504089ybf.2;
        Wed, 28 Oct 2020 15:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8MLPXzg2SZx9c5xJhUu8LnS9OjmrbIOKKCNscuh58o=;
        b=HOXi0BWmmQuKMoTzj0yDIlJF6ZWhxNG4O12J5pdvyoobkGFfTWm8mvkPSs72NN53nD
         MU6xAziewhZwQX682lWYaD7umS/oshawRcoeGVCE2jSUiASeL9dHN6CdYEDo82Hezxu2
         BwbvabQo8cERzT8xiA37gq1DKp1iz6GB8zy+I/mCZpgeeNEXtd36Ic1UoKPz9tpiMA1R
         ibarWJaZUT7vysKoW6zDIFpZ6nEZZ95yd4M6hqqXWNv5H1VefXQQP7dUkrPRHXzrJwNJ
         hGFp+LiUhmrUgKsHiQh6qYTQxRt+JxPRlwzoP2oDLvxlCcPjIC52x97mLn4nEeF+40Vi
         2cvQ==
X-Gm-Message-State: AOAM5327QgqUKDQ9ITSWjmo3N0yLNydIxxYgUZKehtLe45oKGfCeG0AM
        OOFW3w3YNNck6T4GcmVUGdUFxR3GGw==
X-Google-Smtp-Source: ABdhPJz7reJgOyNPbR/RoD8e8RtXXbZyuobF3ZC3HQeIbo0bO8WjCWxfxCDoSnL/csJ+nowSt3xcZA==
X-Received: by 2002:a9d:6307:: with SMTP id q7mr5698617otk.218.1603898611758;
        Wed, 28 Oct 2020 08:23:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm2703272oos.19.2020.10.28.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:23:31 -0700 (PDT)
Received: (nullmailer pid 4050728 invoked by uid 1000);
        Wed, 28 Oct 2020 15:23:29 -0000
Date:   Wed, 28 Oct 2020 10:23:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia, memory-controller property
Message-ID: <20201028152329.GA4050679@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:47 +0300, Dmitry Osipenko wrote:
> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> behind EMC and these controllers are tightly coupled. This patch adds the
> new phandle property which allows to properly express connection of EMC
> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> par with Tegra30+ EMC bindings, which is handy to have.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
