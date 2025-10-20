Return-Path: <linux-pm+bounces-36507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9ABF3171
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B90400522
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985A2DA743;
	Mon, 20 Oct 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBvWBy0Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69D2D8DD9;
	Mon, 20 Oct 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986882; cv=fail; b=aEmfxuXKfHzURyWroYEiVztwedo1rlh+oVG5APACRGxDf6I6GA1VrMErKy6CUZQMc26RpLoIExh352OXRiqp6GKQrCzwHavPRP5U9gdXrGmfj6qKO42foHeOudIHOO17rb5FIk/RMe14UaZct8QwWDWeIhfurxAkx2XlTw7x0ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986882; c=relaxed/simple;
	bh=leddeLUr4tqu0YHTrBCyyTCDC8ZXo0ibpKG1uAhmFrI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jOE/EveP+a+2pN5wgJGPeYJVP7yZ54QYFZGSpPcERiA0MlG/5zEamKsn8Vhm3uto18a5sfYx48jMfj3+Ql77Qhs1VEGvJK2ncbZHvKpj1XZ2hzSr11o7PcpysX7MwvDbX3W5yA/jFM3zYowo5MopqhIn0s1CdW7dpn5/C4Ua7mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBvWBy0Z; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkXX3cvZVX3KmJyeSrLRXJ7SNRWXL8QvKjgOhJe+dkCeOe2tuKA9zEMhSIyK1nZzQg/IwpeHFCX06womeXSsVTt5Bu9Ahw3VdRmLey6wYV+qE/wLDqUl7KXByY5zswOZjtRjHJtoX4U9X28V1eCUuISGXnVoQpg++P6F/xQvY525HJuii4JRjQ89BXQ28EG5WR6XlIhokVnrI80TkJqvMKpn4ccg1E83/feA1l3Mo1G+zd7nkBZoNTL8nINaHkv4kc96SXutva0iJaHmczUlQAJoHVfc/vMPBmgp7I115fiNFCdflEAPlP8IS+Cyv7evhpZl2Nn+Li1tc4Mj158HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykGrHe3x7vCtc1nJ1unMaM9dWgBKylYog8kvfpqIG8U=;
 b=g9mnKGbadnmhfMcXwJNZZuPqbyI3KohLr9RmRgZJRbwYrorqseA1/c2VV0SraWwiOMBwCCkqhTxW9kwHpfExnsSIX8ZgKG8aC2gLDzIL2goxqiOlHpzDoTvooKOEAtWAAIHqEpl2WQ88ku1dOy+ao2QkOf5mkVeonk19GsHgbGChIDdTInq75YGA1bFuoGHxCg6IYOeUS6qymWn3ai2glxSGd/w5lqrzBXPa6dH0knkdPHVLJ6I3MMNqS3QuymGUBwff1ZgxTNEosRTvCYbM8HgUFjCM00jQe4u5C6D9Zq8m1LAH0122L6X+VJVn0W7cVdvvnXVOzP19lXDU8gtTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykGrHe3x7vCtc1nJ1unMaM9dWgBKylYog8kvfpqIG8U=;
 b=fBvWBy0ZteSQAYdldDWfqvTAsMY3+jFniT1tZ2XTsADmMmgSZAd5joEK5NvM4fA7fjtedL07Q3VykAM4ZHI84Xyx2DrbWxlYTHy3LLFUGQnAfO5xU946nPqlnFc1wH6LUFVtaYssgey2Im1SSGSYPeOqfRrXzKlbG8GvxVvurWgEa3jhpqwXJyvOvVgVwnN2OYrXxhuQ+PAWn/KNLf+zcFUj84qdsdaYWwyLRhTy39fr8VcZTPZ1piY9YECntUAAokoFjOOG2W4tRTNop3ywkJ3S3nD8lZW+8DXlSNnij8J0XOxW+kWMhHyzxcEYwFIA3Z0D0wfoBmKc2SMPpTnHgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by MRWPR04MB11288.eurprd04.prod.outlook.com (2603:10a6:501:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:01:17 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:01:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 15:00:42 -0400
Subject: [PATCH v7 3/3] arm64: dts: imx91: Add thermal-sensor and
 thermal-zone support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
In-Reply-To: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760986854; l=2036;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=leddeLUr4tqu0YHTrBCyyTCDC8ZXo0ibpKG1uAhmFrI=;
 b=zuT5D4qpKXGZ4kYbsKC4pTtvZ3C/BwkduS0L0mMXzLJRxkUowmVMaUsp3EG0mO7FPQO+1mmq4
 gw0Ltk/qdDnDU2UtolEBRJZs+7Lg6m6v8BhxCkUaU+KQMuEFNKCUqkp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|MRWPR04MB11288:EE_
X-MS-Office365-Filtering-Correlation-Id: 19095f43-db94-4493-c49a-08de100b0c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDB6TnFUaUZPS0UwN1ZRSTk4R3o2TGgwdWtVcm9xZ0ovaG5TMnFXcm9qZ21O?=
 =?utf-8?B?YW5zcW0zRmU4MzRYWEZ2T0ZUWTE0RTF1N0hxZnFsLzNlcXN1ck0wSktrdkJ5?=
 =?utf-8?B?OUE3N0xpNXMrTHFFYjAya1hndU5oTFJNd3RHNG5xTndLOUt3bGtYV1FLVDlI?=
 =?utf-8?B?TjdWZVpkeGtTdVhhZUZ3WXFjd0VZNTRjOGlucDF6djBGSzVuZStiSzlRcWd1?=
 =?utf-8?B?VmNKZndaWFcwbEI1NVY4UmJ5aVZidGhhT3VKSFB6NUsxZTFTMlkxUmVBSmNF?=
 =?utf-8?B?b0NFT0p1ejIrRXRlUkhPZ0FMZGVsU0p0TWh0MkhzeXZrSjZuWGtHM2JqRUpG?=
 =?utf-8?B?ZUQzdlJMTThiejhQc3UrMFU0bUR4Sm40KzhoT3pFdUgxUS96LzRtdlBmd3Y2?=
 =?utf-8?B?K0U2Q0dVclJsUWRMdXlyOStab2xUUGRBb0lBck9Tb0Y0UXhuQ3Y0OEhXQmta?=
 =?utf-8?B?blNqYkRTaW41OE41TGVZY1VJVElPd0U3SXo1dmZmRXBuMlNIR2pmT2JCZVBX?=
 =?utf-8?B?RnNCNTdCanRpNG5LR0pMVVA0Umoya2FUam13MVEveU0vNWM2NklEbzB2R04r?=
 =?utf-8?B?bERpYnF2cDFKNEtmVXA5RnNjWDdLc2sxMVJRa0gyMjZ2UDZJazd1MDBKa3BY?=
 =?utf-8?B?OGxXR2FhMDNuRFpReHVjM1AzRDgvbjROemhLUjVHV0tBSEhuYUt2TkJWZEVu?=
 =?utf-8?B?cGpzNm9heTM1M2tMN0JYN1FFN2MzR0NmMlFTQWZuWWV2UWdVQVFuSnlaZFF2?=
 =?utf-8?B?UVZWc1k0dWU5d054NHp2eThQSmxqNmR4ZEovTk0wd1NUN1Qya3hYZldEbjkv?=
 =?utf-8?B?NDArTHhwVUpGR1UvZlpJK1RqdWJadmowWHRvRW5HUGRZS3dSajI5QjVEVSs3?=
 =?utf-8?B?SnE2d2pJUkZyVXJVRVdXc01yNHpMcmZGRDE3Mnhlbm4xRm0vRzVyTzdabTB5?=
 =?utf-8?B?WXJIOUlCQVRXTXE2Q1cxVzdobElQOFVJSEhIUnBjZU1lQlhLYmdWbUFnWHdU?=
 =?utf-8?B?dXlpTE1lQmtGemJ1dStOeVAzVHl4NjdVUzlnNzdZb05udUtDUnJtRHZYMzZ5?=
 =?utf-8?B?NjN1RWJ3bnNCV2gxMHQxVFIvSm0wTnQ1NlAvaXl3OFZuT1dZWlRuSkladW9r?=
 =?utf-8?B?VUk0b2dJQU96Ym9HQ2JHaDFvRmdNbnkwdUswaVZiUnpnaXVQLzJyTE5FUCtl?=
 =?utf-8?B?QkNheEdjMHNqSWRVU0xFWlY2SmpBZkgySXB1MFJlZDN0cUNkMERCb3YrODJu?=
 =?utf-8?B?MEcyV0pUalZ2QlFvREJpeERpUCtVZnNBVU1MNnZCM2ljSTgxdWFqVU9xVmE0?=
 =?utf-8?B?L1owcXJNWWsvM3NuRnYzdllpbVZzTGNacVA0OXNpbEg5aFR6M1pzZ2V1YzVF?=
 =?utf-8?B?bWlqQVI4N1JkRkt1WGE0aE01UEVxVkV4ZEgwcFlULzNUSmhQWG9PaUk4WlBF?=
 =?utf-8?B?VmJxV3RNTHBXN3Y5c0F6K0pMYXYxUWJTQURwMnl2c2I4WDBhNHhodkY5R3pD?=
 =?utf-8?B?NXBhdEJSK2ZFTVBIUzJ2NjM0Vi9VV2ZZcGtnRCttdTM1aGJRK1A3WlVkZ2RM?=
 =?utf-8?B?TG8wY3pXSjdkSDVaWHhXcFZhem4xelVHMXBqNExWajUxVVZ6ZVJWSGI5b0dH?=
 =?utf-8?B?cUtrVjN2T01zREVZZ3J0WjI2NDFQTndpMUFaSG43NU9pV1F4dWZhWm9mVkRU?=
 =?utf-8?B?YVZNQUJtYnN6cXBjb3p6NUZmMUE5bmZ0c2I5aVIycGpTMnJjcERPOEpwN3Fw?=
 =?utf-8?B?U2FOb21nNm9OcWNzRVFHby9pR203akVOUnJpWTJkajNBNnhnY05uQXh6L2FQ?=
 =?utf-8?B?eWNMdlY0RzFCNHZNbDVaOW5PNTV1VTh4WGV4dVFzVXJ6eFExMDdkYWZXaXpH?=
 =?utf-8?B?K01VdTNRK0ltY2xjOC9mcTNmM0NXaE0vOUU3WE0ySGJ5NEJZRmVWU0oxOW5U?=
 =?utf-8?B?eWdhcVU0ai9rV0tIYnZmVjlEM21PMEZ6R2wxa3YxM0VzTU55UlpUWXRVSkVV?=
 =?utf-8?B?Ly9yK0FQcE10RFRNK1NHL05aN3VTYm4zSER0YVQ2T1hzVVl4ZkJaZHJtY251?=
 =?utf-8?B?d0VYM1RWTnhtQ2VlMnlPbWRLUTBINVZJUVE3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTNtMkdSRi9jVG4zcEhncUJ0ZW9meHlqMFpvZ240Z2hUR0hHOU1qVSt2NDdX?=
 =?utf-8?B?TFpJcHgyazBWMXlpT1QxOUlmMThpZnJQVnJxZnFkN2xFQjRRbDh5T2FYYTRH?=
 =?utf-8?B?b1pYUGM3U3BJL3FoUUh0clQ5K0RBdEdnb1F5K0FKR2d4bjhXQjFwYkxqanhX?=
 =?utf-8?B?Uk1hUUVGcGhuNDRnTjk0dWNITDM2aFZjTGJxRXF6UXNIbTlMUElJZnlVQ1NV?=
 =?utf-8?B?YXZoNWlOaXk4TjR6RTE4NjZWc2VKQWxCMCthbVpWVFhyZW80b3JRR1NsOGVB?=
 =?utf-8?B?c3BrUHNwWlZSdERGMkswT2p1M2ZoaTc3QmduN3d1dng2YWRRdGVLaVI4RkxR?=
 =?utf-8?B?UE9KYnBGdkZ0WE5LSWc1ZTladlV1RVljVDlzd1B5Umdnc3UwNDh2ZlpmTVE0?=
 =?utf-8?B?cXByajF6UThxekpPYlMrN3QyVGtMYlhrVXB3azd6Mjd2cE1mQ3cxWFNwT0o4?=
 =?utf-8?B?Z1VHNlNhbzRVY0ZjZFVxTGZQNloxMlQvSWpFWHVqamRPSGFOVDBKT21BcUhw?=
 =?utf-8?B?QXA0RG1MbzhwekxLb2ZxbHYzV3BJYjJxQTVPWHVEcGJEL2xtS1Rxb0hKWi85?=
 =?utf-8?B?bWNCTW5uUEoxTFBiMmthQUFVV3JGZGxMS2Vsckc5ZTFUbEZ5bFZ2SDNhVUVP?=
 =?utf-8?B?SWNjMGZVS000MW5TVUlYQzhzWkhnR3FabFlCc3lmeUFERDF6NUtJbXZaa3Zt?=
 =?utf-8?B?cWVYekw5NGVQQXFqQ1ZjZFpVbEVLekVjWDI5WmVPbkcyaFp1bVVJRk5Fdy9t?=
 =?utf-8?B?QlFjc2xxYTNPR1lPdmR4eHdjRmMxS3ZCaFZNNEtibEhjRVZNRHdzaHdPazJB?=
 =?utf-8?B?NGFVT1pPWE96SzlpaVJIV01FN2lOc1dkVGRUVzFjNUU1UXFHcnZKSU90TUtL?=
 =?utf-8?B?T1dCVnVDVzlQQWtBZVZXQkRucjAxMzFlTGZVNDk3am5JRjJBNHRqVmc5aWdR?=
 =?utf-8?B?MENBMkRrKzdyV2NsakhsY1VSOGlKZnFxWEFpUXF3V2UyMHhUK05IWXBpTGhq?=
 =?utf-8?B?bHd1alIzQ291SXZyei9OZEkyZWNKY3lDeVN4bmhBakN5L2V3ZCtGVksxZHp6?=
 =?utf-8?B?eS9MMHVkd0VlekdpdlU3MWdTVmNvaXdOS1BhODR2aUdKelJYSzVKL3lXdlZD?=
 =?utf-8?B?THZDenlRdThSbzF2aXp1OEwvNkRHSU1ybXdwNCsxQlVRWGNZbElWTlFRMTdp?=
 =?utf-8?B?ZHMwbmxDVFdlaktDTExDVkttcUowOXBWRTI1WENxVlFkSitYbERBWFFVVDd1?=
 =?utf-8?B?Ni9OSkM0U1VOVTc2ZjQ5b1lycWtRSXJrVUN5cGdKS2ZJdVVyb0w0RDI4VlU4?=
 =?utf-8?B?MlJHM0c5bktKTmkwbUZwdFdzT25rYVU4Z3YxSVQ3cm1HOFM4VlkvSEpYbVIy?=
 =?utf-8?B?K0laN3Z5Q05uRnlUSjdIbERPTVNhWHFxczJSOTJ3UmhYWDJ5YW1hOGdVMUZY?=
 =?utf-8?B?Y0xnbk5jWDJ3d2JDQ0p1TThXS2tMeDBoSGFiNWI4WmtIcFVoQWhvZHlMa0hk?=
 =?utf-8?B?NlNITzBnQ2c1UFg1Z016MmoxM05jTjc1TmdNRkdHZ0RGOGhqTkUvdTQ5WkY2?=
 =?utf-8?B?dFk0NlpYQzZRdlkyei8zYXQyY0xEMVlGcUhKQjhwaExOelJtUUtzbmF0cnl2?=
 =?utf-8?B?cmUrUWhuaWhrbmpycnpZVEVOL29HT2JPMXp1ajJ1WHhxb0pvSnp4d0hkcUZX?=
 =?utf-8?B?cEI4dEhEZzF1RHdwYTVZRko1TzQ5bENCcktZOGtOMkg0VDFBR2laMDUyQ01B?=
 =?utf-8?B?a1R6UnRzYWtNcWMzQXdQc21PVG14VGVoV2NkbGp1WVhFYzd6aU9QL0k2ZmIy?=
 =?utf-8?B?VDZKT3NKR3lFU2dVQkR2dzBOTzV1dnZKaldmSXF4bnNVdDM4ZDhTcFllREds?=
 =?utf-8?B?TVF4ZDI3WGVkdGJjeTVSMlN6N3JDRWc0MklBTVpTcWt1MWxrQWVQTXM1Sldm?=
 =?utf-8?B?V05wdTNXbDU4UFRSSGRNL01ncVZxeGFSZ0h3MmtzVTJScmE0MDhJSDNWdnNI?=
 =?utf-8?B?VWFxbVNLcEt5OU81TS9ZZTRJZTJUeDROSEh6a1R1dmE5S3M5aUlBcTdHaDZw?=
 =?utf-8?B?K01BQUlNMUZESHlpdDlmQXZmZmh3SlFrcjA2T3d6bThJMncwUHJNekhnWnY4?=
 =?utf-8?Q?X36z3+gYZzd70m4bQn4m9VEN9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19095f43-db94-4493-c49a-08de100b0c31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:01:16.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRr68UGe67k4kGoFVW5QJWr38VBFMcCFZau1KLZWxn32cRnU9v9yhbmLz53vA827Nd3QGID1SdFr8ZzC0gNLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11288

Add thermal-sensor and thermal-zone support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v7
- new patch
---
 arch/arm64/boot/dts/freescale/imx91.dtsi | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
index 4d8300b2a7bca33bd0613db9e79d2fba6b40c052..f075592bfc01f1eb94d2a2bd8eea907cc2aed090 100644
--- a/arch/arm64/boot/dts/freescale/imx91.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
@@ -6,6 +6,54 @@
 #include "imx91-pinfunc.h"
 #include "imx91_93_common.dtsi"
 
+/{
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
+
+&aips1 {
+	tmu: thermal-sensor@44482000 {
+		compatible = "fsl,imx91-tmu";
+		reg = <0x44482000 0x1000>;
+		#thermal-sensor-cells = <0>;
+		clocks = <&clk IMX93_CLK_TMC_GATE>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "thr1", "thr2", "ready";
+		nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+		nvmem-cell-names = "trim1", "trim2";
+	};
+};
+
 &clk {
 	compatible = "fsl,imx91-ccm";
 };
@@ -69,3 +117,13 @@ &media_blk_ctrl {
 	clock-names = "apb", "axi", "nic", "disp", "cam",
 		      "lcdif", "isi", "csi";
 };
+
+&ocotp {
+	tmu_trim1: tmu-trim@a0 {
+		reg = <0xa0 0x4>;
+	};
+
+	tmu_trim2: tmu-trim@a4 {
+		reg = <0xa4 0x4>;
+	};
+};

-- 
2.34.1


