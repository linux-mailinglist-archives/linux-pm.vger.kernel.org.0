Return-Path: <linux-pm+bounces-39235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEC6CA63F2
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 07:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EF0530474C9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97423D294;
	Fri,  5 Dec 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wfFdxhQB"
X-Original-To: linux-pm@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C310398F97;
	Fri,  5 Dec 2025 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916772; cv=none; b=lWi+c0nnsdIuKCyAL6rJRwQHFW0yQesnKXi3Sq3tlHCPeAAx/nCuLXqs2SV+OI/ImeZ9E97vGdex5WSm4JNxDLXgb/JDuorJsGe8Zg+SMneObbFfzu3DHGJnY3AWqQBlFK00ibA0nP7cRXaA8nEaz0hKajEiyusMdw/KEKdZx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916772; c=relaxed/simple;
	bh=yUy1BcJmLHMHOtA7yp6N1OrwEjmA5sFJVnjeWgswAlo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Enqn+5ugPLjJht0wbo60GOxjtZqoZhAOn06txuI2l5UbENi8m7hgtNV/0FTZapm/HlnWKkApBaLivO3ZyN3KVUAVono4LhM6KPEuy7aMo+ldOQvvm3cz+1iO3C5o13b1dzN+VahoJOejXf+vyPJsnKmJESGBEvGP3QUguJJNXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wfFdxhQB; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1764916758;
	bh=sDGhZw2pqYBSJZt6Ld3KRRGaUSTB5fcV7do0o7atRso=;
	h=From:To:Cc:Subject:Date;
	b=wfFdxhQBtOgYwB8Og2HhKRb0NIDBagUHKY+9xsRUNP6zf5pY/OjyD5MmZKd3fRuBw
	 o4TkyB+JnkMz0c8bluMSqRiOymdWfvnMr2hXKJ5/8p8jt9itAvvkN/765n+kcwbv83
	 t5hShouO/alTFAYOdCwtyN2k1/ZSoiXmW1W7Q0+w=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9D113065; Fri, 05 Dec 2025 14:39:17 +0800
X-QQ-mid: xmsmtpt1764916757tpecw65lz
Message-ID: <tencent_D85C91225CB9F5A85A2141BD8C4E12E6D009@qq.com>
X-QQ-XMAILINFO: N0qCj8+K5YsT9nj3/JJo+WgnP6ClXTcIHdVDjaglMYAhRHiZfb+19Xr9h23f96
	 siPLgZ/lhi9WD5VYwUexiAea8XqlsfSK/rL1l6z+9rpQmkz7C3EQPVtnSay3rMmM5vZeka+zd1Bt
	 VfoYz4YkZXEFJTKtzOB90x2S5WxKdXEajxYYReMc2PluesyaNSJDFYYoZbkes6UH9bn4W2eAFJ/V
	 WiGapnIHJRDcggPUFsgcmJTCwPaTYgsxKxROAN+vW3NlxqIF+VsSng8gf0gLQA/vBNtCOhIx9dK9
	 dvH1+0vKopdj5DgfIp/ljV8Gyxb374jPeoEcFq2/Q1AOlU5X8UzCI2RELtmn7n9nQqJRWpPSx0Cx
	 yE1ZHAsZeYETKEG6Fln7IMYJyEzrpO0WRGgQRdB8TpjLEHBXQwNvmYrBJ/lyYpyyu8MblrvU1VFP
	 2GjCjUfX1bF96rASuo8BOGpQbYia7dFAkt1ze0yDveyW049jT0kbZ0FJxirloMZ98yUu7vVYoPMl
	 q4Si/cpSZnD0SbJFtkTeYzoSwnUD62wox3O5SwS2EQQR9l+AIFG3gEJgeDderWLdLgQ7Co5ddl1j
	 g7q0X9AWZl86we6fVgBeWUlGVU7LClnHIVL0tDqLy8uLxJM7N6UglB0D+AWhDPyLGkqM/9XMEuvx
	 t5aTn1IxISCOkSkEngBzNJGC01AEvAN9yCiMS/pUYpihRieExA5Nx+0z4JY4MzW/EpktrJGlk+In
	 splidqBW2cFoZnLEXXSxx/CRXTCaR4rtP7wy7ZbMOXpHlnqhK53mESd/uYkNeLLf3ZBgpOBgwY3G
	 bPFz/Bt/RZ94QOA8Grk0sjeJLOUXLS4vbMWFrsVLCBBm2Uxr9R8L/xdnxDbqa7Vudv+vQmmtR5GQ
	 1gCaLDU4FtSQd0Dw+Vv+wAiJzlC2WN+iT0P8Wja/DFbHpGJ4FXNCLTXXKGrTh3rL/SCSVYBW1Zz6
	 p7gFXA8QUffjdgW83JGvGvNm7FhbVUtirDqIjeC39ubhz8+ujvTQNyNge4sgzVZAIyEuo8rtp4Xq
	 kpfeosJQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: xiaopeitux@foxmail.com
To: ansuelsmth@gmail.com,
	ilia.lin@kernel.org,
	rafael@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list
Date: Fri,  5 Dec 2025 14:38:55 +0800
X-OQ-MSGID: <d68ab9328bfac6aeaca0c3b0e8f333f0bbd91208.1764916628.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

The of_device_id table is expected to be NULL-terminated. Without the
sentinel, the traversal of the array can lead to out-of-bound access,
causing undefined behavior.

This adds the missing sentinel to the qcom_cpufreq_ipq806x_match_list
array.

Fixes: 58f5d39d5ed8 ("cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 81e16b5a0245..66d3169b2331 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -263,6 +263,7 @@ static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] __maybe_unuse
 	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
 	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
 	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
+	{ /* sentinel */ },
 };
 
 static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
-- 
2.25.1


