Return-Path: <linux-pm+bounces-13755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E796EC1C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B86B20CBE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397514F9E7;
	Fri,  6 Sep 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKw4EMl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7414A630
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608207; cv=none; b=HoP273itmakSBhvSZ+OGrbW19XRMUkJdSZObSYQDCg+z7vwCc1yM3FjmFkcSwuSX3SuZae0cGLjvGi3zkunNF2FME5kC+fYZkT+qPsijw6evIAxAXIFvtoMtMfoGOMPuLi0yOoaM8/Q4arCmlc+bm7Cq2rCuUOXi7u7pQvZ07Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608207; c=relaxed/simple;
	bh=jBaTX53Phst+hHnS5w1wtky5QWcWytquKVGEZ5GX7ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZsJC6Zhm8citokZBYFwz/iBSj1HCbQO1otRrBe9QIg07Kh90WPrCjHEdULYiJLzqcrHN9PZiz7Y5uyEL2bZlBCng9WTlohL5yje9Rh+qsWIVbe32vkZ3RWabQ2C3WOY5hCSk8wwSFWBVZIBaCsVWow7DwXIE5Q34SUV0OXKd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKw4EMl9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374d29ad870so911574f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608203; x=1726213003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=iKw4EMl9vxCsUPBjgrERQcvCPxgehhbEIZufJ9dyzF79GDsZiliYK+rtvvSMn7QWTO
         nTr3IX03r5V7CudbGBbHcvrqpJ52QO8T/AVivDVa9Dfe/fyM+7BOpfqrY+epMk0kMQi3
         h17Ucu2pLvbTc9BIEiJAqOcvbdOZ1Vqym4uJr2FU93utbpKBg2+jPe0CBTNLVR1X7ASr
         LHALGOkBKCfRLB9lBov4l1eIKlpUDFWhzWo89RvQhWCT/2v+y9Y6s2s+5bXHcQK3nxX6
         ut2vtSfhJC96K+HiZCHzA20blNRmWbtIitvMcTtkvvX+IlATfTY6Mcf9ykgIBLS7pT+e
         AqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608203; x=1726213003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deaZPEiz8FHu9sPVP9I3mxBXKzoXXYxNuh+Xqkh0+pc=;
        b=t73WZtnaZlaEdoN3kSlgZidUTebxc3twqv/PkPxgUnhtBjVS28TJPg10Hefq5ioWp1
         8B6Hlkt/KQBxCIyItb0CA2IYF6672acz/lbVYSiCBVoxD2DNeG1aPJm6jEX90lgKBK8l
         9J0fg02+jPsQNTNS2fqKIrfCLhwDnCJ02EbNQq/6G8vICCqRa7hbwuuxSwsGINOkb+ZS
         ISP++C1am+QbkTJcri4Y15I29PLQ5oCUh9FGn8E0/U0UMNcbKTCUWKXpEx/48+DVcOvh
         JUxr5Rwprg3dEQiI0U+HDbg0h3j2eapHfSuv/ijzQ6PHf+wjFlzYCwau65DVnWZdD6N3
         rWUg==
X-Gm-Message-State: AOJu0YxPgKlnXnJ1L8R2OdOzlIz6uFRjCn2pmhg7k0KprnUTC94u+A0Y
	6QlQrZT7+NMfkUDMSQvSXfwVjvffCZW3lWv7/7bWunE8VKJewnTCfAWRC2tLv0vvy/Tt32uv1Jk
	T
X-Google-Smtp-Source: AGHT+IEnjk39z9VNIUJ7UoFl2ceMVZKoFamJyeo3d6CVf5y4RBlxsaFrcrPF+rvnDjXy+NOEBYOS9g==
X-Received: by 2002:a5d:4f8c:0:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-378895d5318mr1094842f8f.30.1725608203500;
        Fri, 06 Sep 2024 00:36:43 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm8113885f8f.18.2024.09.06.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:36:43 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v3 4/6] tools/lib/thermal: Make more generic the command encoding function
Date: Fri,  6 Sep 2024 09:36:25 +0200
Message-ID: <20240906073631.1655552-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906073631.1655552-1-daniel.lezcano@linaro.org>
References: <20240906073631.1655552-1-daniel.lezcano@linaro.org>
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


