Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25336F55D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhD3FfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 01:35:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21927 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhD3FfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 01:35:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619760864; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WyIiMnFBS/zDlAuBJ6dVpP5Wm6YrC+/il7PmxfKg7BE=;
 b=leaXCiyMf9FbmJ4zYthyycpV0hO3z75sRlRExcPVWACoex88OjlPpN3PR5F7gajTGv0VuLZB
 0854XEQGyAWDw0bY9H3py18nIYZAUzPVWZrfvdn3DCAiNsO3U/5W4b1qkKbGFQxC7D25WF7E
 0/OeQyIZ6wL8FEsqhmkhZwME5KQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 608b96da853c0a2c46e310df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Apr 2021 05:34:18
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7778BC4323A; Fri, 30 Apr 2021 05:34:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA03CC433F1;
        Fri, 30 Apr 2021 05:34:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Apr 2021 11:04:16 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
In-Reply-To: <1618556290-28303-2-git-send-email-okukatla@codeaurora.org>
References: <1618556290-28303-1-git-send-email-okukatla@codeaurora.org>
 <1618556290-28303-2-git-send-email-okukatla@codeaurora.org>
Message-ID: <825aca2d853e5dd577d61396df49f44a@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Odelu,
Thanks for the patch!

On 2021-04-16 12:28, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index d6a95c3..98223f8 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-osm-l3
> +      - qcom,sc7280-epss-l3
>        - qcom,sdm845-osm-l3
>        - qcom,sm8150-osm-l3
>        - qcom,sm8250-epss-l3

Based on the driver/dts changes the
reg property maxItems will no longer
be just 1.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
