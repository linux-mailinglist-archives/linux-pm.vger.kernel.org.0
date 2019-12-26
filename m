Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF612ADF4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 19:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLZSp3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 13:45:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32834 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZSp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 13:45:29 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so23908327ioh.0;
        Thu, 26 Dec 2019 10:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seNNxtSCY5PCaSndRDL3FP6aHUS8ClKGG6WAGLgdqN4=;
        b=agFh0EaVoZpWBAB5sbjJecRFoz7lXwMOKm3sXb3AbEAq+x2REDyjEStoX2FzI4MY5X
         8ggcuW6kQWLxvT1AUhsvFB8B8NJmEZtYNCEL6o6/YhcXP0XZ/vNgpTXsCzuPqZLfSws2
         DbH5NHGQXEAw1XWA6HddLefzqm1AbgSHUxk/OpHZ1UMM6sUwZ4f8nWUcs/aTBDTpNNkR
         BGm5G7zdEl16G9VUrROIqeMHeESMi3di7LDtB6MpnaCXvm3t1c+ftfAeGjvfc6fqG2rA
         Z5iclBU3AFRNPMGUszJ70ubIz4m9zIjv19k+vUA3X4hVDX4/swSLls7GelvxumdDlAGG
         N7fQ==
X-Gm-Message-State: APjAAAW9QL2egsS7zvVM1LBBi2sTxfo81l3s+6UcLq2uysjJNjE2H+dt
        rIIgRMQslX2JaMsXnVTUSA==
X-Google-Smtp-Source: APXvYqx4a+2ZbSQn5pck8RmSH2U1pLL0lDa4l+CIZQSTvFSgSQJep4AGLUbj//ws+G+S6yfyMuxpIw==
X-Received: by 2002:a5e:8505:: with SMTP id i5mr30406952ioj.158.1577385928163;
        Thu, 26 Dec 2019 10:45:28 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m189sm8649602ioa.17.2019.12.26.10.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:45:27 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:45:26 -0700
From:   Rob Herring <robh@kernel.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: interconnect: Update Qualcomm SDM845
 DT bindings
Message-ID: <20191226184526.GA18040@bogus>
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
 <1576475925-20601-2-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576475925-20601-2-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 15, 2019 at 09:58:42PM -0800, David Dai wrote:
> Redefine the Network-on-Chip devices to more accurately describe
> the interconnect topology on Qualcomm's SDM845 platform. Each
> interconnect device can communicate with different instances of the
> RPMh hardware which are described as RSCs(Resource State Coordinators).
> 
> As part of updating the DT bindings, convert the existing sdm845 bindings
> to DT schema format using json-schema.

Too many things in one patch. Convert to schema in one patch and then 
add new stuff in separate patch(es).

> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,bcm-voter.yaml      |  45 +++++++++
>  .../bindings/interconnect/qcom,sdm845.txt          |  24 -----
>  .../bindings/interconnect/qcom,sdm845.yaml         | 108 +++++++++++++++++++++
>  3 files changed, 153 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> new file mode 100644
> index 0000000..74f0715
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,bcm-voter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm BCM-Voter Interconnect
> +
> +maintainers:
> +  - David Dai <daidavid1@codeaurora.org>
> +
> +description: |
> +    The Bus Clock Manager (BCM) is a dedicated hardware accelerator
> +    that manages shared system resources by aggregating requests
> +    from multiple Resource State Coordinators (RSC). Interconnect
> +    providers are able to vote for aggregated thresholds values from
> +    consumers by communicating through their respective RSCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdm845-bcm-voter
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    apps_rsc: interconnect@179c0000 {
> +        compatible = "qcom,rpmh-rsc";
> +
> +        apps_bcm_voter: bcm_voter {
> +            compatible = "qcom,sdm845-bcm-voter";
> +        };
> +    };
> +
> +    disp_rsc: interconnect@179d0000 {
> +        compatible = "qcom,rpmh-rsc";
> +
> +        disp_bcm_voter: bcm_voter {
> +            compatible = "qcom,sdm845-bcm-voter";
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> deleted file mode 100644
> index 5c4f1d9..0000000
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Qualcomm SDM845 Network-On-Chip interconnect driver binding
> ------------------------------------------------------------
> -
> -SDM845 interconnect providers support system bandwidth requirements through
> -RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> -able to communicate with the BCM through the Resource State Coordinator (RSC)
> -associated with each execution environment. Provider nodes must reside within
> -an RPMh device node pertaining to their RSC and each provider maps to a single
> -RPMh resource.
> -
> -Required properties :
> -- compatible : shall contain only one of the following:
> -			"qcom,sdm845-rsc-hlos"
> -- #interconnect-cells : should contain 1
> -
> -Examples:
> -
> -apps_rsc: rsc {
> -	rsc_hlos: interconnect {
> -		compatible = "qcom,sdm845-rsc-hlos";
> -		#interconnect-cells = <1>;
> -	};
> -};
> -
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> new file mode 100644
> index 0000000..1aec321
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:  Qualcomm SDM845 Network-On-Chip Interconnect
> +
> +maintainers:
> +  - David Dai <daidavid1@codeaurora.org>
> +
> +description: |
> +   SDM845 interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  compatible:
> +    enum:
> +      - qcom,sdm845-aggre1-noc
> +      - qcom,sdm845-aggre2-noc
> +      - qcom,sdm845-config-noc
> +      - qcom,sdm845-dc-noc
> +      - qcom,sdm845-gladiator-noc
> +      - qcom,sdm845-mem-noc
> +      - qcom,sdm845-mmss-noc
> +      - qcom,sdm845-system-noc
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  qcom,bcm-voters:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandles to qcom,bcm-voter nodes that are required by
> +      this interconnect to send RPMh commands.
> +
> +  qcom,bcm-voter-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array

Don't need a type for *-names.

> +    description: |
> +      Names for each of the qcom,bcm-voters specified.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#interconnect-cells'
> +  - qcom,bcm-voters
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/interconnect/qcom,sdm845.h>
> +
> +      mem_noc: interconnect@1380000 {
> +             compatible = "qcom,sdm845-mem-noc";
> +             reg = <0 0x01380000 0 0x27200>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      dc_noc: interconnect@14e0000 {
> +             compatible = "qcom,sdm845-dc-noc";
> +             reg = <0 0x014e0000 0 0x400>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      config_noc: interconnect@1500000 {
> +             compatible = "qcom,sdm845-config-noc";
> +             reg = <0 0x01500000 0 0x5080>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      system_noc: interconnect@1620000 {
> +             compatible = "qcom,sdm845-system-noc";
> +             reg = <0 0x01620000 0 0x18080>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      aggre1_noc: interconnect@16e0000 {
> +             compatible = "qcom,sdm845-aggre1-noc";
> +             reg = <0 0x016e0000 0 0xd080>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      aggre2_noc: interconnect@1700000 {
> +             compatible = "qcom,sdm845-aggre2-noc";
> +             reg = <0 0x01700000 0 0x3b100>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      mmss_noc: interconnect@1740000 {
> +             compatible = "qcom,sdm845-mmss-noc";
> +             reg = <0 0x01740000 0 0x1c1000>;
> +             #interconnect-cells = <1>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };

Examples are just examples, not an enumeration of all possible nodes.

Also, when is qcom,bcm-voters more than 1 phandle.

Rob
