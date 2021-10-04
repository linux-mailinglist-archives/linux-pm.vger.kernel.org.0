Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746DF420ACD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDMXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:23:19 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35383 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDMXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 08:23:17 -0400
Received: by mail-ot1-f45.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so21228712otj.2;
        Mon, 04 Oct 2021 05:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zbLNyDLPseOe4Bc3ltZiGCgMDdlmlhY+/bKlvrBnmq0=;
        b=uhmSOSZZP+eDXN9rkkr8gzNIDUqnh8r6ynoOkpIdyZyXFYIkIoIk2OOFswaMOxBout
         FwrevrQLMiAUClWKXEoFrNKwncM4ScuujncWLB2W7Qn//eHgfWBDjhmmoi6UPuqLH43/
         LlOUF2bVrI1j5mEc4clTSeodexHYtWL9iZrOUWPq5WHlxeIQSRKZF/jm/IiSn3gHo4ct
         OxkUjxQpHzWA/x8Ob3ksk5Bf4XD/G86VzsTE0jmF8bl3x8UMMoWJkxf/DBKreA8mbTDL
         pAQobsRZcu9rrkSNY4uibdozQaPYcNXuhmztKEKu/2vS1f7hLhDeVHpDapC4XbprM3Qa
         OL1Q==
X-Gm-Message-State: AOAM530Ay/cBAjcBE4/RuqyKlCRLo4Ca8eTcqELSS+yB4t4kf5IDWrgO
        dvFehwjw1qBke1apDZrT5pl3RUus5g==
X-Google-Smtp-Source: ABdhPJxxJ6d/Ye9W4omHMs8XfGjiHbLTsdkTe7WBOg3H2i3q1sthHEPj8pX0i5OH4sF1snRxec2nAg==
X-Received: by 2002:a9d:6752:: with SMTP id w18mr9097780otm.117.1633350088248;
        Mon, 04 Oct 2021 05:21:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm2980435otk.46.2021.10.04.05.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:21:27 -0700 (PDT)
Received: (nullmailer pid 1051507 invoked by uid 1000);
        Mon, 04 Oct 2021 12:21:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     viresh.kumar@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Mon, 04 Oct 2021 07:21:26 -0500
Message-Id: <1633350086.739525.1051506.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 04 Oct 2021 10:13:17 +0530, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> I've taken this patch (again) from the cpufreq series by AngeloGioacchino.
> Addressed the comment by Rob and Bjorn on making the "reg-names" property
> optional as in the txt version.
> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 203 ++++++++++++++++++
>  2 files changed, 203 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml: properties:reg: {'minItems': 2, 'maxItems': 3, 'items': [{'description': 'Frequency domain 0 register region'}, {'description': 'Frequency domain 1 register region'}, {'description': 'Frequency domain 2 register region'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml: properties:reg-names: {'minItems': 2, 'maxItems': 3, 'items': [{'const': 'freq-domain0'}, {'const': 'freq-domain1'}, {'const': 'freq-domain2'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml: ignoring, error in schema: properties: reg
warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dt.yaml:0:0: /example-0/soc/cpufreq@17d43000: failed to match any schema with compatible: ['qcom,cpufreq-hw']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1535939

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

