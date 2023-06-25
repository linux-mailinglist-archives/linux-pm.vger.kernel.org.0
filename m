Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC373D4AF
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFYVsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYVsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 17:48:40 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B17C6;
        Sun, 25 Jun 2023 14:48:38 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-780ca92d8f5so154042239f.0;
        Sun, 25 Jun 2023 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687729717; x=1690321717;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqIbZFmHB773z8GF+Mo4Z7g3WzNCRfvJQwoqNsoGcUU=;
        b=IhwLpqXgzfm+EnOFRsW9C4w3eitYe9T8ImsssT/hhwXbYkvkroS0txkc54VbPzNa5L
         yjMQFM4+pm6Cfj79r0gioWUNlDTa+UT9LyOmr4Q6bWreX29kkcnEBWwG1hOeFKyfNkDu
         h6ncV15Cyw6mglVTqgxxURSZAWp+XGhnrbJXnS/x6qpGiHFjbWfjydVK1MsWlPBIi5gR
         wSHnFoBFh/K34hnz+X1M+re6Z/f2rno2aL6rIWTe4kVuQa7UwTXgfewHcz5gmvnbZBDe
         aXg0D5efePtZ63qANB7a0fsBXsSTCLYpTfxpporlf3DkSg1lMvPQqefiO4fEr8oNoFzn
         2OVg==
X-Gm-Message-State: AC+VfDwm9iH1t8/eRCU1HeBkG0aoCCrL7MCoK7S+QAfNE0okSY/wRWNj
        2DWPWuoDKzOK0poQNv03og==
X-Google-Smtp-Source: ACHHUZ6QS/ZKbgT9vjGZlmAIMn8s7rGDKi3jBPniFtaadVG6zZYRg/iYS8ATVGKrzFQT7bHaNNWnJQ==
X-Received: by 2002:a05:6602:357:b0:783:3943:581e with SMTP id w23-20020a056602035700b007833943581emr4578052iou.7.1687729717242;
        Sun, 25 Jun 2023 14:48:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dq42-20020a0566384d2a00b00423230a3085sm1297927jab.99.2023.06.25.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 14:48:36 -0700 (PDT)
Received: (nullmailer pid 1364631 invoked by uid 1000);
        Sun, 25 Jun 2023 21:48:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <djakov@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230625202547.174647-6-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-6-dmitry.baryshkov@linaro.org>
Message-Id: <168772971459.1364605.3603930032942558144.robh@kernel.org>
Subject: Re: [PATCH v2 05/26] dt-bindings: cache: describe L2 cache on
 Qualcomm Krait platforms
Date:   Sun, 25 Jun 2023 15:48:34 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sun, 25 Jun 2023 23:25:26 +0300, Dmitry Baryshkov wrote:
> The L2 cache device on Qualcomm Krait platforms controls the supplying
> voltages and the cache frequency. Add corresponding bindings for this
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/cache/qcom,krait-l2-cache.yaml   | 75 +++++++++++++++++++
>  include/dt-bindings/soc/qcom,krait-l2-cache.h | 12 +++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
>  create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/sifive,ccache0.example.dtb: cache-controller@2010000: Unevaluated properties are not allowed ('compatible', 'interrupts', 'memory-region', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible', 'l3-cache' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dtb: l3-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible', 'l3-cache' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l3-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible:0: 'qcom,krait-l2-cache' was expected
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: compatible: ['cache'] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: '#interconnect-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dtb: l2-cache: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230625202547.174647-6-dmitry.baryshkov@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

