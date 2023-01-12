Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E57667A86
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 17:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjALQPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjALQPQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 11:15:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D333885;
        Thu, 12 Jan 2023 08:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1144B81EC0;
        Thu, 12 Jan 2023 16:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824B7C433D2;
        Thu, 12 Jan 2023 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673539945;
        bh=YlqcH9gGz4CSDyoQ00zTTO6WursRzo06mm8smboxaxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6hRdZcih5+bfTbtan+8VHh9AqmmbdzDPPX/qMQTpugkajrhvfchGXKxo13txXYsL
         mfjQh/zV1Y0CxfV/jCkolFrCGVgLHC3tKEFqWnB8RCLYp1J8qNaRB7YjPWMnUGZedS
         SysYRDbwUcYTAGRCwyUB3M2CqBl0nMsdGcnFWhkbCpqkXJK+//tYRUJAAnrBzm/GPI
         YQx4jJNEmx3TP9gbowocrPhwySKHKbhYEm4HSkHZ7dB4Y7/foH7WHAN6GtNlhkk2SU
         XuZOava7t8/1hfI+8V9BEJrd5Uyr7SjkMW9GUUi7SnyohB5NLjdVEzexJyQZBNo5Uy
         Ak48GW82qy1vA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, mturquette@baylibre.com,
        dmitry.baryshkov@linaro.org, quic_tdas@quicinc.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, sboyd@kernel.org
Cc:     djakov@kernel.org, elder@linaro.org, johan@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/12] clk/interconnect: qcom: finish migration of IP0 to clocks
Date:   Thu, 12 Jan 2023 10:12:19 -0600
Message-Id: <167353993748.2393683.9716872439882770100.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 9 Jan 2023 02:29:23 +0200, Dmitry Baryshkov wrote:
> Commits 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0
> interconnects") and 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0
> interconnects") removed IP0 interconnects (and ipa-virt devices support)
> in favour of the RPMH clocks. Follow this example for other platforms
> defining IP0 RPMH resource. While we are at it, remove several leftover
> from the mentioned patches.
> 
> [...]

Applied, thanks!

[11/12] arm64: dts: qcom: sm8150: drop the virtual ipa-virt device
        commit: 88efcc060edbb277bf80768de8c2f63651d74b90
[12/12] arm64: dts: qcom: sm8250: drop the virtual ipa-virt device
        commit: 6af6827fb0c412581f89d5c0c865892ddf984fab

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
