Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A775312B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 07:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjGNFan (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 01:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjGNFam (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 01:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76319B4;
        Thu, 13 Jul 2023 22:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FDB161C12;
        Fri, 14 Jul 2023 05:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBBC433C7;
        Fri, 14 Jul 2023 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312640;
        bh=wH70BvdhLEtr/N+gonp/uuTZjF4Md0BD9RWyGOD2yI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIF/uJwhkn9WjRAtBOOvk289sd4pQ8joRiMXwwWTxVIvYs4eKb+QzsKWDIdV+pEsD
         h7SqT+Zz7PoFVYGVpTWqBsElMIDklCj7qwpBmKFWiWC+M6XRmyxHysp/MoeNS0wzdC
         jCkrt2CwHOTkJkTnowgsyhccxA8zpxiGkRlG4OPHgkq8gv4ggJ0vs1cHjArLgsl33T
         evtDeJ+3uA81sSVkDCSIk4YPaz4tek7oO7jHXj6d1EBa3n1yZ+N7ES/kGF+SyGek7f
         k09Ykv9W3Hl77bIda3mn2/7hVhODyrB9y+p0S0Q+j58Eo4ozywblO3syKQWGwLKDA9
         18nenzYD1puig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/4] ARM: dts: qcom: apq8074-dragonboard: enable resin device
Date:   Thu, 13 Jul 2023 22:33:56 -0700
Message-ID: <168931284125.1538684.17945028830332180125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
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


On Fri, 09 Jun 2023 05:25:49 +0300, Dmitry Baryshkov wrote:
> Add support for reset / volume-down button found on the APQ8074
> dragonboard device.
> 
> For PM8941 we don't have a defined field to store the reset reason.
> Support wrapping pwrkey and resin, but without writing the reset
> reason.
> 
> [...]

Applied, thanks!

[3/4] ARM: dts: qcom-pm8941: add resin support
      commit: de57328b1c9da0f30ccca4925ed6d5615b1a72b3
[4/4] ARM: dts: qcom: apq8074-dragonboard: add resin
      commit: a9037f330e9d6faeba6f5663ca05f525aa1954f4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
