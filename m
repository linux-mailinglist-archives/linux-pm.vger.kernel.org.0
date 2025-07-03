Return-Path: <linux-pm+bounces-30003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB447AF6752
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 03:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BEE18910B1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF61581F9;
	Thu,  3 Jul 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aLcr/3I4"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011062.outbound.protection.outlook.com [52.101.125.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F53FE7;
	Thu,  3 Jul 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507354; cv=fail; b=jdMmBak5wRpIK4L24hDvvOtQ11SVdYkh+uGzBVIIHpb+vXI31ZK+Dxs4k9OKN20YrblMhHGQADnN8vvI8t+q+TIzdJUrCw0Bodf79tT98nnb6EYXEPocAKYM5HchHNLseKAFDuJYSdSVIQj6mOlLW6xf+3nIbPMM0m8R3rQfGIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507354; c=relaxed/simple;
	bh=e5d0MssvZStVvo+vmdxRAYRo9OyRsz7r1eP1KqAMYEw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=oVjY9aqwMzakkC8lgO6TcVyR1EpKeO7HlB6oIUz9n/WsmxPgnu3So0+GOmdLxWLCDJ22DCSVVigVH6oRO8Qs9FS11mPNO4bl4Q3yC1/FKFJGHETwfaGPSx1HwPRxbBpWiKBfUpHb8uWZbLCRW/3OO7w983EtXqWyEFMwWOPe8Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=aLcr/3I4; arc=fail smtp.client-ip=52.101.125.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSmo6CaLqV2cyknW9ifGHTMlO9Ptsl6r5GS88CcMitFttY78iDEHaV2zbujkInjzzds3rBMJ+W/l1htHfFKw2gBbiTZRPwCjZIeAxLrP+I7eXlcTSYiEHT1XyKh0Vwnr8TyzJiseTkvtAoFPOYUkgrLQeKj+hKr04pVX0BGWhDf9Ayk12k1w3oXJ4QGSlzv1yhOwoXHD+HZFY0k9PlH07beiY+m6mcePrCagAtYqZvaXzbg9j8OtOXfOOEfOu0ij6QbDHeH9Wpig4c3KCZJi6TP8JLOYepjFQdPJL6HSciBGuwvWh4Tqx9NCge0eGPM5Mysb5hi5uaCidnigqjwE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuJss/jGOGeNtYe63dETebimdDceOuRut79y8Hq+84U=;
 b=u2fecysPF1jRYig8rsUNY2aC3xZ/qhIZSGz/uZNLTpkd/apZ5RVX9GTe9AO9v/idUCJGk2n5lpkngu1SpSwIe5CD3M8bNmWNkNyL2CiorjkamLdioeCUeTtkAv7mDE7LBPTAKtdW/NXhAwpTmuXnVHTzk3nYDSJuqrqpuT+gzUOgVahqStBRKaX3Xmi5qaNUSQ+4797TxDWS2dnCK4hBWIu/v80RgCLSBxfF78Nd4ck41b3ad4TJ6ODFtK4++qHtO4YHPGDtEp00j+x3IQiBAD9xPorw0fAUO6h0a9CRwT8ZCssvVxIrWqy8Woc9q74Lyuj2zmD9TbCac3rizrZtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuJss/jGOGeNtYe63dETebimdDceOuRut79y8Hq+84U=;
 b=aLcr/3I4iKXOnEvAb/UgsDVVyFlC56XB1+3ugvjCaosyTF5uCO7+uuZwpH1TahaUnkgNYqe7WMFMcjdKoKx75+lyUQUFPXf4F6TF8cKSv8IV7LziSPE8XTRRNX57iOw0/vvV28HMJEQpCr0Wl55QJxwgIc4JRY6fTayNWv5cN90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSOPR01MB12299.jpnprd01.prod.outlook.com
 (2603:1096:604:2d9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 01:49:09 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 01:49:09 +0000
Message-ID: <87jz4qcacr.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 1/3] pmdomain: renesas: use menu for Renesas
In-Reply-To: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 01:49:09 +0000
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSOPR01MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: 58341903-58df-433b-45d8-08ddb9d3cd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kl4sDG7GdoNVRLXF09CygIXKQzBnY/lcdac9s7qtlmJy8DdfAHXO241YMnkI?=
 =?us-ascii?Q?+lYYhsgeEtew0/4eMtwwFSH6Wcl1ivJm4o41m9FNUV4yB6JvX1hTmLtuDPiL?=
 =?us-ascii?Q?Xj4aqrzu2c0GFAA1TK0MkSe/M/kDvPepQoJ0WsOn+dRAEbgOfMkpg/FDsLuX?=
 =?us-ascii?Q?A0rxUgfmw0vvRJ4+6sXiVb+IyPZdM9g0LH6mOC1PXolREs2uT9nsxh+0lXNf?=
 =?us-ascii?Q?tLQDnO7L0rzCQdUOeU940IPsrTOVQkUTwVqt1qiBcY7B9fhRsYaigpDyRn6c?=
 =?us-ascii?Q?99/2lFOAuBZwA6cw0rfBxJJ+4tp5SLh3kjyK6+l6xuBMWTQVTApGavVQAG+T?=
 =?us-ascii?Q?B68szR4I55unNETF5kYRN1gXHLMg7XYvtz3BYQesEkP9mZsag0mw/e/2DUBM?=
 =?us-ascii?Q?TGtfT9GmUMyEXIWoe/Q6wIoSijjnYCgV1Q7JXaZC0oTR9aFR3YiB2zzdJST6?=
 =?us-ascii?Q?q7Cu3wekUDsSNknW2ehTn6NwKqOIkm7PrsNP1Tl1yu5BT4XXAKNwSOYTaWup?=
 =?us-ascii?Q?h5S4kEy0+ohLGkH9mtkdDP2ax8asjPZCnQME7ekJk91pEVvXWCq2VKoyJmwO?=
 =?us-ascii?Q?nGt33RduAjBG3m9Tf0jfj0W3Ogq27U7ASBCBWF6BQW9vIlVI9ET2ha90awMS?=
 =?us-ascii?Q?9qFiXTLZnubhQuJmbrg+ow8RQPXnwqqtcvIMXdoDrI50hVUXCVQ5CpGkZHMf?=
 =?us-ascii?Q?fC42W46TvhhP1O5WMFczjseEThdHo+7yXRxK6MaCtET0+v3AWHdrx+woSSHf?=
 =?us-ascii?Q?RrENqv7ftmJsQge4MvGN9Gr3KhnfN7X3tIl61v9Ecz31GjSslonWqMEjxTi0?=
 =?us-ascii?Q?iRwzZ55fEliJ7ddlxH2quTBDJWeJKtDXuZcsjnGQJogVY21WvPM7tzHbl9wv?=
 =?us-ascii?Q?/ZAqeGIfUYr+Cu/+KFlNEiv8C6swVjlWm8tORve86FPkrbJJUfYsMbRSub1E?=
 =?us-ascii?Q?Sz5TVFsm+PE/Fh13/wmZmeo/WWdQD1ZYWr75BEYVy2ZZTWMdJkkKZxo3VgKY?=
 =?us-ascii?Q?K7qOnd6+gM4itosykPUdwkaTzqQESPlnBZWMNQI7aV/LSGzpgFTobNrTZfMH?=
 =?us-ascii?Q?vIglix3Es5uaxOO1I3LfAdmAi6uCvkHp/3OtZqT02aDwx37mReyRnquHZ6IL?=
 =?us-ascii?Q?entjhRx6o8LU4p1P7YNXb25nHkbkKFRTtzz/I6G+R92AhIcQ1qrEiRlcpM3K?=
 =?us-ascii?Q?DIXNXSyJjI/tmlj3iuR12+SuepBkcu3xSrKInpQsuZqpvtvL/khPRuxhUNFY?=
 =?us-ascii?Q?O162HqBGSKoE3mH1LvicPl/hIpYrlHq83pSEsfKnF59ijyIv6sxgVbwdBBD1?=
 =?us-ascii?Q?Kl+btjdLyU5uTU6ZPPTbWKKJrHlc2CPfsHWGX7/PP4I6QY6mqytKCR4mZuVA?=
 =?us-ascii?Q?U7vJoJapuJ0oNRvgC0zVaspHXt82IXsfXNBTNzmIR4xLYX/6QAg5Lo1vEpRK?=
 =?us-ascii?Q?uH+VlaAV3wX/2nDKgFoOjLsmslEvm5KyLHqRlcudtTzTRJWztV9WOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H2i0muk8piP+RknSwfkmZhVZq0njEay8RFIA9f9EVgiF1Y/bIMujqPAPeV00?=
 =?us-ascii?Q?ZZK4bBpfWyQ0cMGSsF8mijNbIKywSDRdjbbvb3dA+sul+QB4rHbx7GbrycYL?=
 =?us-ascii?Q?+zqz5z8oAT9mI0rO+EnkPQ79da3rJNv1C1IKXvJa7JQBa3nJgMBpmdj30oFG?=
 =?us-ascii?Q?lMphyJv9NE1mt1biQHenWf31Cvf2i2cN6qvHg8m3uTUJngmsrMFoGxJOEEIl?=
 =?us-ascii?Q?dgZRpa8YGxC5Q5P7nPYLwRFKz8xdX8Yi39od4qLS9JNqp4C+g2isZy5F0bPK?=
 =?us-ascii?Q?QByIxm7n8ui3wqpJl+xZ1rcS604pXDjCq9nFrwxawuzdwLhz+IMyLDKSVO/H?=
 =?us-ascii?Q?/4TLZf8+QhrlBLp7p1+oYdbV+TvWnrcl+yIo6TM3mAnVhf20fo/Tb71WbBR5?=
 =?us-ascii?Q?Lxtl1RMBHxAfE8KvtkRVumhxfUTxhD5zPgGVWmpU6b98rw3RveV9fPTBHMzw?=
 =?us-ascii?Q?fyNz5CiKwwqgFdcZpQDix8WZjE8JJSs+RzLbQSck1nq45cf5x8LD/wCNn0tE?=
 =?us-ascii?Q?3W7iacLq1ZHWoY8Z+eP4khgPUI4y94irzUo7VbH8a+aRIkWH33xb72netw3r?=
 =?us-ascii?Q?himcPi7oAyMyRjnwLicOj9E2SZXk25Nn9R0jA9Nw1IYAjARmWJqNxNB4GvRk?=
 =?us-ascii?Q?L8ZnNO5+BbAXIA+fJGgfH/SPY5t2os/ncFnWc1xkWN9fuJIhQMCrC/k9H5L3?=
 =?us-ascii?Q?nmIjj9eH/giqq+kTxtISCFu4W/y0UcQJKsi+PPmePSUq7irWSIqhnngBY5Jk?=
 =?us-ascii?Q?lHk7rUaOTgmils9J2cJGve24IvLKo0bDbYziH/uvlDMRRVcvz1SVbfr7KrUT?=
 =?us-ascii?Q?htj6r0+ILuwEykafqb/YdI9ydqr428vRVB17Tsjzji7zXRgkW1idVqmvflp6?=
 =?us-ascii?Q?dS8WfzFhQxMFWCiHU2RW+88sABjVfh0OrAt4q7lgHEeO2DCXmXh42WccRKJn?=
 =?us-ascii?Q?l94FeOm6GQCiohRwuUlpHPm50n9rEVbyqAIqq4LroTqspWgZBu6FUF9wMDvH?=
 =?us-ascii?Q?lbwDboUQM9YYESiWiEV+mcS6tNb3UcDTCa/UrbnMs4VqILGTljv0talNyN/l?=
 =?us-ascii?Q?i1MeSZ1iHtTuKlM/PqMbU3JSb+ULqcTgml34pTojcPFDyBnJULWc3tAxBu6J?=
 =?us-ascii?Q?6nzRYaTWYhrazRxs34fp4KIiETucouD2A14lcCHtlbncZZ6jgYfvZgLQTA3y?=
 =?us-ascii?Q?cc1PpW/oKqQfeyqokehrZdIIValrvXVhZd/QvrkfnUXJZ+lvUl1fsGa/9M90?=
 =?us-ascii?Q?NU1xg5fIGWuqrVkmn0pYe9kpENNQ/vxDGu+HsL+wxCmy0OvUjsKbsHqDBoQN?=
 =?us-ascii?Q?1m6glr7q/25eBtcTytuSGd/ZX2/iTEXr6xQ/X1pCOvu4nN02x5bk6qsFgcRu?=
 =?us-ascii?Q?PA9aD0sGTguyAIR1nx+qffAC1t1Ar19qWvaXb95GMO8djnZeLX5SxCuR3qFd?=
 =?us-ascii?Q?ePge1RnrrUe2n0MdMp2ar5Wt3Op63CcybHgeOc58EcH0fyW2VbrN1eZF0QNj?=
 =?us-ascii?Q?RzRsW55VGmLJ3S7L4JkY0cnB+gbOQwJtofiZEVIoxkHuRBldh5U36S/xTC1B?=
 =?us-ascii?Q?ngHt8xIp0G2kbJKab2WkMhJ+if2+P78bt+2wOVRVcC3WJ7TYZpzEmhgw3huf?=
 =?us-ascii?Q?+SZpnYgG0a0MG/slrAdJlzs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58341903-58df-433b-45d8-08ddb9d3cd72
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:49:09.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 061W4Ka+8Q1vHtYjHHMghV3Ur/h/yuqvk4BW91g0ev3tyG1PEcaC1CUaT6l34iKlnvDukdVKJIc63Bpuf4NHe/gbF9va0uyt8p1Q6GcvW9L2sd2ZGWVsLw9eQpa616uu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12299

Current Renesas PM Domains appears on top page. Let's create new
menu for Renesas.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index 54acb4b1ec7c..70bd6605a97c 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if SOC_RENESAS
+menu "Renesas PM Domains"
 
 config SYSC_RCAR
 	bool "System Controller support for R-Car" if COMPILE_TEST
@@ -110,4 +111,5 @@ config SYSC_R8A774B1
 	bool "System Controller support for RZ/G2N" if COMPILE_TEST
 	select SYSC_RCAR
 
+endmenu
 endif
-- 
2.43.0


