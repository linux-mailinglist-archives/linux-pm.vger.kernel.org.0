Return-Path: <linux-pm+bounces-8675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D168FDBDD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 03:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B681C23073
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CEEEC5;
	Thu,  6 Jun 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHNzpdf7"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFC4683;
	Thu,  6 Jun 2024 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635599; cv=fail; b=XKIHEdr2QtzDO0xf+BljHmmIVXigLv0Exf4aKEY9FuJNNpFmL9nWxm8x+QjwcptoKtaurDIKpZDVpP2/QOwSjuzrwDAbzD0Oxh5inGaDm3pIxyoQAtI17vv4+Wy4FtjfUTJDSPIiz97Zw9YgAqjDBAU3+NRRlFABLZFUwBml3SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635599; c=relaxed/simple;
	bh=6KvMlReQ+wXNBjwVZNunlP3QU86We4LjAFD2fP3DtKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+3De4bD9mpKp4Xyk5KHzPe4a9X+8rX+z+s8lJd60NyrRLPknJSMZRarVfKJDyAwfduY5CUALsDuRph1edGyTcvfDkI7tExx5d/FWedH8IHWdGdgu78GLT2dMsYAruglw89TrRqVpMy7bqf0CCwCWwjibVt48cCs/mCB2RcErto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHNzpdf7; arc=fail smtp.client-ip=40.107.14.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDYnDaRdXdQF61Gmv0Hm/PnmZS2VemziGS2NpJydnOqRruA3M06am5tBWv4/TqL5C1+OgjqeFf4uLa44u5D/gjGv/pWa3oXuxB2kw/3qkxv3FJBe4xdUEvAroh/lljfUn54lJJ0R9CPh1y3xiqfDT263bZMdwyDNNiz09C8wdv/kR+E+5KW8cp14cZ98AufYPrZIy360Wr+ZP+88spZSH0JRvrG6otCp0gsI06ikpq4l3+ZdWeLSHpPv4JOIVzeXgQZh8kqRttBUTShpk+pqxosZzLCAZ9Sof0DS7sx0czTQ1B499HOfaYhNwrNcKVboWp59lxqFv2p7pmJXdOA0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KvMlReQ+wXNBjwVZNunlP3QU86We4LjAFD2fP3DtKM=;
 b=NuQIc5xBoXB20Qgl6cHk5HLt1P9EAUCBWup5+DU0nyvmyeMkV6leN29MtEYhV/xgUS4FCewk4/cdUHy77LED7Zw6s4umhXpzFhnMnbclkJrspI13gI4JBCyzWc7iveknEhEMIsshRd6kVJ2FwyDSvucbtn9Y+5xI01F0mwrg1n9IZo3DzmiQlKkRUYJOS2edlYR9oMdZ1jb9osdS2R7gVA/N7TvLYLizW/i88xzM2QOHIl6lhHwr/DjIQgzXOrpdXishW6aDMdJDswwIGpFeIy0OJ1hp2X9v7gibIxxysiRl7/2wCG5uj9XrFmWD6BTF7KMXpeF4BJKoPiYpv/EmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KvMlReQ+wXNBjwVZNunlP3QU86We4LjAFD2fP3DtKM=;
 b=DHNzpdf7uckWsUxCqH2j+CUOBWTbY9Ev1s7Q6RpuFl/vNWvhJEh4VGoroL8noPeJt/38ZxsVG28OcIYE/BjK9Nqbr5DXmPr6ZYQ+Ejz8TThw8DwygKK/yHdM2G5Rvym0w5EhbS3IhlHbgK+oaF3FwKpB01+7eWzRXyQKz7OFkTc=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 00:59:54 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 00:59:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Georgi Djakov
	<djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] interconnect: imx: add missing MODULE_DESCRIPTION()
 macros
Thread-Topic: [PATCH] interconnect: imx: add missing MODULE_DESCRIPTION()
 macros
Thread-Index: AQHatg/KTgQ6dQunG0eayBdINzECobG57Www
Date: Thu, 6 Jun 2024 00:59:53 +0000
Message-ID:
 <AM6PR04MB5941FB665D2D512238095FA688FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240603-md-interconnect-imx-v1-1-348a9205506c@quicinc.com>
In-Reply-To: <20240603-md-interconnect-imx-v1-1-348a9205506c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB9PR04MB8251:EE_
x-ms-office365-filtering-correlation-id: 9614fc42-5d19-4587-0613-08dc85c3f9ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjkyQm1uK0FLbjNoaXQ1Y2I3SmtVOWg2TzZRZlpzM2VRZFhrUGVmUEJUNkdC?=
 =?utf-8?B?YW13Ry9SS3RWRUJkalFwLzBHYWxzeElmZkdseHF4VGpnekdLaXhRY1IrWTk4?=
 =?utf-8?B?dndoRTRzK0plclp2RCtZY0dZN2ZDVHRvemZmSXRQVGNvMzQ5ZWJ0Q0RMeWt0?=
 =?utf-8?B?NDhCN0pOamNxOFN0Uy8ydTNsRzYrRm1uTUp0TXpjQjAvV2p6WDA5UHh4N0Ry?=
 =?utf-8?B?YUxiVldkcGtENFVWRFdRcGJ2ZTgxSVJIWWVoeThmbHZhOUQrQk14emJubkRB?=
 =?utf-8?B?SXJ6UEVBRm9qamVyUTdmb21TckdiMUhRK2dmMnAvK0M1ME4vVVYrV2RQN2Fm?=
 =?utf-8?B?YjJ2NFN2YmhHYkRpVUczOHZHNU1naUg2blViNjVOcWxQcHBZV29ucG4yTTVI?=
 =?utf-8?B?T01UeTYveWQwVVdsQVVSYUJRUzJXZFpVNzhCdkJ5OFRkR0V5ak9icmZDVnJk?=
 =?utf-8?B?NUliSzRRTWhYSnZBQ1ZrNXlGcU1kK0E2OGlZYnkyMnVyWVg2SjVUVzRDTUFQ?=
 =?utf-8?B?dDJVVGtRSFhoY2NIN2t4YmFqTHdCOVRLcXdhSW9FM056cWJvOHhoM3pDQjhL?=
 =?utf-8?B?U0dWZnJOWXQ3SzJ1ZndoZ2hsbG5QMUFEdld4czN5ZWdVd3h5WTdoN2tyb1Qv?=
 =?utf-8?B?WllFOUYrWFB3emZvWWgzNUJQRmNMYjJpSEpPZy9zdGxSQ3d5eXRZbHEvUTls?=
 =?utf-8?B?aTdoSG44SmdCOFFVazM0OXo0K0swVDhzVWdNSmhKOUg5Y2JwYnVpUkZnbmVZ?=
 =?utf-8?B?WnFBSnZkblpzTnR3RDFsQUxkYlZPaXFQcUZzczBkbnRxSEhxUEhlMTB4c3R5?=
 =?utf-8?B?N1VBY3A3S3pxZkZIOUw0QmVWd1A5YzJDTmZJeUQ3RlBMZ2pxTmExZmRzejZ5?=
 =?utf-8?B?VE50MnRxZ281S25jMnF2SzBaTlhuaDNSclcyMkxiODM0UHd1TncyNDRRcVVP?=
 =?utf-8?B?bzRraE44ZWdNSnREUHJ3VmIzd01rdDlLaG1hU1pPVXV2RWg2REt6MUVQc2dC?=
 =?utf-8?B?NW1BQlhEQk8vRnRCNTI3NllrajVVZFcxNC9RcWF1UWx3ODhLdENrNUMvbE8y?=
 =?utf-8?B?U2Z1c1ZTOEJYaXhhVUo3Wm5hWDQ5SGFlOFozb1FuTzlOUWQvVTlhM3JGOTF4?=
 =?utf-8?B?WnpoWGdrOEN1eU05ZGdBd2MwbDhkTjE5MUIvUm8vbTNQS2RXa3pvMXFmTzVq?=
 =?utf-8?B?NW5MN3lnb1ViV3Y4NzZqdlIyKzlvRm9Gcm8yK00vUjlDTTI3TTVaaGxOcit1?=
 =?utf-8?B?cWc2K2hCVk5RanhHZGxXSU1nanI0dHNtRlgvK1lrZjhLNkZOSUVtaHNjdTNI?=
 =?utf-8?B?ODlUTkEwSHdDZys3cUs0N2dtcGt5ZVhlWWRaVmpnZWxEdEVUWGc1U1RYL1E2?=
 =?utf-8?B?MURsaEVRdDF6YXJYU3hDajNWY25GcE1IRmhFZGtIRHkrdS9uRU9BYituaGk5?=
 =?utf-8?B?T01IaTMxL2p0UnFWVjM2WDY5cFh3QkFBWi9yeVg4N1lROWJZTTZzS1RVMGxR?=
 =?utf-8?B?aGZtVmNJcGthUW1td3Y5TWRCZVJuYXVweUVCejJoVGVTVU1NbjJMcnlob1ZC?=
 =?utf-8?B?NEd5NS90ZlRST0hyTldGYytYbGVKaklXRTFOd3IvMmRWdUJmcUN6YnArWGsx?=
 =?utf-8?B?aHB4dHozMVNvMjFNMHJIS0YwUXh2ZlFVMlh4RlZraEF0dWF4OVR6NVpUZXFL?=
 =?utf-8?B?M0JGY1E2WFZBUExVbmVLdGVYS0gwUDFId3dZeVIva1g4T3kyRjgySWlTYmpZ?=
 =?utf-8?B?MjVvYkYrdllVQkNVTmoxUmlReXRLWGtrOHYzcDVKWXlKZG5zRjVoNVdUQ2Ez?=
 =?utf-8?Q?spOUqZtwcjLFZ+45MyaOzOv7t+V0mOg/yilsU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1FvSnhmbjNsejNoSndQUU9EL3ZMM3RyK2FkUXBtOWFUekVLdGk0Tkp3bW9K?=
 =?utf-8?B?ZGVSTjZuenhvc0h2RGM2NkRWbG85SW9yU2ZKU3Fiei9LaENIVGYxa1pKd09t?=
 =?utf-8?B?dzZ2ZEJBWnUzYU5mTTduS3FsbFVoSEpTQ2ZnLzBBVG9OcUN6WERLQWR3K0da?=
 =?utf-8?B?M2oxZHd6OVk2aW9YN0JNd25yRi9acWhZeGpZbFhmYWo2WkxpNGJpdFNvTTEw?=
 =?utf-8?B?dW1lUytJTENFeDAvZFlFSlNTRUo3OGxKVDRZOW1KKzY0d3pZQ3Bpd2VlUGJU?=
 =?utf-8?B?ZHlPc0MrMFB1R0t4emhFNjYwaW1rYklBZFI5TU9wZFRnOEo0RUQ0aDA4RGpP?=
 =?utf-8?B?SGthdnk4NHFPbzNwOW5pVXB0SmhONUtHYzBiOXFXTHNGT0o5bGlYSGJuMHZp?=
 =?utf-8?B?bHp2S0FoTGhUOEpkWmc2MndkN2ZHaWlLSWR6NzExaEkvTzcrT3NKblZmeXZO?=
 =?utf-8?B?T05MbUhHOHN1TWxVYVdVdlBGN1Z6R3pGd0tQaGVZL2tRdytiUTBOa2JESmN1?=
 =?utf-8?B?SmMyRVloVlZLNERZb2pVY284cCthYlpQc3hqU29yYW5aT2JRVzZEbm9TREg1?=
 =?utf-8?B?Vyt1YXBXTG56bjhLSkpJdUdNditicTdBMHlIWE5GSFZieit6WWlMWVVmSnNE?=
 =?utf-8?B?M3hob2hnSnRJbjcreHp4blp1aGFXSDR1dVQ5VUR3R2t5YlpBaGFEQ0tYK3lp?=
 =?utf-8?B?NDFXWEZOK1NxdHc3S1RsTGFTcEo2aGN0VjRJSkZMS1hkVFBXamhsSWRWUXM2?=
 =?utf-8?B?MW14UnAvQ2JQdnI0SUFvLzlQamc1YzZaMlBVTTh2RWc3a01WaFNkV1kwOVoy?=
 =?utf-8?B?L05WSVYveWVjK3FBdEl3MXdsY25LbFB3aWZaS0NHbDJXaUtQRDJ1cG1rbU1E?=
 =?utf-8?B?L1RIc2p0RXdyb1N5VzhPTXY1eEVFNkJSeitRUnM5c3pwY3cvbXdLVFl4OGpx?=
 =?utf-8?B?dGJqMzhwSlZLU1B6TG5sVWJnY1JudkVLYUx2cGZZb3YzeE1EZStnWWE1MkZx?=
 =?utf-8?B?bWJiUXhJUC9LSUFFWmdTd3M3TzZHWWlpQjM3a2RJaVMwUXF6OTc3eVRFdXFn?=
 =?utf-8?B?MWY1UGtYMHFxbGFWdkwyamlmK0RXY0VIbVBBcWtZOEFHY0tSV1ZxNUZHa0ky?=
 =?utf-8?B?MDAySWdWbDdpYlNWQXhtckV5Zkc3SHcrZW15WFd6b1NkMzRtbGQwZ0lUYmp3?=
 =?utf-8?B?QUY2OUNhN0psdFFRWFEvOENOb3JCNkxyeW02b2FlUFJQeXVnMHhZTEs3OTlE?=
 =?utf-8?B?eDk4Sm9odDhPVXRodXN4L0szSGtRTTArdGM1Tm5aSTVpOFdLUnZxMW90MDVQ?=
 =?utf-8?B?Mm04UVBReG1DSkhyN2MwbTlMOWh6a2RJMFRVUGRteUdiQ1IwbFd1REFIVmVN?=
 =?utf-8?B?MUxyRlljODN0dFUwRFY4RFVVNk5GaDdrenMrcUNlcElta04wVVpjQ2ZrclBG?=
 =?utf-8?B?TkNlTEtwN210T3JRSmdNSi81SDNaUENqdnpTRWNuc0ZOdVI2MC9QZW9uSXNy?=
 =?utf-8?B?ZFQzMFVOS2JyY1JBblNIcDJabmF2ZkRNdE9zWFlqcW85aVp2VkJIOTkzbEtQ?=
 =?utf-8?B?MzE0ckhNaUIzbzF5bEQ3M1l6amZGREhUb01YRWpoSUNQQkd4QmY3RmFNNXJT?=
 =?utf-8?B?bWVqUWRaZENWTE8zNW9IY1JRUkRFUWpEZ1M2c3VqVS90dWRkVi9CdkVFaFhk?=
 =?utf-8?B?My8vdWd4bWZFMlZqMTlLbU5PTys1SFJUenN0a2h4czJmWUZ1dThaOGFYM1k4?=
 =?utf-8?B?QTF4bGhPQTZtaVU4OEx4MnR1QXRvWW5QenJGR2V5b3NvVnA1T2pyb3BUZWFh?=
 =?utf-8?B?ZUV0Q01GQm50ZllMcTNuRE1YcUhFZklkVVpUYVN4dzFEa0lKc0dEUVlydHJT?=
 =?utf-8?B?am5QQWNYSjViaC9KNi9GMXg4emVhOTREdm9DUFhzNHNZZDJFU21UaHlRSVB4?=
 =?utf-8?B?eWIxSnJ2RjAzY2FvN0xiRFBZTkdLcVBSc0xwY2s2MTd2QTYrY1R1TlowRmo4?=
 =?utf-8?B?a2ZaZEs0ck1zVkw0OFdxdHZMVm9sK1Z1OTRGallENTA4SXdENTdkeWhGd3RJ?=
 =?utf-8?B?YzgrellkY3d0SzY2aTVNK1E3RDdjWVR4YnJXa3h2WlpHRXNnYUtzNjhLSHhx?=
 =?utf-8?Q?8zMA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9614fc42-5d19-4587-0613-08dc85c3f9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 00:59:53.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7jUR6usFg4twYKTz+juKIut/4oYzBU0Qp3TL1Gr3slgoEULmUFbxtfzbx1RKL8Zw691edf1sc1YyB371Ti1yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251

PiBTdWJqZWN0OiBbUEFUQ0hdIGludGVyY29ubmVjdDogaW14OiBhZGQgbWlzc2luZyBNT0RVTEVf
REVTQ1JJUFRJT04oKQ0KPiBtYWNyb3MNCj4gDQo+IG1ha2UgYWxsbW9kY29uZmlnICYmIG1ha2Ug
Vz0xIEM9MSByZXBvcnRzOg0KPiBXQVJOSU5HOiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9ERVND
UklQVElPTigpIGluDQo+IGRyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9pbXgtaW50ZXJjb25uZWN0
Lm8NCj4gV0FSTklORzogbW9kcG9zdDogbWlzc2luZyBNT0RVTEVfREVTQ1JJUFRJT04oKSBpbg0K
PiBkcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14OG1tLWludGVyY29ubmVjdC5vDQo+IFdBUk5J
Tkc6IG1vZHBvc3Q6IG1pc3NpbmcgTU9EVUxFX0RFU0NSSVBUSU9OKCkgaW4NCj4gZHJpdmVycy9p
bnRlcmNvbm5lY3QvaW14L2lteDhtcS1pbnRlcmNvbm5lY3Qubw0KPiBXQVJOSU5HOiBtb2Rwb3N0
OiBtaXNzaW5nIE1PRFVMRV9ERVNDUklQVElPTigpIGluDQo+IGRyaXZlcnMvaW50ZXJjb25uZWN0
L2lteC9pbXg4bW4taW50ZXJjb25uZWN0Lm8NCj4gV0FSTklORzogbW9kcG9zdDogbWlzc2luZyBN
T0RVTEVfREVTQ1JJUFRJT04oKSBpbg0KPiBkcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14OG1w
LWludGVyY29ubmVjdC5vDQo+IA0KPiBBZGQgdGhlIG1pc3NpbmcgaW52b2NhdGlvbnMgb2YgdGhl
IE1PRFVMRV9ERVNDUklQVElPTigpIG1hY3JvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmVmZiBK
b2huc29uIDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPg0KDQpSZXZpZXdlZC1ieTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14
L2lteC5jICAgIHwgMSArDQo+ICBkcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14OG1tLmMgfCAx
ICsNCj4gZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtbi5jIHwgMSArDQo+IGRyaXZlcnMv
aW50ZXJjb25uZWN0L2lteC9pbXg4bXAuYyB8IDEgKw0KPiBkcml2ZXJzL2ludGVyY29ubmVjdC9p
bXgvaW14OG1xLmMgfCAxICsNCj4gIDUgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5jIGIvZHJpdmVy
cy9pbnRlcmNvbm5lY3QvaW14L2lteC5jDQo+IGluZGV4IDk3OWVkNjEwZjcwNC4uOTUxMWY4MGNm
MDQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14LmMNCj4gKysr
IGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5jDQo+IEBAIC0zMzQsNCArMzM0LDUgQEAg
dm9pZCBpbXhfaWNjX3VucmVnaXN0ZXIoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikg
IH0gIEVYUE9SVF9TWU1CT0xfR1BMKGlteF9pY2NfdW5yZWdpc3Rlcik7DQo+IA0KPiArTU9EVUxF
X0RFU0NSSVBUSU9OKCJJbnRlcmNvbm5lY3QgZnJhbWV3b3JrIGRyaXZlciBmb3IgaS5NWCBTb0Mi
KTsNCj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW50ZXJjb25uZWN0L2lteC9pbXg4bW0uYw0KPiBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9p
bXg4bW0uYw0KPiBpbmRleCA4YzQwZjQxODIyNjMuLmEzNmFhYWYxMDZhZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtbS5jDQo+ICsrKyBiL2RyaXZlcnMvaW50
ZXJjb25uZWN0L2lteC9pbXg4bW0uYw0KPiBAQCAtOTYsNSArOTYsNiBAQCBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBpbXg4bW1faWNjX2RyaXZlciA9IHsNCj4gDQo+ICBtb2R1bGVfcGxh
dGZvcm1fZHJpdmVyKGlteDhtbV9pY2NfZHJpdmVyKTsNCj4gIE1PRFVMRV9BVVRIT1IoIkFsZXhh
bmRyZSBCYWlsb24gPGFiYWlsb25AYmF5bGlicmUuY29tPiIpOw0KPiArTU9EVUxFX0RFU0NSSVBU
SU9OKCJJbnRlcmNvbm5lY3QgZnJhbWV3b3JrIGRyaXZlciBmb3IgaS5NWDhNTSBTb0MiKTsNCj4g
IE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gIE1PRFVMRV9BTElBUygicGxhdGZvcm06aW14
OG1tLWludGVyY29ubmVjdCIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3Qv
aW14L2lteDhtbi5jDQo+IGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtbi5jDQo+IGlu
ZGV4IGZhM2Q0Zjk3ZGZhNC4uMmE5N2M3NGU4NzViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lu
dGVyY29ubmVjdC9pbXgvaW14OG1uLmMNCj4gKysrIGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14
L2lteDhtbi5jDQo+IEBAIC04Niw0ICs4Niw1IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGlteDhtbl9pY2NfZHJpdmVyID0NCj4geyAgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihpbXg4
bW5faWNjX2RyaXZlcik7DQo+ICBNT0RVTEVfQUxJQVMoInBsYXRmb3JtOmlteDhtbi1pbnRlcmNv
bm5lY3QiKTsNCj4gIE1PRFVMRV9BVVRIT1IoIkxlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVz
dGV6QG54cC5jb20+Iik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkludGVyY29ubmVjdCBmcmFt
ZXdvcmsgZHJpdmVyIGZvciBpLk1YOE1OIFNvQyIpOw0KPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2
MiIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtcC5jDQo+
IGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtcC5jDQo+IGluZGV4IGQyMThiYjQ3NzU3
YS4uODZkNGMxNTE3YjI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgv
aW14OG1wLmMNCj4gKysrIGIvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtcC5jDQo+IEBA
IC0yNDksNSArMjQ5LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14OG1wX2lj
Y19kcml2ZXIgPSB7DQo+IA0KPiAgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihpbXg4bXBfaWNjX2Ry
aXZlcik7DQo+ICBNT0RVTEVfQVVUSE9SKCJQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4iKTsN
Cj4gK01PRFVMRV9ERVNDUklQVElPTigiSW50ZXJjb25uZWN0IGZyYW1ld29yayBkcml2ZXIgZm9y
IGkuTVg4TVAgU29DIik7DQo+ICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ICBNT0RVTEVfQUxJ
QVMoInBsYXRmb3JtOmlteDhtcC1pbnRlcmNvbm5lY3QiKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW50ZXJjb25uZWN0L2lteC9pbXg4bXEuYw0KPiBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L2lt
eC9pbXg4bXEuYw0KPiBpbmRleCA4YmJkNjcyYjM0NmUuLmY4MTdkMjRhZWVmYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtcS5jDQo+ICsrKyBiL2RyaXZlcnMv
aW50ZXJjb25uZWN0L2lteC9pbXg4bXEuYw0KPiBAQCAtOTcsNCArOTcsNSBAQCBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBpbXg4bXFfaWNjX2RyaXZlciA9DQo+IHsgIG1vZHVsZV9wbGF0
Zm9ybV9kcml2ZXIoaW14OG1xX2ljY19kcml2ZXIpOw0KPiAgTU9EVUxFX0FMSUFTKCJwbGF0Zm9y
bTppbXg4bXEtaW50ZXJjb25uZWN0Iik7DQo+ICBNT0RVTEVfQVVUSE9SKCJMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPiIpOw0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJJ
bnRlcmNvbm5lY3QgZnJhbWV3b3JrIGRyaXZlciBmb3IgaS5NWDhNUSBTb0MiKTsNCj4gIE1PRFVM
RV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYTY5M2I5Yzk1
YWJkNDk0N2MyZDA2ZTA1NzMzZGU1ZDQ3MGFiNjU4Ng0KPiBjaGFuZ2UtaWQ6IDIwMjQwNjAzLW1k
LWludGVyY29ubmVjdC1pbXgtNDNlY2NiMzQ5M2JkDQo+IA0KDQo=

