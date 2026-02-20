Return-Path: <linux-pm+bounces-42949-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCUCNQ+fmGnJKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42949-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:51:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A1169DF2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5D7F303EEB4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85836654E;
	Fri, 20 Feb 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocnfj4VW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E0Dwl9ZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F574366077
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609800; cv=none; b=TENkcDgqTYWu3bxMmk9EYCtPoZ91Vga0m/xLH7l01Lqbkl7NA3vfJSu73pSb0H3to5DQw0I7l+9mkDokD/oPah4McrjhRU8rxKD5tnm52mOkcpbegHdkkow7nfZ6Dzq21/fX49dv6SpjDd5GzRB2WoZa76JmzmDhFSaws7omS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609800; c=relaxed/simple;
	bh=FpTNP+/xrhawrqj5rMc62e0LDh1croH8P8G1MF0q2NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsJ42/uUGpoPjruf17YlCk6Y0YEElwEAmKUrpXUpwhlJz2hZ5id3682T2crSPAM/dnwGCRc/0C2TyIVRwLinW/a7WCZxD9ui+eNGhb5/a7afVzkA5FD+ePt06XSJbuOfl5O3WnMsW1vd7fFyGYJdti7rHsTmZ6t4CAtXXM5XSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocnfj4VW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E0Dwl9ZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KFc8Jg3698940
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=02PYs9qwz99
	oYgCLQtVuPS4RYMeDUq/hf+3L4GhLo/Y=; b=ocnfj4VWjsJjYSESEzJqOU+rCsC
	Uk6iGr/FzMOZ9U61eWwfevX+QFtsuPEeLR3DC0+/ot7D5x4vD9/Q/SgIzvfSmQPN
	ooQIv5x3Zpj6+ljzxMLlMSuVdfeJ6jN/3s5h4IodBm68e9ouH8Gx0rqgFzKnLYQV
	4lwIIG++Mh8TmMau39huc3MshieQ76aV1SbgQVNm2J9NItQ21t5/xw/1wNUWI9MF
	Nm/n0/ikXMlQeVtDC4IJLywjZPCEAdHVzUt96Ykt3xS9d5FulPHb7vWZJBVuvq62
	gI9TOckdX65fonGrnKeSZlGyv6sOLGSh/42Q7lVIvTaxtDVHVagw578yKFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh5jhvn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c7166a4643so1910736085a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771609792; x=1772214592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02PYs9qwz99oYgCLQtVuPS4RYMeDUq/hf+3L4GhLo/Y=;
        b=E0Dwl9ZKlC12p2rJVYUu2yrksQW7VbJkxj9RwS0D/bpZYN9dzabkAHodPWbUW0wW5Q
         KhZwklk8m26oTqCqXbRbmIyasodahtC1jctMp06KmNHYZbugIMph7PVKtTFhIYVRtGX3
         oIEY3X5dtEQiGXUBjLluvhJWP2aswBvC8anMTOjPOBN0khL5SJVHBRRUX3RsrqJ2DmG1
         p5yLP0GJ34RUAM6ko3RIEaUifMopr1yWdiCBog0vGdPIplc+wG1uzjhfysrHvuutSE2t
         AKqVDPGH/ucb2GZWKg/tL7VuKnwF7z1lOXCm9ISNETm13v8giQCcE6OAKPs+yv1gZUK+
         JnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609792; x=1772214592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02PYs9qwz99oYgCLQtVuPS4RYMeDUq/hf+3L4GhLo/Y=;
        b=N1oquMwZZnKeNzDyEWmcb1BCPAM6W6XdTpoEnjosN7Uv6w1cJ62oF7VGxXE00gid/X
         TKGEQgXtConopKVfvUSvFF/ZPr7Gna1RT25x5sOQBpJ+MkOv656x/s0ia7mfryhCMMIb
         5739KpY4eyOAtZwEfBmeM6FHCIV2LS1RUrjmkEHjmdK+mlStpZZWDXKwLsO+g+IhNkq4
         bSiF4gS0Q0F/8EV/KgexMrPc0yOgGXuxQsjqO3B8FgeIEctgT5CflZllua5LbJL/ch3N
         koer33gpatyPR0nug5XQ3+dv4rcUlBTKugIWhRGgWwT7h1IpMey5FXIPDy04kyHEVKQZ
         lV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVie0UkKn9Gn4PJTxs54Tr7UUBQZWW0CXETUkHve33O55d1TrUeriRetH2w777iD2sdi+5gg6bgTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlm979YvrMDekMAbDDdpgch8smjjzGTVNcQvpzlcz9j/vfKJwj
	qT4USYbTpVYQW1fV+2MjD7kdy8UhiDjTC+Wctwv/xstAv4ESYsy2XB+agYdcQN+4v9wnVU2WQkf
	P1DJH2vFkeLfZpCXWytxkVcMlPvr4ahexGeELqGLF55TaxCb/cOYHNCc3QGRXpw==
X-Gm-Gg: AZuq6aK/quSEdeu0KAMM8UO3aFf9ijM+eSdMxLB0cTy+LtDVLi9BeKO2VP1HxbjENgV
	7zq6xi+V+5+IPAmBBHM4l/ZN6kULw7rOkm1JxYwABMYkiJWwbPW+ssiWRcFCkJ0tqdmVC6FGP7c
	FYp0+haB/86b20rYq2Vqkcvz/hp04G0oARm06xXEap1KEgtp4CJz2hBgG+gskgY1TAs1335yp0O
	KsALYV0f/B4wgfPv3op98mPEpHJZ6rO6DEGIEzS8pnHcsWTRJykRyLxPNmng7AOSUbE4cYPb5Dk
	v4rg2BFhZ0D4r6K4d+O8J5+j6X7okQpt0VJncG/PygAbWn+PeZR4flgELzuky/otW/oHahJ0v3h
	v4eX7k9UMBR7UO29lGw0J3/yrvD5uGtnikj5tkg==
X-Received: by 2002:a05:620a:1aa9:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8cb8c9e680bmr49019585a.14.1771609792499;
        Fri, 20 Feb 2026 09:49:52 -0800 (PST)
X-Received: by 2002:a05:620a:1aa9:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8cb8c9e680bmr49016885a.14.1771609792081;
        Fri, 20 Feb 2026 09:49:52 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5e5sm54071940f8f.9.2026.02.20.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:49:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 3/4] power: supply: bq24190: Avoid rescheduling after cancelling work
Date: Fri, 20 Feb 2026 18:49:41 +0100
Message-ID: <20260220174938.672883-7-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=FpTNP+/xrhawrqj5rMc62e0LDh1croH8P8G1MF0q2NU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpmJ63Lp+BEwinx8QX+jqAkbO9cnYynznF7WyBS
 DSr84KvLsKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZietwAKCRDBN2bmhouD
 16bYEACDtIrTEwsC+wvnJ86BdyqAtHC6Gt7DCilVCV6OGBMEodOXEdd67v4U6rC8HRStlz0CHCg
 vDgk7XHWFqZ2mLCBEn8WwR7NkZn7oXN3VG7FtWPsnIPL0ZGU9hIynzuJLOX+buQ+cWRqh9fmSrG
 zHG281Vr+cr+FNFX+MHsOuhDosQ69yyXIB5+Rm42/0XkmtWtXJJl0BwgFs5yQ8/p2JYFAGwdOjz
 JnxfY/ItTk0KBcCu/aZ2C1dN2ugRe30uJDnpJIzuxjj6LW0ItIKh7875ChGoZcZRPisJmFvPQrR
 g8BMRsvKjVS0IB9+cNRDvCB2x0lRK5vmENpL94qNeCqvSNaTM2OGAClPd3k/p0YbcQUYeyLpGbm
 XvhaLQAvxSwPGCRvKA7+uPP3FyRTCxYsL6ydxXq5IdyG5fYTJW9Vp3SFGAqNW0km5glxGFjYGB5
 wE9onacmZF4PTBz1koCqsvLto3d91wyDyfVctd65g/a7Qcu0r9DpeBmFT439cPDxX0kFIZTw8K4
 qiW4rcLfaOcS5m1YcKLkD8L/sMB11ydgSFhEMmvp/TXWYIw0Q1Ql20pqqtlHBLOs+qJm0kAxmm2
 Rv1bPtfU/gNFCqc4aQXoZNBztK6xzKxMrqYs5/Tf3Ds2hINd8qcugTSxF21/vE/VNH7ZUQoAuSr H7AvPhEue0emalA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Raedyltv c=1 sm=1 tr=0 ts=69989ec1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=_DSFLL94n4vPYmCQlYgA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MiBTYWx0ZWRfX6eNFfNov3W+G
 clX+hJjQs1eDnPWnT9J3GErrdr9GsuAMdtO4zsKmrxMwYzCcsKPXoN8tLgOiKEeDBJc0L7r4CVC
 IwWRqoSs+Lh3a1WW3AkfK5bgHrXAwbZdCsRtIj8mikUr1+UiqaI6qGka/4HgYqIi59fGCfcGKIN
 aGKpH07Xh44QEhXkkIMcC8D/whfv0k9hVBbGH8Pq6nl9x58DwsO+xrL4ULkF0oulE98rCDFQQXC
 j6vzEyLxQFTyoL5tIgVo3KHunNGlOId8L/EGgrmzEynCUwFyoFDarLoKpxREAUmQYvTrxzO8FXb
 i5p3fg0sg0Zsl7jT9gdNJCKSd8JrsPZd7gwBRqRnKG1lvZnAlOlxHALrePXtEpbaony6VK4HUvU
 LpJ901XgXTRxtY4Jmle8hqobYX1NhSHba1WDqCsSSarwDBdM2LigTYPfxRywiHIquaPiUKmo5n0
 mDHwnpGZSSOF5H2ZVmQ==
X-Proofpoint-GUID: VkO7JFutjpQSz3ozBWwW2gqDuKt0AyDh
X-Proofpoint-ORIG-GUID: VkO7JFutjpQSz3ozBWwW2gqDuKt0AyDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42949-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 960A1169DF2
X-Rspamd-Action: no action

Driver initializes delayed work and then registers interrupt handler
with devm interface.  This means that device removal will not use a
reversed order, but first cancel pending work items and then, via devm
release handlers, free the interrupt.

The interrupt handler does not directly use/schedule work
items on the workqueue, however it updates the status of the battery
charger which might lead to calling power_supply_changed() and trigger
chain of calls leading to scheduling the work items.  If this happens
during short time window after cancel_delayed_work_sync() in remove()
callback, the work would be rescheduled.

Avoid this by using devm interface to initialize and cancel work item,
thus having exactly reverse order during remove() in respect to rest of
the probe/cleanup paths.  This is also more logical and readable code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/bq24190_charger.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ed0ceae8d90b..55da91bacc3e 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/power/bq24190_charger.h>
@@ -2087,8 +2088,11 @@ static int bq24190_probe(struct i2c_client *client)
 	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
-	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
-			  bq24190_input_current_limit_work);
+
+	ret = devm_delayed_work_autocancel(dev, &bdi->input_current_limit_work,
+					   bq24190_input_current_limit_work);
+	if (ret)
+		return ret;
 
 	i2c_set_clientdata(client, bdi);
 
@@ -2198,7 +2202,6 @@ static void bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	cancel_delayed_work_sync(&bdi->input_current_limit_work);
 	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-- 
2.51.0


