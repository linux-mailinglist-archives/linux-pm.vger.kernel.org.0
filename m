Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866937DE7AA
	for <lists+linux-pm@lfdr.de>; Wed,  1 Nov 2023 22:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjKAVbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Nov 2023 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjKAVbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2023 17:31:43 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D138119
        for <linux-pm@vger.kernel.org>; Wed,  1 Nov 2023 14:31:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7d9d357faso3662787b3.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2023 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698874294; x=1699479094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zFm2dW/KL7aE52KhigwzLTLJuWwq2yuHsjbZbHtYak4=;
        b=KSdEdQak4Bl8sz1HUqgmydBOeGwBk1+ns1HokADO5rhmNgMUgzLiqD6G/cYGiuzPf9
         liyBFEOAlHFdyw7YpBDnX7aUbdivJtS3v6SB18++E/9aksJ6wP4/JfyoBq72LA/iBs/v
         rH18xOFyfdSO2hbdAKwy8TJpCTLYyw/iA/UU83FFotWkXRp9QWQw33331cmHMbeVoWhM
         jPp1ZT6k9fAu6V1d9tkq/piNkp3YGEU06Nzp4/qpJwQQ8XD2PlO2fjwy9/GBCdNi80IB
         7IQsdrAXpFbFoyzeJJA3PylydOuXivPLQkGUU/E15M2DdsTdbXNxTmEjl1PKOf0/c5km
         IYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698874294; x=1699479094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFm2dW/KL7aE52KhigwzLTLJuWwq2yuHsjbZbHtYak4=;
        b=o2jUMyv31ThO1Qm0fmbnvwv+GIMlbLRF6Cb1OyCr7SQcPZb6d9emTq+dyxyM+e3lDi
         MpAqfZlML4TVu+D2y5xj+T47LpsotFgwN1/8xhk2Vj9RR0yZ7yG+C0UCy3QYnnK1jRLG
         RIEcQASt/SP20Ppf2e+9enW3tElR/WW4wkmCB4B5CBgfvYleQ0G7y+qOh66s4qoJiv8G
         fv611VqAFJKe51eM/zqSxtUNHEvAXAKrBQfOUBLdar9Pa2AK4JgHG1afVsT4ZPCPAPp9
         Srh8Uc45lcTk2pFFuqHXuOFSCQI76zIW1QS+UN3oGOQTC0Xoh4Un21fy4jghCPb0wvDI
         G5WQ==
X-Gm-Message-State: AOJu0YypK7K29aqB+da1138qFnOUqXV8+8i5xZ8Fgo+2rZntXWMoeVxS
        4v4Qz/XZ6fhjERwkNIHd9/EvdmXLkf8mNv5u0Q5FVVi1TaPRv4Vv
X-Google-Smtp-Source: AGHT+IFjXRks88JaaQT7Z/HuY+udht98lzRJfmDKyfyXFZNBr4nnBwp2fhdl6HnOEP+WCcxCT9BIiXP6UotQB9JASd8=
X-Received: by 2002:a81:a749:0:b0:595:be7:a38 with SMTP id e70-20020a81a749000000b005950be70a38mr16577399ywh.49.1698874294594;
 Wed, 01 Nov 2023 14:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org> <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Nov 2023 23:31:23 +0200
Message-ID: <CAA8EJppM9XfUPbt_=UKiKbbrtvkmEt5J=yw_b8zWXrGa9yMRJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Nov 2023 at 11:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>
> The current HW_CTRL flag switches the video GDSC to HW control mode as
> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
> give consumer drivers more control and switch the GDSC mode as and when
> required.
>
> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.

Will existing venus driver continue to work with this patch being applied?

>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/videocc-sc7180.c | 2 +-
>  drivers/clk/qcom/videocc-sc7280.c | 2 +-
>  drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>  drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>  drivers/clk/qcom/videocc-sm8550.c | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)


-- 
With best wishes
Dmitry
