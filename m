Return-Path: <linux-pm+bounces-42947-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFoZAu+emGnJKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42947-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8EA169DB8
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7733005EBE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A62D3ECF;
	Fri, 20 Feb 2026 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7fiwkBK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIZZ5Jg4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89972F363B
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609798; cv=none; b=FnYskARsT24xbN/GTbAPYFqv4Yk/+WY8zqb0jQ8oD9rdM21Dqud9P9hDUaSlcM6amRbqRNA+VnVtAM6dfV2VITy0Z+0iO6PpJwE+g6sb99uLa0Vcz/PuaTuPdN5dAZUTLo8pxK3AxUzM5BbsDogFtsFBn6Jbov4FaxZfsbp0Oo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609798; c=relaxed/simple;
	bh=Wyke2HJepXYq8CbvPBGWv2GWEiyMQCdTJ1y+5sgP6Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1R+hP2UjW75Fle6oUUqNCXMpyiruPxnidb9JnG+ln1NCF9HELwTI7aa202Av85fco+x+bUZw5mJee+5IdGueCCLv5LQQcY7mu3nO7tRCTY3VkzXED8JqUZd/oejnVyx1d2/zwYkCxefmQT716K/7UOh25uQvLUJoUBP424vLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7fiwkBK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIZZ5Jg4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KA4Rm32219742
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Z50xNzkspgTZYBSnUsJ84fnJgETFf1Fl5T1
	VYAyIFcQ=; b=M7fiwkBKFhOo93A3yiawFn2K82ki9594RP6C9wsein+wIxkSJli
	jdNxIWB81w6X6/TEViWR3buTfTa2jWYFwdaEkVCkvT5dj3jGSrsab7jxbiGx1/Qi
	M/HWNVqHw+yFGETEnQ90cMhuO5NORQbr+r/CZvMoLn5cUhjdByJxoOxFItwfd8Fe
	QxjmQWwfwEK4HpafuaHDCt1K7zOt8yanO0Fe2uyuGeFlodsqNwna0d8renFdjnAr
	CyOxSXdmR5PfYvYIEHT7wIEVKrsSjHoHQ9nPDLmQm/TXZgypks1qK6aWBm6M1HBE
	Vse700jsSPtLhL1V46SdHO7Ps2SC6ZWu+kw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cenhgs761-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c71500f274so259275285a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771609790; x=1772214590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z50xNzkspgTZYBSnUsJ84fnJgETFf1Fl5T1VYAyIFcQ=;
        b=UIZZ5Jg4I10awiZfRtKqnNiLugNzl9AEMFSOnrJklBqVW5A55p/QUcfqm3tnBwjcf4
         fOSjNQn4CUfSYt5PQBq8IQ5+q8P7eImQHZorxBMJ4MS44L+oCOgPgOcwOH63VUBpHgOd
         VWJ/MCtyPvxWtQRot2toPJfG03y8/PkqV8HuD4/kSqjMQQc9hYPf1BY0wyhkg9idapmU
         mCQkD2sSm0686JvfSz+FT5V6Q2hnmV9Y0q+I41G9iZZVE7TbG6nbQSkwK9xC68YxxT6W
         cNeSukX0c7TbXQhbxPe2Fk3N3OyM3Okb5e/iYnpf02tSrzL27e8rxuB+QepQEpYrIXB5
         4omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609790; x=1772214590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z50xNzkspgTZYBSnUsJ84fnJgETFf1Fl5T1VYAyIFcQ=;
        b=R1l+CjOKZCoxVe3eh6/FBs4WSKNFnFZa4DYI/sbbIXJh/G3h5QHTEjj/cEJJwLBi5a
         vZ67hg/ZqWpji83SO00zcYu72txGZS2kGfkGEUELY6BcYU6WfFHJtxcnjDMEbOx3Dcs8
         Bc6EYxhss0c/EXiBB34vhgcuuTxMSN9BIgKdop3DgXdHLUnRzIIaTOTQ/Gq0s7EwCDk1
         jNlqO+P/mtQdRfnA151ik33RcwxNSLIJEVTNOIoP8K1wPzaQqv6RUGvb1y82boYir3vG
         3ndmkhRx2e3Z4ACtyA8kOYQe496JxR5uvOJftBF2j4TiPSBk2vJ1oPyoJJaW+5Xj0rai
         EndA==
X-Forwarded-Encrypted: i=1; AJvYcCUEtaCc1Fjyzi5qh5PB5gMgNzDxR5XCVezE0/fqPWSwZCNHhZqtdJQGLI87QRLWBDvU5prRYhejUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fhzAtMDIV7JJL0YRr8jNtPJLRSQpADwf8xFvJ2ueqJFef0gK
	H8lMzbXtkIfQwlhWWxURPQRp3WDgoDzOsDVtcr38/CjsPfdgrRDalEwCzbDKwWUIW9rlgTtD370
	InhPYbl8iof5y+jFcNaqyDtHUT5B1YiTE6omUZ087R1xvkMIYZHmxzfNtN+YG8Q==
X-Gm-Gg: AZuq6aJsWRTHg4A6ABOrRHEffj/yKWEHG8YSZFWIJtofFpDQO7I4NZVLMQz9/cultYG
	tk8W7f5fXEgPIrwd5JCB6G5UBQ7Ea7z75/AJEICzrcrXwoV0KxygoInS/g4nKkjHXaSF+yw4vVS
	GYdOmvdWXliHK0zsoTo1zV+XSNegQYyhg0BOKs9yHFKhHSxT3HVhObsksu14Kwf0m51IYbwcxsl
	kl1+EaPR5/NCEE7oErgeSJ6CyhHIf/KvcHkO/LDGU7DFD1RGAkGHGPEVvOAhx4CupgRuhGIL3aD
	XqN1nygvMY9rRaa+8UgNcuefVf9gqctPioYgsygnP+YMJxHsu5yCPicd3rlBIijrEIwjGmCy0cf
	BQUapI8Nrqlxi8v8iPLW/UDcoXGKTyp6o4TDpkg==
X-Received: by 2002:a05:620a:2908:b0:8ca:1dd1:97c9 with SMTP id af79cd13be357-8cb8ca94cf2mr46157285a.76.1771609789642;
        Fri, 20 Feb 2026 09:49:49 -0800 (PST)
X-Received: by 2002:a05:620a:2908:b0:8ca:1dd1:97c9 with SMTP id af79cd13be357-8cb8ca94cf2mr46155085a.76.1771609789036;
        Fri, 20 Feb 2026 09:49:49 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5e5sm54071940f8f.9.2026.02.20.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:49:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] power: supply: axp288_charger: Do not cancel work before initializing it
Date: Fri, 20 Feb 2026 18:49:39 +0100
Message-ID: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=Wyke2HJepXYq8CbvPBGWv2GWEiyMQCdTJ1y+5sgP6Dg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpmJ6ylv9PTBWJjIlTDepZd7RH8L4Xl8SThBfgW
 C1yU+7LJWWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZiesgAKCRDBN2bmhouD
 17R1D/4/NUK267mJFxuLAWQXAXpI+hDXHDEOnL55hIlQ/TKQuT84zzcP0f1Imup+9ajFEO2Wkw8
 6lruuzE6l1PBBKMp9K5FJw697u3YIrBiKUgUn2nvwlgGsnfVh9wiM6NE+XHFK5bTgAyhx4cIrZp
 Mc25IBUfyNrFZV7juo2M67w9hps/M9iTXkHXGyYw/K9vu7oipLgsvfUIfL8QY4I3IytO3xDf+H+
 JBxVnVWAJnPNK5mq4CFovT/Ul3MQOj+bMI1epufl9twJeayrkyS4XKFgJJcZ4CXEfp1R+SMQ8FF
 YrZI3d0vYNXQAWDDEoQ0gPSj8SS94fCbBcw4BMjYOy8+akhGMe9NkR1GTK+y1di+zwQeH5B4Env
 aH3rT4Dm4m/MChEWbDsU3TX2tIa6/2PcHSxeMckFAvsKapAdyJ7qRN07SfPjFxpx5phPMWzzY6f
 bAb661Q3PFtXkqJUCsjNEGeyOnds1iWEqt6CJ2hEEt+eMXS45UOYeQMLVK4t23oDVq1khD0uOnp
 7euIejrfD3LeU6Wm/e5wPveCm9fAeSuBuKpY7E/spgxf8NffjVXcTTfYUyih2rd0TGP8fI2I+HH
 HVw3hgQzpqaI/bD4CF6zbDQ1jrYWE5Svvi17cQdp9xa7KKfLK/zSMLBde45V3V5dXAh2UfB83yj NJdDeCjWWgqODvQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJVIilla c=1 sm=1 tr=0 ts=69989ebe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7jbrx-f8LAmcTEjaDCAA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Ze8H97FnUVmzYlvOQrkxhY_yEC-xq3B5
X-Proofpoint-GUID: Ze8H97FnUVmzYlvOQrkxhY_yEC-xq3B5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MiBTYWx0ZWRfX4W/9fcfJ1wTi
 KZFjSAdAsncFBuxK9MnN5n0R7sP02d3/r5X4+DQ/qlCYxB47BTM+53DnNZnUNcEiQDBivGdJv63
 lpXT4X8lYc0FPrG8Vsmh9VcinaAqUQ0Oqmt+N6fCogFQ/xobUuho90c7+LNBz/7AFjqWWpLVhIR
 A37qnC59lcnNDvLIoPkjTkU9KWNJsx5vJDeHtE+nCbWkZhiu34I4YDsizdeuQM+dKbkAQUX9tIa
 PVFOb4rE78cG+wJrbuNAHyOmoWWAbfewmnyqGoJLgaa1GKhAIvzaZ6YWZ0XYN7OEQF3Qois9OSW
 lhpeztIcF1e73mr3+5qs79zGDtxDyF9Qrtupic1xhKos2TxwlRh6ORmmO87/AlGrTGJnqat+hYt
 tJpozrAglduJKvgNnq0ydGyXA+ArgnREbRHI3J+gUDco37VRw/rzLfL7J88bF6gnPeoyqZtM4GM
 DRICQjoCcaH5hDtxdKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200152
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42947-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A8EA169DB8
X-Rspamd-Action: no action

Driver registered devm handler to cancel_work_sync() before even the
work was initialized, thus leading to possible warning from
kernel/workqueue.c on (!work->func) check, if the error path was hit
before the initialization happened.

Use devm_work_autocancel() on each work item independently, which
handles the initialization and handler to cancel work.

Fixes: 165c2357744e ("power: supply: axp288_charger: Properly stop work on probe-error / remove")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/axp288_charger.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ac05942e4e6a..ca52c2c82b2c 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/devm-helpers.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/workqueue.h>
@@ -821,14 +822,6 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
 	return 0;
 }
 
-static void axp288_charger_cancel_work(void *data)
-{
-	struct axp288_chrg_info *info = data;
-
-	cancel_work_sync(&info->otg.work);
-	cancel_work_sync(&info->cable.work);
-}
-
 static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
@@ -911,12 +904,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Cancel our work on cleanup, register this before the notifiers */
-	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	ret = devm_work_autocancel(dev, &info->cable.work,
+				   axp288_charger_extcon_evt_worker);
 	if (ret)
 		return ret;
 
 	/* Register for extcon notification */
-	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
 	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
 						&info->cable.nb);
@@ -926,8 +919,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	}
 	schedule_work(&info->cable.work);
 
+	ret = devm_work_autocancel(dev, &info->otg.work,
+				   axp288_charger_otg_evt_worker);
+	if (ret)
+		return ret;
+
 	/* Register for OTG notification */
-	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
 	if (info->otg.cable) {
 		ret = devm_extcon_register_notifier(dev, info->otg.cable,
-- 
2.51.0


