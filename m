Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA079066F
	for <lists+linux-pm@lfdr.de>; Sat,  2 Sep 2023 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbjIBIrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Sep 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjIBIrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2023 04:47:45 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B72761702;
        Sat,  2 Sep 2023 01:47:40 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Bxyeqr9vJkw_4dAA--.51842S3;
        Sat, 02 Sep 2023 16:47:39 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6n9vJkZY1pAA--.58262S2;
        Sat, 02 Sep 2023 16:47:36 +0800 (CST)
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
Subject: [PATCH v3 0/5] soc: loongson: Fix some issues about loongson2_pm
Date:   Sat,  2 Sep 2023 16:47:26 +0800
Message-Id: <cover.1693623752.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM6n9vJkZY1pAA--.58262S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1DXrW8XF1xJry3Kr17Jwc_yoW8CFW7pr
        9xC3s8GF45Xry7ZrsxJFy8WF4Fq3yrAasrJF4ftw17uryDJw1jv3yrtF4jvrZxCryfJaya
        vrs7GrW8WF17urcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU2G-eUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
V3:
- Changes "loongson_pm2" to "loongson2_pm" in all subject lines.
  Sorry, it was a clerical error.
patch 1:
  - Add Fixes tag;
  - Update commit message.
patch 2:
  - Add Fixes and Acked-by tag.
patch 3:
  - Add Fixes tag;
patch 4:
  - Add Reviewed-by tag.

Link to V2:
https://lore.kernel.org/all/cover.1693474728.git.zhoubinbin@loongson.cn/

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
  soc: loongson: loongson2_pm: Add dependency for INPUT
  dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for ls2k-pmc
    compatible
  soc: loongson: loongson2_pm: Drop useless of_device_id compatible
  dt-bindings: soc: loongson,ls2k-pmc: Allow
    syscon-reboot/syscon-poweroff as child
  soc: loongson: loongson2_pm: Populate children syscon nodes

 .../soc/loongson/loongson,ls2k-pmc.yaml       | 43 ++++++++++++++++---
 drivers/soc/loongson/Kconfig                  |  1 +
 drivers/soc/loongson/loongson2_pm.c           |  7 ++-
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.39.3

