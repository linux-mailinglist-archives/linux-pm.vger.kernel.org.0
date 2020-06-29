Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3320E86B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391913AbgF2WGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 18:06:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40152 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404852AbgF2WGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 18:06:39 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so18891303iow.7;
        Mon, 29 Jun 2020 15:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7i/LtCWxvjcrkXKayf7wJy9l1xOiA2SNi/swky4zLs=;
        b=qLdJXcPscwc3PFY50yegWdAsLBHC54GiL4gYXMR3cLhKfeE3Qc4tzIKGsyz/QutbkW
         dNFNivu56Q9rxEcbHgc6nt7Ux9uxtTPEgSbkkK2VaLArJUTSPLPfOhjQvFqNXhEGsONp
         HfF1/16rL3djkFNZIkWNL//zR0Ve5ogJUcR5mW/cp6UOajRLAQcpAODLTWpdHJptoBVL
         LBBWcvW8YyxiMfdAlWVxig9cWw7vxrNdjS2LpMOP969UKZLN3VTaduq5qoJzzelrnD5V
         yDIK+ZWMemU8w/3LmJL4WJI8dfK8Vpq3c0IiHyaGamLZzf32CN0tUBCFDJyGszPasPcE
         8HXw==
X-Gm-Message-State: AOAM5310p9e0Oi5sOfZduAQx7NXmtg+f0oMJCFh4x9/0jSfeaaR0+oWg
        i+CdgQSAe1IZS3VvIj+Fgw==
X-Google-Smtp-Source: ABdhPJzu7iHEmXhdSieXnQBr0DvEvJgrCjdJBUPurQFawvCOFA7nufQByGRhQUQtaAcZ36ucGFZwCw==
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr19143451ioh.182.1593468398381;
        Mon, 29 Jun 2020 15:06:38 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id t11sm627471ils.3.2020.06.29.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:06:37 -0700 (PDT)
Received: (nullmailer pid 3025233 invoked by uid 1000);
        Mon, 29 Jun 2020 22:06:36 -0000
Date:   Mon, 29 Jun 2020 16:06:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        catalin.marinas@arm.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, will@kernel.org,
        talho@nvidia.com, linux-arm-kernel@lists.infradead.org,
        thierry.reding@gmail.com, bbasu@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 1/4] dt-bindings: arm: Add t194
 ccplex compatible and bpmp property
Message-ID: <20200629220636.GA3022986@bogus>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593186236-12760-2-git-send-email-sumitg@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Jun 2020 21:13:53 +0530, Sumit Gupta wrote:
> To do frequency scaling on all CPUs within T194 CPU Complex, we need
> to query BPMP for data on valid operating points. Document a compatible
> string under 'cpus' node to represent the CPU Complex for binding drivers
> like cpufreq which don't have their node or CPU Complex node to bind to.
> Also, document a property to point to the BPMP device that can be queried
> for all CPUs.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/cpus.yaml: properties:nvidia,bpmp: Additional properties are not allowed ('descrption' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/cpus.yaml: properties:nvidia,bpmp: 'descrption' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/cpus.yaml: properties:nvidia,bpmp: {'$ref': '/schemas/types.yaml#/definitions/phandle', 'descrption': 'Specifies the bpmp node that needs to be queried to get\noperating point data for all CPUs.\n\nOptional for NVIDIA Tegra194 Carmel CPUs\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/cpus.yaml: properties:nvidia,bpmp: 'description' is a required property

Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/arm/cpus.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/arm/cpus.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1317775

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

