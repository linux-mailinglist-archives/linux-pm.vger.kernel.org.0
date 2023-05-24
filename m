Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23470F394
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjEXJ5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjEXJ5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 05:57:07 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABD130
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 02:57:05 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9e27684b53so692653276.0
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684922224; x=1687514224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vH2+XRfLbLSg7dX3ECLEuFafMqGcT0nmYiMVQ0VO/PQ=;
        b=iOEW2/dj0DCI7mcTXMDXrLv+AO07KE9MkpVYnkH81hXbJ6cXQRNIVP3lE3INLp8FPc
         BigpxgYT8Md1dDGHyDIUmFA4vG28TXl1inmwRqaODbWcX1vok0M/XdW4X8EwqxS/veNL
         yy3SVWB9ZkTu5r68coUC7ubnxT3zweVbl9u7wEztcCHHkySZlUKQ28+kT8q8qx4aI5ND
         kgPqvxpr/StwubC+NmjOg+usoBLi9r7GCBNPG4U8W7si/W8byF0xJi7vgvKCa8v9RsKX
         n4NP7ua7JiDxWL8Iv4uSc6eAFKfhEoWmPsk15EOzV4hWx2b1Zc1cNqL43XFGpYdRp+LH
         gMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922224; x=1687514224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH2+XRfLbLSg7dX3ECLEuFafMqGcT0nmYiMVQ0VO/PQ=;
        b=TUr35/HPTVincEFAC+uwEGOhf6NO5zY6TthjEXalA0D0lfuPlPFUHpC7+WlOCYMkgM
         yB3cUatHxJoYVjwZyikcMpuEVrnK2fatxFWA/FE6bm+hH+vzb1QFcADxp4znlg0sdPAx
         32l/O0iODhVlJ7Y+MYqRshyR/Z9D0/JYudZfp/d8cuQzBzZYgjak+5yDvZXP7kSsskKV
         fPJoE1kMFbhuaqPZuDDtOmM+hnvl0LmtDoRLFSTs281e/lunnaGAGMduZJHnufM/ZreY
         g8czwUjB16zRum6Lm2NpL8Bv6Fv1fmG29YbQPdfGETM2DE53Bo5aogf8SqxeQ7T91apd
         VTww==
X-Gm-Message-State: AC+VfDz8vWRb2mj1wRQuHFHPOEsqZ6z/4VrgLOHLyCQysKtBKAnmF387
        AY8Zap9SijVhX6T/EgeLlpSHPPrLi/CPWAZqupV6/A==
X-Google-Smtp-Source: ACHHUZ5g3w1b7BDAEbgQDZk9MGbN4UM4FbejYnoo/ZcxSc23w+cGK0C5F6MQyriujIDtYDLoCJamTLG9MfMQCDMK+lY=
X-Received: by 2002:a25:73c5:0:b0:b8c:54d:c60c with SMTP id
 o188-20020a2573c5000000b00b8c054dc60cmr16230310ybc.34.1684922224229; Wed, 24
 May 2023 02:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
In-Reply-To: <20230424110933.3908-1-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 11:56:28 +0200
Message-ID: <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
To:     andersson@kernel.org, Maulik Shah <quic_mkshah@quicinc.com>
Cc:     dianders@chromium.org, swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 Apr 2023 at 13:09, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Changes in v4:
> - Add missing s-o-b line and reviewed by in patch 1
> - Address ulf's comments for error handling in patch 2
>
> Changes in v3:
> - Add new change to provide helper function dt_idle_pd_remove_topology()
> - Address ulf's comments for error handling
> - Add reviewed by ulf for devicetree change
>
> Changes in v2:
> - Add new change to Move enabling OSI mode after power domains creation
> - Fix compatible string to domains-idle-states for cluster idle state.
> - Update cover letter with some more details on OSI and PC mode
>   comparision
>
> The dependency [2] is now merged in trustedfirmware project.
>
> Stats comparision between OSI and PC mode are captured at [3] with
> usecase
> details, where during multiple CPUs online the residency in cluster idle
> state is better with OSI and also inline with single CPU mode. In PC
> mode
> with multiple CPUs cluster idle state residency is dropping compare to
> single CPU mode.
>
> Recording of this meeting is also available at [4].
>
> This change adds power-domains for cpuidle states to use PSCI OS
> initiated mode for sc7280.
>
> This change depends on external project changes [1] & [2] which are
> under review/discussion to add PSCI os-initiated support in Arm Trusted
> Firmware.
>
> I can update here once the dependency are in and change is ready to
> merge.
>
> [1] https://review.trustedfirmware.org/q/topic:psci-osi
> [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> [3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
> [4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum
>
> Maulik Shah (3):
>   cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
>   cpuidle: psci: Move enabling OSI mode after power domains creation
>   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
>  drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
>  drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
>  drivers/cpuidle/dt_idle_genpd.h       |  7 ++
>  4 files changed, 117 insertions(+), 51 deletions(-)
>

Looks like this series has not been queued up yet. Note that patch1
and patch2 are needed for stable kernels too. Moreover, patch3 (Qcom
DTS change) is dependent on patch 1 and patch2.

Therefore I suggest Bjorn to pick this up via the Qcom SoC tree.
Bjorn, is that okay for you?

Kind regards
Uffe
