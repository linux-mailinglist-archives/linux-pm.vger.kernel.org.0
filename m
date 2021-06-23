Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF43B1C43
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFWOWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 10:22:08 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:46713 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFWOWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 10:22:07 -0400
Received: by mail-io1-f41.google.com with SMTP id b14so3576748iow.13;
        Wed, 23 Jun 2021 07:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UVPpaHH49R7LNxnAOOyz/+Z+U9in8qUPXgYTVhm4QcQ=;
        b=oQWepna8lJCzTEvPfQlBJJJylyUXGIUju+1SQ/vU5aqOTiauf2dwnCCkbltAHQkMWX
         CwAo7afuieM21nhgC0KXwLUWKjgC5GjzESDaWeMSzaYlG956MAJfdFkzux+KjGwShGna
         dS3i9NjvzLHbIwaXjvq+tJCNbHXDJBKvpdINoipTWOkIa+HxXQu240REznVCTfxqc9tf
         7dwQ22hxlkfNsTDYd4PBs6H3/O5bjt5ESix/LM0Gl3/99yIjf/wpigG981IW360Gcq12
         D+O6tmrUmi6hEd/LTEHFheZ+24kti8SPXiA+n8VAfbo5eeoOFRZKUgpeV2kmkx/aGh/n
         +jNA==
X-Gm-Message-State: AOAM532uF8ykde8qzMuCo2lyldYwbTmDqTZCvYqAh0EU90dQxkfbn+Yj
        FUGaJKE4HG95i7+6fkmtIA==
X-Google-Smtp-Source: ABdhPJz3N/ThOA76tJQ73yqswaHvSdGjLeeftaHD5GTFNgF5LKgxk7CtY3xm6x0CBp18Z/iiHWbmNA==
X-Received: by 2002:a02:620a:: with SMTP id d10mr9480381jac.22.1624457989188;
        Wed, 23 Jun 2021 07:19:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p19sm13843487iob.7.2021.06.23.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:19:48 -0700 (PDT)
Received: (nullmailer pid 2339996 invoked by uid 1000);
        Wed, 23 Jun 2021 14:19:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, martin.botka@somainline.org,
        devicetree@vger.kernel.org, jami.kettunen@somainline.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        daniel.lezcano@linaro.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-pm@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, stephan@gerhold.net, agross@kernel.org,
        jeffrey.l.hugo@gmail.com
In-Reply-To: <20210622141117.358893-3-angelogioacchino.delregno@somainline.org>
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org> <20210622141117.358893-3-angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v7 2/5] dt-bindings: soc: qcom: Add devicetree binding for QCOM SPM
Date:   Wed, 23 Jun 2021 08:19:45 -0600
Message-Id: <1624457985.973822.2339995.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Jun 2021 16:11:14 +0200, AngeloGioacchino Del Regno wrote:
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

See https://patchwork.ozlabs.org/patch/1495727

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

