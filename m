Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC865BC341
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiISG65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiISG6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 02:58:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A691D32D
        for <linux-pm@vger.kernel.org>; Sun, 18 Sep 2022 23:58:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so32749044ljq.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Sep 2022 23:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UXvzNY9WWFT1v7vAfbxWfr9qr5ssnDrbFnxCDWveRyQ=;
        b=UU45yYL68ivM+qw9w8N9YhmGzkm5v0qu7kGADmPxdb0xhywN1VMrAmsNwRjx2dadO1
         O0tQTmdaMTLgsA+vVW+s3XqHJqCyrycEXh7AKfk5UrT1RVmo58KxQ//AzXzjtkWvc34y
         th6BMBWBviuo6syks5HwfZcdk2ZQApkv5z0yFzYHANX2sW5kxTX20mq4aEXPz3ccwsrW
         QSnqNL2tilihrik7qk7yntR+ZI0eJYfesH40IDRcg0fmz1nNdnYiiuq6UHRDCxQZQ8jp
         mHDW5VQotpo0YGRsiVnp6ApaNVPUx2XIYwLGOKKnNUQK+4PzQa3pwASICQJJ8ZXrgrdj
         rsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UXvzNY9WWFT1v7vAfbxWfr9qr5ssnDrbFnxCDWveRyQ=;
        b=q/HsFWL2oAkgkzIGjU+p3vvdqS6R+tuk38UUCL3xCARhUIYkOvGueYcA4DCXOc+/je
         GX2idwMoaWS8g6lP0ntCEmOd5LZvFDSWSf3X717x64cEMG2AeAloX6EgUGKFSEAxvy4+
         R6IZ20HxkJcsL6x9XzEJqs9ylEyL+saXVYJBY+dt8tT4gONejSnR7POTm3bdJzer5uvZ
         hiCBw7I7TKenP7uzh3tHq/JIj5R3TmTp+ox/ATTovbXfHd1icXwesuRNnEOso6TcW4Yq
         IrjPN6bMjpt7olCp2kKkKkLZTWp6s0kFFgptZ0zC1/uOSy4+pPdzs08iAEAG49ZV3stY
         nN2A==
X-Gm-Message-State: ACrzQf2NXvPVV04bDp8GYZypveRvfaORWYWOzj5FveY46DxS0SMYie6c
        CpVw1BUs/opZ7G7jq19i95IBBg==
X-Google-Smtp-Source: AMsMyM7Qh/83u/LK4ogM1Bxeq4ntIDeo+3CCpkxbVjK1fcSeFAztCrA2iCJdT7aw1zzUsTxpnNlq1Q==
X-Received: by 2002:a2e:bc11:0:b0:26c:565:12f6 with SMTP id b17-20020a2ebc11000000b0026c056512f6mr4528557ljf.91.1663570726912;
        Sun, 18 Sep 2022 23:58:46 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f36-20020a0565123b2400b0049f530939aasm1904249lfv.126.2022.09.18.23.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 23:58:46 -0700 (PDT)
Date:   Mon, 19 Sep 2022 08:58:44 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: thermal: Convert ls2k to json-schema
Message-ID: <20220919065844.su3hpqbwzdqmzzw5@krzk-bin>
References: <20220919034915.26912-1-zhuyinbo@loongson.cn>
 <20220919034915.26912-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919034915.26912-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 19 Sep 2022 11:49:14 +0800, Yinbo Zhu wrote:
> Convert the ls2k thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/thermal/ls2k-thermal.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml: properties:interrupt-parent: False schema does not allow {'maxItems': 1}
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml: ignoring, error in schema: properties: interrupt-parent
Documentation/devicetree/bindings/thermal/ls2k-thermal.example.dtb:0:0: /example-0/tsensor@1fe01500: failed to match any schema with compatible: ['loongson,2k-tsensor']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
