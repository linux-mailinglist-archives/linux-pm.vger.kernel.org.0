Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595CF5109A6
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiDZUNE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354598AbiDZUNC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 16:13:02 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0E1765DB;
        Tue, 26 Apr 2022 13:09:41 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 12so21906054oix.12;
        Tue, 26 Apr 2022 13:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OV/A8v2dbjRut1aFpgKMXrCe55Q4x31l9ygqY/LXSuQ=;
        b=DgZf+Mqd8rGuxOyA7TWI32pmZZXee3XJPGNC/pLuZF/WBNyCCuX+LRhNxN+U6meTwS
         ii5bevICFqs0KPWd4EXTIrtdvW1nN9UsNZXriG+0ToRaHwN72ZAXaCTwW8A90zxbdHXx
         4z11Bg6dhBGwlRBZGDMuiRPQjUUjRn/pwgkUA23qT00KjU8BJkafHCN17ZoYGXWMdjbM
         hTZDgKiVogRgaYH+kSG2VcQYW4dAdSLlw2pi3khvSfQd23T6tk6YVDzVr+U0V87SEG3b
         wWlR1pcX2F0Z9tu0JXtoL2/SlomFMgvM2+EycYJxJJWUX9IqA/igHfRdGoZgrs2+GUP7
         2qpw==
X-Gm-Message-State: AOAM532dV4gk5XP82b1Vkk+IbHqPCl4qj92tu98v9cOqCkCyo+PCM2uB
        hzKCV/wJdUgWUNq3ieRouwwR5zS4EQ==
X-Google-Smtp-Source: ABdhPJyei1KiciUYTQ9GMne5zIIEXZbFAYQFg+lrMhVXm7Re8FviB3mAj53+fhL+2I9V5RSNOQaodA==
X-Received: by 2002:a54:469a:0:b0:322:9e32:e71a with SMTP id k26-20020a54469a000000b003229e32e71amr15306741oic.282.1651003780813;
        Tue, 26 Apr 2022 13:09:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v17-20020a4a6951000000b00329d8b23f0dsm5923382oof.5.2022.04.26.13.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:09:40 -0700 (PDT)
Received: (nullmailer pid 2455313 invoked by uid 1000);
        Tue, 26 Apr 2022 20:09:39 -0000
Date:   Tue, 26 Apr 2022 15:09:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rafael@kernel.org, agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
        ilia.lin@kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: opp: Add missing compat devices
Message-ID: <YmhRg+aEUUZwXcsF@robh.at.kernel.org>
References: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
 <20220418162226.2983117-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418162226.2983117-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Apr 2022 17:22:22 +0100, Bryan O'Donoghue wrote:
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
