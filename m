Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C977CEB63
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 00:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRWh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRWh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 18:37:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA9116
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 15:37:26 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7c7262d5eso92663157b3.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697668646; x=1698273446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sVJFVpPwshmtNesSZYpLdeu3AKCPAN5fOk/AE0DGUc=;
        b=uu7qKZO9fW/V52UMWo3os3UxIMUH9+AcUa+7z202HbsLfolO0r15qt5YAVIgx7pi1d
         M/T5S/U3x+TVKtJiMpa7+PoxbvcXoz8FQMtWZ8OZlFI6lEQ27REdKsUSaCHopLJ3Dpgz
         GZKPFMH6A7CxX3Tc60KDoTHawa/Jepq/tbpMhWD9eugU878M2wvbol5WP8hEdgLuxkns
         bXVUHfj94hL0hQuyeL4iApYDom/WFNUTdF9IeDhVVaofVp8mtu9idhvnySsDKapg6Y6o
         WAMMVzJxvVkkyAnazoaa3bn3rYB8VpOaJMWUXZTcTE/cvIndcNhHL0S0SBYGircUMAiX
         lvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668646; x=1698273446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sVJFVpPwshmtNesSZYpLdeu3AKCPAN5fOk/AE0DGUc=;
        b=NiErWENHTKq6o22N2nMr0mnEivIYeZTgYA8uPPa2rlTfPPacc5nsW7IAtFSLVVrx3F
         S3fM1RlnUPHoW0T4RfeNTmMzJo+XYPniHftsk2OIFB44GYV4hVUrgF8UZIARiIpfiRh6
         D4AKnffxdbFmepSgyxX/bO1/EGRXkiqx70ImMpexKZElYVxe3z0TEjpmgKwT5vA4s3hP
         iNvbbWoB0l7U8WTeARsUKW2Gga8reFCMau022aIpb1aNCUHHoGVWscg0KeRNh9i8q0Ej
         9YamFZEuOQVoTDr9v7yKEdvDNHy2TNTtzH20QZfXhcnsOTO+yy+3Xba14p2+7SD79chN
         UrUA==
X-Gm-Message-State: AOJu0YyDPdBruCO7jKyBE8c6OktWRVV0UNxhUm/vY7HbijO+b8IiQTCl
        fNZRnv7uueSk85/3KmwXdJLSrVy5EEr5bP0fJqFzNQ==
X-Google-Smtp-Source: AGHT+IGQlkbNBVD/SIMZRooMGJ4PHAVW/C3q1NKNDnZ+FMwhI+gT6LA3YI3WJjxYOKCV9tBBzi3ChIxzhBVUQseyZQo=
X-Received: by 2002:a25:c8c6:0:b0:d9a:f897:f9b4 with SMTP id
 y189-20020a25c8c6000000b00d9af897f9b4mr616222ybf.65.1697668646025; Wed, 18
 Oct 2023 15:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231014133823.14088-1-otto.pflueger@abscue.de>
In-Reply-To: <20231014133823.14088-1-otto.pflueger@abscue.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 00:36:49 +0200
Message-ID: <CAPDyKFoq-7FL=e_ACDeSamoKSmoewK=eSEzzaL1xRQwX_jf_LA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] pmdomain: qcom: rpmpd: Add MSM8917 and similar SoCs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Konrad, Bjorn - it's getting late for v6.7, but not too late yet,
hence I am pinging you about this.

Can we get an ack from some of you for this series or there is still
something to improve for Otto?

Kind regards
Uffe
