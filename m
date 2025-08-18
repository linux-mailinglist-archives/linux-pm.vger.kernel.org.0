Return-Path: <linux-pm+bounces-32517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B48B29E11
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900C21964B25
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE72D0C67;
	Mon, 18 Aug 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WpnleaET"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A823176E8;
	Mon, 18 Aug 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509615; cv=fail; b=pBfekFrAJ3Iz0vTQVLWgzUJh10h5EQd604nbaqwkuRhLNSFvxKlJA/QFw1KFyTyJT78gLaJGdkutNkMIxo99EoPwbxv1CCFGAmKU2O3mvVnlHZXHKMwx6eHhnq+5U+kfyzhVz0M5e61wrJqVcVrmSJuu7CUptpabs9hJVILkknM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509615; c=relaxed/simple;
	bh=gttvk5m31FGx86jDqaHhwkI/KGyFMrph5NqIHqkfhLA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kQVpSOqIa7gPsM6UBXRAa0+WYAXZRnGLSpovvMg3doAY30y8Cqe/Bagl4tbWinwQ9HzdWFzP8S+jIU4OyTz9zt+obVw4vUESK3Tfrsg37h6hvEAzg9uTkJfAiA595JyoHznjSfFR4doMzCQKrY1nKKurWhEfwJz5jIfyN2v5HdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WpnleaET; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/DbRwUNp/dxAcqKmelqCsetP3xdU62fTDE2S1ZUoaxYep7q1QKIWSORl7TVT4x5azgl/N8RVq42zvtApbngE9CMCpu04LWAlc5JQfHAbcIWfdPWsFnkZdStPnl3vnlhl8tdszgxP9OJnORKIe7RHXIMJ/z0ag+A0DH0D2urXXqrAmLuNx5N32ub+0jyRkfvvRjkDCjoGzTDSmYQw780RTokOcAi39UMNWgIx7jVenpEvGWftR9vj/lOe3UF9h8B11H6KaEyBo/wdESNvMwpNmRFRLMo2uMSt5AnD/aLqgVTHRfhKuuk4nh4GyqmSceg2mahQxlSU3noD6Rxe6ghVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lozIDWC+aRB3xP0WBMuFzrowASSlpd7QxizH8zTCyGE=;
 b=QNw1AGHLRS0C/mW1VB2ZYRo5Ku50xkc2dOrchSogsjCfmSNbg8QFwEpEwilSqiy6CinoA+xbgzNfIMMZezW1RYn0+kJNeU7yg/kV0dqFNsQLZNxXWHm6epQZr6O0ZdIyubfKxq+t9Ki7TSVkhw2Zvf6Cdgv9nLcbDjzyEL2TZ6M/KrmymrHtyAB+b1hDJS/3u4u5UULKz3K4UDQleEc3jUYkmiFCCugGlkz5mtipbj4gb7FGT8S+nS4Rk0Ve+18Zbzn14iDVqDwcRcwtCBSJwiDBoEqQWk5RSAsraWe92O4ikTcVSvUzIp3PuqkCaYnmzxGTSzKR9CbuzoF1hxFAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozIDWC+aRB3xP0WBMuFzrowASSlpd7QxizH8zTCyGE=;
 b=WpnleaETFWMKLN/UzgOWg3QhNKObn7Pj2pl/0XUO1GRM64d7FF5SpahkEPSd2eWRaBRM6J6Jb7zHia+2cQbZdJypm8zDtDgqlm1HUUfX+bmvjKjlqsajGRYVyN51nGzOsQ97SKLO3F53HAdHrKYMZ4otGZcwsus3gPJCFoc2Up0gPcI1iswvpRS3JOpBTPkboqKWaynN8wNAQrPjiIdZob/enPgcVfbGaumhU6nARKafY0zjalSlIUtH2fn1MkomTsD6696j88PcLtYWlLhSshQBul9GjlW0ejIvTRsHEVlW71s1O7tBww38yIOBYxtqYFWJIm/G+zfp8L8lZ1Y4RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.9; Mon, 18 Aug
 2025 09:33:28 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 09:33:28 +0000
From: Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH v3 0/4] Update the thermal support for imx93
Date: Mon, 18 Aug 2025 17:33:10 +0800
Message-Id: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbzomgC/03MQQ6CMBBA0auQWVvSKSJTV97DGINlgFm0NC0aE
 sLdbVy5fMnP3yFzEs5wrXZI/JEsSyhoThW4uQ8TKxmKwWjTatJnJX6zzXP1b9URkaN2wO7CUPq
 YeJTt97o/ise0eLXOifv/A2pCRFujtdZYUqiihKl+9XILW6zd4uE4vj25OzuXAAAA
X-Change-ID: 20250804-imx93_tmu-7888c85d176e
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509601; l=1079;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=gttvk5m31FGx86jDqaHhwkI/KGyFMrph5NqIHqkfhLA=;
 b=mokhVv3oyToKxk4VT8cA3vG0ylDgZIHU1XdORYKCMsOOq7TxtcMJY4H/FFLl/vhvDadpDtyh+
 OmXdnPqihbFCHcKgd4/5ZO/1N3UB7htbnxehTBBm/EfNxhec+bllRUB
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 36542a17-9248-4d34-64de-08ddde3a49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXdhQmN0aTR2MnJ5SzBpTkRHK3pMZ0FmVHRkeEpRakFpOHU4ZEV3TVRGN3dX?=
 =?utf-8?B?bEFaWFdjTlkvNDc4UGlURHBMaWRRYnFDdE5zNmcvYXdPblp0NTlSa0NIZjl5?=
 =?utf-8?B?RFJrWC9PL1NWeFZ5NkpUcEJKeldiQVp5SEEyY0R6ZmE1aTVaV1NrRHpCYnJ4?=
 =?utf-8?B?V2svSEttZ0dYZ21iYW1ZVS9sYThYRUZCbmpGbW1MWGpaeWNZK3BXdkJrR2kr?=
 =?utf-8?B?d0hBUzEwYWJvYVkwZ2M5aXprSlI5VUlzN0cwK0M3dXVVZ3JkYTV0b2Z5d1VT?=
 =?utf-8?B?SW9xcXNsZFpIajdIS3d3bUVoNEtqL3RYVGNHR1cxNit5N2lJQi80SlZ0Q0ky?=
 =?utf-8?B?VkdMVUtDRXBteERuaFFsRnRlSFY1OW94YmZlbGRFZUN4VFc4N1hrRnp4VzNw?=
 =?utf-8?B?bGJuYnZWNmpFVEErTDJhU2NUVjJPR3RSYit2OFRVaUFWd1lVUytUODE5ZzV0?=
 =?utf-8?B?L1p6MjZWMU1MZUlkS3hVUkhZUWt3K1dJSVBIbWRZVFRsTGV4d0RCcmtONDUr?=
 =?utf-8?B?cHdVZk9lVW5yMWxuMFRNUDJzYkQrTkFxTDNkYjU1aWczUjZBMXFNWm96REdP?=
 =?utf-8?B?Vlc2Z05pbHYvM3h2RUxHbkJUZ3QrdUNtVFZpM25jWmhuQWtEZkIvdUNhbjhL?=
 =?utf-8?B?MEVBWTRzRmxUVHVIM0V6WG5leDIzZFZ5M0k3eUs4WmtkRkdsaHNPcUt1UVkr?=
 =?utf-8?B?NGF1cEhOeDBkUE1JbXN3bkdNNW56MjFXUXVGdVZ4ZDRtVHg1Slp1aUthTW0x?=
 =?utf-8?B?eEVER1VueGV6R1VBS21oWEdUOGpkSU5SSHFNWDNnY3JpQVJMQjNoc3dKSE5E?=
 =?utf-8?B?enF5S1JVNllhVkNqcnFKakhDRXZ5bUhMTUJnaFRCUW4vSmtuLzlMZVJycEgz?=
 =?utf-8?B?OURZZHgzanl4eTJrZTJib1NoUUVQb2xaZ3hhWVhHeFA5VUMwN2F1RWFEMTNU?=
 =?utf-8?B?ZFhYS2tPS2p2Nk5Bb1I0TmJZQmU0V0JiSDBhU1ZnZTh1cm9qSFFRTEVBdTY5?=
 =?utf-8?B?SDBGd1dBR3dPWTZFUm5kMHNSMmN0a1ViNXhMUEdKakFJd1oyNlpwazg0ZGU5?=
 =?utf-8?B?bTk3SU05YlZoZUR4cWJjd2hkVi9tby9lejA1S2R3a2RrVWI0UkNvai9MVFRu?=
 =?utf-8?B?OUV2UGFZY2dIem8zUEFxbVNXVjRQZ2pnZmdsVmx2enFvU0RLTzJsLzJybGtu?=
 =?utf-8?B?dVdsSllxN2w5RCtpOEJtU0ZMNjllSFRzOFc4WkNuQjN2OW5XOFp3R0pieDBL?=
 =?utf-8?B?S1NYazVKdXE0WjljNlczeDAxWHNMQmtoN3lHMjAxUkZlZDF2b0JIQnV5Rmpj?=
 =?utf-8?B?OHVrbnI5SXBmMTVlRTN1cmgyRUI5emRpcjk3WkpqWUpsakFQdWVPcmhqeEE5?=
 =?utf-8?B?WUVPZ1RXSWVuZXF3UFcxK3plSkgyek5aaEVDVHhsL1Y0cHJRYlR3L2lXU3Mv?=
 =?utf-8?B?VDRhMnJTa05SMUg5Wktra1BnclJUTVArc28vdXZmdHZDNC9zT3VOc0JCbitI?=
 =?utf-8?B?Nm4zK2lzeXhWYWdwZjFCUlJHSytLTFQrYlp1VzRPSDQvMXBkU0xGWk04U2Vn?=
 =?utf-8?B?NVJreS9pVDJiQ2ZmdjZGLzhmaDlhaUFZZU5xS2JxbHJWakdMTzQwUUNldlRG?=
 =?utf-8?B?S3ZXdnlEQkY2SDAweEMwK1pYTHBEdG0yRkNad2E0WUt6QmcwYW5Vc3RneU9C?=
 =?utf-8?B?VlVSYURhc0lTaW5TNFROcGJ5cnhBMWxYZUZrcVBDV3AxQmsrSUhTYndjaHUx?=
 =?utf-8?B?MTRpNXNmam03UndJSGpwbjd4S1ZPa2FvQmhWUnlZVzAxdm1IQU0xTTVFM29n?=
 =?utf-8?B?UTVhOXVqVENYRFVERnorcXNkUGg3QzRRc3lzRElLL0NudUZOTnVjY0hMZXpB?=
 =?utf-8?B?UHNrUk0vWHp3NXJhRzFERGtxdDh1N0Z2b0RENFNVMldRbWE2cnlhR1llODBx?=
 =?utf-8?B?c0FmeTRYZ1dLUERaSUZRTityZ21Db1gvcWxjTitQL1owNFJVeTZaK2FNVkdN?=
 =?utf-8?Q?1Lvv8gAIkAzIwSWHCYFYvFFc8gX/Kk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STlFSTdUcDFrdXdFaUFTdVFocmNJMW5QTGtTc2FVeVByeENkOFVrNzRKUTM3?=
 =?utf-8?B?WWl0MGMrWTh5ODh4M0VjMVlmZG5OeWQ2SUdGbGhMYmw2OGdDdkNWSStXSjAy?=
 =?utf-8?B?cHZPVy9lRlZjZTg1ZmhyZk9IRjhxSUJST3FnOUpPTlhZQUh6bFBDcmVCZjBk?=
 =?utf-8?B?M1oyc0YzT1daM1laRTBiekp1NnZIeG1HRkxBV09ZUW1MOEx6ZTl2MUJ2Z0lB?=
 =?utf-8?B?Y0pncG5JbUQzQXlDcWI1VGpOYnd0Nm9Cc0NYNFZGclBoc1pCemNPVHN4STJV?=
 =?utf-8?B?Y05YdWxxdmoveE93N3NIQVBEM3pFYXRLSllWL3l5QTlURWJNditmb3ZaUlRV?=
 =?utf-8?B?WFgxbC9tWE5jcWtBN0YzYmhJcUJlUk9YTnlQeS9tNFNqTTk1L3VWNkV5NjQx?=
 =?utf-8?B?eXRpak81ejI1UHFocC9vT21UaXhuUGlETW1KMFA4VU01SjZKdzlPNSt3eExH?=
 =?utf-8?B?UWVhb0xuaUlQbjVyRWt6UmlPdUZKUFowVlZrMWtkZklKZUw5Z2VDSm5xN1pW?=
 =?utf-8?B?YUx0dmdBV1UzNnZxTlNFUzkrNmgvK0NFdmo0ckdFV2RMMTBHMTNKZTU3dG5Z?=
 =?utf-8?B?dm1oN2MvZ242WTYzVmtqWkphaXlSY0t0WC9GbFdJa0NiVFNETkt1c201R3pr?=
 =?utf-8?B?QTVxMmE2WVNaSDdaUzlwRW1PSloveUlMdS9PYVlCVlJPakVoUGZWQm1EWGxr?=
 =?utf-8?B?aUM3TDlUWmNialRxRW15OVdsZ3BIN1hkUklZb0RvQWYwc2JqNitHSWdCY2Rh?=
 =?utf-8?B?dlJOV2E1UmZsNjBvbWVPQlo3TVRSbkFhMGJsQk40d2ZxYXBFKzFFRGxESTd3?=
 =?utf-8?B?Qkh0MTRFVnZUOTdiL2cvZGF2N2JJb0gxYnNRSTVic1FYREQ3TjltNFpwTVRz?=
 =?utf-8?B?VFliMFRKbGxlUXBJb3g3VXYrMFl6TjNsR0k5bFZhMmlLREpnVUU3WGFPZVBB?=
 =?utf-8?B?dlU5WklFUjJiZUhWNi82TDliNGFwbVovMXRzV2hiY21JZE4xNGE5YitodS84?=
 =?utf-8?B?K2RxdmFLQVNjb1VIcWQrdjZhaWUvMlpaWDZybkIzMEVwUUo4MU40T3p5QVhZ?=
 =?utf-8?B?N3Fwb2NESWd6K2ZJQ05jRklGbzNlTlNuWE42UkNJWU5jQ042SFQydkg2ZWxI?=
 =?utf-8?B?YnIrUE1VdjYzZzNKQUdUSnhKb1pvekpMRjI3MDVvNnlML1k1cjZNV3hFUnFB?=
 =?utf-8?B?Y1F0SGw5NGszK3BIMEY5aXBYY1RDeVJydFB5T1BLQ3doTXdUSVBrNFlCYVBh?=
 =?utf-8?B?WjEvZDhtbzJySXpWUzE4eC9tWmJhNUM1RjU5QUJ4blNON0d4RVgweXdGcG5y?=
 =?utf-8?B?SUd4RkdjditxaEQ0OWpKUUxGZjNHTk9JckI3TFBiTVBXQUVZR2ZibGxzdTc0?=
 =?utf-8?B?SlJPckl6L2RUQWpHVG0zNkNoTitQUXhEY1ZkWVJwS2NIT3EvTmM3RjdERG1L?=
 =?utf-8?B?R2hRdTViSmg5NXRQSXZTcC9oQy9sbEE5R1RQc3UzaVdBQ0M4bFo2ZHRocTEw?=
 =?utf-8?B?cG8wUWh1ZzIwSW9GakZVbDBRdFZQQjJmT2JXR3pBMWFySmo4YXRrWUl6SEI3?=
 =?utf-8?B?TTMzc1I5MnRvSUFaRFl4eGMwLzBRUjNhY0tWbDN6MUsvV3lFbFpUZlhUSk9K?=
 =?utf-8?B?TlBJK0dxWnBVTmRBWDZObmtobVIrTFRmbmxvUzIrRGt2UW1DZW5pY2ZIWnZU?=
 =?utf-8?B?UDlzOEwwTGxzaDE0bkJzbXdoSURuTkVQWjNkb3VWQkQ1N3VCNy9GbzYyaEgy?=
 =?utf-8?B?MUFHZXVGSFk2UEcvZ3RzcWN5enRVSW10UnpCTzNydVNaa0NXcXhtTVA1d1VE?=
 =?utf-8?B?WVM4cDMxOWJOa3JuTWswOFhUSzVpOFhLdENVV3pzSDdkVnIzMGR5bHV6dWFx?=
 =?utf-8?B?MmFOVExhbkl6emU4ejVOVzBjVWQ1ajUzUnRzNU5RcWJucEhBbG9rUzB1THRt?=
 =?utf-8?B?L3RXZVAweW5OTUFPaTIydk1lbGlwUXdtQlhkVkYra1JDVXA1Z3dTNHBzMWxw?=
 =?utf-8?B?R1paRkFzRFRGTUp1bUpXTkpTME1SN2l0bXErV1hRQ2FJNk5WNUVvNjhFaEd2?=
 =?utf-8?B?OGMraUYrWnI0TlN4OTE3aEtmZGFLM0VralZUaGRabGExVXJNOXhCWUVEa2Nk?=
 =?utf-8?Q?8oe7fFyYKDOAwmWC6u3hSTvZk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36542a17-9248-4d34-64de-08ddde3a49ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:33:28.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 704EeRyElKfrMRmbTcldXq8z3/If+ego3cEww6yW9C64QWqP7PDpOFeMCFNNOHEwzCy2q2sw9AUSa0YGH67mQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

The TMU (Thermal Monitoring Unit) on the i.MX93 requires specific
configurations and workarounds that differ from previous implementations.
So, using the 'fsl,qoriq-tmu' compatible string is not appropriate.
To address this, a dedicated compatible string and corresponding driver
changes need to be introduced to properly support the i.MX93 TMU.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Jacky Bai (4):
      dt-bindings: thermal: qoriq: Add compatible string for imx93
      thermal: qoriq: add i.MX93 tmu support
      thermal: qoriq: workaround unexpected temperature readings from tmu
      arm64: dts: imx93: update the tmu compatible string

 .../devicetree/bindings/thermal/qoriq-thermal.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  2 +-
 drivers/thermal/qoriq_thermal.c                    | 60 ++++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)
---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250804-imx93_tmu-7888c85d176e

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


