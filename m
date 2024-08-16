Return-Path: <linux-pm+bounces-12317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334B9543BD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D8285F57
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0612F398;
	Fri, 16 Aug 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlbQKWE1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F012C49C
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795971; cv=none; b=hZhoVlLZcFT3D6mXr02RCN3oecoqt0LrNyBCs+Vf+vuDyi/4lQYWp90CZOc0r94800QKePiXT35phIo8h1VPOJ5dnWWU6ZXr4WsxiJMvCB76GoP1WJclRuzqPF9RoezEfNszHYe7JsLpF3kS8x5Om26hBxU6CpK8KpXMH0FlXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795971; c=relaxed/simple;
	bh=jBaTX53Phst+hHnS5w1wtky5QWcWytquKVGEZ5GX7ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+H28fkFmagPj5FyubZkCQoZdlGk3NDdxtk/ELSmS6zHsKJ0MP4aqI9228u/UHqByglhtGqyXQUK5EwJCYlkymFG2bQfqtn2LTOMo1vLLbKy7c2uxd8NGyZ9NLbLrfEDqCLzpnZnXUc0aZMDZdtXDugodVPC9ZkYzs/+iH7pHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WlbQKWE1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so19075431fa.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795968; x=1724400768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=WlbQKWE1ECF9a0Oq4oTv8vaDkSwmUWz82D8fx7FEsO42fESsU+HKoGE52n4qirXJeg
         OFG9UFqX22FtlDgNuW3BfoM87toWBtgmXh8LolCgbWJwS65DbaYUQEOKNPW7iPF0s5kc
         KzVDwibweDCcP+pvDBa8klv1s9Yv0dIZgkoM3BajCS2ThgOSOM8lbNMmhz/huM2iuzhe
         B+aC6OEk0KMFY//6C5Gaxqm7Sg7Tl4iXS+ckxxnZSIS5gtKB74ZcxbAo668ta97gQWnp
         HQv5bDwEfzPLZQbzpLu4WKljo0e33jus6AeCs38dMOOA3n5yXQaTrifjwVjReO+gdsMC
         PdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795968; x=1724400768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=Y9px8xvvBNb5X75aumatPaCflCao1EDGZ/Nr2XuDs6VH+1D+ZlHbytIYbJNNBA9BOu
         iv3o9e3PQ+gcz+RFpUtujQwj/AQfDh910+4bjawTO++8I0JeG4iTHgOd57hUEq9yjUYP
         DzTL+bcq20Cr0hAIiN+504/SlfWAIywM9kohQD9HINmTvfRb6DLtxA5zdYIc7W6V4/rh
         x8lToRg1GoHvQYsICknpTekl1w00JEct8VRb0o6G8x9vYRM+dAQ5pNDiCPoSMjMABKnD
         T9tAPWZgnKTTp9jklH9Vu1tVJS/rdVxuPedvhWCiRu8jdVTAAel5kxwEbvw7yc5/5DXt
         m73Q==
X-Gm-Message-State: AOJu0YzYK5jHVfpq3NTo4oOoh/1TdaTZURrOi1EDyfkvZW3bKaLZz35P
	RJERQkoBLcFni+8qnLFFNpg9q/3eRMw5fI5FGCzwepsaklO5oM6ICTNjb67uIa4/X1cqlhyLZme
	tuIk=
X-Google-Smtp-Source: AGHT+IHcO0hz1OM/X0LRknRDFQT/LCo8CrbGPbOl/NjVvg/n3iOjAnbbWI8CzCWuv8DqyOtlZGwzvA==
X-Received: by 2002:a2e:515a:0:b0:2ef:5d1d:773f with SMTP id 38308e7fff4ca-2f3be5a8c4amr15414921fa.24.1723795967679;
        Fri, 16 Aug 2024 01:12:47 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:47 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 5/7] tools/lib/thermal: Make more generic the command encoding function
Date: Fri, 16 Aug 2024 10:12:36 +0200
Message-ID: <20240816081241.1925221-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
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


