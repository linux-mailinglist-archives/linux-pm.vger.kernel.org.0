Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE85624F9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 23:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiF3VQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiF3VQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 17:16:25 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5F33374;
        Thu, 30 Jun 2022 14:16:25 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id i17so188617ils.12;
        Thu, 30 Jun 2022 14:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JaiQRa9DAPraA6IMeaHtsfsxx9rxyM6yNzdmE/ofRe0=;
        b=2clDUQ7ir8bhlWYioCIafiJYrcouS/8maeKeq1J3EZGFmUmhl3fa82ekjKstMJZ5wt
         ktZ8kkkOLjNIfNKTvScpF0jit+zaT28e//moDUp6CZMAB6emv3g+WLpiwZMGzQXy3bC5
         Hv+iou3baZAacHn0iKhIp/LdAe+Xp5G/o6h3urv+kcD7nbqoYsUJOcM/WLZkr2znd4qZ
         xe4RljPrmWQ4bx5yWNXEexhO3GWWcO1HDvxxwTwMjGsXjAuz912KLdvrNEh38mjF95vk
         ZGS/0U2U8J9hiKjBBbOKUtMrbBWoHPe6JirOZ400pWfjc1ptn5ilZq5Ixk3a+xAGEAFr
         911Q==
X-Gm-Message-State: AJIora9/ht7vnCYpTO3AbrbqJVOvz2lJZY5onkxVeWJ7oNa8dfdCgWE3
        kIqSrAiLEvedHYyxX+MZwQ==
X-Google-Smtp-Source: AGRyM1tr/0Nir5l5yIltvIP2yFTOmc1ev6s/ojbhFKZsOAYnOc1wSCyWQORxf+5cOM98VXcgkiHZlw==
X-Received: by 2002:a92:cd8f:0:b0:2d9:5d44:6a53 with SMTP id r15-20020a92cd8f000000b002d95d446a53mr6406085ilb.226.1656623784259;
        Thu, 30 Jun 2022 14:16:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056638451b00b0033195fabca4sm9166992jab.175.2022.06.30.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:16:23 -0700 (PDT)
Received: (nullmailer pid 3313669 invoked by uid 1000);
        Thu, 30 Jun 2022 21:16:20 -0000
Date:   Thu, 30 Jun 2022 15:16:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org, ilia.lin@kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [RESEND PATCH 1/5] dt-bindings: opp: Add missing compat devices
Message-ID: <20220630211620.GA3313612-robh@kernel.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
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

Acked-by: Rob Herring <robh@kernel.org>
