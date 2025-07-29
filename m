Return-Path: <linux-pm+bounces-31547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF0B149FD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FED7A7507
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34F27817F;
	Tue, 29 Jul 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JbOK/e6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898D2AF1C;
	Tue, 29 Jul 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777269; cv=fail; b=kAL6Zbg7r9kcI9IquaSzyR9+c+DWc2S7m2XkjHsIfM72iCwXB5DsS6AA+Apb9jnk24HeM/kMJFPnJUPp+EePNho/daMyMf9CRTWP2qho7x/KAhJJKTsTZ4ODb3RXygOe6CtkUqn7OAEao3RqBQSTZCAfhv4z56Fbrf45euOZm6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777269; c=relaxed/simple;
	bh=jw4dbIDpA8ULO5tlh5tm456WY395d2vrCj/CuLQjl58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IdnUy38405nF/L4nNnrxKvEPwcCY0trPkx3uq3cfpR1hQSQ/vDLKoEJmIDe/rzziW3vCAUBvq5YDO12U9sP2vQRHOrQd1HBgDY2mNd56NoAdU+eIEYrXyOddQ39Rmwmo3ehUwm4kvTs2RCwr0UOn07Ut7FI+NWAQqEJomqx33wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JbOK/e6I; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWXlKU+00xgSrqn3/gw7oHJLymHPu0SK5Fy7hVcGjGdyOrAaXCifoX+q1sF9Ie7AJN6qguHubq6oU8OcmDkLUzmF8QZ38PQaH2rHwMhi40WiZehnhhCWD8OBcQGBb13GDwgBBC4EFYewcy7oXnIuV6v0hN3FnD4pjGQeoAckTpEni7IFtmY88QMqH4DdWBUDuRDJPzNTT1XCiRKCYhR9I/bWSudS96ie/dYfWt4WkInZgz8BiZeswQWXd2ut9RiPqagwdw7feu//N3mhIxjqB2LvfQL+ezsbSyHoJ41bwwBUsobhz1XOsa0lNRXOt3xImqV46s9w0czZdIgPIE2ymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw4dbIDpA8ULO5tlh5tm456WY395d2vrCj/CuLQjl58=;
 b=cFMBqOmeh899yDwdOpopbm8H/ydwLJ7DW9D9rPCfXCv01RdMLHA4sCGzSGIaGPsZDIPMtlvFbtZRbmLTVucqZOMunVIp9WnwTOylAgTq74volnaJVsd2O7NWmDVhaYMTNaKWS1AOfUBgGcyAWebrCXeZOKlcZOQUYYHaiA7SafqwDXbXuWc883/m0DK1n7mcBI0wT9q/1Pi+cz8/UNMBKnZlCWuHNM6Vr/I/alFoMDVZRGgNO+QIX8MMZAUfOvjLbBvOJskYFp//AEIvW2wnysCHVoJS98J6DzH0zc+Xh2uNtgA4H11RNK1J7tmyMPMoD/u0lb9+PjNLCVIuaTDg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw4dbIDpA8ULO5tlh5tm456WY395d2vrCj/CuLQjl58=;
 b=JbOK/e6IrDWMh+EwSOtN0wZH9S1Cr8xSwpODt8ZImtvnBJngdges6HD2IyT8P/468m1gC/FAOSyNvouwqvUYhuW1zSJakZfMd4bTnvrrqVtY1oInZsp3muvV2n/7Rf7j9C4ESruIdmKEq4Uasc7i7pn6LH/F3ZQoI4O52nMdOAVAEmsv06YBX4LmEa/NPSQqIYIumomxtFbJmZa2ehbaK1K2L9qzGS7ywLF0oHUE9qOnG1CDTc17gsagBfMHoOiV8kiOlefa+XnudEKx7b3AmHy3Tr5t5x1oCOXUGi9I3c1EkInPtNgiY2ZnLQJGbcKoih4PDjt3gaw7QaVY0Ngw/w==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 08:21:04 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 08:21:04 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Topic: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Index: AQHcADHIj7Ah5US3Lk2vWufsX1crirRIp5KAgAACpNCAABUrAIAAAUXw
Date: Tue, 29 Jul 2025 08:21:04 +0000
Message-ID:
 <AS8PR04MB8642EF2E53D1229D639F55AF8725A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250729024039.1223771-1-ping.bai@nxp.com>
 <20250729024039.1223771-2-ping.bai@nxp.com>
 <21ce4f23-8aec-486f-8fbb-021c1e114908@kernel.org>
 <AS8PR04MB8642DDDAF4E9CA5E98F94E9B8725A@AS8PR04MB8642.eurprd04.prod.outlook.com>
 <db07bf8a-67ba-40fe-ad38-a76ad551dbf7@kernel.org>
In-Reply-To: <db07bf8a-67ba-40fe-ad38-a76ad551dbf7@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AM9PR04MB8397:EE_
x-ms-office365-filtering-correlation-id: ebb8e27d-2e7b-4b14-a18d-08ddce78dc7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3FsbTJacVpEVkRRTVhJMGhiSU4zUy9OWWRWcC9KT3E4V2FFZGRXNUtsMEd1?=
 =?utf-8?B?UFRXZCsybW00Wk82ZFRVSFAwRExOL2NyUFAvNW9PUmU2WWdhZ2lINmtEemE4?=
 =?utf-8?B?eDRadHlOL2ZSUGtvOGlCRXVVRFZrZGJaK0VWN1lUSktCNlgvUGpJMmxjUmV3?=
 =?utf-8?B?SFlUYTJwSHpaSUhrZjVYd2ZQR3ZsU3pQcVM1V09lb0pyUTdlbFkvY0R3L2Q4?=
 =?utf-8?B?L0xvRVY5K3l6SkhSdlRidWttRmtWUEpTcWdqUndNOWJPelgzbVpIOWxtS1Av?=
 =?utf-8?B?Z1BIQUhNUnc5VUZ3cDk4RnZEWitoSFAzQnFhWDExYmkraC9sWFpLRXlLVlpU?=
 =?utf-8?B?UjRabGNHaVAzWlUvNEtrRkdsWmN4ZHV1ZG5PUjJnTVNBSWttTmdRMjBaRG55?=
 =?utf-8?B?dHRWc3NqUnU2eXIxV3llSERjeXhGUFlHd21Xa3lNcndGRUJ2VkxyMm1ISm5u?=
 =?utf-8?B?MExLQlMwbUU4dnhDWi80S2lUeVNlM3ArSkJrN2VaekFtNEQ4OXVhSVZpMC8z?=
 =?utf-8?B?Z1d2QlZYVkM3U2owS2JKR1BoQVVhVmFVWVVSMXNKMGRCZXZTUzBmOEZlOGho?=
 =?utf-8?B?eVdvVGJrcllJU2pzcXV1L0tvQkJvSjNMUXhOTVBKVVcrWVNqM1JFKzhnQ1Zy?=
 =?utf-8?B?bmFRWTEyY3hXUTVHOGJROHVsSzl5OTZRbGFYS0dubEw4WUowU2N0d3o5YXVO?=
 =?utf-8?B?VnMreUJoK09EbUpNQlJyZG1tNWNWT3hIL2Q4NUNBYlVTM0NUM1hIZ3VoOWZN?=
 =?utf-8?B?dUNveURYSHlzTUs0Mm93N1g3Tkl2ZVJWWG9wV0NoZ3FKYVlnd044Wnp2R3Rv?=
 =?utf-8?B?QzZmaU96WkFoSFRON29EaUtGeTlURzFaTldENDNBS0RUMklSRE1PZjV2WkpO?=
 =?utf-8?B?OVBzcXQvdldUWkJ4VDhMYlh1R2tXUGthTU1iYmpRR25FQlcxb2hMeUtPVXlp?=
 =?utf-8?B?M25QSUY2VVFUUk1vOW14THRoQlNsY0V6b1YybmhTclRwOXJqSmhYakNYQ0Yy?=
 =?utf-8?B?NGVFb25Ib1V1K2dKanpaNmRXSWhubU5XYlZROVZmaDhTdkJQdHdmTHpPMEVu?=
 =?utf-8?B?blJudXVjL2R3cDJyN1R6WGtmUmwvdE1JNzV3eUswc1pNblR5dEU2OCtKVnN1?=
 =?utf-8?B?Sk5zQXZ3UTJYWlRGQjYvQmh2dzV3SzJyc08wZUVNSndjcDBEQXpwcVhFeitM?=
 =?utf-8?B?RHpRajRuMHdHSnBNWlVPakJ5Q0lNYUhBY2oyQnN4OUtxbDRWdHE5dXk2VjZV?=
 =?utf-8?B?a284NFhkVFZuUHppVVpxRlRsejh4cFgydXBZWVRGaWc0RkFEYVhMU1NYKy9O?=
 =?utf-8?B?cGZ1MnR5c1JvRkZFQ0xNbkNOYkltV0wyL01pazhMWDN3NmxKcVQ5Um5iUmZt?=
 =?utf-8?B?bWpPQkozbmtuQTlDVWVlRWJlbjdQOElFbjFxTTBROVA0bm5CeUtzbVRHYTA1?=
 =?utf-8?B?Z3V6T3VFZEdHaGVxRWx3S01xTXFpKzBYUjZmaFoxSjV3OHRvVjFOQ1oyQlpO?=
 =?utf-8?B?bnNjM3VNUEVBR1QrSUhJSFJzMVhSVjFTV0lVakM2TVpQUGlaRmNaMFJVZnE2?=
 =?utf-8?B?bEU3RXZuNHZBN1pMa3dpZXF6eHhzMXBobjFpTWVjbVRuRFhCTFpud1pCVUYz?=
 =?utf-8?B?YWV4cnlTcTdic2YwTk1CelQxK01QUmVyTk8yWldWSW0xVFZRcTJGOGlkck9H?=
 =?utf-8?B?WCsvTnRFTWFjTXllVzdha05xa2gvOVUwb1NOb1FUNlpYYlFpNkltaXE0QllE?=
 =?utf-8?B?K3BpTmF2T0hTalhGNGUyWFRYdUZwL1JBeFhtL0lhTnNoaW8zd044OG1tOWY5?=
 =?utf-8?B?djJzYnRTTVZocmJLNEVucEM0S3dSZHNTZloweEVPVHNLZEVyK3E2dWE2d2dP?=
 =?utf-8?B?c0JXK0d6eXROc0pBdy8wRDVMa05hSXFhcmxrV3VJeGo0V0xMWSt0czZPZmRk?=
 =?utf-8?B?bHBzbDB1OWREcUtOVzZFKzVOd0t2b3VuMHVKa1RnTHoyV2tSTlArZElqZE93?=
 =?utf-8?B?WTRGS1h5eU5RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L29HNGZjNWNKbXVtcm8rV0Vtc24yUm0yMHlKUlltZjdsbmRqZDR1S044d2RD?=
 =?utf-8?B?QXRaZmdLd1lnM0VMY3FPRDR4WGJYT2x3RlRWckEweTBIUzA4Wm9KUlV5UytL?=
 =?utf-8?B?bjZWTndWWEFSTTFyTEVLUEhRN25kWXFHcVBBalFHSkRGZmNkbkl1UEdLRVAz?=
 =?utf-8?B?OTlWUmJoYXpPdGRnNDc2VWE5T1l5Mm1wenVoTHBuTDhjaFRYcXlhTHVidDNQ?=
 =?utf-8?B?dUx4MUk3Qkx0L3QvY3dSdjlnSXNDUGtDM0c4cDJVeWJRaWxURGp0ZzlZZEUz?=
 =?utf-8?B?VkI3UHRVZGthdGsrVmlGOGVsWUR2L2hWSFVLdXhuKzdBM0s3TVdiV1BtczNJ?=
 =?utf-8?B?M054c0d3YTRxRFA2YzdOVXNZTW11bHR5Vm5tY2NuZkM1WXNoZUhoczhxTWJK?=
 =?utf-8?B?MHVIMFpMRE5VUjdRaGJTZGk1M3VMdzQzSmVOQkJjZUhUdHhFalA0NStlVVJM?=
 =?utf-8?B?c3ZmMjVUTEZQT2VzZG5NSkdCZmVKTUIzaWExdTg4ckJ1TGlUNks0YmJoNHIv?=
 =?utf-8?B?OEZZbVlPRWg2VkpvaUx0QVlvcTdaUHFzV2ovd25pZHpOTkUvN0p5MUM1eWlr?=
 =?utf-8?B?ZjZVQ085bjJMUWV2SjVWcWdKT21malI4SU5LZVlaVjJGNWhQNDZRcWRzdk02?=
 =?utf-8?B?VFl2V0ZiUWRXeHhka3FaeEszUmlOR0UyTDRHTVVSL0hvbGJqQW9aWEkrWmFX?=
 =?utf-8?B?SStqZ2F5TTdJMzY1M0IzUFo4VVdtbXh5VGdjL1F6RjFybDZPM3R6MlF2M1lY?=
 =?utf-8?B?dHVmMUxvM043RkgyNGZlN0dUTW56S1BjcnhLall3RW9vWFBENTJqZk5uL0ZS?=
 =?utf-8?B?WkpncmpoVklja3ZQSGdKMGp5VVJkZWVQV1N2YVdKbkp1MWlnbEdLUEdlM0NO?=
 =?utf-8?B?c2FaZmhIQmNTNmN6OEgzbTNTdit1YzZOZ3RCT1VRNTZIQmExdmZvcFBtSWw1?=
 =?utf-8?B?WklhbEtMU3BaN3V4R3Y1OGtkdTVJaFJpMi9YNm9FN2hnSWw1ZTBCcmw3NHVu?=
 =?utf-8?B?TkVkY1M5cUVLRnlOTEc1c0ZoMHppMDlDdlgxSFdFSEhXOTdGUjV0YTJKMzBT?=
 =?utf-8?B?M2ZiQnN3VGlnS2MwNzNDVnN3SjBwRlFnRWcyTmtUQWxFN3REdk1Ka0Z4bXVn?=
 =?utf-8?B?ZURoOFBxVXR6cTcwNnpaWVJuWCsvZnNyMlo1RjdYUUI2M3lGN1VPNXZ2Y2N3?=
 =?utf-8?B?Q1FySk5UVHFIcldRUUpPRWo1dWtCQWU1Q2J4MHQzdGVTWmhQK0tXdm0rTVU2?=
 =?utf-8?B?Nk9saE1rbU05aTE1QzdLSGNEbWU2dTNJbkdHNHFKTFU3NkJLc25qYmsvcGZC?=
 =?utf-8?B?Q2tycWNZUEQrckxkRUxZaVRHdGpielM5R0prbjdsYU5KSTg2bDFXdnVyVi83?=
 =?utf-8?B?RmUyMTNwSGlBWU85bU5rWUZ0QmdPZlFqckxXY0JIYlNpYmc5YkU0YUxDQjRh?=
 =?utf-8?B?cGFRc2lkbTcxamYrYXZnWnVjaGFKeVRTTUFKQnVvbDlZcWdYRjNmSUNUNFJT?=
 =?utf-8?B?NFFlOUZVWU5KUURtZ2lZNC80bW1IVzkvbG5JTUl2VWtaV1UvWG5UNDg0c25l?=
 =?utf-8?B?b2JTTnM1VGI2Z0tWenJoVWJCSmlWYzZCVEhzWk5hUGg0YTMzdkphMk1naTlQ?=
 =?utf-8?B?dnZDbmJQcjFmQ29jYVNoN1hJZjNjYSsxWmwzWWdmVHROeTlrRFJLV2ZtdUhv?=
 =?utf-8?B?aGMyc2M0VzNiZWN0eEtVZUVyZ09BWTE4QU5wbU9KQnRGL3ZZMXNraGhBdGxh?=
 =?utf-8?B?a2ZjR0NkdDdTWFRjOUdzOURMcDRyK2ZFOWp1WjJtY3BEeElna3phdzNDRTlv?=
 =?utf-8?B?YU40OU1DdGhPdDlNWjRoZEJESS9kSnBLc1ZyM1NQNGlOZzN0NnFGZVE1YURG?=
 =?utf-8?B?aWo0WmVCMUM0UHc3RU55OXozQXFiU0tlZG1Tb3BHSTNwRFk0Q29qQzN1VUR4?=
 =?utf-8?B?RVhZUEprWVFHcTF1NlNBUG5vbFJ0c2V4blY2MDNPb2puS1d5WUQ4d0p3dkQ4?=
 =?utf-8?B?WjBTNXU3RVZjVzdnUEZ1TElBcGd2bllEUzYyNit3TTJFY2xzYjVlemdKM1Yw?=
 =?utf-8?B?MVdtd1g4UnFJZHFuZEN2Q2pocUdpSDFnRWQwR25VTVdqRlBMWWRlNGtqVmZL?=
 =?utf-8?Q?C/RU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb8e27d-2e7b-4b14-a18d-08ddce78dc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 08:21:04.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVIH29JZRJKZDYNWqUwTdAzMWYORV5WpjvX/7LotWoVbil9VT2J7VlPR3pHFnzWyUG6cmW73ayNufXdIcDmjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8397

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gdGhlcm1hbDogcW9yaXE6IGFkZCBpLk1YOTMgVE1V
IHN1cHBvcnQNCj4gDQo+IE9uIDI5LzA3LzIwMjUgMTA6MDIsIEphY2t5IEJhaSB3cm90ZToNCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIHRoZXJtYWw6IHFvcmlxOiBhZGQgaS5NWDkzIFRN
VSBzdXBwb3J0DQo+ID4+DQo+ID4gLi4uDQo+ID4NCj4gPj4+ICszMjUsOSBAQCBzdGF0aWMgaW50
IHFvcmlxX3RtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+Pj4NCj4g
Pj4+ICAJZGF0YS0+dmVyID0gKHZlciA+PiA4KSAmIDB4ZmY7DQo+ID4+Pg0KPiA+Pj4gKwlpZiAo
b2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImZzbCxpbXg5My10bXUiKSkNCj4g
Pj4+ICsJCWRhdGEtPnZlciA9IFRNVV9WRVI5MzsNCj4gPj4NCj4gPj4gTm8sIHlvdSBoYXZlIGRy
aXZlciBtYXRjaCBkYXRhIGZvciB0aGlzLg0KPiA+Pg0KPiA+DQo+ID4gTm8gY29tcGF0aWJsZSBz
cGVjaWZpYyBkYXRhIGluZm8gcHJvdmlkZWQgaW4gdGhlIGRyaXZlciwgd2lsbCB1c2UgdGhlDQo+
ID4gJ29mX2RldmljZV9pc19jb21wYXRpYmxlJyB0byByZWZpbmUgdGhlIGFib3ZlIGNoYW5nZXMu
DQo+IA0KPiBBZ2Fpbiwgbm8uIFRoaXMgZG9lcyBub3Qgc2NhbGUsIHVzZSBzdGFuZGFyZCBtZXRo
b2RzLg0KPiANCg0KdGh4LCBnb3QgaXQuIFdpbGwgcmVmaW5lIHRoaXMgdG8gdXNlIHRoZSBjb21w
YXRpYmxlIG1hdGNoIGRhdGEgc3RydWN0Lg0KDQpCUiANCg0KPiBOQUsNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo=

