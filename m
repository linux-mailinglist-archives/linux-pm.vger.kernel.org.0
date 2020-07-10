Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC17A21BAC5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJQYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 12:24:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38850 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJQYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 12:24:04 -0400
Received: by mail-io1-f68.google.com with SMTP id l1so6641522ioh.5;
        Fri, 10 Jul 2020 09:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qtcWcMeM3SiH3Wm5yxY34abrLuE5rPecmhQcVfTZvk0=;
        b=e8ySMckPnPPzNn4KiC4TSBnjL3iiWH9qI0UfPujOAhWk1BP5PpgHZczicFOrlrKGqo
         phTdQEWRjTndzSAAejDqg4GAr3bBtkEaLl+xMiuBZdyq1UEY/cvrYKi9vz5dlpnfe5pg
         G3cwNYQ1/ObWIBYsGljk1bU8nHFtR2+x3bob6kFkho7jvCer2as23/lg+JMcBNgXZB6+
         NIo+BA+RMSFCtxZqQp9nE+HMsbydFDx7hLtlbZuySmhrALDephC2jCMRIMZf62PeZdXT
         ikx2qXgcc4+j7HioXctAQptjzkf0XxK36PbnVOEolcnEkQoJJ2e4NaLaHM1G21kD9Mbu
         LGhw==
X-Gm-Message-State: AOAM533/8RpaNSPmlEge5SL7EPSQ6iWU8oD0vd+ADI26H89Bcn09alEs
        sfwSz7ENvcgl8ahI8/DMKw==
X-Google-Smtp-Source: ABdhPJxA38bjQ5v1CA4oSC4dgCQvGPFvwg+J+igA5QjNPtmzKtiqtnHpWudXiBOuqXT51iztx9Hlsg==
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr48578200iow.28.1594398243116;
        Fri, 10 Jul 2020 09:24:03 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id h11sm3590660ilh.69.2020.07.10.09.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:24:02 -0700 (PDT)
Received: (nullmailer pid 2744770 invoked by uid 1000);
        Fri, 10 Jul 2020 16:24:01 -0000
Date:   Fri, 10 Jul 2020 10:24:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064
 bindings
Message-ID: <20200710162401.GA2743639@bogus>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
 <20200709215136.28044-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709215136.28044-4-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 09 Jul 2020 23:51:33 +0200, Ansuel Smith wrote:
> Document the use of regmap phandle for ipq8064 SoCs
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts:21.38-31.11: Warning (unit_address_vs_reg): /example-0/thermal-sensor@900000: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: interrupts: [[0, 178, 4]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: '#qcom,sensors' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: 'interrupt-names' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: compatible: ['qcom,ipq8064-tsens'] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: compatible: ['qcom,ipq8064-tsens'] is too short
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: compatible:0: 'qcom,ipq8064-tsens' is not one of ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: compatible:0: 'qcom,ipq8064-tsens' is not one of ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sc7180-tsens', 'qcom,sdm845-tsens']

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@900000: nvmem-cell-names:1: 'calib_sel' was expected


See https://patchwork.ozlabs.org/patch/1326228

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

