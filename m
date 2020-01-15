Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B713C687
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAOOtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 09:49:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37980 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgAOOtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 09:49:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so14185380oth.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 06:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1ze89BBE7QI+NzTkr8tdkM1RIqde14fHEiBxrkkmaI=;
        b=mYO/U6aFHVn2ipNktCn4t0YTQyyWEuv+62d/B5VOxleQA+zpgaPnJhgGyzeJUfLR8E
         wJcCT/OKIkUmd/60us/4HNWhc2XvJ7tfafQQ5kY29rbKYHKk4Inf7gS6YDKtmsd7+LB3
         +0vdXhuaR+HmmfFPjynskVUFPGN+N/u56q63mHRIgJRyeoAI2sfiWoiso6iVAH+UTMbi
         hgLpylA4SjrKKwfVinU7KX76itGjnfoLte2seKJlkEC9gokG5SB/EmkTnBXiZ+37E3ZH
         v8KtbejS4/Ks8CiSERt3VyZlTI1VEZ1TBXe5fHiA0Ql6FR8lkbWlZ2gHdh9hFTkNQvsO
         MSiQ==
X-Gm-Message-State: APjAAAUVBe2DwaEUyHq7EdWDbhxAHN2SnwyIFBSWUUBx0AmkTKPmhWzG
        anj0EJYMpA0+1AK/mXNERvCEL/M=
X-Google-Smtp-Source: APXvYqyyLL47AR3H5upKSed+qb2GhQOJoAW6Ssuql3r1KDXengPiL6LUr2e++Dw4FTdIbgbLUhcthw==
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr2842843otq.1.1579099784778;
        Wed, 15 Jan 2020 06:49:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm6580415otp.10.2020.01.15.06.49.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:49:43 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 08:49:42 -0600
Date:   Wed, 15 Jan 2020 08:49:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: interconnect: Update Qualcomm SDM845
 DT bindings
Message-ID: <20200115144942.GA15075@bogus>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-4-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578630784-962-4-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 09, 2020 at 08:33:01PM -0800, David Dai wrote:
> Redefine the Network-on-Chip devices to more accurately describe
> the interconnect topology on Qualcomm's SDM845 platform. Each
> interconnect device can communicate with different instances of the
> RPMh hardware which are described as RSCs(Resource State Coordinators).
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.yaml         | 49 ++++++++++++++++++----
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> index 61e0097..6741a12 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> @@ -13,21 +13,44 @@ description: |
>     SDM845 interconnect providers support system bandwidth requirements through
>     RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>     able to communicate with the BCM through the Resource State Coordinator (RSC)
> -   associated with each execution environment. Provider nodes must reside within
> -   an RPMh device node pertaining to their RSC and each provider maps to a
> -   single RPMh resource.
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources.
>   
>  properties:
> +  reg:
> +    maxItems: 1
> +
>    compatible:
>      enum:
> -      - qcom,sdm845-rsc-hlos
> +      - qcom,sdm845-aggre1-noc
> +      - qcom,sdm845-aggre2-noc
> +      - qcom,sdm845-config-noc
> +      - qcom,sdm845-dc-noc
> +      - qcom,sdm845-gladiator-noc
> +      - qcom,sdm845-mem-noc
> +      - qcom,sdm845-mmss-noc
> +      - qcom,sdm845-system-noc
>  
>    '#interconnect-cells':
>      const: 1
>  
> +  qcom,bcm-voter-names:
> +    items:
> +      - const: apps
> +      - const: disp

If these are always the names, why do you need them?

> +
> +  qcom,bcm-voters:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandles to qcom,bcm-voter nodes that are required by
> +      this interconnect to send RPMh commands.

Is the max length 2?

> +
>  required:
>    - compatible
> +  - reg
>    - '#interconnect-cells'
> +  - qcom,bcm-voters
>  
>  additionalProperties: false
>  
> @@ -35,9 +58,17 @@ examples:
>    - |
>        #include <dt-bindings/interconnect/qcom,sdm845.h>
>  
> -      apps_rsc: rsc {
> -              rsc_hlos: interconnect {
> -                      compatible = "qcom,sdm845-rsc-hlos";
> -                      #interconnect-cells = <1>;
> -              };
> +      mem_noc: interconnect@1380000 {
> +             compatible = "qcom,sdm845-mem-noc";
> +             reg = <0 0x01380000 0 0x27200>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      mmss_noc: interconnect@1740000 {
> +             compatible = "qcom,sdm845-mmss-noc";
> +             reg = <0 0x01740000 0 0x1c1000>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voter-names = "apps", "disp";
> +             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
>        };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
