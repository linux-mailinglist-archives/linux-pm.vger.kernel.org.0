Return-Path: <linux-pm+bounces-42895-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOuwOZR/l2kOzQIAu9opvQ
	(envelope-from <linux-pm+bounces-42895-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:24:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C573162BF1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EB3300F51C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC5328B7B;
	Thu, 19 Feb 2026 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnE84iLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24B30DD1F
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536269; cv=none; b=jB7YjkdRoUb20CPENEytQ7eS/rZdLAcl6bGYTqlPkup/OL39+wbPbSW6HpU9l2p/uJIxRZM9vQV1wOG7Nx24sUNuUZu73YOpaKks2s2Pmr26K20QkWq9zwCB7BYG14JHg0f/iEonocXOlZPiofoS7qIk7Ft3G3VLY3KyJNjj6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536269; c=relaxed/simple;
	bh=05RSzQ6aGfpQBWFTHSrnmnLGtqa2JkboMGza++RcVTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbLbhw+UUKB3Q3bLKKNMEUKO3DNFbiqHxx/TDhBsykxymp6BWikbjlChcz3yi0RGmbsFHk9EbjY2bVtHvqK6Ca9T4msgkZFl71LM2m/fzuErfwtoVJOg8YN8oOM9Q9AaiQlEmhy6/B88G8pkvoSNB89AU+oTdLEjotfNuXjQZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnE84iLF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4837907f535so12822215e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 13:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536266; x=1772141066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYmQavggp/+jkZ2TtdSFHajcoKxwjBoH+NI9S3pIhw=;
        b=lnE84iLFnPbelDjTJEmWYKJCmVP6X2IWvGenrItNYxBG3+WQJtbFsm2MOjR+O4JRSj
         cbUDpyldknsMV/ut/mDgOI64nmAtVonHtEDUDqpGFixl5Rjgc6wxpPaysdjW3oOym4yx
         NCjvPVNhVFbYVQJd2hEziVFdmf0YpelQ0rHYluwnkAzUyPr7xdhmvMNfKhBUk8RGldQ5
         PDUrkuV/j9VQvSfmcWQsZ6Lf7j492Xi74ofqOXFcWLej6G0Eci7urJBcL85b9hbhZB0q
         W99k9TnxqeaBJptuB+0MNl58d0CFUaVOw2GCAeJqIXTHBDwDbSUA23KbmAwB7LDm5nTS
         f29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536266; x=1772141066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GYmQavggp/+jkZ2TtdSFHajcoKxwjBoH+NI9S3pIhw=;
        b=gPi9WxAI38wW07eexZzT2C0YpmVyZv99iBSnLaVa0+rd6h+AZs3w9ObK6Gtf9p3Jm8
         rIuAn38H71J04DvJna36J5M4qYfE3JHvUJG1RoCnDxetL4Hda/G9WvXT1hSbxGWf4eD1
         iYHG0PHXAM6Xk2NJ14/rFY8Y7bwyLlBr0UfuQZ3PMswKtIDAtF2D94WehKi5+roZx0TW
         C1bFRxsPgAr4pYC6KFpC8D69XpF3pcrPsW1JueCS3se3zEcyeTvWsPesM8RxXW/PgUBU
         WwO1NW/mtrft/Ct2+NxWO/4Kn/aAiIfmoWoptZvYrfGGRIOGA8P0l+eJjqCtMMMigCvP
         Jfpw==
X-Gm-Message-State: AOJu0YxYqf43tZaGQFjtw2FMa7OetWIVtXpxBqoLSuq/2R5P1x+HPNpp
	GBp2MPj1s6Mu4uX/8n6J/MgzC1em1NkulQS7WBU6aWX8yZx6s2vrbL8De12h/2CaKVQ=
X-Gm-Gg: AZuq6aIpUf3ouHtQ0/IvVJgqc5W5i1DyukbhYJSx3Qa6w/JQrfGYcPyKbu8OBAx8/ln
	SmTA4I4LX1tiXnbw2E59hdWZ7j3GyaYSxMQHwnGnjEaeIT+MlA7ooskielelglS0wssFMPGsJCt
	9tGr3Fic9vR+76LTLcojByphQkJ3A/WMr/c3soebgJYhrG1si0cREHm1uj5Qj7URPv8bchhgt8n
	ivch46/kRVa5lPR8yhgapE6jqjhnYuV8nOvnSSLRhkB6fG/jKLfn6Jn6TyVFitxDaLpCVzlkfER
	htApFL7Q9IvxiD3KBK6ly4eGHhFeOgNUyuJOeCqNPoTGhJso5DPqndzW+iV55/XbtB6iL2ZLhN+
	i9YuDd4QXDxJccgsvopgqyJ4Vs1HH3IX26tkBawBNyzTdvPTPtLe52ww+FIuz/cq8xiluETGyPH
	EuiE6UbIlV7yPpDjLXf1pLiNcILg==
X-Received: by 2002:a05:6000:2c12:b0:431:2cb:d335 with SMTP id ffacd0b85a97d-4379db98794mr34683985f8f.34.1771536265903;
        Thu, 19 Feb 2026 13:24:25 -0800 (PST)
Received: from localhost ([37.228.227.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74704sm55020667f8f.16.2026.02.19.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:24:25 -0800 (PST)
From: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Subject: [PATCH] power: supply: cpcap-battery: fix typo in config name
Date: Thu, 19 Feb 2026 21:23:53 +0000
Message-Id: <20260219212353.49416-1-jaime.saguillo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42895-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaimesaguillo@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C573162BF1
X-Rspamd-Action: no action

Rename cpcap_battery_unkown_data to
cpcap_battery_unknown_data to correct a spelling mistake
in the identifier.

No functional change.

Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 507fdc1c866d..f58269c75509 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -387,7 +387,7 @@ static const struct cpcap_battery_config cpcap_battery_bw8x_data = {
  * Safe values for any lipo battery likely to fit into a mapphone
  * battery bay.
  */
-static const struct cpcap_battery_config cpcap_battery_unkown_data = {
+static const struct cpcap_battery_config cpcap_battery_unknown_data = {
 	.cd_factor = 0x3cc,
 	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
 	.info.voltage_max_design = 4200000,
@@ -429,7 +429,7 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 		ddata->config = cpcap_battery_bw8x_data;
 		break;
 	default:
-		ddata->config = cpcap_battery_unkown_data;
+		ddata->config = cpcap_battery_unknown_data;
 	}
 }
 
-- 
2.34.1


