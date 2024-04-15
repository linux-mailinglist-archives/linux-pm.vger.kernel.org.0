Return-Path: <linux-pm+bounces-6377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE78A46F6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 04:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E301C21D2C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 02:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185D168C7;
	Mon, 15 Apr 2024 02:31:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FB19479;
	Mon, 15 Apr 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148315; cv=none; b=g7gqLE9aFrlyADrv5m2Qr5BpJNoikOiiQYzJS6OE4MyJuQcm8IRoRE2QDRCorWNMKYvGCZZvCgM2jCap2RoDTZ0geBtjZxw6FnTBEJN0N6M9YP4ZKyx67qMdYEqIZ/yktz3POsfg+W7XFQNhcHGFPCQgKpWS522EUulmPIiZehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148315; c=relaxed/simple;
	bh=yC9VuY3rBArlxLJwyUUE+Fyn/S3XWt8lYJYJoYEDWKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUf9jedXFDxb/m98xuYg4wj1vra3tUntG9+m6Qas6m5VaB3npQ9Wx52vkPGSmV85hD39O1HVDWEJDzN2VPR2TuGwGuP5MkAxogVZOpCrT5pkuZSjcFRsyD4zLmTzmfhSvq1Ni9Ct565V4wZXYya1TBRvlGbkncUYWogWgxozTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxXbuVkRxmeY4nAA--.8697S3;
	Mon, 15 Apr 2024 10:31:49 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRRGRkRxm+Bx7AA--.27668S2;
	Mon, 15 Apr 2024 10:31:45 +0800 (CST)
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
Subject: [PATCH v2 0/4] thermal: loongson2: Add Loongson-2K0500 and Loongson-2K2000 thermal support
Date: Mon, 15 Apr 2024 10:31:29 +0800
Message-ID: <cover.1713147645.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxRRGRkRxm+Bx7AA--.27668S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XryDtw17tF1rXFy3Zry5Awc_yoWkuFXEkF
	ySqa48Jw17GF13KFW2gr4xG3s3WFWq934rCFW8try2g34xtFyqvrWqkr9xWa1fWrs8uF15
	X3ykGr1fA34xWosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

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
V2:
patch(2/4):
 - Add Acked-by tag from Rob, Thanks.
patch(3/4):
 - Add "minItems: 2" to the reg attribute of Loongson-2K2000.

Link to V1:
https://lore.kernel.org/all/cover.1712733065.git.zhoubinbin@loongson.cn/

Binbin Zhou (4):
  thermal: loongson2: Trivial code style adjustment
  dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500
    compaible
  dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible
    definition
  thermal: loongson2: Add Loongson-2K2000 support

 .../thermal/loongson,ls2k-thermal.yaml        |  24 +++-
 drivers/thermal/loongson2_thermal.c           | 111 +++++++++++-------
 2 files changed, 93 insertions(+), 42 deletions(-)

-- 
2.43.0


