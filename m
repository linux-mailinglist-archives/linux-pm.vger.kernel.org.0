Return-Path: <linux-pm+bounces-16245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CED9AB2C5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044992808FB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20001BC9F4;
	Tue, 22 Oct 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAnxlRfh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABF1BC9F6
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612321; cv=none; b=ad8N5NSJ4Ljo11W8w4V0Zh4r+Oz1lGFOGi0lomvG2uqdfKRSZMoFPHt4EMKpVWosJbUdr2spJuVy0xibW9rEFlCFw6l1X+OcxofEbI6hkN+w22iBQ83082baft9Ca0Qvt6Kp9S+/mZrWFSncTrMXmCMmKe0MyeRx3qs6cumlcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612321; c=relaxed/simple;
	bh=Vape9wmPRqvxV9y6aEkeCHyg0PIZjoI3tZA4z2EcPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juj6AmJYR9haZW8drriFZYATNDdHRO6sPjP+B6x4/jhvYfMX3UunnIYMtRHoZkY/Jk0CSlFtd81a66GCu8+06LhecWw+zX/7rc9NOG+MGO80MipTWkd+iqN9XUNZxvDewsica42vuI4OuOE2a3R97f0xXQ4HFRvRQEzRUOH6wwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gAnxlRfh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431616c23b5so29935475e9.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612318; x=1730217118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6N0J/aO9QVYhgRdsmiLuSTn61Oe0bhTn6ZqjO0maUY=;
        b=gAnxlRfhy5F4gW1Lrp43JUB5JkEN7i7A3BUEKEV1FpFpjn5+LKJZlkJICZ03Oc6xPJ
         9u8QG+Z2G3TtRxE4hPb3hgb3Q2R5AtCuCxwN6VXM2JJ3NqUN+ObX8DigLokRA+ki0T3J
         bBZGCw5MT2SMEZ6ZoGo8YRzFbyI2zW/pGaKwhQRVfz/L9cH4Dag/fSqRtxHQPu3bnhh2
         LJzrkXXpOW3WMC5Rt6DXUemSlCBgnA0iD+XVdjSxzMa1YpHuiI471F77bJDWg3QWkS/y
         DX9I68nBmH+frZ59K6g8kWTgUk+8633ua5/qibkijI3EIP7cihB8gbqYnUeL9y5/2G6W
         1vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612318; x=1730217118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6N0J/aO9QVYhgRdsmiLuSTn61Oe0bhTn6ZqjO0maUY=;
        b=vQCXg3iQpf781uxYY6W5UYczVDLg7UoMVo++I6SuCTsLCZRM+IuRslQ2WnUpkd4pgG
         oTstnKaGiYUDz5xU0MoYc7+z3b6lDpg4XsLeZss85SRZ4fP0i2H7IN3G7Pks+fCU4tt/
         GL5XgxZH6EGc1d51kGADmSP/10nKIRy/0uzYx0Y/6TIl5biVA9F+XzPAXnNHFOEG5UdY
         o4ktrdmmaPH941QDqB6hfr6DBD2cXUlI2UNsy69RbzjRAKGHtgdpy1G9iXjFrgll78Qf
         wusaGQ8fDR6si3qGxqUg6qDAC5sDOOcLpObrLhVuX1c9mpYwcSj49sY1VveikMRLA/tO
         B+wg==
X-Gm-Message-State: AOJu0YwJuUAHHIH7k9Zq6WxIBE5cR6wilELG/P2FMjm6ODGMjezfiJOS
	Gz+sckT6Gm8jI9+qAEHqeGkwNah0k9gu2eUa5IVvjAgB+RMaCwTwJqjs25ZKEIk=
X-Google-Smtp-Source: AGHT+IFZGJxkruqz5VdSXHb/Pj6KWmupMMwvDiT8bndC65B+zIRBRSjzxvTqzMnwWKNX+qsKfk7EuQ==
X-Received: by 2002:a05:600c:1d10:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4317beb1da3mr22486685e9.17.1729612318070;
        Tue, 22 Oct 2024 08:51:58 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm91538075e9.22.2024.10.22.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:51:57 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	quic_manafm@quicinc.com,
	lukasz.luba@arm.com
Subject: [PATCH v6 3/5] tools/lib/thermal: Make more generic the command encoding function
Date: Tue, 22 Oct 2024 17:51:43 +0200
Message-ID: <20241022155147.463475-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155147.463475-1-daniel.lezcano@linaro.org>
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal netlink has been extended with more commands which require
an encoding with more information. The generic encoding function puts
the thermal zone id with the command name. It is the unique
parameters.

The next changes will provide more parameters to the command. Set the
scene for those new parameters by making the encoding function more
generic.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 tools/lib/thermal/commands.c | 41 ++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index 73d4d4e8d6ec..a9223df91dcf 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -261,8 +261,23 @@ static struct genl_ops thermal_cmd_ops = {
 	.o_ncmds	= ARRAY_SIZE(thermal_cmds),
 };
 
-static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int cmd,
-					 int flags, void *arg)
+struct cmd_param {
+	int tz_id;
+};
+
+typedef int (*cmd_cb_t)(struct nl_msg *, struct cmd_param *);
+
+static int thermal_genl_tz_id_encode(struct nl_msg *msg, struct cmd_param *p)
+{
+	if (p->tz_id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
+		return -1;
+
+	return 0;
+}
+
+static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cmd_cb,
+					 struct cmd_param *param,
+					 int cmd, int flags, void *arg)
 {
 	struct nl_msg *msg;
 	void *hdr;
@@ -276,7 +291,7 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int
 	if (!hdr)
 		return THERMAL_ERROR;
 
-	if (id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id))
+	if (cmd_cb && cmd_cb(msg, param))
 		return THERMAL_ERROR;
 
 	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
@@ -289,30 +304,38 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int
 
 thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)
 {
-	return thermal_genl_auto(th, -1, THERMAL_GENL_CMD_TZ_GET_ID,
+	return thermal_genl_auto(th, NULL, NULL, THERMAL_GENL_CMD_TZ_GET_ID,
 				 NLM_F_DUMP | NLM_F_ACK, tz);
 }
 
 thermal_error_t thermal_cmd_get_cdev(struct thermal_handler *th, struct thermal_cdev **tc)
 {
-	return thermal_genl_auto(th, -1, THERMAL_GENL_CMD_CDEV_GET,
+	return thermal_genl_auto(th, NULL, NULL, THERMAL_GENL_CMD_CDEV_GET,
 				 NLM_F_DUMP | NLM_F_ACK, tc);
 }
 
 thermal_error_t thermal_cmd_get_trip(struct thermal_handler *th, struct thermal_zone *tz)
 {
-	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_TRIP,
-				 0, tz);
+	struct cmd_param p = { .tz_id = tz->id };
+
+	return thermal_genl_auto(th, thermal_genl_tz_id_encode, &p,
+				 THERMAL_GENL_CMD_TZ_GET_TRIP, 0, tz);
 }
 
 thermal_error_t thermal_cmd_get_governor(struct thermal_handler *th, struct thermal_zone *tz)
 {
-	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_GOV, 0, tz);
+	struct cmd_param p = { .tz_id = tz->id };
+
+	return thermal_genl_auto(th, thermal_genl_tz_id_encode, &p,
+				 THERMAL_GENL_CMD_TZ_GET_GOV, 0, tz);
 }
 
 thermal_error_t thermal_cmd_get_temp(struct thermal_handler *th, struct thermal_zone *tz)
 {
-	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_TEMP, 0, tz);
+	struct cmd_param p = { .tz_id = tz->id };
+
+	return thermal_genl_auto(th, thermal_genl_tz_id_encode, &p,
+				 THERMAL_GENL_CMD_TZ_GET_TEMP, 0, tz);
 }
 
 thermal_error_t thermal_cmd_exit(struct thermal_handler *th)
-- 
2.43.0


