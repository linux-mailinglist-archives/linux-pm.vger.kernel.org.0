Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47EB72846F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjFHQAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjFHQAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 12:00:23 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDB30FA;
        Thu,  8 Jun 2023 08:59:46 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33c37f62e24so2572545ab.3;
        Thu, 08 Jun 2023 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239985; x=1688831985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r0/vEh4IS5CMehqDj3ctEUZ6TxjRX/vT01dCyAoI8Y=;
        b=I0HPpMpnkma2hXICGLoFeShTWJiEgVIUUO2GghL51tjblvcYrni55sbti+bbhZ8KxZ
         8Wo3W/DFb0vOByeuqeAhithuzdnSlY+n2gfSFweXSkgRcscbWvQCWfRtRAJw/NZRo7+F
         tnr2iEIgk89Jjoq0c5BJg9mKS6R3uVyxYDSB/hKOAeRruOnKWe5YGCOCrcwrHFUL/ZCz
         Jwc69H6FqrABfzdOU6YRrvCN0MoZPzdlMIKxH7Bs/7YUoQPPY+GpgmEUBYZuNSqRvkXj
         pvsEWv11L2+cvOsf2YumyPl/U0MYgGN1ueKhv+q2C1ddRmoTSEcZC3jXf51CDIxhERNF
         uzmw==
X-Gm-Message-State: AC+VfDwBtOQWoNjEliXOaz3EzFyHgSe4gZDpa/FPRMtMhynliE1FA9ji
        olRGpUMgcoPqK3fZUA2d13Ki5vo4+Q==
X-Google-Smtp-Source: ACHHUZ7yk/NvwHUsPeiu/6vyCXx/dPrCVQq8P60NJEQ0devZOoPizQaTXfmpEHi948NP/F4ArSEhJQ==
X-Received: by 2002:a92:c710:0:b0:33e:7eb4:8fd3 with SMTP id a16-20020a92c710000000b0033e7eb48fd3mr1569079ilp.10.1686239985202;
        Thu, 08 Jun 2023 08:59:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p5-20020a92d685000000b00331139b467bsm487093iln.21.2023.06.08.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:59:43 -0700 (PDT)
Received: (nullmailer pid 2770356 invoked by uid 1000);
        Thu, 08 Jun 2023 15:59:42 -0000
Date:   Thu, 8 Jun 2023 09:59:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Message-ID: <168623998109.2770281.12624541362600655020.robh@kernel.org>
References: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
 <20230531014248.3824043-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531014248.3824043-2-dmitry.baryshkov@linaro.org>
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


On Wed, 31 May 2023 04:42:45 +0300, Dmitry Baryshkov wrote:
> On PM8941 pon doesn't store the reset reason. However we still need the
> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/power/reset/qcom,pon.yaml    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

