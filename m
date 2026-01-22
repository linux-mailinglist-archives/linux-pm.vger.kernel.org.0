Return-Path: <linux-pm+bounces-41257-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Oy6ESqBcWk1IAAAu9opvQ
	(envelope-from <linux-pm+bounces-41257-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:45:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7960789
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E488B4E8519
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11326354AF5;
	Thu, 22 Jan 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Okzn4zgj"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150830DEA6;
	Thu, 22 Jan 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046305; cv=none; b=euMetiBZG748PlrDobTv3dJ6OX9+zvS9Pg6oJUyxg/vR1VxDkw4k+m1DoB2S8D+Kjzztxpmz7pceEfmjEkXoKxyFlcIF4zkAdTp8n+BMIg9ObB+EPSqIXU9rHB0mb9N+MHuVejHq6qzHL60lM3640qd72mljkLCZSvmkBMMf9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046305; c=relaxed/simple;
	bh=V5mpuxlhUnQEIOHCzuPRjfwOQhWODGZ8fIfboxbMyBg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IlmGByeDR+z8te03BUZIOnmJBZsN4Wt18zcbl+pdyu7HNSaW3iuwjylYyQwAfVSPa0QCTUMkuwF2wfhriwYYxiPuzb2Cb89WcMMTS0vh3+7OmGqHD94dWTJ/zleSZtE1nUDM5E/dxIUd2Si5NE+LWFKNiN2jfXtRZB7/ieyfE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Okzn4zgj; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769046291;
	bh=G6VeG6ZKhL8Ug2rmbwe0ebZRk2xvylPk0ABrTmUlBnI=;
	h=From:To:Cc:Subject:Date;
	b=Okzn4zgjzuekAQIzvCwVGm0jp2WOmylrpReN3fwrm2eocHj2sH29A4yK/5yuGmoMy
	 iY9xPhLEmlZnGiKI5nZvRrDShfU0+Zi2ZH85rHrYE3pCnAzvFjocBUvRuGauzR47AZ
	 qpojCuww/CXaD1KgTm1Zh3PmwZziG7L6l6p4X1pE=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B3198802; Thu, 22 Jan 2026 09:44:49 +0800
X-QQ-mid: xmsmtpt1769046289t6ik33xpc
Message-ID: <tencent_E072C90BFC84600EC8B529829AFB81CA0105@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgshDxJe9Ol2zW35bp7tqtXo2ooS+E77RqsYC7vskUbg+woKs8Dh
	 OcwK/deeLB0i5q058oWeD52Qa1QmlnzYZnT9tRIB4cRL9fjGEw1XoH0peI5c2CYiF191pg/QIORv
	 FFdvmCy7IWr6g08qc988/vsdLYCI+cL8a+lHLjO6rajWpTh8EEQK4mIvjeSbFLFcLT3fkwWqYBId
	 RYnWSOdGU3eLaeirDBta0Bx0RRV25L1vKlp1Q7+ZgNp51UftfMp3J4itnayGZBX/CL+7wSaEJv+G
	 Bwwzc7iFBomkX4lnR/svPl0JNT1amW7M80rQEI3jtprlTTJ3HXakfUGkrb7fn4vTvEUTlWRQ7gL2
	 Ore7q7heCTd8GBpqDuIKo7qXGZb+aw5meRVSNag3jj4BhPC+gVAxTN38oV00+xrojTQJx8CQ5mfj
	 OQZ4lv/9NpitObm7DEKdPOY9mS3hCJWzcPenLwEym0fbTFxUILFFegMNSQMdK/A74e72bYtILggW
	 C5y+84sVtIAhomEsxp0l4j60d8nufXLujPsTJdmG8u4CNjG6IfPL5kWm2qF73AhIijxm/Llwh0LI
	 /0Z1K7GGUVe12nX3Gs1avTRFERvwmSTZKPw2JGoSoNEp/NDnDVu3l1hhlVUXvfs9bQAaDT9thQpI
	 V9YIoSdzfzBc9IbD4VoX4EGpkiJUNLYGGpjtvh4P2UwKjVYS/FWSUl2rtIQkLjaORP5Oj5QKlGLP
	 OemOzhkrhZHG5blXXMr1qNF+IHgmRPmLfpzSGfCNvcFysGG5QFj/dzfgQB/Lw3nQnyAXsxDXAx0E
	 w+apG97aKswB+j2t/0AQxnIb/xRvzSexEGqKM8P1NR3/hTJyyMqGfTEEdGXaUuwyJC82ljxCtQhJ
	 rwfMz4CtCkdk7obbHIa2JdXXTp19pGdUWnsfKApARIEY+VBvGHukef5uw9yIadOLllKJapCpn3l9
	 tpmLJ2dzGF4lxb3qGLHBeJOxuwOnXvG9Mu30xOzeXF5pIo108B4ciYDdnV54WT
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: xiaopeitux@foxmail.com
To: konrad.dybcio@oss.qualcomm.com,
	ilia.lin@kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2] cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list
Date: Thu, 22 Jan 2026 09:44:48 +0800
X-OQ-MSGID: <403587b741460b6b23bf1771a52a6fe404279446.1769046044.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41257-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[foxmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[foxmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[xiaopeitux@foxmail.com,linux-pm@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,foxmail.com:dkim,qq.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: EAC7960789
X-Rspamd-Action: no action

From: Pei Xiao <xiaopei01@kylinos.cn>

The of_device_id table is expected to be NULL-terminated. Without the
sentinel, the traversal of the array can lead to out-of-bound access,
causing undefined behavior.

This adds the missing sentinel to the qcom_cpufreq_ipq806x_match_list
array.

Fixes: 58f5d39d5ed8 ("cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changlog in v2:
Remove the extra commas
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 81e16b5a0245..b8081acba928 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -263,6 +263,7 @@ static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] __maybe_unuse
 	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
 	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
 	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
+	{ /* sentinel */ }
 };
 
 static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
-- 
2.25.1


