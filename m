Return-Path: <linux-pm+bounces-5011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB687E2CF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 05:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A442281803
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 04:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993E1B966;
	Mon, 18 Mar 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eCTIYTQF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974E1AAD7;
	Mon, 18 Mar 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736826; cv=fail; b=cZDiy5goL0BhEX7OQQ+7qyVA2ZJmI3HGHCv9wProPtH45f0KFwYqLnzcYgFsyZ6gwySlw2YteDPMufFzX2HyXYnRkEgdtRV3u8fXE88htq5AFH1EeHUCb1V3tyZtVTT60HdS95xklI9g5S24AS4fjxoKkbn+IAbZWuziBeVcWdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736826; c=relaxed/simple;
	bh=7V8tJNmzZVIM77MEJ4Typx6YV2HjKxspEpp+c+/c2ms=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c3e0TKwvSIP9vD3Xuyzzpb2WjBdzC7MxZRK7Vwbf6B83+INNljClvS0HWW9qle/TImQSS86zl0ciMsNJRGLN7bNPRd+/4ebkkexE2wlbQrH2y+gGols2L7fuV+rjiYBCz7hf98RJ72vGjxtHjqLsrroCCr1VmXD98b9lzEvJ+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eCTIYTQF; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HLjwvL031842;
	Sun, 17 Mar 2024 21:39:51 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skkw15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 21:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNxX37uBTAURI/OIHOkpO86/HJp3s1zfjkrxzTrUGmTCHlnd9/+Auq4Pwt76Uh9sUu4/+4zi9K511rGXNnmniOyoWUajsCwv2DtY/pHYVDeDbvxtg0VCARk1919aLI/BK/kn7gCa6Bs1uJ2wD7ptniKkm4oMkTxRuzaOTglCPtpMrhyeq2h5knLXbbY6VrMtO2l2+rGte/gnmvJTgFiLVen76SFBQ9txjd8vG7uBeI+Cy2elBnsSaaqtAw2SzI6Eudy2gulLphPbA8JkEHNhYBbqqidof1lp5eWPBpj79wa2H+UKbLiJfdes09q79D71eZ+lsdAmipZDgdTd7ppdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXN/wTXj/awE7WKSMXmKiimpKZlPQNuPLWq5McoUEtw=;
 b=YGpGX0qU2nudLxy3n0MYH7yaAUmxp7r5vrL94YiXr4ptZlovcfT+jO3Ueu66yS9CFDaeaQ4buikTU2Fh8gJyeLPxC8RX/FggB7OoLD7W0drr1+w6V8tmned9JiEJUUcHTZOPQjVuxqIV4XBe4qRRAtPYVQs+AXSw0lFiJpUJmyBkpH00OcF9mz1bs3ISaNWS3BtvBHzRbLGk7KrPnklLUa/TkaR58AzeWSloeg4EiQR60GTkVuCz9nkRqHpWL3iAU0ctaLB4HXA1xLDvT6HEPhJx0G+qcKzb9QGOWOeYCExgx2NFg5WSXFy3XBTbVShkTtihVc9HMFv/DHp5ZM7b6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXN/wTXj/awE7WKSMXmKiimpKZlPQNuPLWq5McoUEtw=;
 b=eCTIYTQFJ/EGl0jEJdwgtg6CrIrS1mTW3duYhMP9a5FjTjS2ewAfPPZrSJHVDymvl4y6YgfYqVTbuj4J0tqxwGO+R1pgwFqiLPVEPMSwNFKPsuqqnkUo1pURwgnolcIk1OzkuEvb4wW+guwBuN5ylF/Wy8WFhm8IKvq61zMjBmA=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CH0PR18MB5461.namprd18.prod.outlook.com (2603:10b6:610:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 04:39:47 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 04:39:47 +0000
From: Amit Singh Tomar <amitsinght@marvell.com>
To: Andre Przywara <andre.przywara@arm.com>,
        Yangtao Li
	<tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Brandon Cheo Fusi
	<fusibrandon13@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin
 Botka <martin.botka1@gmail.com>
Subject: RE: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all
 boards
Thread-Topic: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all
 boards
Thread-Index: Adp47hhYEkU3dDRtSqKoG8i992mRTQ==
Date: Mon, 18 Mar 2024 04:39:46 +0000
Message-ID: 
 <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5084:EE_|CH0PR18MB5461:EE_
x-ms-office365-filtering-correlation-id: 52dfddab-445a-4689-9ecd-08dc4705709f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oUL9K0m9pvd6OLTsUAWtYEH1OHXdFgpdUTBM8d0x9QAA06owGiQMYIvyGaO4Ld3fbQn8MrBN59w4QQYEPOd/YGVD1Ke2BK8EA9rKu+1wnpb0OZKVx+5ol/GZrFCXuGqkhSrVWtni4uEe0xye7NOeww2rkdQ3UK1ors2ttWD5+Re/Z2HKUWlaspSHmyVsLq2lGlsZRCWfBMe2Bwjd9X0aCKOCN4EG2/6PrUoeH4MaqrNmNk+3Zb4qO77IsLcSfoKB0RiVTXk8P4jbm0tTqc403EE0i0/4AC6qRmdeod+hok1VxOuEIqerGbAJtpb2BIeN3UFmgrqreC0JnMMfOgQCDORsuQ8/Lx3NRcRN41udGqxq039jxHYII0HiqeMtDyndszYXM1nNTitK7ZCoTa4iiUXvVCEV1+HUwnTUCzcogRRaaD52DT9cHEDP6L2tHQZyCPRNGTXjDb09XVPnnjyQXbVdT8wWPzeakvlfD3rIn9cvWz4nKix+ezo682OcaTVgjg4JYQOGgIoXLsQUCIIoNG46cf6tT5IdCYjDUQh2xpYC8DeeW+p5Pdnf9Gvu7lKAGHA48m+bQK8NpgDAb8Y6inGbIjsDyNAlBqz3Cu2Obf2A2n3XdiVrjArawNnEp9aGCpAEjXOSkQ0oxsYWkmW1ujGL0XmLiHtbjaG13KJUqNMARW1B0bI2nHmtwY1MiaiVluyv/rteGpsczE3rh5ta6eG5irG66RTq20+PKwGWOZY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DsiPLhqLej+GLIHFa68GZbNeHkem4rM6j0TaI9MRIvLHt90FUIYt32vrWOH6?=
 =?us-ascii?Q?qvPffsPE55KSXOl6450NIa9UwBYY1PmOiBT4/PXR2h9zfakdq6MVQPJKxEs5?=
 =?us-ascii?Q?//J+/1m9U5tJph1xqMv0qL44jPZrlpX/y2zQuN9PcpNvicC0aWGhLQgH29R7?=
 =?us-ascii?Q?V89XL2IhE0yHd9yYcAr510yi0BfhggNIu2Eb8fY3OzfU0qBmTr4DFmVnzNMj?=
 =?us-ascii?Q?3UdQia4a+w7wSuA2vxNi9xOaJAgjHRhlGo3Yhw4ReXsBdHQy5r45UdeR8Wiq?=
 =?us-ascii?Q?KMlizmiUTwwCxwH8s4dhAbcnh55Z/bXj/6yon6OYUvhpBJz5LL08ry6xKoXQ?=
 =?us-ascii?Q?SeAmG4veKVH3eXZ66VwkwH/ceyfT9MRvKpbQbdvOEkoIn1CT4Ss3ADSThGSh?=
 =?us-ascii?Q?fNxWy4TmTjgMSY/t6YE+r6mK7A7lsgUtkhcWZoXHHE/TVoxYfo+smtoXsnmI?=
 =?us-ascii?Q?HOHcmP5yWPF0UOe0urKTGlxyavASinmYFe7shCl7YVwD45YHklqLJ5dTjLxX?=
 =?us-ascii?Q?665jMxQJo9FMQ28tvsUW4S3DAwxf8q9MP2XIKyKx0ug8H3fU8CJP/LfHl0xa?=
 =?us-ascii?Q?QuwiQcH/MRy2G7xu+SmLsV5E3e0WDNGr0+sIkzxzLoJQcg9IR4OXPj4IStOj?=
 =?us-ascii?Q?4lrOehN++4rNQ2zW7YQ3CjCtvGBNUzEAH7wL1Fv4pYIe6c7kqVXSapVP9LAH?=
 =?us-ascii?Q?uQAkT5B5HWDTl5etAv8x8AwumKpASnxQXeqEuysWjdZdqinJfIDoW/Hxc6xE?=
 =?us-ascii?Q?bApfSeYSC5wX1gta/EwZBulKBIpbot27F2P7dLPZyc6HUzNCmWQe8Ces4drJ?=
 =?us-ascii?Q?6xO16xqNsAvbAqLvK5W5ePl2nRHwbJd3vbUtGhJgRqrdghO+UwrDBDGzA+qr?=
 =?us-ascii?Q?6y/OsCARqfOGC88buyBm5BYYPqA4f+A/5O3A9+LRamJshXJ3aJlMX4hG+PPX?=
 =?us-ascii?Q?1kO/l2Ee9U2WNH+s7El80K/StgAi70sn2bGvR3CjxyqAs2nZFnQQiaVb1SI9?=
 =?us-ascii?Q?hFJzUxUmzngbTpbphc4uAxnm84b94JeO1h6N73dK+DWZYmie/VGsY0ULM8fF?=
 =?us-ascii?Q?k3wmVWCVzO4aJfXk28mBulbu0YH+ZU3CHniFNiQAoRrd5FKEnoiWT3i7IPFk?=
 =?us-ascii?Q?2mbMWBY8UH0tkUuFNH83U/lwxKtEuzAE4ftKOMRznOYiYOSFZbqKce0Pk49/?=
 =?us-ascii?Q?BWsGg2mGSpsNmRkrVm2LdjAmuPt1/ckQXqF14HFUwWLdAOlAyGL+0evPZmMN?=
 =?us-ascii?Q?sDZlOM9SARNFEGZ4js1khysf/4It5Gkz9qIIBENBq3AD6dSGIp9dMwXR2Mxx?=
 =?us-ascii?Q?5UUi22msOAJXiOhN2P/UDO4eN/f8fJVh5kvDTN20Bp4mVPn/hzCU9ie3c9+h?=
 =?us-ascii?Q?caJ9gGlSE1JMU9ZXGIcx+jc9b+iplsE/X4UyXDW3jbW7QP9e2+gSRae+tFY1?=
 =?us-ascii?Q?CrGAetiqcnma/UeLT1r7tDJOPsv3qL6Rl6nsGnXEUROK6kdreGn6pCjcVPm7?=
 =?us-ascii?Q?ghG2zYqsgJsHL9CwDvh+8KNObMN3+voSL1gy6/aSShVBqGnkwCZDyLKyxc2L?=
 =?us-ascii?Q?9K2/cu1QlmSu20Gln5GqoiYSqBrRpdvSDAY+27MC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dfddab-445a-4689-9ecd-08dc4705709f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 04:39:46.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wA0qZnyUEQuzKcNgUPhvh176WZoVF9qV0UbI6b+OnWc//pE6etwubNeluuvmzPwCSt/NuFC5nrScrx5ySCRSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5461
X-Proofpoint-ORIG-GUID: 7QRPzjrQJALnjbtcnbOTdulW0qVYPmlD
X-Proofpoint-GUID: 7QRPzjrQJALnjbtcnbOTdulW0qVYPmlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

Hi,

-----Original Message-----
From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Be=
half Of Andre Przywara
Sent: Monday, March 18, 2024 6:42 AM
To: Yangtao Li <tiny.windzz@gmail.com>; Viresh Kumar <vireshk@kernel.org>; =
Nishanth Menon <nm@ti.com>; Stephen Boyd <sboyd@kernel.org>; Rob Herring <r=
obh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>=
; Conor Dooley <conor+dt@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej =
Skrabec <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>; R=
afael J . Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-sunxi@lists=
.linux.dev; linux-arm-kernel@lists.infradead.org; Brandon Cheo Fusi <fusibr=
andon13@gmail.com>; Martin Botka <martin.botka@somainline.org>; Martin Botk=
a <martin.botka1@gmail.com>
Subject: [EXTERNAL] [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS=
 for all boards


With the DT bindings now describing the format of the CPU OPP tables, we ca=
n include the OPP table in each board's .dts file, and specify the CPU powe=
r supply.
This allows to enable DVFS, and get up to 50% of performance benefit in the=
 highest OPP, or up to 60% power savings in the lowest OPP, compared to the=
 fixed 1GHz @ 1.0V OPP we are running in by default
at the moment.
[Amit] Could you please elaborate, what test were run to see 50 % performan=
ce benefits?

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi      | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts       | 5 +++++
 .../arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts | 5 +++++  ar=
ch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 5 +++++
 .../boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts     | 5 +++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi=
 b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
index 1fed2b46cfe87..86e58d1ed23ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
=20
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -62,6 +63,10 @@ wifi_pwrseq: wifi-pwrseq {
 	};
 };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdc2>;
+};
+
 &mmc0 {
 	vmmc-supply =3D <&reg_dldo1>;
 	/* Card detection pin is not connected */ diff --git a/arch/arm64/boot/dt=
s/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/=
sun50i-h616-orangepi-zero2.dts
index b5d713926a341..a360d8567f955 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
=20
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 / {
 	model =3D "OrangePi Zero2";
 	compatible =3D "xunlong,orangepi-zero2", "allwinner,sun50i-h616";  };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdca>;
+};
+
 &emac0 {
 	allwinner,rx-delay-ps =3D <3100>;
 	allwinner,tx-delay-ps =3D <700>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 959b6fd18483b..26d25b5b59e0f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
=20
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -32,6 +33,10 @@ reg_vcc5v: vcc5v {
 	};
 };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdca>;
+};
+
 &ehci0 {
 	status =3D "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
index 21ca1977055d9..6a4f0da972330 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
=20
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -53,6 +54,10 @@ reg_vcc3v3: vcc3v3 {
 	};
 };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdc2>;
+};
+
 &ehci1 {
 	status =3D "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index b3b1b8692125f..e1cd7572a14ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
=20
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 / {
 	model =3D "OrangePi Zero3";
 	compatible =3D "xunlong,orangepi-zero3", "allwinner,sun50i-h618";  };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdc2>;
+};
+
 &emac0 {
 	allwinner,tx-delay-ps =3D <700>;
 	phy-mode =3D "rgmii-rxid";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index 8ea1fd41aebaa..2dd178a164fbe 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
=20
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -41,6 +42,10 @@ reg_vcc3v3: vcc3v3 {
 	};
 };
=20
+&cpu0 {
+	cpu-supply =3D <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status =3D "okay";
 };
--
2.35.8



