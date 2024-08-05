Return-Path: <linux-pm+bounces-11928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B494863E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B337F1F221C6
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B760170A33;
	Mon,  5 Aug 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AlAGvw5U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA816CD3A
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901159; cv=none; b=hDTpxJm4HAeU89OWuY0Z7cFWBQPmPPpqq9tdctVALtRx7Ru63tIeJ5rmuGzl6rPEo4Y58VAC08fxoks2Kk8YjXF+hCHgAMoSXNMTc1iqK/ZssNNqn4vo4uz05zjttvXqkkAH8SU07RJLbNy2Hg00V2Lm9m0u7B0AbG2ftCX18+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901159; c=relaxed/simple;
	bh=aUhXQyVPFrL0JWTJ8beXrItrMemL62+rc4k2qIkw/uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKP3KSLWMRhcAkbRW7BA9OEpGKUfEI/FvnjnjmXMtatDPTBKXB2qfEtCvUs04Y4l3mlW7z8Br4x8vD30p3Xm/+GnA9F1OxHOztjZXPongYi52pDJWY35mV+PVlEIID9AxW1YE+2GvI8Iz/pqj9qrZhKqy+9r21JnZVKKhgGzfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AlAGvw5U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc569440e1so1896075ad.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722901157; x=1723505957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMoK0Qo5SMl4nszA83I1OdSyVHO6YrX7RhAtuco02KE=;
        b=AlAGvw5Ut6lBGEsDzAgZUFMMUGo/6VbqyS0P+gDCM0osp3mWIVxGdSQejYZDnmKBtc
         RNpc9TmWnJDESLbxF7c9BHq1T90d6XEPwUElxqJs9IooOGcYmzFa4rFuzqFQT5SFMhpn
         zSslKZbPdBIDPWOkIaRH0BrCfSrCozMfgzJUJYD6aOn2M/PhZb17ET4cn+RwnV5Owz+l
         T6YCc6YLoLb3BfgsqSM+ufW/NSOgTDytHYia8sdRYvqtjRorf4lYXHfd1V42ug3FbnxU
         ZxVbIZUqdBauqAFh6lVUMoaWAdmqnZQ7z50XZuEBqZeezntyB1hBTntHvvmwkLCyqPBh
         aM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901157; x=1723505957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMoK0Qo5SMl4nszA83I1OdSyVHO6YrX7RhAtuco02KE=;
        b=IEehCsdW4DNt36zbAGr5qkssLaAQqfIsxEFr3MpxLFvtof2/ufCxJpYz+BCb3odcHs
         OTKP16wxycdwhvDuuUF7njrreGdKoefUiGWktT6D0kCwf721FQXUK8wy2J4FwrUaBmZ+
         PPOVWeawm2sxR+TfIFSR83QN42ezX39yRrkweRL3ve0oYS02f4ByFKLN+omSyy+aP/h7
         GPmbkETHa7MD1AqhSCJ80gepQamc8zLyaxJVpQG+U96ckK30piDyzWophCmvbe28F02O
         vUyErkklJsOCoqM/jiVgCHhdEwqvAw1GhYruf2sCWg0ubrIjpBRA/JL+FI/OwBNVRPg7
         /Syw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHv880meI4RDdqmYylbBmJU6wmseDpkk/TlBB1/OibqIWthULweGH3L4rAMxE8dYzTAlICz5Hi5gly1B7ug37bB5MVzzbVWI=
X-Gm-Message-State: AOJu0YwgiVpT1xqepU006oibz9OY/MMgVyTmGmHOagSaYwYuESjF+OU5
	uXXbWYK8ZD4ZNzIKv1mxopGLWA9IdQX96duvnDVhzR7MbqW3L2LcyDMEIDwMhYg=
X-Google-Smtp-Source: AGHT+IGU2ua9T3+pEZaILj3eRYOvNhkdYAh1SxJhl0qoN7WB7rqpH1SxarYAFcOGXTS/PVZZH6t9lA==
X-Received: by 2002:a17:902:e743:b0:1ff:5150:911d with SMTP id d9443c01a7336-1ff574a2318mr180660445ad.60.1722901156706;
        Mon, 05 Aug 2024 16:39:16 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927efe8sm73931945ad.224.2024.08.05.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:39:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 05 Aug 2024 16:38:41 -0700
Subject: [PATCH 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy chain
 wakeups
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-lpm-v6-10-constraints-pmdomain-v1-3-d186b68ded4c@baylibre.com>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
In-Reply-To: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=aUhXQyVPFrL0JWTJ8beXrItrMemL62+rc4k2qIkw/uA=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmsWKg+0bREECCIN99S3Y6KtlAALU9lAthCgDzf
 Bf4iUGVt6aJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrFioAAKCRBZNxia0/vG
 Zcf1EACSk4ZidtH82/O+s8oj6aWPnpde20zrx47lXaBfxZfk0Bg80Aac1G+fXTSB1wBWdiVYqXZ
 f8R4hmikfvYDiac9B30IHEdPIUbIPqdRn7ouG+s/sqMxGOBoH2PQJJ1J3Jtc9KtbTRCncF34XX6
 LTuThT7ogDmORnkIaXRVyagjAZ1IJTc0EnMnR1p18UmEyvRU4Tnx19xTKSBf89qtRJ6XIyT3RCB
 xkv+zSXstVjWJ9BhWjjesoRPAsBWo/nAUe45SCa9QYIYP8HBsJqquVQgO6gkAPZoCGmJ8qp0tYl
 NWiBge+F5xzaRtPytFj56HpbbCL0WhVPmxlacDy13Iu1G7RR3OWn7MvcIOezcRzAdu8z42NYsHe
 9uqVT9dysnzMrnBrigY6PFsrbVG003BAC6bpvVwtujdtftYYnYVdyrsr0tSetCUDLjvBbYhLiMp
 leryBok4AlVHNLdzo+7B1L4JyAy2/2cjlDPSSJi9NQ9XLkPRXJiH3WV9EBEG+Sfzaf3LJi3VqpC
 CAPBKtyhB+JRgFpkUtLeSVMthYqDXQWJvUPVOeq6XJFA8xZoo2l/yLxXZ9K9+NVQMopkdd2q08b
 iIkDPIN+/rSFqJnfNQCy5tLkaHjHQbHkkVNWUXGLM/SeV237JdTeCmuGy/WtkFE4+uiXPQWBK3U
 95qwGdvjz76jp1A==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

When a device supports IO daisy-chain wakeups, it uses a dedicated
wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
wakeup constraints since these can happen even from deep power states,
so should not prevent the DM from picking deep power states.

Wake IRQs are set with dev_pm_set_wake_irq() or
dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
when the interrupts-extended property is used to describe the
dedicated wakeup interrupt.

Detect these wake IRQs in the suspend path, and if set, skip sending
constraint.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 7cd6ae957289..4c85ce50510f 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -99,6 +99,15 @@ static inline bool ti_sci_pd_check_wkup_constraint(struct device *dev)
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using IO daisy chain wakeups,
+		 * we do not want to set a constraint.
+		 */
+		if (dev->power.wakeirq) {
+			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+			return false;
+		}
+
 		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
 							       TISCI_MSG_CONSTRAINT_SET);
 		if (!ret) {

-- 
2.46.0


