Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A1422678
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhJEM2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 08:28:51 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35565 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhJEM2o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 08:28:44 -0400
Received: by mail-oi1-f181.google.com with SMTP id n64so25991759oih.2;
        Tue, 05 Oct 2021 05:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bfmACICGOmWfPzZ+fa6p+DSX46Smp7cp4Xl40pW5V0I=;
        b=o5GUb7zYi8c1lKb3oAkQNxx3tOAkLYWdqcNRyR5CPS3aHGQjzqsrt7HVCFE79rU+SP
         MjCRtRnkEnUnW6k3mwOlKJxZghgksp39o+N3CW0vEhdb4pKk5vSEUVLtunA+UTd5cVg6
         iTgCgiQX6D4AlKMsJO1pp5qGPrhhj1W2gyC0GfNfZ1YD0iLNKFczlgPc0SY8a+0srDut
         SoMCENSOmHBpGfC9Qqc1pSuPkKXlMwgtU4oNdNbJ5/mje04k3W+oTo/5oGLncrfxpUpU
         8otqr+oLrWD0090Boe9RMhnrFrHBaCH4X6k2JJQHcM2kzctUI55KsUxcnjm//Z+VFqlk
         BvOA==
X-Gm-Message-State: AOAM533V1QY5Jalnh9jsdHty3GlGVwpSR6TCu6NgXGmeT+jhU5J94GP1
        YqZGSMs5eLMLTv0uWWxVRsLqN5CJ2g==
X-Google-Smtp-Source: ABdhPJwGyYN3i6dySAYhusJoss2TO9w7xq/j51h4VZbLySVVJUG2myZcdz9rvTBTFMxh7/4/7dK6fA==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr2214637oiw.28.1633436813466;
        Tue, 05 Oct 2021 05:26:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm3461684otl.19.2021.10.05.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:26:52 -0700 (PDT)
Received: (nullmailer pid 3226809 invoked by uid 1000);
        Tue, 05 Oct 2021 12:26:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        viresh.kumar@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org
In-Reply-To: <20211005044920.78544-1-manivannan.sadhasivam@linaro.org>
References: <20211005044920.78544-1-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Tue, 05 Oct 2021 07:26:38 -0500
Message-Id: <1633436798.641210.3226807.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 05 Oct 2021 10:19:20 +0530, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Removed maxItems property as reported by the bot
> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 201 ++++++++++++++++++
>  2 files changed, 201 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: reg: [[305397760, 4096]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#freq-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#performance-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536466

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

