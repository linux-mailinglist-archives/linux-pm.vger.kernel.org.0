Return-Path: <linux-pm+bounces-18160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D99DAAAE
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259A1281D83
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457C200B80;
	Wed, 27 Nov 2024 15:21:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021140.outbound.protection.outlook.com [40.107.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DA200125;
	Wed, 27 Nov 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720888; cv=fail; b=A8Jbiq6WMQDv12vvQN1MQM4tJ5Xv+m0Cek5nr8f/QzrmaRY97AoVj58L84N3gj0Mehp8fYW9mFsK6AMlPQxAWiDmnG4Vuk/B0dBveRQukocxG9de0wnNZTBZPKKT6xfmL/LVMsY32h+R7Q7JpwaTbSa6XXbiKf5oAkg7bsYH7mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720888; c=relaxed/simple;
	bh=mau+iyuetsEtFoNABVJmJ0TbAVrxJOFmwYpu4368+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxbH56DdcDp8uc+n6fbKdQDWBkM+40bWMVPN4yrgPLIjL9Zuyt9JiVwrqekoczTm6mZ4eUJQspo+R4IPTq29xkiMSx3rHPdUsOc0wffXkm0ZZFjpgsfCQ0bKKpLeQsKZNhGYukazCMuAJab9B6EtWARw2v2KsFb/EDx26fCr3B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNzb7dIxxR/bUzgO2jDtwVqaaQAtHFL7jSG2z+AoFqCCqWcNA0sJdi/6G23KS8zlyHVneVeQh/RQCbx2Yw3B5ZMVexzie/py5SLRrTK5y/xjIiEoRL6uBOpzIP5QoWYToR/yZ0zMFU4mA+7uQH2dK3AxWfP7eBGEvCKZGu4yGEfDNFWSZXLz/LMb+ryqya/uEmvGg8HhbeT3KycQxywEBPHGUxQCJmnCD99zZcK0o7eId3BgQbWmxBIC0Xvpfwe2LXAvHw9+irVqDzTpIyTDOIMp2Cg3KTZjySdcNT8b3ZLCU1hXkNXXHGDT+geUUf9lzrT+0v3uwWcUHelr2if1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK4MTa/RnYMfcXBca8nC2RySfY2e31JDZBNwFQB65FE=;
 b=RUkZ9eCvjczwCoZZVj6AQqeSs5UexMmFit5genjMjY+1lPQTj8MBpVM4fnF0Rpr97cWypGD91uTcLiBgW0mJoMMvpD9/zL4q4991d887hfh9v6iaZsWtM8QME82QpIBdaWJ586qkOe0es4wRYrCyijPV/Nfi0W50YpDcl57794duLU9aG8I7c+0OnaN07HtrXiwr0P7/rRsLtV9d8EaDBE4N55ShlHfcJe3hjx41DYi0myNtYR2wlM06UBXsWABaDiazNuDqenhkc5/Ex32svnwvfRNjTGUKUc2LLCi0WkgziSt79r4dvDhq6+qJ9efVNasm8HFWMah/DHBlVhAfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN0P287MB1989.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 15:21:24 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 15:21:24 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Wed, 27 Nov 2024 20:49:11 +0530
Message-ID: <20241127151953.29550-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN0P287MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee63c72-df99-456a-7e1e-08dd0ef727fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?goqT13hT3OShLh6TH/i769h7KXKW/pLv9xw+ISb7mDE/tlL/6pgL/efS3mpX?=
 =?us-ascii?Q?1KciTTzWOPQM50tl2Z8YCm4v3DUBr14MBDY6kVFt2pCOmgqHAKOb7/4PWHnk?=
 =?us-ascii?Q?wjpLMdNtOhcyzNEBEylSigU0Ss/23FmuYAbQmGWLd/pBjBQPpdCvqOFk+gVV?=
 =?us-ascii?Q?BE0i5Df4MkrGEX0trszYLOK9ETqJEZvI+5H+uwOzz9b7FCTs2IvY/TQ305h0?=
 =?us-ascii?Q?ZbcBpoVSaJI80jprSOShvtE7zBcRnBwwqW+QVAWOiGMpsZI2SOvnJwNOZbV8?=
 =?us-ascii?Q?lFga4evSKqaAnqE24WhJ9J3nLvCNVNDKzftc28jyeMf6W1Pw3Sqa0rJ2c6Pa?=
 =?us-ascii?Q?GNVJTiVcY6fFO44+229AWYugvZTiyPtNlo2DSBym9bC3XBMu9fx3/F5v1Z8N?=
 =?us-ascii?Q?BQlZqsnAPKfcqBkdhdRy5SVGseXmtV0e32Dnv+gPevnw5UNC2C65aDN2fmKi?=
 =?us-ascii?Q?4GOyiDT54CJt8jyhJNKJYUSmcFAhsQzyaO7aKLaoVAC9hmnuNiux+0l1xU8J?=
 =?us-ascii?Q?tHrvAfJzyWYP/LXq7Q6d0+H3suWTBStjkcEmvd23aMg22iLlkUmUPKUtFaaO?=
 =?us-ascii?Q?Y/YWTjx9SAUmCsG4B09AWeWQrXaNNq6F23lhHEeDIx0Lvjx32jrGlYzVlhiu?=
 =?us-ascii?Q?fLGqh/HELU9fkYT5moTjeKWfwPDKqUK3AWGYJSQj6BzD61+9o0RLQOU7bQ+S?=
 =?us-ascii?Q?ugQsT9hqXW9eQ3LGaPjiG0NJtwg+L5aS+pLRiu1yX3wNHOKqaDcTtvCAWE0P?=
 =?us-ascii?Q?oyioGUGCKYcntjzReEDhR3yyHGvIIRYomsL0pT9e9rpLIQht0zm9UkSAB6uY?=
 =?us-ascii?Q?Z1fMdnA/MuXfvqfPNyrVxmLQnnlKZgqv635s8Lt6hgIhWwVDos5RqeBFwQDO?=
 =?us-ascii?Q?GpS78sU9Ljwte1USpzMirwtb1f4/f6t+hjgaUgwmxOZQ8B1YCBt8XkUSbAhK?=
 =?us-ascii?Q?yFC3PvJa12Hrct4Jd3bUzNEaDZG8l1M4g/qSHTC1mxNbnq/XQpPzN0RWv8YV?=
 =?us-ascii?Q?Hrb3heWUWdyV7FZ9gLXK91QeWqrf8Nnin1QEbiY5gnRvMzmaNbyq92EFf2JF?=
 =?us-ascii?Q?v7zRr1cnvB+6UM8Mt24sx0yPAsjwWPAE5R+L9rMP7R5msn2fkuF/D7wO9xgu?=
 =?us-ascii?Q?vtR0vI+ZKjDdxcwzQ0Fs+RgdOqSLshOkq49RhdwwW/dyD0ak5J8GUbYTxuVq?=
 =?us-ascii?Q?lRq2pEFjZcns3AnB97NGMcm/mJWBQAmfJRy4xqnMFzO/Nue1RtMkRQZFfueV?=
 =?us-ascii?Q?Ab1tRNtB6eQu+6hPVmUfdgglP0jyr5JMnVm3Lfwp/64adfKh6lrajE7Aon9o?=
 =?us-ascii?Q?0qhO0g0wRgM5ybt3F/UvVBBmSF7cnspmc0phfRR73vL978n5z5H1XbG6IXjB?=
 =?us-ascii?Q?dDKK7KVXuALx69xYhJrQqoBghkeWo7AfFu6y08LkKi/H8nNkbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKOYJ9CeSgPC3GSc6UywZT96NDqCaVuCPGB8dD1tIBMHw+3zngiHibJ1i3tY?=
 =?us-ascii?Q?1wzIHRaXPuYj0J1YqNqzcWtxV9SDoJWeyqEap2dePmjD8ycE5P3HCD7BHBUt?=
 =?us-ascii?Q?wopNx1i5p44PEGPDgGJ+pA8OaWWA/Ar58n37W8C+g7g0Crh4D/EKJplhDsU7?=
 =?us-ascii?Q?mjtyfrV3PvqJp+Z3okRwbRPZeU5LJVB6qTjb8i9WgDmJiyLWIVcrU0C/i9gM?=
 =?us-ascii?Q?9r2037TNyBkHkz5LCL6cfZnvAMEnUMNZUM0tFY8fgzOY6MkPfByq+D21YhHc?=
 =?us-ascii?Q?6j9brmHqrjQMYi4fb106wt42ApGgkQjZ66et/SB5oHBUX346CNmiyN/vyjpz?=
 =?us-ascii?Q?UY9vLlV+qPyLg60ANJdkyj8MHtishQ76cYXD/8s5qsWcC9XhAYlwvWmZD3C7?=
 =?us-ascii?Q?/hC11ZBAJpcy04i+5TPziF5xzALmuM06vEz0sI3IdJzMHFsPvKVQwcQa+lF/?=
 =?us-ascii?Q?qYVHvf4zgzhWJT8PrUdxvSHqWjGK9nVC9ng7QF67d1AYxsCEThKZoD7wAR2/?=
 =?us-ascii?Q?rMRwkJTr7sjLv9XRXMHoUrGanqdub00NL7IIQxPha5JM/jLOWAQWeb4fUate?=
 =?us-ascii?Q?CAsbWgVSJqlwfO3oE2xMeOsWgLHyr2VKFkjodV0gciQ1YrI7N204wy8+zXeW?=
 =?us-ascii?Q?w2tfhlaWHlnZWMiVX2sgkNdcqG6FdwZxyHSXe8GTgri6ITCyAOCwWsPY6Nor?=
 =?us-ascii?Q?74PWHTprJEaDEOu1ApmwIUBuDrMPTbLVtXWeBgheQbO5Bk5vBFZ0u+Wtf5mF?=
 =?us-ascii?Q?UluVmujQYc1JjGP4ngeHfrkE5SMDkh/UqusYedQYroT5FyFYNuk/VDXNEvz5?=
 =?us-ascii?Q?Z/2IIO0I8H9bYP1OacGb+ZFIE5R7bHbkCaYzLnmSIme5RAH+1Ff9vrXUAXDq?=
 =?us-ascii?Q?wnXBUTBAtv/yhHV1XR5yEi+9SgNMfzLckcUZlQ14U1mZikFhMbGuswqhyjUL?=
 =?us-ascii?Q?COw/W8r/MJO3mXLYeM+ve10Uh5KqMNwrSeKP43dw2C/56mrUPXald52N5Ne/?=
 =?us-ascii?Q?Z3wutOQsPameeP+VB2+wjMyealJh5BHpK/Koys/dgme59LPqRdiuQCT2uz7v?=
 =?us-ascii?Q?Tl3WF14AzbjpQWgacyf2DHl0P+HPIxQwrV9cgmyDco++ifSpnvbeSIG7tkUR?=
 =?us-ascii?Q?qVuKe/Eb2e4GoCT2LrkvBouyIugxrmYIQuwcoENJ8B5Yfn3Yreolldc09Y+k?=
 =?us-ascii?Q?vi+hzI6Yr00c22vNluu7/ZH5xren5yP+TBRXdYQbTu7rTsvOmSyAtWYb61Ee?=
 =?us-ascii?Q?Vb/Nr27gQD2XvCvTkv8dYmBz7bbimoZ4LM/+Q+nGvbfaXQWCozZhh1UX5VHk?=
 =?us-ascii?Q?ivnTg4YSf/S5Q+gTzs2hXCCTipgcSiRakD/Aeg/LFhnwdTKqzulht1on1wNq?=
 =?us-ascii?Q?Z7zGQ49nE53XlkbSrxT+VWA2G+2DdGfIOrgl492Kg8N6DxnBjOMUpDdF9pxR?=
 =?us-ascii?Q?QShZKMV/VIyPzYJZ7cPP1rn606NNNgNMPb66stRhrILSrBeWCV+JDBGRjlrh?=
 =?us-ascii?Q?HPmMHhDqm/9d6sjzQPkWsafaVWh+M2JP/ysX7R2raj8AB6Gz0UDLwNj0RySS?=
 =?us-ascii?Q?ZbQQKdqJlyVyKTLj3RQO2t2kjyW9sWbChPV5EqvLUWhNZaulUayemh+GIH12?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee63c72-df99-456a-7e1e-08dd0ef727fc
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:21:24.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVeOZxSGfOizgEmJDgmDxANyZSEWUhawVeNbU6Abt53BI6QT8jYzN3TfXood6qwdSGvVSkSh6Z/gFtlGK7nedCvm/1l4ITa8bCpGtOD98Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1989

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 625 ++++++++++++++++++++++
 4 files changed, 641 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 82161bc70b51..42c1af29eddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21855,6 +21855,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index bcfa63fb9f1e..6ad968fa1f69 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -908,6 +908,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+	tristate "STMicroelectronics STC3117 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for fuel gauge with STC3117
+	  PMIC chips.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 8dcb41545317..aea3d35f27f3 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..99291bb9250f
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +-2,622 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/crc8.h>
+
+#define STC3117_ADDR_MODE                       0x00
+#define STC3117_ADDR_CTRL                       0x01
+#define STC3117_ADDR_SOC_L                      0x02
+#define STC3117_ADDR_SOC_H                      0x03
+#define STC3117_ADDR_COUNTER_L                  0x04
+#define STC3117_ADDR_COUNTER_H                  0x05
+#define STC3117_ADDR_CURRENT_L                  0x06
+#define STC3117_ADDR_CURRENT_H                  0x07
+#define STC3117_ADDR_VOLTAGE_L                  0x08
+#define STC3117_ADDR_VOLTAGE_H                  0x09
+#define STC3117_ADDR_TEMPERATURE                0x0A
+#define STC3117_ADDR_AVG_CURRENT_L              0X0B
+#define STC3117_ADDR_AVG_CURRENT_H              0X0C
+#define STC3117_ADDR_OCV_L                      0X0D
+#define STC3117_ADDR_OCV_H                      0X0E
+#define STC3117_ADDR_CC_CNF_L                   0X0F
+#define STC3117_ADDR_CC_CNF_H                   0X10
+#define STC3117_ADDR_VM_CNF_L                   0X11
+#define STC3117_ADDR_VM_CNF_H                   0X12
+#define STC3117_ADDR_ALARM_SOC                  0X13
+#define STC3117_ADDR_ALARM_VOLTAGE              0X14
+#define STC3117_ADDR_ID                         0X18
+#define STC3117_ADDR_CC_ADJ_L			0X1B
+#define STC3117_ADDR_CC_ADJ_H			0X1C
+#define STC3117_ADDR_VM_ADJ_L			0X1D
+#define STC3117_ADDR_VM_ADJ_H			0X1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/************ Bit mask definition ************/
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE				BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                      0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define RSENSE					10
+#define BATT_CAPACITY				1800
+#define BATTERY_RINT				60
+#define APP_CUTOFF_VOLTAGE			2500
+#define BATT_CHG_VOLTAGE			4250
+#define BATT_MIN_VOLTAGE			3300
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
+#define CRC8_TABLE_SIZE			256
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+enum stc3117_status {
+	BATT_LOWBATT = -2,
+	BATT_DISCHARG,
+	BATT_IDLE,
+	BATT_FULCHARG,
+	BATT_ENDCHARG,
+	BATT_CHARGING,
+};
+
+/* Default OCV curve Li-ion battery */
+static const int OCVValue[16] = {
+    3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+    3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 TestWord;   /* 0-1    Bytes */
+	u16 HRSOC;      /* 2-3    Bytes */
+	u16 CC_cnf;     /* 4-5    Bytes */
+	u16 VM_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 CRC;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct delayed_work update_work;
+	struct power_supply	*battery;
+
+	u8 SOCValue[16];
+	int CC_cnf;
+	int VM_cnf;
+	int CC_adj;
+	int VM_adj;
+	int AvgCurrent;
+	int AvgVoltage;
+	int Current;
+	int Voltage;
+	int Temp;
+	int SOC;
+	int OCV;
+	int HRSOC;
+	int Presence;
+	int Battery_state;
+};
+
+static int STC3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE, reg_list, sizeof(reg_list));
+
+	/* SOC */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->HRSOC = value;
+	data->SOC = (value * 10 + 256) / 512;
+
+	/* cureent */
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->Current = STC3117_convert(value, CURRENT_LSB_VALUE / 10);
+
+	/* Voltage */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->Voltage = STC3117_convert(value, VOLTAGE_LSB_VALUE);  /* result in mV */
+
+	/* Temp */
+	data->Temp = reg_list[10];
+
+	/* Avg current */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = STC3117_convert(value, CURRENT_LSB_VALUE / 10);
+		value = value / 4;
+	} else {
+		value = STC3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->AvgCurrent = value;  /* result in mA */
+
+	/* OCV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = STC3117_convert(value, VOLTAGE_LSB_VALUE);  /* result in mV */
+	value = (value + 2) / 4;
+	data->OCV = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L, data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->CC_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->VM_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM, ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+};
+
+static int stc3117_update_battery_status(struct stc3117_data *data)
+{
+	switch (data->Battery_state) {
+	case BATT_CHARGING:
+		if (data->AvgCurrent < CHG_MIN_CURRENT)
+			data->Battery_state = BATT_ENDCHARG;
+		break;
+
+	case BATT_ENDCHARG:
+		if (data->Current > CHG_MIN_CURRENT)
+			data->Battery_state = BATT_CHARGING;
+		else if (data->AvgCurrent < CHG_END_CURRENT)
+			data->Battery_state = BATT_IDLE;
+		else if ((data->Current > CHG_END_CURRENT) && (data->Voltage > BATT_CHG_VOLTAGE))
+			data->Battery_state = BATT_FULCHARG;
+		break;
+
+	case BATT_FULCHARG:
+		if ((data->Current > CHG_MIN_CURRENT))
+			data->Battery_state = BATT_CHARGING;
+		else if (data->AvgCurrent < CHG_END_CURRENT) {
+			if (data->AvgVoltage > BATT_CHG_VOLTAGE)
+			{
+				regmap_write(data->regmap, STC3117_ADDR_SOC_H, (MAX_HRSOC >> 8 & 0xFF));
+				regmap_write(data->regmap, STC3117_ADDR_SOC_L, (MAX_HRSOC & 0xFF));
+	       			data->SOC = MAX_SOC;
+			}
+			data->Battery_state = BATT_IDLE;
+		}
+		break;
+
+	case BATT_IDLE:
+		if (data->Current > CHG_END_CURRENT)
+			data->Battery_state = BATT_CHARGING;
+		else if (data->Current < APP_MIN_CURRENT)
+			data->Battery_state = BATT_DISCHARG;
+		break;
+
+	case BATT_DISCHARG:
+		if (data->Current > APP_MIN_CURRENT)
+			data->Battery_state = BATT_IDLE;
+		else if (data->AvgVoltage < BATT_MIN_VOLTAGE)
+			data->Battery_state = BATT_LOWBATT;
+		break;
+
+	case BATT_LOWBATT:
+	  	if (data->AvgVoltage > (BATT_MIN_VOLTAGE + 50))
+			data->Battery_state = BATT_IDLE;
+		break;
+
+	default:
+		data->Battery_state = BATT_IDLE;
+	}
+
+	return 0;
+}
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM, ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i, OCVValue[i] * 100 / 55);
+
+	if (data->SOCValue[1] != 0)
+		regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE, data->SOCValue, STC3117_OCV_TABLE_SIZE);
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+						(ram_data.reg.CC_cnf >> 8) & 0xFF);
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+						ram_data.reg.CC_cnf & 0xFF);
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+						(ram_data.reg.VM_cnf >> 8) & 0xFF);
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+						ram_data.reg.VM_cnf & 0xFF);
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int ID, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID)
+		return -EINVAL;
+
+	data->CC_cnf = (BATT_CAPACITY * RSENSE * 250 + 6194) / 12389;
+	data->VM_cnf = (BATT_CAPACITY * 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+
+	data->Presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return -EINVAL;
+
+	if ((ram_data.reg.TestWord != STC3117_RAM_TESTWORD) ||
+                (crc8(stc3117_crc_table, ram_data.ram_bytes, STC3117_RAM_SIZE, CRC8_INIT)) != 0)
+	{
+		ram_data.reg.TestWord = STC3117_RAM_TESTWORD;
+		ram_data.reg.CC_cnf = data->CC_cnf;
+		ram_data.reg.VM_cnf = data->VM_cnf;
+		ram_data.reg.CRC = crc8(stc3117_crc_table, ram_data.ram_bytes,
+                	                        STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return -EINVAL;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if ((ctrl & STC3117_BATFAIL) != 0  || (ctrl & STC3117_PORDET) != 0)
+		{
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return -EINVAL;
+		} else {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return -EINVAL;
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H, (ram_data.reg.HRSOC >> 8 & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L, (ram_data.reg.HRSOC & 0xFF));
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.CRC = crc8(stc3117_crc_table, ram_data.ram_bytes,
+						STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return -EINVAL;
+
+	data->Battery_state = BATT_IDLE;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int ID, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID) {
+		data->Presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return -EINVAL;
+
+	if ((ram_data.reg.TestWord != STC3117_RAM_TESTWORD) ||
+			(crc8(stc3117_crc_table, ram_data.ram_bytes, STC3117_RAM_SIZE, CRC8_INIT) != 0))
+	{
+		ram_data.reg.TestWord = STC3117_RAM_TESTWORD; 
+		ram_data.reg.CC_cnf = data->CC_cnf;
+		ram_data.reg.VM_cnf = data->VM_cnf;
+		ram_data.reg.CRC = crc8(stc3117_crc_table, ram_data.ram_bytes,
+                                STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0)
+	{
+		data->Presence = 0;
+		ram_data.reg.TestWord = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		if (ret)
+			return -EINVAL;
+		regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+	}
+
+	data->Presence = 1;
+
+	 regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if ((mode & STC3117_GG_RUN) == 0)
+	{
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return -EINVAL;
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L, (ram_data.reg.HRSOC & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H, (ram_data.reg.HRSOC >> 8 & 0xFF));
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return -EINVAL;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->AvgVoltage = data->Voltage;
+		data->AvgCurrent = data->Current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING)
+	{
+    		data->Current = 0;
+        	data->Temp = 250;
+	} else {
+		if (data->Voltage < APP_CUTOFF_VOLTAGE)
+			data->SOC = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->AvgCurrent = 0;
+			data->Current = 0;
+		} else {
+		       stc3117_update_battery_status(data);
+		}
+	}
+
+	ram_data.reg.HRSOC = data->HRSOC;
+	ram_data.reg.soc = (data->SOC + 5) / 10;
+	ram_data.reg.CRC = crc8(stc3117_crc_table, ram_data.ram_bytes,
+        	        STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return -EINVAL;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data = container_of(to_delayed_work(work), struct stc3117_data, update_work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+				enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->SOC > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		if (data->Current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->Current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->Voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->Current;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->SOC;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->Temp;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->Presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	i2c_set_clientdata(client, data);
+	psy_cfg.drv_data = data;
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	ret = stc3117_init(data);
+	if (ret)
+		dev_err_probe(&client->dev, ret, "failed to initialization of stc3117\n");
+
+	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	data->battery = devm_power_supply_register(&client->dev,
+						   &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		dev_err_probe(&client->dev, PTR_ERR(data->battery), "failed to register battery\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.43.0


