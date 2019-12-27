Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5AD12B1BF
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 07:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfL0GZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 01:25:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38336 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfL0GZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 01:25:12 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so4495388pje.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 22:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+EKn8We3BkGgywlh1HuV4tzBZYkzn1Xs8GUmEfUy078=;
        b=hfxVgJ5v1cMuu2MQODqTRoZDn63VkkyCBQ9YJbz3fvFtMUcXeXKRMXXSh0abGiWK3d
         5ptKXl8F9s+ti0PK+Pk5uPWoMEMZmrqqHAdKl6SEfafchEdU1DmX75ihmffd9x2kbx/s
         EEcXNkU731Vt8+eVxeFk0tqx6TyLAD+disN2NMTD//X8MI89yUZi3UpCqEUfSwuFS3kF
         SxSJaHrYR22ozQHh+Uyuz/eQVeQUtKu3Mc/Pjgz+hzoGltHQdOzuVH9qym0ma1DKpeRy
         CA864jSbQKZDT2EKNhOy4lp7dr7k45+wPTs/ee2NL32lZvUtI3HCb+/o6oXY66a/Bte/
         mOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+EKn8We3BkGgywlh1HuV4tzBZYkzn1Xs8GUmEfUy078=;
        b=a1W4MFEoh0dgPmEP4dYbLe38AbByP0l1qVUXNs1old0QBXwUJ1cc/GwU0UFHjmEv0E
         UaZR4tnHLIf9t+1VABa2HMUCpTLv7VuhF4OOMYQJFpOjhGHVPa63jwAdbK8Yd/rpFvA/
         bAnFE5dsGZX1/MnO8LrK4q1SVThQ/LTzdajyfn35muN8wBHfoPszIsi7WLmwUbZGHeah
         0At5almGFthH7iGpJhbxGeyQc/GZ+aao+hOmife7Oc4rKBxxSBgl+uN8+QpVzl2GrqEM
         f/i/LqiqEwdDd+7WJ+X/G8SJgrEvqt6VWAOH7F5YH4xqQo4cryvv6/GHIhgxRLeyK35t
         DXaw==
X-Gm-Message-State: APjAAAVINraqq/mMoHUTbvp4Fk4im92XWX5KnmwDUsgD6q3Mw6nqpn10
        AgHjz5U119zXnDDP5+n2w+eJ3w==
X-Google-Smtp-Source: APXvYqw2qyrZjW+qLKzs/TN5PVizOk8K27jmhhHnPigI4HLMQERBFm/IqC/GFrkiZ9PfVgEfLnXJ8w==
X-Received: by 2002:a17:90a:aa84:: with SMTP id l4mr24319054pjq.143.1577427912269;
        Thu, 26 Dec 2019 22:25:12 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v143sm30824367pfc.71.2019.12.26.22.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:25:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 22:25:09 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add configuration for
 sc7180 in yaml
Message-ID: <20191227062509.GN549437@yoga>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
 <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Dec 05:14 PST 2019, Rajeshwari wrote:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index eef13b9..c0ed030 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,sc7180-tsens
>                - qcom,sdm845-tsens
>            - const: qcom,tsens-v2
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
