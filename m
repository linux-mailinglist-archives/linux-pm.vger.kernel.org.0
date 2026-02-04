Return-Path: <linux-pm+bounces-42051-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKsnARwpg2kxigMAu9opvQ
	(envelope-from <linux-pm+bounces-42051-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:10:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD2E4ED8
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A6B3300F9F9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4B3E8C7F;
	Wed,  4 Feb 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMCcBuab"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1F3A1CE7;
	Wed,  4 Feb 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203417; cv=fail; b=OAfXDIy+ESZpbWIW68U9YstTX/rFNZ5CWWtkjPypAPqTCmdxskiyoPAvnFr0WG+0n/tLIRY83HL4OxlZCZaaTPqWQefaVLjPtw0d9QtD8A8ypidT9jpAEK5ll7AXeArIWAYRwJg+35NRzGhCdBdaDGiTtHQtyiyTI3kytRuU3WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203417; c=relaxed/simple;
	bh=QrjPJaLT/XL2NFFXGuMeMp2Pqz08ETgNtGlg+scUdrA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=m2ZbvQDcE0Xp3BTOGUwrze33jhtekbEANkPPjFk4/ksdHqQ2h+I8N1CGc6n2LteMcOdTOXWQ5RqrQa1k0v3dxwBAzb50L6AdBDo5MMtatwVZjwduvnXCwmj9gkIRfasHHNmg51bJVwJQJyQ86vNTE/uZqxF3y9/FPkaMMG/pcqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMCcBuab; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqnJmYsGtnUeNxHaE0DY6DnLsvcKGsRaCM8M7lsmoaVTRhx5sf/tXv0kooUVYPjzc7Wz+tagJ52Mo9jAB7kbnxZdQYW5Z5P5JEApi+lV9+mwdwGxsL3FshdoxRcxHhNrXWWMr/E5UUupZu9alK4fGqRe8+EjZkgvLRs5+XF/Mqa+EJ4wPwxDUIkogWT3H9b6Sy4FVv5o6AxXcwALYEVRKscqlJvdx71uWBjVOYgOSXclEyP1CjD9JCL4blDvJnR9my6nS6pCWzjHa08+qaNmjIJ6s5Cqoje8XE8KD3xx/UbJUq94yNrFhvEIpakoFjKd/y8NtB1wkIVBcbRr4se0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaCzyCniotQK7Gp3glCjGI5pXKyvnEG9ICnpqbLdwb0=;
 b=vJApyoyW8VK89xOZbEKrraYzb5YBWSlbS6hbXXGLEYCKkYiucOoXnL7OZFgp4qi/4Cy1X2bpU3yy6308Yvsfl2LguSBuCwWeMk456vaGSMwA99JC/Sm56gWuEaPcO6R+wEOFfAeHJNHvSSCq3rRHSHXH4At8caBqc0jnaBPyF5cBt0WapoCXZo8ALs08r2/sN0PDUryM3rKa2vkBfOCGTBQk7WNpDbuGAl2QXZg2uWRkA5rWhi8Y87LWVngEtPbRbdOlYRMDvHt2lAgtdr2MnUOmMbH2Zyd0FlXy7GT9yHeGj/fBDQEst7IunwB3c85aXt480MWEONTMcjIHqQfo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaCzyCniotQK7Gp3glCjGI5pXKyvnEG9ICnpqbLdwb0=;
 b=kMCcBuabCvsc5ipSxRXbXz53kAgNO41PyBAgq+qYTGMMormQQHjy/FIqDBvSW7VNEVOF7PvmxUCZXsy3KwgKw4ccAGdB1IaIblQEWzapJQ2m/G0yjhxPhl+naZDNGZhIvUyoFWbRegc/TVeTt/9HvqUhjjn9FA7CYbaIwe5cI+vly9HCj9ZKVceki6pgB4IzGNtAYZBY8IOkAzdOoIrU930ryY1pejQbfvECKCTiVo9QzwY6zfxqH/8sHQyJ7GL2Qxog2oaIrtTTu1+epapxVDqQpaZKxzBqhXG3xLYPfkWAjNTVCVxsZJ4FouuS7kzbs6e7AMuiMmBQKurKz6sbOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 4 Feb
 2026 11:10:12 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:10:12 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: ulf.hansson@linaro.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jun.li@nxp.com,
	rafael.j.wysocki@intel.com,
	a.fatoum@pengutronix.de,
	ping.bai@nxp.com,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pmdomain: imx8mp-blk-ctrl: keep gpc power domain on if blk-ctrl pd is on during system pm
Date: Wed,  4 Feb 2026 19:11:41 +0800
Message-Id: <20260204111142.2147646-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 721281dd-263d-4191-04dc-08de63ddf744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|7416014|7053199007|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9kJ8gnm+m2CjQETLjAaMSKhW7xgDTCM13zDTHQjJZ4aO9OaPf2C0kSynYrn?=
 =?us-ascii?Q?vy8FlpwMTdDvHIlp7+pHTmwtvtsqM6S0eOzCW+yVRHTNvUCWifPTnVj6QtJW?=
 =?us-ascii?Q?MR3awAN0XYfEj0Di8AYY1p1Il1pQdR5eclW8MfVM/mlkg1tVYVWLOfCHr+0S?=
 =?us-ascii?Q?eGc2yfta8jHkscb3t/1T+GTaJtJCZyGPb/3XrRDGRrG1fjN3FiFBAd2/6Gu7?=
 =?us-ascii?Q?8TN47Ns0Wl/pLH9EZEIzdnLH6JkYKE5aWI0PCMi/pbJZ6PFVyWCaNZTslgU6?=
 =?us-ascii?Q?A5VwtLKccYi5LiahQ9cwNV7u96zfrO6hjIpbPEKCByWeaxJcgdckZAyxlBql?=
 =?us-ascii?Q?lHI6BpYRnDgngkzoYaKP9T4XdpGuv7s7IZeEgtM9bJAnAF+tFOoFEOOwpDdY?=
 =?us-ascii?Q?0Fq9ONn3AP3nDyXrRWoyGDnQQsr1Y21Jdo90utVtkYa+C3Aej130/FDIfQPg?=
 =?us-ascii?Q?rmhAod+hjyfhlfvslWD6nuWOjPETbJgLFt6m9DduO9kFWiw5XIu4E9E0mlar?=
 =?us-ascii?Q?v3IqxPIaYDrzGxi+dpW/mByyTyGCMlHQPG4uYnOnF10+ke31xaCfi8k2EO3H?=
 =?us-ascii?Q?5AHDwzgPbpdNJW7XIb2YfkRaIYE9a9i63sYfvYdUFq76jRdyV5MoPHYC7+xu?=
 =?us-ascii?Q?DtWhqvIK9Lhvfb+T3wR51MXUMqQnv7fW8mjnI4ZE6o1GKJb5iPX4rIWc4SOD?=
 =?us-ascii?Q?AsRABAfbpW+dUD5/sOUqkSLsbfj1R+hjkKY56030DpsJMxUPK1ra2Ro217t4?=
 =?us-ascii?Q?uU6evJp966a4NxIzMqFdXBhm26jaxHEQa6FUPtEc1vsvU9fHpJahQvHPYc+Q?=
 =?us-ascii?Q?DUEb5MyS3PQrSugu3TH/Vu6HzDNK+4/5Wa1nWOJWxxEhdHRUvZlQMk9JRINi?=
 =?us-ascii?Q?tsPd3N82EOst0GLPXEcd7vBnC2o3XdYu4C0YkK7pN3aXjlTzsT00s5R/XNMm?=
 =?us-ascii?Q?Y8NnBMdw6MDJc/fvzjEd2tkXROlgtoX2nt5UG6JWvK2Filjw0HbHKUC1vtX4?=
 =?us-ascii?Q?+W02R2OKQOsdN92l/9j5/wH8ylmwa/fExO0GmkGj+lP8lpyM2rUclRyStV5i?=
 =?us-ascii?Q?CdHTjKc5zWPViOZk0klSyXff9Rwf7oJO5PQViOIoendaKxgfMAwr7Q6JTF68?=
 =?us-ascii?Q?1kxABGTbJFrSur08FP9nc88kK9WhvY+MBtd8eyK7WSSs2qjTOP/tSjNBw7gN?=
 =?us-ascii?Q?30EdkVwjpAjjCD81MkljlmzO+rgTkEhE2I+MyixOuDwr4D3iLg7BBq6z6tQs?=
 =?us-ascii?Q?KmNub3VMi/QcC2zXfLLDDPPVdr01ATwyEemznLkw5j66EQPmeQT98W59Ts1J?=
 =?us-ascii?Q?MzXzfgae3tRu7W9WlkJWsLpTA/khnN0rtTfPzgJz6/lXxTF3oAIhIs+Z6OFL?=
 =?us-ascii?Q?IKozx5/0WkCzk4K8JkFqZOyKxopbZfEn4RdY8K1TwMo1pG5OGPE0ZSkiy1gR?=
 =?us-ascii?Q?zla1JF0AinPesoIql9zc6IHRk10IqSNBYz4Jium9DnoWTPD1jgxj4C9chSmy?=
 =?us-ascii?Q?Q+Qk/0yDRFFTGsHDEUMwTxoIE5pql/yBC9g5Xnn2SxaihEqUgtHLp+2N0+d4?=
 =?us-ascii?Q?FKWDd6RSoi4vXlYOqT9kUciQID0hwXGJUQKNs+MFcbb+F3J06QqTFRMKAmiq?=
 =?us-ascii?Q?xvg3/E2htnSaH6CRYys+zISVmiYGB08qtWaoFqz01F/O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(7416014)(7053199007)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBu7Ypt990crQxBGh2speStATgyBA9lkITBt9scPL+U3KwqijowEZ3DwEHNZ?=
 =?us-ascii?Q?OtB27Fe3fRNPZ5Nu8rC+LijPpQn6MEH2efl3SbbgKayqCLjhaY4GsivL6IeH?=
 =?us-ascii?Q?yeK2RThlz30+f+T7d/9A4RafKt7ndDm/5GaCtD9zjerxQdoNnItwNI4eFRXF?=
 =?us-ascii?Q?gTIlGnjo7mvP8lc5S0BVlzfArOF+jKjNsowaR0IKCSozWWhH/vlQ6A2WTKZR?=
 =?us-ascii?Q?dROded6tnEs/pvB8pEiZwF5x/asP3hKFVTI+cNNCS7aO4prJI8Azw8Am2l4S?=
 =?us-ascii?Q?djKpg9HCUMUEIoSZL6EK3z/rZeXGHR5DHYYCGANjWvIdeJbHGvCdDdxKYfYY?=
 =?us-ascii?Q?ltVN2Aos7r2EasItZDalW4cV57q6p2Yd54sm2+8Vt1lGQjMKcRfiidPljhXA?=
 =?us-ascii?Q?3ZCGO95xuAWimKKtqvCniyvGK4ckT+7sgOYY2V/G/cwMq6rO+9Q3aIakCBwn?=
 =?us-ascii?Q?xCcF2MU0ymofZ5h7/90kUntGpcXu4sK6I83z5QEvTBUpBfA7YivuARxndKnD?=
 =?us-ascii?Q?4KThALLRAKDxWx0PYxT7QGCkCZlrjegrynhFoZ+PYy6mTz9UsApLjiK0nyDK?=
 =?us-ascii?Q?QwE3xzk2/V6lSyrFlKt1/PlvaYsVAK0b6bijWtuWRrsZ/u0Av1iPlqHecOBz?=
 =?us-ascii?Q?1CScdiOgHenoPOrr6F3fgUtYDfPk+iZLwNW5k4YihcxHaHzcgtIMXQ4NAz71?=
 =?us-ascii?Q?KTsjIv03ey/Qwb4JrVHZplW/d38J+eYV1P+hyANPrStkuooOYqDgE3RTa4Py?=
 =?us-ascii?Q?VWiYx95hgklWWNSVmDJjxVz4TYB3oH5S6nWlTm+UhnRVwkscmq1QB/ZfwSBK?=
 =?us-ascii?Q?DHohHvXZYt+fJj2vsvir3Rk3oHqN1PiHeQnCYlit8BEfRmJY289vDCRp37E9?=
 =?us-ascii?Q?JFlaPO8+VgoGm6YRb/uWC4YnTk8VfLxVy6fsM4/22WYQPM7+GP6uuDu/4Hx7?=
 =?us-ascii?Q?9T8WwSGiqyTG0Rcl48eNuoC6RkMDMACtG7fh7I4kxIaCJM0vweEtpIoiVjr0?=
 =?us-ascii?Q?Cjxpjch9n7go3g740HqG+OJKowwKnHKnFchmX/ch+oNbqHMVJ50omAQntGAT?=
 =?us-ascii?Q?ZFVmuTmhwCTJJe/Hd+9a7QbvEOSrs0f/K9p/5WlhCUoGe5EkULPH0uVvl0Zp?=
 =?us-ascii?Q?g6VNCUKkUTrOziSLCgJGGApRSTMe8AQPr/r/lZL/qLLIB9TyJ446XHvDWGGW?=
 =?us-ascii?Q?tM6huFoXPupZN9EyC6q3QeqYB4741qhtS3IWAyxACRtZZrnk7XK/BC5xwd5B?=
 =?us-ascii?Q?xPUEh9cxwhhs8TI4Fd55oXiWw92JFqkFralNUwenfRt5Cx8HUm0g+a89+Qml?=
 =?us-ascii?Q?40h3HDqUXmEio2gcuu0qfHd/jPAYoPUHNZviprf2JeEUNeN5ywMnBxy1e/ac?=
 =?us-ascii?Q?33XLGpKVjFOeBhxkWTNYIL/VIlGmNA3jhqk5+t4Zy/xcKSXlX05agREQV99K?=
 =?us-ascii?Q?qWm4hOKsHKto0eXggL+Y+SuvvIY12aQDjqXh85/dCROyNpTv1rx1u22VezYY?=
 =?us-ascii?Q?Qy4QRPxNrhFN0ON7Rn0h0npwYKETTORJUUnuqcms35AjnDoJhC30AjI7DXfr?=
 =?us-ascii?Q?MAObPy3Gj2A/Omj3QlznfzpGbT2FkI90Dj5Ef+8TaDFXJK12NEj6y95PyGok?=
 =?us-ascii?Q?J57oAp5n9xc8BIngfoVSEaUxzCq8UiLA3aTj33mlANH6kPq8bXpq5psS7p/7?=
 =?us-ascii?Q?NOgvClsYiFn0WhSShq45yh3JHYZoIXB8Iu1ZntNCV19Tin3MU5JaShO1DrWq?=
 =?us-ascii?Q?fISo/yCaxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721281dd-263d-4191-04dc-08de63ddf744
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:10:12.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcK+egPiGMZOGOUd1dnfZy8KmFdBcBJSvugmW5m/TbsxOQ46Rc3NDwTrOtvacsRCMlmi/+3VQxdyPKUyanT6OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42051-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[linaro.org,nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60DD2E4ED8
X-Rspamd-Action: no action

Current design will power off all dependent GPC power domains in
imx8mp_blk_ctrl_suspend(), even though the user device has enabled
wakeup capability. The result is that wakeup function never works
for such device.

An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
is created to build connection with 'hsioblk-usb-phy2' and it depends on
GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
power domain 'usb-otg2' is off all the time. So the wakeup event can't
happen.

In order to further establish a connection between the power domains
related to GPC and block control during system pm, register a notifier
to power_dev, so that GPC power domain will know that block control power
domain is on and will not power off itself.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Cc: stable@kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add notifier to support wakeup needs
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 34576be606e3..56bbfee8668d 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -65,6 +65,7 @@ struct imx8mp_blk_ctrl_domain {
 	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8mp_blk_ctrl *bc;
+	struct notifier_block power_nb;
 	int num_paths;
 	int id;
 };
@@ -594,6 +595,20 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int imx8mp_blk_ctrl_gpc_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct imx8mp_blk_ctrl_domain *domain =
+			container_of(nb, struct imx8mp_blk_ctrl_domain, power_nb);
+
+	if (action == GENPD_NOTIFY_PRE_OFF) {
+		if (domain->genpd.status == GENPD_STATE_ON)
+			return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
@@ -698,6 +713,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		domain->power_nb.notifier_call = imx8mp_blk_ctrl_gpc_notifier;
+		ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to add power notifier\n");
+			dev_pm_domain_detach(domain->power_dev, true);
+			goto cleanup_pds;
+		}
+
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
@@ -707,6 +730,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to init power domain\n");
+			dev_pm_genpd_remove_notifier(domain->power_dev);
 			dev_pm_domain_detach(domain->power_dev, true);
 			goto cleanup_pds;
 		}
@@ -755,6 +779,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
+		dev_pm_genpd_remove_notifier(bc->domains[i].power_dev);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
 
@@ -774,6 +799,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
+		dev_pm_genpd_remove_notifier(domain->power_dev);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
 
-- 
2.34.1


