Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6593B0781
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhFVOjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 10:39:06 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:41680 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVOjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 10:39:03 -0400
Received: by mail-io1-f52.google.com with SMTP id i189so600164ioa.8;
        Tue, 22 Jun 2021 07:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Of/VzMGz855Wz34Tuq2SD5JHgkJPelGIgUky1xC77Tg=;
        b=f2P9Ju/nRipalVBCvcFIEd3vVqsZkieUEEVS15OZfaBjxP2cgdbBvneYGJ3gq3r/TN
         1NnAr2Kl4ygHuurvfQbpmHDl8EXSdrOL0YqiAkLqyqiSmFg8pdWxHfG/tzVQiH866OTc
         nkRMrtSkgfGQ7iu8kFifb1w9KZjYVzlFlOIU/oommX+WdbHzJEo9/Psx2LZRUXi8SsEA
         oTvp78X3kMC9LpX6AOFl2c72niXvY8UTEBTMuA8nJfXdckchmTx2HJkMUL9BeihQCd/s
         GuG6+KX2coM2MDLznFUn41voj2VL7KlrCsITKWDgzMc46kd4xIaR7nzTm3kAlztKO7J9
         oqTA==
X-Gm-Message-State: AOAM532z4QpewjUp82ZidKE4N7VncXW+vHAjY5gr+tVkP6zZp6mJ40x/
        dqw1lywdd5xcch7VHQLJXUt9nViVPg==
X-Google-Smtp-Source: ABdhPJziqbME6LQR9cT2xsvCNevM8ONjOtoYNfKtB2kAz1pz9qVbzDiyel+JGMXGJMZhR7ZJXiFoKA==
X-Received: by 2002:a05:6638:3896:: with SMTP id b22mr4300070jav.37.1624372607096;
        Tue, 22 Jun 2021 07:36:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e2sm9917641iot.50.2021.06.22.07.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:36:45 -0700 (PDT)
Received: (nullmailer pid 3566365 invoked by uid 1000);
        Tue, 22 Jun 2021 14:36:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     phone-devel@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        robh+dt@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jami.kettunen@somainline.org, agross@kernel.org
In-Reply-To: <20210621181016.365009-3-angelogioacchino.delregno@somainline.org>
References: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org> <20210621181016.365009-3-angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: soc: qcom: Add devicetree binding for QCOM SPM
Date:   Tue, 22 Jun 2021 08:36:40 -0600
Message-Id: <1624372600.481255.3566364.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Jun 2021 20:10:13 +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree binding for Qualcomm Subsystem Power Manager (SPM).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/soc/qcom/qcom,spm.yaml           | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,spm.example.dt.yaml: power-controller@f9089000: compatible: ['qcom,msm8974-saw2-v2.1-cpu', 'qcom,saw2'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,spm.example.dt.yaml: power-controller@f9089000: compatible: Additional items are not allowed ('qcom,saw2' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,spm.example.dt.yaml: power-controller@f9089000: '#power-domain-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/power-domain.yaml
Documentation/devicetree/bindings/soc/qcom/qcom,spm.example.dt.yaml:0:0: /example-0/power-controller@f9089000: failed to match any schema with compatible: ['qcom,msm8974-saw2-v2.1-cpu', 'qcom,saw2']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1495264

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

