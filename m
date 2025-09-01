Return-Path: <linux-pm+bounces-33582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D5B3EDEB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D780B1A884B2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEBB3101B6;
	Mon,  1 Sep 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FmARqFM8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FmARqFM8"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0310FD;
	Mon,  1 Sep 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751634; cv=fail; b=raA4qcKmJxXC1DZhevG2t+wdgZieTvwm2MXqWsaFhw738gC1J80kr3bHTgMN4i9FHH+KS/QG7FpSYJpq217ZmVLz5uF//YYvi5tWSEFwRdIBdUwP1mrm5wtMFptQM22w+doShE99Mr7FZveu2s2sGFvz5mOIBCJEjmSwggawEi4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751634; c=relaxed/simple;
	bh=GSZ4rropxIJ2ifgHV8/Cfh8mXpEIYZw2NiPoPmJPYcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aSJrhSWjlPqWluLK/fXyCE7DGmO03hsCnNA+/6yucNpjiRgxwSx9e6J51FAO5Z0NWe485bTLIXovqlv6rpc+JM7/g4SCCSBt6q0EZ77JKGBh5tV91ZLwNfBuDyZtbS8hzIfqmqnWpYrXjPyNjysCJBkOaPX3SyWAp3Zjc86rGao=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FmARqFM8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FmARqFM8; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=b0rMEBWZ9lIlaOvKeKIDdnqa9w5TLIj4ncj04V0XqwHrzEBL7aUWPLVDu8F6PvlXzxCjG3+D38gWFYsxM5ejvRjljERD31pmExdL95USwxaF2IsW96p+oNLETslbXfE02LuL9y31Mu0IvsF8PIen5BknMSbwSYBDt55n37Qful+1DDhpbX1+bL/bfp9j9ZoGhqKErMg8x5Dlz+sPblzzNXzl7Y2KyTxT68afIKJ9vdypikMDu6+6GZN6o5Uk6SYxho2JX2opmuypkxfJJ4rd2KJDY7ihKhh6fJU/A+NbnRPDkI3TnoCuQnEKmLsk6BQ/ZyIFrc3o8IiaVTlF8pNVyw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qH3rw/Al2blWNvC4q/r7HhgHGqIMtHf0zyFKVGYGAk=;
 b=xMMTp+rD33HGYVzpkyAKerXnVhQsWhtOAoFZsYmRK9CIrXpKks0lXFBFhmwUJpyf1HEv4vEaWG+6TkYsVsd8w4jXFQ7T8offMaD7y0Cl2tL96GcvofnilmlsgBAt7K87lGtc4SNLv/kSoRTlw9YA3wlWzaH2VAGNP40tfsFmeE5hN2qwVVdpOmzmKHC31CGrRyn5PqVrh1qSu3WNx3hUE2A3UKeY8SnCVzGsy7DYszv5iqaUEaVgjrn3qAkR8969/p/VwHQwOWGLN7uvRRH+uAfgxsvCExOWcnp8ATPDjfuKpeVMG5TbPmazix+75+TvUhNNDl+ZEFpyJKHoTs6ZUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qH3rw/Al2blWNvC4q/r7HhgHGqIMtHf0zyFKVGYGAk=;
 b=FmARqFM8fodNHqLe3BELSfSmKAis/MQGLLeIHVvZG9S6DLBfxGBjP1soTLNgeoTmAH9+W5AmFpjNVFbsSmwXQFJTDQn18ZZFP60eKys+lksKDL43USBstDz7CtXbSHQ8IzjlrdKKjXjiOCRfWPC/HM8hSHFjKZLQ/pO8s8DtxPY=
Received: from DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26) by
 AM8PR08MB5665.eurprd08.prod.outlook.com (2603:10a6:20b:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 18:33:48 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::e) by DB3PR06CA0013.outlook.office365.com
 (2603:10a6:8:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 18:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Mon, 1 Sep 2025 18:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBZ2sPYfYq/01JUrT5kpvoNaMi7EQ4J/qxyX1N8kqAS3trkawy9Y/ifSi+J2YNXwr65xxNhUf3OTOOQyqZgzeeFJqWtcVSMUIvrEwvQPXhPkA5ofRroFDrWiwKPLLycZGJEje6SL9BBjVTiGSh4ZzMnQ1+BBWuHpFO1hwrTVZSw1WzIMU5CFRnKcqIeRB2n/30IxedZCo4ySG5QufA/vbl+3FKDIgH1osd0fievNkiHV5Q/Dl4BYFKxsbtOGZCu0Q+ziJAspTITYg13KLCP17YRtDHgdN1koU8/fVANh06ALzjhCYPTIIRrw3bFqBf94NV7VuUMrp6CYiiaVLuuOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qH3rw/Al2blWNvC4q/r7HhgHGqIMtHf0zyFKVGYGAk=;
 b=axtZ9KtWP0XMVjUaNaW9dopFXrHg8MRvtdKxwkD7WkB5ZmlA0YBr4f1YXCrTPT6JHYm6el6FjEPjLxQHxFCiAgHhzxVEivAnWgsd/Z6H/9ZM97G02bSue3Wh3+BkTHTXspqLGOpY64m1L2D7+1RTzDGUHR2dpNN9737TxGF6lhxuY+4DtE9YqEo8CIAXD4iKhUk3FJrPV3UJTMjekC+F9p2q4T5NG0l6/lCLetwghgXzPnIkEa9U/AcnKm+MFN525zM6rcXeotoUTw/RKdMbSxEGZKzkL3NqcaG2ylGJ+bu7h8FmEbRH5QrQj2LxTmmWdQ2/HMGl195l4x0IfbZE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qH3rw/Al2blWNvC4q/r7HhgHGqIMtHf0zyFKVGYGAk=;
 b=FmARqFM8fodNHqLe3BELSfSmKAis/MQGLLeIHVvZG9S6DLBfxGBjP1soTLNgeoTmAH9+W5AmFpjNVFbsSmwXQFJTDQn18ZZFP60eKys+lksKDL43USBstDz7CtXbSHQ8IzjlrdKKjXjiOCRfWPC/HM8hSHFjKZLQ/pO8s8DtxPY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB7812.eurprd08.prod.outlook.com
 (2603:10a6:10:3b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 18:33:14 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 18:33:14 +0000
Date: Mon, 1 Sep 2025 19:33:11 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Message-ID: <aLXm5/R+mrsnT7tn@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-5-yeoreum.yun@arm.com>
 <aLW4FTcqommWSIej@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLW4FTcqommWSIej@e133380.arm.com>
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB7812:EE_|DB5PEPF00014B90:EE_|AM8PR08MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 310b3a09-f07f-434a-1ec8-08dde98616d3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Vh69CgyqPfZuzLRHPs43yqihhgkzx16u1FZnhUfKnAeK2vbknYprLxW/C5MC?=
 =?us-ascii?Q?teUAPIXW7OmJpIWK+UrsJ5hqtIH3dLfj0Mq3U2Q/jwRsRQE0AKjTlBmHiTdJ?=
 =?us-ascii?Q?H/aAK6fztVR7vybYyB3qPgknibYZqHA+ts3N/f+QZkcBzbSz9beS+eGYMwFO?=
 =?us-ascii?Q?7XDAXNjeUdclgsS31p5EykcJ3G7HcntjRJFjBeD4YlItBZQc+GUrEXp9BLV3?=
 =?us-ascii?Q?UbtvNsuw086Z5zSbnnmaxydPYZDzFwK/TqLkoUkYC4jez5xQzZk6UWDFpXV2?=
 =?us-ascii?Q?kyeabTI8jdpQamfKQ6mE+g+B4ylh4XBEMkCDzfo3iGr+Ik8k9rL4N5EGZrNJ?=
 =?us-ascii?Q?sgIhotm8kBhcAY92JQNCHb0+/tHiFT/AbjPSOzN7bqJyHBUHARZ1HLds09g5?=
 =?us-ascii?Q?a9QlP70uUDh6ytpnu7uPaFsqOc0Y6eNRtELN3rnO2HlG3E5aWIkCD9HDM11e?=
 =?us-ascii?Q?th35qY3VvDUgWMHtelTFu8+pHSVypEWMoskR4y7u3XtPF96sz03XfgA3vasT?=
 =?us-ascii?Q?tyJGfuDHISD9hwsWDVy+j+RZ/d88Ekd58GrzTprRNiBv7x1OZwPP6XpCTz+a?=
 =?us-ascii?Q?z8GbHvVWRMQmqwBEkKGzUA/JKtNUqVRWof4IZFeEmJH3uPcu2a3n/brgHTMa?=
 =?us-ascii?Q?hhkJyRUC0x02wAx2Edez/qeA5uQyh+OgPDKDqLM5uIMa/viQZ2NGvle5kOCg?=
 =?us-ascii?Q?vPM/97eUw99VCHlL9Mw/a/1UCOgSJd5KnrmE6YD03d8/b4vJ4j+CyCRXCCD0?=
 =?us-ascii?Q?CK2cKk3LgIbF1t0Fnr3Bo9VeI8q82u5IogD6gyrXaDdSMD9o2vOOGqcHPgAe?=
 =?us-ascii?Q?Sk9x+Jq50G/xOJ1pJ1kT8IH0IPDMY9sxTFquNchKA6YWJ5hGV2gQW9Sdexik?=
 =?us-ascii?Q?yc5OiDXEp2XZVZqrvbC1aGAdzNDR5DhggxKZxSe5ic9KtTXL4kXIdCG99lcR?=
 =?us-ascii?Q?Q3LIgEnXhX0KAuT0vz6c3dJsH3j3vDlKur/jEjVsYXfNz/sHAKsy0awuSQKF?=
 =?us-ascii?Q?Zv2uLk1QYv5lWMmP/fuVr3QJoKPu9Yxl+HFDNgwqT0Jf6mgBoA7NzdkQxx42?=
 =?us-ascii?Q?6L4YihhmoOeAqw4eLfiJ2QmPmOBKvruIeQT6A7mOsD8sN1DIxZ0wbVL83jBU?=
 =?us-ascii?Q?i+qte5vaHqY5K0QcqUeLEKxYwVR3Lg322rHrEFpbCRAtBhQtWneSyfZWSZYH?=
 =?us-ascii?Q?hNU8fkb8EVXO+Idyv2HkxYjLHyI9xo78Om3kfTf0wuf+qgO11SCVoXV5n2Uf?=
 =?us-ascii?Q?wCHS9T8O6b8eAZrg7hAFQoKc6aKwqKGYEWB9LzHBke1/YOMhyEi+LOwcVPe/?=
 =?us-ascii?Q?GhShqGM6bEKkoiTaRJxpohfLXBoCvlCxB0H3BGi2Ld3pHSE588fVzfrjPSKw?=
 =?us-ascii?Q?OkToegJKr3rbG0InW974ElpYM2pQLZ/L/YQ1+vL3qgFoS6z3ojbMnUmZZag1?=
 =?us-ascii?Q?GEcmIWFuWEM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	faa0a5e5-6408-4ee2-ca5e-08dde98602ec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|7416014|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7IENwyYTImRdjzaoBriZgQ6jxW1z6SNIycfgXr44tD4EW5+XhBpkSKw+r+E?=
 =?us-ascii?Q?Mk22BneEwfqEI65SDDxePOABqEo4gf5O2h3mu43spFzsbTtCvzah1rizxQwq?=
 =?us-ascii?Q?16kI9qSWxWFLtZAFk6QobVtIYOojpLgrsNytEDOYyd5jaRDXmN/CMJJuHDvS?=
 =?us-ascii?Q?T3XDtREmT16Ds0E3ZWMY3QuJWToH4BLb+4K5Vpr2a5vbJmRprVWLMzF/W8xh?=
 =?us-ascii?Q?YnbP7Z9WU8x5plcADEBlGxR1D0Nwgy4ybEik/ZbyznJ/I3IVmiZGOTCw7rSH?=
 =?us-ascii?Q?68k4KBfckMQkN60FBHsgPcAhk2XtgmZSSzI1T5cu0HOZyV4RvCBlfzDOCHKK?=
 =?us-ascii?Q?aUzdb5PtOU//sviwWoP1cwJEJvwTHkyW17A9NXZZnNG7dRTuZ/smgjUoY9Pg?=
 =?us-ascii?Q?5ic5njirCvCrhX8s2M7DVXR+635OpFZ/Jn7Bl0ZeLRpNzVRQvnU1l/RuZpTo?=
 =?us-ascii?Q?1Z/3wUrgqgpI8Bb2kVZ97sxNmUn35YjBICNRhhV8en+P+gJlYFTKRbaQhsGS?=
 =?us-ascii?Q?zyB8YCecuNNl5nzbkc6goJJYDNbiVo9LGVnGA8k4XLLxmZoiTzOfeM87IkZE?=
 =?us-ascii?Q?I3m0EzLd92wpWS3rIXTQhnOR4jcJ2IKVMf4t9bL1b7HlheeQDjjsi68znTkF?=
 =?us-ascii?Q?3ZJ2gb3bnzZKWJ0CAXVv8toU3sTvb411WC7rG3sGMe9+SPXAj5bQS7RbgpDL?=
 =?us-ascii?Q?MwYcg+N6xrkRGeQxTiEvH4a10xGjYjAzNMnoqcpCo5tH2q1ioQvSixeEGFVF?=
 =?us-ascii?Q?nvQ1KcjZ0nHvxRkh0dTK/kc2Xpe6PGgWINnBxjy6VcZ81aj6JAtAZ/RsWZPn?=
 =?us-ascii?Q?S/EtYZluw0CAiegArmGH4FKLRJhmJ1VGeM/+pu03qWwRzo2b4o/tQs5hDHAX?=
 =?us-ascii?Q?2149TI5iTEvGRdl7TH3v6pgTFZKDCNWegeDzqBE3exs98K4TsTdpniJFviOr?=
 =?us-ascii?Q?DWdrDSYPk7Yz58CS6IfLtfkgSwrMFcHCi3oyX9Dj4Yqt9vBthFTBOaqENrjM?=
 =?us-ascii?Q?B+pviQFa7dxuKAzVAo2qhZH6T3nX8hbsfLAWYBnv+BQTkpWZ9QzXuQHnA00w?=
 =?us-ascii?Q?LDIZTd+HiiZD/KOYHYeq2vzJOP61HZb6sUV8VUFR0x3L8Fh4j8iGbvfApaUB?=
 =?us-ascii?Q?qYnTskosdSNjtYq8fqqbc2cyctIbAM0ZjMCQLfpmliVp+K40gBRSVjza8ciG?=
 =?us-ascii?Q?ZldwlWBj69oixoI064mj/5eUOEeLskXIC9JHDvc5y3jBaVChbhJRAt2aTMeU?=
 =?us-ascii?Q?E9NZ2gwoujpZc/ttcBPMBHxilzwqzaBQx3hMNt7q9lGyPB6wUUKztP60mrdO?=
 =?us-ascii?Q?ILL8/8zmo6UYqYWRqY/IsKUXcvu9VS4bFXSbkQSl3O8MzKuYRYdzEVD/pbPH?=
 =?us-ascii?Q?cdW0ydkq4JGV1drdK3PJ0GbdBDqEgui3dCIytywlsbdvtERRC4mA+Drp7e8g?=
 =?us-ascii?Q?ckiVLFabitXxo10y8sr4RfoVUbQMEnoSPJD1jKbjz3VRX9ofkjpbFVLWuLC8?=
 =?us-ascii?Q?6kjJRU3WJrobgqTiX9nBdEOmF3BUgmchIxYH?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(7416014)(82310400026)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:33:47.3257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b3a09-f07f-434a-1ec8-08dde98616d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5665

Hi Dave,

> > Explicitly initialize the SCTLR2_ELx register before launching
> > a new kernel via kexec() to avoid leaving SCTLR2_ELx with an
> > arbitrary value when the new kernel runs.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/kernel/cpu-reset.S      | 4 ++++
> >  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 3 +++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> > index c87445dde674..c8888891dc8d 100644
> > --- a/arch/arm64/kernel/cpu-reset.S
> > +++ b/arch/arm64/kernel/cpu-reset.S
> > @@ -37,6 +37,10 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
> >  	 * regime if HCR_EL2.E2H == 1
> >  	 */
> >  	msr	sctlr_el1, x12
> > +
> > +	mov_q	x12, INIT_SCTLR2_EL1
> > +	set_sctlr2_elx	1, x12, x8
> > +
>
> Nit: does it matter whether we reset SCTLR2 before SCTLR?
>
> I can't find a convincing architectural reason why they need to be
> reset in a particular order, but it looks a bit strange that the
> cpu_soft_restart and __kvm_handle_stub_hvc versions of this reset the
> registers in the opposite order...

TBH, I couldn't find the reason why SCTLR2_ELx should be initilized
before SCTLR_EL1. I don't think current bits on SCTLR2_ELx doesn't have
any effects from SCTLR_EL1 (MMU bit and etc) and vice versa.

But as other code, as you mention, it would be better to reorder this
initialization.

Thanks!

[...]

--
Sincerely,
Yeoreum Yun

