Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174395624F3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiF3VQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiF3VQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 17:16:08 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11431DCE;
        Thu, 30 Jun 2022 14:16:08 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id n14so192133ilt.10;
        Thu, 30 Jun 2022 14:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+7nLzMWMWTEMn2W1C8VpkC2aCiu6gzqsfxPis7eOvc=;
        b=3FENsb++GvJFD097InPn3B6IWkbwYr3Lhtwal3xnobVdDsB2W0Ghu+UhtWUawXj32x
         E+yr1+sMpxZ3zG0lkgyGRZKH/zSWKzqPaqJxlFywDVKcbutq2lngInddNT7CwgZhrgJO
         VB4zJ16JKWP63aAUPZ1WHWF3ce6GQFvZ67Xe5NXkWmc/+2zIrzx047rWyOpiyAF6fokW
         rOVf8mWc/WHhB0c6Uy3sk0ujVnD4HLs8JF5iaXo3GL4CdRT4Ae1sfg7b2GCA/kbNmSpj
         fy4THwhbHLmZh7MwYgBS8NrliB8prQTljqsYWJ+zwwYa+lo9AXyDEBErhCqp3eH+YLi9
         yqrg==
X-Gm-Message-State: AJIora+XdOJ3pr5Dd26gtg5FisvmqU5NqyoSVHU8HXf8ODbt5w8d3oqt
        ldOZov56/R2XYyU2r26t8g==
X-Google-Smtp-Source: AGRyM1uUT7k75EK9oHdantNPJyNbc+mpbaVzJ9CF47Z5pKrTAlXUFMHHPfLlZqPv8UmJknqK8sm33Q==
X-Received: by 2002:a05:6e02:20ea:b0:2d9:49a7:bd1b with SMTP id q10-20020a056e0220ea00b002d949a7bd1bmr6296716ilv.169.1656623767240;
        Thu, 30 Jun 2022 14:16:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c97-20020a02966a000000b0032b74686763sm9056820jai.76.2022.06.30.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:16:06 -0700 (PDT)
Received: (nullmailer pid 3313167 invoked by uid 1000);
        Thu, 30 Jun 2022 21:16:04 -0000
Date:   Thu, 30 Jun 2022 15:16:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ilia.lin@kernel.org, agross@kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        viresh.kumar@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH 1/5] dt-bindings: opp: Add missing compat devices
Message-ID: <20220630211604.GA3309310-robh@kernel.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
 <1656542219.641791.1042479.nullmailer@robh.at.kernel.org>
 <3168903b-6850-a9eb-ead5-1389aa37485c@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3168903b-6850-a9eb-ead5-1389aa37485c@nexus-software.ie>
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

On Thu, Jun 30, 2022 at 05:10:34AM +0100, Bryan O'Donoghue wrote:
> On 29/06/2022 23:36, Rob Herring wrote:
> > On Wed, 29 Jun 2022 14:02:59 +0100, Bryan O'Donoghue wrote:
> > > A number of devices listed in drivers/cpufreq/qcom-cpufreq-nvmem.c appear
> > > to be missing from the compatible list.
> > > 
> > > Cc: ilia.lin@kernel.org
> > > Cc: robh+dt@kernel.org
> > > Cc: krzk+dt@kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > ---
> > >   .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml     | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domains' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domain-names' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domains' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domain-names' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domains' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domain-names' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domains' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domain-names' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-307200000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1401600000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1593600000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-307200000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1804800000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1900800000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-2150400000: 'required-opps' is a required property
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> Well I didn't see those errors but, I don't mind fixing them.
> 
> I'll do a V2 for these

This might be fixed already by Krzysztof.

Rob
