Return-Path: <linux-pm+bounces-41368-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPBwELdhc2kCvQAAu9opvQ
	(envelope-from <linux-pm+bounces-41368-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:55:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6969756DD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 959C2301683A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B32DE6FB;
	Fri, 23 Jan 2026 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cACHRyNY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3024169D
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169332; cv=none; b=e0rF4lU4ZI6lhlegbhHrYnR95c5Sv399cpVheDZIMlkIxjrz2FAednrJtlU6fWXRgJCQDoW/mnNPG4l7/33Ze3SiwDnQfEx+v6eaFGj/NwY2NFJGd7ggYB1RaNQlTQq3vP780ZhRszJcuquDxjM1aPabsQlQP8A7BjRyioN0izw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169332; c=relaxed/simple;
	bh=XTcqj191QDUYaA+6GiS0z3Gz/w3k5q3FR/PCUyPd+ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eqwj4giDg5WjzWIXSYNdcORS+oX8TKAt1sCfmi9DuXS1HlL8WV3yOzJvoKfsrsxEJjCPL2KfKUjVa8lvGP7DNLCwIV08RxMYVTsLOvP/7zLZDKnzPAL4vX+qP1PzjhwbKK5GQr+HPlkKZESm0luW30kULgRMz/+33qA71qSDOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cACHRyNY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a09d981507so14351365ad.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169330; x=1769774130; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iASSXGw3nYa+sTt6tk01/U6NYGoPbh9N7lOgJfhKC0w=;
        b=cACHRyNY25KhE7iPOasOc6PzdDZixdwktfUq+YvgaNY2W/fODeMLYCxR9aFpqe5TP/
         exji08BETU3LlMILjIVg2+c9gGK94Isj/AZtKFF9LeEY8ICB4ZD5gmPX1TPNzFjy2Ax4
         cMgpOMxJ9toMlTkoF5Z6lZuTefnfC+19sjAsObZ+CEOG5Tli/9HQa5YnnHL34yNrqtqa
         WPrmdvmOEfMH7QnQ/QmKsnDqVgJX6yAe2kAyAfPvtz7cCvaryLByoAqFuBMnLsyqwtVX
         qJ3EVE0h9M/GRtpCysgr5uFxvwW9yutWX8mxJdab4CnlRj9esuurZ4ctC2fthslNUJwL
         HKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169330; x=1769774130;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iASSXGw3nYa+sTt6tk01/U6NYGoPbh9N7lOgJfhKC0w=;
        b=kOASTQRdAgJJR+U5anUjxhvTfY+Z+nY0E/U3KQyu2nNdxxZFaSBMQQwJYKXZIWM/Kt
         we8jW1LggwfKhtld7hpsVmewOlHTTGiTCwzUTT6L8fZDknvrLLyPG7CpukBU3wNdfjs2
         AUpr50nSdZwt9USQYF271o+CglVoaCmZgxtvDjnWiLqPY8/Tb6Gf4QxOoeQl3aqlxcul
         8UA5WKpY7vaQXstjJEOivCxIJWxN4x4tC9x+sY12Xm7rGT1tX25k80PnXRpSCnn/nIdp
         9knWaatOzUj0F0uqU23elHMO49dajMEEQ5g5HNvfeTl8q6XX3+Gi8UN6F7c6mKPrHkaA
         j8EQ==
X-Gm-Message-State: AOJu0YwU175IcF06MASiayzL+j6HaknEbwojXKj2jyn7cN225Z6+xQWs
	II0Dv0m/2G8KngeUxspFrJUCuYJCYF9TgP0MxWm0jVE4ii7Zj3eb4m64QOFTRA==
X-Gm-Gg: AZuq6aJhMcsNnnkm89uvT+V4Xc5jVt47pz4HktfStcBDg5Zs+zTXhIKjufJ1qQCW/lT
	b8rPVAWd03vFbsPmW6rHbypATiKSq3g6UTbgI9n4LvhwGpmf4XxZ7RCjbRAbrrddYEuoIOdLupm
	nVraU3g9BdhzN5pI2MOb0ir9/MvDpCAKhIBrghB0CTyj4+LqZSqsbHK1c7rnBfOVaeUDgBzMvUr
	MfFzhPzji1GURXhty5wAyWP546XrZpev0MIjS7dnv1swStgySXDW1SteZ4Kjm4LNVcSyp0v6Usz
	yY+00Q9tiYHgZQ1k5e7A+yv+TFbNvfbVSqYsYNvQw9tSgMSCR5VXzTI0LXbdqJIAvwfd5SpnbWd
	nL25hbRS1faJYtet/yjgRF6hwQK1qyoEJp+kkevVzrHJSO8pHDhqPp8cMoR4LT1SJUuNGRkVHLg
	sQ2Jw0MbPhgeZ1KtjkVky18Mzt
X-Received: by 2002:a17:902:f60b:b0:295:55f:8ebb with SMTP id d9443c01a7336-2a7fe809fe7mr22969725ad.21.1769169330456;
        Fri, 23 Jan 2026 03:55:30 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fae2c3sm18753455ad.69.2026.01.23.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:55:30 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 23 Jan 2026 19:55:23 +0800
Subject: [PATCH] thermal/drivers/airoha: Fix a device node reference leak
 in airoha_thermal_probe()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-airoha-v1-1-ab167bb12fb7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKphc2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNj3cTMovyMRN3k5BSzREOzRLPUNDMloOKCotS0zAqwQdGxtbUArEW
 uGVgAAAA=
X-Change-ID: 20260123-airoha-ccd6a16a6ef6
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769169326; l=1272;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=XTcqj191QDUYaA+6GiS0z3Gz/w3k5q3FR/PCUyPd+ec=;
 b=WtpKuRsBJd4y6BjExv8rSVeq1lBBsAV0vZxDfU5eMyPlsBl7MAIQ8TSVlU+ylQizJN6ZWZKbR
 haJ5wBME4MSDmiMgWhWb1/xMFYDOn/OASg6337XZT81ybprz/NbvuBK
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41368-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,intel.com,arm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6969756DD
X-Rspamd-Action: no action

In airoha_thermal_probe() function, chip-scu node is acquired through
of_parse_phandle(), but it fails to release this reference if
syscon_node_to_regmap() returns an error.
Add the missing of_node_put() call to the error path to ensure the
reference count is properly decremented.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..308ea846ba26 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -431,8 +431,10 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
-	if (IS_ERR(priv->chip_scu))
+	if (IS_ERR(priv->chip_scu)) {
+		of_node_put(chip_scu_np);
 		return PTR_ERR(priv->chip_scu);
+	}
 
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);

---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20260123-airoha-ccd6a16a6ef6

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


