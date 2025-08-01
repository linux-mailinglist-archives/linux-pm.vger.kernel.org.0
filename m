Return-Path: <linux-pm+bounces-31755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C917BB18090
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E8A84B3F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8712367AD;
	Fri,  1 Aug 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/ucVyCp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E072459CD
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046012; cv=none; b=DY/uYmKnckSLWHHaOQGE70TOa3xNKWwiS5qMNiSMYV5q2al+IVQMKTifL9aDvpTGxIEz38sQPAYmOhQsJ++41c0xixyuvU/tdFH7GqLRi9rXaoJgvLK5mSr6UCknRz8emUIRYx9BWUP3S09VQFYeBzazyKBsT311qmK1HDptTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046012; c=relaxed/simple;
	bh=Kp7aLz6ua2U/kn6vy6jAG2izbyo0Wnrw280JYTZZa0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTkm110qaga683s0wHAcO1m74hJ2K4AfYOCW7mD//EbP3SXU+rgwU2NoozKfIJVkjiOVkJw086rLL6E8dM72KSFGuflAL2+DKcJcrGgpMpIDJJVxe65DBVQjxLneuffldsUSQNbXx+gMP+Thbz6Sa2Irk6o6aN8j7kBbfZyN3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/ucVyCp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5715D3YJ009136
	for <linux-pm@vger.kernel.org>; Fri, 1 Aug 2025 11:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEMFi3yFFkbpJ7pR+UhigZi4QAV8nxhHoe8LrmMYYTA=; b=K/ucVyCpYUpqLgBZ
	j9GS7cUVB/ZmfFQ7ErzZdU9dVKOI3j6dUUXM/6jUZKZg5QudjVAJk4D0t8WbfiZE
	jw6dcjvhPlt8R0UwVpkuhviGsQ3m+BB0KzhvSftt2khlHv7+vbOQt6IFYS4R4Ej5
	dxCTh6MPjGt/d8g0K1w2TKNRKeqA9GaoAyO1YtKn46dPw7Q+aF2Nz0voJo+PhATO
	joA5Y8m03fAM6bSh9jsYqvRjQwSnBmtC3pCQRpFcVvszoyCAm7q1L8tqpI+/oMzv
	7WAyRXOB2VBSI16rfzvM/gQyPWBONmil1xALZfTf6ODexU8FeQ1+iWHBfCjPx2p0
	7m+qJQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488q7xs45e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 11:00:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4227d86246so1432720a12.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 04:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046009; x=1754650809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEMFi3yFFkbpJ7pR+UhigZi4QAV8nxhHoe8LrmMYYTA=;
        b=VJ+uvmJggDbFsPQMER9G37Rp3ZDRmJiDQ8e8/9dwS3DLd/7NWgA/vQlVJS71UKqR74
         mPoUDy2R0t7ZnJzB4rrTAyNGPtFjlqHETj8wgXYZKuYsS/ZJBcnzu0m40yibAilztjgt
         0jAnZUKrH5vMsUgrCVM7Xk62oRzvWh3k5lQYCsmdjeKXJ/UsBOoXrqoLNwTb9Lm3n4eJ
         riRByF69PJwP/cxdpUX0ZcLXdWazIIqIQ+bKAll9QG/H1uPHTw4MGXc0P/OPjghQH/ZY
         YNZwJcd5QT/A4N5QDWFRPzsYzlGa88lghYkq3x7tQf3LbsQq06TSsEWbOagL69vLw0As
         ok1A==
X-Forwarded-Encrypted: i=1; AJvYcCV9IAMX58IBq/TeknvV7V7es7LRcSeBX1KEBJMRx85s0B8miRzsyQEmIWO34PzvCNLE4k+L9fnOvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLuUowD9DPx2cXj7LBAThzhWP7I+c0OfKpS7NPdOITLPBffHH
	XcrAR3ynpRDTSMkvgdUetd3lElUc2e4U20WnEYpd1yy5fxKPe5JMWWOJtmqcU8jyRt6afc20Ds3
	UEn+rJMvPh6MRGLrZX6WXdg9qUerC/WgEJJax1BM+IcuN/JklXQYALiezpiSDOw==
X-Gm-Gg: ASbGncur5fU94Wq4/6n0/TXmUU1FaKg81igrwiGXdcqRhtgmi24Q4Y2RWynYjJonSEl
	cItLFfKhvW7DcPmhwUdU11qdMW60694B7D+JCc/njno9N0uQHTNuuyfRF5d5TefoYfQ7XFe5ZSG
	5PUq3GqNiCKtqDYfS0vWYKoIOilZ7gdPVlrfjCH3TDWQEGihmt0q3hQbC0yMUi9Pi62vdvy+U0H
	wf5sb4bIQQYYWfFBbhF8BynMHlQ86hM8xII7EMV2iIE33F3kKjKKhW5qILW8hZSOa43/97gc7ii
	BpKtEa6pIu4Knc2nc94RysOW6IdsI8s0gmcDCw9r/elnDlbSl8mEmDqCrTO9ruHxUM31pAHdGIE
	=
X-Received: by 2002:a17:90b:2511:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-31f5de4b9demr10317720a91.19.1754046008587;
        Fri, 01 Aug 2025 04:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1a77JjJtoze4OxqCff+khRd9sEZFHd1GYlo3bjukpx9Fh2DsfOlLdvQnBiwD1wkCTknZygw==
X-Received: by 2002:a17:90b:2511:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-31f5de4b9demr10317670a91.19.1754046008033;
        Fri, 01 Aug 2025 04:00:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm7154395a91.26.2025.08.01.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:00:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:29:44 +0530
Subject: [PATCH v4 3/3] PCI: Add support for PCIe WAKE# interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wake_irq_support-v4-3-6b6639013a1a@oss.qualcomm.com>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
In-Reply-To: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754045985; l=8173;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Kp7aLz6ua2U/kn6vy6jAG2izbyo0Wnrw280JYTZZa0o=;
 b=g5pBTW9TyAhCznAys9dfE3nfBdbVVklgPlSnpz/26ZyyOP0ZwZd9UFUCPgPPKpx0XXuyv6oCU
 xT7IcLaN/26Bq9HgztbUiMbg8NLAbcxlscON+J7HEGNAJGc9AN8aywm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=EqPSrTcA c=1 sm=1 tr=0 ts=688c9e39 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pg203nmD_v0msc3Z_NIA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: txQGuNqiGrHHLbi792_qkKQM2AwqrSU6
X-Proofpoint-GUID: txQGuNqiGrHHLbi792_qkKQM2AwqrSU6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MSBTYWx0ZWRfX7yP6uARSzDgE
 KJXJBRMix4iAbw4aKLaSkhjVuHFnazAz4dsTfdAqIdcL8kBOevBByHeTEFe5Ohn+9UMyqkZHC9Q
 VpcpfV9oCtwOY5QI0eAIsaGXsHviqyicLFrxfaLekyxlUp/mwY2AJj1Q2oMKocE8hnBNQ16/cTG
 szW6zadPdTnhigaDrnhOBugnZC79tcMUUg0xA23TodAE94MjAOBq1vw/BdpZvgbzODr9qOLqtgY
 P4PsjDhzryDPKTuO2DmCcnM+uFzedZGhuYTef8DtSO+QE5SLfqq5+L91rxEDT0MjHAC2jzCSS2k
 T0YpR/x4CaPHcekSx/eb1GaSggLZupAKVwObQK8KRTUS2M8XC7SZeGNWvBRN8AQK2tuYB1TiTBc
 0nuSYiFjzieGEKPg6BeD0Nqj9zc2kHBxxdOLfdjkb2SXoJ8KBlYYgLslj8lafTRiN1yBFAH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010081

According to the PCIe specification 6, sec 5.3.3.2, there are two defined
wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
provide a means of signaling the platform to re-establish power and
reference clocks to the components within its domain. Adding WAKE#
support in PCI framework.

According to the PCIe specification, multiple WAKE# signals can exist in a
system. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. To support this, the WAKE#
should be described in the device tree node of the upstream bridge to which
the endpoint is connected. For example, in a switch-based topology, the
WAKE# can be defined in the DSP of the switch. In a direct connection
scenario, the WAKE# can be defined in the root port. If all endpoints share
a single WAKE# line, the GPIO should be defined in the root port.

During endpoint probe, the driver searches for the WAKE# in its immediate
upstream bridge. If not found, it continues walking up the hierarchy until
it either finds a WAKE# or reaches the root port. Once found, the driver
registers the wake IRQ in shared mode, as the WAKE# may be shared among
multiple endpoints.

When the IRQ is asserted, the wake handler triggers a pm_runtime_resume().
The PM framework ensures that the parent device is resumed before the
child i.e controller driver which can bring back link to D0.

WAKE# is added in dts schema and merged based on this link.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c | 10 ++++++++
 drivers/pci/pci.h        | 10 ++++++++
 drivers/pci/probe.c      |  2 ++
 drivers/pci/remove.c     |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 91 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f119845637e163d9051437c89662762f8..5a832bbf2dd5da728080f83220f47c3578cb6b5a 100644
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
@@ -586,6 +588,29 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
+
+void pci_parse_of_wake_gpio(struct pci_dev *dev)
+{
+	struct device_node *dn __free(device_node) = pci_device_to_OF_node(dev);
+	struct gpio_desc *gpio;
+
+	if (!dn)
+		return;
+
+	gpio = fwnode_gpiod_get_index(of_fwnode_handle(no_free_ptr(dn)),
+				      "wake", 0, GPIOD_IN, NULL);
+	if (!IS_ERR(gpio))
+		dev->wake = gpio;
+}
+
+void pci_remove_of_wake_gpio(struct pci_dev *dev)
+{
+	if (!dev->wake)
+		return;
+
+	gpiod_put(dev->wake);
+	dev->wake = NULL;
+}
 #endif	/* CONFIG_OF_IRQ */
 
 static int pci_parse_request_of_pci_ranges(struct device *dev,
@@ -1010,3 +1035,44 @@ int of_pci_get_equalization_presets(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
+
+int pci_configure_wake_irq(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge = pdev;
+	struct gpio_desc *wake;
+	int ret, wake_irq;
+
+	while (bridge) {
+		wake = bridge->wake;
+		if (wake)
+			break;
+		bridge = pci_upstream_bridge(bridge);  // Move to upstream bridge
+	}
+
+	if (!wake)
+		return 0;
+
+	wake_irq = gpiod_to_irq(wake);
+	if (wake_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);
+		return wake_irq;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_wake_irq_flags(&pdev->dev, wake_irq,
+						  IRQF_SHARED | IRQ_TYPE_EDGE_FALLING);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+void pci_remove_wake_irq(struct pci_dev *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b853585cb1f87216981bde2a7782b8ed9c337636..2a1dca1d19b914d21b300ea78be0e0dce418cc88 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -447,10 +447,19 @@ static int pci_device_probe(struct device *dev)
 	if (error < 0)
 		return error;
 
+	if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ENDPOINT) {
+		error =  pci_configure_wake_irq(pci_dev);
+		if (error) {
+			pcibios_free_irq(pci_dev);
+			return error;
+		}
+	}
+
 	pci_dev_get(pci_dev);
 	error = __pci_device_probe(drv, pci_dev);
 	if (error) {
 		pcibios_free_irq(pci_dev);
+		pci_remove_wake_irq(pci_dev);
 		pci_dev_put(pci_dev);
 	}
 
@@ -475,6 +484,7 @@ static void pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
+	pci_remove_wake_irq(pci_dev);
 	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb682b669c0e3a582b5379828e70c4..c8cf0b404a4f31b271f187dddd75a007c7566982 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -920,6 +920,11 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+void pci_parse_of_wake_gpio(struct pci_dev *dev);
+void pci_remove_of_wake_gpio(struct pci_dev *dev);
+int pci_configure_wake_irq(struct pci_dev *pdev);
+void pci_remove_wake_irq(struct pci_dev *pdev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
@@ -965,6 +970,11 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static inline void pci_parse_of_wake_gpio(struct pci_dev *dev) { }
+static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
+static inline int pci_configure_wake_irq(struct pci_dev *pdev) { return 0; }
+static inline void pci_remove_wake_irq(struct pci_dev *pdev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e6a34db778266862564532becc2a30aec09bab22..4fb9d8df19bc41cb84dcd1886546076bcc867a43 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2717,6 +2717,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
+	pci_parse_of_wake_gpio(dev);
+
 	/* Notifier could use PCI capabilities */
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498edc88f1ef89df279af1419025495..1910f7c18b8f9b11c8136fea970788aaf834c97f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -52,6 +52,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (pci_dev_test_and_set_removed(dev))
 		return;
 
+	pci_remove_of_wake_gpio(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..8f861298e41d2f0d2dd0fc3f5778fe0e77a93511 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -548,6 +548,8 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	struct gpio_desc *wake; /* Holds WAKE# gpio */
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */

-- 
2.34.1


