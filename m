Return-Path: <linux-pm+bounces-32403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE8B269C7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC13A51A4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D341DB34B;
	Thu, 14 Aug 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KgL+BFjs"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BA321444;
	Thu, 14 Aug 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182229; cv=fail; b=ApYcU3ghpNQUXXVnGaVjEZLdcuaR96R+XP7rvJac1EbrEwXzZHn94elnBbNo0WjLo+Uf19mhskXfgM9y6PAfawevRczoWK2rdCGmQPmjhmL/IoqFm+up/e3Tk9d0xO0Odte1frmhEAz5/xODl74Dx1ivZFxa3DK58Q4u+RwZolY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182229; c=relaxed/simple;
	bh=qkPOIIGlQaWn5nbGcuMIiwd7BYhoWrQ4zS1Hz80Q044=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uDLfFvJPG7qJ3eFiaCuOoUBXO/J5E+cG/8JYNewBPv0zjgvZ6CkT20dJKMa5rUx71KetqPI3yQwtbvnQURec9JuOOBpXQk7GyXHdaC7KY4O93y+1pRJ3bqVGK7xQ273BSUaYzdneTJJf9orRCBBx1QiJ3vYkC7OaAn8pELaYFX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KgL+BFjs; arc=fail smtp.client-ip=52.101.126.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOxxbpT+k3ldUaoospFTc9C6Gy1x8oY7fq8JxZkSUSINZnVbJUZa8GUNW69Aamqbaax1i+9ddI8UFPhJf4cWlKn4aJAoJBVbvrBJv9oxfOoiCqM41UF28Q9d8UTf2dCyR2n7PBky774mPpPC2dDluuuOQEmShmYOLmKqKe/ZWQMN23uuIKHzb6D5FxocgyE1JYm8Pwn1Jdpigf0vKUGaMx0+97VgKWops1fy3OcctoyjbMSam3cs7IX/X4QP7+mcfbg6tKBqADPxM6UYZJj7FgJ6VOF5MeXTKOmRYbWs20ffgRY7ccitP5yapmD1yV6dcMno5lramZ/676YQmD1kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q29PkREqP7js9u5rioqRazg0SEAADllhsTxV88AGPgE=;
 b=suSlsHZ5RYnezK+NfeY0Jn6kpicuRy0nRpeJGpxmgZg+C412R4FzeqF3CnJCzSSb2hE/sTr+a0kHhP64Pmc9KWiME0aNUvihObYC45d9Y/CfxN2Yh1mSbZVVKmQQ/N6e8IpbVCYx6l51xV6biBYnV+heyx+nhVeOD2AmISSOaos/qsa2s/933JHs4Ooy5lKL1npogAar0rqCir4RITNUrNATQQ+6wzLCSP1Ik7TeUjLpJeBGzXzmyVdJKaBOckzVCA7T8TP0AdOyo4MrUtSYfsPsCZnNFpkgHWfKvt5ss2gZ0TwqVmwfoIAvdl5Xfw0eCR0miFyBTaQQJdm8mkmd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q29PkREqP7js9u5rioqRazg0SEAADllhsTxV88AGPgE=;
 b=KgL+BFjsi6Rlgz7EoVRhdbQmWglqIsn0dSvNohLtxsly4lAW/wPRKzMMwlykwyDA1Bhdbv1DEW9ErVpsBQ+ksG+1uH1FB98uMl8AQlC0Y1sY34+pOOomAsD4i+vQycy/TrDn0/eexfKkeJNWv275cF0bM0Xq5gZhY9Beag6oEgd13OG/eM+d+Y87wOjeu5kHmtkcJwC3UkzuEiiHR/IjzCOkgXU/731uyF2P8mFYRkJ8L/3eQmyBblqsT8qwTIKbQLe9ypj8QRVGcDoxGgSz6mH3q6gsZq3kexsP1n5a85mJdEzQ9S2UEU7niRr8tjfMjfbc7wAY5AGWLPpo+2Xd/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5733.apcprd06.prod.outlook.com (2603:1096:400:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 14:37:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:37:04 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] power: supply: use max() to improve code
Date: Thu, 14 Aug 2025 22:36:53 +0800
Message-Id: <20250814143654.289715-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1c5869-6068-4cc3-c58d-08dddb40098d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kcmi7ZGc6EWlwemmsAVLIPUZtb3kv2+58sb+nT1W244i2GilFA1DdkRzONB0?=
 =?us-ascii?Q?P/dTNzbzMyCQ685tIYc8S3w2+hYZjqo2W1p4TbLbACuwyaRF0/oo/1q3yapd?=
 =?us-ascii?Q?Yqe3FxwgvR637+2/+EnJizfsvhZ7W++ZncGn6QWJe9YoskrZAYxnJcGbX9vX?=
 =?us-ascii?Q?Gvm7eyfX2M8hV0mHvHhu/VRvqfFruoaaLTfgOXT96Yh8wqCZwwTgmwoWyNpf?=
 =?us-ascii?Q?z7Q+j8vC/RMwh5oI88/zPn/dRqvHqOgVcWsy1zdsy0pR+eOfklDepemCh+NU?=
 =?us-ascii?Q?qu2baRyI1iX2aefhEIUVB+Z00qn3/lvcUAs39Lp5pGIyrUZbYxJoYuAqwi/G?=
 =?us-ascii?Q?Qc1mxS2xKjSa0Sm3Y7+Pi3rHlz/e3cOQCvJQtjZ88gAQuykrAusdvIJty2Y6?=
 =?us-ascii?Q?1gF+PVQJWLVwottizvhRq5jU8bthF7A4rKc9aOGUdMnS3WfRPPtU+f4pgUD8?=
 =?us-ascii?Q?coROTeLMsbHZePNYKeKAltrWC+B1j/SZmVaaRcXg2QruHWKHbsq6F8RF5T8p?=
 =?us-ascii?Q?0P3mPXYBIOtKiidjeg2up3zOFfHFO0kvvH5KJ5Xe7rJZ0QaWAjjBCH+F5BMP?=
 =?us-ascii?Q?/6tjhFH64xSKmOVOl2LuAKVpmMT6FCHnZQNgzioWpTCpe7An5NbxpQN02eda?=
 =?us-ascii?Q?PsZYQUVaAptWaJx1zUABGq5zAxeXblis+7JzmzN4tcPvuBbE+8IyHRYKf41k?=
 =?us-ascii?Q?FSf92wPm6I4Ju8fxaKHILzhKb/rsj8DTDi2HS2zqhVNUyGbm/vXkWh7cXVAr?=
 =?us-ascii?Q?V3yOA/4z5nsrbWmozNLlJ0O6O28niyeEPLd1fDMWWJ2xj0IGJsKDrehsXP4H?=
 =?us-ascii?Q?WMrDhEIKPbAyrlZqRnx3C0dilxpnHsL5nv4uosumh9MNlpfjXcX8mV/BZr9e?=
 =?us-ascii?Q?LotQBCOF7ei1NsPt+jqAzrjo3hytzZ2zaJ2gh4rkdbykNQxta67m8WtQJAwX?=
 =?us-ascii?Q?5ieAXBfPnvRUQyAcajfKFQsdJl9qtVy4SPIyi4Y9uFzyVJGH+E2qNfSVOnlM?=
 =?us-ascii?Q?irvG+JGOVfsIJXaOJZgnpDVi3qetMvJj9tFJf92+oX/ws9/PJV4+Ay/aQ2dN?=
 =?us-ascii?Q?bfU7MOWBBkH5l0K6+AfApZFCnFgnCW8CWKkgjQFO+hFWrCsDqMKXj4g53yog?=
 =?us-ascii?Q?ZFY4retudCuQ9/uvj3hQDDofDE2P7I5BpFHgnJdeA02ARzy2+vvJyLwgutJu?=
 =?us-ascii?Q?vR7/hKlJg6R1qk8FFhEwsO1DluPuh7KwyPyoSASqBRQ2wbox2GEqlikn4xQO?=
 =?us-ascii?Q?zixMHuA2M8HZQtQKFJSjXW9sLU2t/vGLYN8RqQFSYqye5mJ/1EHRDW6G9V0C?=
 =?us-ascii?Q?gUO5sbH1hk0u0xp0XR7r61jiq2nsrRP0l3OVH2OFiw3hxR/sfXQHG4UniIoc?=
 =?us-ascii?Q?s51UNlvGip8hhhtKvxYJqoiE+4MLMh65CbwcxrVfueuPCW22QJxZ46K2+1IS?=
 =?us-ascii?Q?YtXAz3bYUNataGouO4CTOGp53wFndiAhJAUsXWgPDlvJ9N8jVGBHEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmN8Nv6LmdQ13G+CXzVi6qerA0muDVW35Ysazm/JG2ydjHG8Au0np98GrMYS?=
 =?us-ascii?Q?1chY+D5yQG6KxUbY8Y/yyub7ecLPKpY+xaxseEGgq50ULyIZcTZNSP/YX4sJ?=
 =?us-ascii?Q?FkCw/azNZFOHOKXOkFq//3FGwHvKvMmaftoZ6mXItOdSZDoYCZHSVOSQxv/w?=
 =?us-ascii?Q?oAMrR6aKsza8SlkVgBUi6XvC1fAOwCtzAYgeINihSY4eiKhzwLKg1EqIcJJJ?=
 =?us-ascii?Q?7/gKxePL0cOeny0K/HklKrfD2sFldi3VqQhWDNLtNzLEUhTg80TVcZq3cc8Z?=
 =?us-ascii?Q?4/3t0fEG0bwYXCnCGwAGixDub2ilnZimAT2Zwrz4RPnrC/tQfqdMnPCW0F7X?=
 =?us-ascii?Q?3+9rU4vpvwOK69gWPjzNa5y8g4D7ydPESKBl0tQ67S52f9W1SyPLJsXifI+3?=
 =?us-ascii?Q?ufoSMoDZFaFeYXLf+AMCqof5j/TmS/b/eo10yUha0UKbjG0oMqMXmcuBThMN?=
 =?us-ascii?Q?luWPSQ7Uyk6WKPYWhEaAqFx5pqx1t1NmqnH8xOCaB8AljKiBRLc5KEBCej6w?=
 =?us-ascii?Q?rn5yRcoOYkJat6iXY01zcG6CTTvnQRUwTIsNctSSTJgCLRVLQsx7WhabPgUT?=
 =?us-ascii?Q?LPuKvyrUWs+rAi0VfJm3o3qRCsxq0Ny+NYo/4/Qz7Kj4AcFnEoAB7DiykpuM?=
 =?us-ascii?Q?lBL0i6kXl6O4UbUL8A2ocMO5NwCRYNGtYMhA3W1DrAw3uNZS0+Z8jVg8/7nO?=
 =?us-ascii?Q?s5O0cwFez8RZDq6aNwEcqdng/6xYmwtwG4Zj1I8lKRAKkroiPRFttHVcb8wl?=
 =?us-ascii?Q?Lhg2O8G5lQkTog+D2myE3UK7Rho3+OHmamBGX4LbYDHU9f6oTbQpQLZpd+wL?=
 =?us-ascii?Q?CpfLp6e0vcWO0RkDhas6ofKGfeG32EJRRXiJRK0dWY+ZIEDiR3Jhl2DIr+vC?=
 =?us-ascii?Q?8FgFBjj+NjI3hbxmlZJfZP6tFWMtb46iL+ZvSQpfgYndSCQb58rQvnRSmIR+?=
 =?us-ascii?Q?aeIiHpZY71+NSj4XGTMkc0/YtNjKw5+GqnH5T7wBfUtbIPv6UB+yjC/Vl403?=
 =?us-ascii?Q?QDAnsxi2jliJ7HRb1IZV+68E6IgDxVFQJNCHXoN+mpkDNyWi8sNHJMcOcixU?=
 =?us-ascii?Q?g0Zq+ObbRtPHn2zMWrse5wMHMzE69qD+pYhsbwMiypJE1ycMOIfQdWLqHNka?=
 =?us-ascii?Q?N4ke2ywcQK+sYPQ77hAloeRhlGsFCJbCR4UC0qvBwaqDZGZwwZm2OQeCbNSI?=
 =?us-ascii?Q?/MnocFBQHGyiydt2WHGcPATpLVk2h+mscUU2hOQOyO662ZjXbL5BA65moCVK?=
 =?us-ascii?Q?FCdDsHzZ1HsJ2YXponpL4eCius0v1o9bkLRiIUrvHcm3PqrNYJGiWHwVeQMM?=
 =?us-ascii?Q?GCfaUP5UTXMlnj1Xy2rCQRC3NEbG07wjh0hecNkj/+YUJ9oOoyfUf2hsZ9KB?=
 =?us-ascii?Q?eceMX4JMwLzexaJQYlxnyCuq4VrBlMZ+4rdjeA/wsTldh2Yx38+nVkz93itt?=
 =?us-ascii?Q?56gfUMRbpZ5QDBbdsn8ryTp1R3rq8SRR/wSw75MesC3xn4yoaukJS8Ygk892?=
 =?us-ascii?Q?4iW2s3a5T++yEjUsijBwN5xshbg2b9/JCx3DZQimEQF5VF/IibE9Vv/YQsm5?=
 =?us-ascii?Q?6OkMKwte0BfhIPZVQqR/HNKfFHRSvXkgzAnqZ+D7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1c5869-6068-4cc3-c58d-08dddb40098d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:37:04.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn5R0ES7KIeXZLCr2UXn+LcYd3wsQc4FICwUhqs2iYzFZ87gdTyDi8hrFg/8wab1I1zbTLvgkk995FFotDX7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5733

Use max() to reduce the code in cw_battery_get_property() and improve
its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/power/supply/cw2015_battery.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index f63c3c410451..afc607fee5c9 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -506,10 +506,7 @@ static int cw_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		if (cw_bat->battery->charge_full_design_uah > 0)
-			val->intval = cw_bat->battery->charge_full_design_uah;
-		else
-			val->intval = 0;
+		val->intval = max(cw_bat->battery->charge_full_design_uah, 0);
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-- 
2.34.1


