Return-Path: <linux-pm+bounces-42806-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK6+EJN0lWnDRgIAu9opvQ
	(envelope-from <linux-pm+bounces-42806-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:13:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD54153E7D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D0903032DC3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CB3161B3;
	Wed, 18 Feb 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQcCVZVL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZJKswC7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0120318135
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402375; cv=none; b=tqGW0uh7XpUENrl6p1psMS03aeKYQTB4TOiYpGsh8UnGBQSiGv9/Ck7cOnlOhxjxNx/YlgFmKcYYTxAdIEhiqXsBA2P4QOI6aC1zPRA8HVvAPon/jswoCGiR1V8jA50jxgQoTjnXQkW7oMgqkIpthmDveZ9s+7bNheXGPrwWQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402375; c=relaxed/simple;
	bh=YyvIpWrTFLi6XlA78epLgR4oDc+qO1nmiVhSzx9chWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRAFuHRjbVY9/cJ7yIKlVmTOV8X1gWApL81izsZEtPDsOU1CRC4A0UDNdA8dV3ljq/tMwtGfiBkB6Mnt3w7bU3Pfxu9P+vhR5b/yodLZzU00XkRizLnHQhJ0lribdVYPApUL46uvnqiJD4u1wmH/I1Zkc4f/eJCskMarDXoXZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQcCVZVL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZJKswC7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HKXp3d3695372
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fygRWP8pcLbQ34jhJxnxGK22lbC+YAxbQQyhOVa/yJs=; b=bQcCVZVLa3xhQUCe
	cX0vsq84LQfdwfq8BWnjE3XhMCpMDjPCWIOEONVNqGX2vVug6wBSVClvAbUMd5da
	uSHUvUm5DVOASlwu1gKUfrb9uxuYYhmOsTQvFdK28gz85sbnaUTqhLfp+TcZedbF
	g15TAoGBcfLoz1d6MAPBle88GHbGywPQ6WJU8MOrOUWJPRxcpM9h4sDDBX6Xja4r
	dfb9FxTRu7u/0n4hVBGFzyNQorReOtAL2Z/37ep9vGdsosL60mTd5sqymb4xF9NX
	BIP/F013UK1n4yF+SDsGUCCfVQm752UdSg/VH3LMT58pFb6nUCJeC8RNaQPV1gNZ
	nU8oCg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccyfb1j7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a863be8508so56634225ad.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771402371; x=1772007171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fygRWP8pcLbQ34jhJxnxGK22lbC+YAxbQQyhOVa/yJs=;
        b=ZZJKswC7DSpjI8+ZGf0HA6wxBSNL971o+UCsbsSRssiw2W7IvZPxEaNPhPbRDG4O4h
         0Hhw3WwGO0csX9DqDx5QyQEyiFiQBfyWg31NBrHmC8A7/OLNS4390PTKnILrFeVd7Nu+
         DPZkf7H2RT7r9b/r8KvcvQe4Gigl4vluBUT/kbWwI+9qP92Se3oc5T8W9YsrsyI1AKwz
         dunpcSt4eaPWy9NFsUV2EYyrN6Us6w9ny2iRV20cR8O7UXal3Q+jCEls8E6RsZjOHisR
         voDPFOhFZnZex9bU1sTXMJQWCP2+pjMXpbS/mtf7IUvSF6VSQg/JZIbhnak1zzIamsWp
         0DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402371; x=1772007171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fygRWP8pcLbQ34jhJxnxGK22lbC+YAxbQQyhOVa/yJs=;
        b=MVd/3wFU7eJyGspSqIviu+RgFEmVAM0yXgLJaOjupa2ARlsHaoEGDIcIEThb8HFBxY
         BX2coub+1ZAX19MrUlIwu3943mgSEZca0Fg1BiQ+eJ/77DKywwSpwo5ypeyBie8i9n5C
         6hMkdPFv7rX0L2XfFYCbmGRhKBLlFrZfakbHduSpHwUaYjtkDm5FntJBqO2O6fK5v8Tm
         hVl+T83lAafz422Phc3dXqGYGEWjEWCoAouCh5JHBhbd/l65WKfbSSOW9sJ7X42ymtpR
         YHqNws5W6LUmg3W5zlJLBsIvO69f3N55qjIWrUUHnXJPVZiNqhEJn4GAhsbmJiqjtVjV
         dIpw==
X-Gm-Message-State: AOJu0YxqxXjMvat/I88qsL+Ls5Fl3YP+AOUhk8nMbU7Q89TYsW5hodpc
	5QiJQjlmoL84EhuAZvYgkigEIvSWTupL1H+ucR+3vf3gOkC/k6XaDKIK43zFIKPxpV2l+rL0YCY
	agVfcstdhU/C6msyYkdyDONHxGjzMC+drwzqf+g4GEX0x1akhB+S86WwiwOckqQ==
X-Gm-Gg: AZuq6aJitGrVjBM7HInO0WTuzrwZFcDfoAaH0NO7dRUqe7o1SJMn6mvPpTFNGLHIq4L
	sfn8SHmrxX4kuSakO+F6rPdRw6RmC/46MO9xKBC8nj7sRdDNUJZYs+tfyHKZQxT8IcbSA8dWfXy
	sE+6ceFYdrzukoAQMFIoRyqTrzeKk/4sKP86hBVnlgV684Lc2EBnORjLHA1Yw4WbchZ0kplA5Qz
	pVt5RNi6L9Qj7xEEp/InfwLzuEbWlM9K2Om/d+7e0UX2aIc8ITXQX1TN/RR86edlC+XtgXmo/sW
	IEjBABeGf80fgoPngL3H2JtMSoFyPbgWBt9aK6sQveDXN1N9rf/mN7rwsZtmqWt4xW1iEA0eTi/
	GHpVFmIwVpGCjUc+gAY++fWi32m4q2blLoMF1hr7kergoRLNn9NGCUWgB
X-Received: by 2002:a17:903:2b10:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad1754a10cmr133301945ad.45.1771402371312;
        Wed, 18 Feb 2026 00:12:51 -0800 (PST)
X-Received: by 2002:a17:903:2b10:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad1754a10cmr133301625ad.45.1771402370825;
        Wed, 18 Feb 2026 00:12:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d624esm118123685ad.49.2026.02.18.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:12:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 13:42:25 +0530
Subject: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771402347; l=7967;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=YyvIpWrTFLi6XlA78epLgR4oDc+qO1nmiVhSzx9chWw=;
 b=T9yc43Z0e8+NjXJSIlHu3tdFO6HaY32cKsWHdKZZ2VqhHBCDBrlY90crKCb6DxcOXTnxOfSLF
 9SUKBwO4bV5D1Zrj1R2rRIXSVgYARNPyuZm3lMN/9oxEZq/mzzo65Bk
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: trUucx4lFiLxP4Viiw2TBL1Nhdp0pXhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3MSBTYWx0ZWRfXyW7/mEg2ECCu
 L2u2kFJKZehRMJJtB0DnrJz8OvMVKiZnOpeXW3LqcDnVKYU5pYYh1FJQLlWLmqp6NkdN92+qpMo
 svoDl6402HdQUebQhgVdqd73lxk49WrMBwKYGKkcHd9NyrJaJ87pA1xDpV/YIZyeBcLoQ4KNsyE
 ybbgWfAtutDiXpUMSHWhvGrH48GlHxpNFeIUT3SsfuNPKBRgBhnahKi7F3bj8UQpNqQ34L0LHV/
 ntO0yepezvPd7/gnSOZHy2/YcQzVm/T85PJRJJTO4H2gQ/bZUOI2rWj3XJIbdTYhPleMo0KhZqw
 ZBSS55QYEt6jyLayjtKjHeanN6feTZZgSe0YiCuSKffetjY679eNc7euRSt7Q+hd472tmjhMsZN
 kMykphLpaIYL7Zk60fpUDUezo/w0rLEM+bhPYYWdniefjI0Yc7BKYZ16qFxTnmKaCjTeTS0qxj+
 TNxpMYsyrcwJlpKqj3w==
X-Authority-Analysis: v=2.4 cv=JNo2csKb c=1 sm=1 tr=0 ts=69957484 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=ttF918e8ocTVMR-R1j4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: trUucx4lFiLxP4Viiw2TBL1Nhdp0pXhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42806-lists,linux-pm=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: ECD54153E7D
X-Rspamd-Action: no action

According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
hardware-only mechanism and is invisible to software (PCIe r7.0,
Section 4.2.7.8.1). This change adds support for the WAKE# mechanism in
the PCI core.

According to the PCIe specification, multiple WAKE# signals can exist in
a system or each component in the hierarchy could share a single WAKE#
signal. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. From figure 5.4 in sec
5.3.3.2, WAKE# can also be terminated at the switch itself. To support
this, the WAKE# should be described in the device tree node of the
endpoint/bridge. If all endpoints share a single WAKE# line, then each
endpoint node should describe the same WAKE# signal or a single WAKE# in
the Root Port node.

In pci_device_add(), PCI framework will search for the WAKE# in device
node, If not found, it searches in its upstream port only if upstream port
is Root Port. Once found, register for the wake IRQ in shared mode, as the
WAKE# may be shared among multiple endpoints.

When a device asserts WAKE#, PM core will wakeup the system, resume the
device and its parent(s) in the hierarchy, which will cause the restoration
of power and refclk to the device.

WAKE# is added in dts schema and merged based on below links.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
Link: https://github.com/devicetree-org/dt-schema/pull/170
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c    |  9 +++++++++
 drivers/pci/pci.h    |  8 ++++++++
 drivers/pci/probe.c  |  2 ++
 drivers/pci/remove.c |  1 +
 include/linux/pci.h  |  2 ++
 6 files changed, 77 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9bb5f258759be3f1e23496f083353600a4ef6743..23248900253faafaf9509d87c531b454fca41798 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
 #include <linux/cleanup.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -15,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -586,6 +588,59 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
+
+static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
+{
+	int ret, wake_irq;
+
+	wake_irq = gpiod_to_irq(wake);
+	if (wake_irq < 0) {
+		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
+		return;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
+						   IRQ_TYPE_EDGE_FALLING);
+	if (ret < 0) {
+		pci_err(pdev, "Failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+	}
+}
+
+void pci_configure_of_wake_gpio(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct pci_dev *upstream;
+	struct gpio_desc *gpio;
+
+	if (!dn)
+		return;
+
+	gpio = fwnode_gpiod_get(of_fwnode_handle(dn), "wake",
+				GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE, NULL);
+	if (IS_ERR(gpio)) {
+		/*
+		 * In case the entire topology shares a single WAKE# signal, look for it
+		 * in the upstream bridge node. But if it is not Root Port, then skip it.
+		 */
+		upstream = pci_upstream_bridge(dev);
+		if (upstream && pci_is_root_bus(upstream->bus) && upstream->wake)
+			pci_configure_wake_irq(dev, upstream->wake);
+	} else {
+		dev->wake = gpio;
+		pci_configure_wake_irq(dev, gpio);
+	}
+}
+
+void pci_remove_of_wake_gpio(struct pci_dev *dev)
+{
+	dev_pm_clear_wake_irq(&dev->dev);
+	device_init_wakeup(&dev->dev, false);
+	gpiod_put(dev->wake);
+	dev->wake = NULL;
+}
 #endif	/* CONFIG_OF_IRQ */
 
 static int pci_parse_request_of_pci_ranges(struct device *dev,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd05b15d52f866d80a015ed21f98f49..225cb861b3425700fc0d9d4805f5d9efcaab6f56 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1123,6 +1123,15 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+void platform_pci_configure_wake(struct pci_dev *dev)
+{
+	return pci_configure_of_wake_gpio(dev);
+}
+
+void platform_pci_remove_wake(struct pci_dev *dev)
+{
+	return pci_remove_of_wake_gpio(dev);
+}
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce6698514d92500dfea03cc562cdc2..22709573e41caf0ed45b20ee7ded5963f55aa9fe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -282,6 +282,8 @@ void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
+void platform_pci_configure_wake(struct pci_dev *dev);
+void platform_pci_remove_wake(struct pci_dev *dev);
 
 static inline bool pci_bus_rrs_vendor_id(u32 l)
 {
@@ -1195,6 +1197,9 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+void pci_configure_of_wake_gpio(struct pci_dev *dev);
+void pci_remove_of_wake_gpio(struct pci_dev *dev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
@@ -1240,6 +1245,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
+static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2975974f35e88b5025701d2b721df8386419de8d..7f5132c0c8de36a6ec2775468a3d4e5156a046d0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2771,6 +2771,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
 	pci_tsm_init(dev);
 
+	platform_pci_configure_wake(dev);
+
 	pci_npem_create(dev);
 
 	pci_doe_sysfs_init(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e9d519993853f92f1810d3eff9f44ca7e3e1abd9..d781b41e57c4444077075690cec926a9fe15334f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -35,6 +35,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (pci_dev_test_and_set_removed(dev))
 		return;
 
+	platform_pci_remove_wake(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..d1e08df8a8deaa87780589f23242767fdcdba541 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -586,6 +586,8 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	struct gpio_desc *wake; /* Holds WAKE# gpio */
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */

-- 
2.34.1


