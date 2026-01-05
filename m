Return-Path: <linux-pm+bounces-40215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FECCF5026
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DF130422AA
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178B31064A;
	Mon,  5 Jan 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FvfsHsgj"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E32D0610;
	Mon,  5 Jan 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634009; cv=none; b=ucuPQkmMWvmqWY0F0RuP0PLlEz7pbyLHHp2U9KQFzX8YVp38CpRz5caRUxuqb80F+7T6C7nQuGk3uo2e6SuZnWMZjLhfEwowgUEodMcOeL6//0Q+mBuWvnNUQKoD9iQcFmPmUCsRlSY8c6uN9NusPtNp1ANgt1vujvNAKSj8u1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634009; c=relaxed/simple;
	bh=nr1nUJZ861Pt93C2gXY/TX35ljdTJDdRAv39IBJWbTk=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=soboU/SHec1Y+LLemy5g1hlggfZlATDbIKLf5yCZUTMbr0o7JTwN53jkgSOQQ+B/7o72z8K8CcW1pLybt3d8rD5x46ug55FxDVLAwrVwVT/TYK408G9uC7ta9takjNxhaGFykk2YNU9S1HuTXUyQ9nyhcIF/54AMRCkDsIbz2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FvfsHsgj; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767634000; bh=nU4oGOpJwp3Q/MANXI0zxfwIDFbVnVE/U6jKEshkPTQ=;
	h=From:Date:Subject:To:Cc;
	b=FvfsHsgjjMok7g0wdaxJ9e26TZWMkZWWImjdEuONf8pMaFX2e84HddLDK7BnoV3N+
	 oWwngTh4FHeYd3m5iHY2HCulqARfeWaTKqFlj7JM4b9kH2mL78VMIkgErVA9fXv6TC
	 rAG4OnbrouOnQkOmkr1vCvUoaccyCO14O82C1S9s=
Received: from junjungu-PC.localdomain ([223.167.147.103])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6A5AA8BC; Tue, 06 Jan 2026 01:26:37 +0800
X-QQ-mid: xmsmtpt1767633997t6s5n9yjy
Message-ID: <tencent_68F699431A877005CF0887CF888B440BF808@qq.com>
X-QQ-XMAILINFO: MILSKRzDrLPbipQjZXgCF41Di+higtsdGDhYaZyj9r6A76I/R9AdyJqn7gHMCN
	 8ekuy+uDxBxCse10UPI9nekJ2iVcFfN4/h4jGxzHmo6C5QJV7xJWOzesYbC87jcQqlP4gEjxihGg
	 A4L84Chzt+EkyrayrLmL65ELRhhZeDjM84xictkcpM7l3i7PemebMiWwf8m3JFcEVn7ZS2nS0h4p
	 GsKxyH13tZo7N9ahN1D6B3wpnvQKfPgp+1QGfay4M0pzs/CrbpuOC0z4bqAmScw44SRj0HxWYmp0
	 DQpkruEZY3eEq3Bb43yqbTwe3MNMhyOUbSJtoWmJyg3Mi2deB7wIDGDcNq6bYfAo+fRxrsRCQasv
	 TnqvuPYJ+yZoTvozzQ9IqyvpvPzf6rT5ANzjdvW3O5aCSsdBKuL/PtordknM0PDKs4booaq7JUex
	 ixNeG7B4ZP/fyNPjz3WV2o3L7TZw94SWmkZmEdn8b6+N+fEcSs3t4Wn6lf3h/0B/lahJdgLeHLYy
	 XH8U364f9lk8Cl+S+EcftGeNx/gF3X2Rjqa8L6n+7zP5XSP2q864DaSYfIc5dLzmPucgpCeocF4a
	 9gHtsd/plPH0zQhg1PGel6bzvMkrgg9ZChh6zFCj10CDt5k9Of1EkTtDrGJ2qic69LL2NBOCqCki
	 Z7O1w4XzN1Aoi2Ar2IRccug/Vu8TVt1kJWn8L7rQQWhGF+mR+eaOMPzur4NgP6oMp3bv7/QX57nK
	 2RwCm6fPbKqb583F5ZGuZynBexz8SvNe4FqjKYpufs10ib9pyRD17DDRK/RCDbw9pIQwxPF8/dHW
	 9YBi2gmIRx5DTPgVEhGKV5le+ZJ96XwH15NyViiSAZryDLLViVIGByyvvYfX5Y2OasHdY0VvhgJK
	 +2sEP0GDHNdoQPZw8lYteuopXHqQTIC0frXW8Jk3/ELcaLZADAz/kzGh4Fooxw/FxZ94NBVI2uhJ
	 0DuawoCJiyp91C+cbeBVDLwkITDyALJgdWF2xVRWRjXK0hH+OglDuFUAVtM5BssKQAESpBrWoZkw
	 vwMHRDgzKYj9IQvSXS8NdzA6e81nbwOuyLA9TMqdzzTWkmp7WXyVoOLhNQ873TR1jquXyufwgHi/
	 OiZ1Ayb6gqZ7u7fuLyvQXr4+CLqZtT1bOdK1h8dDWRkjfFbF3a1Dgo19mVF13mOtlyzUMqF4PUYs
	 OWlewVVOeN+9T5KQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Felix Gu <gu_0233@qq.com>
Date: Tue, 06 Jan 2026 01:26:29 +0800
Subject: [PATCH v2] cpufreq: mediatek-hw: Fix resource leaks in init
 function
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260106-mediatek-cpufreq-hw-v2-1-6d46b87ae1df@qq.com>
X-B4-Tracking: v=1; b=H4sIAET0W2kC/32NSw7CMAwFr1J5jVESSPmsuAfqwiQOtVB/SSmgq
 ncn9AAsZ6Q3b4bEUTjBuZgh8iRJujaD2RTgamrvjOIzg1GmVFpZbNgLjfxA1z9D5AHrF5KhQNY
 dzcES5GUfOch7rV6rzLWksYuf9WTSP/u/N2nUWJ7I73e+pJsOl2HYuq6BalmWL0QWYFGzAAAA
X-Change-ID: 20260105-mediatek-cpufreq-hw-a2afa5c8275a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767633997; l=2978;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=nr1nUJZ861Pt93C2gXY/TX35ljdTJDdRAv39IBJWbTk=;
 b=O48yMN5V+xG5FJIt6McPAIfjKwFDTCpBUZbwwXXVQijE2CcE5TBwYWlxzaS6mAav1oxBCIZJx
 Dgo5By3I4yaBeIlz4ydYQe7CivtssBFIKElkqjreHYAW9420Vh6VRf0
X-Developer-Key: i=gu_0233@qq.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In mtk_cpu_resources_init(), if mtk_cpu_create_freq_table() fails, the
function returns directly without releasing the resources.

Similarly, in mtk_cpufreq_hw_cpu_init(), if the driver returns -ENODEV,
 it fails to clean up. Fix this by calling mtk_cpufreq_hw_cpu_exit()
to properly release resources.

Signed-off-by: Felix Gu <gu_0233@qq.com>
---
Changes in v2:
- Move mtk_cpufreq_hw_cpu_exit() before mtk_cpufreq_hw_cpu_init() to fix compilation.
- Link to v1: https://lore.kernel.org/lkml/tencent_0B346CE1589FE10E0110418896F129323709@qq.com/
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index ae4500ab4891..3e74c32bb273 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -278,18 +278,32 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
 		dev_info(dev, "Domain-%d failed to create freq table\n", index);
-		return ret;
+		goto unmap_base;
 	}
 
 	policy->freq_table = data->table;
 	policy->driver_data = data;
 
 	return 0;
+unmap_base:
+	iounmap(base);
 release_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
+static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_domain *data = policy->driver_data;
+	struct resource *res = data->res;
+	void __iomem *base = data->base;
+
+	/* HW should be in paused state now */
+	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
+	iounmap(base);
+	release_mem_region(res->start, resource_size(res));
+}
+
 static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -322,6 +336,8 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		if (!(sig & CPUFREQ_HW_STATUS)) {
 			pr_info("cpufreq hardware of CPU%d is not enabled\n",
 				policy->cpu);
+			/* call mtk_cpufreq_hw_cpu_exit to cleanup the resource */
+			mtk_cpufreq_hw_cpu_exit(policy);
 			return -ENODEV;
 		}
 
@@ -331,17 +347,6 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
-{
-	struct mtk_cpufreq_domain *data = policy->driver_data;
-	struct resource *res = data->res;
-	void __iomem *base = data->base;
-
-	/* HW should be in paused state now */
-	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
-	iounmap(base);
-	release_mem_region(res->start, resource_size(res));
-}
 
 static void mtk_cpufreq_register_em(struct cpufreq_policy *policy)
 {

---
base-commit: 52ae6ea5bd7c7286dcba463b6323b640b22af833
change-id: 20260105-mediatek-cpufreq-hw-a2afa5c8275a

Best regards,
-- 
Felix Gu <gu_0233@qq.com>


