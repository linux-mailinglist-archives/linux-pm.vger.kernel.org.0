Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A662C8A60
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 18:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgK3RD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 12:03:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38390 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgK3RD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 12:03:56 -0500
Received: by mail-io1-f65.google.com with SMTP id y5so11443257iow.5;
        Mon, 30 Nov 2020 09:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVRcg2DyYnY2T86oR8Te89KJ9jB7+OaNC7lMLPrhpP8=;
        b=ahmXBkPUBEU9PzW+agYRUZ498p92yF8F3lYqdX9XwtbaVVkuEdalYc03l2nK+eKt9L
         xJ2s14a/VuBPS7DsdSe3c1MCp6kXu9ITEEAIYfZh0KL74rjbgZrfN/h6IytLT36VybOs
         7u4xMVLn9+vRBDMaltPyniZ89Qr3fH/IrWqjv+iXk3B+ZEClLJ96l1u5nnTlXAjJVCJQ
         QTdVvLYftHt3UBo6w94BRuTcsZsdHAQcVer8eT9lEQ9blCDUw87dBbfKsHhT1JlN40OL
         hO3KfGS4e6GVOvMFNzsKuqt6xG5Po1UBJfAic1ksh1hf342w+OK9nOSgoTGrdJopQ9yb
         ADnQ==
X-Gm-Message-State: AOAM530t0+PA0vKX/pCVj4Zu5ZGBPAiiPfuSR5RPBpB6qy96u8laYSgG
        HyQqwERvHmOsBivEVsQq+w==
X-Google-Smtp-Source: ABdhPJyjovkgkPmew9hFyzwW0sWCRJdcvlG4zeJ8246X7c+JB13zmvU3zgYWciFKeDBC2ZGXUfxVAQ==
X-Received: by 2002:a5e:d717:: with SMTP id v23mr12204718iom.60.1606755794761;
        Mon, 30 Nov 2020 09:03:14 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t12sm8339755ilu.46.2020.11.30.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:03:13 -0800 (PST)
Received: (nullmailer pid 2631520 invoked by uid 1000);
        Mon, 30 Nov 2020 17:03:11 -0000
Date:   Mon, 30 Nov 2020 10:03:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, martin.botka@somainline.org,
        rjw@rjwysocki.net, phone-devel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-arm-msm@vger.kernel.org,
        marijn.suijten@somainline.org, jorge.ramirez-ortiz@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, nks@flawful.org, konrad.dybcio@somainline.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        broonie@kernel.org
Subject: Re: [PATCH 07/13] dt-bindings: avs: cpr: Convert binding to YAML
 schema
Message-ID: <20201130170311.GA2630904@robh.at.kernel.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-8-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184559.3052375-8-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Nov 2020 19:45:53 +0100, AngeloGioacchino Del Regno wrote:
> Convert the qcom,cpr.txt document to YAML schema and place it in the
> appropriate directory, since commit a7305e684fc moves this driver
> from power/avs to soc/qcom, but forgets to move the documentation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 131 +-----------------
>  .../bindings/soc/qcom/qcom,cpr.yaml           | 115 +++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 117 insertions(+), 131 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml: properties:clock-names: [{'const': 'ref'}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml: ignoring, error in schema: properties: clock-names
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml


See https://patchwork.ozlabs.org/patch/1406855

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

