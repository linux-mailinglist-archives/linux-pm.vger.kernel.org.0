Return-Path: <linux-pm+bounces-41152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE3D3C046
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B94007F9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974C36D4EF;
	Tue, 20 Jan 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lI5P8lTL"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8C3816EF;
	Tue, 20 Jan 2026 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893246; cv=fail; b=YZPTZh8eef1TRM0irHbvXizeS8ghcAF7+O1ZKnA0XX3gxF/paYG8P3fMgQyXJ9KvYwLpZFvt2EXKJMLWXWx5emje5l0Inbe1O80O1o6TvWdd7zZvLbYiryYapxcwODzH2WTm6jOOqF2pB0uG5GAX38XsJPQIf/f9kzg0EnQ1zDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893246; c=relaxed/simple;
	bh=uvH2Kdwrq+eryRGUACd6R8iVvOQrx/tFy6GraB0GGvQ=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=tqSfSxa40g/wlyc71aSyrhJcya6yp/BrhtdljofaTYkjHWwDJJ/Maq03oddbbfhSAkrdgZN3VzCIBxyr3weEG2kAwat9DGZfDzGThQnzjnGN5vDcXoG2SREHRkOx8PChcMaSuSnMT5MkhV6/Fs4oqWisr229Bbf9cmJ9+oWhGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lI5P8lTL; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPIvKlcBEJFkDcsVpchbWVZwHcIQ8owt7AsqZw4bcpdaB5OwJjTVKTa7NkCr44JkfCi6jNmISLRUsNris2BgtEz+gkVzW9weUh8U1B0rtKH81o8JeXp6epC6cSWWajS/rUPi3MhZSmhZ5kqAnEu2sfM5hSCMMais1rbXXZeBLAxBva1diE5/ralWlR8P8OgLP29Q3M4mPTU1U+Mx5RSOWIFi0Fu67rNhg8m3j22I1NUN14qJg+05kdHqm8v9SH8N7Q5A1quZVhnb57wsBN/89ly/eoX2ItxpO60U0/FfhJpJYKXo+PgLqDeUFogvaiKV0iD/tNesShgVVYnUeYdrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2csLgKEwdAmqjl3hg2rsNCnQgtwwUVBevzsdDyyxjzg=;
 b=PTKbXXKtPXGb+hZS8MK8UsF8u0TAxgFBs9R8OQjbIGEkagr3IOVX5bsGTGVdOIgvTZ1r2qCitwNg/58xNB6NtjxrjN63DctcN1rM656K3Fl6CEsqy0rqOjTHfXKA+C5YG8UnpkIhrivPpoGp3h0GUvdf2X/KArxTr5poc+lik7v7m1hDaxu0jsuTU9Ac0U5pGRLa/nm88t+oaQJ2vt+xBz3QI7w5MRb03ZTNwbICyAY+X/s4zYyPlEYiUrtEIqQxsLTTGKHe7lljqYHBGFRkuUxIdGUEGBczlMRY/eltEg7TZRVdn/0vGpVMzo6WvHpTAHsF4AjG1cbIhrZi1gT6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2csLgKEwdAmqjl3hg2rsNCnQgtwwUVBevzsdDyyxjzg=;
 b=lI5P8lTLRaVUI9rMFWDNN0C6hJVAf4XscGpDzubwgaEqZ17abR1LH3KV9bGvIHU6xK2o8O/XY+v4wXfU0E0kQmE2ZklRS2lAUDcU2Qz6FRUXdyXQpHiWRnOwp8ZaPob1xdAnMbdS+6S9DqbgZfO/MNsWQ4jzersAHfJoaBIsY0MPNyoOCPctGNRBKvZSWqhsdNQ0DTKVksSDEiyGSlAywbICg49Rqx5iS+azJdlN37kTKt/wx/DNWHlgZ41tsTTo5vB8hlKLIBeRjz2XUWvCzIUH4PyHgZwh/OeSIifexoPH+NstUSnbmm1N/bkbkiIXd8pWgsHKGBJOyMS3wj/7CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 20 Jan
 2026 07:13:52 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 07:13:52 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Tue, 20 Jan 2026 15:13:38 +0800
Subject: [PATCH v2] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com>
X-B4-Tracking: v=1; b=H4sIACErb2kC/3WNyw6CMBBFf4XM2ppO0Qqs/A9DCCkjzKKPtIoYw
 r9bSVy6PCe5566QKDIlaIoVIs2c2LsM6lCAmXo3kuAhMyiptEQsBdulsrYbw7ML/kWxG7zt2Ym
 zNkoZkqh6hLwOke687OVbm3ni9PDxvR/N+LW/Zv23OaOQojwNFZqL1jXqq1vC0XgL7bZtH2OG4
 0u8AAAA
X-Change-ID: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768893229; l=2815;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=uvH2Kdwrq+eryRGUACd6R8iVvOQrx/tFy6GraB0GGvQ=;
 b=e6FKSysrChI+Q89aP7RfuoSdwmZQHQG2mkUpdDq7soY4PxVS/IXjJrL2inaUMxUi9fPa6oz+g
 4+LaqNMaIiwDyTVkH3LPjBZv+96416YLBSMmO6GWdD3DOAx3ACdIGLc
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|AM9PR04MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c525a4-93b2-42b2-3bb5-08de57f37754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkxuS0JnUm4vVlZuR0FjRmd1TGFKYzdhakg3YlJUNzEweGJMdi9KOGxtY1Ja?=
 =?utf-8?B?STZBek1jaERqNy9lRWpqQkthSHc2OE9FdEphcUZCdkNlR3kxQklUTmkwb2Nq?=
 =?utf-8?B?RklqbmhQOXErK3ZLbWo0RzRsZHl4T1dDd3RaNkQvRHpWb3ppKy82U2JCWklJ?=
 =?utf-8?B?WlUvWmZac255dGFTWDZpTEROd3lCeXcxZjZPYlkyQnNucE5XYll5Rm5DYU1q?=
 =?utf-8?B?RS9YWTJKKzh0RmN0Umh2b1F0dXREc2pjbGNzSnhPRVlvN1BhdHg3QkZEZXdu?=
 =?utf-8?B?KzRiSjZqWTRxRWppdU1PWnNHYkQ1aW1zMzlTaXF4MXpDQjNMN1JranU4MDNH?=
 =?utf-8?B?NEsvQjhLVWpYV09CYy8wbzhjSVVjQWY3SW5Eb1NRSFBRUjFsNUZ1ZGZRM1JF?=
 =?utf-8?B?SVdOMlRQcFduU054ME90S3praFE4ajJpWmtPQ0tWZHdOd251MENDaGRFMG52?=
 =?utf-8?B?d20xUE9aNWhsMnZLbUgvYnZXcTNpY0JPSVJJK2p6bXZkMitIUnZ5MTh2dVEv?=
 =?utf-8?B?LytnbUtDeHJJdEp6eGNsLytpOWpsS1BrUXg0OEIzQXJSM3dBenVyeXVib2RG?=
 =?utf-8?B?UjQvNlpSdjYxZHFRZkJPT2hFTTZFN3NObHlQU3dRZkYzZ1VGZUwzeTlOWVJh?=
 =?utf-8?B?MjAzWW1uTWMxTDUwREZibklWT0FVQjhSS21lU0doT1pBeDA4dTk2cXNjR3d5?=
 =?utf-8?B?V05EeXhQOWllZExGeWRiVENGanZjc2JuUmtQajBpOGdKeHMrR25NUExlTUVP?=
 =?utf-8?B?ZEF1SDZON0FEemphd0F2czh2aStsNlMzRjI4UXF5NDg5RTlnOWhmS0tDWXZ1?=
 =?utf-8?B?RXE4UGhHUk1OUzJiZmY4OUpYQWs4bkN3eUJMUnVyN05UNFZRTXUyTktUSDRD?=
 =?utf-8?B?VUJQRWJtQ2g5UWNlWVVaNmVOd1dVQzc0MlJuMFlxM285bEVLOVZyR1p3SGRH?=
 =?utf-8?B?V1F2allIczJFZHFWKzROdTFzT2N3c0FnNG5tTWhSSEtUQTdTcDFSZXZRRkNj?=
 =?utf-8?B?LzVzS3ZEcXpRb1R1RXIyYjRESyt1Mno4aDJTM3RSdnFuQXViaUJYMTM0L2x4?=
 =?utf-8?B?eFdEaFF1Q284L2xjaE5oQ2Y4R0NuT2o3YnNrM2psQ0hTeFlGYUczSG9wa2NN?=
 =?utf-8?B?bUMxVUtjV2JoNzN3Y1lCTk53Y3J5WElldVZNd2lHaENCK2dtbmwwU0RpVU9n?=
 =?utf-8?B?Zy9NRWc2NHpRRTFGL3dpTSs5UXdyd3NUak1qM1RzSWtQdTgrN2xXYk8vMkxS?=
 =?utf-8?B?b2J0TjdSRlNaU3hCZmlLa2VyMWpOblkyRXkvb3psNzVFNHJROVVJcGV4V2N6?=
 =?utf-8?B?QWRZZ2Q3bGdyNVQ5WTkvSExoYkh5WVFCUG51dG9XK3liNUUvd0d4d1hUeW51?=
 =?utf-8?B?TC8rRG16TitaSDZzWWIxa1hyQk9wUzhtWENnNmg4S2Era3laVXFLUDFlY1hN?=
 =?utf-8?B?c2x3S3BtWnJyTDh4TW1ncTl2TDEwaEpQNjJCZURNSG1HeDF1UEg2UThJaUlt?=
 =?utf-8?B?NzdkM1B6M3dUYVdHU3R5NkxYZnJNME5zZHFwT2tqZFVqYW4xcnVacHk3ckFI?=
 =?utf-8?B?MHZ4ME5maU1mY3dPZU5VOEpodXlMWGZNWGx4Q3BMYUVyZ2NIaXZ5Q1h1RWEv?=
 =?utf-8?B?cnVzY0hEbm5wdk8zQzd5dU5YTDFlc3d2a0xkbnpmVml2c012ZWhDbzZ1ZXRa?=
 =?utf-8?B?SWs2VkxxN2hwZm80M2VlVktLdFdvNERIbE5rUFMrRTlubVppSFNOWnBRZ2JU?=
 =?utf-8?B?aWxYOUhqKzM5YUxUcUgycmJubm5pbnl6RjlXdUlxNk1NTVBmcjdMVVM4cXBV?=
 =?utf-8?B?K3JkdnlDRCswYS9vWnk4MlVxTDdVZnc0UXN3MDhyMGJLSXZmRE1SUnlDWVo5?=
 =?utf-8?B?cklhLyt1eVl2bVFlL0FHSHEzUnl6UjF6NUlyNlJJZmh5c1IxeEx6Z2M0VzFa?=
 =?utf-8?B?Q0xQYWdMcVJHVi9OUXRYLzNaWjh0NmZWKzB5NGVjUENyQTlqVDFMNlgxY2hu?=
 =?utf-8?B?YU5Gd2RiU1U5NkgxM3ZlRElQMzVWNGRTVTlVbGJaSUZVWnlFTktybi9EUkky?=
 =?utf-8?B?MVZGVXpLeWdQWFY1TDd0aHRsYmhaL0tUd1V3eCthVHJlU0djTFlrSEdvT0FO?=
 =?utf-8?B?amFmYjFoRDBaM2JacU13UzZ4eWZyVWlOS0REUXNPd2Q3YWFCdlQxTjlNbFB5?=
 =?utf-8?Q?VlUJV/m16MQh5+HUE32B7Ww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b01UdGoxR1I4VkU4d3l6V2dWemJVY3ZxcXVaa0ZFVzYzazExV3J1MHRNT2cr?=
 =?utf-8?B?WThYVkE0Zmx0QkU2MmVrMUN4ajJxdlR6N1RJa3R2TUw1azRsaXdubDJucW5P?=
 =?utf-8?B?M2ZsM2RqdDlvOVN0QTdSWVlSYWhmSUhzT0RGTjlFVGVFS01FSStQaXZNTjZU?=
 =?utf-8?B?aVRyUk1mYkdKVWtKeUVoMm9Ec0tvR0J3emtzRHF3MkR3aGNNTThreDdIYWJt?=
 =?utf-8?B?VmZKbjc4Ti9ZdW0wNHR2Vy81dnllZXJDTVRwbWxQTEh4N2VDL255KzFpeC9Z?=
 =?utf-8?B?V1NNdXc1M2l3Mit4M0NTOGtEMlRPSnF2ZDlKaWdZQnd1dFJSZjYxelhYaHFS?=
 =?utf-8?B?aUFpdThnMStKVjZnZ0hSR2VzbDBBZGVoUjhlSmRGTUNMMFlCaWdTODdKa21N?=
 =?utf-8?B?Tmo3SlFLVlVPWForSHNEa2RMMktNNWhDSFgwUzJQd1lJR2hxaHZLMWdGZnJz?=
 =?utf-8?B?bXB6UGdqVHFmRm5QNTFnNjh3azhVaHFpQnN6c053UDZGemNBV0w3akladHJU?=
 =?utf-8?B?S1NYc2RvWDRPZjMxU1E0b2FwQ0pkanp1OHJWa3NyRTJUZXVqOWNuVk9hMXkv?=
 =?utf-8?B?NFZ1UU1FaloxQmhSakxCaUpqUnJyNlFiU2FXWGtMT3kvQkN1TnVZSlF5SGR6?=
 =?utf-8?B?aFNHczZVTVI5VHZVY0I2bUNxOHFCMndYZFNENmIydmRXU2VSWDVnVU5BOVZs?=
 =?utf-8?B?RGF6d3NuN09wQTUyVkk3WjhTUjU4Ujh5V2doMkV5Y0FXc0lJUytNV2o5UTNN?=
 =?utf-8?B?VEU1STZ2SEE1Z3phUEhRejBtZzhzNFlwNmdSb2VadklDKytNODNpSTlxTEow?=
 =?utf-8?B?dHhkaDJLSGRFa1Y1SEVyMWIzTXNaQzZsK2VORlBrOHVyaGZuZ0FkNmdoNnQ2?=
 =?utf-8?B?R2hVamtjeFZjWnRYbmRYWEJ3TEdqSnBOM0xhdzl1c0NoSmJmRnk4QS9iSFNr?=
 =?utf-8?B?NjhKdUNFNnQ1M3B3QUpZWVk4RVZUSE9oYWt1RFV1ZU1XbTJMd2s5MTQzMFlT?=
 =?utf-8?B?VmNRMkZIclZ6YkpseGw0VlA2TGJMeGN4OW56OUVLNC9WZWhHbkwvQUJCU2pW?=
 =?utf-8?B?V1JwQmtadzB2NWE1T0JWZndIMXh3YXBtRFo2ZkVGOFlzWXlHMGJrZWRFK3Vk?=
 =?utf-8?B?MTZpS1RZclBGekN0b21OMHpGeDNmeGdPTXBHcVNMM2FVbCsySUpGd01ML2ZL?=
 =?utf-8?B?MGR4Ukp4OGdoeWcyWVZld1BvVWppN0xMbUI2eFkwUk9iQXlhTGRjVnFDbGdX?=
 =?utf-8?B?ZnAxMU9OcktuNkhxZUJBclNCRVBVcnBMSlBlRWE5SXhjVFFxUm94b09ES0dB?=
 =?utf-8?B?a2hBM29XTkZJMGRYSGdjcSswbjVuZDZ5c0QxVWNSY296V3pIRjJ5RnFWM0Jr?=
 =?utf-8?B?dmdXYUttVUdxVVJuelZEeHgvVU9oOC9VZzBFakwvTWRNTGVLUTAvcDdVaHg2?=
 =?utf-8?B?TlRBN2VnL0dMRlBlT1VSbWM4Y2k3aSt6WU8vd0t0RU1iL1dBQ0F4ekFjTC9m?=
 =?utf-8?B?YURLaXhGTWxoYk15eDVmQ0laemx3ZkM0a0M3Ry9TMW9jNlpLM1BraFU1bHcz?=
 =?utf-8?B?SldKa2VuS0trWEI0YmxsRjArUXNHdXlTbXhsN1pTWmhNQ3hleG1pMTBRSnBi?=
 =?utf-8?B?N3MvR3h3VDRaeDdGeDI4SE5hOVVNWURhZHA3UXBYUVJpK2JVMytvc0VVM1ZX?=
 =?utf-8?B?dkRZTkljZXpqL1ZOVm0xVjVETmNROUU1UzIxVlh6SnlMOVJPalI5L1hnbDJX?=
 =?utf-8?B?eXRWdTN6ZTE1MTh2M3UwQmpmUFhGWXdOcHBZeWRuR2w4WUU1NFhwSkZmQ0x0?=
 =?utf-8?B?Z2NiaXdXSThrbkd5a2hrUVJFUWhXVUcwUGJkVi9Xb2JsY3ROc1FxNDdsNnIz?=
 =?utf-8?B?K0Q0bjdEbFgzSnlYWDZTeHIreGFjek9EZHlMTzhLYWVxSWw4RitCdVhIN0hw?=
 =?utf-8?B?VnphMUp6aWpEMlVEMDE0TzRFcEJEUTNDOEpEOXl0MkdkSUlTbUNFSlFlT3di?=
 =?utf-8?B?QktFQ0tuWGV1bzdaa1NyU01yaTBQUk0zOWNHdVVXNEVSd0xKNTVmYXZmdzht?=
 =?utf-8?B?NVFKWVJrU3IrdTVwZGEwYXNocWtBRS9GQ1VXWU1wbzh0TDFKdVlEdmpXVm1Z?=
 =?utf-8?B?RFN1RTgvYTkvRTdQYmF3YkZZbU1NcjJ6eCtTaXRjVW9QK2tiUUpZYmVSdjd0?=
 =?utf-8?B?Q2NDb2FuSmJjTkNqSjdmU05FdXV3d3pkK2JxNkVyTFhscE1iK3NnYXluUk9Q?=
 =?utf-8?B?eFExNGVqR0VuUm81ZVhUNVJoOFd0UmRMQnJSbVF3TCt5YjBpMmVKalYrVmNE?=
 =?utf-8?B?MENZZU93dWt1VW9JUUU0Z0UzOS9UUXE0SVpiMHVjWkdhT0U4RFNwdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c525a4-93b2-42b2-3bb5-08de57f37754
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:13:52.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5RRY1Q+wFG7IUSYXpjS8WjjJn2NBLSwESnkx8I2Wkgn3WFdH2mBn7BAyEwlntJQ+T2jilIQe3kkamoewqBxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876

On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
also triggers a reset of the GPUMIX domain, including its ADB400 port.
However, The ADB400 interface must always be placed into power‑down
before being reset.

Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
handle dependency ordering. In some corner cases, the GPUMIX power‑off
sequence is skipped, leaving the ADB400 port active when GPU2D/3D resets.
This causes the GPUMIX ADB400 port to be reset while still active,
leading to unpredictable bus behavior and GPU hangs.

To avoid this, refine the power‑domain control logic so that the GPUMIX
ADB400 port is explicitly powered down and powered up as part of the GPU
power‑domain on/off sequence. This ensures proper ordering and prevents
incorrect ADB400 resets.

Suggested by: Lucas Stach <l.stach@pengutronix.de>

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v2:
- add prefix to patch subject as suggested by Krzysztof
- refine the patch to move the GPUMIX ADB400 into GPU power domain
- Link to v1: https://lore.kernel.org/r/20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com
---
 drivers/pmdomain/imx/gpcv2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index b7cea89140ee8923f32486eab953c0e1a36bf06d..a829f8da5be70d0392276bd135fb7fc1bbf10496 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -165,13 +165,11 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
-#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
-#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_GPU_HSK_PWRDNACKN		GENMASK(29, 27)
 #define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
 #define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
-#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
-#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_GPU_HSK_PWRDNREQN		GENMASK(11, 9)
 #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
 #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
@@ -794,8 +792,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
 			.map = IMX8MM_GPUMIX_A53_DOMAIN,
-			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
-			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
 		.keep_clocks = true,

---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


