Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1C744FE3
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGBStD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGBStD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 14:49:03 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2810F1;
        Sun,  2 Jul 2023 11:48:55 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7836164a08aso203263039f.1;
        Sun, 02 Jul 2023 11:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323734; x=1690915734;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJNWUbrku1kIHtg72m/Wbm4WBGnlFB7vhWBdXWjLIY8=;
        b=ER6M1Ypq1391i9jyv/O6Dx+xM52mooPLWzrDBnG7dzKRwIdBjWoYl4rPVDKYIno84Z
         LOERH4fg374OMSmRaRIJy+6JGb0UBG+KtceQ/8sp/nmDKVzjN8bJyZWPgAyfmidoMFux
         N+8lY3KzYDkCr4eT7XKaqanG4nxuRX19X1O5s8s6Z95Nf4iWDGcSWtJJ77r0R2aSfoIV
         zlxegbJGUFHd52mVt5DLpvTLdIH7aIpNwFAW5gogMeWEbJJynTlzz/tnToWXZwrvGpMr
         xc6fMgTsOxowu6B3Q4y4yiHYDL9Mgz8sfVo0VXheDXJBEQKRyB20XOJfXtqTZ7Gzghjn
         IW2Q==
X-Gm-Message-State: AC+VfDzHDRNgKVVlfqyCypRE9eqRBXS8jGhJutgMPVgS3WXskKoLnQ18
        SkHIYUDHVijBklLANZ6e9w==
X-Google-Smtp-Source: ACHHUZ6rNUM9Vh9PrsfkN6dwjxUGgd2YCCMmuqviNzP8UbLi68XmwfMS0tJV9jyIMSlSbRniiu6nYg==
X-Received: by 2002:a6b:a0b:0:b0:783:58d1:823a with SMTP id z11-20020a6b0a0b000000b0078358d1823amr9282865ioi.9.1688323734164;
        Sun, 02 Jul 2023 11:48:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d84ce000000b007749c05ab14sm6792320ior.2.2023.07.02.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:48:53 -0700 (PDT)
Received: (nullmailer pid 1628574 invoked by uid 1000);
        Sun, 02 Jul 2023 18:48:51 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <djakov@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
Message-Id: <168832373109.1628543.12772150086810323580.robh@kernel.org>
Subject: Re: [PATCH v3 05/28] dt-bindings: cache: describe L2 cache on
 Qualcomm Krait platforms
Date:   Sun, 02 Jul 2023 12:48:51 -0600
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


On Sun, 02 Jul 2023 20:42:23 +0300, Dmitry Baryshkov wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230702174246.121656-6-dmitry.baryshkov@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

