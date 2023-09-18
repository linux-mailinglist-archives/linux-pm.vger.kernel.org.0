Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40C7A461B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjIRJin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbjIRJi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 05:38:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F435115
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 02:38:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bfbd7d49e7so67879781fa.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695029898; x=1695634698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qMynowtM6sO6WhIunL19I1lsaUMnQPIdw7sq9xV6Eg=;
        b=Y0bwdr9UoMsxsIrPEDQuyq+Ahl+ss46DHE+tY488mJJGXfRjJ8FwZ0CcRppW2Bw3MH
         L4kuZa8vUvcqZXAhdq/b8xpUWsDxRh6tmvJdYOVqpm4Uzayo3DKFpcAUNVVjLnSG8+7V
         8D7IIpu0Gkt4p6H9Z8NEj6sLiPtxZcVm6fs0WAwXtBjrRDyuLdbteJ8VnDNAr0xxrw+T
         dXC4HPKV3vZ6BBVgnq4iazhJ0QA+MGRo50z5b1dc0OVicRHDCEVcp5Dr7ihsHQsxeS3b
         S7Apr1Z+4bSbYqoldosPlX/u62zxBRzEO3DenLSNPljZdcpJuXdrmWPGSG0rEgQieLIR
         mbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029898; x=1695634698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qMynowtM6sO6WhIunL19I1lsaUMnQPIdw7sq9xV6Eg=;
        b=S/KHPgUQ9Ui+koAuZ126xO436TTuUonThl6NjbjhRpDDzZDKbcFX6tfCmIbN4rq+mu
         FVpnzxgNCFVEC6TGryZaO3/9egP0q895YRR2jjRDBtl1gG7MDFIwRFypKONo7X4OLWxs
         eoulDUxlpPKcsffG1Y3XqA6GfRjHEU8jlMToAh0UlrjqffUOdkVwZCj3xc9/GLe5IGau
         JfVgXFvO3yCPX7kX4H1aOW4r9HcEap/Rb98z/jY5vASg+vQzm5/M5z7M7G0PW2eIBGxZ
         dHecF7zBwJ26vfSQe0Ui7ofLRESah2YpRHMC77Q6vI6Qkdsf+SfVJeLHGK+pBoq2Xj7j
         52jg==
X-Gm-Message-State: AOJu0Yxuib1DyMj5ogAOY8dpnbwM2fRAO1bGySRRkTYY7fhlLThrrAZ0
        HK/QItoGt8xSaH+s+zM4jrRevg==
X-Google-Smtp-Source: AGHT+IGp45ZVIMqUnpyNlGTjOczPJW9+COazaydZ4vg+A0aUFwj9VUvBstOriVWXiS7GXoKBhC6xIQ==
X-Received: by 2002:a2e:a41c:0:b0:2bf:7dc5:884d with SMTP id p28-20020a2ea41c000000b002bf7dc5884dmr6984504ljn.21.1695029897811;
        Mon, 18 Sep 2023 02:38:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0099293cdbc98sm6251164ejh.145.2023.09.18.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:38:17 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 0/8] soc: mediatek: MT8365 power support
Date:   Mon, 18 Sep 2023 11:37:44 +0200
Message-Id: <20230918093751.1188668-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

no real changes in this update. Rebase to v6.6-rc2 and according change
of directory.

Thanks for any feedback!

Best,
Markus

Based on v6.6-rc2

Changes in v8:
- Rebased to v6.6-rc2
- Moved changes from drivers/soc to drivers/pmdomain

Changes in v7:
- Rebased to v6.5-rc1
- Fixed a couple of small style issues pointed out by Angelo

Changes in v6:
- Change flags field to be u8 instead of u32
- Use macro concatenation to simplify BUS_PROT macros:
  BUS_PROT_WR(_hwip, ...) etc.
- Use the final bit values for scpsys_bus_prot_flags from the beginning
  of the series.
- Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
  MTK_SCPD_STRICT_BUS_PROTECTION.

Changes in v5:
- Create defines for all registers and bits in mt8365 power domain patch
- Redesign scpsys_bus_prot_data to use flags to store reg_update,
  clr_ack as well as the difference between SMI and INFRACFG. The code
  uses the appropriate regmap depending on the flags.
- The WAY_EN patch now uses two flags, one for inverted operations
  'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
  'BUS_PROT_STA_COMPONENT_INFRA_NAO'.

Changes in v4:
- Redesigned WAY_EN patch and split it up in smaller patches.
- Added two documentation patches.
- Added mediatek,infracfg-nao field to the binding.

Changes in v3:
- Mainly redesigned WAY_EN patch to be easier to understand
- Rebased onto v6.0-rc1
- Several other stuff that is described in the individual patches

Changes in v2:
- Updated error handling path for scpsys_power_on()
- Minor updates described in each patch

Previous versions:
v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/
v5 - https://lore.kernel.org/linux-arm-kernel/20230619085344.2885311-1-msp@baylibre.com/
v6 - https://lore.kernel.org/linux-arm-kernel/20230627131040.3418538-1-msp@baylibre.com/
v7 - https://lore.kernel.org/linux-arm-kernel/20230713150414.891893-1-msp@baylibre.com

Alexandre Bailon (2):
  soc: mediatek: Add support for WAY_EN operations
  soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

Markus Schneider-Pargmann (4):
  soc: mediatek: pm-domains: Move bools to a flags field
  soc: mediatek: pm-domains: Split bus_prot_mask
  soc: mediatek: pm-domains: Create bus protection operation functions
  soc: mediatek: pm-domains: Unify configuration for infracfg and smi

 .../power/mediatek,power-controller.yaml      |   6 +
 drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
 drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
 drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
 drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
 drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
 drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
 drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 157 ++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  51 ++--
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
 include/linux/soc/mediatek/infracfg.h         |  41 +++
 14 files changed, 972 insertions(+), 446 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.40.1

