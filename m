Return-Path: <linux-pm+bounces-22318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1336A3A424
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CD316AE60
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3626FDAD;
	Tue, 18 Feb 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kmnx66HB"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893926F47A;
	Tue, 18 Feb 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899406; cv=fail; b=ePkNEsddNM//uO34gGEd8Q7CMD5cx0Yvr6E/44CLaUUl+Sf+nRBW/x52+tqA3mNrKJZ79PjQKz+6l1eRfaQjov7ejP39YUU9V4YQAAg6G9WC3sL5ViXvp1d1HP/uo8q3/gvdaBV5WRNbD1Cqz4PXwcLv6yD17QgkdzeRAbrKmOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899406; c=relaxed/simple;
	bh=Mwg9v+wuQnMkPWPNWUPogDL3ec2mhnhJ1U2osVz9Q5M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Znbh3GoQ9BI1ic22aGOMuSl1iw12MFQ7ok7MIuvaFCO5d+U4Gooi20NVbsIPtpLGVKvTmJ1+dw2ijCN0PTB/QE861FOE2x8UxnP/oVW5QkPmzE5M35zGJ9SfxlojhAzx1njvyRdDVHGrtKY+5DvhC4wMP6DxcTbChUKhZG9M+hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kmnx66HB; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBUI0CEUn7x6Mw1iE75g3z3E6/xhrSVgYsagkE/fMY/1sIfRiqt8UnlDOTMy+lM2eEHJEnp/cPF8h7cSFTA365h5pJRnmJQR3UShHZfJQ/RoUZCUUwGOG7a3NnFiPCF93kzXXnuybZ/AjyJcPmrlEOWBXgBhWjF6pGn0eRX7hQhyCdohjPG7mt+8aF/B6qB1OyLIwgyIWIzRJJBXccDqOvBecAo7vEg1fp5iS3MINUHYGtCbKOeTWRf/w2NieLn/0W3oQf21yy9E6+H7ECA4fXt3VectaLSAQandI8Dg3orzcZj5ymvY9VHEJtLpCR4aUZ48iLWciq9fwBgGPgMKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YFq1g+sBCdLR8YS/1ArspNrr8T0C4dBvavZnVyjorw=;
 b=K9ef8RtGH6/7gMDJzGugIlw6cyIgBJVwY+sOggAC8J0jbai68OyCQLR6J93fKWLb3UVGT0mQUZFmVVIYBWayRiMDKDAUlSV8umx4Fw37YhjKKoM4WJ4XwyNUX5aIFg1LZmMkTgna70JdCoXlU/b2BYoRvcft6w1wGAXpDbOKeOxF7DS1GdUAjaQaEy6MOzT/6DDVlQpkBIMfWiFk8LsS139ZHjlgGdt525tCtyEmR0zHwVjZs2EU4cLCar4Bb+KhLbwdMGmdJPrVEcZD8UsaHk0R+KT80Du057WULYwPXvlwJxXtk5SfJkuLibcOmdHa5kOaWlTpXQwa+y3+CoirYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YFq1g+sBCdLR8YS/1ArspNrr8T0C4dBvavZnVyjorw=;
 b=kmnx66HBPoRGG0rnKkwZ79VMfD8wAR9dsR3MMU3XCaZesX7YKG1BrugZBpopyManfEwamUqpaK0r3nT7OoBX2dG/8KoHUhgqOv79fCBdmqwGN1q4UljZpQA33/IUxui/60vDUVzr2MxTd14Q3vpodkNvanYb2FQZ8usBg7UdcekEaZm91NIZ0WnXOK0ki9Tr/C/3PEWj8VPdOhBwmWW5wHyFoxTvdTmR1NoLQfKTIR9mjciMUrkhA/+IUcEq+f572O2hPKqIurs/HDwWWj32cg5AcsFnEvTbtz2BpIoxbkNBZfwpcnO8+vtygXMcqEwgGwvf/9N9NrKm9W6oL8b5Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10596.eurprd04.prod.outlook.com (2603:10a6:800:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:23:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:23:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Feb 2025 12:22:58 -0500
Subject: [PATCH v5 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-imx91tmu-v5-1-76c0b27673e6@nxp.com>
References: <20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com>
In-Reply-To: <20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739899390; l=2915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=U52kb8zZxJdnuJaaMSL6kAhuRzQOevkcQQgBwCFQriE=;
 b=LFg2tkF5nbDE2NzVsSgxkMnv5Xvxr+vdmUjjPMvDHkxNM3oQvW6l23hiK1B4SaScvtTGkAqQO
 HX3mD8DHQthBfdYgufP2C+KylTjK69cl7qirEUxKrBKzRSEPRqGlIpz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10596:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c5cba3-9d29-459a-1a6d-08dd5040f131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0F2WEVOQkJzVUpPU1ExanR0Znh5VjgzVUpKMzFtY2dpSkVMRmFEZG10ZDA3?=
 =?utf-8?B?OWs4Yk1JdVNrdUhPMStCMDM5cEx0OW13MTFiUVJ2OVh0RFYyakZDbmxwbVdJ?=
 =?utf-8?B?OGRoOHBVZklBQkpjRXhSTUxrUGhNQ1I0WFFucytHRjl1UklnT2xmVEN3WUZW?=
 =?utf-8?B?VEMwVDgrVHNrNUNaNlNSNjdneVNxQmpjbDFSRWVNMWIzRHcrYXBSK2tHazdr?=
 =?utf-8?B?SEZiRE5ORjVrWC90M2YyeEc1eTlGSCtkbmlIck5YVFBOSVNoQ1R1M3R6TnVG?=
 =?utf-8?B?SFQ4aGhmSUlKOWdsSmxWLzhIUmhiUldVbFVLVnc1bVk5dVcyY0N6VjVrSlFB?=
 =?utf-8?B?V2FqcTJsV3NrNE9FeW9VY0Q5WWxDUFpBYzN5eUtGazZCTlJQZGZRWW1yenRE?=
 =?utf-8?B?NlBYamxXbGVQRkpOYnU1RHFFcHVUOW9kNzV1bDdmMlNpUldxUG5CR3VjeHBZ?=
 =?utf-8?B?OEh2UnVldmtMdU02YU5LUk5TSVN4RW54aXdmRU54b1ExWmZXVEdZMnFlT2VI?=
 =?utf-8?B?TktwZGJvaUpYemlnZzRpQlg3a3JLNzZPQ3hWbllWUWpQVytyWlNCOWtlcUtP?=
 =?utf-8?B?bys0TFJvUjNsT0RodVd4eisrOWx5Ym12eHNYZjgydkp2NC9WRTdYZE5vSTIr?=
 =?utf-8?B?aSt2Qng2czlSQ2t3Qlhrek9PRE41VFA1ZVZPNHk1eHlGdENrSldWQTErWmlq?=
 =?utf-8?B?Z2ovOTdnZnUxYzhtQm5ENFRKbnNnZ0hYQU13N2oySkE2Wnh1a1I2S3R6bVFO?=
 =?utf-8?B?c01PakJub2k2bC9HUytxK0lvODA4QWtpdDBNdU5yM0twcDNHWDZvRk1jeHZM?=
 =?utf-8?B?TkxROU5Xa2EwZFJ0NStNcHcvSk9TMUZEbFNYQ21GV0VwbkZFbEZ0Ty9xL0Fz?=
 =?utf-8?B?Z3F5UEhibHc1UHpsUFByak5ZZC9CaElWb1lNSG40Z3NlYUN3TVNjU1lrZzRO?=
 =?utf-8?B?OXRMTE5GTnRGQWRxeG9KR0FZM1E3M3F3eUwxdERnajFCR2V5WmtVc3VXY0VN?=
 =?utf-8?B?bERzYUh3WncvYXBPZGpUZ2ZrMFdvQzdhQVFUQ09UdUlobSsvaDFPWC9iZnND?=
 =?utf-8?B?R1ErSXgrQk5yTitPVU9makQxdFpLc2RFc2Yzb251TjJsV0E4dTdDV3REZHZq?=
 =?utf-8?B?SXV6OWFzUHhzdm9GSVgya3Q5S01JR2ZtdTQyc2x1Q3NIbGV0cWFST3B3NjlW?=
 =?utf-8?B?WHlaWTk4U1JBMDNQNFg1bHUwQTlMWEUxNWVrUHVLaUgvcGVVR3lZL20ySnFG?=
 =?utf-8?B?MkxXd1Jwa25YcVRNajFpUncyZmZHcWpTcWhkZHhyU0h1MVUrNURtM2tHb1Nw?=
 =?utf-8?B?VVJJU3NlM3d0Y3J6ZDN0YnFkUzRrRnlpWEM1OHZuQXkrNkkzSzJEVFNnMi9N?=
 =?utf-8?B?SCtEZmlncTFmZ2g2VHlkT1NwUzQrZ2hlRXliUlVKR2NuSFRraXdRS095UlU4?=
 =?utf-8?B?ajg1bE02dW1RWnFkL2RsYlhGYkN4bzc0Rzd3eDZJK3VMeWJaeDgzQjVWdkFO?=
 =?utf-8?B?MmZGRVZTcXg3ZjlmbkpDNXk2MlVraGl0TFBTTE5EclVPWVBNcXhiTUhDKzVq?=
 =?utf-8?B?ak1DMmNDYkdQb2RvSVRaNUpOOXhwYmpZbWRkZ2t5NThPQktxdTBXTnVrOTdp?=
 =?utf-8?B?NlJWMnZ0SXFDbnJnbGRFaXBNVVY5TVkwcGpMdnR4TmtwUlVGMUxxQXRpRVVI?=
 =?utf-8?B?YStJb1N5SDJHUktLSDl5NUZJK1gxZDZ6VEZyQXdxZXRVSGc0Zm43V0NyVmU1?=
 =?utf-8?B?d1Q5L0tHL3dyK2pHMzZNUDRwZW1TUHk2c3d6QWgrYXVDTHVYNW9NVHIra1Zt?=
 =?utf-8?B?Vkg5dlluTDRIaHZRSFppTzc5UlRQc3pkcXI0YmFTSlVKc1F2d0J1czFvWUd4?=
 =?utf-8?B?dTNEUHViVzRlNjBEZjFseGV6RXFQdmxzMWUyN1pzZGc0ZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGdoWk9jdGxBa3NVa2tGdXU4elNrR0FDWHdZTWNZVFVBd2gzNmw3UEE4SzZ6?=
 =?utf-8?B?eHQ4cnVmS29Bb0RyRmlHMlpJbkF2N2NPazlYOXdlWW8wMEd6VERTdUMzQ2tR?=
 =?utf-8?B?VDZhdnRZT0lZZTVZdWQ4MG54S0FmL09IZEM1MmpvOFFZL2tJZ0NQYVUvQVNh?=
 =?utf-8?B?S2FoQmFjLy9NK0pQYlJGblpWUWFZY2RQbGY5bjErTUl1SGRCRm5sNmEzTG1S?=
 =?utf-8?B?Y3l3enFqVTlJRDE4SXhUZ0pwcUJReVRYNmJiTkZQZlhHb0dSN1hCOFlGWS9n?=
 =?utf-8?B?Rk9rblQ0WFI0YnJuSnNDL0FzaEFabE1XRmFjSUZDWFdOVUVuUU5UTCt2QjJm?=
 =?utf-8?B?KzNNZ1p6Sy9CQThQRGxsMlNUSVNqV0NNR3J6V1RhS0Rrb0l6eno1cnhsNTBW?=
 =?utf-8?B?NjFZcmlXMVdHWER1VTJWVFhvS1BXQnQ1bEZaZGorNWxMOUx2SHVuOUNpUDRK?=
 =?utf-8?B?bEVvUTEzcmZXUjlRclRoZFpLRUZBQytwSTFGNVlaRTdBSmJqSkhWMWNtUUFy?=
 =?utf-8?B?VFJuSmF0S3BOQ1B4aGo5K1JQOTFwc2dITld3TGdPWThEdGxCR3VRTWwwMGFS?=
 =?utf-8?B?UVJqVXlJanE3TUlsSjNyMmFneUJzYzJFM2Z2UUNqUlNUaTJtTjRrTVhvdEFu?=
 =?utf-8?B?Z1dNRDIvaXBITlJDMXhkRlliRytiSjlHbWh0cUpiaXU3WjFCYTJpYzNKbVdO?=
 =?utf-8?B?TEtLM1ZaQ3JpSlNwMHlUVUhvMGc2OTJRRlo4VmlNUVpKRithRDllc2RhVXhr?=
 =?utf-8?B?a21jWU1oNWI3MVBvWFA3bDg5eDVHN25qUis4eVZGdEswK1laL0dmK254Z3k0?=
 =?utf-8?B?cmdCS2M0L0hVVDZmSWI3azN2T2pJcDV0ZTg1QXU4UjlwUUMvazgzUUNOTHhK?=
 =?utf-8?B?OENpQVNPVzN6NFlSRTdPWG91bEgzOUt6blg3blZWcVk1T0ZRZ09QOWw1K0FM?=
 =?utf-8?B?dE5EZ2hQMjBjd1Z4Vk05c0kxZTA3Q3VmS1FmTXR0YkZoV2JETG1TRjBvWG9U?=
 =?utf-8?B?clBMdTdjVVdMRDRVRXF5eVJtSis5N0NnSlg3Qm1rbEx4M3p0SDFBdERNRi9s?=
 =?utf-8?B?cHp1OXpJVzM5Ri8vcm43elZpM05BMng0Y0RIb3U3T2ZHMFp0NE05S1lNcTEv?=
 =?utf-8?B?cVFKelZlZWkxRGxYWW5SVWhQTFFFdU55Q2c5Njl4STJyZGxiSmRUWWVHNDFN?=
 =?utf-8?B?Q0ZiWCtLUU5JNlhQUC83aTdiNnYzSEwxcG9LTzdUeWhFVnJId1M3SkFEd0h4?=
 =?utf-8?B?enc4U0pYLzBqamNTVUJvS0ZkZHArYlo1YVVueCsveTQrcnBGOGdxSVhCeUph?=
 =?utf-8?B?UzM3YmRqbmxWU1hZRldJdUVFTG05V1ZzRkYreVBiazNZSDJRQU1qc0tUOGRj?=
 =?utf-8?B?TWpXRnRVMm9yUUk0Y2N1RlVJZHJXK2x0U3ppVlJKRXV3d05JRk9TaVlMaVFX?=
 =?utf-8?B?bVc3eVZXOXoreDgwT3FreExvSStZbGJqa0Z0UmkwbXArQ3RCL3NyMHRidHln?=
 =?utf-8?B?VStzQlJWMWhLVk1tYkpobXF4cUJTdW9KQng2enhCYjVKZThGcDFxT0l1OEwz?=
 =?utf-8?B?alIzc2xpMTJrN3U5UzRXc0ZkbzFDd0RIdXFQMGN6UjBwNVU3YTIveng2VS9l?=
 =?utf-8?B?OFJOMnBzeGN6OWJBK20rVml4QU9aT2lIT3RRcFBtSFFXZE1oZURxd2x2OHBU?=
 =?utf-8?B?NEV5ZzZVYmJJVGQwU2trUFRBQXF0Y2l1UnM2TEM2Z2o2NHc4Y1hqVVUrL0J2?=
 =?utf-8?B?SnNIODVUaTQxbzdiUTFiQ2o1dWpNYmJBL1N2aGRiUSt0ejZCOTloZ01JR1hI?=
 =?utf-8?B?Ym5Oemc4TE9ETHo2Y2QyMTRoeDYwUENJU1IrUjB5b1R3c0Jxc2hvR2tiUDBu?=
 =?utf-8?B?UHN1N1FLaThXQ2hseEVTUFNDTmFWRkIxR2VEZkl5YWQweUhvRHV5WUh5aDZY?=
 =?utf-8?B?cHdRS0ZQMWxFVFFPMmlTUkhHM3JBSW9Ja2Q5ZjB0SXkzR3d5clIrQUI1b0lj?=
 =?utf-8?B?cVN1K3l2S09qRTdoeVJyZXhad0h4eEwzQ2R5ZDliM1pCbXZXME1MSUhsTnc2?=
 =?utf-8?B?N2RzcTZhWXJYRjE5eU1ETWZVaVk0SXg0QUlOOFpadjk3N0dVVWdEL2ZxMU5F?=
 =?utf-8?Q?zRw8aPjmxPqYZ4WmbDXiod/1z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c5cba3-9d29-459a-1a6d-08dd5040f131
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:23:21.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUcWSIH7GtKNqtUV78wNHeg7SyUg8C6nrziZfMvS29g/J63e7m/ZJMTkv/sbDNpqVzoHYcEY1pBPa9Kp67rGJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10596

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add interrupts propperty

Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..2dafec8b37024
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Comparator 1 irq
+      - description: Comparator 2 irq
+      - description: Data ready irq
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


