Return-Path: <linux-pm+bounces-167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162197F70A7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 10:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0511C20F8F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4857182DF;
	Fri, 24 Nov 2023 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C7E319E;
	Fri, 24 Nov 2023 01:58:23 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8BxpPC9c2Blg4o8AA--.54658S3;
	Fri, 24 Nov 2023 17:58:21 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxP925c2BlB4dLAA--.37596S4;
	Fri, 24 Nov 2023 17:58:21 +0800 (CST)
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
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 2/2] drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgment
Date: Fri, 24 Nov 2023 17:57:45 +0800
Message-Id: <343c14de98216636a47b43e8bfd47b70d0a8e068.1700817227.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1700817227.git.zhoubinbin@loongson.cn>
References: <cover.1700817227.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxP925c2BlB4dLAA--.37596S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtry7XF1rCrWUXw1xAF43Arc_yoW7Xr18pr
	y5Jr18Kr4kXr17Jw45AF15JF45JasFya1xur48Gr1UAr1UGr1UXFyUJrWUtryDAry5JF17
	Jr1Dtr45tFyDJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EPfPUUUUU==

PTR_ERR() returns -ENODEV when thermal-zones are undefined, and we need
-ENODEV as the right value for comparison.

Otherwise, tz->type is NULL when thermal-zones is undefined, resulting
in the following error:

[   12.290030] CPU 1 Unable to handle kernel paging request at virtual address fffffffffffffff1, era == 900000000355f410, ra == 90000000031579b8
[   12.302877] Oops[#1]:
[   12.305190] CPU: 1 PID: 181 Comm: systemd-udevd Not tainted 6.6.0-rc7+ #5385
[   12.312304] pc 900000000355f410 ra 90000000031579b8 tp 90000001069e8000 sp 90000001069eba10
[   12.320739] a0 0000000000000000 a1 fffffffffffffff1 a2 0000000000000014 a3 0000000000000001
[   12.329173] a4 90000001069eb990 a5 0000000000000001 a6 0000000000001001 a7 900000010003431c
[   12.337606] t0 fffffffffffffff1 t1 54567fd5da9b4fd4 t2 900000010614ec40 t3 00000000000dc901
[   12.346041] t4 0000000000000000 t5 0000000000000004 t6 900000010614ee20 t7 900000000d00b790
[   12.354472] t8 00000000000dc901 u0 54567fd5da9b4fd4 s9 900000000402ae10 s0 900000010614ec40
[   12.362916] s1 90000000039fced0 s2 ffffffffffffffed s3 ffffffffffffffed s4 9000000003acc000
[   12.362931] s5 0000000000000004 s6 fffffffffffff000 s7 0000000000000490 s8 90000001028b2ec8
[   12.362938]    ra: 90000000031579b8 thermal_add_hwmon_sysfs+0x258/0x300
[   12.386411]   ERA: 900000000355f410 strscpy+0xf0/0x160
[   12.391626]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[   12.397898]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   12.403678]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   12.409859]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[   12.415882] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[   12.415907]  BADV: fffffffffffffff1
[   12.415911]  PRID: 0014a000 (Loongson-64bit, Loongson-2K1000)
[   12.415917] Modules linked in: loongson2_thermal(+) vfat fat uio_pdrv_genirq uio fuse zram zsmalloc
[   12.415950] Process systemd-udevd (pid: 181, threadinfo=00000000358b9718, task=00000000ace72fe3)
[   12.415961] Stack : 0000000000000dc0 54567fd5da9b4fd4 900000000402ae10 9000000002df9358
[   12.415982]         ffffffffffffffed 0000000000000004 9000000107a10aa8 90000001002a3410
[   12.415999]         ffffffffffffffed ffffffffffffffed 9000000107a11268 9000000003157ab0
[   12.416016]         9000000107a10aa8 ffffff80020fc0c8 90000001002a3410 ffffffffffffffed
[   12.416032]         0000000000000024 ffffff80020cc1e8 900000000402b2a0 9000000003acc000
[   12.416048]         90000001002a3410 0000000000000000 ffffff80020f4030 90000001002a3410
[   12.416065]         0000000000000000 9000000002df6808 90000001002a3410 0000000000000000
[   12.416081]         ffffff80020f4030 0000000000000000 90000001002a3410 9000000002df2ba8
[   12.416097]         00000000000000b4 90000001002a34f4 90000001002a3410 0000000000000002
[   12.416114]         ffffff80020f4030 fffffffffffffff0 90000001002a3410 9000000002df2f30
[   12.416131]         ...
[   12.416138] Call Trace:
[   12.416142] [<900000000355f410>] strscpy+0xf0/0x160
[   12.416167] [<90000000031579b8>] thermal_add_hwmon_sysfs+0x258/0x300
[   12.416183] [<9000000003157ab0>] devm_thermal_add_hwmon_sysfs+0x50/0xe0
[   12.416200] [<ffffff80020cc1e8>] loongson2_thermal_probe+0x128/0x200 [loongson2_thermal]
[   12.416232] [<9000000002df6808>] platform_probe+0x68/0x140
[   12.416249] [<9000000002df2ba8>] really_probe+0xc8/0x3c0
[   12.416269] [<9000000002df2f30>] __driver_probe_device+0x90/0x180
[   12.416286] [<9000000002df3058>] driver_probe_device+0x38/0x160
[   12.416302] [<9000000002df33a8>] __driver_attach+0xa8/0x200
[   12.416314] [<9000000002deffec>] bus_for_each_dev+0x8c/0x120
[   12.416330] [<9000000002df198c>] bus_add_driver+0x10c/0x2a0
[   12.416346] [<9000000002df46b4>] driver_register+0x74/0x160
[   12.416358] [<90000000022201a4>] do_one_initcall+0x84/0x220
[   12.416372] [<90000000022f3ab8>] do_init_module+0x58/0x2c0
[   12.416386] [<90000000022f6538>] init_module_from_file+0x98/0x100
[   12.416399] [<90000000022f67f0>] sys_finit_module+0x230/0x3c0
[   12.416412] [<900000000358f7c8>] do_syscall+0x88/0xc0
[   12.416431] [<900000000222137c>] handle_syscall+0xbc/0x158

Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 133098dc0854..99ca0c7bc41c 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -127,7 +127,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		if (!IS_ERR(tzd))
 			break;
 
-		if (PTR_ERR(tzd) != ENODEV)
+		if (PTR_ERR(tzd) != -ENODEV)
 			continue;
 
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
-- 
2.39.3


