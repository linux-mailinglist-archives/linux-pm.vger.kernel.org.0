Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C32F08A7
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbhAJRTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 12:19:37 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34773 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 12:19:37 -0500
Received: by mail-oi1-f169.google.com with SMTP id s75so17722344oih.1;
        Sun, 10 Jan 2021 09:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=gieP8eMMhIwuDhb0Vl0swuQVI2c1HXJ0Uk0fu04gagQ=;
        b=skRTs6T2k99yA6OTJnSqsF8ahec5LZW00XErd7PZ3foSvs20epx9IoAWq2IDncL3RN
         1GoXRl7V8yFb7cjT7YYzuKqJ0AU/TfY9nLFAsXl3ssxg6MptswQObh+G+2jycmv6I1pO
         X0rWE3C3bt78htLeMIpBVDjgSPzEou3vnyyJFZIBDudyWr6XVhIU9NAhESYiAJ/g2Xaf
         sBUwzgbDr/gbN0D64oAEXInA+XyWtkT0EWM2AfGebyyCA+a2suKFhRSvkrBhFi4yR3G8
         xDyF9dF1sIqJN/0/yiK+RhxbJluBvObRHoBHinror2t7C+Zv0e3X5sHTtb9hi5JEcend
         52jA==
X-Gm-Message-State: AOAM532M1af5UCrNlUlEm42EHov/PopWJSAd3Euc3Y3n+b24J6HQh5U5
        05W3mBs+fFqr/N/ZMZZggw==
X-Google-Smtp-Source: ABdhPJzLxtszYVeUrCOzKty8zftKIo/Vu35XEp81Bhe4mSudgRYg+tdhVx3ypM+/82ZLFWYvrDIQwQ==
X-Received: by 2002:a05:6808:4cf:: with SMTP id a15mr8301191oie.147.1610299136149;
        Sun, 10 Jan 2021 09:18:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w9sm3125675otq.44.2021.01.10.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:18:55 -0800 (PST)
Received: (nullmailer pid 785283 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        nks@flawful.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        manivannan.sadhasivam@linaro.org, linux-pm@vger.kernel.org,
        martin.botka@somainline.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, marijn.suijten@somainline.org
In-Reply-To: <20210109180359.236098-9-angelogioacchino.delregno@somainline.org>
References: <20210109180359.236098-1-angelogioacchino.delregno@somainline.org> <20210109180359.236098-9-angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v2 08/15] dt-bindings: avs: cpr: Convert binding to YAML schema
Date:   Sun, 10 Jan 2021 11:18:46 -0600
Message-Id: <1610299126.051571.785282.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 09 Jan 2021 19:03:52 +0100, AngeloGioacchino Del Regno wrote:
> Convert the qcom,cpr.txt document to YAML schema and place it in the
> appropriate directory, since this driver was moved from power/avs
> to soc/qcom, but forgets to move the documentation.
> 
> Fixes: a7305e684fcf ("PM: AVS: qcom-cpr: Move the driver to the qcom specific drivers")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 131 +-----------------
>  .../bindings/soc/qcom/qcom,cpr.yaml           | 116 ++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 118 insertions(+), 131 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml:36:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.example.dt.yaml: power-controller@b018000: nvmem-cells: [[4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.example.dt.yaml: power-controller@b018000: nvmem-cell-names: ['cpr_quotient_offset1', 'cpr_quotient_offset2', 'cpr_quotient_offset3', 'cpr_init_voltage1', 'cpr_init_voltage2', 'cpr_init_voltage3', 'cpr_quotient1', 'cpr_quotient2', 'cpr_quotient3', 'cpr_ring_osc1', 'cpr_ring_osc2', 'cpr_ring_osc3', 'cpr_fuse_revision'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml

See https://patchwork.ozlabs.org/patch/1424131

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

