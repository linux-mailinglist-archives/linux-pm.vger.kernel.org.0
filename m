Return-Path: <linux-pm+bounces-43594-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHjTE8d3qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43594-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:19:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D72062BD
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C35531F6476
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD813DFC8D;
	Wed,  4 Mar 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XflvQ8Op";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SspFAjBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C953DFC80
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647435; cv=none; b=pVwGcnHpcTEgmHhxYdnce7T+qakUDpTo/BZ8zOr/R21XxKVVNvFC0ak+Jqy0nHMTS/X3Ivf6TgH8J4LELBScLhGu+6zV0roDxpMnS22OZHhxesDyveQY7zOK0XLC382I/FrAm1IU2ZtvJmWeiikn5JI36RloK141fLGcg4+JywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647435; c=relaxed/simple;
	bh=ppOwiZTyFwlfDH5FcjIV48AYYNX/eY4c7Ah69UnX22I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmlyipT/LFG7tNqu+10iEPSDa9FojXMeCwog1dr+5ruCnP0YZ44l9PecmEjXbw7L1KUPYux76f16V18GbDti7dsYfho/2zfRxEZyGWHgoWVp2w+SkjIgOsIlBdkbIgL9fPDPoelcDAOWuU7MCivye+4SBVxSG61aDoZmXSTLGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XflvQ8Op; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SspFAjBo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HI6UI2613894
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OnqEHP+yGGninOeiIPQlRgRIHub8vI+/1VIN6MsbMTM=; b=XflvQ8OpLxjrfHDE
	e3DZYCDnHBv1EdOWxwvBzR79D3PvjiyLm0eEfvPpV7B/t0Eli7QXzIw4s5cA9RBF
	IQz2lZKJRbMqkORMJz3f1xftDJ2E4Ki2MJrYUcbbDydMe4ipKkwKpai4orqXOlpe
	4PVLUdwjtBNfDcgJxFUxJ6gpGdKsccp2RH9ajiMyk3rNzyCfkPFiEUGiM287xJWi
	HbcBYx5CKfxcwdSrHk90Ov6a1m29Blfm+DZr78dULH5AbYnbgKFSjQQI9bmP6KqS
	zsYbuCoQQdp8//lWMT7HyFlTlTuTpY257TAxjE/7wMInhBcOPZWxjAIqyRnaeQX5
	+AuLKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w84kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:03:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35842aa350fso31716341a91.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647433; x=1773252233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnqEHP+yGGninOeiIPQlRgRIHub8vI+/1VIN6MsbMTM=;
        b=SspFAjBoZW35UmqCzz7ecKcUmFRfuoUopBfDCrp8ZFm9AKhmZPZGZjqLUscfrCUA+M
         F75tHzPFe207cydfMuzVucgd6NEKQ6jSZRcPgDv+pNM/3FyBzbXwiC3CygcDg/7mXQvx
         sjHqU8VXe7g859d/wYShjequK/fQ2IGtp2Ofz66gB3lVuemviwdWIK1wJUbHv+jUoYu5
         pqccFpja/8WnlfR3oGobJPdk/NIv+YEUsUIv1kWB2PXuAFKUb+e108qm+sqhl4rxVDaC
         rApHfDclu+km+X++DQAy0oz8mQFQ0+Tv9bNzPxy8V2c1J8C6HdUQoQa64lVXdI5yP2rI
         3NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647433; x=1773252233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OnqEHP+yGGninOeiIPQlRgRIHub8vI+/1VIN6MsbMTM=;
        b=hQcuW0KvR/bIJwsSjvt1i+YZgvMc3QYrpQtnCg68q4UDl2ct/LFLefomeBvh9BA6CE
         6MJkB4FAagxu7lcL4JbWM2BmiBkvNieIip5Lv8TZUxHRNQRQLIqfUcRKoF4/0C9po/EX
         aH8lq4UVZUXiO7xR2c+YrznlpT61cEfY6cjUy+AewRvRuJD62GVd+Y+omxrnCf2P5UnP
         luX/SHTuyN+SuxwTefi3iQGB+5aduhQn9AqfVryGoN1tLKoeGn6zzXPHOEh1R2BfMJRa
         8WVyMPZOx7PFaXY996eqvRJsZ1BigXIXT0vnrLw9PmM5eM5RIv+ig+azX0ZTJn4RPFeo
         uo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLNCeFDxw3l7DlBhGGwNEyY6c5YzVabNr80Wrfzzd8/2TlNR+hP1YNKW6IvdwV3uPRo1XwdSwO4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YytHt/Pfueyy5k9mLS0RgiXPkOH/SuxPpRnjjnhOOvyH7+rvdl3
	LWndZRaIjTusSVBPyTZpK/hQoR/gO0ZoG5Te40Hhu2Lmv+zw2d+OXww+08DNp6lETYRftpydYHt
	4gJRpCIO0gGkabxQVDi5W1jxtSid2wffO8QkrO+rsPKSFLPrAfd1HpsPVS3jcsCzW3VoI+Q==
X-Gm-Gg: ATEYQzwBidqUU/4b0Hssokj/aCwI90AfBbb2n976xERV4Btg5Rr3NpSsjYMS9wKbEhn
	M68wRUT+M3Ohoe3VS73tZjECwyWMKmqwOxOJ22yqavFBdv+TJk9fSMnbIJPPrHJtXY150iBCx7Q
	Pg1Oq4OIZwy6fzh5g83CODxYE2dP8QwJ+BFwCeMfOrtiptkwDrW121nWN9jEIUkqHqZs51lj5Io
	ce5UIV1/WxAeadRSUqLMGEO1omJssukCafOkIokl5R/1D93sjVL2olii5ppHOGgkhG9An4ijni8
	IoW2qxsQ9B887b/LvYuJkc3GnP3bmJ34dXTILY4ma88e4tNH7a1PkSYytT1U4MQRIxbMtgB4W6/
	3KpoiKCJyxTUvIPnEojRRyi+WHQp7oi4kta8QiX43nXCZ9wBx4k3JOfC+Zw==
X-Received: by 2002:a17:90b:3fcc:b0:359:8d95:4a4f with SMTP id 98e67ed59e1d1-359a6a92272mr2248850a91.32.1772647432953;
        Wed, 04 Mar 2026 10:03:52 -0800 (PST)
X-Received: by 2002:a17:90b:3fcc:b0:359:8d95:4a4f with SMTP id 98e67ed59e1d1-359a6a92272mr2248813a91.32.1772647432343;
        Wed, 04 Mar 2026 10:03:52 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:03:51 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:03 +0530
Subject: [PATCH v20 03/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-3-cf7d346b8372@oss.qualcomm.com>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=5777;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ppOwiZTyFwlfDH5FcjIV48AYYNX/eY4c7Ah69UnX22I=;
 b=UK+o0a464RE0NcYd20AKEXW3fuiIRJKZKzPHnn3vsW/wNnqvFROEKIGq4O1lR9YFR5Ypvgsv8
 bbnR0T/8gqSBANw+nV1dGkeCQ5BlLIiILnarbjQNO+rbyIscetXhEiG
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: GvoPZ9C8EsLBNrH63rqNjHPYrZmXOsix
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a87409 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=iyrUps-_NMxi75ASTaIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfXwAqbLHyhfeS1
 SbwSLaz8cy7Dbd92yibZxEceUHab6Fw523Sz5bncXwng8h2PTS8qys5V0EgxNblJCIz8iQvU2CM
 HOPUH8CQcGZVBEaLpQR50BOLOD6EHPa7NxJ/QUUweadeCfyEyh11+BX0GBzfQM2wQyxhUL9rBun
 c25bX0ALMlQjk0iUyQ8ETCB/gCP4TbkydNvtIlspse1MsOF0HAxXLnvQ0qUL4CTDWAubQO2ogD3
 Jqlpy2wqDYG9wdVSUBsKjwBUDj4KJM7YIuY0b7kAuKLfX7GiewJb+r+7MFoOpPTjQY2r2NKrxbB
 ITq61KDySCRakyx4j8u1mSjP2om0Jv6b55Wl/uzglREqItDjjt6k98AA5uf5+xZGB02iocW4jNb
 ruZcuSTf1Y3P4rBFzMvqSery+Y0hvaIm8Fa0mcZp2KcFWnhHGrN0P0G1xOK+K6FtsCys70XDLoQ
 sO33G43KqnxD+3FXwZQ==
X-Proofpoint-ORIG-GUID: GvoPZ9C8EsLBNrH63rqNjHPYrZmXOsix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: E22D72062BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43594-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

reboot-mode based drivers can define a reboot-mode by adding it under
the reboot-mode node in device tree. This limits such drivers, to define
any predefined reboot-modes statically within the driver and creates a
dependency on device-tree.

Introduce a list for predefined modes in the reboot-mode framework and
process the predefined reboot-modes along with the device-tree defined
reboot-modes. Modify existing reboot-mode based drivers to initialize
the predefined list-head as empty.

This patch enables a reboot mode driver to define reboot-modes through a
predefined static list, in addition to the device-tree based reboot-modes.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |  1 +
 drivers/power/reset/qcom-pon.c           |  1 +
 drivers/power/reset/reboot-mode.c        | 28 ++++++++++++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c |  1 +
 include/linux/reboot-mode.h              |  9 +++++++++
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index bd05d660490c686b43134f82f1eadd7665403d20..83a8d80fd7d1ccb1b736aee5f2d675246a63b8f8 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -53,6 +53,7 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 
 	nvmem_rbm->reboot.dev = &pdev->dev;
 	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
+	INIT_LIST_HEAD(&nvmem_rbm->reboot.predefined_modes);
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 57b36e6186f80aff947fd7f5aae5ce280c65dc6b..9d0e3fc621a6173438c6da4cce38394199451881 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -73,6 +73,7 @@ static int qcom_pon_probe(struct platform_device *pdev)
 		pon->reboot_mode.dev = &pdev->dev;
 		pon->reason_shift = reason_shift;
 		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
+		INIT_LIST_HEAD(&pon->reboot_mode.predefined_modes);
 		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 		if (error) {
 			dev_err(&pdev->dev, "can't register reboot mode\n");
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index f5ab6eab210bcd9670441a4d2a301d9efdf2f322..a0cd463cad42cc08c55a9d1cc11174b513995104 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -17,12 +17,6 @@
 
 #define PREFIX "mode-"
 
-struct mode_info {
-	const char *mode;
-	u64 magic;
-	struct list_head list;
-};
-
 static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
@@ -73,6 +67,7 @@ static int reboot_mode_notify(struct notifier_block *this,
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
+	struct mode_info *info_predef;
 	struct mode_info *info;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
@@ -82,6 +77,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
+	if (!np)
+		goto predefined_modes;
+
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -115,6 +113,24 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		list_add_tail(&info->list, &reboot->head);
 	}
 
+predefined_modes:
+	list_for_each_entry(info_predef, &reboot->predefined_modes, list) {
+		info = kzalloc_obj(*info, GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		info->mode = kstrdup_const(info_predef->mode, GFP_KERNEL);
+		if (!info->mode) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		info->magic = info_predef->magic;
+		list_add_tail(&info->list, &reboot->head);
+	}
+
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index 9f4b18c5e46f6a8bf197773ceceb80b250f57541..0218b71541a0cefe1534e306f956ae51ea9ee870 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -48,6 +48,7 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	syscon_rbm->reboot.dev = &pdev->dev;
 	syscon_rbm->reboot.write = syscon_reboot_mode_write;
 	syscon_rbm->mask = 0xffffffff;
+	INIT_LIST_HEAD(&syscon_rbm->reboot.predefined_modes);
 
 	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(syscon_rbm->map))
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 2ce189fdfff4b396d7cc6f175b30016781ae4fe9..f07696f9439063a04fc180e953114ea09475805c 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -4,6 +4,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/reboot.h>
 #include <linux/types.h>
 
 /* Construct 64-bit reboot magic: arg2 in upper 32 bits, arg1 in lower 32 */
@@ -15,9 +16,17 @@
 /* Get 32 bit arg2 from 64 bit magic */
 #define REBOOT_MODE_ARG2(magic) FIELD_GET(GENMASK_ULL(63, 32), magic)
 
+struct mode_info {
+	const char *mode;
+	u64 magic;
+	struct list_head list;
+};
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	/* List of predefined reboot-modes, a reboot-mode-driver may populate. */
+	struct list_head predefined_modes;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


