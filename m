Return-Path: <linux-pm+bounces-39496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66056CBC4A9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 04:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E43B53005BAA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 03:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EC27EFE9;
	Mon, 15 Dec 2025 03:07:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04D3FFD;
	Mon, 15 Dec 2025 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765768027; cv=none; b=QeWGO0K4a5eKrhPsqwomn//UinAvW9U6xiR4sdZfID6lioZ33CbUketSDLhBksAQMYPQLT07TUh6Knmj/lkxSMI7HSPL3Yv8RcoR7v+QNZfwokth03lxnGec1kUWewSF3F7t5qmLSQaBl0lITqoTxImEdpzRgh0xzEL+XSB7txI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765768027; c=relaxed/simple;
	bh=LErrcRNnpssQ0GpNWM4WP5MO2P1nIf8hlgEKdjFQgr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2Eupgy/JwvdaH2olP9VksnnHb0x9q4UM7bXcyaUedFn50bl6NbH2dlKNtEFGkqxKJtvC5rHz2LaVOnhOspooua9rKC1YRmmHN/HQzYXOA0hZ2lossmt+faauqjQt7Ekib5YMNi2PmIT4x3DQZ5SvXXU1hYthWXOngV23jTSbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACnyN9Rez9pY3TCAA--.57841S2;
	Mon, 15 Dec 2025 11:06:58 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Kevin Hilman <khilman@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-omap@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Date: Mon, 15 Dec 2025 11:03:27 +0800
Message-ID: <20251215030327.1771-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnyN9Rez9pY3TCAA--.57841S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45XF1xAr18tF4rury7GFg_yoW8Gry8pF
	Z8Xr42kry8JFyvyw4DuF4I93WFvw1vyws29348Gwsavw1DJa4fX3Z8C345ZFWrG3ykJr4j
	vry7Za4xAFWDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUejjgDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsRA2k-bwQynQAAsN

The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
regulator but does not release it in omap_cpufreq_remove() or when
cpufreq_register_driver() fails, leading to a potential resource leak.

Use devm_regulator_get() instead of regulator_get() so that the regulator
resource is automatically released.

Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/omap-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index bbb01d93b54b..f83f85996b36 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -157,7 +157,7 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mpu_reg = regulator_get(mpu_dev, "vcc");
+	mpu_reg = devm_regulator_get(mpu_dev, "vcc");
 	if (IS_ERR(mpu_reg)) {
 		pr_warn("%s: unable to get MPU regulator\n", __func__);
 		mpu_reg = NULL;
@@ -169,7 +169,6 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
 		if (regulator_get_voltage(mpu_reg) < 0) {
 			pr_warn("%s: physical regulator not present for MPU\n",
 				__func__);
-			regulator_put(mpu_reg);
 			mpu_reg = NULL;
 		}
 	}
-- 
2.50.1.windows.1


