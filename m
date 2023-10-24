Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F677D4E42
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJXKwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJXKwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 06:52:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464A128
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:52:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af45084eso41775357b3.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698144727; x=1698749527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByymKernzbt7l2A1qflNQoCJCAiaYl24vxzOmzj3yAc=;
        b=Zd5lP/sXC75EiIvr2ffUWi6wB0HRiVU/GYXEbrKB15tS3Mp5En2zqZhFNayCkmcNPW
         uAHNGNKsG5wdYc3yoxSJROLEqeYB4yQK9tzFU0QjUpddTexI7+ajKFZgHJbQTHjjV/ZI
         2llVWBpqUHfgD/8fZeUD1+2RJLDEqb1N4IWYeIoL4fGF/kKdiyqp1vbMPMjw6fK/ebvv
         i2ClR15E2AQObTTnfFU3leIhaTYFBQ6rHUPFRR1SRjy5Z8O4f+rYH8JYpZLrlGlfkjpy
         OzY0mV315C3sMtOnm9D0OJ4Q0kNIjMubXIziLj82Tg43wFZbzn4l8V/8Mp0pjTcwYO0L
         UZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144727; x=1698749527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByymKernzbt7l2A1qflNQoCJCAiaYl24vxzOmzj3yAc=;
        b=vtKHu9GWqke+9Qh9E6hy7qsEh0TI+tx1xvH0yPCS7aUpdfJwAAVBFKw/ZQitmhrEGq
         bo5ohGbIELkpE6OKxWMVLP4FvEISvuXfa+eD13kH7LUII+2Erb1jVapyDoAQeY0GcuhH
         sR5RVPGEHdeyk/w3h5DJ4KmH16TXLKeaRd44BJJ9l0cBo03RcClBBF3X/DM2yaQZf0vb
         FrPPBfldWGAHhyvnKuKC5ZXf1UYJawaslomryEGWJghXzfbl77R40pVaCU6TwepvAJmN
         9okbUuSjHkBDuQTpEbjFb3yDI+VpTcw7mMwegoXkAdchaQQV87t2+GrY1BHHSEfRvwLl
         O3UQ==
X-Gm-Message-State: AOJu0YxI+vY6E42JZm30MN+C2pCP5N/EuDUjVGyKA3kp7Cft/MkXDOp+
        wKR93+eh5Vi8wMZsabUag5UGIhfZ7Xgvcn+2Z2up5A==
X-Google-Smtp-Source: AGHT+IFo/3QgV0KZOi/gmvirPkbINOiDhalcXKuhYUP+qSnmfjX/7XWUmuor40d93j1eqXJDHRoLEpe+HKTeMqXFZ7E=
X-Received: by 2002:a05:690c:dcd:b0:59f:69ab:22f2 with SMTP id
 db13-20020a05690c0dcd00b0059f69ab22f2mr13575017ywb.40.1698144727007; Tue, 24
 Oct 2023 03:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231014133823.14088-1-otto.pflueger@abscue.de>
In-Reply-To: <20231014133823.14088-1-otto.pflueger@abscue.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 12:51:31 +0200
Message-ID: <CAPDyKFpuQmyG9_Hr2XeMx2axYmNMKfr8WsXtvvq-GJPDTQ0vaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] pmdomain: qcom: rpmpd: Add MSM8917 and similar SoCs
To:     =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 14 Oct 2023 at 15:38, Otto Pfl=C3=BCger <otto.pflueger@abscue.de> w=
rote:
>
> Add RPM power domain definitions for the Qualcomm MSM8917, MSM8937 and
> QM215 SoCs. These SoCs all have the same power domains (VDDCX and VDDMX
> in voltage level mode), but different regulators are needed for QM215
> because it is used with a PM8916 PMIC instead of a PM8937 PMIC.
>
> ---
> Changes in v4:
> - Rebase on latest next as of 2023-10-14 with new SM7150 compatible
> - Add missing Reviewed-by (if there were no changes to rebase on, I
>   would have simply resent the patch)
> Changes in v3:
> - Sort compatibles in device tree binding documentation (suggested by
>   Krzysztof)
> - Rebase on latest next with genpd subsystem renamed to pmdomain
> Changes in v2:
> - Fix typo in patch description: VDDMD -> VDDMX
> - Split MSM8917 and QM215 changes (suggested by Konrad)
> - Remove redundant qcom,msm8937-rpmpd entry from rpmpd_match_table
>   and use a fallback compatible instead (suggested by Konrad)
>
> Otto Pfl=C3=BCger (3):
>   dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
>   pmdomain: qcom: rpmpd: Add MSM8917 power domains
>   pmdomain: qcom: rpmpd: Add QM215 power domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml | 81 +++++++++--------
>  drivers/pmdomain/qcom/rpmpd.c                 | 91 +++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
>  3 files changed, 156 insertions(+), 37 deletions(-)
>
>

Applied for next, thanks!

Kind regards
Uffe
