Return-Path: <linux-pm+bounces-43731-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHqSFHk7qmnUNQEAu9opvQ
	(envelope-from <linux-pm+bounces-43731-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:27:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A965C21A9AD
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05A63073F61
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11233BBB5;
	Fri,  6 Mar 2026 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EEnAfYX/"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF633AD82;
	Fri,  6 Mar 2026 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763964; cv=fail; b=UdmsWXuVhC0SZMKK6DwMJgLUCrX0+VDiEe4F86DUnHiSe4jsdpITfnZAAfnDgQ0kw+LggTNYiKCT1A8xXgkisAdNnqdtmJX2nPJvqqJbt5BnuvHYAu7dauaLfr5dGwm7xfKpFYFXh5DaBzOBmK0RbiZE8RNxcIrdsE87liD+yzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763964; c=relaxed/simple;
	bh=wJJGSad7o0fvkHP9A9xUbqGJhXvMrxPj6pDG4Hs8bGA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=klaiwCztxfgzoCQC63xUuq9Jt7hjHG5VV1FcBOj2EaAy/PEW9tXzwzXWk000UC3BvvaVnyo9SvJer1jN4vjB5lLM32rCBcyvRdOp9+A/DkaO6prE2ZALEZhUvdGID2ORvYM0BEx9SsOvbi3qycxtOBt8tkRVBvMtCtW0CqWFRAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EEnAfYX/; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjKGRU+EUH39upYK7wykzCIcXgFbMS2YUpqiu3i3yfHxhhLGrA1AZGbvSiGnTfP8MUlM3quv2fSfMHF1O0wVSlhp7S0gPyH18fwmmX+T5jTZhcRh5ygJEReXMG00se+UC25PTishogazEX6kGfW3TZ5LkI5yVzEzDpxfG92pcHPG9SRHwG5LCPm8CTcVJeCbxSK0tqg7AnBKs12eHKtXnqIAX95SKjEAsYZAuhvBXegVCoN/5Y2uTx0Ld+lhcPwDVdUcf+Q1jzkvBXKp0gi9Fz9z5DYA3neBYbOn+3cYg+ShFBaSXAencxVzwsU5dObNWNKoCpkLZKpv8qq3dZDh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9EOJ9QxdvnD07sevCFdSS05l0S8kqLisCiR4ReOwjw=;
 b=bOCZQiAoZWewBYQKsuy+Vm0hgBblhpXsmHEjrzb9+saDSffTNzeD4VMJbfVafwDOKoHnvGXPnx3ix10gOqsLMV5nlkfazOkzqiqtdtX9zKOjqse6V5pQNuse/LRrECBPJ2ebqmnQfchV/D8wkQ1EF0SDVGY2lqaMXEB9bqf6dooe1SuZpK7SboVdrA+G4pzQ0RFopIGvFJP4DFi5apvhN7EDjAnlXcQOAUwNlWBWbz2Iv5ZVq5wMYo4zNxkocuFK1n8IRZ0fWcl2crJBPWsHprGXJW1jooXxXunaF+bh3E1YL3gW48mqDPWSGrFlYR+ZXRJcffU4x7NWFjspEVfjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9EOJ9QxdvnD07sevCFdSS05l0S8kqLisCiR4ReOwjw=;
 b=EEnAfYX/NowdE/URqVcHDUPHF4bWJ0XWqcJreQnCVbAsbluT3wIuhVXPe9iczaEme0tkFGmJCVPMXO/R83VTn16EuE5Y0EGd7ZQfypZ/V4uOhyzYJ88W5rZ4aHHDAY9TinIEl3pDvSnXqyk54Ti3je5oYK39i5bzhccKGwhNMxEwmh27MsG5jL8aipt8tPGZOxyovz3UVy/2S2CZZX6XXE24lUxC/HCMF9xcr2AtuVBx4UauBvOSUiL28tfISTG02FaR32sTSl4od8Kn+9xEmxUihBGYcJZwCkf3eEcQ2Py+GFchziXiJ2cEhwqKxG7nXl0qRvgpbaIQas5oyCwc/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV2PR04MB11633.eurprd04.prod.outlook.com (2603:10a6:150:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 02:25:57 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:25:57 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	m.felsch@pengutronix.de,
	fra.schnyder@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: verisilicon: Fix kernel panic due to __initconst misuse
Date: Fri,  6 Mar 2026 10:24:04 +0800
Message-ID: <20260306022406.760-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GV2PR04MB11633:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fd469c-d713-401b-889e-08de7b27b28a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	wBcWOMgCe5Q7/NwIW7h6cODMhfdZRiun3HDA4Y8AaIsy3AGRNIpeN70ciKabuGa6HHbzoXkHqt0bkGs/795I4JpsOX55WYZhBHoPPgr84QYYMYcoA2wShwLlZwtsPNEvkpiShVqlXUz0SArMTNRYliczqFJSY83Okq7EC16A/5MxyDcEHExV6jIbYYGzgIZsZRYiTQcCnHhJ28OY6gwtrbsWFns8K8tAzBEB2F3fzloqGEqI/LZjSc1Zpy2tNEjtFzPqvAOVXN2bXiaQ68cJmSPuRI5WsuBEsV1v9DZiiqwdxfHXt2RU0EopYn3Dsbs0ulpANXnyPKxanbC7sySYtRw+j1Re9+kqClxihLP47KUYRUbnum7Y7bJsvXwZa7hw2g7OTvwjgicqALI2320JUgbsn7/DsoxDs0v1F0Cdi2n5xTinUUyMfS0USGdfrevsbUIlkVT9BsIpjZT+4fC1IXnY+5cqOdvTxnYwjrG+ca1VY3h7j6ETj7gZeE9FCdfxze90kY8WrQwNaMEINiLzKDZoGbnNHpvUoBWNMaN4tACCTGM6SyLkCaZBVJsAj9KL2mXAY5jhTKa4zqjZuIIuOzuZ7jiEkYaZwxLhU2dH4d8xKT9Es/Gi/ecVy/JLya1l41/cLYWTDkNDYLszOKo1pWO23f5xprqcBar9Lp/kot0UA+U9v3MwBCE7KL1rtv+ZXfW6NU5y5x+cdOecMSgeae16MDeIkqvUWwE6raM4SH01ENU16rL+M2KlsYLnKeyKlcyG4AEdJ53pKcPB4Rb3mJgHIRA82MXbF/4/ROaQM5aKu60n7eqPVEK6X4ywOX/7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FR18+UYAZhJyDJ4mVEB0DxOdMGMA8Mieb+0XvfxRjO57EfVUJd2gmCR9JJOh?=
 =?us-ascii?Q?vkUMI5+n60+4QCYXUTHvBBCXHVm/e/hcx+L0QLnT9QdICPqZl/lDzmVn0g79?=
 =?us-ascii?Q?DnIRpseJP4/+rd64hIbjQVgs2FahDWfaWRAl0FTeEkeaidHWilmClt3i8Abm?=
 =?us-ascii?Q?1Bhdv3ypUbN8WT+J+TR0ro/vpiaAsXUd6GhEuy5+qW34lYQzCFrC3oKz8j5w?=
 =?us-ascii?Q?MMTjNj5HRsINZRVT4bXNv3KxX1VFZY7QgkNmRqd7P8zYZl39tPKzkY8ZzTIQ?=
 =?us-ascii?Q?HqONPd82fAb+LhTwcFmQ3w6g70jRX7okzIEELHvjb2hj5EIg+IMC2xT619ki?=
 =?us-ascii?Q?owaVHOOzv17O8+qO6+mtXrMp5InIZD5s+Gb4vG0oYSq9lkd+10vXBwc9NO2G?=
 =?us-ascii?Q?2jWhJ/QnvDTJUCDbp4ZDdKGDIYwrbz9PolS9yJDgGBVjfQeeFanHOcEPWHhV?=
 =?us-ascii?Q?ycC1yrZXJ68x6vjiZ+eelV+miKpkRA7tqpdziOvYXkAqJXuuBsM7I4wmYjXv?=
 =?us-ascii?Q?9SCW3zCnwuCuT4fTD1QvNhp9cAf/CYJgNLioCe4eMP/+BhR/13xLnJxup/Tr?=
 =?us-ascii?Q?fSEU2Hbdn7sErAZpXrE5MULAHlcrp2fHXEQmoU1DpbsQa5DoYW7oQWJR/hGp?=
 =?us-ascii?Q?P9jjb6uiXxRyFFiCtZIULq8qNBvWY9mht+zvCPB336iJhjSJ1VWsKWHktfpZ?=
 =?us-ascii?Q?SDGBGkFIgOJFpOGUmlnZrrjf9rsMZjXTstK5JvNT1LY0LGF4DxmLfR51Djfb?=
 =?us-ascii?Q?y+s1MEC1Z5gHOQqxG08NRKGL/E8QiOOdTVhX3YgMNaEsjSveQDA8eUx5ASgM?=
 =?us-ascii?Q?taomvHRi0ibdruz1N0z1d/tqkk+Jc+zbOPVKPJ+xUjLeH3vBrXu4kw7xWtrx?=
 =?us-ascii?Q?j7yafWe3iEhF8wfUBXYL/VpCg1zcJZPTrt1SxSdoPxzVBWgLf8sfjM8V2vfd?=
 =?us-ascii?Q?gjXOgkCL/S3dHHZHNTlk3oeBoDR7T4xOyAnlWr9+66oANySvZ1jYa7tyEjyD?=
 =?us-ascii?Q?8LZXvzarYNmkLZh4vJGDQYq4Rp9rs//GOomirWWX+bD0nP9QGCgtM7nicOts?=
 =?us-ascii?Q?0htdyHuvxOFHGDAByH1OZWge55m7+WeAD2VNcuhldZ8/91W50pZjQj7UZAlW?=
 =?us-ascii?Q?ruDasjJl5wBVuNo//Mooz2UmE50m1rL2a48Igh5iloR3sUrCJeVuysXxwmXR?=
 =?us-ascii?Q?cTnF/mxm89jFIu/aiSNjPZQOrZYMjSJU69b87CMqYRbSwh3S1wPeLXWEI4ET?=
 =?us-ascii?Q?5aRdpQ3050ZnHWXpZUFCNw0ZYkIs6FeSsEnsj2al6Z3qgoAcsR5qGJBfvp38?=
 =?us-ascii?Q?4Ms6g49I/pksvf2b2nbKsamBMaxKH8+/p5KLzTgtzKlj2Gc25Iq0QY/ufq/C?=
 =?us-ascii?Q?RGsVQmHZiWIhFscwltQE2fvFS3Hjzx4osjy4WVBQwbDvkrZ01Po2RSnO7wl3?=
 =?us-ascii?Q?N8nkiV585KFD82T0SADAQAEvHXQm7994ktatnbXQCiDZ92mq0bDzOkP+Eqrc?=
 =?us-ascii?Q?geQCKW54HgfmoGfdsQYTHPD1qnaDeici0tchGGNEjY02dBt2j/oXlcY/aAZO?=
 =?us-ascii?Q?cEsfbFaT/Q/uMYEcbhGy9oAUKA/mtHnvE4jd+JutXOkZ/xqj3Sv/STDKCEM9?=
 =?us-ascii?Q?3K576xgEz12LSeB3Z79jSK/Xp7dAGrvdYbuekoa95pWPXQRFZ/cOmTRbt6tS?=
 =?us-ascii?Q?e1dIYoZLu4zI+uD2sn4cxmmAc40v9MBDVfY+Wvi9ukylu6NTW+GHgbbjMv69?=
 =?us-ascii?Q?O8+ZW9XDOQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd469c-d713-401b-889e-08de7b27b28a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 02:25:57.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSqTrvAalCByVjZ4T3Z+u2mm5MUser/eiicCYNVtSyiMYnnl5y3XsHcPWl9POkiq7nNPG0EfrD8wXGSvVEvsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11633
X-Rspamd-Queue-Id: A965C21A9AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43731-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,pengutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toradex.com:email,qualcomm.com:email,NXP1.onmicrosoft.com:dkim,checkpatch.pl:url]
X-Rspamd-Action: no action

From: Ming Qian <ming.qian@oss.nxp.com>

Fix a kernel panic when probing the driver as a module:

  Unable to handle kernel paging request at virtual address
  ffffd9c18eb05000
  of_find_matching_node_and_match+0x5c/0x1a0
  hantro_probe+0x2f4/0x7d0 [hantro_vpu]

The imx8mq_vpu_shared_resources array is referenced by variant
structures through their shared_devices field. When built as a
module, __initconst causes this data to be freed after module
init, but it's later accessed during probe, causing a page fault.

The imx8mq_vpu_shared_resources is referenced from non-init code,
so keeping __initconst or __initconst_or_module here is wrong.

Drop the __initconst annotation and let it live in the normal .rodata
section.

A bug of __initconst called from regular non-init probe code
leading to bugs during probe deferrals or during unbind-bind cycles.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/68ef934f-baa0-4bf6-93d8-834bbc441e66@kernel.org/
Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
Closes: https://lore.kernel.org/all/n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp/
Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v3
- Add missing Reported-by and Suggested-by tag
- Add commas to pass checkpatch
v2
- Remove __initconst
- Add missing Reported-by tag
- Add missing Suggested-by tag
- Remove comments of sentinel to pass checkpatch.pl

 drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 6f8e43b7f157..763bb2c7c815 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -343,10 +343,10 @@ const struct hantro_variant imx8mq_vpu_variant = {
 	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
 };
 
-static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
+static const struct of_device_id imx8mq_vpu_shared_resources[] = {
 	{ .compatible = "nxp,imx8mq-vpu-g1", },
 	{ .compatible = "nxp,imx8mq-vpu-g2", },
-	{ /* sentinel */ }
+	{ /* sentinel */ },
 };
 
 const struct hantro_variant imx8mq_vpu_g1_variant = {

base-commit: f505e978d1a0442adbbde48aed38c084ddea6d6e
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.52.0


