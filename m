Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF72620E0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgIHUQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIHPKB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:10:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B57C0A5534
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 07:58:24 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m12so12132852otr.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9gggthlY+o0JLKVW4bDabhGMPHFWypt8dqyEIpp5HBQ=;
        b=YB1FIRYyzS+ivsL/x+45ExVO0WH4Is9QWS50BvdosbbeX3Gi9nCtUp3J82nNmljBY6
         2JWQ8OutTr8NVlmEj5knAEd5QvGTHBgwJGuOKKBrxGLIqUrSTCfdGuVlSplWSBuVYG50
         1gRt3j7MlGKO3Vgm/lbDnz/Rr6omJsM1OVD/v0oDJTX71dK7psTcnMmqtUpToxc8zybt
         4ejNbNqpq110GFV6L5J6HSaFqA/UgkLEzxllqqnoKmQ4UbGu6gRzTXzpmg+clp3rTrUT
         SlGD+3IhJ/dsetPuwDX0gLdqgHqVCPqxO1fgcGCW6gJcc09yKjpzpaQTKnrRam+Iva7t
         vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gggthlY+o0JLKVW4bDabhGMPHFWypt8dqyEIpp5HBQ=;
        b=YSUPXQHf12/OozTPxnpu5wsKF90X6lrElXp44OOteL6aEl1K6LT2Va7MarL27YXVjg
         Uqq8ykGbWSSLZQ3livUDNL7hJNF90w2P46JEeZlneJnfEMJbwDcVt0HvRNQMOE6ePlwS
         ZfzoL6a9+S5mXTozsmqwY8AFtSN9kzI5iiZEu/TFzl6Z9qJ/kWLWxJhceQPVRPCHVs2x
         ZINl3uZSiMqLX3Y7hNfDgTq2Y8D8Nho/jH64iDQAC5nKT6pq5G6JaK4Rsvq01kkjL2kP
         56Jg2oTr7PVBCgdlg+iarpGSxBsEJ2JRZQdwvO1IZXJHaqakILUd53oyU0sYS1j4Y3VI
         Mtew==
X-Gm-Message-State: AOAM530Cs1vTQ8pZ7QoGiT/krjwoLvYYQHF989woQkx1HJ7ZctXBVqMZ
        fB94RkFZcZQyo8OoZ2j7sH3u2A==
X-Google-Smtp-Source: ABdhPJwzWVepX/rnpXMX9hm2hay4q1Tqm8YqYT8JJBjjmrghpuG4jHcnsb8c87sfS0CmGWklIjZJNw==
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1860963otk.23.1599577104131;
        Tue, 08 Sep 2020 07:58:24 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id y24sm3515779ooq.38.2020.09.08.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 07:58:23 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:58:19 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document
 SM8250 compatible
Message-ID: <20200908145819.GN3715@yoga>
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

On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:

> Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
> hardware block which carries out CPUFreq operations on SM8250 SoC is
> called EPSS.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please follow up, after this has been accepted, with a conversion of
this binding to yaml.

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> index 33856947c561..aea4ddb2b9e8 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -8,7 +8,7 @@ Properties:
>  - compatible
>  	Usage:		required
>  	Value type:	<string>
> -	Definition:	must be "qcom,cpufreq-hw".
> +	Definition:	must be "qcom,cpufreq-hw" or "qcom,sm8250-epss".
>  
>  - clocks
>  	Usage:		required
> -- 
> 2.17.1
> 
