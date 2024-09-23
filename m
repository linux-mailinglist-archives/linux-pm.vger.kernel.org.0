Return-Path: <linux-pm+bounces-14561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0497E934
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D3E1F21EA9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA5195FE5;
	Mon, 23 Sep 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foMm+X3/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAF194C6E
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085616; cv=none; b=d9PGSv+/9lmVKSyHmSE0XUyPJYHzFChfgGztaDlDrrIlbvKVLyb0oByRgWP/Rtf45aLy4FuKw49b6F0NSaMDuQzWjZUZ/Ub4ogKeR8/QfqcfeAMK/yUvKJ1VBn2iAOuiVXrtJDyOT81tAgQfTVJNQYX9fd1/RYD37YbiT+9eY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085616; c=relaxed/simple;
	bh=jBaTX53Phst+hHnS5w1wtky5QWcWytquKVGEZ5GX7ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BChRIY6L+m4V4FYJpPMxXOuSn/TZh2FwQl7007n82KO/sO3T5kKKTqoKPrGMfDTxgT7agtgBv0M8+emTQDyAu3Cn+2S8zaZzF5xpa/wN//0OBUom5j7p1m5z+llauGuwGPODHcxlW7Z4nv9LbfJtIeZI86ld0ZyfTJ93W47CGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foMm+X3/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c326c638so2296794f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085613; x=1727690413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=foMm+X3/F1d6lfC80NTe8P8F9JCGjpnXmnayy3/yUwsSz7E87oAB8FqEVtoNO89HES
         17vRZz1Gvm55/GMkvngVZp2hC88CXIcieieCrGTmSJ9CPFRMpV474y2zk6utVe6/10ci
         S+gOIpB87kZiRv7xwkKQQIGk98eNC+k8doitnkcB/RcS+QNVOGV79Anh4CByoDh3gJli
         L1l9FdT/02+EGkNpOb/BI2wCqEp3Jax4iYlfleieo38QSexQZIkac7L0I/csZk8vhLHK
         rDfUiDge6LVJBgOrRZVR6fpvVpaL6CVy4FhK8WLgU2tC5Rxz+WZ+DRWzHMyM7lFAsA58
         pZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085613; x=1727690413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=kcmWUwheWC0RAFSl6PwS/AXArhmmvc81coeVAtCmv02Z0g5hiylG+zznPlDK2DsTvf
         KzxqKRY3jXuCEFdr124BZWwNp8DTdDuL9Z3l8ZF4Zq7Xa3hnVZugBXLABe5gb5XDVrCH
         n6csLd2g9q5AkUF8CNi4ayhtSQQ8hxMnvzTBhVjNIUacR+2j3Jev0GTg5jTcEpqyILfA
         0U/uASfELYCzOIEmktrb8MWdj1jT6i1pdkx12Z/0NdICGvSEhcadB6ytZKBoPEDMRk8o
         BmAAAQNssHgbxWj8RcLjeDatePWkussmQHrAZaXAitiQFydlxlqD4kgRwfGKsTeLEipt
         WN1Q==
X-Gm-Message-State: AOJu0YycPkjpH355JU+5LMQ93iybR94HQ0WDm5uu16IdZyEz68VgfwsA
	woTXXkcpfTrMOqHlLh5QEL3PPMfgvZjp3H/ZJcGFYkQYks9iB4HPwRoPtuGctSo=
X-Google-Smtp-Source: AGHT+IHPqUeJXNM0nWjuvXLnmg0xECnAAmNrYRnyvWunsIb2Di5nRB25HSWfta8Kak3jTQgqSXSAyw==
X-Received: by 2002:adf:dd90:0:b0:36b:bb84:33e2 with SMTP id ffacd0b85a97d-37a4235a1d3mr5397014f8f.37.1727085613105;
        Mon, 23 Sep 2024 03:00:13 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:12 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 4/6] tools/lib/thermal: Make more generic the command encoding function
Date: Mon, 23 Sep 2024 12:00:00 +0200
Message-ID: <20240923100005.2532430-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
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


