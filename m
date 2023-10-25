Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03D7D6544
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJYIg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJYIg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 04:36:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824A129
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:36:54 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2b1af09c5so3181114b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698223014; x=1698827814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFUU64/OUuF1nn0EtOhMJ/Ae7a+hOsjEWRp2Dhz9W0c=;
        b=ZYkUZEm4L7uaBrMrky71FGR/1rk36yfxmK+SVWY7N9XZjVAdc5tAfIAx1nTmDgJGiA
         AI5bgZH9Ss7LX1N0HA82HJBJju1BZCqMJQZnLTTFSwSz5peJLgaZq8croCLCrcW9g6SA
         u2/FPr6mosrotu1mOInysUlFM/aCmILPc9HoQAZinaMm2Vn7RiBiB8evcz0VHEcawBkP
         cFlzaSnA4m+jS8Irc/usevaT9/IYg6n1mnmvAlXMascKv+NEgjKTxqVTwov/d39X2Uc1
         tTJ1qQVpurfgn4lDTpkh1RSD8TtFUS6CBGKzeLn480VUzXrPXvDcdVQNUumrVukXJtjQ
         xJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223014; x=1698827814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFUU64/OUuF1nn0EtOhMJ/Ae7a+hOsjEWRp2Dhz9W0c=;
        b=N4jzSMggEWO9BKlcTIONAZLb0O4Lah7Pn+joo/YzhBx1VWdAU0mTxu62sSQs9mP7mc
         JsudNExPrxHdofLMF4mDEgmAPsFaZu4WE3I0W+EXgDwd3GyCpqEkwHTntCF4FHZu1OyP
         scI/4VJUSYkjqVHWC2TPEzpUEkKJ/L6e1WnfpJryulixN715l8X8HNDeE+ROtwoWDjAb
         zHrNGwcRS4fi8GyeHUGgweRaW9tWFjX6XRWRSiouk1sWFldyJfV3Ho/RG8/ZSTuOAuu2
         9481bNgAJOK4iEPPnsccZnS9BIxKdaHv2Y3AF5bg36q75bwuTLqgFuVQ9hi7p1RP8ZTy
         MmVQ==
X-Gm-Message-State: AOJu0YzWBqXz18Z6045jZjcXONDt73YSa5mKYZWv4073OB+iXPCHQRuv
        wlpV77vYyLuOqb9ZKUOx94zCResDHg67L61ELrRmlcJveJ2ayps5XfI=
X-Google-Smtp-Source: AGHT+IG/GggL0RFatm6CzkOC4Y36ZQHValYB73KmbvVCy3HhRMzE1zGwMdJhW19B90K/3jxacKZkXu64KN1CGeuyGkA=
X-Received: by 2002:a05:6808:1a88:b0:3ad:fe8d:dfae with SMTP id
 bm8-20020a0568081a8800b003adfe8ddfaemr10855002oib.57.1698223013802; Wed, 25
 Oct 2023 01:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
 <20231025-topic-sm8650-upstream-rpmpd-v1-2-f25d313104c6@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-rpmpd-v1-2-f25d313104c6@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:36:42 +0300
Message-ID: <CAA8EJppPzjdpeFksu-0h0FbYwy5bC=X0f-61_zPL4-sH=3n6zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add SM8650 RPMh Power Domains
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Oct 2023 at 10:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add RPMh Power Domains support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

-- 
With best wishes
Dmitry
