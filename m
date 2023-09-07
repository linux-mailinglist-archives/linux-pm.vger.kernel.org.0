Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF477974D8
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjIGPlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjIGPfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 11:35:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89C1FC9
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 08:34:34 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58dfe2d5b9aso14494797b3.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100840; x=1694705640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbK6fKvS9Fgoje98ZfydB5ImVNxTq9WKZiMHsHIMJYc=;
        b=MH6X+FZfAM5YBs/S2sUYZ4OQ2GoFvdBu776GPzJmIctBWo3Icro27seLGtsEmYjKm3
         mmEqLTEpEWfO2QrvBSDwH42HLHhSDhCJt7ReQYcaCQMaJGcbBvRbekB4QkNqEcne9GrY
         yTMpr4B3s60GJRgSBE2g/FG8R6CwkyXJ+HsAEugINRCo7OmjLGCWXRyIEtiNHpTN9VMb
         Z1wHDC9gj/w5DSHF2CRMyPdvtsJrcmKBS3NRTi4yOpB8DWma1crOuugCVGCUXEKZY+vW
         k40YBCyX8StxqAsDAyp8+aA3ikbk0BbH0Jm/zns0e9kedsF6qdN53qSwMApUzrGczNo2
         naKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100840; x=1694705640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbK6fKvS9Fgoje98ZfydB5ImVNxTq9WKZiMHsHIMJYc=;
        b=kans9jhl/+ZXGDmJjgwD6IoXbngaZAYouK7ks4HQimWVjcxua5NTKOxRq/pRe67suf
         WIs8isQ5bv8GQBpbXKFryacdjkAieRj8IlbwhHRcW6MsN7AXZlShmrVv3P78qtJEzzRw
         wPUG/l9VZ9Yx729RsAQbaA3OgeA/hMHYxvgNytrkywp1KkMlZu1n609pelw8Bg6YcvYB
         1DaDZVbSS+2hnr5i6qwnHgB7vaGRHoB7JZ6xJ45jgqzVGKiBacDasCHmQdglyW/u8vNF
         CWtBw2S9OJ2ZM7++Py173ti5IE4FtCcGhS7A8TkyJNkaRq+S1wrfCrrWYweP/PZ4k/5M
         90jQ==
X-Gm-Message-State: AOJu0YyhZzrjXcuN7w0KogAP7xvdCKmAesUOL8SB7As1pcqDRBw/3oWS
        9X5r4mm0vZRCjaVEpg0TsJKabBphGFeyqxE7Ntb0NCXnyC38T6FL
X-Google-Smtp-Source: AGHT+IHu6D0PjyoNN/3icMZDTJRryJCp5e4gDUZ/wy83CohE7b2nsJzK7Ge1NIZAUgYV6LutVWZGRWBUmBFmeDVHGrc=
X-Received: by 2002:a05:6902:154d:b0:d72:8a65:394f with SMTP id
 r13-20020a056902154d00b00d728a65394fmr3971430ybu.18.1694094049986; Thu, 07
 Sep 2023 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <543183ecfba929683c1b8d7ff24d75df489ef0cf.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <543183ecfba929683c1b8d7ff24d75df489ef0cf.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:40:39 +0300
Message-ID: <CAA8EJprSHCx6TQ=-iEV6L55b69yYKANCJmGSqN+YVSv1dSCAqg@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The earlier 'l' value of 0x3e is for 1.5GHz. Not all SKUs support
> this frequency. Hence set it to 0x2d to get 1.1GHz which is
> supported in all SKUs.
>
> Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
