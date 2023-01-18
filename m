Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0F672D0F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjARXzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 18:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjARXzu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 18:55:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041AF38E82;
        Wed, 18 Jan 2023 15:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3771B81F6C;
        Wed, 18 Jan 2023 23:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E4CC433D2;
        Wed, 18 Jan 2023 23:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086147;
        bh=JOfiQ7WBUH0UFt84AR47vK+y4/azbTBmeNX+dMk6w9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XacF67VNiogUeO8qeckA1qLVItPgQKCKnaASN1lbLZ+VWmq4OWScmNrJVUv3blt2i
         50fJId/7C2qJ0mC4v9r01GVh95xIjYFk+dtB0D/h0n+GfVMWix9Kz/ZQalAoLJvzvE
         V+bIH38by4uEuZ3/DSA2ILv33P5N1vEf6LdvBsssQ342tcIjYeXNmrviZ6Rfi5Tt+8
         KLKpy889KKmYS8o2jtNKJPrZVzs74byQ7Vh2mizRBFAHEyZxqZLridqld+kcP2XZD4
         38NZHzHnVgYk8edW28S5BWYE8l9GEIp1SdTMvPzTngMWRjZsgFoyBbPx+r97xJgUt2
         gYMOZ38UDoeOg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     rui.zhang@intel.com, Rob Herring <robh+dt@kernel.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        dmitry.baryshkov@linaro.org, thara.gopinath@gmail.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, amitk@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bryan.odonoghue@linaro.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        shawn.guo@linaro.org
Subject: Re: (subset) [PATCH v6 00/20] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Wed, 18 Jan 2023 17:55:32 -0600
Message-Id: <167408614058.2989059.12964039840302172563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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

On Sun, 1 Jan 2023 21:40:14 +0200, Dmitry Baryshkov wrote:
> Historically the tsens driver fetches the calibration data as a blob and
> then parses the blob on its own. This results in semi-duplicated code
> spreading over the platform-specific functions.
> 
> This patch series changes tsens calibration code to per-value nvmem
> cells rather than parsing the blob in the driver. For backwards
> compatibility the old code is left in place for msm8916, msm8974 and
> qcs404, the platforms which have in-tree DT files. For all other
> affected platforms the old parsing code has been dropped as a part of
> this series.
> 
> [...]

Applied, thanks!

[19/20] ARM: dts: qcom-msm8974: specify per-sensor calibration cells
        commit: e108a3858e7dc7192f34b0b9fe2afc90d452407b
[20/20] ARM: dts: qcom-apq8084: specify per-sensor calibration cells
        commit: 1283b2e61a7a2064e71f50f3f0821d6e56ced920

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
