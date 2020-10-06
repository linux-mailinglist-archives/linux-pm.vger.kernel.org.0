Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7509528527A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgJFTdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 15:33:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34387 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJFTdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 15:33:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id d28so7127197ote.1;
        Tue, 06 Oct 2020 12:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vr0kh5Yxt0ub2gjD/7iyTdno80qJHwUQsM63YCqKmPE=;
        b=NH6tzrB/M9/29bFwH6AjtwdZ8KtGXCMe677oW2Gm5J+KwZpZ7S0NjwuFuhSXxotZj1
         sWa/CkxSGJ6ncmNDKq5T+YMioOINq+1p2YdSoJHumcaGF+SbPa87u9IHPWBKDUkohDnB
         O77S3PEE7/FBZhWVAYR2WRAatKkBboGW4ybrNZkbBPUsAozWMk4Ghz1wvdm//UpC/zre
         rtnWg60orniGcWMQA/06w86lrTxRfqFVm4P4ehB+NxDJYk/nXSfhMh3ZFEXnwYNzi00v
         A/nTjnztRbuK8wGpa/FTLfG3hgqTxAf2Ttf2zT4eb3soZ9sNkhMZ0BJj94K46S4jcle+
         aJjg==
X-Gm-Message-State: AOAM531nvzMPVyN6t5nWrkQDujZiIeT5RKZP+PrMdTVj9tmMKFdR60LB
        KWjDAv4uwVEOgbWLMC6B8zVhfD5QJwyw
X-Google-Smtp-Source: ABdhPJz+7hDASH5s1uaYlFg8P2NS0UoUxaBOu1qyfY2bBXP9RS81Vr5QtD5xZcp7K8YqiXsh+Bt+Hg==
X-Received: by 2002:a05:6830:1e30:: with SMTP id t16mr4070247otr.18.1602012788414;
        Tue, 06 Oct 2020 12:33:08 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm1729470oig.54.2020.10.06.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:33:07 -0700 (PDT)
Received: (nullmailer pid 2693469 invoked by uid 1000);
        Tue, 06 Oct 2020 19:33:06 -0000
Date:   Tue, 6 Oct 2020 14:33:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, stephan@gerhold.net, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: rpmpd: Add MSM8939 RPM power
 domains
Message-ID: <20201006193306.GA2693413@bogus>
References: <20200930100145.9457-1-jun.nie@linaro.org>
 <20200930100145.9457-2-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930100145.9457-2-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Sep 2020 18:01:44 +0800, Jun Nie wrote:
> MSM8939 has three RPM power domains: VDDCX and VDDMX and VDDMDCX.
> Add the device tree bindings to manage them through rpmpd.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.yaml          |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h                 | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
