Return-Path: <linux-pm+bounces-22319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7703A3A422
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33FF1885AAB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF48270EB6;
	Tue, 18 Feb 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DByFFIAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0F26FDBF;
	Tue, 18 Feb 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899411; cv=fail; b=TXMGmlXlmyczEVHBVdrl3X0MyyTyx9i4HQk7xpecfGWxARoL3f83Qmurd3pLYkAUq29a7bZjGdLH8AafXhHGq5fnOcfUbYNDd1fgAahu4cKRoqSnBX8HoMI9ZkDBM6tw3t0Zh3/3uje9SWxZx0P8gqCUkJkdOi5jYCUE+hBW8WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899411; c=relaxed/simple;
	bh=cQURtdrQ+a5vVkNLTE4yHgP4/4cHDSp+eoYzOg/ViKY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sIuIq7gXvYtLxd0+yvdD1uQIByEvQ9Gg/jgE3/SvONmUPxuWn0/tTaLQEoGAANUq7wMLaO3fxmvzEwu44BApwPJ8utMWH4GgWJWEZveQh9i581IUPwB6xW0eOF2hoYCSBT2BPk89wgW4l9nksz095s8zTXSq09GJFZIlvBrEN2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DByFFIAb; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7AkpzgsIijRbr8p0Wc2IN3p8MLCa9eLpGk/NRXHK1eY0QgwkelReOPJNWbuWLJ/y/8uUlRr8DPneiviwY8yU4bsaeV85YPwnZZfbwIp0PWZdB+5Kw8YBQzHUKYg3CoWM0duqois56HjC1N/iZ9rCnGQARYl+SWmXTHQBp3qH7N6IOkRSTRDsjkJ+/Q5X4A1UfeDmRmiqEmIMmTFugjxu9boAZdcx5EtGguZB+bS91WVEJJZn5ZaJquf8bKJd9L6ZwTH3pb2pTIKAagMBwdJ2CnR2/DbjaXDWqe2/uAk9B1TTf8THbF2LV7zQE4pniDYfCWsLEJ4i6laokXPsIXUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOtide0Ps+q1NaDroh3C9MPjIfzWv7OX3CClBHaJMxs=;
 b=jGYa+hamE6GkfxBiT5688euM6RNy7kzE+Lra4W+wkDMjI7LjH9REqWJFWkQQ6abB8mVi40oFyiIMNmeAPriLPYHw6t2d8ZC65YJeMSSza1rLAgN2EWgxgPkLx/L0jssriuM/m9nLs8sMsHTZjatflbeXyJVcXLA2/0LD933SNIgomtMHtSsXhlxftHgn6IMWjl1k179TuxaMvLGw7Yl52QZtWfUnzZv1ViFPVgjiaY4rI1mekUM3Mn59m9rHKTkywpWIHiKiot+FBfRja2UnQfinM9jqVazKF1mhMymN+ZLkeo9l5fpbyVde8KJ1L74QpKiQD7KAsL9kMWawSfrW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOtide0Ps+q1NaDroh3C9MPjIfzWv7OX3CClBHaJMxs=;
 b=DByFFIAbAQbxVI2Df+Nk7vEM6e6Gu1h5W0c8+gHxkyHda8ttqk2rMJsKCwYsOtK0vTPcKyrk6B3679Cxz2xsDVJOhXy0/9PUHi6eV4b4IDqUck/6iqwjRv/OXRelAcGns0LWEsAkkCIx7zwIyX1zMOstoTvbM+H9D901Mq2Zv594z2JJ3IlMWKqFRPRzhZBkrjslNh/xShRc7x9vKl2gmOksPuRKul8ufnWRr7W4c7EgLbzg/Iq8DbXvCKS+hrWVlnTLwh5IqPme6fgL2QflLYBcxfSO2uP1e/5f2SiJpxrPT++SMU4vqu47Fhsl7xhQEO3fdL0YGswjyTE39HhuBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10596.eurprd04.prod.outlook.com (2603:10a6:800:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:23:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:23:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Feb 2025 12:22:59 -0500
Subject: [PATCH v5 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-imx91tmu-v5-2-76c0b27673e6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739899390; l=15746;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pys/IYtfZzO9IFH5Il9VZ976JE408gQb72DpcqHA+4E=;
 b=Ty9LZjJZehqwLVL6gm54GokifIk4YptqFNKZb+BrMVQ3VoteEjfqu/AHmQn9c+jiFn+Qs1WjE
 3VXVQPSiHmODKK/Inm60z+tqcNiCPe2MUFR9i22lxM5gyhKr9p+Tp8w
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
X-MS-Office365-Filtering-Correlation-Id: 35d527c6-e53c-4d63-eb99-08dd5040f446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNoV1NpZzhmMGFndUhCdkkweDA3QW1ONG5rNzJ2UmMyWFUwa2NuVTJWZlp6?=
 =?utf-8?B?NW1pcGFyL3hPSjM5d254SmFQRDJYRURoeC9VVmhCQUZNam56Z0JGaEM4dmhS?=
 =?utf-8?B?d0NjV2lJVnpGaHhZRHlyVElzMDRpMnFURWozN3JLMUNheWROY3Q3OEJXT1hv?=
 =?utf-8?B?c2E3Wm0wRnlJS1pVWC9CMHR1cVVBVmNvMlhVcndqRCtXSHk3cW1xUmFsMElK?=
 =?utf-8?B?TmtPaElJczY1NUYydVExUVBsV1dmVEVLcUFvQTlveWZUSFJEMEV6K0JXeXZ0?=
 =?utf-8?B?UkJDeXgvN1BpNkFVeEpKeVJxeWx5d0dsMVpCSzYzUUVJZXo3L0RiWGRhRThO?=
 =?utf-8?B?dmJjN0FMaUFsRGI5SE5zb2wra2VKSmd1UHk3MXRxU09vNERhT3Q2MUUvcnVq?=
 =?utf-8?B?SnBaT0VleDF1cVQrSkZyWmxkZ20raHpJYmg3clpweTluQkQzaTIwbTU0eFAx?=
 =?utf-8?B?WEh6d3VnQkZDNFQ2WndJY0JtN08vSm9nNng1TmxaS2FDWGh2clZWTG4zcEFP?=
 =?utf-8?B?WlBsak13bUk4U2lBS3ViTS9zWUJicUplVm5qK2Q3M3B4enRZMU4xbU1GbVR2?=
 =?utf-8?B?NXNtdWRmYXlnbFZ4OUVxejZVTkxZOW5XNTNuMlhsSkpoS2cxNlFTWGowN3pr?=
 =?utf-8?B?aXdVeTNqMDFzV09pakhvYi84aW5pdUtwNFVWMFNrS0RlYkdZZndzZTU1SkdE?=
 =?utf-8?B?Y0pHS2RCR2hTTFZ5NStyT1RYUDhGZXo3TUhZRnZvSm9Dd1kzcUtBbk5QSTBS?=
 =?utf-8?B?cVZiRGlvNjlvWmRXN2F6NlJ5V2VJOEdSRWFxVWtqUHd5Rlh0K005NTB5WUc5?=
 =?utf-8?B?N0h2U0tTRTNQT2s1OXBYVGJLdm8vdkJxMGE5Mlp4MjRjUWcwSHZNc1UrZkNI?=
 =?utf-8?B?M1FGSUxPZGVZdnMxcFJoQ0dxNlZFNWJIOHpQdFNrYkNXSWM4M09BWHRzVCs1?=
 =?utf-8?B?cWlzMjBWb0NCYnNucy9GenpkRi80WEVjOWo1Sy9yL2pxZTNXRFUwRWZSc01w?=
 =?utf-8?B?bDVQQURaU0JzWmF6VVpSOFpUOGtZM2o4V1d2OG1sVVBsOXhBN2dseXVKVXJY?=
 =?utf-8?B?bUtHWlpEdGZmRUlzQ3pLeDhqT3BWVmNlc0hNUGgyUVpNRlJqemRob0dlY3o1?=
 =?utf-8?B?MUVjdlRGUDhid0FGdHh0YU9tOHE5RnRzVzI3VVlDRFpnQmEvRWRWNzY5R2Rw?=
 =?utf-8?B?ZlNWVWJ1MzQ5b2xrcWl0bmQ0OG9LVnlLQ0JPRks3RWlhM3ZGTDJmZWl6a0VX?=
 =?utf-8?B?d3ZmcHZWa2w1czdtWnhEVDRKTnpUY2tWVDVoTXZFR1dvcDlsNU04a0p5NlpH?=
 =?utf-8?B?eHkxNTBoY3RDVFFjQW1sdDJUbU9QU3A3N1lHemp5bmhJclBmRVBMSlNBT25h?=
 =?utf-8?B?V1FHU1ZncGN4WnRwVVlJYUUwdnUxUGVwbWx0VW1Mcm1VV3BjVlhEUGRoRFlT?=
 =?utf-8?B?Vk80VmhkQ3NMdlppVmcxOXJCQTZmNmtwSUIwbkJpcUNZZWhyUGVBMzV0ZjNH?=
 =?utf-8?B?NkpUVjNLS2xjc2c5a28vaGVzZE5qK21BNmJ3UWFaUlBhNnlJKzhpc3drdmNi?=
 =?utf-8?B?cFRFd1YyV2V1VVhtU2tNVmZsaS9xTHpha2s2elpRczZXclRremlNS2l4QXdq?=
 =?utf-8?B?Tlo5RmlTbVBwRGJlbC9BaVpzejcveURKUVZkcTlzb3Z1c3FTS0w2cHdoRllv?=
 =?utf-8?B?b3ZqNkNsTWdwRGFQTWh3aklUaWovSHJCdU92TDhGV3FwVzJySHhGRGN4SVg4?=
 =?utf-8?B?OEhJUloybXlxdGg4VGFIS2hSMWluWXYrVTdXYXZoZjJlZHdmMjl1OXQvd1o2?=
 =?utf-8?B?TFZTS1c0c0xvWUlZOFNSOWxnN0pBRUp5TExXaGdCMzJOWkxHTnVnU1dpVjhX?=
 =?utf-8?B?YnVnQkNnMzI2MjlXRGZvOWRwazNrekR0cUxXTnB1WlBiS3U3UHgrSXNEYnJQ?=
 =?utf-8?B?aWR4enVKYmtYQisrY1dXTE9KdXJONzhiWWNtdFh3TjAvSy9vZHVUUnRlMXFw?=
 =?utf-8?B?b1k0NUdkZ0VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHg1dTE0Z1k0R1hsVGpxVTJsU2R2d0Q0eW1Ra3IvcXZKZ0RBNXVxVUN3bTg2?=
 =?utf-8?B?R3VSaGZmb0xla0loV0xhRTNtSHJPRTg0aUVhWklzNm9vdnRTR1VyTXFmYzRx?=
 =?utf-8?B?dlRUN0dRNEVaYWE1eEsyM2xQek5FU005OWZ1RXcrVEV3TzVRQ3drYmJIc3F4?=
 =?utf-8?B?SldNdFpXWm1hRkJjK2JVSm5TcWd5d0V3RTkzdUVFTWI5VzNXaUlnYzNCZE8r?=
 =?utf-8?B?MGgrckJ3ejlESzhaNVpGOWcrcUJ4N2xpRDB1cFFGclNLRE1vTVZyT0REZGxE?=
 =?utf-8?B?L1lwL0xHZFM2ZlhrM2dsTDNtOHdGNzRwRzJza0NtY0grZkF4WHIwU2JaaXla?=
 =?utf-8?B?VG9KcGVSWFN3aWRQWUdpREF2dkZNWkFWWER3b09sQVErUG51RWJ0dTdkZllH?=
 =?utf-8?B?aEoweWZMNlliV0FZSnE2aytKRHlyc3kvSnNWZmp3bDhYMFVxaGYwS3hyd2tW?=
 =?utf-8?B?RlViNkE4TVNnSmpHTW9SbDRzWS9wRjZweTZIdnRIaTBCM1hCNHpkbkdJTTdD?=
 =?utf-8?B?ZCtza1lmdXZad1hSeGpWZ1JlaGtQa2xIM0hPR0Nhb2JJNTEvUk9DZkovdCsx?=
 =?utf-8?B?K2MwcGhSaDJOM1BYNU9TUFFmWGtSZC9BZUdLN1RlT3dpR3NuVHlMMUdPSDRU?=
 =?utf-8?B?RXdNdSt4YmRXb05CVnplQldhWFd2bVdKUDZNbStkTEdPVm41QnU5VXJjdS8v?=
 =?utf-8?B?Mk1tVkZ5Mm1FTGJLUWwyOWFrREFzQnZLUU52RjZQblB3bWV6WGY5Z0xSVUUw?=
 =?utf-8?B?Uld0bXI5d3pOclFxcUttSVk5aFk4T1Vnc3VXeFpvZklyUEZObFZsa3pocVR0?=
 =?utf-8?B?Wm84d3lUVkU3bGk2aXJqU29Ja1JlM3VRM1dkbnpDZ3B5QXdoYzhTWDhCb2VC?=
 =?utf-8?B?b2FCNnhLODh4UjltL00wd2lXblNYWkRFV3BnNys4ei80ZjA5SE1xZ1o0alZR?=
 =?utf-8?B?UitWVDkvN2FUc2llWEorRU13ZG5wWXltZ3IxN1dpaUVpVGtpNEdLRVg5MFFq?=
 =?utf-8?B?dGl2bEc3WjZjQ3JLQlFJcFE4SjBVZTlDTjRsRVhxZlRHc1pzb2IwdXJmL3Rj?=
 =?utf-8?B?eWJMVnlKUWdtRi8vU0FOTmNaT2Ezcjc3Q2FuVC9YOTl4T0tXd0huSUs2ZXdZ?=
 =?utf-8?B?QXRjaHNIRXhDUm5uUVdaWE9CVytFSzQxRG9FamhxSy8xSlppeGYvd3l0YnlH?=
 =?utf-8?B?MlpBOU1yOTZjRVhqRWJJVzBHK2FOcDdzWmt0bEdGeVFWclJaeUFBeDVEL3pk?=
 =?utf-8?B?R3FQckNtQW0wd3N4cEk4OWZTUmVkNmZYTUdjWVRISWFrZ2Z1Nlp2RlpyWnhL?=
 =?utf-8?B?MlorVlFWNVZLeVUwbWMzeUVIUXE4ZGFhNmMxTHkvdzlJUkNLVlQ3VFd2VW1J?=
 =?utf-8?B?Y1QvOUJWQmxIcnE2bzF1QnZYSHNlM2MrdlVXVU9oTUNVQzVoKyt2V3pKVy94?=
 =?utf-8?B?ZGRFY2dmYVJMeDFnMVRvdmo0QVlvTU5hQ1ZzNkhIRUVodEYwaE43T0VsVmV4?=
 =?utf-8?B?T3FURDBpRmlIeUJJQ0UxSEFvd3VZWFN6YzAzZ3c5Y1pGR1hpOUlCSWtOWGdm?=
 =?utf-8?B?Ky9rc1FtSE4rbGY1dlhNRkUyTno2ZC9xWWRQSmxhVnc3OVNOUFdKSndaZVlJ?=
 =?utf-8?B?b3dTWG9RRTZQYVVOT1ZpemsvbnNEYUdmZ1lPa0JBMU16NldFTytzWk1IbjR5?=
 =?utf-8?B?bGQxMWJtelNxUGh3Sy9WNC93VWdoeU1rMjNMWXB0U2dPTW8rdS9zK0VpVTI3?=
 =?utf-8?B?TkNDZ3M5Yk1qZUUyLy9MWWR2cU5zS1lKS0pZaUxldEFXL2FlUGhhZEpRdk9i?=
 =?utf-8?B?THlNUFRqVlFJOC85eDk3K0h2WTBqRUo3eUVSTmtDNWxndzBPR2I2SmpzSWlw?=
 =?utf-8?B?MmhQcjJTcGQrUTBXK1doSnJsRFdZT1N3aGdpOE9YMHZGQ0RTSjJUVmhQNUpJ?=
 =?utf-8?B?ZFVjSll1SEJBRzN1RHhVczRmZmZsR2JiVFpMZmEwZFQyb1EvdzE5T3o1TUhB?=
 =?utf-8?B?Tk54cmltUGswRzd0a3ZFZkZ1TkE2bzNOWlg2ZmUrVGEwc3JIalplczVUR3RK?=
 =?utf-8?B?ay9BNVMwNlpZaDkwSW1Kc3N4K0FkNlV5bFB0NWRmU1lERjhVT3RqYngrNmlr?=
 =?utf-8?Q?LfzpUrfg0jI9/Q0U1vpBCnlNU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d527c6-e53c-4d63-eb99-08dd5040f446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:23:26.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyTGKvKB7aGHcioNjeqlvDn1vZybYfY8H+iSFK/16cHvwoFd2BDxhtF0r/JTP1JyanUNu5ZuSlRlZO82LwIdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10596

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
accuracy, refer to the datasheet, as it varies depending on the chip grade.
Provide an interrupt for end of measurement and threshold violation and
Contain temperature threshold comparators, in normal and secure address
space, with direction and threshold programmability.

Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- add irq support
- use period mode
- Marco, if need drop review tag, let me know

Change from v3 to v4
- Add Macro's review tag
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()

change from v2 to v3
- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
uboot may change and enable tmu.

change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 +
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 422 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..78a05d1030882 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Include one sensor and six comparators. Each of them compares the
+	  temperature value (from the sensor) against the programmable
+	  threshold values. The direction of the comparison is configurable
+	  (greater / lesser than).
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2bb..08da241e6a598 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000..da2e01aa6f281
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#define REG_SET					0x4
+#define REG_CLR					0x8
+#define REG_TOG					0xc
+
+#define IMX91_TMU_CTRL0				0x0
+#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
+#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
+#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
+
+#define IMX91_TMU_THR_MODE_LE			0
+#define IMX91_TMU_THR_MODE_GE			1
+
+#define IMX91_TMU_STAT0				0x10
+#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
+#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
+#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+
+#define IMX91_TMU_DATA0				0x20
+
+#define IMX91_TMU_CTRL1				0x200
+#define IMX91_TMU_CTRL1_EN			BIT(31)
+#define IMX91_TMU_CTRL1_START			BIT(30)
+#define IMX91_TMU_CTRL1_STOP			BIT(29)
+#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
+#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
+#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+
+#define IMX91_TMU_THR_CTRL01			0x30
+#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
+
+#define IMX91_TMU_REF_DIV			0x280
+#define IMX91_TMU_DIV_EN			BIT(31)
+#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
+#define IMX91_TMU_DIV_MAX			255
+
+#define IMX91_TMU_PUD_ST_CTRL			0x2b0
+#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
+
+#define IMX91_TMU_TRIM1				0x2e0
+#define IMX91_TMU_TRIM2				0x2f0
+
+#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
+#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
+
+#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
+#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
+
+#define IMX91_TMU_PERIOD_CTRL			0x270
+#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
+
+#define IMX91_TMP_FRAC				64
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+	struct mutex lock; /* sync with irq thread */
+	int trip;
+	int hysteresis;
+	bool enable;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = IMX91_TMU_CTRL1;
+
+	reg += enable ? REG_SET : REG_CLR;
+
+	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_to_mcelsius(int x)
+{
+	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
+}
+
+static int imx91_tmu_from_mcelsius(int x)
+{
+	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&tmu->lock);
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
+	*temp = imx91_tmu_to_mcelsius(data);
+	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
+		ret = -EAGAIN;
+
+	if (*temp <= tmu->trip - tmu->hysteresis && tmu->enable) {
+		writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+	}
+
+	pm_runtime_put(tmu->dev);
+
+	return ret;
+}
+
+static int imx91_tmu_set_trip_temp(struct thermal_zone_device *tz, const struct thermal_trip *trip,
+				   int temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	if (temp < 0)
+		return -EINVAL;
+
+	guard(mutex)(&tmu->lock);
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	/* Comparator1 for temperature threshold */
+	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
+	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(temp));
+	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+
+	tmu->trip = temp;
+	tmu->hysteresis = trip->hysteresis;
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+	pm_runtime_put(tmu->dev);
+
+	return 0;
+}
+
+static int imx91_tmu_trip_walk_cb(struct thermal_trip *trip, void *arg)
+{
+	struct imx91_tmu *tmu = arg;
+
+	return imx91_tmu_set_trip_temp(tmu->tzd, trip, trip->temperature);
+}
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
+	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
+
+	return 0;
+}
+
+static void imx91_tmu_action_remove(void *data)
+{
+	struct imx91_tmu *tmu = data;
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+}
+
+static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *dev)
+{
+	struct imx91_tmu *tmu = dev;
+	int val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	scoped_guard(mutex, &tmu->lock) {
+		val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
+		/* Have to use CLR register to clean up w1c bits */
+		writel_relaxed(val, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+	}
+
+	pm_runtime_put(tmu->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int ret;
+
+	if (mode == THERMAL_DEVICE_ENABLED) {
+		ret = pm_runtime_get(tmu->dev);
+		if (ret < 0)
+			return ret;
+
+		guard(mutex)(&tmu->lock);
+		imx91_tmu_start(tmu, true);
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+		tmu->enable = true;
+	} else {
+		guard(mutex)(&tmu->lock);
+
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+		imx91_tmu_start(tmu, false);
+		pm_runtime_put(tmu->dev);
+		tmu->enable = false;
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+	.change_mode = imx91_tmu_change_mode,
+	.set_trip_temp = imx91_tmu_set_trip_temp,
+};
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	int irq, ret;
+	u32 div;
+
+	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	devm_mutex_init(dev, &tmu->lock);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / (4 * HZ_PER_MHZ)) - 1;
+	if (div > IMX91_TMU_DIV_MAX)
+		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
+
+	/* Set divider value and enable divider */
+	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
+		       tmu->base + IMX91_TMU_REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK,
+				  IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	/*
+	 * Set Periodic Measurement Frequency to 25Hz:
+	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PERIOD_CTRL_MEAS_MASK, 4 * HZ_PER_MHZ / 25),
+		       tmu->base + IMX91_TMU_PERIOD_CTRL);
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE | IMX91_TMU_CTRL0_THR1_MASK,
+		       tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL0_THR1_MASK, IMX91_TMU_THR_MODE_GE),
+		       tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+
+	pm_runtime_set_active(dev);
+	devm_pm_runtime_enable(dev);
+	pm_runtime_suspend(dev);
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	thermal_zone_for_each_trip(tmu->tzd, imx91_tmu_trip_walk_cb, tmu);
+
+	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, imx91_tmu_alarm_irq_thread,
+					IRQF_ONESHOT, "imx91_thermal", tmu);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
+				 imx91_tmu_runtime_resume, NULL);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "imx91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


