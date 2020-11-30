Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2E2C8ADB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgK3RXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 12:23:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34102 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgK3RXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 12:23:50 -0500
Received: by mail-io1-f67.google.com with SMTP id d7so3744445iok.1;
        Mon, 30 Nov 2020 09:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/gmjfv5NQeyFB8RGSzSz0Neo/S0f9fPQTdy4U5esOc=;
        b=XgQFaeN5wERbBGWH+RulQEmrxtpF4GdRqVuAAheKeCE/0XeFKtmXUl4DCRbrUomEUq
         Yc/YA38ddDTqGjFcr8o+B7J5aiSAFpULjqiDK6nqhq4PaVC/eBLC7XthwrWZ5+7ulXNm
         +K3hN2zeOQBgJn+jSiRS6LCOlvITEsGsAZTLqYjCgC6QZkLyGWkKUREKABARD7EpxRy0
         urgdKGqeFf8jg+blKT/E3iGksUiSJDiHbXHcZpbbCNhplboGAgesQfl9mmE9xxSO3LeX
         Vw/QesfQJKhp+betMQecpLmo5ywE04SOhVVvAb12Rr/n3eGEPf6USCfFonSj0L4siVvG
         ragw==
X-Gm-Message-State: AOAM530nOt1rr09QGFAMf5Bu0iKWvpR0ZH1JiXS3Nxg9QJY65jUOh+E7
        kaAoNN4EqSCXteiwj/uCOQ==
X-Google-Smtp-Source: ABdhPJynQgQFRwwrLb/PKBWFaFLkRalheSJSvHZUa1Map+UJYqXcPISSJkCcGmeBawITCQwPKR+5Lg==
X-Received: by 2002:a5e:9242:: with SMTP id z2mr12844435iop.175.1606756988771;
        Mon, 30 Nov 2020 09:23:08 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x17sm11141097ilj.67.2020.11.30.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:23:07 -0800 (PST)
Received: (nullmailer pid 2662313 invoked by uid 1000);
        Mon, 30 Nov 2020 17:23:05 -0000
Date:   Mon, 30 Nov 2020 10:23:05 -0700
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        nks@flawful.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        phone-devel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org
Subject: Re: [PATCH 11/13] dt-bindings: cpufreq: Convert qcom-cpufreq-hw to
 YAML binding
Message-ID: <20201130172305.GA2661895@robh.at.kernel.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-12-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184559.3052375-12-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Nov 2020 19:45:57 +0100, AngeloGioacchino Del Regno wrote:
> Convert the qcom-cpufreq-hw documentation to YAML binding as
> qcom,cpufreq-hw.yaml.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 173 +---------------
>  .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 196 ++++++++++++++++++
>  2 files changed, 197 insertions(+), 172 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: properties:clock-names: [{'const': 'xo'}, {'const': 'ref'}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: maintainers:0: 'TBD' is not a 'email'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: ignoring, error in schema: properties: clock-names
warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
Error: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dts:150.3-151.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1406857

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

