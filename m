Return-Path: <linux-pm+bounces-38691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803FC893AE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB44E464D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0224302156;
	Wed, 26 Nov 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pMwu/oo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA32FE050;
	Wed, 26 Nov 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152225; cv=fail; b=SuMNknGSaJZiOZ4yBwKNoiebMLhbhWXQND0xuqI9JZFY3hb7aLGPJz1dcIuUWxjQD3mjUbfciyqOmd9eN6We1+ggF5/cAR1/91Xq0EnIba6vvUacidr6ec2YEP8L9Oms4QZLz/NbI8KoWAo3HRyhXXJ/Tmhjmcm+w4VvCAik1Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152225; c=relaxed/simple;
	bh=soJBR1jKBpZOjqtqkVXJpgGmMT298vlXBICq+/FCN0o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tnx1qDToag7DXjCidwFzrSDk0CNW1gMLCKLdBlCGyewKm29/xptXhyp6d3i81K1jDVnnHMgGM04Nn2lHjLagZy+uvXze7B9xQCNO+Zlbi839Iz42NMeukKi7sBBssidrg7au8v4t+xgX+k4pbw+3HFE4sf0NkJBjmaI7SqG69A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pMwu/oo+; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd84HOU8Asl8yHMBb2fhMplBHg5Gwl64i728RC2bFlMNolmqro7zlU1oX0BEsXO97w/Wo819VAi+Bz2Fc/+3sK1j6Cwp/ycdDEfBCEEOzAKyt+6YzeB8bb3Nh3i3n9YHFsMQ3i/jsGpMhMgzXpA4ZUr9VbbryBrlf8/K0prU3uU1gQ16oev8fB1//0le8ZhFIs1DVz/H5vAUd0E9ylB1DN3Wy/Z1s2+/GCgpgOCz4Zb1ZjXtMyR1Kwl5IUg8p+1DDe4Mj13604i/hKhmnIQ0u1cPbp0uOFDVxjDtD6bzYivuY+ywoyP+WHGE8IfJmhXWgKN5t8AGzVFHcRlryv80iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqnVvT23gPb7TDNpulZq97TSFrpGCTbNMPCfgnxQrtU=;
 b=e/NjMwyg4f2RzmlBZtHqXEgoA277no51um3916Xv9zRCOmHcfF5QlD9KJLoRchN8jkJilfpz6DmNiPcGUDQDzVNTGWJrBn2+EVzg+2eYmWQMiVU0GdZBr3uPc3O1BlkWru7+8Jd8wlOIvKXAMmZqVezJ4OY7d5mi5tobr1K8w+pE2tXQdijNUKIiRJ4rO62UnSqEQAS4I2xlvBViwBdLVuW+2JBpT9juao7rvEJYv40yjJohkMnfYb4aMgbk2JsP1BPYFjilT1VyNmA/Mg8pbzgBSb673hIMeUvU9Ne65/x0+e4gyLyoeLr7GsjJbWT7VmKz/cDeF8SkpY08a9hOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqnVvT23gPb7TDNpulZq97TSFrpGCTbNMPCfgnxQrtU=;
 b=pMwu/oo+M1MCBAmuHpIeDMy5OxP/rE06s4+DTlS8J6EbeUWnS/Wwu6n7wDZEnoZ0Jh8krwLQm/D1s3rkp9TTv0UJnS+ntmyVHj9gpAE1TCEj4nq/9aTXgf1r5vThUrVmsRCu6wiBYid+fCtGizIfZa07dz0kuOHz8bPMUbsCER6d+b2SGgtj52YKBokcnsavwuSbrsLs3+cyzQ0r2MX2P36IoZy9dHEHEdrgxoCiSB5MmMMiBk9V0J8xaQfHhO2RBPvpMYNWjVWo/b9nMwYoyNHlorGFh9UNvq9fQbYZYd1jSNXXl0cyV2CWJAgP5J1rpFmkhJBD717A0Qt0UZNkaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5211.apcprd06.prod.outlook.com (2603:1096:400:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 26 Nov
 2025 10:16:54 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 10:16:54 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH 0/2] PM: runtime: Fix potential I/O hang
Date: Wed, 26 Nov 2025 18:16:34 +0800
Message-Id: <20251126101636.205505-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaf2244-1bd9-46cb-ee1b-08de2cd4ec05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkZ+Wme/DCwtWff/8MHoVnZu06M4/nCp3sixrVvaXkoIwGGWjAGori8fUnR0?=
 =?us-ascii?Q?omIs03lAyFLbQAG4dyksz6VNYtWewHzB+jLkvOO9WTXaTHuic7KD+f0UGixk?=
 =?us-ascii?Q?UNmZpTikPClEuLdzUUGIT82ec2qIcZ/I3Ce1XnGstryTVoVkyORqxkRmpA8I?=
 =?us-ascii?Q?A8xYfrLUihJSG3ClKKLzVls2/OmYBpR+AaVHe0yRpueCfC4AvDeL84kv6zCV?=
 =?us-ascii?Q?mSnZXn9CeufEutPkjDn3GqVXIlngCk1yBvqwYwlODm9M8Q6N5FhYwY0hiiAx?=
 =?us-ascii?Q?3JKkXlFVi0OgvbzTJYVIUlQIKEF+KM5lN4uWdJ+W3l5PgYbB5v0OfhFnSR2T?=
 =?us-ascii?Q?O9ucgFNOyQtTXkeJykQ43DEh/3eqlwFeL6FAX+B/jJsHVY57s2FA4/g+ZjQY?=
 =?us-ascii?Q?JNWdOtoTNRomC1qkiQrr6lXMBSGI2csjfkNN2eY8fIB2UqIakC6W4sYkwKz8?=
 =?us-ascii?Q?HFlNIUG4wbfTinbFkO8ol9eA7OpQKTU2tXVAX8dVvJbv0mm45HjsbbS9ZsFl?=
 =?us-ascii?Q?bLq3g9xASBE8nfLudPHaG1Ik0zdVvERnTyqLX/nSXLC/Go25l8kd4VE6OkdY?=
 =?us-ascii?Q?o7+lUvm+1ojGcKoEK0FDF+GaUOxDABwD3gnDFs+XwsXNSICuXDrj4RJnsDKY?=
 =?us-ascii?Q?CSjec+hP/kQl3hnnanCUtredxJU9ZNfXmKAoTOLs79dllQnkBROSkBWo+DJB?=
 =?us-ascii?Q?fUlHBD9UEHPB4jTTGzwkvKF8qmnRdTFn4WOmoJjx7EOw9GELRlYQBSTJsYGS?=
 =?us-ascii?Q?mhv8S3qNEysWjNzX5Bo8TdGNCxyEHYzVnI8KvltX6y1GegWYaSEEFdVUEAco?=
 =?us-ascii?Q?PtYUrlKSFlq5N3yM3hMCYAQ4xl3nEJSyKaz0EN7xfzohEfSXumIu3tNLildK?=
 =?us-ascii?Q?QzLgExVGKtSuTp0mdysIrI6Lgs9Y+9cuPWBCRcPrREyJsEv31v9OwhMp3Rke?=
 =?us-ascii?Q?WTIcCOJUE36DNyCUTJ6G6NrOPeteX/zs1d2h3xvP+03lFOpOTjfxY1/VQD8E?=
 =?us-ascii?Q?P7x4tLZ/qVe2fOT/mqqWsjNL7czpdudLXO8/uocBCsBbx/bohID+dvraC63n?=
 =?us-ascii?Q?qiJE5OF+IIuvC9eP3ia4YeR4SB/qxmuqXIFvam6rGEmNH9dFDsxLGWoM+dIJ?=
 =?us-ascii?Q?g1SPrnGgReZOppckuKFEAIK8ciJMXvYJBJvMwyRFIjbR3sP5gl9L4ITEynCv?=
 =?us-ascii?Q?ARpHBQsYvUi18C/KAMF0sw50mbwL0w98nMxWjor7NhBoseV73QQGjOFyoEQn?=
 =?us-ascii?Q?4sU6+ZJ37lo51TyOAuWgyRk/H29pFKsVK2ntlJCf9b5n8E72EzalTthzBPdM?=
 =?us-ascii?Q?vvX8QE+Gqr59GOzVepJdbbJ6yD0hWqDv1v1Y+o+O5FMxs62egRHppH6e1dNY?=
 =?us-ascii?Q?cFa5HCV8dbKOahPSEXIsTQLTaLvUA73m+ySmsu4W4z+G7VH9QqYmZRPpwmRT?=
 =?us-ascii?Q?pBqEWLbzkQ1UR694Gj9tlvPvUy1Fm0vk40+ABiXBZV8UGmXBIwvNddWjhK4+?=
 =?us-ascii?Q?4XxzL8SOXP78aYAMeGTVmcFt9IxQjYlcr3qx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0H03ynhimrKVyonw/oQ/hckX4JJPOd9xp/PdoARE/zVu5knGjK+lzDieZ//Z?=
 =?us-ascii?Q?ohopsaCStEMzzhUNpPNalHGyoF/ukb/tTzFvZeA5ftULADI31RfANDSlNo9t?=
 =?us-ascii?Q?cje/2g0OkUDWjGi3EKfojCDHo9CZpYwW3edRvR1F+uFS9YNLB8JH54f6C66i?=
 =?us-ascii?Q?QD5fBRbhSG5V1acjoGzbzcgiU6cTN8M+ZJhVxwIyBv+fgcYbUaREIEX7T9nu?=
 =?us-ascii?Q?tncfgtb3J5bCrRaZVmS0cYLlaw/GvONaPBl1h6RLOgMb/eX9+7MUdAmNh4jO?=
 =?us-ascii?Q?gYna1hpp9lVhBI8NDqSzLOFe0FKxd8V06fbj/O5INP5hB0BifHrxRp0RPWtd?=
 =?us-ascii?Q?a0pIGosOeO6w+EwapgsiqTg+p1Vsn+eLHWr41KudXRWXpCTWM675eeCSw4bE?=
 =?us-ascii?Q?YtW5otZeX8kzvtApkitZ6nN4dFu6XycHeAgcIwtiYYs/8Tc/KmxV9VCwYjBs?=
 =?us-ascii?Q?+7WxXtGeXhM7NO4r7wOLjhN0CMx6z02ci9ZTYeeDOy7BjIUjSTyrQMxY9qXA?=
 =?us-ascii?Q?P4kIo8FOVJYejruqTT3MNSBLt+y8Hl4zQLjvaai7rCGWJukgJ7ds8q8LVRIP?=
 =?us-ascii?Q?IkGWdq1tGZbwaVEpy8Nym6sTVM1/Al9hFLevrY3d0fY/zUd17dgWZVq7S19E?=
 =?us-ascii?Q?r2C8zljXdbvxVcnVGEJmRd4qhaIbbGoIqGaHuim8ASUuEknsH6uarIsGjc7z?=
 =?us-ascii?Q?9TI+9YG5D1+WKGxxHfHYsufgpWMChyBFQygAau85nbPFruUif0oV1VQCXqLc?=
 =?us-ascii?Q?G4A1iatRxndwY1Mdg8KjDeEdqYrFuy3igCyNiREvyrWggHCXet5vKS7Qn5Zv?=
 =?us-ascii?Q?qudwHHErK2gTRp1Lk0/SPGTnQjc5rdXjMf+YHu6SoW9T76y2mAWZKbhczbnI?=
 =?us-ascii?Q?5Ub9uuQ3unHE89vG5DzYw0Mkqo2JkPgH3/+nWyLtAzSnJNQnePdvM4Pgr/8l?=
 =?us-ascii?Q?0RAhiIJXu8Hm9F4fWcpfdHHaH9U3SgSK9RlZXonNrHSoZMiwbjOpSV9b0cCT?=
 =?us-ascii?Q?wij+1WyKrym1o6OfpDwQC37bwFrsJbXdTysKRz3cu9SwjWKYQtlhanXxkKyB?=
 =?us-ascii?Q?g8yknbFkIWZwtnWdb4qYQv7DzPndPnPPoEaU0tw7gde2073BjhnzdkihCSgG?=
 =?us-ascii?Q?9LnQA+YTmSwMs0GvcM1EgzIiK1gKDmQgP691PTnshu88paYxT7PWM6GQuz+G?=
 =?us-ascii?Q?wP8GlJNYBYTT946u6BftQzGCpO3JtF141KFiWeovZmX3vPBvQyb1+RBFjffU?=
 =?us-ascii?Q?o8kfVBJQ0rYteamRKaz+4tnA9d+z87t81T6tZJEATBF39D71VHHhoFS9l5mK?=
 =?us-ascii?Q?z4+oHjzWVVIkUXVhRYY5G7ttbwoLkvBTzNVdrX8nvAsHrMWBRPRK8MP6m/7g?=
 =?us-ascii?Q?dREnjq7FHCSDG/y+ZogSIn+PUpoJQA3wHfGRBZ6DzY09BLFkA0ZXrWNJFJn9?=
 =?us-ascii?Q?8tB+p9wY7suGUMNKzDnwhnpY/dVU7evAsByjsFMOiSb2aWTszds/8R5GkwdE?=
 =?us-ascii?Q?MPC/pRWvtPZQ81n2SFRPXurWkW6ltwcq/NTShX/APS3Qoo/fjJBCC3KUzNuM?=
 =?us-ascii?Q?hufvpFYExTCjrgbknVchDtI8eA3vVpkBHyUclb+i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf2244-1bd9-46cb-ee1b-08de2cd4ec05
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:16:54.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9TTShs2/Un/NOqG6sCnxJ2Cs2A52Zz1uYZPn1NVKue3NjSarbZkOvlxh1Y+hyphwtRzpox8cZB+mT7OsPg7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5211


Yang Yang (2):
  PM: runtime: Fix I/O hang due to race between resume and runtime
    disable
  blk-mq: Fix I/O hang caused by incomplete device resume

 block/blk-pm.c               | 1 +
 drivers/base/power/runtime.c | 3 ++-
 include/linux/pm.h           | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


