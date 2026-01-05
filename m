Return-Path: <linux-pm+bounces-40209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41ACF492C
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F128302FA01
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175622E406;
	Mon,  5 Jan 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K/PiSX82"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086D33AD8D;
	Mon,  5 Jan 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628809; cv=none; b=Erf95sdx2y/lYKWaOL0i2xqUhNvJBep6HL3NW+5HzkFWP9RlY7AecHJdReXatIElX+L3hdl7Ic4t5lRl+D/jOH8N20B/BEar3bdmvhcZ5betbuGH1IOA3yMiu257YCwOAlKIsYh36/fJtFEAuaCAbG9/AMsa+Zi22J/PdGBmeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628809; c=relaxed/simple;
	bh=N1hoyS8vAEYeNcKmQMNtf0b1xMeM++/15iIyYizaztg=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=mGOLmoJnBCtT5f7NvlucM+vkrJWjCillAuaTkdKNCaZeoHoBoyjO0PwE0uV2oa6ObJ1muIHvXqFiFIZF+E4nBOfmQk2lAzGadgFXj5ldzTTgmopkQhMTAtILv0VPd90Z43G0/0EPEajQ2QwXvV8aomQP9jLV2MxF8xSmOEHM6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K/PiSX82; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767628796; bh=3WeX3bT5s+OT8VIdljNj7+krconZGdqv+VIUg1emz0E=;
	h=From:Date:Subject:To:Cc;
	b=K/PiSX82MSFDXGbCLbe3GViDBf/6RDUpAaU4UFMdiwdA5eyUMOYK40AATjlVwCK3S
	 30F7nv0KBMnPE81ZCw+i92mCTRjG0JWOkT/PVoHJRR4di0LwSdXsZOKScCZ0Xl+6hr
	 TTfBGh4gu3G6Zq7rckdmDIeCef6g69n0IxX+HXBE=
Received: from junjungu-PC.localdomain ([223.167.147.103])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id EF627A59; Mon, 05 Jan 2026 23:59:54 +0800
X-QQ-mid: xmsmtpt1767628794tr0jci5fx
Message-ID: <tencent_0B346CE1589FE10E0110418896F129323709@qq.com>
X-QQ-XMAILINFO: NFIgmBUYVYTpNalnUa9mLZPXg2XFb1ZTzEyZxEoFXqyT0NrWEKUy48GSJLDgYQ
	 UYmFa1M0a7TTTuoWqNfIkyqlSSt6VUpBxPDRP6f9cHsHxLHveFwa6Oi2yCUCSPfB4HiIrQbnuS/+
	 6elU3TBe+GDUvZVJRidGsIZU0jiZZ4m5faZXytDiZF2TZCVnPm02bpM3vqmoDoKfC4AQHnMzrQAg
	 HJ0a1JlaDqsqSuAWXwiF4Vr3LMgbQvINVpZJCdE5RaxQaL0TzMYYqRMj4sIDq5UJYP1VBKLBnIV5
	 6PheMEs8pYirzDdOXFO2kLqTMkgdc/v7FXfij5Iz0RYHciKLYDXEnSARr2Hyh6LJf0I3CYii+Qjb
	 ppsV0nKWWW/3O+VLWtJh2/sdI8WU4sm1rtErEpXi/9bNQQuZm2dXXG98xFZHbUmkT9Ymai7dKb5p
	 QZISQMEH9aZIIkAa41+TeTiwRIlLVsR4fvc0MnXTI/Su67f3U1d8go1NCYJ1iZ3Ldv0qH3i3fK3s
	 I9VLBIF1FHaS4dahKHivYQmf7nUnn+z3yGg6NwA2WPTTMt5HmcN9y5/Mpc6HrT6cwM2NOuDMY0p9
	 Wg+ih54a8z0fykRDvpA7BeG5aUuutbBgqpISJTnPP83eeJvYOq0qeQANLtb/9bK5GqMSWL0WmIMk
	 ttp2qP4ZIKwYfZRbuwhpm7qlukykW6H4fmNrHGcjVYDxfmiVsPFPvzN/RQ50arMaTRWqv4J2qiDK
	 tP2ziFYvKi0ScbA92waeqRcgMj1puQOZHqOZ+MWRBzzJNEvYksR+g2IRYr/3ZsEgax892UkftgJP
	 8AVcJMRPgErMEHs9xa81WvgR5VBzQGh0+v0F9eR67rcX15/hZxr+Z7SGaWXP8BMncTEcFRz5A6pK
	 m4/Ge4AOrVielNgCnG+I3EtbRsOeG2qCYyreZKab69jBGCraEG0LKFqPMDiAzqZgWnz+TAbJlH4i
	 QB7wEe0BwYMR7K4iLBd1CoiqMEAT5DoOUlKUsFBV0JDgR8180FPEOCGh+87qCBp4Uwe0sSaih6yz
	 gbSSBzp9LmtJl0Tt5V+u8/WiQF+fYUUOTy7LiX0Uo881utbOtKxi7z6laKnki64cdw+dnR5iUuIR
	 WLSG1wAC5G+PwocXOOtsrv7jxDxGffO2n/HfIOI47G0ZtuTB/NB7QxtOP9TBEofV9uiXt4asC82T
	 eqYFI=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Felix Gu <gu_0233@qq.com>
Date: Mon, 05 Jan 2026 23:59:40 +0800
Subject: [PATCH] cpufreq: mediatek-hw: Fix resource leaks in init function
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260105-mediatek-cpufreq-hw-v1-1-69ad43d6ab1f@qq.com>
X-B4-Tracking: v=1; b=H4sIAOvfW2kC/x3MSQqAMAxA0atI1gZqoSpeRVyEmmoQp9YJpHe3u
 HyL/18I7IUDNNkLni8Jsi4JRZ6BHWkZGKVPBq10qQplcOZe6OAJ7XY6zzuON5ImR8bWujIEqdw
 8O3n+a9vF+AGvz+eCZQAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767628794; l=1651;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=N1hoyS8vAEYeNcKmQMNtf0b1xMeM++/15iIyYizaztg=;
 b=m3kmr/y/heV8l/1/sXa7s6mw6GRn0lgdc5gisKmjjSANU0xwK678ZTBHg/ZwxEQTwReOy0RGB
 ptIja3YhbHGCvBVucI4f7DEqg5Vl8gUPIXlq5ditsq+bcgz3fK3aq8a
X-Developer-Key: i=gu_0233@qq.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In mtk_cpu_resources_init(), if mtk_cpu_create_freq_table() fails, the
function returns directly without releasing the resources.

Similarly, in mtk_cpufreq_hw_cpu_init(), if the driver returns -ENODEV,
 it fails to clean up. Fix this by calling mtk_cpufreq_hw_cpu_exit()
to properly release resources.

Signed-off-by: Felix Gu <gu_0233@qq.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index ae4500ab4891..f28a3de1604f 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -278,13 +278,15 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
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
@@ -322,6 +324,8 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		if (!(sig & CPUFREQ_HW_STATUS)) {
 			pr_info("cpufreq hardware of CPU%d is not enabled\n",
 				policy->cpu);
+			/* call mtk_cpufreq_hw_cpu_exit to cleanup the resource */
+			mtk_cpufreq_hw_cpu_exit(policy);
 			return -ENODEV;
 		}
 

---
base-commit: 52ae6ea5bd7c7286dcba463b6323b640b22af833
change-id: 20260105-mediatek-cpufreq-hw-a2afa5c8275a

Best regards,
-- 
Felix Gu <gu_0233@qq.com>


