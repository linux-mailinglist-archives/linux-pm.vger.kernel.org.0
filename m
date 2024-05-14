Return-Path: <linux-pm+bounces-7845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F88C56A1
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2522835C1
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4213E02A;
	Tue, 14 May 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EbEwgHmV"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EA55C36;
	Tue, 14 May 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692250; cv=fail; b=pGnBNNlb8bmAs0+2fHCWHZB0DBnV6BhyCSDz43a9TvTLRGY7qH+hDyDbFOgP/2/K/u7t2INM1zwBwHwPKlkfE7gGrbsgmCI1nV9lgrUQiTfrsgrVoBQxkn4of4GcaTU9fwHTLoy+Q/z9d/qGDk4VdNTJ908zljdW8Q9tS31A3Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692250; c=relaxed/simple;
	bh=6Ct7qLupLfQIBG6j0A/M/foo42EipT2wh6B7Ro+Q8/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GNBD6cZbmO5MomI1d4arOoTGCgvi6ZAKBVC1sMzBUfuah8GoGB2xjOz3hZ9gCbEG+6K0utRoeY7lZIIpO5cowWprHlCXbNRnLFkcCEgGqwK9UmcFMEliZgrBCHBTSxBRO86KvVPs5zsraJKc0Tf7Su+Hl1RpeqjO8nOC+dSPFzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EbEwgHmV; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfD4I67KLe7U44oOu4EidoVR8pmAnb2cf+EOkWZWI4qqeGlcWf55AKV+Lhj9lxcFcOBe8I2Ey+V15NrYIDEPdDQVPTLlhPuDkC7QVz5VX5NQ99rL+ymKdwogsyCsOa5vMPudrxfNFKwf1jQR8NEHv+u35y27gX9RaXFB4Adk1SH847WMOkif2yaSSxGI3JO4SRl6Z8xgVx3aelLl6M7GBzj5hyiEWtdWiw2Ry1s7H71ZiW70EG45wLV1TQ6DvZjMZYqTO6thK2b83t/rI1bsMNu/5gsMYtJgm9jjYCxWMhmSevIHK2tDyJ1Y32BmI3n9T2FxvUQM0IQD9GelBezHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eyixh4il75JyrUuKQf9OwfQX5JUsiz+r8HGhD6CFJk=;
 b=Jg5Kyxxzfdy6joJN4kiuBEHwwyAdzy6Llt0z0PM0YJ09sVbyeI8A0AO4CGXP6MesJFKvfhcVFjNSBs3c3IrD7JqBApoEG5SewoELi+umGAD3ldF7nAZB657sGv5GkCzqQIA0GnvhKsf0gub1mC1xBIGy6n50cSMtvkVOgVT+SjCTxNUHb81AvlGMOX3Y2vHlH/FAhOKF/Ei99cHgsO44metax+UZfwQbGPXxECHlHNfSIiocLQTiGbVX1K1QsK2TeC0WRGDbMOasmKskjY+99xt95Yar2V9mx2pNvQ0RXI/IKIzQItZcf9F2rSy5I1B9GIeeWZlUCra1gHYtttyl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eyixh4il75JyrUuKQf9OwfQX5JUsiz+r8HGhD6CFJk=;
 b=EbEwgHmVV5EyL1V5O+oxftYQQTB5AnGah9cPt/mZ7YDCqx1E8fIYkbA805yrsaV9XAbWtR+wC+NjxzjE6UfDpiJF8RbV78NqkWppFl7XuJG7Cl00BFuISgJUnMHLtwo4vv3lamMpSIG9jvpN7vGAZAuwkS+5Hb7Fx2mIIHTamVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 13:10:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 13:10:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: set flag GENPD_FLAG_ACTIVE_WAKEUP
Date: Tue, 14 May 2024 21:18:33 +0800
Message-Id: <20240514131833.911703-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be793d4-ebf3-4749-a637-08dc74174346
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WF7msWgTglZcU6T236C/8Mp6bMTeSl4IgUeofOMrlFoJOvC9DaO60uXO/QrX?=
 =?us-ascii?Q?CFfex+FRKCP8RvtLJBRyMKsmJUB0wLfRmIDVTnJUy+NeBoZpdutXFwlgPCNs?=
 =?us-ascii?Q?NlJwk5ND1ekFU4BcLiR7dtdCQJeYrLkrnqgMIUFiTfc1SSP95Anx7J9zKqPK?=
 =?us-ascii?Q?mGnvpJz7O0hR3LwEVngZ4HIsp+j/LC0GB7CBYMCDWrKfuyqKjznQAT/L8eTe?=
 =?us-ascii?Q?r/c0AqJ4KYvOXRL5e1WZasa/H2HJA7antnzaQuHPWIUioURHwqCFrxt25Nk6?=
 =?us-ascii?Q?HAxTf/TYk00OEUOZKmIERPBaQVUu8/jRlxQyOZtJdZ4t+Yy6gjBEnyZdaI2a?=
 =?us-ascii?Q?UfeqkAcli8D0cDEmlFBcz1BqyITmHeqN3veBDD9zWJ2gCyeZWTUbeEnJMnAN?=
 =?us-ascii?Q?pnMknrhFc+DHTZSr0GcgTarWDki4Fd/odKDixAySZKOshOg5YBz0yF1RJ43u?=
 =?us-ascii?Q?HinEOqO7EMOpmyAVHOJlxpy2OVTo2RYI02UGHEhc+DqmYnPRQBTqaMysd7hO?=
 =?us-ascii?Q?GOP/3vxWfiiTlS++QxV/GLpUGLsY4ZKtz6yfISISyjF6UJY7k3pff3HXv+u9?=
 =?us-ascii?Q?JH45AfL3/zy5wX3EZMYE17riSF5mOHu/6fUR9T2w2tvg7o2aUqJh/l519cbV?=
 =?us-ascii?Q?gZ8k4db0/D/3SHYsvgfgEUqM0ryeOIrRzNXA7UXCn1SEyz0Kk1S5pI2grcUQ?=
 =?us-ascii?Q?DvqH5ssoUZAjZuNJ3yeqwaGwVv9OXrc2b9jEVj3UhC6pDjLDyFHH20qDTFdV?=
 =?us-ascii?Q?yskW0hM2yrFQX0u3HNvsytwOJZwHug/tQxRX816NQPniBNz0fRhbHb5+mbIX?=
 =?us-ascii?Q?6h5DeDuNKXcGzjnVzS/G5u/lqPQ5og1wbY8WTT2lQlLMjPWRQwo1NB+8Krnp?=
 =?us-ascii?Q?G6HeHHyL364e3AGPUWoHpDAnSFcYGmkboYjdV2FV+gyaOo44IAgICRXE/jB0?=
 =?us-ascii?Q?FxsnYHrrh5IM1aunhN5/KoG6KBa2YbJSXdBuoQ0aluNVx5Lqrc0NBVUf0wpd?=
 =?us-ascii?Q?r6Q7W3QzSOdXivOoSbuBKtUvxNviq627/B2RsyuOxCjGqdcDvtV8/Q9WiurG?=
 =?us-ascii?Q?P95trRMwNAYnL3eMtrIJpCV2ndoSfWZJGxP7hlYsKS1eyMb9Gbk780iRA7Pg?=
 =?us-ascii?Q?HEcFGs+wPl9dPh4UQevlnqH1jY3JO1Wiqi93rPR0qCOJ1encRadpqiFVrngZ?=
 =?us-ascii?Q?3QdwlGrVJfDc8o3wVASs6N2xrF8A6VJheN5gX97a5wY5xeD6RiLpnNdocwQ/?=
 =?us-ascii?Q?gvpu1Uf3aAj9roYGTzVo7ar1dl0GbBTa+S7HFWvXRBhGIb7XKBzhDYL0BYEk?=
 =?us-ascii?Q?zEzA2rc1ujw8YnhQv9kIl8UrOJ8p5F7FnOrPffG0gfvolw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ge+IDOh95mQ3KfdOAZohLt0uZp1uLpMPsJqoTTfG6fiSyiNcAwWxj9W0wLCE?=
 =?us-ascii?Q?DeVm5aF+aFNhaXaejZnEihaPkgsiGIO3HrHs5x0SwOmTJNp4YRNLLjwvKdlB?=
 =?us-ascii?Q?YjUaVcf0AFWqA6WMvgLY1cvxElY8TKePo9riKQjNLdtHBltvAlmPGpbPAF4s?=
 =?us-ascii?Q?Jq1I18HhyoaR76eTCvhgW1Q4DudYWkBrZya2DlcqgzoQ38RRPNJZ7F7s9taY?=
 =?us-ascii?Q?4alGm2sR++c5k3F6RBEXWQmRgQNeG86EMR+fXTcvNIDg8OnEkQRcB4qUoBC2?=
 =?us-ascii?Q?8IjD3mvSzKkuKiXpvCZPCLgOL954gn3GcVr84sD1uQzPDETHyx4t/o5s3Rho?=
 =?us-ascii?Q?TGU3xIcrJO6WyPCaLRQpdFZCeH6te1ucIclJgYvfFMuAAcEWpCPgNSCTuQMx?=
 =?us-ascii?Q?fQ66dMJAs1VhE8YAvp4TMNgVf1HYdaQfe3avEhixpZdFAIplsIMRmz1BEhh4?=
 =?us-ascii?Q?XbCYJTKkVgWvyLTLPyb8YDCNxB+CrZHtZyMPQUBhkaOOZm0xHwI0OhZFWtqB?=
 =?us-ascii?Q?esAE5QgIRVfg1Il4Mns+pSdnx6KdwDCYNSjTLmTFeeATCxW2u4ho4c/XrMWt?=
 =?us-ascii?Q?+LfVPMeR1pF4FDjsdz4JwpiSWiIgqGu6I3IwK2SjoyQ+Qn4L6P23Tj5KQUL1?=
 =?us-ascii?Q?sn823JrA/FqpJTgOih1HQxp5wzhI1c82xouw2yUVFDecXFo96hoSh+/W6qHN?=
 =?us-ascii?Q?MQZlttel9KtEpSmShfziS4GZGtziNRTqoC+hI+x8QkOJxuXUG1MIqqLL+47l?=
 =?us-ascii?Q?b6TgYQfjOJ7vYlEFZbiLxfnOuMBPU9TrvoQd4FDqvXbezfQrlywG1okJVvPC?=
 =?us-ascii?Q?T89Kzmkh/lxfNY2qhyOvV8+vycvjMkGnhc7rflR2flMlgbWokJtCFfCOcggT?=
 =?us-ascii?Q?wdURSDcfJyCRsrbm6fJSG+YqlOapIYbloyrEYVSZUBqq8HDpHSaeeDDEetuY?=
 =?us-ascii?Q?x52arDxJiY9QoaxzGw6Cp7s5lCXE9rGSaRO+Jp5OfVMjJxWF6T5R7rwEsAj2?=
 =?us-ascii?Q?q0RAcd938ROgyE+unoCbZ5RNKdy10mbMzY58hOWXI2ccJ7tOs7Eq5SGFuXIi?=
 =?us-ascii?Q?C++wupPevN1cSbmwnl96Oar6yXliijGvwdAL73QSBnhgs/dh118QcKtL8roc?=
 =?us-ascii?Q?VAGmX+0bVcAR4upJTM+9zY4nBmFp1BRlliw5CuN8NJrjaYAEluFqumjia2MO?=
 =?us-ascii?Q?BtE4KFCufnMxX6rnFZZrdonJC4uwu027i8fRSUBXsV+nnJ28UuV2XRzmzuwB?=
 =?us-ascii?Q?KgVP7m8lHfmMQFciPsOPInS4JNOUr28SHxP7WyrnKAq4oASFDY8ydb2alvbM?=
 =?us-ascii?Q?hrtwbzuOO2XAspDYCCgdp5x5mVRo/VYmGc421Yw8luknuhbvWTB/ksBmrKWq?=
 =?us-ascii?Q?mm0s4a4+6B5Uzc+71EEJ1JxutNIvCrUIayMTQ1cwEY5L8LlNc/3TYMvTml2Z?=
 =?us-ascii?Q?8gB3QHdZMgohySpqtkHqxeP+ysnEPw/jkk9+rPe7gynFQSgM4fht2Qo4LNCM?=
 =?us-ascii?Q?Uh+gCSWTqdIJpu89mbICacMk/CZftl6qDau+V4rhBRy/1+/5me2qHd0F2/od?=
 =?us-ascii?Q?nX84h8VaReYCaVHQ8uNqV7LRoJRgNod09dF8aFTp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be793d4-ebf3-4749-a637-08dc74174346
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 13:10:44.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UMlOEz26+I96u/n3EehmrbaPXf2S4i2NnMrufjUEN86D92xxxL8I1ypoObzJXHoCnc29zFF4xHv2vOYpr+mrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

From: Peng Fan <peng.fan@nxp.com>

Set flag GENPD_FLAG_ACTIVE_WAKEUP to scmi genpd, then when a device
is set as wakeup source using device_set_wakeup_enable, the power
domain could be kept on to make sure the device could wakeup the system.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 0e05a79de82d..a7784a8bb5db 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -102,6 +102,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
+		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
 
 		pm_genpd_init(&scmi_pd->genpd, NULL,
 			      state == SCMI_POWER_STATE_GENERIC_OFF);
-- 
2.37.1


