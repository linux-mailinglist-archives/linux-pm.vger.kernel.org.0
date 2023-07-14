Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DB753134
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 07:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjGNFav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 01:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjGNFao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 01:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4182708;
        Thu, 13 Jul 2023 22:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C8AE61C11;
        Fri, 14 Jul 2023 05:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7290C433C9;
        Fri, 14 Jul 2023 05:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312641;
        bh=e2x1Y3C+TGIy2o4/+xRmRchPGszNhJV6EAVBco/PM+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgGy2nMDoqc3N7IfzCS6u65LUvlhqgu1fRyamEQWnRHpVfUyu+Y5pY9PCyDAG/6cM
         0Vp9uUIr6zf/kPBOXOdh63lroJb4pWNpivCzFjKR7T0/Ro7fcv5NG/aH6AqntZlBHF
         dz2wSJW+KMg08SFa+PfbStHDR3hsTO4hAUH5n77DVvIjDo/Lvkh46PthwkHp6/jEL5
         XHdpPRqqODdIu2M6VJq65WxrdTTBfLVcxHUfwB/ZMyMs1jeS9mxxWDUqX7xYQirS2Y
         LIwevr2nAiTutWoKgjVqSMZkwyKmE4g9THDkf0F7z9IqV9jLj0Tsn1SYRNGBT17GT8
         C9Dt4Z6AkUAIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/4] clk: qcom: msm8996: add support for the CBF clock
Date:   Thu, 13 Jul 2023 22:33:57 -0700
Message-ID: <168931284119.1538684.11732456705108123765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 12 May 2023 03:13:30 +0300, Dmitry Baryshkov wrote:
> On MSM8996 two CPU clusters are interconnected using the Core Bus
> Fabric (CBF). In order for the CPU clusters to function properly, it
> should be clocked following the core's frequencies to provide adequate
> bandwidth.
> 
> Register CBF as a clock (required for CPU to boot) and add a tiny
> interconnect layer on top of it to let cpufreq/opp scale the CBF clock.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
      commit: 8bb8688c1d73f21f413e4ea2a37fbbb90997f2bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
