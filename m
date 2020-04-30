Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFA1BEF96
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 07:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD3FJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 01:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3FJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 01:09:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C35C08E859
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 22:09:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so240936pjw.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 22:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcQ5rdhX5fAQSX2rbYN56O2PhBMBX/klcGq2rtNptpM=;
        b=UIPWkQRCuoKPusij5bXjIgUWQTmsoLYcmtJotv/WTwQI8XCnxYM/ilm3V1d3vhaud4
         oCaqKAnwOWt5jxRvv0ApLhJU/GBO/g0rlUmPsIbEgyH43hmyRzM8W2Il6LQSpGe3ypnj
         EOj8avcPW4dHenocr4HMTna0mxX8s7g5Oix67ExkIYNYkeitD5cOrJyEPfZ+y5EwxtJf
         S9n7zQsqB0ZmZi2MzkQtgIZt/ak+6Vil0L6KPPg8uk2fG+qxaymCvPs6GsTq+PnOJIXW
         XW99dc7mSyRYJpsJB0bdR02UuxxukrNuIyIriUSQBawkWbd4eQCLUGzlQNPouKs6ZAIN
         WoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcQ5rdhX5fAQSX2rbYN56O2PhBMBX/klcGq2rtNptpM=;
        b=qldZgCw+Xmsx4XkryQDRWxT6pWkIsAsUko/Oe/K2GrH/kzG6AddgeHtYtgduLC7om6
         V5QqYeoSRd8vMb3W8nP8I/M4e3vIbN3Wq290RkTwMbm5bmKr37wVxiJVy+Q+htOrrBDw
         4dE0keyjn9g05HdmmC/RVIRxnYHOsCgaTpniIBNZ+2S4VMDT3txP6Cu/ha4xZeqTifCu
         D/5KaurvCFpUxKLBISHUo5++uaIDzo3WGdH6NVAzEpqM3qF604FzWnCHD6gjAU9F8QGw
         +oFPpwZqpcl+C9ApXAe1yY5DPkL8LXKAEloIw0UsB7cHudjKG8MVgPJOHly/vbniqHdT
         eAOg==
X-Gm-Message-State: AGi0Puba8pKg7kHNaq9zwBAdzTUM7ckj3/kYCbPW8RoYKemHOgkpYpDh
        UX97uyIS/tHAaNSj8MMUuWfZZRJXN/Q=
X-Google-Smtp-Source: APiQypIWG8LTlURGRjcnCZlUiotPB1jlfz7jUIeRNAIqGaqtSuVr93jORUA5tW+QP7j+WvGiFJXmgQ==
X-Received: by 2002:a17:90a:ee84:: with SMTP id i4mr956177pjz.71.1588223361336;
        Wed, 29 Apr 2020 22:09:21 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id h193sm2422349pfe.30.2020.04.29.22.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 22:09:20 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:39:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
Message-ID: <20200430050918.b2g2yc7xhvbzeqqq@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-2-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-04-20, 18:53, Georgi Djakov wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * I have dropped Rob's Reviewed-by, because of the minor change below:
> * In order to store the bandwidth values for multiple paths, the
> opp-peak-kBps and opp-avg-kBps are now defined as arrays of integers,
> instead of just integers.
> * Improved wording (Viresh)
> 
> v6: https://lore.kernel.org/r/20191207002424.201796-2-saravanak@google.com
> 
>  Documentation/devicetree/bindings/opp/opp.txt | 20 ++++++++++++++++---
>  .../devicetree/bindings/property-units.txt    |  4 ++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 68592271461f..a8a6a3bfcfcb 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,17 @@ properties.
>  
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes except for devices like power domains
> +  or bandwidth opp tables. The devices which don't have this property must have

bandwidth opp table ?

> +  another (implementation dependent) property which uniquely identifies the OPP
> +  nodes.
> +
> +
> +- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as an array
> +  of 32-bit big-endian integers. Each element of the array represents the
> +  peak bandwidth value of each interconnect path. The number of elements should
> +  match the number of interconnect paths. This is a required property for
> +  bandwidth OPP tables.
>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +140,12 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as an array
> +  of 32-bit big-endian integers. Each element of the array represents the
> +  average bandwidth value of each interconnect path. The number of elements
> +  should match the number of interconnect paths. This property is only
> +  meaningful in OPP tables where opp-peak-kBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index e9b8360b3288..c80a110c1e26 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>  Pressure
>  ----------------------------------------
>  -kpascal	: kilopascal
> +
> +Throughput
> +----------------------------------------
> +-kBps		: kilobytes per second

-- 
viresh
