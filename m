Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B10421D38
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJEEY4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 00:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhJEEYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 00:24:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4AFC06174E
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 21:23:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so11867577pfc.10
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 21:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FIDE+itK9PP/6qNSejIUv8DnzpCmOGBNCkTKxdd1fCo=;
        b=dfUf/Rh102+RBR6eL8TEn2XI22uyXoD9tI1sUkm8ZogEYUv2UhSuYuPNznT9WkpMYc
         TRyPkBBi9TtwKrVbtHrowzZ8zvbEAdP1LYfoAEyylRNQW3NZpV1jz5uG35Vf7C+RLuli
         NKv1kgrIczdpj4K1zEcIx7RQ/Kdc26MhVy0oNJzUx/Z9Mr3TSaRLqwKO2lhsN5ckdRzV
         wXlY3ixi/dAa+b4WLcP4mGcWr9JScrE0DgmEZpdykU/fzKdSVgY7zwRQbYXlA5IJxzy0
         vTsRFcmmjv3o8wsbGPsPtUAJ8s+YK4kUyzURe+egb7/kTBdLkJf8kUMX8dQvHki+HgXr
         ohLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FIDE+itK9PP/6qNSejIUv8DnzpCmOGBNCkTKxdd1fCo=;
        b=KTWxq3PNy+dgMClblOjpgycsE8815FWDznkhwZDGoQeWH408q4Dhx9pXexe53kGHO7
         s5It9621xuu/q8E84R8JXI/Cg8Q1XaaR1IbDNrHrsXEDz5GGK5O59lWoIm6lryXiDeiA
         nh0qNFud0RTP48Mwwy4XokpsTIR5+Cvkb2MNcAbCV1LPbT8OXQmA3RAuIaz19mOnCSni
         cU2NUmQmZtNITIXkPok020LCl1z/IvCJfYSWo4ka1KX6suR1F/Cd4+dBrlCKLdJiidve
         xrxmDFWc/osqCe0w4u+IaZ3iNg+6mJxkAvx8ZelU3jmT+tpmb5v2bf9QjL65c30S5GVx
         eCMQ==
X-Gm-Message-State: AOAM5328SbFgAAQhnkXF/yiLeRZPKMcqgtHdTrJgzMUiNSlyd6XjJ1OL
        KKBK+5x2HUDQpwa1f1AZUhlH7A==
X-Google-Smtp-Source: ABdhPJxkYDU9Y16QOuD3/DRSSPEfzJcP6QJAOfFImHJArei3UlkfQzDDgy1bdvvaVWKwH089SyKA0Q==
X-Received: by 2002:a63:8f0e:: with SMTP id n14mr14093935pgd.75.1633407785102;
        Mon, 04 Oct 2021 21:23:05 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id q21sm15112936pgk.71.2021.10.04.21.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:23:04 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:53:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20211005042300.ix46h3ceu7aiwrg7@vireshk-i7>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

I hope you will be resending this after fixing the DT warnings ?

-- 
viresh
