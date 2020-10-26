Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB4298D29
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772258AbgJZMvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 08:51:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37886 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775602AbgJZMvq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 08:51:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id m22so7858460ots.4;
        Mon, 26 Oct 2020 05:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vcZvKgWj3tvpCdWw11KvF34FDIuvpLAkBuN1aheOyE=;
        b=Gi0+8MZtJJfmCqMGjEWHn1JxrjZjNLDoLavqa7+91lRiLfrKcOWuxWgtBM3zugeUbF
         7MYRvAWMqhDG7VRSNEr7RJAOOVzLnbuJfx6dgllXdDVij1Rgviv35n9en8DZowCzxba5
         kuzLJE1vbheNQzEKUTpFCLSu03ElDQKbeUQJv920pbWXglm2SQE/G5kMiRfugt2vOvbb
         kczTgOvyQIfm2hNt/AIqlT2OQ+0znLodTIaCBL4X0kvQEapSZnttppVgyJGsM2UGK81X
         kpvuGE9v8buhRqDyu5poCoBxC7QnSa3AhMCfVFytLYXiTl8H6V2gWkJ4P30LPoYBkm2u
         hAgA==
X-Gm-Message-State: AOAM531My91CYwEXOBnrAkCEFlo6Z0p3WwjGylZlvX0SrT/4d3vsMvYB
        zp8M3yMttlvf/YJBbSDKmN8znFWT4w==
X-Google-Smtp-Source: ABdhPJwtQ8qXPYNncRhuW2K59WC9pM4KV3qQo7AARhnKaGe2bwX3DRc0S3phoNePbEXYmvRskbucJw==
X-Received: by 2002:a05:6830:448:: with SMTP id d8mr8698533otc.318.1603716705097;
        Mon, 26 Oct 2020 05:51:45 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm3524919otk.39.2020.10.26.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:44 -0700 (PDT)
Received: (nullmailer pid 4170335 invoked by uid 1000);
        Mon, 26 Oct 2020 12:51:43 -0000
Date:   Mon, 26 Oct 2020 07:51:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Viresh Kumar <vireshk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/52] dt-bindings: memory: tegra124: emc: Document
 new interconnect property
Message-ID: <20201026125143.GA4170168@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-14-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:56 +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> External Memory Controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
