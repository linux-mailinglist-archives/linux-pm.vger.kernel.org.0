Return-Path: <linux-pm+bounces-6871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015758ADBB9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4471F22B30
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC674168B7;
	Tue, 23 Apr 2024 01:59:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A17134C6;
	Tue, 23 Apr 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837563; cv=none; b=XvVSAM2XM5CheGk3InIQwtDxR9VC/y43j0DDvqjqtkeQBbPiPGHnZiR2NoEVJ0hLxoHWoC3y+RwSy/ZFIdrhHwV3+R3pPU7v8yIWR5DHI2ohSUj6yRBYugWXrJUaRmIgbUR9VZXU1SAw7Aczv/GUpfRxlzMpohcypCW4vrGkTUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837563; c=relaxed/simple;
	bh=8DGHlsuX7VCV0LWKxXv65thzSYoHUKP22O3737krA4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMUWbZRZwwaG+75tHx388DY+4F7jXJnyDHSHhITTQP5xEFabFsEPJ7EpXSk1uCHdVQAf5pkXgXxKtHJqCjbhnjAky73fq2fTAYNMN7GQ33r4wEWNG+dqdkthHJoMnf6ykJoH0BFWPUnXmVdzmRNXmsrkuce3vm8bW3szOFsOVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Cx7+v2FSdm8x0BAA--.6573S3;
	Tue, 23 Apr 2024 09:59:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnlfxFSdmX+EBAA--.2983S2;
	Tue, 23 Apr 2024 09:59:14 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 0/4] thermal: loongson2: Add Loongson-2K0500 and Loongson-2K2000 thermal support
Date: Tue, 23 Apr 2024 09:58:59 +0800
Message-ID: <cover.1713837379.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnlfxFSdmX+EBAA--.2983S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWftFW8AryDZw45KFWUJrc_yoW8CrWkpa
	15u39xGF4DCF1UZw4fA3yrArs093yfta98XFs3Cw1rZrZ8Gw43t34rta1YvrZ7urW0gFW2
	qr95KF4UCFn8CrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==

Hi all:

This patchset introduce the Loongson-2K0500 and Loongson-2K2000
temperature sensors.

The temperature sensors of Loongson-2K series CPUs are similar, except
that the temperature reading method of the Loongson-2K2000 is
different.

Specifically, the temperature output register of the Loongson-2K2000 is
defined in the chip configuration domain. We need to define it in dts
and calculate it using different calculation methods.

Thanks.

---
V4:
patch(1/4):
  - Drop devm_thermal_add_hwmon_sysfs() return value checking, to avoid
    jeopardize the initialization of this driver if the
    devm_thermal_add_hwmon_sysfs() function fails.
patch(4/4):
  - Use the different ops to get temperature.

Thanks Daniel for your advice.

Link to V3:
https://lore.kernel.org/all/cover.1713509889.git.zhoubinbin@loongson.cn/

V3:
- Collect Acked-by and Reviewed-by tag, thanks.
patch(1/4):
  - Several code stlye adjustments, such as line breaks.
patch(3/4):
  - If-else statement goes before unevaluatedProperties.

Link to V2:
https://lore.kernel.org/all/cover.1713147645.git.zhoubinbin@loongson.cn/

V2:
patch(2/4):
 - Add Acked-by tag from Rob, thanks.
patch(3/4):
 - Add "minItems: 2" to the reg attribute of Loongson-2K2000.

Link to V1:
https://lore.kernel.org/all/cover.1712733065.git.zhoubinbin@loongson.cn/

Binbin Zhou (4):
  thermal: loongson2: Trivial code style adjustment
  dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500
    compatible
  dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible
    definition
  thermal: loongson2: Add Loongson-2K2000 support

 .../thermal/loongson,ls2k-thermal.yaml        |  24 +++-
 drivers/thermal/loongson2_thermal.c           | 117 ++++++++++++------
 2 files changed, 101 insertions(+), 40 deletions(-)

-- 
2.43.0


