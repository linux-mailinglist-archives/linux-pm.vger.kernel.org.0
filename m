Return-Path: <linux-pm+bounces-16883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C19B9487
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460ABB215C0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517AF1C9DF0;
	Fri,  1 Nov 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KgHoo3oE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103F1C7265
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475411; cv=none; b=LxPkbtjaVId552BfJFKRk3R7R5+eZmx895pWWjTgyuMySSoWDnTJo30ZKIucVIET552198v6rQ4tGde/lAN6tVCpKuazqtvgzcHTFwYBfh6ZXJxAbg4yu4D3/6lMm9nTQJW5fr3PqxsmUqvc4WGtHJFi0xw9JgCJmY/nfuGExm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475411; c=relaxed/simple;
	bh=xhPvgmqbX1LH74jmdbMgtdutexJPgNxRb87XIYrFvw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIyzn5cPOqfXw4rcRQbx4RMhKNDP3fNWDML/Nl1q9u9d/PBOHCfv2fYg7rhkX0+f7zzuiI/yivmgunGQtWZ8F+cI62oV4/UiIZt/3mKa4L/WbmAIW0Wool19cmMdERJor4paUCj+dQzIoIaGI2CNLTpb0nBLWPsktXsPJVGr3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KgHoo3oE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cceb8d8b4so13678215ad.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730475408; x=1731080208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke4bvOR1ARJKXE6dRhRI5chunW+2b5MmRjCBBzyOcvk=;
        b=KgHoo3oEKNkEZOVE0YYoB7nkNvsNCgGr3UDU6nYrhwxDU80qS+vVpCIrueW1xmvRrb
         Awc/oRlAtRSfaDaza2BMhAXtRMAuXfXBKqs0Uhd0i8QpVyYhEfi3QI8smTRWnpUiWNRi
         pF7vGyDZcyMnVXKfqpquu4Y+z+1zUCL9yp56H5fkF1ChvS7QsrryUpWrkH9XE9F5YPzJ
         ZVB+WWsvVGNa39RmFHwebbbHPei246fymVxd/O1qIiyFjzs4woxuAijDf/9Iat9U136/
         +X4ohdHRqZnLpa3fX+Il0BtBcFYJYwGrooslYEWezgcJFkbNjIeUP6XwGtxgSWgAwA9y
         XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475408; x=1731080208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke4bvOR1ARJKXE6dRhRI5chunW+2b5MmRjCBBzyOcvk=;
        b=DLbpCjV1PuKP37AEPSxjz9XTL7A1+LhHFAGSjobo81gId5DzJQZKsvl4T8ofo/qobP
         8luMF5j8eiHieee2sWEChs51J/Mv2AY9+gW81W1VyiS7ksr0mqmSGDg6+37Gv3GWfPTj
         bbMyLurFFJE1+jA510jCPVAsiG7ckB5jvPgNP6V4GryeGwFK7sbAT7DI6KDr0smxY+tW
         NWdCrIEZ/Gg+RNii7OsIZguym7F0fKppk/joJPfRfZVmkjM4UyM8yoJ/rVIaWdKV7VqK
         LPkDmbAt0vVJuAO9RU985t/GS4auUGIXiv/tM2NnjcPAJmb+1VXJBmBS8lirmucRRLxY
         0mFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxH9wGR2zE3dfWYsvMf9+8pxsksaKr0JKcWVPkzc/Qvx+MZ9PhqwX9leP3XWQS5LWyyPir6R0bUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrdhcyVhDg3N1BWDTTl/9dNInn7Ta/SpIT3goHRdR4DK85b9Rh
	Hvgye55dzBxALRUG9MrSdNr2mgleSU+SPF/y9h7SaXA2HbpC23rvHkmF0OWc5TM6k0Ol7W15azt
	evrOnDg==
X-Google-Smtp-Source: AGHT+IG/l+yDbRhZEjiD8rTuwk+Sm1zndokY3M0MeOuQu/ZKMTOJSdasBgYBgyc864NCeM2KcYX6rw==
X-Received: by 2002:a17:902:d481:b0:20c:b3ea:9006 with SMTP id d9443c01a7336-2111938d4f1mr60409805ad.6.1730475408251;
        Fri, 01 Nov 2024 08:36:48 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c1117sm22363545ad.224.2024.11.01.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:36:47 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 01 Nov 2024 08:36:22 -0700
Subject: [PATCH v5 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-lpm-v6-10-constraints-pmdomain-v5-3-3011aa04622f@baylibre.com>
References: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
In-Reply-To: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-cb14d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=xhPvgmqbX1LH74jmdbMgtdutexJPgNxRb87XIYrFvw0=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnJPWMXtH5x8ZpT2datlNjpCsnJlX4SCLuKATpJ
 3kgHjSOs9eJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZyT1jAAKCRBZNxia0/vG
 ZUyPD/0SCDrZfCLPdsvedTVTqaRMR5mj5eDMnG6FkO1ciyUAcuO+putYwuhHhwRO1Aqs3/ZKdLf
 i6PBtuQOIC+eZO9emjOp8dYnBbxSLcuKLTRB0cZm+6oCb+eoMsjwaZjI35cD9VY49nZcU97x0kr
 +Go35m4aHJL/Hg9jhx1oJvth37B4kbl6SFJCtHNlGw3mnGBY25kU40H0bABOURDMeFYbpEXjc5Y
 kjMDsGE1H+r+s64wERgBNlE/cSYeNiLzNW5wNi+TQq49Ny6zMFxRk7j/8TvPee0rbR8HrUmzbgx
 8MVDt73UR+rLmWMPf+ysyvXfKlNv96D1tlzv85OlERbFBGekt4tUD23FwZ4W+5vYJ4+S0myyVFu
 6nbpBt2cBAMRLlMSohljYIKqiM9N62G+OLAlUvuEKSnKlZnFUkREq3d/RlO/7IPuw0m4DJqzCIT
 1ci7p8KFmFnse9mlljjaHIVe9BK98xiVJkXR6CUyzDDhtDu5AtU/pMGyx4USAoTxarSI8b/LxMz
 PAMxc0Hlq+dPh6QbV8ryKUcnp3IbP/S56sCnr20ONCuHpLMgYn4az8Yh3WXmMoB+MDEocJgV+J/
 JGLpJsTXbuHFsJC3gvV0g9gYmj2LiG+JOqwSwH1W4kLK811GMRoOJlOzz5HhkK3tKsNLStHsJyN
 82/t/LK+VRSl6ng==
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

Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index ff529fa2d6135cc2fb32ae8a3ca26ac055f66cf5..8c46ca428f60b3d42a5a43488538f16b7ffaa3ac 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -82,6 +82,15 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using IO daisy chain wakeups,
+		 * we do not want to set a constraint.
+		 */
+		if (dev->power.wakeirq) {
+			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+			return;
+		}
+
 		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
 							       TISCI_MSG_CONSTRAINT_SET);
 		if (!ret)

-- 
2.46.2


