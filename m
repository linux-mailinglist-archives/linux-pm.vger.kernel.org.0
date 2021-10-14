Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B0C42DBB9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJNOdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 10:33:36 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44885 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhJNOdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 10:33:21 -0400
Received: by mail-ot1-f47.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so8433483otl.11;
        Thu, 14 Oct 2021 07:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7LzJFsTPL40Pc0hD3eRsvasVcxgNW0015ccj9x8BWbg=;
        b=Q8A57+h8Ie/QPPBXGBjOJT6GLPb0lLjabjOA8QcGwohU9QBlY6Htgomp9iE3iEddqd
         atAaz+Wu3MOYG7T5E/4teFIzdV1kQW/cJ+gZISblj1xrA6N4BTTCx00DAcFIZCY6ltBq
         ettFddHUhhx/JO0hWVQnCSPj7R1Wi9Qj2Il7B/YP/m+1UHz9DSPWIOTDtIcPDr7UKXqp
         nmDkxYe5OfrSzOIn2JV2dJ+YJJ+6BtwGB+hoPa9LU7MS/WjHfab/PYCP+q4GyNM5V6Hx
         iHiJcy8/KqykhIDrzaOVppCoPdvpEhXbXEx07R6dtkfNHW3/fp2igyubXgltquxrbTWg
         gGPw==
X-Gm-Message-State: AOAM5313zgef+AyvkseWdZF73m9z/XeR2ypGzenTeNZI9OLbMPAAe4Y9
        2OxPqURGh86XxpXX9KLjyw==
X-Google-Smtp-Source: ABdhPJydt6+seG1Ow1oKkFS7PuvHRQL4pi2sc6D14ULOw8igIp7Ajhnn3IoxCd262A14/DP1SMv1jw==
X-Received: by 2002:a9d:7f81:: with SMTP id t1mr2758721otp.376.1634221876072;
        Thu, 14 Oct 2021 07:31:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y4sm595787oix.23.2021.10.14.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:31:15 -0700 (PDT)
Received: (nullmailer pid 3295879 invoked by uid 1000);
        Thu, 14 Oct 2021 14:31:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-clk@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        phone-devel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20211014083016.137441-6-y.oudjana@protonmail.com>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-6-y.oudjana@protonmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
Date:   Thu, 14 Oct 2021 09:31:04 -0500
Message-Id: <1634221864.175463.3295878.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Oct 2021 08:32:35 +0000, Yassine Oudjana wrote:
> Convert qcom-nvmem-cpufreq to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/opp/qcom-cpufreq-nvmem.yaml      | 877 ++++++++++++++++++
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ----------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 878 insertions(+), 797 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.example.dt.yaml:0:0: /soc/power-controller@b018000: failed to match any schema with compatible: ['qcom,qcs404-cpr', 'qcom,cpr']
Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.example.dt.yaml:0:0: /soc/power-controller@b018000: failed to match any schema with compatible: ['qcom,qcs404-cpr', 'qcom,cpr']
Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.example.dt.yaml:0:0: /cpr-opp-table: failed to match any schema with compatible: ['operating-points-v2-qcom-level']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1540830

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

