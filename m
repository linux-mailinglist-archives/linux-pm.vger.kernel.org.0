Return-Path: <linux-pm+bounces-39878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD6CDA0A5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E5EE302B317
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980A3469F8;
	Tue, 23 Dec 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJW59uGp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhR7mswz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226F257843
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509693; cv=none; b=LyXZnEFCts5nRZZrtRStypDaNYI+U/zNCxRiIXY6BZ1T4aydEAB1i9LrWs5RyHr3Ha5ylSl3p6OL/N6uji5i/3nEwWcCLDoPWyi2ZLgAkWepVMvcjKCOZ3YO24Y4zPkBL9b7DHloQsj9g20B8ukPRKsTgsCPinw/mbJX39CmZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509693; c=relaxed/simple;
	bh=2o2cT38Ly46xd/419lqAtzNeNc4dO02E+TShPOPKLWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOywG6q/WpTxaH0HIWgiIAefXRSuC7BgsDYVcJDYbngsk/BQGIFJjOTGrioNrdW36kk2lY9DAB1lFDz0Odpsr5NDGioUtt0sal5mCbHvKwbwB/PUkpIemJMUMpNKASTy7eHpoL1qBeZgKzxUoSBMS972SjJECQk++kvcAB9N7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJW59uGp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhR7mswz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNF0Yad2115377
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7mc3GOn350tsV5ROq6wQgRZLIh0hhlkh6WOkw1l+Vmk=; b=KJW59uGpb8HkkLVK
	xDoavrn4MmeLJb+PXS0aMTmD105NuKRIRhuMJXXJ88k5I20iGy98cfm9pu1cLNEp
	r5Th+IFHeMFZ+XxFQy5FovEEooftgnFr4tNojHWbEfmq3sU+/e7razRdqO53YORY
	ow2q7Lv4zy0Iv7v600styZbeIVlOTUWXNL1vFRHpaceZwy4PR0earaGHH5DeOipc
	eMkHNsDGBVuyY9cwZFFqU2rPpLCTfAzGq4xQhPt4GJW0tJn+QC17kY+2BUmIiSJC
	StkG23iQYhqctdzgZV3qJQZqfvNWOsaMkUAfdibJCGJSlQuYzwslIux0pvNzAtvy
	jM41GQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cudkf9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so136817545ad.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509691; x=1767114491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mc3GOn350tsV5ROq6wQgRZLIh0hhlkh6WOkw1l+Vmk=;
        b=FhR7mswzBlXO6z933RUQVlzGPq+QRFOCQRRwpaKHsD9iAnjEIgERryJH3Av6wJczIj
         aZbTk3fXwbBZS60e776IkAHMa8Aj8zzEGlsk+3u9BQxnvtDbmbtBSe7ilTv55mc3d0FN
         Mgml6Bk9i7x5quXYWdCUljr8qvtNwXZfaWs27Cz7qONNmnpfL/JvMkNHChOMll1ByZ5K
         8WF8qTC1qAgy8CP1NeCxoIb3al9JL/B2T+zteon60DhTUmK/ZJRzhdoI/6XCvax9HA72
         s2zfLX0EFr5ULVYNbn2e+iRm2BCpaZ7/ECXNCkVw7AQBZhHhksE9uv797ahvXsxwjmx3
         z+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509691; x=1767114491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7mc3GOn350tsV5ROq6wQgRZLIh0hhlkh6WOkw1l+Vmk=;
        b=rER61mKrwiRXo/rLvIvQA0zsrEVoQ18hjQSasi+EjiAd1F7so8Wu1Do4tI5j7PK7Rv
         al06Jd9CQmHCSZ0Zr/arPAy36yfckYsebDKjICw9d5HttqMYs8nFMyW5nztGsE5avD/f
         zUxHyqvzSJywz9SU1Oq6zdnt7q0E7Ql0BUUeiBdcOucY+/1xkStvcpmVrsMCcS/6DT8b
         8uqplrgQhZ1bo63tijvZ4HncMDlriORl3opixqHaRJInzvAX5+ZaXiH7hoOY3uDPPDpd
         zgtHE5rwa2uGYSWzGIKkESe4+5X5R5yJgcErjcbwtQyj1g0dkaWzYvf1pK3EhC5vPJ4I
         zSAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJeeG1VXSen08Kwc0OFWWy/BGBRs4LRqbkNEUUjA7p1d7QUrmQx+9r2+j9JtshkuoHVZ5WylVlvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCPknDNpveh7e9CighjQ/vfdT5h6hFPQxihfMZ26jL842fZJv
	ZLul5bybfs1ccPuESFBZMqluNRWAtoD1E2b9fny3C4FkZS2//5qho3Z91ZjIoi0aaxX1U3cWJmu
	YaML5Dezho7vdRChnukGbFD58UmGq+N4T9O9p7Ms3W8DM+dQFUqz5vX8xTzeY9Q==
X-Gm-Gg: AY/fxX7z3No+7+UYmbnuGAcELVPHhSHOLG8SbnifIjuSWgCwjFiUOWnpbWnNh5dTK2c
	4W8E4+oG7/bfCVMMsXgM/G24p2B/Fd8ZMgrLWo4/Tl7E56Kox6EYkuPIOeGgD80j08VZQDCGqSl
	ovWvMvMU2FayoFGV+ZrEaiJoix1D2CPWUDAAaEbfMqZetmDq7roZZyroonaybbUVK6au0Gnecnc
	0DeGg1plMVGyxa+k1wXgJ6zJ79u0QGMeRbF/t70Dqmoy9QMFGw5lhqKTNgAO6SuddZ5za1opN5a
	CSXPEUff14vOBkLUA6am5f2gUn6pr0ONoqN4FlRIs6X03FxMvQ4jS0NNqszvEKo7q2EYkJ8aiPp
	/3Ljzam8jKeCHeZYeSaABq53im6EyeZ2nbhy+LriWd7IYNg==
X-Received: by 2002:a17:902:ec8b:b0:2a0:d436:e7ad with SMTP id d9443c01a7336-2a2f2832c51mr157277835ad.49.1766509690506;
        Tue, 23 Dec 2025 09:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ4aOnLvyrVaT66N/eDSlqnerZMeyA1rrRBgGG9I3JAKDcbQUsSMiZ5xQmSXBqsbJ2CmnO9w==
X-Received: by 2002:a17:902:ec8b:b0:2a0:d436:e7ad with SMTP id d9443c01a7336-2a2f2832c51mr157277475ad.49.1766509689927;
        Tue, 23 Dec 2025 09:08:09 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:09 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:33 +0530
Subject: [PATCH v18 02/10] power: reset: reboot-mode: Add support for 64
 bit magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-2-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=7589;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2o2cT38Ly46xd/419lqAtzNeNc4dO02E+TShPOPKLWU=;
 b=ErA8eTOuOFOVhrWwNxeIIP8Srfsn/pUO1IpTWe2NedElfQ2IN4YB6eCoG1OL1KxxLRWA2O5U9
 jE3AMKHa3WXBeBut/eiy7DVsRaP290clHrPDEVmXVTJPn/xTrYR/pwP
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=ebkwvrEH c=1 sm=1 tr=0 ts=694acc7b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=MO_J9Aa4ypbE8kPWTcIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 1YLmCEXvWASzcxUO_g4k3GOea4e97C0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfX9Sm3hJhyhX8q
 q0HJtTtrHa4N4rR2rtUPYQ+kWg15dT8qL0PeqSbTgf2L7k+K64bpCASR0BOpfmlp91b0b9kJJCh
 8HnFxiNZdscSv98WcVTlge97eSjrVj5w9EQVRUVNBQAPrIrxlpBFJoH+Hiz1wXMuEPdx+UDNcLh
 twLXWhpg0HYiAUZdWmPNHcED4JPbUxzoE4RKTrE9Kh/kaIA6YJjFBtk0MBnXW7Dh1BQH2iw64dy
 OqsRUqhCVRreSWe7p85ijH1DBvA5v3QdABeWdoQwchOKLaQM1KwTU5aRv4sukNpmJ44i0XU3kOs
 Dfk4hixoDf4stB6tstNZoWNmSUllZuRmU3FR8sp2TbAvYiGzrkd59gCsR0MRm0SzXO4ZVz+fpTZ
 Kqv1OOoLnFEKITBjQTxsfTJwTfaMRBL9/6XkH2mqpZlZhkgqZZH87fiTuoFj2ooDJQiG1egq1uH
 RZGg4VXhcH4woETOQWg==
X-Proofpoint-ORIG-GUID: 1YLmCEXvWASzcxUO_g4k3GOea4e97C0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230142

Current reboot-mode supports a single 32-bit argument for any
supported mode. Some reboot-mode based drivers may require
passing two independent 32-bit arguments during a reboot
sequence, for uses-cases, where a mode requires an additional
argument. Such drivers may not be able to use the reboot-mode
driver. For example, ARM PSCI vendor-specific resets, need two
arguments for its operation – reset_type and cookie, to complete
the reset operation. If a driver wants to implement this
firmware-based reset, it cannot use reboot-mode framework.

Introduce 64-bit magic values in reboot-mode driver to
accommodate up-to two 32-bit arguments.
u64 magic
--------------------------------------------
|    Higher 32 bit  |   Lower 32 bit       |
|	 arg2	    | 	    arg1	   |
--------------------------------------------

Update current reboot-mode drivers for 64-bit magic.

Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++++----
 drivers/power/reset/qcom-pon.c           |  8 +++++---
 drivers/power/reset/reboot-mode.c        | 24 ++++++++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c |  8 +++++---
 include/linux/reboot-mode.h              |  6 +++++-
 5 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..b3d21d39b0f732254c40103db1b51fb7045ce344 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -16,15 +16,17 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
-	int ret;
 	struct nvmem_reboot_mode *nvmem_rbm;
+	u32 magic_arg1;
+	int ret;
 
+	/* Use low 32 bits of magic for argument_1 */
+	magic_arg1 = FIELD_GET(GENMASK_ULL(31, 0), magic);
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_arg1, sizeof(magic_arg1));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..ccce1673b2ec47d02524edd44811d4f528c243e8 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,19 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
+	u32 magic_arg1;
 	int ret;
 
+	/* Use low 32 bits of magic for argument_1 */
+	magic_arg1 = FIELD_GET(GENMASK_ULL(31, 0), magic);
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic_arg1 << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 4b6ae4007c4f6fb7d51520b4be2bf3cb1dff518e..54adcda57e44edf2fd2cda0f752226f747aa72d7 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -17,12 +17,11 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u64 magic;
 	struct list_head list;
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -54,7 +53,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	magic = get_reboot_mode_magic(reboot, cmd);
@@ -77,7 +76,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
-	u32 magic;
+	u32 magic_arg1;
+	u32 magic_arg2;
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
@@ -86,10 +86,13 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		if (of_property_read_u32(np, prop->name, &magic)) {
+		if (of_property_read_u32(np, prop->name, &magic_arg1)) {
 			pr_err("reboot mode %s without magic number\n", prop->name);
 			continue;
 		}
+		/* Default magic_arg2 to zero */
+		if (of_property_read_u32_index(np, prop->name, 1, &magic_arg2))
+			magic_arg2 = 0;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
@@ -97,6 +100,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
+		/**
+		 * Format of u64 magic
+		 *-------------------------------------------
+		 *|    Higher 32 bit  |   Lower 32 bit      |
+		 *|        arg2       |       arg1          |
+		 *-------------------------------------------
+		 */
+		info->magic = FIELD_PREP(GENMASK_ULL(63, 32), magic_arg2) |
+			      FIELD_PREP(GENMASK_ULL(31, 0), magic_arg1);
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..eb7fc5b7d6a7ed8a833d4920991c4c40b5b13ca7 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,18 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
+	u32 magic_arg1;
 	int ret;
 
+	/* Use low 32 bits of magic for argument_1 */
+	magic_arg1 = FIELD_GET(GENMASK_ULL(31, 0), magic);
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic_arg1);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..a359dc0c6dede0ac5ce67190a00d46a7e7856707 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,14 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/types.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


