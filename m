Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633E78EC57
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjHaLnZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHaLnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 07:43:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67324C5;
        Thu, 31 Aug 2023 04:43:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8BxNujWfPBkGG8dAA--.6830S3;
        Thu, 31 Aug 2023 19:43:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniPTfPBkVxJoAA--.14619S2;
        Thu, 31 Aug 2023 19:43:16 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 0/5] soc: loongson: Fix some issues about loongson_pm2
Date:   Thu, 31 Aug 2023 19:43:10 +0800
Message-Id: <cover.1693474728.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniPTfPBkVxJoAA--.14619S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1DXrWDZFWxWF4rCF15GFX_yoW8Xw4UpF
        9xC3s8Gr45Zry7ArnxJFW8GFWrXrZ5AF9rJF4xJw17CryDXw1jvrWrtFWjvrZxAFyfXwsI
        vr1xGrW8WFnrurcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
        Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
        vjDU0xZFpf9x07j5xhLUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all:

Since commit 67694c076bd7 ("soc: loongson2_pm: add power management support"),
the Loongson-2K PM driver was added, some issues have been found and
this patchset is planned to fix these issues.

Specific:
Patch 1: Compilation error found by Randy;
Patch 2/3: Rewriting the ls2k-pmc compatible attribute with fallback
compatible;
Patch 4/5: Add Loongson-2K SoC reboot/shutdown support as part of power
management.

Thanks.

-----
V2:
patch 1:
 - Change "depends on INPUT" to "depends on INPUT=y", because the
   compilation error still exists when "INPUT=m".
patch 2:
  - Use ls2k0500 as the fallback compatible;
  - Add ls2k2000 compatible.
patch 3:
 - Drop ls2k1000 compatible, for ls2k0500 is used as the fallback
   compatible.
patch 4:
  - Drop label;
  - Drop regmap property in syscon-reboot, for it's deprecated;
  - Add missing space.

Link to V1:
https://lore.kernel.org/all/cover.1693218539.git.zhoubinbin@loongson.cn/

Binbin Zhou (5):
  soc: loongson: loongson_pm2: Add dependency for INPUT
  dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for ls2k-pmc
    compatible
  soc: loongson: loongson_pm2: Drop useless of_device_id compatible
  dt-bindings: soc: loongson,ls2k-pmc: Allow
    syscon-reboot/syscon-poweroff as child
  soc: loongson: loongson_pm2: Populate children syscon nodes

 .../soc/loongson/loongson,ls2k-pmc.yaml       | 43 ++++++++++++++++---
 drivers/soc/loongson/Kconfig                  |  1 +
 drivers/soc/loongson/loongson2_pm.c           |  7 ++-
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.39.3

