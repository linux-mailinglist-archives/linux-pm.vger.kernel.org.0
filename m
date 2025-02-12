Return-Path: <linux-pm+bounces-21968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301AA32838
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41507A0F51
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F720FA90;
	Wed, 12 Feb 2025 14:17:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885EB1A5AA;
	Wed, 12 Feb 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369823; cv=none; b=YfJCkz/CHmbkYYzPYjPoh8hna8Y016KaPMe0huSaWi2hopfcRiMScaB5jwP4EGiNfqJYuCNMiWL4fzgne2BfppXOWPzMYVCyuJ0HAItqHVAl6CKsGO8Q2MOacBgi66Q3iNTAaNj9zZ8lgqBG9dp1Tx4xXxyntc9syBNVJhtZuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369823; c=relaxed/simple;
	bh=E7GrwC0pOKXDDZPTfqpnhVvP9PN+YrM0iMkoJ69auwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ogkn/c8AfqqciVCgDe7HEM6kSzWgyelpBUq5ZD50gs18CCQEUtoxGtqjKHYC3ACzmnCE1wWzaFBJRN5yq6nwERiP2MmlyPbsFxTXAxyWlOTxl6E2lM4v/1xixBJf/BBnWyjE/kWGaCSOfVgUV6Q7ZcRruKdxLVAI/9o2hVE4zDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.156])
	by gateway (Coremail) with SMTP id _____8AxaeFXraxnNi1zAA--.25365S3;
	Wed, 12 Feb 2025 22:16:55 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.156])
	by front1 (Coremail) with SMTP id qMiowMAxHsdTraxnd_ANAA--.3470S2;
	Wed, 12 Feb 2025 22:16:54 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>
Subject: [PATCH] mm/slab: Initialise random_kmalloc_seed after initcalls
Date: Wed, 12 Feb 2025 22:16:48 +0800
Message-ID: <20250212141648.599661-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxHsdTraxnd_ANAA--.3470S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrykCrW5JFy5Cw1DKr43XFc_yoW8AFyUpr
	Z2gF1jqrykAr4Uur47C3y8urn5ZaykGFW7CwsIkwnrZw1UAw10gFWkXFsF9rn3XFW5JayS
	vFyvkFn0ya45ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Hibernation assumes the memory layout after resume be the same as that
before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
At least on LoongArch and ARM64 we observed failures of resuming from
hibernation (on LoongArch non-boot CPUs fail to bringup, on ARM64 some
devices are unusable).

software_resume_initcall(), the function which resume the target kernel
is a initcall function. So, move the random_kmalloc_seed initialisation
after all initcalls.

Cc: stable@vger.kernel.org
Fixes: 3c6152940584290668 ("Randomized slab caches for kmalloc()")
Reported-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 init/main.c      | 3 +++
 mm/slab_common.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2a1757826397..1362957bdbe4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1458,6 +1458,9 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 
+#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+	random_kmalloc_seed = get_random_u64();
+#endif
 	system_state = SYSTEM_FREEING_INITMEM;
 	kprobe_free_init_mem();
 	ftrace_free_init_mem();
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..23e324aee218 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -971,9 +971,6 @@ void __init create_kmalloc_caches(void)
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++)
 			new_kmalloc_cache(i, type);
 	}
-#ifdef CONFIG_RANDOM_KMALLOC_CACHES
-	random_kmalloc_seed = get_random_u64();
-#endif
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
-- 
2.47.1


