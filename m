Return-Path: <linux-pm+bounces-435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAF7FD09D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FE6282514
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297C11C91;
	Wed, 29 Nov 2023 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAAB1BC1
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 00:23:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgC5557Qgz4f3l6l
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 16:23:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A44961A08D5
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 16:23:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xHt9GZl0vn+CA--.33992S4;
	Wed, 29 Nov 2023 16:23:23 +0800 (CST)
From: yangyingliang@huaweicloud.com
To: linux-pm@vger.kernel.org
Cc: zhuyinbo@loongson.cn,
	liupeibao@loongson.cn,
	liuyun@loongson.cn,
	arnd@arndb.de,
	yangyingliang@huawei.com
Subject: [PATCH] soc: loongson2_pm: fix wrong pointer check in loongson2_power_button_init()
Date: Wed, 29 Nov 2023 16:27:20 +0800
Message-Id: <20231129082720.656172-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2xHt9GZl0vn+CA--.33992S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur1rXry8ZryfZw4UCFWUXFb_yoWfJrb_Wa
	yIvF4xuryrGF13t3s8Ww4avr9F9FyFq3Z5CF47AryfXay2vw1fXw1jvr43GF13XrWjqF9I
	qw48Wr10yr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1co7tUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

It should check 'button' after calling input_allocate_device().

Fixes: 67694c076bd7 ("soc: loongson2_pm: add power management support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/loongson/loongson2_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/loongson2_pm.c
index b8e5e1e3528a..76181330696b 100644
--- a/drivers/soc/loongson/loongson2_pm.c
+++ b/drivers/soc/loongson/loongson2_pm.c
@@ -100,7 +100,7 @@ static int loongson2_power_button_init(struct device *dev, int irq)
 	struct input_dev *button;
 
 	button = input_allocate_device();
-	if (!dev)
+	if (!button)
 		return -ENOMEM;
 
 	button->name = "Power Button";
-- 
2.25.1


