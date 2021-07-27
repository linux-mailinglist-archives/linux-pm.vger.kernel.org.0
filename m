Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9913D7D62
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhG0S0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 14:26:51 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:38663 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhG0S0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 14:26:49 -0400
Received: by mail-il1-f182.google.com with SMTP id h18so195241ilc.5;
        Tue, 27 Jul 2021 11:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2ZN+Os4KcblXwXlTL5vzGACuV2+/v2kG3feRmGVKyCo=;
        b=BRzHPIoDVKNnF+bu6IZ/d3FagDEFXVA0zSgzabCx4LooKpQX3bTf+mR4KdcAzI1FYy
         bnpoVL4KEZiZa8H+9D7PslSOtTiqTiYF9IEa1A0z+E35hBlsaKHMFo7R18rxweDKZHqa
         whOhD54HRVGeg+Wv5WTwOJwIkU8P44QkCs+g0A4j2R/fEZnGiHC+mfwAJgZvjAfK/Qez
         RNjoqjCsNNVvUF/hJPo/crFdz2JFpA0a9dM38H3Fgnks76s72TknnN8Mb4GG3hAcMdeC
         KADI1pgXxqXR933G804S/e7NnssuZPDgX6x++vNBq38rQ0erhewmrPSEoyT5imLUOe7o
         1u0w==
X-Gm-Message-State: AOAM533KHYu2IKBCdmQSCuqRd059x+pgRXFgsFHVIpY1CUfXXGdpRdk8
        alhJMwZobAtFDaAfTE+D2w==
X-Google-Smtp-Source: ABdhPJxJ2NYaxQ1nbNMMl3dkF0KXaLypDNB2gEo4iR1RWB0PAxHYmIYgSOJlEvITbTdqjse0NV4VtA==
X-Received: by 2002:a92:dc8a:: with SMTP id c10mr17390858iln.48.1627410408071;
        Tue, 27 Jul 2021 11:26:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h13sm2066103ila.44.2021.07.27.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:26:47 -0700 (PDT)
Received: (nullmailer pid 3210656 invoked by uid 1000);
        Tue, 27 Jul 2021 18:26:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org, robh+dt@kernel.org, viresh.kumar@linaro.org,
        devicetree@vger.kernel.org, rui.zhang@intel.com, rjw@rjwysocki.net
In-Reply-To: <20210727152512.1098329-7-thara.gopinath@linaro.org>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org> <20210727152512.1098329-7-thara.gopinath@linaro.org>
Subject: Re: [Patch v4 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Date:   Tue, 27 Jul 2021 12:26:35 -0600
Message-Id: <1627410395.886153.3210655.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Jul 2021 11:25:12 -0400, Thara Gopinath wrote:
> Add dt binding documentation to describe Qualcomm
> Limits Management Hardware node.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v3->v4:
> 	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
> 	  a phandle pointing to the cpu node instead of a number as per
> 	  Rob Herring's review comments.
> 	- Added suffix -millicelsius to all temperature properties as per
> 	  Rob Herring's review comments.
> 	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
> 	- Other minor fixes.
> 
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml: required:3: None is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml: ignoring, error in schema: required: 3
warning: no schema found in file: ./Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
Documentation/devicetree/bindings/thermal/qcom-lmh.example.dt.yaml:0:0: /example-0/lmh@17d70800: failed to match any schema with compatible: ['qcom,sdm845-lmh']
Documentation/devicetree/bindings/thermal/qcom-lmh.example.dt.yaml:0:0: /example-1/lmh@17d78800: failed to match any schema with compatible: ['qcom,sdm845-lmh']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1510556

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

