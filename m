Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4FE2C8AD4
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 18:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgK3RXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 12:23:21 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43013 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgK3RXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 12:23:21 -0500
Received: by mail-il1-f196.google.com with SMTP id z14so12040644ilm.10;
        Mon, 30 Nov 2020 09:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNwNXHiMSvl/K6oiBYfJxFqVm8j0n5Lsk6okDP6sH6A=;
        b=O8zpTmbbL3EBJGboEGNxzAxCdbYiKQHuKvMFESdJ4VAFbbFYmn6uMmcf0lkycnbFvK
         qxvz03Iarx3XV+U84GQ4s+on3DESgP4d4/LKeSL3N68BzI/77shOSo7bGdLJgMk66Rce
         Vx+rmiVmw88qgsrtCkjUUG/yyLVXycjFPSrtdSV5yFTRJujHvzNB+KKeK+lWpC3Io7Bo
         5eKHb6QDI3bR+PxOpzqbApY8Sqm9A1SrFxhhwOO/LodeFi1AbPC0vmVdwyXOGQXutESW
         5PEEC7Tj7d7D7hYoCcM6XA1uvW8BUR0JctsJ1OKTuM0zXvgFSQ+jNWp5V3Q/2oHZ7xND
         zXNw==
X-Gm-Message-State: AOAM531WTsABfp7DqtAEUdW+2Xufuhn5PaObDQ6nsAWwoyeBWjjXUmzf
        /rtxCZ7/Iw/F91ZHBVJpzA==
X-Google-Smtp-Source: ABdhPJyxOgCeh5UJ2Rz+bXXFA5rO7bJACGQH+2r2cRBJsEAoNdeLMl0fJVX7ojwx/t9Z3kZZxmNgYA==
X-Received: by 2002:a92:444e:: with SMTP id a14mr2292924ilm.129.1606756959820;
        Mon, 30 Nov 2020 09:22:39 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o11sm8443319ioa.37.2020.11.30.09.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:22:38 -0800 (PST)
Received: (nullmailer pid 2661469 invoked by uid 1000);
        Mon, 30 Nov 2020 17:22:36 -0000
Date:   Mon, 30 Nov 2020 10:22:36 -0700
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, martin.botka@somainline.org,
        phone-devel@vger.kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
        marijn.suijten@somainline.org, nks@flawful.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Message-ID: <20201130172236.GA2632683@robh.at.kernel.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-11-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184559.3052375-11-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Nov 2020 19:45:56 +0100, AngeloGioacchino Del Regno wrote:
> Add the bindings for the CPR3 driver to the documentation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/soc/qcom/qcom,cpr3.yaml          | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml: properties:clock-names: [{'const': 'ref'}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml: ignoring, error in schema: properties: clock-names
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
Error: Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dts:39.9-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1406856

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

