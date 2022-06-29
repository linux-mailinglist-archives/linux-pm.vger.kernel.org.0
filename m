Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D3560C63
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiF2Wjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 18:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiF2WjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 18:39:05 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4621E3F0;
        Wed, 29 Jun 2022 15:37:09 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id p128so17484282iof.1;
        Wed, 29 Jun 2022 15:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PblpVWpvP4Mlg/XpzinVZ7+H1NQejQIk7gpI4n/YkVA=;
        b=JohbpqY/AciEBlMYqcrCoc+sDXyONERKMgU9pueU8BrPetxYWqOS1QqqrOxw1eaUNy
         ZLJWzXH1V3K2WzsLSu84BUcb6oayB9uDec7SNdJkF9gv7MPvqgx0XHX+8mH97d68ZOhG
         i7bn8IllUD5HL8H8QOX1yltPkP7Aa9mSHd4UwN7QUQfH/zHOoaPXbRBdncjhoy/qKMjW
         BNJjXrsWqPChXII7atWcEazOwHsiUalzPPOc+qfEqGTzehB/SAe1yhVaX+uRc/dQps8F
         kQdM4c3v/A3CKrz6PA0VJ0trvvLENtFk2TNlyzxusMQZJHhGKVajDZZKdjis/24VzqCA
         81qQ==
X-Gm-Message-State: AJIora+Bu52iTB6TOTacd7grK7qCzpXy1zw9YdZYa8ksbGwSv2cgBP+J
        zNTM65uIlw3j7ORj+ZVUBugsOr6fzg==
X-Google-Smtp-Source: AGRyM1uB1StHyWE9SyBTWI1xOAT7t1T8HPaTXqhinGSqNnCsuY7X2NOCBA7TJszxIeJbR8r9S2YDKQ==
X-Received: by 2002:a05:6638:300f:b0:335:b12d:3126 with SMTP id r15-20020a056638300f00b00335b12d3126mr3243964jak.210.1656542229016;
        Wed, 29 Jun 2022 15:37:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x26-20020a0566380cba00b00339e18d2c9bsm7868449jad.115.2022.06.29.15.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:37:08 -0700 (PDT)
Received: (nullmailer pid 1042480 invoked by uid 1000);
        Wed, 29 Jun 2022 22:36:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ilia.lin@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        viresh.kumar@linaro.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org> <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
Subject: Re: [RESEND PATCH 1/5] dt-bindings: opp: Add missing compat devices
Date:   Wed, 29 Jun 2022 16:36:59 -0600
Message-Id: <1656542219.641791.1042479.nullmailer@robh.at.kernel.org>
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

On Wed, 29 Jun 2022 14:02:59 +0100, Bryan O'Donoghue wrote:
> A number of devices listed in drivers/cpufreq/qcom-cpufreq-nvmem.c appear
> to be missing from the compatible list.
> 
> Cc: ilia.lin@kernel.org
> Cc: robh+dt@kernel.org
> Cc: krzk+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domain-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domain-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domain-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domains' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domain-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-307200000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1401600000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1593600000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-307200000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1804800000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1900800000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-2150400000: 'required-opps' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

