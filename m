Return-Path: <linux-pm+bounces-11446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A193D949
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F11F1C22ECD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C679952;
	Fri, 26 Jul 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIPCIqdY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930F44C61;
	Fri, 26 Jul 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023540; cv=none; b=n49uJ1EoaA5z/sfVtNSCx3BkQa2heC+iNEK15wbQ0OyPKHJZ/TqoUsUYNVkyGTx63nbQrf7CwZtPqGiRjlwNPhjS9JlXqkDAQihXIWz1jOPZVsDBNQY75UUwuamLrqi0nffbuDYhnpdt4E2tF26z/BNuESnyIFOUiwVtP4NqdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023540; c=relaxed/simple;
	bh=Wg5fWNhfV3VcE5zdPsBscKsWfwaOt8kpZhzfjWLAknI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edHk2WCU5JqRhn8spt360PjKdDsX0cm+sF5jg1hiGBk9sev5JDafbYRQFYqsY9f9oZtEWZCcy8FUPDWRjF+TVYencTePVTD3KFmppXDDijPykf6ulWzKpw6eD+lBJnys7VYWitSsHlKT3IP78gl87rpgU3kkhY1ROlgAqSU0Ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIPCIqdY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70361745053so616508a34.0;
        Fri, 26 Jul 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023538; x=1722628338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U65j//PVGPMnXq7lvPNajRb5WEczobVRzKngFXWVkqo=;
        b=ZIPCIqdYfGT8Bww2t1Ylww04HY3yZ888x7VTLW05BSZ7gD/MlXPSbAfDI3ANg/uMIQ
         hf0b/0U2XIQM4aZDko5CUoAcMokwqq03vPnjidnVFk2Xe6oFaLqigv2Nou8XYURi1/V4
         gXRDlqtJ1z/y5pPNHrttWQixVMIDMzSQpmtvIdv5HijT6jIBQuQmAiN4vuiCkhnTNppv
         THT4AkhGbqD0Y/6vsXYd/pzJ5UxCFM1iJcHjIcoR2bk48qdROBQ7sGAdUSvd1p21sZoo
         5GDc08iOqYgmN/3wr1iF8iFkcVy1OF9gqATQ4ns1HSM5taNcQJyTtLm7TBY8HyolrnmW
         wxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023538; x=1722628338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U65j//PVGPMnXq7lvPNajRb5WEczobVRzKngFXWVkqo=;
        b=Etj7sWcN/hLMz3pCOF13r5I9I87hbh1wCi1V+ebuOiyLfWIhBfdDjaTbA9OLp7CcXT
         DF46f2TXcQaPSIRPNcHX6+0pZW1eqWxs5F3MjVo23CC4bd5ErpZtgvPrU0J9ijbVGx+z
         N4895TpFf2BKTuuUxTLPOIRxxsoVrbo0P6Hcb+nDuywAkSTKjSFAry1RFqCM9lQdzKPY
         Et9qeyd0gLkwK1B4X8UWx0+6Cn+gFZrefDRWscEdnBz+2p1KQCsuBUCs8OXNd7ts5CM+
         qg3cese8q9zMCbBtHdL1WiHI3aP5AedFI9LzZZ4q5TYq8oCs7X4Gh67FKDF5e4YDp6hH
         cu0g==
X-Forwarded-Encrypted: i=1; AJvYcCXBt6YUl8Heu0H1NnRgEJttnK2BnmxjHejDB5ManKVlubZ8CCBUIz1wBNIOp6KJa4vQ8EM8keeVrV2nZoKXet6P6QYLXAt1aOLEdA==
X-Gm-Message-State: AOJu0YyKQ83AxWykbyxXOFB1c33L8s32fo6Pqd7RKXwVlQPALALYzya/
	wgIdrPhgWWqF+d3olkRQAbIF0ncT5BJEvvv5pofL00dziKJ+PEdl
X-Google-Smtp-Source: AGHT+IGqDKOZrQG0lnORBUuq0nhr1WbgwJ0MZK5eJDcDyNunTGSy0TUpdkpY3iH5A8Zl9p/Gr/nj+A==
X-Received: by 2002:a05:6830:6817:b0:703:6cde:1cb9 with SMTP id 46e09a7af769-70940c93075mr242842a34.13.1722023538443;
        Fri, 26 Jul 2024 12:52:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c1f3:7caa:bc8b:ab10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778069sm889972a34.59.2024.07.26.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:52:18 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	jagan@edgeble.ai,
	andyshrk@163.com,
	jonas@kwiboo.se,
	sre@kernel.org,
	t.schramm@manjaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell configurations
Date: Fri, 26 Jul 2024 14:49:45 -0500
Message-Id: <20240726194948.109326-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726194948.109326-1-macroalpha82@gmail.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The Cellwise cw2015 datasheet reports that it can handle two cells
in a series configuration. Allow a device tree parameter to note
this condition so that the driver reports the correct voltage values
to userspace.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/cw2015_battery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index f63c3c410451..b23a6d4fa4fa 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -77,6 +77,8 @@ struct cw_battery {
 	u32 poll_interval_ms;
 	u8 alert_level;
 
+	bool dual_cell;
+
 	unsigned int read_errors;
 	unsigned int charge_stuck_cnt;
 };
@@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
 	 */
 	voltage_mv = avg * 312 / 1024;
 
+	if (cw_bat->dual_cell)
+		voltage_mv *= 2;
+
 	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=0x%04x\n",
 		voltage_mv, reg_val);
 	return voltage_mv;
@@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery *cw_bat)
 			return ret;
 	}
 
+	cw_bat->dual_cell = device_property_read_bool(dev, "cellwise,dual-cell");
+
 	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
 				       &cw_bat->poll_interval_ms);
 	if (ret) {
-- 
2.34.1


