Return-Path: <linux-pm+bounces-17304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B09C3924
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE361C2129D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F215990C;
	Mon, 11 Nov 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AfkLZFW+"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AB14F9FF;
	Mon, 11 Nov 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311279; cv=none; b=gkf0gRPVXtQpGHs9BVtXQsp0+bSkNkuAdORe4YHUxAX9qRQPS2xsPXzIEgWfbF2XznrXM/Vy7KXYkyGjUOSXg2+kuadhRM3N5Ji65NiiBX8j99WHB7855gpRj5jONi9Z9Bqg8ASKzB/leS4IAdP10Vs/UdaEd2QhgzDJJ3hVttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311279; c=relaxed/simple;
	bh=8141MIeQteVO4xmHYABX+Gcz/sZ+OiBOCJf1oHf2DYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0GydFBJdAm4hWRSGdQU0xOkYhQc6VNrDIgz01yAnTehyAcpt2DOMuXTSHtIQtMJ1btjHvd0m/sGBCFw5VCbMgwUyv5qkwtNuDkV7OIC4Yf/BL5HM64M0ePSWDtDXXOF8baZETANPQdrWUDsh3Nl/yLMW5wDdZATjff9losbc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AfkLZFW+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 13710A02C2;
	Mon, 11 Nov 2024 08:47:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=2i3QQlreelCEdwCoTEZ1
	tiG1QMbQutV9WlIx5Sv6tSM=; b=AfkLZFW+VP0uMQG8Z1k4NeZKT9xYbNv5GOSE
	yc32X14mK7LzVh2H8RgTbGMFb5n/qM6jyqNNVvHqm5fgiYRBuY9vQ9ypJLCjRok8
	ohP96toFlRFSIZTDmqZGYFV8N95xgZ6zL8/YwDRI4KffgoHA6ywxZMKaXapw0t2S
	X2MHr51Nr3jmB3ZNoGy1M0KUgV1rMjWwobDQDs5O7syWTtKA5LIRyXvBE1BRJuNQ
	s/ydof+KKVj+nOUn3QG/3M4tetZuOx8g+eXZ1tV/zQBLT7MQ1MX2hYcUUuFc4x54
	65k9v+GqrJP9hA5YhbRju50mwW+2/URz2HwSuws27taQwtc9MWHEbhPPktxQY73w
	5YARn5Qw1jAIxvS5PYiyR8+8v1c3ceJfRBEtCjsFDyn0BUGGpWMoECoLAO9o7bbY
	ioxqzijoR4lffQ4SSZNENSsu/rUxpbYp78OoLx/7qyVekuuCKsUoSB8E5vXop1dK
	k5hY1nYdcWVyJZBQQlKsalAOpVZ2voOAhrTsOMufkhWvcVwrHhZFbJm2U//HrRVV
	Hj2yc9e/RfysvB8lwk/IoUQOr8iJOhaJzFhPMgUxVBOtPY0awrRz+a1Evqn3kM4L
	SyqaMjWqF4jM2DCvSXkezwna9N54aG9ag8VVh+B10YS5Fj+JqcKMXdMv2nrE8Emv
	UFXLLwA=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v4 4/7] power: ip5xxx_power: Add battery type for 4.4V
Date: Mon, 11 Nov 2024 08:47:17 +0100
Message-ID: <20241111074720.1727163-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311268;VERSION=7980;MC=3195921940;ID=287558;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

IP53xx series supports 4.4V batteries. Add support for it
to compatible parts (that have `vbat_max` set to >= 4.4 V).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index a55441f87cc1..3a739a969dde 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -10,6 +10,7 @@
 #define IP5XXX_BAT_TYPE_4_2V			0x0
 #define IP5XXX_BAT_TYPE_4_3V			0x1
 #define IP5XXX_BAT_TYPE_4_35V			0x2
+#define IP5XXX_BAT_TYPE_4_4V			0x3
 #define IP5XXX_CHG_STAT_IDLE			0x0
 #define IP5XXX_CHG_STAT_TRICKLE		0x1
 #define IP5XXX_CHG_STAT_CONST_VOLT		0x2
@@ -363,6 +364,9 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	case IP5XXX_BAT_TYPE_4_35V:
 		*val = 4350000;
 		break;
+	case IP5XXX_BAT_TYPE_4_4V:
+		*val = 4400000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -490,6 +494,9 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 	case 4350000:
 		rval = IP5XXX_BAT_TYPE_4_35V;
 		break;
+	case 4400000:
+		rval = IP5XXX_BAT_TYPE_4_4V;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1



