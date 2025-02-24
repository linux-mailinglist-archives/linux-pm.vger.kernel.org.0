Return-Path: <linux-pm+bounces-22772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42228A4152F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A75C165BD2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6F1C5F27;
	Mon, 24 Feb 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dPq/3yLO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2072.outbound.protection.outlook.com [40.92.19.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C721C6FE5;
	Mon, 24 Feb 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377592; cv=fail; b=kQJPBp+xdg+ulYr+tDNGWViv8dT8P8vUQD/SrA5gDwtVn4yDyBeNw7CTLFmIHr9itFMhLwL7V8V7UE21Eg91KLGpk1XV02fRCjqgCpZYVU+g+cOyJgRmHVXQeTv3yAl2hB3CFMZxz7LIQ8LGo7ZQntpaNLxKswyEmtP9gX0QKPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377592; c=relaxed/simple;
	bh=ppT0eVV3GiEqywvKxT4h6a+kZQUoHGIBNyc6o2VeDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGJVM4P5ogBMwNUqn3hbQHxstgKtcv40fF9EUcEiiyK9aeHNX5J7GmVnEy+nT0HubKytRn4aAAKzAL4PK/yfmRtyMo2qdfo1H9rqcVkjdaHcnOXvSYuZR2pY5kU/FhEznLSrn+UE63CsKzKfHA0VfIgJR9ceWA85vf9tGPYaI+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dPq/3yLO; arc=fail smtp.client-ip=40.92.19.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6On/fcoRX+ol0TVtxI42jlJNRZbJPrllccmhYomyowqzlDOeGyBrq0ubEH7beWs6YhnF3K6gIJ8TQDaAGBUP3sBLG8sqJUGg8kLdEjVktYdD6hwP5c6MW7kkcfB/2KUJtZqXsWHjeGUJXF3Cx0I5fSAvmEOOYMfltBxNuiR8smIYYbQtuwtdaaSbpVSuyT1yhfXvuA0JAk8uPs29hpu51UT4EcNae1ooe+PjNivz+4ilKa2sMtG1hkE2OaFIRw2Jbb1OmCbMw3QZ5a2q/7IktNDMiFWswKE9OCMiCcxmFWfhi3NqcDhVNz0li93ZlXzPlVfeIibuPN5b2U+YeFx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3q35Y5tAw2XBoubkQYCuTrUDorBQzx0Jkmaum1pDt0=;
 b=L7yy4haXT7uyBom+qpnYefSfAJFgj2f6w8FxHfj6kpnB6L7uZ5MfQpXX8hCfASoSapVrV7qOeY9TUHqCzcz/6M8kjT7Jj26j5jvIQrNwAjzs5ZONIQWbLowYVfKGnin0dCGYw0x2LA0kbVBezbUeC4SztYjVL/VByeEszrEwHrMsYH82kxzPqJsijeAJbcZ3CPZErjSaPejznNHlEM+38L+xOrGj6yc04vx/oAal32AfO0GRjwySX4RxjoYMxkgyFLfbSxqFNAj7UNiaVdwbG2ljKNBfdW/7Ur1YiCg/I2tCHxyrhqMucVD23H7zLrNHSV5M9yDAPSvfidY/VNu6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3q35Y5tAw2XBoubkQYCuTrUDorBQzx0Jkmaum1pDt0=;
 b=dPq/3yLOv1jP2lJcO3bm8/qLiukPaIP6Mr1gsS01E3UgIhVDvS1q/fdCHrp9Ct6Sto+lZUBfXxYIdBFVkf2MI3f/t8UUJ9TOZp67oiWLFHecfPnDwclDxAzsiaTAQtz2rvKJgQT0apVKA0BqGyvWza1QyCGR5EDs79MIdtyS6ccvl2xwquKDInJsIbTVPYamnJnD7v1y50RbPdhmuhCDta9d2T8E8CVUdlEhR+wASqacbDss87mEbToNdl7klftT7qWfkJBK/lBI3bxq02hqCevzne2wZpxHyrG3y7mILGm22eOrTvHtcBgXm9TSm/2oHIHnx2RgLkx/49t8/ySu3Q==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:13:09 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:13:09 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v6 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Date: Mon, 24 Feb 2025 10:12:24 +0400
Message-ID:
 <DS7PR19MB8883F741184F7A82D25CA4719DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224061224.3342-1-george.moussalem@outlook.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0014.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::26) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: d324d0e2-3cf6-407d-02f4-08dd549a4f12
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|13031999003|461199028|7092599003|15080799006|8060799006|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AeS8rzoUQR1tW7mHT0QgCNwepk3rduqiubkaK5OCDygnxvHGwhaPHlM1X5P?=
 =?us-ascii?Q?xaiVLao0JsmQ4K3kfSDQf+CTfzm+84wB+jIzrxpBhMb1roGTnbl3k00HzPYX?=
 =?us-ascii?Q?RPYt7uOnPmwwrdoYyIBKIv5C4Waewq/9q/DGTGPGATQWuD1NzYeXDPjzVfL8?=
 =?us-ascii?Q?GA03Ylh2w2zPKBiEb41hJW93G5zQ4Kh0JQantrkcVpW9DqUrIAwRZHSRtzvc?=
 =?us-ascii?Q?HmhjuawAI5+H/mm5RJBgCVg/ZKJfNiJ3Z0B4cXgZ+b+1jB3OgL7GKm6HUDti?=
 =?us-ascii?Q?Q27BrSI8l+r6cGlCoPP8lf79Fc0rhp0ZqD6rhfFE3kigUh6YryC7LHFdpkna?=
 =?us-ascii?Q?sq7DK19v5ozlPK5MLL47IMp+NcVUxGu2AIFEUBa5j4CAOloxF7GxqHZ82rGQ?=
 =?us-ascii?Q?Ia1357XYw+OsHz6pq9Y4X5xesuEcYmzeYX2C+HBIhPLYkThbvL+bBe3rejAh?=
 =?us-ascii?Q?YBDZ4tdssx7kIcnSg+EpRBtrJMi0vPTxbeuUk4aTqRCBR0DSIU++XTtOk/S/?=
 =?us-ascii?Q?WViUXtXH7wEQvPQtrqcsoR3MJ9ydG2hXXsBOWtaaGWrNYpOKrb3JxGMr4BVK?=
 =?us-ascii?Q?njOau13SZjZ4FeAy2c7AH7vtTZj2NIvrKzdWn8lag1lSYxOe48uCYGGs3Iuk?=
 =?us-ascii?Q?8aBu/bwjAfncU/cuAerDSFR21GiZFBW9tmvbC1PnpvXHLpZ2rKTpke+bZ1Uf?=
 =?us-ascii?Q?ixss5pOlePjH/KEue2qnVFaqT+ROoQkPcgNZRi3MNFHr0qbsi9vkytjvfsH0?=
 =?us-ascii?Q?P056b1t8H3Apjak02vWceY8pU+03kSrW2knVt2HCRybiPDqfnOx1hVtbeh7S?=
 =?us-ascii?Q?aWmfOV6lZZbno5GzdoObyBACBL4sjFu/+fYJbQZosMCsQvBqa6yFUUR0gTMz?=
 =?us-ascii?Q?HuspIdIs7xGO8LPocZyP5gJG5oj+HOJ+h6aZQOFWJbkAZqSjSENIHiz4Mhst?=
 =?us-ascii?Q?5Go+Doe6iwsHoqluFSq/ovhyRztTPHa9wEsxPfZma2nVr2YkKIPmCpYCWA92?=
 =?us-ascii?Q?cUmLhaux7UZN3KbPHYKbTrzSsLn2FI7XV9q9v30/odnQAOTkZQ9ceLrQ9zIo?=
 =?us-ascii?Q?HUlwfGopP7gmy9eMumQ2vs551nPh5NU8pwrL1wgy0AumeH/sYZJdc+unZXB/?=
 =?us-ascii?Q?H1yYhuZl7nNDgOkJk7BWOJHnXSS9sv8lkkqXTrJpOh9OWst1qhss2vY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6D0G0JLBntNxhxXJcjQn5FMmXR4/QZ1Yk7lm2hCuaAADEh2Uj9b8GoG5W/0X?=
 =?us-ascii?Q?BtlYGW4Sfki/EVst9PqCihr48BRf52zYZsff7BYBypYpU1pQTmF+vENC3pok?=
 =?us-ascii?Q?MfTzt2/oJLgN83PBOuEMiJBqfbLTAyL+J0K7HZvEuUOhiSahvbHKgNJXN/54?=
 =?us-ascii?Q?Hnn9niIZDMKx96MB2JYRqn5RHHRCsMCdN82KQUcxYlznD0trEWRlReWtKDut?=
 =?us-ascii?Q?+Pbt0/y4hrzoPuTFitiaEoDXhf7CL8nVsn2Fl/hUmxcNedinIk2ox/wZRQSW?=
 =?us-ascii?Q?jrLaNVenJU0t+T49A4PJyLUvWVR54QTCe8Ysd7fHWpYb+VxjzGR/ug6yjWyQ?=
 =?us-ascii?Q?lfeUiOAJLWzb9brMTqyL247eFuGGHqm3c2E0neMk03RwKzaunM7jh6IjudUD?=
 =?us-ascii?Q?KAfzRdwYAKFeMM3aGICwXVjdakmUW/RaGb/d4aM81R92CgzEH6LyoWDSPfl+?=
 =?us-ascii?Q?9B+lD/9cDroNSuBzAO4elPsRE6+YdZiSYwjX1ZFXxy6HGNPX8vvjycj3PWtg?=
 =?us-ascii?Q?9641j4rNwPrIBDuj5I1E8x32eEmQUm/e1sLpq6fmxUw/rIhogVV7bN+E7JXQ?=
 =?us-ascii?Q?8tL8B32lbHRfyW8Mmmfwn5+LlxqDJFBvaWcTzGMQUF6TzQ8YkKgIil4GtO7k?=
 =?us-ascii?Q?YOpSCz9KfJux58LdEwyZcNtbpQEhSDEA5Z/b+k1uJNtjnmNHEG+0AFkcq8Ki?=
 =?us-ascii?Q?GvSHM54gJzalmEQzlSZeADmvBJX6gxvSKV7r0Xl5cPPufB7d/2BNCSayS7x6?=
 =?us-ascii?Q?defIlFmE70jyipHbMFLDPNzLpPxxrB6NCTwkMBMBAFEkWUrww8cuFqdqqu59?=
 =?us-ascii?Q?byRdIdKss5dFcco5FI7QwGdAslLMbH8FVB4JKDk610ph8uxyAn47o9BHgo9B?=
 =?us-ascii?Q?9P0R3/UdRSuVKIIhWYF0PF6w3hr9HfLQSSHxTz8qsSR2/ipJr95QIkqaJ4Bu?=
 =?us-ascii?Q?lDnGOhjJymPpBywINdrSYq4dGGa1OIh1+dcHUKQoIWmuwq0xWMkyp9hk1KlR?=
 =?us-ascii?Q?u1z/1jvSixm6SzlITYoq9hZc7kCj197VdA9RAAwte2KVigCK+nOlGsrcqdc7?=
 =?us-ascii?Q?AfLSskDr2U4a7zB5tAinpjMae/6l1zNNH03P5X92fSr/8+yp2UrxDb/wsBt/?=
 =?us-ascii?Q?BtUgqZukeQMFpafwaZnfPFtADeD+1boy+s+Xnv2ZtvFTEBCxzL1tjdBk1uRI?=
 =?us-ascii?Q?cRGoNeXkwXSM7jRHfgbbd7EBkzaTImh/e3eC/eOwF44ShUrIwPby5p4uDgif?=
 =?us-ascii?Q?nycnX//7ju03g/PJtNfh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d324d0e2-3cf6-407d-02f4-08dd549a4f12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:13:09.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem nodes and adding 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc4..91c062cce903 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -147,6 +147,117 @@ usbphy0: phy@5b000 {
 			status = "disabled";
 		};
 
+		qfprom: qfprom@a0000 {
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0x000a0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_mode: mode@249 {
+				reg = <0x249 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@249 {
+				reg = <0x249 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@24a {
+				reg = <0x24a 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_s0_p1: s0-p1@24b {
+				reg = <0x24b 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s0_p2: s0-p2@24c {
+				reg = <0x24c 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s1_p1: s1-p1@24c {
+				reg = <0x24c 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s1_p2: s1-p2@24d {
+				reg = <0x24d 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s2_p1: s2-p1@24e {
+				reg = <0x24e 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s2_p2: s2-p2@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s3_p1: s3-p1@24f {
+				reg = <0x24f 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s3_p2: s3-p2@250 {
+				reg = <0x250 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s4_p1: s4-p1@251 {
+				reg = <0x251 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s4_p2: s4-p2@254 {
+				reg = <0x254 0x1>;
+				bits = <0 6>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5018-tsens";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>,
+				      <&tsens_base2>,
+				      <&tsens_s0_p1>,
+				      <&tsens_s0_p2>,
+				      <&tsens_s1_p1>,
+				      <&tsens_s1_p2>,
+				      <&tsens_s2_p1>,
+				      <&tsens_s2_p2>,
+				      <&tsens_s3_p1>,
+				      <&tsens_s3_p2>,
+				      <&tsens_s4_p1>,
+				      <&tsens_s4_p2>;
+
+			nvmem-cell-names = "mode",
+					   "base1",
+					   "base2",
+					   "s0_p1",
+					   "s0_p2",
+					   "s1_p1",
+					   "s1_p2",
+					   "s2_p1",
+					   "s2_p2",
+					   "s3_p1",
+					   "s3_p2",
+					   "s4_p1",
+					   "s4_p2";
+
+			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -389,6 +500,64 @@ frame@b128000 {
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		gephy-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				gephy-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				top_glue-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi32-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				ubi32-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.39.5


