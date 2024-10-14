Return-Path: <linux-pm+bounces-15608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936099C61C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28177287995
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE45156F3F;
	Mon, 14 Oct 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1xhI1BQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3C156F27
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898999; cv=none; b=FwAFLbxncXleunD1umIJeD4aQMbwsgfATCm07FdyWOXGAhnVw9seVgDs4ByV5WtI57kZbwADwY2eyy45z9/jzBuDfr2xJIpRZiGJDUOuKcdQeJAkxFTtXhd7PTAOlLxEi8FuDViJsqPrXB4vJrzjSXd/Rsfpt0bamJA42w9vHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898999; c=relaxed/simple;
	bh=jBaTX53Phst+hHnS5w1wtky5QWcWytquKVGEZ5GX7ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiqHW9c5j4NhNRl2uYFypTRHLFhKtPvcXry+OIaTzWQW7rIPtfxX5fecgaAgbTiwOifDkK01p4LEt3IQy708UWkLLlg/Zk9Zl42YcEts3IiKGi5aZKOD5clBTO7tgnpG1WI7n3Ga4a68WJ5EfZxXpTDpXeWcG6G3khPvvFJKGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F1xhI1BQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2959104f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728898995; x=1729503795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=F1xhI1BQG38Ci3DQ7MDqkVjSLJMgTQLeI38b5Y1cxPMnkaY7CDJT+dn24nWk785XGa
         mfaz+D/NyzEu0lz7dlVzoTv3GcPEl6/OLl6sHSAnC9OGVS8sTJDMoDM1Vq5AOGcI+/g8
         PJ1I6OqglM8q0wT9CGxppap/yTBmDKEJpnKvjOHVo3kOLt+8cvxDURJFpwnykKKvems3
         mD4vLQpBWrJ5Zue7JrS9punpiHlsAwaxFhaA3iI/IyOMy0eN80lyGzX5DdckYK8XneVe
         FYWySgq0HDP6FgBykBg66xl4rcDOz4Ip8gt9ry2WyddYac086BvIBIhhrPOW/O6dqnVE
         qRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898995; x=1729503795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=pQUB/mv+1pwY6kJ4INXAvVKaOtBCdzVcGz4Sq+VYhi1pNsSJehCYf0r/S7fzS+Lxg9
         Fx54BRHE8SwyO1v22cBVDHisZW6dUqLMQU7ZwjLi5cGJT7nYoNuDXR59PLWp1L1vHyQZ
         2KUNDlcqA+btb8l5ZK6TE3bH2Nr2ij9EdWQhEfh5rGYjmzovNtAVAAHw/DdVfSfFlVc7
         KNQqtuEjt8PtCDSh/loN2XnYtGdeqf1mkoa+mx5o/60L4CS2sPVKWkEN/Ofm6cxCYW+V
         KTxI6SW+W4C/17xshtKZmM3NgghVj1wcEt1KxJpM+FxeZe0P+KnQU1cfM31f6dtCIgAx
         eeXw==
X-Gm-Message-State: AOJu0Ywwvd6YDt8cwWuAZORINUrW8AtF5u2YVA+TC0FndMv6d88Wt0q3
	P8YGucqZltPxUO6CLZXIdg73jKmRINZol+f/P7jpUoUNZ08tTJD69zmQ+4QC45pdL0l7vg7ccHD
	M
X-Google-Smtp-Source: AGHT+IEWb7k669GS8/0+8DSqaPo5mUNyMWKZE0WFobbMhMn6BO8cwjfwkxcppmAuDTQj7UvnDdh9DQ==
X-Received: by 2002:a5d:460f:0:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37d551e0644mr7376977f8f.30.1728898995375;
        Mon, 14 Oct 2024 02:43:15 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0203sm10935840f8f.57.2024.10.14.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:43:15 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v5 2/4] tools/lib/thermal: Make more generic the command encoding function
Date: Mon, 14 Oct 2024 11:43:05 +0200
Message-ID: <20241014094309.1430126-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
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


