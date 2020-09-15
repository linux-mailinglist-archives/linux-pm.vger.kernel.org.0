Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BE26B085
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgIOQlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 12:41:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32991 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgIOQjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 12:39:00 -0400
Received: by mail-il1-f194.google.com with SMTP id x2so3654056ilm.0;
        Tue, 15 Sep 2020 09:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTzkkYbk2jIELRszsQOMk/GOI+jJqqHog/KwqOMwjSE=;
        b=TMp9N4f+SfGlvQFLyW3JN/5pqas+0v0ac3JHD5+1Z1p08NFAIwlOkxqIJ+hDC1+hgH
         p0Ht37KMrG9ybD4slHhOOfeQ+EfZCGpCrHNmmKbeP2cx2/aVSOo8M6l4GhdtV+e7LeA1
         +M8T/9l4gFn/fbP7WyCUvYIxFxAfVTJ0FfXWfL2+74T+vLyin4ne7RKZhh2rw40bgr1k
         e4TXq/D7cQ75zammOVy7Ab2ReGZtxeH2dLVxq/Ayx6cc4DcC78lQS7Abb7qJStLXtH8E
         pRrN88yUzwUE37GPTPY/QKvTjegXAYdy6m4cg70iBS40dhSqxtUcb1FwUVsx13hKY99x
         5+Lg==
X-Gm-Message-State: AOAM531Vud46FUAvPS2JYz0RvY/gYVst8dm+wxJl9ucsqqXcqYfplbYa
        pweKGJM1phanFHt5T578rw==
X-Google-Smtp-Source: ABdhPJzIqXAg61MtcWBLixcRoN4fp/9lBLh2wQnLqX1wSfxxtFaTCOycI/TjvPHZeEQEoMB6pi7FIw==
X-Received: by 2002:a92:c60d:: with SMTP id p13mr12842226ilm.272.1600187939233;
        Tue, 15 Sep 2020 09:38:59 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z10sm7762968ioi.13.2020.09.15.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:38:58 -0700 (PDT)
Received: (nullmailer pid 2089328 invoked by uid 1000);
        Tue, 15 Sep 2020 16:38:56 -0000
Date:   Tue, 15 Sep 2020 10:38:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        dmitry.baryshkov@linaro.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document
 SM8250 compatible
Message-ID: <20200915163856.GA2089296@bogus>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 08 Sep 2020 13:27:10 +0530, Manivannan Sadhasivam wrote:
> Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
> hardware block which carries out CPUFreq operations on SM8250 SoC is
> called EPSS.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
