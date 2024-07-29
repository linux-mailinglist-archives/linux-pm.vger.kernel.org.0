Return-Path: <linux-pm+bounces-11547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4AD93F901
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2847BB222AE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519E15820E;
	Mon, 29 Jul 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJJf0WDJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B94155A39
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265420; cv=none; b=Ha+X430TULtuKpkTIiSvxdNSAysD/zkNnx5FUOQdxBaT3R0itHdB38+DRsgFAOktZvPEKpZv1bpvCKdzF+b89jzwkMexSlJBmuBgobOa8tJ4Z1xToeZOyD2OsyTjEft+7Z7wiU6QwQ0fWDZ9noZmJYJJYtRHn/c+aO8emhxr/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265420; c=relaxed/simple;
	bh=jBaTX53Phst+hHnS5w1wtky5QWcWytquKVGEZ5GX7ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLV63mFK3RIGWUeeXC9cn40NG4pKT4dAxC9EKbmMSVCM53Lyra9Nc35xc+B94rLNOFoPM5zeOuDH3okXzE6v9ZxZMDxHMncu9rvDmaVd0h+9WdIy5+MuKelHsU2FIRgnZtr4PnrOpcTogVjEdX9K0qAJYeLwijJ2ZOZIv0xly0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJJf0WDJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368440b073bso1234125f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265417; x=1722870217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=AJJf0WDJD1JdV/phTN3tjO/w/kQHH8qG9Ctws7eo4+2XmodRw5hjrQwxylCYNHTmK9
         QVEb+7/bsYYFMJ9ahQyNBEJW/DMHTOOj4lFcFWrei8NbjQZ9p8Mww+a8IIvlcchYf8Qa
         Oro70n6txLO0fC3toYzK+epwVlSv8PfnW4UuBfof+rCZVRW4AMOqIlIKaacasmvQcl6s
         tZNyjCGb8sOrZAxRNlOavQplQykFwWTu4Ga8xMZJUgXMGkdAsbL5ue4LBsVO6mjPruqk
         4718Z0QC7TKpbAqNU3Yr5fKxmwc0qvHFA70uqNcE7epgAc0EzUlseFkEkk6CxZHQTBar
         3xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265417; x=1722870217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=SliUrXmnIbNtDQM6d/uCpPNeu1hW5tGf447f3pMOpE8BLO2b/N6wSz9erC/opt1ADK
         21DaU11xg4fm3pyW1TIU11cPRb0gr0jfI5DeHdT465TkG7L7OaZGC0M/189HA2fBqcVl
         /p94fAi6aZ4funFek05uNiOkO7tuTqBAOGuNwd4dIK2Exxq4M1Fzm0ZlRVnSbDSb/rw7
         WAbDjks685OBldH82/Gk1ZeYzdzZO9un/pWksJssZzelBE3uzlqlHVgpp2kbsOIpAM7m
         mygaVDetcG7SiKHBO9OpNCW+/ZTyIlztHVXiSdq4A8Y+tNY6ucsttKGrjN3NhzWjEyMY
         zvdQ==
X-Gm-Message-State: AOJu0YxXoebZjvmXYwD4ye1s+rgdfAyEDesIQjme8thRmgCkcwsYj5D/
	0jav2U9uVxXkroE3Ubo1tJz7xuJ1El51UobWlOvmLwmwcEVVrn7fV+uipqQRtBUqybSS/VaPXHV
	t
X-Google-Smtp-Source: AGHT+IHShRMAWa6spcCLlwXE7Fb6x1EzSLqLAqjsL0bp2ZDSmqkM/HJ9kNrGjNEJXx4T5pc8fFaPaQ==
X-Received: by 2002:a5d:6181:0:b0:362:d7ac:ae70 with SMTP id ffacd0b85a97d-36b5d7bda53mr4702533f8f.5.1722265417450;
        Mon, 29 Jul 2024 08:03:37 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:37 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 5/7] tools/lib/thermal: Make more generic the command encoding function
Date: Mon, 29 Jul 2024 17:02:54 +0200
Message-ID: <20240729150259.1089814-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
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


