Return-Path: <linux-pm+bounces-25587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA71A9111A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EDD7AA89D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1C1922FB;
	Thu, 17 Apr 2025 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ApUjwn2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30D85626;
	Thu, 17 Apr 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853150; cv=none; b=o7r5/ntMCWO0fX2qIzPEIzd7qTcnBGW3E7XSsf+v9K2F62UFru9ZU+el/WZm0kJ2DBOkZO3oxTM8TD6TsIIXGLw7AfM4MC7sULLEBZcEgS9qV8cDYoHSMn48X2tOc6nXLy3WzZ5TcV+l5Ug+kt0HTNEcGwyK3FCoiKzeELuYKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853150; c=relaxed/simple;
	bh=MW/1w69LxsY/ZlXgwNfWYQNsueiopBbrWp7cKxsWHf8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t/V4TPQvc2VczWQOpMptem6d83N0uAR9F+mqx6QijXKChpqBEnSw+bNpst6ADPY+axeWxCoZWmqTasdjgSf3xGb4QM0ewuRQzNWoSbBIyEeHAC6qv93yXyE21FXjJXZqHz3U7Yi1+QngKEC9vZdHTJP82D2ztqaQb18Rv9cC/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ApUjwn2+; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744852835; bh=WytLDcIscOys9VXwbtWnKSguFKL4JVReAaierqjjO3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApUjwn2+apbEcxoUtLbDa0OUZAuvvdTWLBgg+XhtromFv7kuhg3tuzbbII2uMoJMY
	 1JWmF18OGsQYIICeqX+siDQvxhXVrhuuSpTGS9Uj2dkaxpBJySuVimn12bytGESuzu
	 5neQxaQTCsIllneZ3mgAWE1QbL7K4rYmlhPm0KOU=
Received: from localhost.localdomain ([240e:469:644:c677:5cc9:79d:eef7:ec59])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 1F33603E; Thu, 17 Apr 2025 09:07:51 +0800
X-QQ-mid: xmsmtpt1744852071tyzdrfhhy
Message-ID: <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO65gZWpYOMukzoC77AjG1v5S4dj2z/CvWXhfJ19Yq9J5ESu170C5
	 FjoTLfUZySmGyu3c1b1C3NH4fXfG1b4gy7qpPeragCyo4sTmgbIZ5+OOcP35HbLa5qRPDrzcCWD9
	 opzCcapHALhBLi+kWXdbX8jgZ9M6dzuatLWjxiudaOBFU39gsQLUdPChW7OAg0mFfOibYjRpoz4F
	 wn3mhxHgUZ00SbFX7lxxN8pzFkQx1Wiq7qE/btPURHvfKryK/E+TIVuZpoToZOnR78ssEuRtEtaT
	 vOWL8ezgUnFKWVdR1dDPRmahefWuNFm64a8w2H4fHKrMvVIEco9s0TZMZO+W1io3WaJh6AgeYZXH
	 MInHA7Y8toD2B5kaLM5x0u6Pr2WREado9GBYA+NNuxIiZ8XbEeSX5BUSSd3TGBoX907RSiwRMLlX
	 CA1et1xkl9qW82DJ8PGpq44gFHlyGgj9hfHIV7ISrq4VNszKAONWRtOzwVdpTqx+GdOhLVjuWtTC
	 PPFPyqT4J3tMjG2zHhxaObooLlK0WVC8NxhSW2MShfKgX8DI1lwjbJfDKBsX+xFgMiZBSSx4MEXY
	 HW+RE992wQPFB8rps0rlsiKygYbe0H7IfSUcmG90EFhDiBxn2ATjEbmxMCj3zwVQwydlIguTTpFY
	 Kq7xYWW0fLji9n2kojCuz9e+oDYMXIExzolEKL8SsAEmHW58W6d4tf/ayPpHDU3XjBAqi3Efaz5y
	 t3hY5Tfo4BZFjmkaaDrVYoHxiQY87rO/Btnw6Rp75Q0NzsRqxkPOBsCc73fVngYrM0EA1grvL4RL
	 h7Alt70qTUDBiHxAEGzTuPjSbjhLZMTybaav7+nQe1WdCWzXGfSTZlHPdJDaRJykL+BwDMksxrSC
	 Icks81nKBqgcWK1ojPhR1FqAHKiEUunzPikuVYxRzfKzXW/D0j5imiFwlo2IEFVWqYOpYFf5XC+/
	 ff5k4G/BPODx/cF3m1VV0NkjuBKjFV2awoC9apY829hg1DOAR3GDOHvHxoZN2V
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yaxiong Tian <iambestgod@qq.com>
To: rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v4] PM: EM: Fix potential division-by-zero error in em_compute_costs()
Date: Thu, 17 Apr 2025 09:07:50 +0800
X-OQ-MSGID: <20250417010750.85106-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

When the device is of a non-CPU type, table[i].performance won't be
initialized in the previous em_init_performance(), resulting in division
by zero when calculating costs in em_compute_costs().

Since the 'cost' algorithm is only used for EAS energy efficiency
calculations and is currently not utilized by other device drivers, we
should add the _is_cpu_device(dev) check to prevent this division-by-zero
issue.

Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/power/energy_model.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..41606247c277 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	unsigned long prev_cost = ULONG_MAX;
 	int i, ret;
 
+	/* This is needed only for CPUs and EAS skip other devices */
+	if (!_is_cpu_device(dev))
+		return 0;
+
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
-- 
2.25.1


