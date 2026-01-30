Return-Path: <linux-pm+bounces-41783-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFUIGwO2fGm7OQIAu9opvQ
	(envelope-from <linux-pm+bounces-41783-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:45:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC44BB4E0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5964530185E6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF092311C31;
	Fri, 30 Jan 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd+XKquk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C430C36D
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780443; cv=none; b=nBZIi0aO79yhPlmMuyxZa9z2JoIMjTwr4hQf9pyDV9r8DowF1dJCzSQXsH0JLA9yw5Ytl8U4MwVLhmuhSYv72a15S26YROBg3qcsr8Z1ORB3Uc6SXtEPh+oUZi07NbaTDLk+y2VM+BUqVXvCuHUYFh5i9v1Z/9c0dozKMQzP3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780443; c=relaxed/simple;
	bh=cnUUw44tvHNlr6PvqiEfM0NQBbDmCwZTNoYDpm7eRqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9t4z2KwImUtdBRl8nZjTxDCIIL1rgaMGZlDsI7HsN0YcmayNjvp6+twtDv1Fj802u+h9HFQPnHO0w7yCO89h+Tk2CXzMnZIo4KGXgjyTBWT7PsWGeSCJFKC1n/QaUJpJMX2bvbKeudRvriI1ZkG5M05WWDWrs0Kc2Aquktb+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd+XKquk; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so15742205e9.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769780440; x=1770385240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M97ZSM4vrEDur6yjHL1HrvY3NbiEvbdJrVir3jieaso=;
        b=Gd+XKqukw64ZrLwv0cQtV6eIG9XoDjRivb6CS1vosWu7A1xqmNIhBbnKYkUPeLhoCO
         gquOQgegxcTyOEzQp4oFgE9jBYE1GVeG7pNcYQGgUk+9p9uNckgaXvgpSGq6v0GRDctU
         z8ydVSn3LXi/OhHdMrxB0VUl4l62gBWOEPZd0tcSn8tJL4gPvGEXTTkyyATmkTeLg2s2
         wRD7JQwByBce+Kdo99EJXTwp8FJWfd/InjC84ZxmeQqW0p8JHpqCDR6Yu+ondm7+IiPy
         sBbCy1TOMg0qgdM5qDv/6jDMlisBzSQziMugX/UCP0Qspg6ueqXVz6R0VuTw0XU3bUsS
         HqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769780440; x=1770385240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M97ZSM4vrEDur6yjHL1HrvY3NbiEvbdJrVir3jieaso=;
        b=iw45y0DIC2cJ5Dd4DBB4CuyC7pKGVymU20DYUdj+GW1rjckkrHUW5XqGS6571nDtob
         qaQQaC7kb9xEchBKqioA9lx2p9hDBOV0weBLIGgUHeUTqKtH+Y1ELF1HSgSZdFw+h7aH
         RqzHYknwfk66bv4hAEsUmifHBx6hueb/gEzWl3M0UEbWfMcl4jnbosCkFbGUhuUiuXDw
         n5TXA9XDjQ/KqkNZ7CNTredROcy8/ITTRuEFhJWq2eQfUIEMEeiU1Mo82bEU0J3064+L
         /t4BrkQShuAHlR1YnSioJE0IhF5CILst9MlVptaaVkUvs3J3+6Vd1YoYwpQgKoiCkJUn
         lJZA==
X-Gm-Message-State: AOJu0YyOjthZ+cJg6OootNhrRfY0L2ALFeL73yp8Fctw5wpUDtvCb5mJ
	CXI3xCndPjJhrt07KENyqOcStDPAanpGbZutFgJ5xKmDjd2G1MLqZW/7
X-Gm-Gg: AZuq6aJNS4DSFKTUAPsY5lT0F7B6UFGihQKWMqhrUU6c1FFj/7tjTRm8S5iCRxZ3sv+
	zkgETrmarbjCDrKvLAnRedcj5jQ3LiwxCFrRmdw/oD1xD/W7ZrXXMPgYukAB964kQVkScX+HAj+
	pTgja1gyuOnpM2lnZ2MczPzvvlnvLY/qhORi87DpX9YctHjJdKxFU8kTvQnq4QlpsomkFjCpaPS
	uJt/PNFeFkLaRDJFZ21M30jMt9ioESxKreLQWoYy7piMlLCwZ8sqfEFkRbflFVwqGTN/YL28lSX
	a9Tzu4wgDctpwIRJ4PP8zJ13ePrGlZcGK9WAaMMOgxgwdr1tbUSfQzxM3d1XV5zpihTngUD3tT2
	wZ08RCxXh2l9Yo4uDgIDtJkG3O4XOg9/M3BPaEx4ZwU7mm605Ji+UWwHyoEuAED3EUCs60hGyVE
	Dz
X-Received: by 2002:a05:600c:628c:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-482db47ce39mr34693605e9.24.1769780440375;
        Fri, 30 Jan 2026 05:40:40 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm199106075e9.0.2026.01.30.05.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:40:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] power: supply: cpcap-battery: pass static battery cell data from device tree
Date: Fri, 30 Jan 2026 15:40:21 +0200
Message-ID: <20260130134021.353688-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130134021.353688-1-clamor95@gmail.com>
References: <20260130134021.353688-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,atomide.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41783-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EC44BB4E0
X-Rspamd-Action: no action

Add an option to populate battery cell properties from the device tree if
the driver cannot access the battery's NVMEM.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 507fdc1c866d..9e686ba20282 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -404,6 +404,30 @@ static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
 		return 0;
 }
 
+static void cpcap_battery_update_battery_data(struct cpcap_battery_ddata *ddata)
+{
+	struct power_supply_battery_info *info;
+
+	if (power_supply_get_battery_info(ddata->psy, &info) < 0)
+		return;
+
+	if (info->technology > 0)
+		ddata->config.info.technology = info->technology;
+
+	if (info->voltage_max_design_uv > 0)
+		ddata->config.info.voltage_max_design = info->voltage_max_design_uv;
+
+	if (info->voltage_min_design_uv > 0)
+		ddata->config.info.voltage_min_design = info->voltage_min_design_uv;
+
+	if (info->charge_full_design_uah > 0)
+		ddata->config.info.charge_full_design = info->charge_full_design_uah;
+
+	if (info->constant_charge_voltage_max_uv > 0)
+		ddata->config.bat.constant_charge_voltage_max_uv =
+			info->constant_charge_voltage_max_uv;
+}
+
 static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 {
 	struct nvmem_device *nvmem;
@@ -431,6 +455,9 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 	default:
 		ddata->config = cpcap_battery_unkown_data;
 	}
+
+	if (ddata->psy)
+		cpcap_battery_update_battery_data(ddata);
 }
 
 /**
-- 
2.51.0


