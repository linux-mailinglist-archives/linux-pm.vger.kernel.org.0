Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DCA78B817
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjH1TUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjH1TTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 15:19:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD32120;
        Mon, 28 Aug 2023 12:19:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SJ12qH007567;
        Mon, 28 Aug 2023 19:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iwBHdSgkTzksPkElbM9VpFckJ2B833jELeGXVSHyQ8o=;
 b=btG0SOiZNzR1mSGbcDKzRasfehCHb3mQscqb3kiyBYG3VXwwd4n0iv6lZP1e15WkA/5/
 ymfvpGn3AWKdEeItrbxhZFmFAAlbc4SF7iYVZ1jUEw6pV2ifQwf6j2DVRVfWdDV6OPyb
 CL2qcAU8mDjEboOQ6x/Y3Ras4TcECyGCn8vSwOK+1Qe0krdhWHqelXoHTzrj46unKvDU
 5Vf5dWBnOhRrZ4uwYDOfhtD5BvI05IJSdIj7BSsOEcqtvLfkI5qY3caGUilJypAjlEhl
 rF+l1KOrfpeVvMct5kCC06UR5TRrxb1xzJYdyRwyC96yWl7qMr3tTl0fr+7ODIFwNquM 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8vhw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:19:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SJJTn3003302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:19:29 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 12:19:14 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH 6/7] arm64: dts: qcom: ipq5018: Add tsens node
Date:   Tue, 29 Aug 2023 00:48:26 +0530
Message-ID: <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0LxdwKbXpAmCiu73gdA-bMd7uijvC5TC
X-Proofpoint-GUID: 0LxdwKbXpAmCiu73gdA-bMd7uijvC5TC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_16,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=802
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IPQ5018 has tsens V1.0 IP with 4 sensors.
There is no RPM, so tsens has to manually enabled.
Adding the tsens and nvmem node.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..277b3cfc7f72 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -93,6 +93,29 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		qfprom_nvmem: qfprom_nvmem@a0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0xa0000 0x1000>;
+
+			tsens_calib: calib@248 {
+				reg = <0x248 0x10>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5018-tsens", "qcom,tsens-v1";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SORT */
+			nvmem-cells = <&tsens_calib>;
+			nvmem-cell-names = "calib";
+			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
-- 
2.34.1

