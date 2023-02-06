Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCF68C59B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBFST4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 13:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBFSTz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 13:19:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E11AF
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675707547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhvAU6ZF1LkEANx5C+rlnAPFw6900cnUpZORjf4RmTw=;
        b=OPWU0u/Kwp+bD8gqeoaJW0L0hskcwCzwZ3UUuyGSYoFGynBv07XZz54xexPrxLgIL72p7A
        l2Xxx91ALR84wyzKcVBrnA4UgNdo5nld9xEwtHGMQCyEnLYCEJQE/wdvpvM4vIM1kU6cbV
        Alus1FGKvMbF0ymfCzucWtvdfgQlRKw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-y6I9Zp0UNc6j4YbrE63suQ-1; Mon, 06 Feb 2023 13:19:05 -0500
X-MC-Unique: y6I9Zp0UNc6j4YbrE63suQ-1
Received: by mail-il1-f200.google.com with SMTP id d2-20020a056e021c4200b00313bdffad9aso3034958ilg.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 10:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhvAU6ZF1LkEANx5C+rlnAPFw6900cnUpZORjf4RmTw=;
        b=Y4jyhL/vsb89tpVgWNPV4WEMmnWH0J9lMvYmkFzcm/8anlsw8MoSTHrdTD5dGUSjok
         JDOMiv0pI/p0y5BFoeB3qMGSrisRc7OdVCLJHQBttWwKTn8kKhuz50Rnm3fazpAv+rSe
         KroK4t500SoGOttia1D64Hp8hLnxgIo+V4wSt3VzQWLvOR4cO3IuLYgwfW2bfurUnI9W
         mOOnl6VWzkwo0WO0azp86xybscS4D19SV9Yukb18oW0VQSdS5OwFflFahXiPWRwc4dgG
         omw6WbKwfa4hPUhCSGKC0jI1W2/K0+YJGF2PzyPlIN1ag5dFv3a2ZSWBuZcVSVQwkhk4
         C6pg==
X-Gm-Message-State: AO0yUKXTwNBOMHq9t1i1AcVD1+SxpBlFeAWreM5mqJmMrE7Z7DQtK5Ke
        uPBSZCrCUAdKRVm8W07WRZAN+p63AMuWoDxoTQX0zICbUujqsr3KKcmONF7gFKJ6AT0Ur0TP1A9
        R61DGpieo1WN/x8jCigM=
X-Received: by 2002:a92:9509:0:b0:310:c746:d35d with SMTP id y9-20020a929509000000b00310c746d35dmr114875ilh.25.1675707545227;
        Mon, 06 Feb 2023 10:19:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9TfM4R1dtOBwYVl3jyt5Q5tfrV3TDUzJbAC3tAzHDXahYbVOTTf85vkwOrxpIwRDlYEHPrpg==
X-Received: by 2002:a92:9509:0:b0:310:c746:d35d with SMTP id y9-20020a929509000000b00310c746d35dmr114858ilh.25.1675707544985;
        Mon, 06 Feb 2023 10:19:04 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d16-20020a056e020bf000b0030dbd1b725asm3378552ilu.80.2023.02.06.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:19:04 -0800 (PST)
Date:   Mon, 6 Feb 2023 13:19:02 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Lenovo Yoga C630
 EC
Message-ID: <Y+FElkPUkfasI0yU@x1>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
 <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 05, 2023 at 05:28:07PM +0200, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add binding for the Embedded Controller found in the Qualcomm
> Snapdragon-based Lenovo Yoga C630.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../power/supply/lenovo,yoga-c630-ec.yaml     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> new file mode 100644
> index 000000000000..37977344f157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Yoga C630 Embedded Controller.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

Since this is new: Should this be updated with Bjorn's kernel.org
address? Last I checked, this address doesn't exist anymore.

Brian

