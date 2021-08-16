Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE163EDCDC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhHPSKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 14:10:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61354 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhHPSJ4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 14:09:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629137363; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ssvOWDCDdDkaUd8v+/clZG/5CfKJpqfuWHBXok87BXs=;
 b=DUeYYgPixOQVlaMqWaV2c4hb88dJcXwCDH6ZUEMFzPe212xLz31x5kn2hzhSj84XeH/EJbbL
 xqN8UNZWoYeIdBE4H4ahQ2SerAnmquFQgevl41Q4xjR0PlqtacgIt+igi1ME3uoORnE8f2g7
 wLFgF/1zzRvBMDeH57AU5iJU4GE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 611aa9c5b14e7e2ecb6c6ca5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 18:09:09
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 571EDC43460; Mon, 16 Aug 2021 18:09:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 217D9C4338F;
        Mon, 16 Aug 2021 18:09:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Aug 2021 23:39:07 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mdtipton@codeaurora.org, saravanak@google.com,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v6 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
In-Reply-To: <1628577962-3995-2-git-send-email-okukatla@codeaurora.org>
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-2-git-send-email-okukatla@codeaurora.org>
Message-ID: <141da7d1269c5cf91fbb260192521ab9@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Odelu,
Thanks for the patch.

On 2021-08-10 12:16, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  9 
> ++++++++-
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 
> +++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index e701524..919fce4 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -18,13 +18,20 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-osm-l3
> +      - qcom,sc7280-epss-l3
>        - qcom,sc8180x-osm-l3
>        - qcom,sdm845-osm-l3
>        - qcom,sm8150-osm-l3
>        - qcom,sm8250-epss-l3
> 
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      - description: OSM clock domain-0 base address and size
> +      - description: OSM clock domain-1 base address and size
> +      - description: OSM clock domain-2 base address and size
> +      - description: OSM clock domain-3 base address and size

Looks like you missed addressing
Stephen's comment from v4 i.e.
having descriptions based on
compatibles.

> 
>    clocks:
>      items:
> diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h
> b/include/dt-bindings/interconnect/qcom,osm-l3.h
> index 61ef649..99534a5 100644
> --- a/include/dt-bindings/interconnect/qcom,osm-l3.h
> +++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2019, 2021 The Linux Foundation. All rights reserved.
>   */
> 
>  #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
> @@ -11,5 +11,13 @@
> 
>  #define MASTER_EPSS_L3_APPS	0
>  #define SLAVE_EPSS_L3_SHARED	1
> +#define SLAVE_EPSS_L3_CPU0	2
> +#define SLAVE_EPSS_L3_CPU1	3
> +#define SLAVE_EPSS_L3_CPU2	4
> +#define SLAVE_EPSS_L3_CPU3	5
> +#define SLAVE_EPSS_L3_CPU4	6
> +#define SLAVE_EPSS_L3_CPU5	7
> +#define SLAVE_EPSS_L3_CPU6	8
> +#define SLAVE_EPSS_L3_CPU7	9
> 
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
