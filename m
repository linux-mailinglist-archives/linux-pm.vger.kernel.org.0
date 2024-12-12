Return-Path: <linux-pm+bounces-19155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E529EFDC2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 22:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11C7288EB5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331A1AB6CC;
	Thu, 12 Dec 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l+YL9s9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9113FD72;
	Thu, 12 Dec 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037233; cv=fail; b=Eb0v1mXWYuae+98ovXIrQJsVvzcQBemW1LyZCNG0Ja1Fn8c56igkICOFkraRCv4BZ+5MQwOhFeIBebswqa4K53optGvLPvgMrsIGdguFPgE95tym2uHFBZFmsfc4YyQbDCqwpTaoP+/GUMWilJ4nyUHfg0C96lPk+sBO88+acZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037233; c=relaxed/simple;
	bh=EDKvmxd5IyI/TmIpI8gga9zx6nKXYkqwB8iYGkX3HOE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tw0ml+LzD8pVvD73HR6eFqOojzfCPQ5O59RuLM/g46YuZIkz3cIS0AEoDUv7G4lbCIqV7bldk8qUiAhhF8dzt1OBakAYoGys/mVFhBMn6hisYqKyRXvkEOfFdcN3B3zZzX+orLwwF3m8pU2TJJ2hexRTNQB9ThcX2y5bvAMML0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l+YL9s9E; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfyF++CzWwJEhXQ+qsh/YNjcLmu7sdL7xMzO5S+xgK9yxCm4DRa+ig3CM88F1sLIuqCPIcRRiDUPNrfCj5SSv0AdGE8x0setZHSBtv4NjILkFWhllI5s9pgFp2c/mEOasoDrEf00ISGVZhpjigbNSMegNijUOTXzP5MaOzPmpvBmJJZR4Pqk8eECVz3TjA4TF0f1XQDkw6q/SP/IalQf2TH0Eg8RykSgWWvVk4XGG/tHPPgbU+JhnOMgxXpDriahjJHSqNFdzbnlTjDBvU0N3oEog8wJ9EXkN45INBSRmSlSc99AsY4U3aD23G5ebMxU1ClA4npEVfgdRPwjsRBXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk/ktrBE9344DCN24CHnPNVT0V2mBR0ugmzx1qOfEZA=;
 b=oEqiWJ1HyCk677XPVwC0VgEL8/3kaS6zurne53Wa6uw7pDTr9dSuLWB8LrSl04dxj/DLuoOhGOBEFKt6+vGBB8DZ+obWteU/3Q0NkcFlgwnSojW1GDxrT86f1tXyhJJHBxesm4eue/dEhot94gF2GxjZ23L6RV45M3cukTVqxAWORUl4rX60RjESm8uuZ4fUkafKOuaZwM8PkaiKkhS8w8wo42qh3UeOreLcWFXTRvcm0eutj26Ytw5WUHCypCJC1VKVhRQ2yVYoZHXNhH7f2ZbjUnZvAYgeavpbmOZxBNTBPtNtwxgrIOxZjweJcxc+URhC3kNuhvpt3Jj2ldTQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk/ktrBE9344DCN24CHnPNVT0V2mBR0ugmzx1qOfEZA=;
 b=l+YL9s9EaHpIdnMcN3JaMtZR4fJIMjXci/fbojeRIfqWj8aWDPrksNig9r9KMg14IDjNHAy3TWkdjp6JwomFzaQL6yaq5mI7lUKc0PaA6uDnylQNQReT+ZSbfooys++4Lbve1aURk3u9hO06YI8aG49BEauqMc21TBhN7CSe4z7NqfWnyhlvFplVwKx2Z43YA6LhUZEM5NGltKx+SxxV6dxDT8nVxMYO5N9Azw1gva6gAk2wf903SrVKLDkrOKeLWBsbWXlfLamt7Uq7sPpvdu50LpUjVlvuV1hMEoh2qgQYaCFBsN319naPaUHtAHSRTWr2DiQOtbWhiOS+FDmMUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 21:00:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 21:00:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Thu, 12 Dec 2024 15:59:58 -0500
Message-Id: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9OW2cC/22MvQ6DIBRGX8XcuTRwkYid+h5NBwJY7+BPwBIbw
 7sXXerQ8Xz5ztkg+kA+wq3aIPhEkaaxgLxUYHszvjwjVxiQYy2Qt4yGtRXL8GamQ9NYXqPTDsp
 9Dr6j9Ug9noV7issUPkc5iX39E0mCcdZo1VolddNJcR/X+WqnAfZEwpMm+EnDoiku0RhXO639T
 8s5fwERaB9A1QAAAA==
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
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734037218; l=1907;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EDKvmxd5IyI/TmIpI8gga9zx6nKXYkqwB8iYGkX3HOE=;
 b=t3ha4XPKbiZuM+RMcWONIyCnXH6Zg85mkFOJBlkS4sEXZ/VzCEX7yEXvfK0O4hWsz5EkUmZq2
 lhkkkJTEzfOBk2P59K/shimgDriOTJEE1Zk2DrBpYsqb7iq+ArNKUgh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 151d4119-51b6-4089-f849-08dd1aeffece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|52116014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2k2UnJ6bzRzaDhkYU9FaS9VOVpUM0V2eThmSy9wN1p5cWhsa3UxaTBVNlBh?=
 =?utf-8?B?ZWlYczlndWE1bDdSK0tTNUhBZEk2WmNCK2FaaVhwZnhuSHRzRVlJNDNqNGJx?=
 =?utf-8?B?bERscnEvWTVubldWZ0dVUmJoOUNCZ3dvbitBQStMeExEK2pBcTBIYWQ0Sklh?=
 =?utf-8?B?NzEyWDdROTZ2VmtKaUJqVjNEbzIyaFNvL1doUjdkbGhaUmFqZUFDKzBnK1lw?=
 =?utf-8?B?ZGQ2bFBpZkoyYjhPWVlpbHdESzlZU1JndTlMS0J5MGRrS24rTVdpcTRaRG9C?=
 =?utf-8?B?d0VmMUVubFdvZG9kbWdGdWxhV2FkZFdWV2pqS21ZKzJDaVgyV0JRYU1uM2xP?=
 =?utf-8?B?dk1qMlFUMWhFRlNZWDlxVlVjczlMR1JFTXAyRlM3SmQwdTNwQ2lyQlVzSVBs?=
 =?utf-8?B?anp6R3JuYkl0VFp5Um90cEtsSnljQzFsYnkrRFZrajBzenNOcFd0N29YbFAr?=
 =?utf-8?B?eW1acElxVzhOWllvSEc5dnlWaXYzblVTa1VWeGJWMGJIa1FFTSsxY09ob09D?=
 =?utf-8?B?NlJYMXN1aGZSZnpXWDN6M3pQK2xFUVRGemp5c3YyMXMrSFljaUFtTDJtcDl4?=
 =?utf-8?B?a3ZLWTVrbzJXM3lrdkpQZ1hhQ2dZbjFEMldSRitjSzRmeG41WGU2NWNEcWxC?=
 =?utf-8?B?c2pWZ29FMDR2cEg5OGdLZGJNcHZhS1pHL1ZhSUJBZXJHTXp5ZzA5NUZPV1Qx?=
 =?utf-8?B?RTlWRmVLSVg5MWxMVkNqa2I1OFhrS1RrblBVNTdtSno2QWhXNFZ6UzJ2aEl1?=
 =?utf-8?B?VjJWV1hrTGJDNTg2WTZUUWRYRzN6enFNci9USHk4L1IyZW1kZ2RPaDRwTmVX?=
 =?utf-8?B?dlB1K2RCYk9xdTN6SDNMbUVBNkJYcDQzVmh5Y1FMMzdiY3JLcFpGTzNFb1FO?=
 =?utf-8?B?bVNOMXpCMmxhNW1MOWU4ajlTWEFZNDNsQXdDQWdBc3FOOEJtRkg3TytXK1Zk?=
 =?utf-8?B?SkFlYVdxZlZBM094ZHNFMThSOE45cll5YVVqN3JXZE1CNTV2QWJKRWVUeTFj?=
 =?utf-8?B?Z09YemttSUJHSjhoMVlZNmR1dXBtUG1FVzh2eGdnczNiYnpXUUpNS0VMS2Nj?=
 =?utf-8?B?VktXVTNSVlBjU0FvWWN2MU0yUFlEY1hBTVRLWm9OZ2JBcCtDWnJnaFM5K3Ba?=
 =?utf-8?B?UmxpNDcxQzVNTkVOMHlsd0FPazExSUtoMlpieTVQeTdsaDNLUlJzNHpDdmU1?=
 =?utf-8?B?WUZKZWRodUI4aXZ1VXl4MzgzZ016WkkvSC9LbzRxREVxVWFDWnZ5YklQWlY4?=
 =?utf-8?B?bkJrRlE0WGhwM2lxTTgwOEY4Sk1PdFllSlBod1NHV0xTbUhPbnBmK2tGZDhr?=
 =?utf-8?B?OHFCMUkreVlBeWI2NmZTQ3NKVmttVlo5aUtXUVJ5VmtyelN1TXl1dmE4REo3?=
 =?utf-8?B?ci8zcVVEQVZxQldVa00yczZZajh0RUtMMDFGL1h6ZWgzTWErTjRQbHJXZzZO?=
 =?utf-8?B?dFJGZS9ZVjRHVUorVktueHhYQmxGQURhaDdNek9PM1UzOXRkNzNRbS91cWpG?=
 =?utf-8?B?TkdtVnRIbkxBd2NRMzh6TkpMV212eDM4SEdFM1kwU09QZFRlZVZ0WVBidmMw?=
 =?utf-8?B?Y0dhV09yNHlsNERwWGZ4TkFkQUw0aC9WQU5yUUV4S3dkT01XbEJmOU1wTWNB?=
 =?utf-8?B?VUFyZ2p0UFVkaVByaUVJOUp1eXRJU1VEaUU5V3hwTVcwMmdwa0piRDhvaUFi?=
 =?utf-8?B?N0xsMDRWTzlQTElhMm1KL0dJRWE3R0EzeTd1N1NpUWtUbGtaamRmdU1CVkZk?=
 =?utf-8?B?WmVETlp4QUhpcVkvNGpYVkN6bVJLL2U2a25RTlpWMi82ZzFCWmJyNFpFVDVq?=
 =?utf-8?B?UXdLbzFXZHNQV1d4QVZjWXZXdUhrL253aG9zcVZ1MXhiVzFROGRJZEdpelow?=
 =?utf-8?Q?c2Ast1p7JEgnz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(52116014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFkSTZiN0doazE3T1UrQ3pPdFlaRU5hNzdSUnNVL2ZLYWRyNDY4RFlyZ1pD?=
 =?utf-8?B?dmErcDFJS0RQZWhOdm43MDRrd2pBZW00MEVxSXkvcmxWN09XZ2w5Wm9wdWlN?=
 =?utf-8?B?YjhQK2c0SG12QjNpVkV6bkRyRkNuN3NWdS9nY3NMQmZpWE5qTC94Y3RFYndE?=
 =?utf-8?B?dVdnN2Uva2tqcGlYYXNBYWpXMmxBZk40T2t0SEhBU1l6Zlk0WG1JcEVoQlpZ?=
 =?utf-8?B?cVU3cFJVSUxyUlc1U3JLVkFXUnFVeHFjdllzbTd4UEJ3NjNJa25nV0RYcGVV?=
 =?utf-8?B?KzBHUlB0YmVSaHlwU3pEbHVKZk5LbTgyS0cyalRXa3FLd1pGYlo3bndPRlRk?=
 =?utf-8?B?ZDN3c0NNeGV0ZTUzcnhadng4Lzd5Zkswd3FIZXp2aFpBWTR4S2dWelJBNkN1?=
 =?utf-8?B?eHMzVWx0TDFLMDhUQUN6dWZIL000a1dFcGpWTElYbkFGUUI0U05rT01XTVk1?=
 =?utf-8?B?a0ZrcGRUb3AzU0s2MjVidThBRTJMQ3lrako5MytxNXNFQjhZbTZDR0pKNWN0?=
 =?utf-8?B?aXNvTlVZRGlNNFhKaTNZTDdtNUVCV3RsMXgzQ2VRSW5zVE5VTU9nWWFDYXVp?=
 =?utf-8?B?L0gzMFRCdGVQYThGaDdzc3NIWUtSbGlBVzZHWUl1RjlFZHVTclZGTkc3bExZ?=
 =?utf-8?B?ZjBZQWUyZlBaTUdGZy90MmRxaEQ1RUxDYVhtbmJlUFUzN3lUVmx0RFFqZFky?=
 =?utf-8?B?UEo0MmZhQUhldk4rcjhWNmpvdStRWFJDSEZhdkVySUFWMmtxQUVhWUNhWnhx?=
 =?utf-8?B?OWtuWk9GUmtROEZuUEZpNHp3bUVaOTZoby9KdVh1MFp4Z0p6VkZ4cVFMYUVK?=
 =?utf-8?B?Tm0zWFM0eVNjTDd0M3ExOERJT1h5V3FuUWM0NnJFcmdrak1BU3B6Y242YnVF?=
 =?utf-8?B?SHJ5WEMvVWNPZDd5RzhVZFc1YS9QL2hNcUZPS0RzYkJhaUlHQU5JQ1R3MW1M?=
 =?utf-8?B?dEFIQWgyUTY3cjQyK0haS3cxWm80THdteW9CbG9qM0hsMU1aR3d4dlpDQ0Nr?=
 =?utf-8?B?c0F2VmUxSnpRYXhHa3IyZ0xybVNCRDFVbWtyYUViKzNxSlhUL0pXMEMrRXB0?=
 =?utf-8?B?WW9Lck9qRVdndFZDMDFFQmVPQno2bmdSK0lKVTZ5Q0xvTFo2Yy9QMzRtUnRH?=
 =?utf-8?B?ZWlaOHpVaUM2SG1KUG9jS29IYzlDOVdzT3VXQVpFaWlPRXMwbHc2d3A4dnRm?=
 =?utf-8?B?YksyTUV1bjdBbjdXQk12ZUE0NFR2UnlrZUFZUndQR2lnRGlUN0RtQzZjWmJx?=
 =?utf-8?B?ZEhnVTVPSytweUhXMENqSEVxQlRmbkxzOFUxZ3ZremFjeE1wN1lJcCtrVnhu?=
 =?utf-8?B?dGh6MUlOVmhQY3pnK2Fmd0pZM1pZMDhRQkFxVHh2d3k0WXF5OHJ4TGV0dTVt?=
 =?utf-8?B?SFoxVGZSQnFCRWN6SFNhOWludmtYb2hQa2lyVUhKd1VuZURxdEVlTFhvQU1r?=
 =?utf-8?B?NkFQQ1JMVUtjYVJ3dVpyck1Nb0ZnNnJQcWtIbDlvSTZpbnQ1cEtIdTFaM0dV?=
 =?utf-8?B?Y3VRRXVkUWtIVlFTY3VsV1FjSGtnclpzM0ljamFZUEo1dG9pcmJaWkhXNUJO?=
 =?utf-8?B?QWZBSWtGRTAvem56MVV5YmllT3ZMUEUwZm16dTZsTUYzV0ppT2Z1emU4eXBE?=
 =?utf-8?B?UWdrWUl3dWQ3bG5lTTJLRWZ4cHJ1czB0YXl2QjNlaHdoUGVkMnp3YStLTEI5?=
 =?utf-8?B?dGN3UlkzaVljM3NqbDkwZ1JOenBwZUZkWVorbkswcHhqNGpWNXVJQnFtTExo?=
 =?utf-8?B?U1NZSjNuVVcxNUdPUjMvWmVyN3FsZElab1IxR2JQRmkzUlZweDVhcjdRMVRJ?=
 =?utf-8?B?WHY2TXJGWVJhM1Viblp4UWNJcERKSVIrSm45anBkZ1RIdTlZejkydWtDWnVw?=
 =?utf-8?B?RHRkdzIrUWJYbW42M3AwS3pJKzRWVVdYZmhpeTVtYXh2RmY2Ly9MMUVMN2Rl?=
 =?utf-8?B?UXUvbjB3THNGem11RzQ5QittdGlEd1YwZzNnSzJsQTliNlZVcFFGWHNiMFBH?=
 =?utf-8?B?L0orU0ZsOU1xS1lDbldZRCtxQ1NQVnZzN2xKVDREbG5zRjE1Q1VoeVNSQkNH?=
 =?utf-8?B?bWJsNWtqMDBSYXB6RWl4TUQzaXFHWUk0YzJGbmk4MnFXby9KRXk3dVhETlpr?=
 =?utf-8?B?QWRZSHhYcmY4c3dZalVVampJb28xQWFpWVFhby8xNXNMR01ud25YWHFUdVdy?=
 =?utf-8?Q?7a6RwInSrj3abebpUD3erzsX2+uiZEIZscYvpo+eCV/J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151d4119-51b6-4089-f849-08dd1aeffece
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:00:23.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eblO9kEWN7Bpr6mEOfhs8LxM5QYjiDirEzwffr6Yr9N0kjIZWoNgli5WFWyrj2s4eVAt8p7+1YVwWk9pe2q0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  67 ++++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 263 +++++++++++++++++++++
 4 files changed, 341 insertions(+)
---
base-commit: d07c576946b2bc440d6d2073998023e8a0bd7568
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


