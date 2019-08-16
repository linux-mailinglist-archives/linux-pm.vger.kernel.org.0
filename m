Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF090A38
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 23:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfHPVVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 17:21:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38221 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfHPVVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 17:21:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id r20so10891892ota.5;
        Fri, 16 Aug 2019 14:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8d2xPIoqu5OxXnPpgT9R1YUlAnIO+kOwK0U7SSgDuxM=;
        b=K/SLK4dr/nWq6TaHWd7EVZ7GKShADxvVoCxbu8q6h9EmQ590Dh1PpchMHXWYtRfWqQ
         kRlHKJFTmP1rkZXTTMzWDop6zG58RBAcv7gvTWmUyL7EKK5ZTivi1w1ObS2/PiNkarl3
         GPvHrK5+aImVQOiz1x/CYujcBly07r3DSHzoN9Xf0off0j3/JuQb/yT0il9V+KY26u6Q
         DP6rJAeFC52lgVrw54fTZRn/gVgkJrJhG701IdnYpBNuxxezJcNuswhnRWaSGAwNxUMn
         Ju5O3RmDCxvZ+CjSoPtqAWWhTea5wtj/2xmXaPssRXPHRBh40gLxRKL2leP2PVTpafY5
         sfKw==
X-Gm-Message-State: APjAAAWnquAnC1sej0r7YsLSlpV4Sknt+qXIlaSAZzMXpUIVXFmLvVIc
        HQuI1NNlxhmvOT+M9i2X3JKBQdQ=
X-Google-Smtp-Source: APXvYqx/nOO00WsRba+oPRObLtU4yVpIIimg/R3kkezJQFXtQ02NkVL/lFTIc32u6tnYB8Caqeg/7A==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr2356135otn.284.1565990491234;
        Fri, 16 Aug 2019 14:21:31 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id f2sm2559967otl.74.2019.08.16.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:21:30 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:21:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] dt-bindings: cpufreq: qcom-nvmem: Support
 pstates provided by a power domain
Message-ID: <20190816212129.GA22090@bogus>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-7-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-7-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Jul 2019 12:41:34 +0200, Niklas Cassel wrote:
> Some Qualcomm SoCs have support for Core Power Reduction (CPR).
> On these platforms, we need to attach to the power domain provider
> providing the performance states, so that the leaky device (the CPU)
> can configure the performance states (which represent different
> CPU clock frequencies).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
