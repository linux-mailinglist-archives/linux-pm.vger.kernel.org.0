Return-Path: <linux-pm+bounces-37681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B218C4407F
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65084188C6B5
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75622FE066;
	Sun,  9 Nov 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hK7Y9mgw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zd7FfbET"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFC2FE050
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699104; cv=none; b=rhPR4JtwFORXr0TK/SjCXSeBPb9aDnqxfnyp0qAvEjmCk+JjGSLLMjU6SHJxWLg24cK954pOhF1U7ytVbw+MswqqJtC8oIEfQb+ZbL5Zc+fwDwk05XLfMGEBKfTasAkrNQDPJbWaIXbEfLhNlY5wSDJ396CdemXOZYNP43W05zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699104; c=relaxed/simple;
	bh=4y05tl5JnFA8b6YlLDdx12ZxapyYnXQ2xFk7Mn0seVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPZ3vveIdc0qSLg+MzYCDtoVKTM+cQjdEc4VpBzspcmh54c14MD4hDA22AV315p421WKkKI6sGiKDip6BIDbe3L1yRU4X4qjlwxY35KCIzn9ZBdJ0DLu6rd79i8B4mhaEKn2YpSZdYk8b0Hqh5LyuTTbIHKbCTyShRpPChC7b3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hK7Y9mgw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zd7FfbET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A99ERve123684
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uo7LT6euvRJruZtdgnGKAy39fSD8X4XwSTTfUk+1bv0=; b=hK7Y9mgwVQzAX85U
	htBJKQO4Xl+Ik2DPsS/62bLQLCpinBmOMA0olTpoJHBT98/mpzhRX7iXO+bP+be5
	RLi7KiUyf06rka11Oc5a1H7xn4mrHdocQgbCtZ0RML03reAV2bSQI7GFhwFrcLat
	7mwZK83txokPi+WOCLM2nFP2N3EtyUBzCKKul0BKbpCMWWdmxMKcIkqTyzU8KHZr
	L8TucMeJEVCz0NyH7g5XSGnMo1ejR1hs1pQwglrhNYXs99Ghay7isbinaZmK6ZPr
	XQaWZr4uiv0XGUoBTuRhxmUS7nKraVgNuEtfg3gsQ0fStAI8kFe88v71CBoaEWlQ
	ZpV3hA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a12sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:38:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d75897745so5092041a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699101; x=1763303901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo7LT6euvRJruZtdgnGKAy39fSD8X4XwSTTfUk+1bv0=;
        b=Zd7FfbET6k7XCfGOmRVRpf9PVPKSIT3laR2pBURCr465w5DZU7y7Pj84H3PFl8y4is
         hvQqL8cDomQ9ssFTAKS4Yi0HH11qly+ApD19aS+lBUeyB1DH/aDfqtbqa93JCZLr0oX/
         uUD80IUPh8p8UatS2Q7eOKgs8M4mpRYhqpU3TUwChRNVzmg9JHphYTXmy1oyx5Uxe6i0
         aH22CKGcQWoZIwC6etiJ0E6fEJfLQk0Lc/UeocnMOHzy9uGZho70p8WoAwWXrKsKfRSL
         rilvWt3VIn/rtZfqum2C1JvC1MsVvwRc4o1zWtVEwkYh3BOSr+sp4ZCipjtsBb47418d
         Jh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699101; x=1763303901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uo7LT6euvRJruZtdgnGKAy39fSD8X4XwSTTfUk+1bv0=;
        b=jSRNNTOaPopeQUCCQ5D8ELi3XV6l0O8uwwlGXbW8HgWvSS5V+wtICOWn4xFq4VTrjr
         fVEcxAGqM0cSynYBWM70HXhzvmZfQra9v60hl9nyHsP7CT5Uk+o5x6st9hB/tjvm6NZu
         iEs91Z7cr1ODXIRcAa8d4VuCBOl/hA4cqjuOFJqKd1CzA+vk8uDfm2UMAEa/HxmZZh8m
         m2Ae0Xi+RwFzkqE/Auw3KzsYI8IweY9sy8XAQ5Sdw/adrkm862winkigiJlNns8Rw9u4
         WvBj7gGiYGhacDvxHe0IQxbo4m3Aba1KGuZ+cMNID2leY3dhJb55fjH9K3/gHLvIvAY9
         Z/kg==
X-Forwarded-Encrypted: i=1; AJvYcCW7IEvBz/25+hCNLqf0KyD/JV0c8UKb0kapHwe9Ufwf2koQE5AaDUXf+UrkfLQDydY39akOLUwLUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+rLwHgXnmQlSGgucbwCqnGNsWaAFKrA22GbtA3KuOprI7LS6
	q6GqBdHb16MU3EGy9SlKelZSa7vDFU3TJkrMQawC5b/KmeWEENsOuGtHCfYs+R4uOMuzx9w7F0t
	mZ8bnEV8tJlZKhl6bA5yBbtiNWdZWFUsbndGV83priORnoNKHzVoXz0F5UzxyyA==
X-Gm-Gg: ASbGncsNI0UWOARjzHjkLji1avW3RUQrY7p6omiHEWN+k36w8o+r0r+VjSyE1wFCh0l
	LXSNalveqMZuQ+R5QyhaSUe9v1yt8x6PhUFo4jT067TMSgDMIReZNNECYF9urRFKeMPSZIwoyu8
	yHQjduuWkkJZ1uX32cMHfeQR/pcT+UZ8Gr4D0ljS0x3ZE7HZbYK6A7C7aN59rhDYp4Zfg80baca
	jwlwPCPnkYmYOGQZAdA2nffXzaOFYNxBJmgef6/eupsQaFz5jldqPAuGr/U0Ejw5BASO4fwXWs9
	ehJ64LZyB/zUY1mNJAYtPC4wouNZGfVZ4TUjY7tz9oz/fgV2hA/hQVOH+Z7NKsFf9RKK0TLD9yl
	c6eBKkujUbgreIju3SjV+eAXqUCZQXJ5Z1KI=
X-Received: by 2002:a17:90b:3811:b0:340:29ce:f7fa with SMTP id 98e67ed59e1d1-3436cb7ae1emr7571916a91.7.1762699101144;
        Sun, 09 Nov 2025 06:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGnivRRM8Xz3flnELsFAmipMGOzqr6JvqifyyUie4y1Y4jWQDfWv+NfIOTqq8B3YWWPWAf5Q==
X-Received: by 2002:a17:90b:3811:b0:340:29ce:f7fa with SMTP id 98e67ed59e1d1-3436cb7ae1emr7571881a91.7.1762699100638;
        Sun, 09 Nov 2025 06:38:20 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:20 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:15 +0530
Subject: [PATCH v17 02/12] power: reset: reboot-mode: Add firmware node
 based registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-2-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=3351;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=4y05tl5JnFA8b6YlLDdx12ZxapyYnXQ2xFk7Mn0seVs=;
 b=vs3wqeUOLeic+1W7I0EI8aB6oJC74eGyyuuemjAP54LQwPmCWoLH5jWQiO+mDhZeRaIXg4SCi
 FrddfqAJhKSDh6WdKIQCfUpid1SYartnJ4tBNv3Sl8dK0paFII8Fg1Z
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=6910a75e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yMQn7kocbCrLHgxSFm0A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX05CZF2hc400B
 /wZjATOXHZl8Oxp2lx6vfoPH21maMS1DgikveucX2TBNY3L4ihHvqna5jad8lKzZ2WwhGGh93RF
 V1ltIxtOWpkVwJsKEBFHxFKJgr2ppAlFg0lg6EZGp3YEeyYahgjGW+pz7/6B2s8A8jnIxyNrV1t
 bb8wsDjsD7wZbXYN4Qo7VEj0s6iEslL8Vz0/8z9hlEjXfH8sFSSB3F9sab+GFLspUZsZxvMtUfP
 hF+kPe06RbQHrRA0dZJVSF1Fdp53xHFFxXjB0hV25K+3BTOUsK8tyA1eemdEAwEgVtsJiK5a/S2
 1pqW4EYLvWjs+CNW/Rj+egLAO5lEi2IxVI2wKooeKkhefImYHz6xpa9PyLVdOoiwzY7JHZybQqz
 p4OSixAQUQdKOKFEfIrWyX+dc88NYA==
X-Proofpoint-ORIG-GUID: P_n6mv78ZTX-cU0VCYFldSRZZiO6wVeW
X-Proofpoint-GUID: P_n6mv78ZTX-cU0VCYFldSRZZiO6wVeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090129

The reboot-mode driver does not have a strict requirement for
device-based registration. It primarily uses the device's of_node
to read mode-<cmd> properties.

Remove the dependency on struct device and introduce support for
firmware node (fwnode) based registration. This enables drivers
that are not associated with a struct device to leverage the
reboot-mode framework.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 19 ++++++++++++++++---
 include/linux/reboot-mode.h       |  4 +++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index ac4223794083f36960b2bd37a601b7e1f1872de5..eff60d6e04df2cb84ba59d38512654336f272f8a 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -8,10 +8,12 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 #define PREFIX "mode-"
 
@@ -67,18 +69,26 @@ static int reboot_mode_notify(struct notifier_block *this,
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
+ * @fwnode: Firmware node with reboot-mode configuration
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
 {
 	struct mode_info *info;
 	struct mode_info *next;
+	struct device_node *np;
 	struct property *prop;
-	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	if (!fwnode)
+		return -EINVAL;
+
+	np = to_of_node(fwnode);
+	if (!np)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
@@ -168,11 +178,14 @@ int devm_reboot_mode_register(struct device *dev,
 	struct reboot_mode_driver **dr;
 	int rc;
 
+	if (!reboot->dev || !reboot->dev->of_node)
+		return -EINVAL;
+
 	dr = devres_alloc(devm_reboot_mode_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot);
+	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..22f707ade4ba93592823ea8718d467dbfc5ffd7c 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,6 +2,8 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/fwnode.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
@@ -9,7 +11,7 @@ struct reboot_mode_driver {
 	struct notifier_block reboot_notifier;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


