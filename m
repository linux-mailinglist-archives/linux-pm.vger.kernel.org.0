Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B043FF408
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhIBTUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 15:20:41 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44905 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhIBTUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 15:20:40 -0400
Received: by mail-oi1-f182.google.com with SMTP id c79so3908976oib.11;
        Thu, 02 Sep 2021 12:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBZlbhgfABTT3Yk10srbd/x7NTgAjn9sMFwNziqz1LU=;
        b=MlGC4iCdVF8PvOGWUUENRaqgOlqStKGl8XoSFxSig8X+AYV6R0goJYMHrAlTzo9y6w
         OvCsKOdgdNCgExhC3Cz2/PZ3MBdomjHcQilKlvHplxzz9hS3Vryf3EAvZbX6am++u2+i
         stBhjvSFjWnc2wOlPuN42DM7eEdXnmUzs7chnsVJXdbIsxEom0xBxNJgyObLSvPSWXvC
         inquUUC9y6TH57lpOYtGlpNUgtR3KcKecB4I4R6ZPRlisALrXhAS3rQJslzhzZ6iHHOC
         BlZmB7nO6jp8df3WdSMxBDEIS95B4ABFT/53V8m6hXHTqnvYfUMnZtnKPmSMuKhUqo0c
         LgYQ==
X-Gm-Message-State: AOAM5326rNWYhLV6Hq9Ba1U1rY3KKlavVDmmtlH07FQQhusHaqYFKIsI
        kn96c7jrzYYNfmnqNLf7DQ==
X-Google-Smtp-Source: ABdhPJzFtNB+4bifmI7PvcaCV/jGgz1GpqfdR+kukdiVPLZKPzSaWT9W7I3TbSs7X2H44vfmQVGXKg==
X-Received: by 2002:a05:6808:1442:: with SMTP id x2mr3296651oiv.162.1630610381359;
        Thu, 02 Sep 2021 12:19:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n73sm554680oig.9.2021.09.02.12.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:19:40 -0700 (PDT)
Received: (nullmailer pid 1237538 invoked by uid 1000);
        Thu, 02 Sep 2021 19:19:39 -0000
Date:   Thu, 2 Sep 2021 14:19:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        agross@kernel.org, nm@ti.com, ilia.lin@kernel.org,
        niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: opp: qcom-opp: Convert to DT schema
Message-ID: <YTEjy4DNhjQs3vl5@robh.at.kernel.org>
References: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 01, 2021 at 05:55:58PM +0200, AngeloGioacchino Del Regno wrote:
> Rewrite the qcom-opp as qcom-level-opp in dt schema format.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/opp/qcom-level-opp.yaml          | 68 +++++++++++++++++++
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 ------
>  2 files changed, 68 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml b/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
> new file mode 100644
> index 000000000000..65dd2d5d9566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0

This one of course came from default GPL2 source, but I'm sure the 
authors are QCom/Linaro and they would be happy to dual license.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/qcom-level-opp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm OPP bindings for fuse and voltage level OPPs
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> +  - Niklas Cassel <niklas.cassel@linaro.org>
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#
> +
> +properties:
> +  compatible:
> +    const: operating-points-v2-qcom-level
> +
> +  opp-shared: true
> +
> +required:
> +  - compatible
> +
> +patternProperties:
> +  '^opp-?[0-9]+$':
> +    type: object
> +
> +    properties:
> +      opp-level: true
> +      qcom,opp-fuse-level:
> +        description:
> +          At least one positive value representing the fuse corner or level
> +          associated with this OPP node. In case this is used for CPR >=v3,
> +          multiple array entries are referring to different CPR threads.
> +          Sometimes several corners/levels shares a certain fuse
> +          corner/level. A fuse corner/level contains e.g. ref uV, min uV,
> +          and max uV.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +    required:
> +      - opp-level
> +      - qcom,opp-fuse-level
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpr_opp_table: opp-table-cpr {
> +        compatible = "operating-points-v2-qcom-level";
> +
> +        cpr_opp1: opp1 {
> +            opp-level = <1>;
> +            qcom,opp-fuse-level = <1>;
> +        };
> +        cpr_opp2: opp2 {
> +            opp-level = <2>;
> +            qcom,opp-fuse-level = <2>;
> +        };
> +        cpr_opp3: opp3 {
> +            opp-level = <3>;
> +            qcom,opp-fuse-level = <3>;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> deleted file mode 100644
> index 41d3e4ff2dc3..000000000000
> --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Qualcomm OPP bindings to describe OPP nodes
> -
> -The bindings are based on top of the operating-points-v2 bindings
> -described in Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> -Additional properties are described below.
> -
> -* OPP Table Node
> -
> -Required properties:
> -- compatible: Allow OPPs to express their compatibility. It should be:
> -  "operating-points-v2-qcom-level"
> -
> -* OPP Node
> -
> -Required properties:
> -- qcom,opp-fuse-level: A positive value representing the fuse corner/level
> -  associated with this OPP node. Sometimes several corners/levels shares
> -  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> -  min uV, and max uV.
> -- 
> 2.32.0
> 
> 
