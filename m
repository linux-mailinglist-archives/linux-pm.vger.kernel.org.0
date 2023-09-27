Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD32D7B0312
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjI0LdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjI0LdN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 07:33:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83241A6
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 04:33:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d81f079fe73so12523801276.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695814391; x=1696419191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lz3IHbJCH498S7xu5c9BCiLtAi1Io9fWfKGLHW1zJKA=;
        b=DNC/dWrSznW3hGzuYETFT3JtPeCKT5RxWoJBF8/ke1cFxvO3giEX0j39HDExOJw8Mc
         KxwIYC6RhGRTX2JVz7vcCWo/b43PgTqPGGQ1SN7wkO2P43xI81FyTsnreDxPvolw508t
         od07QRLx8fuc2MGgE/D0ATuxwZph5BdzZ1EFEz7JwcTIVnEOxDmqWJV7ZGkAyu1TREyf
         26L07Jjb9a5jEikrFTYN2jkjaeMA+NNFzB4aXuBLfsVbPmuO+mMCfaM6MYk7gkghkwVb
         /C/1FHsKhzqOCtUxzKs58+NDX2wrx0PFC1ge2VnuCSu1EJx5pYeOPa5BXufnom7hAn5m
         DsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814391; x=1696419191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lz3IHbJCH498S7xu5c9BCiLtAi1Io9fWfKGLHW1zJKA=;
        b=iBUI5K5GNpBawWgaUdnwJMjinmY5Na23hGK2d9dvcsszPvDeBoVUn19xudsjyLzxUf
         MOQqZm1MImTUflufZAF3eGLmPkMDb1EDd1z0B4+PXxyhw3TCsGiCUCsWU1T11TPtYYxx
         ZdUdikt3rcz1/x/zJvklqDDbkUzPcGIPCapMs6aSaey0yZVf9RBrWNzJtDX9qucD3n7b
         uzzYV2HaSTD2zPigUlW7GpaCtCN8Hg2m/tWQYCXozsUey68qdW/3JgxRV3lz0Prse7zW
         Po6oSVVgtvOcL+FEvWtxBx4wuLUC4ezAZa2fwcAeIAyiYNarHrHplI+WstMqagPe61Kl
         kN4A==
X-Gm-Message-State: AOJu0YzAfe+zRPx9+wmAI9MDHV5OpMS998ygYXXzaFupzcujv1VeNWoY
        4Ip11jp2O1ys+xC7yuAJi9If8vbfp7US7uS+LM27aw==
X-Google-Smtp-Source: AGHT+IGDDpFT42Omf1fTyNrmvyDJs1CTZMN1gqfZJeu1hy1Eh70d84WQ0FJYRQPUwESHBabdZM4ja0Yy+T01FJm5Nkg=
X-Received: by 2002:a25:97c9:0:b0:d89:465f:f800 with SMTP id
 j9-20020a2597c9000000b00d89465ff800mr1643538ybo.32.1695814390831; Wed, 27 Sep
 2023 04:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230923114950.1697701-1-abel.vesa@linaro.org>
In-Reply-To: <20230923114950.1697701-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 13:32:34 +0200
Message-ID: <CAPDyKFrEgZhPJcYXxxZ=o_VwEi3Dav8ZLBk2vHWNuiqQp8hSZQ@mail.gmail.com>
Subject: Re: [RESEND v3 0/5] PM: domains: Add control for switching back and
 forth to HW control
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 23 Sept 2023 at 13:49, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> This is just a resend of v3:
> https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/
>
> Just added Ulf's R-b tag to the 2nd patch. No other changes.
>
> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
>
> Jagadeesh Kona (3):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
>
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
>  drivers/clk/qcom/gdsc.c                       | 32 +++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7180.c             |  2 +-
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sdm845.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8550.c             |  4 +-
>  drivers/media/platform/qcom/venus/core.c      |  4 +
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
>  include/linux/pm_domain.h                     | 17 ++++
>  12 files changed, 165 insertions(+), 37 deletions(-)
>

It looks like we need a plan for what tree to route this through. Or
if we should use more than one tree. Bjorn, Stephen, thoughts?

Kind regards
Uffe
