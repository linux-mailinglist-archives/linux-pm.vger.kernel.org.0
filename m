Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938E3285231
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgJFTOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 15:14:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42842 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgJFTOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 15:14:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so13360125otl.9;
        Tue, 06 Oct 2020 12:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ErHJdio6a2qxZX+lSmxPpX33WXnLlr6Kp8C66PbgGY=;
        b=XXVGg2ySDzyCm5MQCgg/5w2wB6fws8GTAlBeBwzAVX4xq0Hdbhfb2dpq3wvVN0DEIT
         8A5aV5xgKUjvYjYF8wi9Qpr+m7YUn5sYAW5XXX5aieBK75CvDEa8cMWlHohTKEgSRtYq
         2HCQK9bwA9pn36r0d0EZsTdmGG6edgM+UjgfIqkRaGY8kOqWVbGIgw79v+DGY7Ywgn4l
         TEXPZjKYlKG6MoHf3j+2PdN6aUnpMu2dERqtvESgB4c2XZ1ynbYPKgP/7I3kUuTY7n54
         PpCyhpgalHmYEmvwReJKrepwxBxIfmWnUHhLy4HBT/9cLJLRBiMmQWKpuFKEo+HWTujl
         0GGA==
X-Gm-Message-State: AOAM533QVJh+m6EuuIOLBWO64CY8mSHmK2PYSTApk4boheb3OPvlypMA
        rK47x5thOVBYy5Zl2nsEUw==
X-Google-Smtp-Source: ABdhPJxyBWtokfgX5S/v4WTzeX0OPnFXiWjhUyfJxUiGQBijoa5wad4LLRsNFZcJC4BP16jDrBmocA==
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr368239otk.109.1602011685593;
        Tue, 06 Oct 2020 12:14:45 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q8sm1432499otf.7.2020.10.06.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:14:44 -0700 (PDT)
Received: (nullmailer pid 2664218 invoked by uid 1000);
        Tue, 06 Oct 2020 19:14:44 -0000
Date:   Tue, 6 Oct 2020 14:14:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, agross@kernel.org, shawn.guo@linaro.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: interconnect: Add Qualcomm MSM8939 DT
 bindings
Message-ID: <20201006191444.GA2664188@bogus>
References: <20200930081645.3434-1-jun.nie@linaro.org>
 <20200930081645.3434-5-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930081645.3434-5-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Sep 2020 16:16:44 +0800, Jun Nie wrote:
> The Qualcomm MSM8939 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpm.yaml       |   4 +
>  .../dt-bindings/interconnect/qcom,msm8939.h   | 105 ++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
