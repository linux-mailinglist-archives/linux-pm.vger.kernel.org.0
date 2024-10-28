Return-Path: <linux-pm+bounces-16555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159309B2428
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 06:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D40AB211B3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247018C35A;
	Mon, 28 Oct 2024 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BBiIKpL4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DF170A14;
	Mon, 28 Oct 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093265; cv=fail; b=Eyfq+HiEUZuv52E5uuR9uVp7ttYl3IyZ9oxQtwuDLaVlNLg6IP18YmdmvbSqmmF2Gq1HiOrNIdJAmurQmkaFDWhaZHcjIvssVYNNHea1/UqF8R7xuqOHfeA+MDMF39f2hGVjx5BVTkDb2V6yLYctRGGQ0Ndarpqy/FY8MSoHpgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093265; c=relaxed/simple;
	bh=o7EcJW3+UsGgjzs6hTaQnbtipbzppilz/IRvkRgT+qA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rHwaioBLXB6DZSGdIFAhAq8ccx5KO0ex77irjPVNPXNHZkrY8+vZ/x6fa9n97pw1HIXiX/BV9xcXyJ4SI1thgi5n/a7zuOO/vQc/GK3NEVGEqYe//IznWsOBIyH1bgFfajLfre5h9qHooAh4aGI2begEo97wF2OGWiqMEYVIy0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BBiIKpL4; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SarpRuVHIfZH6qXNhFHYHwv6SC9pN0QVe+L60c9ER1tLPjX7byCbH/V6puRxixFp7TqZSnVYvHy6C/+eUOVOOgUGGY/c8+j9p0QB64BpvUJmnHdu15mPRDGlc0Vey5pemVaI+pKis5jxZw3K7THs+fqHMiLtQWevGE2FqgbqyZvG9GRaXSpqzg98o0d3S4eoMY+oAq9l83B58B3Scq2O1a6J9VV63GpEqdsS6LCRy0I8jyfLxMQ/QZPnp0gj+woly9Hh4p1tuIc0juqrz6rdEJo9G0Cb7DN4tVAc5yBmwty0tnOQYdpY+1KhWkA6YEpmM0ZbFpYgGLNXyYVfBBU++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7EcJW3+UsGgjzs6hTaQnbtipbzppilz/IRvkRgT+qA=;
 b=JK8NFsguiJrkQzSD1jhb/rUBbdvyugeMjbY01sxMO0J9KRWgort9Jru7Y0WTniv2FW37hm6a98X1LEaNUUunaSouZm9NqiFLhlofdAbQ/rQb99tvzDwZWgnFpY1REk3AyuapNU6qmkarTuLwuOpMgIz68pVMB+QorigC3xqxAkSvYV7B0NakXWlgeCU0JUEpPFhbGnqLzJ7pk/p34kfGY6lOL5acwjS8jWFTh0T+KbMZcqlphSlf+TblKDDpvKs+hCDSZeF6qxxI9s7UozXfP/Swn1v/aRM4YhPsUbvWLmEtVBVV7McObRXYZF3RI8FF5WJcBJIMdO9AEe4mBHWlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7EcJW3+UsGgjzs6hTaQnbtipbzppilz/IRvkRgT+qA=;
 b=BBiIKpL4uwZn6iMuT4N0q01zSFfzAGhKMrBeCZ88ffMQWBATzoeDawcaFXXnl3T4db34LgkDUj670ufNkW8N3QNeT/IMRznWJZZE0IuJyWT7Qo2BlmFrkygLtC1JyAJjFfabO8dsWNOr2HMctsiGDdJHJeUIk/EhqR/2ls1JVyQUPFqLyufjbp5oGk1usSngDT9iDMd2sZGJC+Grwmo7mcbFfODoNi0UtXhbwz/L4W4tg6pGjQc9B41psjyHZRxkkGgc0pLU8354EHkKlz+E1Toh0h7AbwT7Zhv9sp8biyAl3cC1co70DcvEqbwkE3VBW/aoO2BR4EA4iODeKB6JUg==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 05:27:37 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 05:27:31 +0000
From: <Varshini.Rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<Mihai.Sain@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Index: AQHbGww0eNfdnuYAy0uOwjFkVwXjc7KbvhyA
Date: Mon, 28 Oct 2024 05:27:31 +0000
Message-ID: <89ffcad7-213f-4078-964c-4c6b30059170@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|PH0PR11MB5175:EE_
x-ms-office365-filtering-correlation-id: 6dfd15d8-7224-47f4-ffda-08dcf711389a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHFacWJmWkw1TVJKVnlvK3R2N09CdFAwTnZWUG82dXFkWjJScEYyYlRHeUJV?=
 =?utf-8?B?RERMaWp1b1NqQmQxYlpjckdwWkNaRWliYmZjYXZvMndNakhhZDJXVW5JTnpN?=
 =?utf-8?B?L28ydVovYjhobjMrMHhDenkrejU3TmRIUXNCM3AvaThicWVBMmIvQ0Z2aGd1?=
 =?utf-8?B?K21KQ0ZwT2hZaFdmc1JlRWlBZXBiZzNUcU02VzIzSkFpNnNZZjVLWHFMUjd4?=
 =?utf-8?B?ekRLSXdGOFdkUGFTa1dWRXdPYXJBeERqeStpRjF1ZmxUQXV6Q1VPRU9vckx4?=
 =?utf-8?B?eHI1a0F6Kzl4WXVVVUFLUFNFdVk5cGt1TGNoM1NNMHkzQWU1Nkc1dW11MVZI?=
 =?utf-8?B?SHA4TWVFdHZDMzIyQUNsVlBRSGYyQlFEZjN0aXVVN2g1UHZwUkhZS0ZIOVli?=
 =?utf-8?B?VFlYams3OHQ3VThlRjJWUW02ZTA3ZncxNXlPK0NOTVgvTW9aK2FFMmU5cWdm?=
 =?utf-8?B?aDB3YXM4YVhEdXkwdWNhSG1XQTlpUERwdGtLNmRGSTZkQzY0a0lrR0tFQVhr?=
 =?utf-8?B?ZVp1eHZnTUR6aEUxVlV1TVpqZGdDRmZ1QVFrUlNCYUpKQjZ1UDlpNFU0N291?=
 =?utf-8?B?RDNrTjZ3c1VDemovZ2FnOWFaM2NQc284WFRrK3UrN0JOM2thR1VDZmVWbmFy?=
 =?utf-8?B?a005ZFM5cFd6UzZ5c0I1emtxZjZ6SW9oL2NsM201Z0FOS1pXKzNwSFVTTC9H?=
 =?utf-8?B?dGJiMTllak9VeFJod1FyQkM5a0JtY0RkSWxDV2Z4MjJrRllrenFoekJGRjJR?=
 =?utf-8?B?NDBCSGhUS2Ria1dCL1U3UFFXMDBQRVRieXdFTFZybk5vdW1oN25wWlJaNG1m?=
 =?utf-8?B?RzJnVTU1R2dwamtkZ1ZOTDV4ZGFMdU43UmluVnliVG1pWlVGWis1T3lpMDNY?=
 =?utf-8?B?TVpSY0YydFVGUUZwYUhFSTlMYmJHcS84K25lMEJ4WmpFam1oVTcyV2tyMkEv?=
 =?utf-8?B?a1R1RUQzeTV6V0YrSGQ0d0dqanBLdlpFUXB4Q3FBYWlYczlMMkRaYk92c1J4?=
 =?utf-8?B?SVpvWU9UQmRudkx1Z0d1K0s1YmYwUXJmS0VEVzVEZnBDQVYrVVVINDI1WVU1?=
 =?utf-8?B?NkIyclk3Y0pYSGpubUhmRlRIMEdsaG1mNG8wcE84bDlCMTVNUG9mNVRkR0dJ?=
 =?utf-8?B?OTJmT2tORWIxcURBS2RkVTh2dW1oQm1pMm5EbnpNcG5pcldHWGxIb1hlanRK?=
 =?utf-8?B?cXAxR0NRS2ovZUxmWFVzUkFaM1JjTEcxWFVpcWZ3eS8yK0l0UW1kcXFiUTJY?=
 =?utf-8?B?bmxVSFlVWDg4Mk9YaGFKQ3VML1ZXMGdycjl1OTl0Y1g4b1prQ1JVQ3JmalhD?=
 =?utf-8?B?ekUwNTFjZWNXMzh1aDdvNk1MSXY0YWs2c1dEMGtheEZPNEY5eTMzL0l6Ry84?=
 =?utf-8?B?YTlWekIzejNVT0pVVFdDV1BzR2VOKzdQS2dGQ1FTK3puT1huV3VqUWYvM3I0?=
 =?utf-8?B?UUpuQW5yQkFqM3pOVGE4cld1U3JvTVpRREh6S1pLNXVNR2lwWmlwSG9JeUo3?=
 =?utf-8?B?UUhzQ280Q3NhYm1GZ1k4eGx6RjloblNOSUQ5Mk00di94M0tYZ3dNdXdNVG96?=
 =?utf-8?B?TWMycGRkNDQ4UTVGQlJIcjRDUmhyeWw4MERjcXJVaVRCclovbll4N29OSVBE?=
 =?utf-8?B?QnIwNWhEZU5rdHdKUGRFKzVOU2wvNGFqVEd4YWNtQ3VKKzYrUnBUVE5jNm9k?=
 =?utf-8?B?Y09kMDFWK2tsNVBvOUFjbzE1R0VvZlQ4ZThHWmFGb2p1RFNucFNyQzRqeUh5?=
 =?utf-8?B?cGxWYk1XRUdzNDdmMHQ4RXRJT3poU2ZwenhydktKcFdYMWhWenlBVGh5aGN0?=
 =?utf-8?B?NjNZYmdvcUN6R0EzeUp2VldBQlJzYjh3WnhDUldydDdyQUF1SElyWThCQ1RN?=
 =?utf-8?B?eVNzbjBQWlB3Q0U1ZzQ4MHF3QXpxNEovWmlaa2RSVmcxamc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0JLRWVPNWIxUFUwdGxka0JsVnl3amVOOXFDdWd1WWlHSWt3dTVoUXBOaTdt?=
 =?utf-8?B?NGtLbkRkTnlES3Y5R29UUUgzVmJ3T0s2dFFhQVY5YXQ5SFZqUmFUanZxVklK?=
 =?utf-8?B?SGV1YjE4QVBHMjIrdVQzR3kzQjVkZkI3UFdQYnZNd0RvWkNJT3dKZTFjUVV5?=
 =?utf-8?B?dnRGMlRncmZqZ29Sd3FvaU91MnJWVENEZSt0WmloR0FhMEozV05kcVowREs3?=
 =?utf-8?B?RG5Obm1udzRCck5hejh4Q3NvbmRNOE5ZK28ra3Q5UitQdWQxbWlpai8xeGJY?=
 =?utf-8?B?Z1ZmZ25XQksreUNtUE5iVTQ5YVFQYmNtdmJ1NDhpL3l5a2RZREVVbU5DWWxr?=
 =?utf-8?B?ZllKWDNJSWFuRlQ2UVlDQXEzSUJmOGFzN3UzWmcwSzBVaTUwTnVVUG1DbUNB?=
 =?utf-8?B?TEY5L2dzNk1YMXRXUWhwbTJrN2VLNzBxcTJVcFhVa3AzaDNtS0FmanVuOVJq?=
 =?utf-8?B?NGN3NjRxV0w0M3QwQzhzTVZWVDF5SmcvUVJSUFZORGhBMk9QYUhMMllIM2Mz?=
 =?utf-8?B?UFQ4aWFFRjlUSVptVmVWM1NWM203ZDdLQnJZc0hvVkFJSEsyUy9GUXBhQnJE?=
 =?utf-8?B?MkhpY3NkOGRnM1VBQUFSblpsZmt4dTl3anRoUWpWUy9zYU91L0RjS3FqQlRU?=
 =?utf-8?B?V1JFc2hNZlZna3FKZzdBZW5tbExxZmp6K1d3dDhvN29ER2UxVnJVcUlGUWVP?=
 =?utf-8?B?ZkVmM1ZhSjVnUUplemxlSy85Z2FYY1d3eGZEaUVIMkQ3UWtsWXYrcmVmbGxM?=
 =?utf-8?B?K0w5cXZnTjloMlFiZDZEVnJYbm1nQjZkbTNWc2FJQzd1WTJnblJJRzljOTBi?=
 =?utf-8?B?d2daRnJPRlV0TWN4ak5zdkJqdzdUMXA4RTcvWFN2SUdvMUppQXJsOWVxR2My?=
 =?utf-8?B?RzVDOG5qWktNanlTbTVZWFNBQ0FwbzhnOTlPTE5WejdQWDROSFEvcDJwZHV4?=
 =?utf-8?B?aVZCRmtObXNqWFZSenJWYnQzSkxiMFBhckpLaHlMQitWcHhucWNTeXl2emQx?=
 =?utf-8?B?emhEWERpNFcrMXFUVGZzZXllSitzYVpMclJPY3lzRkZZSzRMa3dtWE1qOWo3?=
 =?utf-8?B?S3BmUGI5dkt3eTBCK1kwaUNkQlJiWmhQd3kyalFON2xYeis2cFRLd3VNbUg0?=
 =?utf-8?B?Tmd6T1pyRUk3WHJER3NDRWxyY2ZuMDdNUzZpektDajJvR1FkbU9TcnpsNmln?=
 =?utf-8?B?RWQ3dy9SN29yMXB0YXlxdXhWWlNJbGR1SDFaMGphMHVwbGRORFpQUGNGVHJH?=
 =?utf-8?B?bDFIa1dxbzFPUG5CdmVGU2pPQUppN0pSeHZ3cmYvTE1EQjF5K290MFE3WnN4?=
 =?utf-8?B?Q2lJT29NSHRBR0JJRmdBU25UZFNjUDdNeXd3LzVLM3hDaGRsZXNOU1hXMmVS?=
 =?utf-8?B?U1RUV3VCZW9Oa3dtWjBucnVYbzdmdjR1MDdLbENXYWUyeG1sdEQ4NGl1NjVx?=
 =?utf-8?B?OWR4a0YyUjBkR3pQbEEveG1aNzViNVdwSERHeTE3bk5XcmxGQm0wUG5wdThp?=
 =?utf-8?B?WlN4SHZ6ZXUyaG1ONXE4dmVUTVJBS2tyUG14QnQ0TXREK0g3T1VTaHEyM3hG?=
 =?utf-8?B?Q250MW1zbEVhRmw2TVVKY1Z6WVVxNFBQdlQzWkZsTHRRanAwNVdqMmZPcFYv?=
 =?utf-8?B?SW82eTdxQm54cGkwV1VlanY1S2E0N3JlVlBtZzVFVUN1OGo3U2hYVnZDNzd1?=
 =?utf-8?B?WVBCcXNXb1ZwUWt1Mkg5NXlMSkpDTHJxSG9iZkVOaUtWSGpFMzVzQXVaWEtP?=
 =?utf-8?B?UUhNUVBYaUQraEw0TlhkaFM5MVpsS08vNE1kT3NrYWdkYTF2UUUzZHYwYUZP?=
 =?utf-8?B?SEFBUlMwMExCSFBNelkrckFadXBqN3FIWmRYYTIwSU1RQWdOUkVkTnJQL3dl?=
 =?utf-8?B?UXVnUWpKaUVndzBjWEY3UjVONEpzcTFyRFlqR0p2bTE3MFJ2YzBBdnppOHJu?=
 =?utf-8?B?WDB1eGY2U05iMnVRdExDWlBxZ3hoY2Jkd0p1Qk0xUFo4WUQweTNIaktUTXh3?=
 =?utf-8?B?K2VhSmIvcG9ZSDdJUkxmTzRVTFo4OWZHSTYyZzNXSFE3NnpZWnJCQXRHcHBj?=
 =?utf-8?B?aXhEM21XUldSQ1dLYStxMHIrbUJQSnlpbWRCQU50SWtHU0k5ZmgyamZMUHVl?=
 =?utf-8?B?ZFVrZXdtK2d3L3JKK3RuZnFqa0FWUGNmMEwrZjlJQkZmZUpNTkwrbXBTSXZh?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D130C4D5A1E3E544A6B267EC136DE6D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfd15d8-7224-47f4-ffda-08dcf711389a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 05:27:31.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/CzplBNRe4kWJc85lp5SGHmT8q6wm4SfBF321LV0FIHH3K0o1PSJdBUcDA3MHWc3ud5BWrMP7PifxKg8rfOcyWtGq//pC6YtTzSLnPLQNLOpC0zA37/ZfGAc3w2XUCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175

SGkgYWxsLA0KDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBlZmZvcnRzIGZvciByZXZpZXdp
bmcgdGhpcyBzZXJpZXMuDQoNCkFzIEkgbWVudGlvbmVkIGFscmVhZHkgaW4gWzFdLCBzaW5jZSBh
bGwgcGF0Y2hlcyBoYXZlIGJlZW4gQWNrZWQgLyANClJldmlld2VkIGFscmVhZHkgYW5kIHRoZSBj
b21tZW50cyBmcm9tIHY3IGFyZSBmaXhlZCB3aXRoIHRyaXZpYWwgDQpjaGFuZ2VzLCBpdCB3b3Vs
ZCBiZSByZWFsbHkgaGVscGZ1bCBpZiB0aGlzIHNlcmllcyBjYW4gYmUgbWVyZ2VkLiBOb3QgdG8g
DQptZW50aW9uIHRoZXJlIGFyZSBzbyBtYW55IG90aGVyIHBhdGNoZXMgaW4gcXVldWUgdG8gYmUg
c2VudCB3aGljaCBkZXBlbmQgDQpvbiB0aGUgc2FtZS4NCg0KWzFdIA0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8zM2U5NGE4My1lMDhkLTQ1ODgtODdmNS1iZDUxOTAzZWUyN2FAbWljcm9j
aGlwLmNvbS8NCg0KDQpPbiAxMC8xMC8yNCA1OjMxIHBtLCBWYXJzaGluaSBSYWplbmRyYW4gd3Jv
dGU6DQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIG5ldyBTb0MgZmFt
aWx5IC0gc2FtOXg3Lg0KPiAgIC0gVGhlIGRldmljZSB0cmVlLCBjb25maWdzIGFuZCBkcml2ZXJz
IGFyZSBhZGRlZA0KPiAgIC0gQ2xvY2sgZHJpdmVyIGZvciBzYW05eDcgaXMgYWRkZWQNCj4gICAt
IFN1cHBvcnQgZm9yIGJhc2ljIHBlcmlwaGVyYWxzIGlzIGFkZGVkDQo+ICAgLSBUYXJnZXQgYm9h
cmQgU0FNOVg3NSBDdXJpb3NpdHkgaXMgYWRkZWQNCj4gDQo+ICAgQ2hhbmdlcyBpbiB2ODoNCj4g
ICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4gICAtIERyb3BwZWQgcGF0Y2hlcyB0aGF0IGFyZSBhcHBs
aWVkIGZyb20gdGhlIHNlcmllcw0KPiAgIC0gUGlja2VkIHVwIFJldmlld2VkLWJ5IHRhZ3MNCj4g
ICAtIENoYW5nZWQgdGhlIG5vZGUgbmFtZSBmcm9tIGxlZHMgdG8gbGVkLWNvbnRyb2xsZXIgaW4g
dGhlIGJvYXJkIGR0cw0KPiAgICAgZmlsZS4NCj4gDQo+ICAgQ2hhbmdlcyBpbiB2NzoNCj4gICAt
LS0tLS0tLS0tLS0tLQ0KPiANCj4gICAtIEFkZHJlc3NlZCBhbGwgdGhlIHJldmlldyBjb21tZW50
cyBpbiB0aGUgcGF0Y2hlcw0KPiAgIC0gRHJvcHBlZCBwYXRjaGVzIHRoYXQgYXJlIGFwcGxpZWQg
ZnJvbSB0aGUgc2VyaWVzDQo+ICAgLSBSZW1vdmVkIHNmciBub2RlIGZyb20gdGhlIERUIHRvIGFk
ZCBpdCBsYXRlciBhZnRlciBjcmVhdGluZyB0aGUgcmlnaHQNCj4gICAgIERUIGRvY3VtZW50YXRp
b24gZm9yIG1pY3JvY2hpcCBzZnIgSVBzLg0KPiAgIC0gQWxsIHRoZSBzcGVjaWZpYyBjaGFuZ2Vz
IGFyZSBjYXB0dXJlZCBpbiB0aGUgY29ycmVzcG9uZGluZyBwYXRjaGVzDQo+IA0KPiAgIENoYW5n
ZXMgaW4gdjY6DQo+ICAgLS0tLS0tLS0tLS0tLS0NCj4gDQo+ICAgLSBBZGRyZXNzZWQgYWxsIHRo
ZSByZXZpZXcgY29tbWVudHMgaW4gdGhlIHBhdGNoZXMNCj4gICAtIFBpY2tlZCB1cCBhbGwgQWNr
ZWQtYnkgYW5kIFJldmlld2VkLWJ5IHRhZ3MNCj4gICAtIFJldmVydGVkIHRoZSBJUlEgcGF0Y2gg
dG8gdGhhdCBvZiB2ZXJzaW9uIDMgb2YgdGhlIHNhbWUgc2VyaWVzDQo+ICAgLSBBbGwgdGhlIHNw
ZWNpZmljIGNoYW5nZXMgYXJlIGNhcHR1cmVkIGluIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoZXMN
Cj4gDQo+ICAgQ2hhbmdlcyBpbiB2NToNCj4gICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4gICAtIEFk
ZHJlc3NlZCBhbGwgdGhlIHJldmlldyBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcw0KPiAgIC0gUGlj
a2VkIHVwIGFsbCBBY2tlZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiAgIC0gRHJvcHBlZCBh
cHBsaWVkIHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzDQo+ICAgLSBBZGRyZXNzZWQgdGhlIEFCSSBi
cmVha2FnZSByZXBvcnRlZCBpbiB0aGUgSVJRIHBhdGNoDQo+ICAgLSBBbGwgdGhlIHNwZWNpZmlj
IGNoYW5nZXMgYXJlIGNhcHR1cmVkIGluIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoZXMNCj4gDQo+
ICAgQ2hhbmdlcyBpbiB2NDoNCj4gICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4gICAtIEFkZHJlc3Nl
ZCBhbGwgdGhlIHJldmlldyBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcw0KPiAgIC0gUGlja2VkIHVw
IGFsbCBBY2tlZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiAgIC0gRHJvcHBlZCBhcHBsaWVk
IHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzDQo+ICAgLSBBZGRlZCBwd20gbm9kZSBhbmQgcmVsYXRl
ZCBkdCBiaW5kaW5nIGRvY3VtZW50YXRpb24NCj4gICAtIEFkZGVkIHN1cHBvcnQgZm9yIGV4cG9y
dGluZyBzb21lIGNsb2NrcyB0byBEVA0KPiAgIC0gRHJvcHBlZCBVU0IgcmVsYXRlZCBwYXRjaGVz
IGFuZCBjaGFuZ2VzLiBTZWUgTk9URS4NCj4gICAtIEFsbCB0aGUgc3BlY2lmaWMgY2hhbmdlcyBh
cmUgY2FwdHVyZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcw0KPiANCj4gICBOT1RFOiBP
d2luZyB0byB0aGUgZGlzY3Vzc2lvbiBoZXJlDQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtZGV2aWNldHJlZS9DQUxfSnNxSjlQclg2ZmotRWJmZmVKY2UwOU1Ycz1CN3QrS1Nfa09p
bnhhUngzOD1XeEFAbWFpbC5nbWFpbC5jb20vDQo+ICAgdGhlIFVTQiByZWxhdGVkIGNoYW5nZXMg
YXJlIGRyb3BwZWQgZnJvbSB0aGlzIHNlcmllcyBpbiBvcmRlciB0byBlbmFibGUNCj4gICB1cyB0
byB3b3JrIG9uIHRoZSBtZW50aW9uZWQgaXNzdWVzIGJlZm9yZSBhZGRpbmcgbmV3IGNvbXBhdGli
bGVzIGFzDQo+ICAgc2FpZC4gVGhlIGlzc3Vlcy93YXJuaW5ncyB3aWxsIGJlIGFkZHJlc3NlZCBp
biBzdWJzZXF1ZW50IHBhdGNoZXMuDQo+ICAgQWZ0ZXIgd2hpY2ggdGhlIFVTQiByZWxhdGVkIHN1
cHBvcnQgZm9yIHNhbTl4NyBTb0NzIHdpbGwgYmUgYWRkZWQuIEhvcGUNCj4gICB0aGlzIHdvcmtz
IG91dCBmaW5lLg0KPiANCj4gICBDaGFuZ2VzIGluIHYzOg0KPiAgIC0tLS0tLS0tLS0tLS0tDQo+
IA0KPiAgIC0gRml4ZWQgdGhlIERUIGRvY3VtZW50YXRpb24gZXJyb3JzIHBvaW50ZWQgb3V0IGlu
IHYyLg0KPiAgIC0gRHJvcHBlZCBBY2tlZC1ieSB0YWcgaW4gdGNiIERUIGRvYyBwYXRjaCBhcyBp
dCBoYWQgdG8gYmUgYWRhcHRlZA0KPiAgICAgYWNjb3JkaW5nIHRvIHNhbTl4NyBjb3JyZWN0bHku
DQo+ICAgLSBQaWNrZWQgYnkgdGhlIHByZXZpb3VzbHkgbWlzc2VkIHRhZ3MuDQo+ICAgLSBEcm9w
cGVkIHRoaXMgcGF0Y2ggImR0LWJpbmRpbmdzOiB1c2I6IGdlbmVyaWMtZWhjaTogRG9jdW1lbnQg
Y2xvY2stbmFtZXMNCj4gICAgIHByb3BlcnR5IiBhcyB0aGUgd2FybmluZyB3YXMgbm90IGZvdW5k
IHdoaWxlIHZhbGlkYXRpbmcgRFQtc2NoZW1hIGZvcg0KPiAgICAgYXQ5MS1zYW05eDc1X2N1cmlv
c2l0eS5kdGIuDQo+ICAgLSBEcm9wcGVkIHJlZHVuZGFudCB3b3JkcyBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UuDQo+ICAgLSBGaXhlZCB0aGUgQ0hFQ0tfRFRCUyB3YXJuaW5ncyB2YWxpZGF0ZWQgYWdh
aW5zdA0KPiAgICAgYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS5kdGIuDQo+ICAgLSBSZW5hbWVkIGR0
IG5vZGVzIGFjY29yZGluZyB0byBuYW1pbmcgY29udmVudGlvbi4NCj4gICAtIERyb3BwZWQgdW53
YW50ZWQgc3RhdHVzIHByb3BlcnR5IGluIGR0cy4NCj4gICAtIFJlbW92ZWQgbm9kZXMgdGhhdCBh
cmUgbm90IGluIHVzZSBmcm9tIHRoZSBib2FyZCBkdHMuDQo+ICAgLSBSZW1vdmVkIHNwaSBEVCBk
b2MgcGF0Y2ggZnJvbSB0aGUgc2VyaWVzIGFzIGl0IHdhcyBhbHJlYWR5IGFwcGxpZWQNCj4gICAg
IGFuZCBhIGZpeCBwYXRjaCB3YXMgYXBwbGllZCBzdWJzZXF1ZW50bHkuIEFkZGVkIGEgcGF0Y2gg
dG8gcmVtb3ZlIHRoZQ0KPiAgICAgY29tcGF0aWJsZSB0byBhZGFwdCBzYW05eDcuDQo+ICAgLSBB
ZGRlZCBzYW05eDcgY29tcGF0aWJsZXMgaW4gdXNiIGR0IGRvY3VtZW50YXRpb24uDQo+IA0KPiAN
Cj4gICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAgIC0gQWRkZWQg
c2FtOXg3IHNwZWNpZmljIGNvbXBhdGlibGVzIGluIERUIHdpdGggZmFsbGJhY2tzDQo+ICAgLSBE
b2N1bWVudGVkIGFsbCB0aGUgbmV3bHkgYWRkZWQgRFQgY29tcGF0aWJsZSBzdHJpbmdzDQo+ICAg
LSBBZGRlZCBkZXZpY2UgdHJlZSBmb3IgdGhlIHRhcmdldCBib2FyZCBzYW05eDc1IGN1cmlvc2l0
eSBhbmQNCj4gICAgIGRvY3VtZW50ZWQgdGhlIHNhbWUgaW4gdGhlIERUIGJpbmRpbmdzIGRvY3Vt
ZW50YXRpb24NCj4gICAtIFJlbW92ZWQgdGhlIGR0IG5vZGVzIHRoYXQgYXJlIG5vdCBzdXBwb3J0
ZWQgYXQgdGhlIG1vbWVudA0KPiAgIC0gUmVtb3ZlZCB0aGUgY29uZmlncyBhZGRlZCBieSBwcmV2
aW91cyB2ZXJzaW9uIHRoYXQgYXJlIG5vdCBzdXBwb3J0ZWQNCj4gICAgIGF0IHRoZSBtb21lbnQN
Cj4gICAtIEZpeGVkIGFsbCB0aGUgY29ycmVjdGlvbnMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+
ICAgLSBDaGFuZ2VkIGFsbCB0aGUgaW5zdGFuY2VzIG9mIGNvcHlyaWdodCB5ZWFyIHRvIDIwMjMN
Cj4gICAtIEFkZGVkIHNhbTl4NyBmbGFnIGluIFBJVDY0QiBjb25maWd1cmF0aW9uDQo+ICAgLSBN
b3ZlZCBtYWNybyBkZWZpbml0aW9ucyB0byBoZWFkZXIgZmlsZQ0KPiAgIC0gQWRkZWQgYW5vdGhl
ciBkaXZpZGVyIGluIG1jayBjaGFyYWN0ZXJpc3RpY3MgaW4gdGhlIHBtYyBkcml2ZXINCj4gICAt
IEZpeGVkIHRoZSBtZW1vcnkgbGVhayBpbiB0aGUgcG1jIGRyaXZlcg0KPiAgIC0gRHJvcHBlZCBw
YXRjaGVzIHRoYXQgYXJlIG5vIGxvbmdlciBuZWVkZWQNCj4gICAtIFBpY2tlZCB1cCBBY2tlZC1i
eSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiANCj4gVmFyc2hpbmkgUmFqZW5kcmFuICg5KToNCj4g
ICAgZHQtYmluZGluZ3M6IGF0bWVsLXNzYzogYWRkIG1pY3JvY2hpcCxzYW05eDctc3NjDQo+ICAg
IHBvd2VyOiByZXNldDogYXQ5MS1wb3dlcm9mZjogbG9va3VwIGZvciBwcm9wZXIgcG1jIGR0IG5v
ZGUgZm9yIHNhbTl4Nw0KPiAgICBwb3dlcjogcmVzZXQ6IGF0OTEtcmVzZXQ6IGFkZCByZXNldCBz
dXBwb3J0IGZvciBzYW05eDcgU29DDQo+ICAgIHBvd2VyOiByZXNldDogYXQ5MS1yZXNldDogYWRk
IHNkaHdjIHN1cHBvcnQgZm9yIHNhbTl4NyBTb0MNCj4gICAgZHQtYmluZGluZ3M6IHJlc2V0OiBh
dG1lbCxhdDkxc2FtOTI2MC1yZXNldDogYWRkIHNhbTl4Nw0KPiAgICBkdC1iaW5kaW5nczogcG93
ZXI6IHJlc2V0OiBhdG1lbCxzYW1hNWQyLXNoZHdjOiBhZGQgc2FtOXg3DQo+ICAgIEFSTTogZHRz
OiBhdDkxOiBzYW05eDc6IGFkZCBkZXZpY2UgdHJlZSBmb3IgU29DDQo+ICAgIGR0LWJpbmRpbmdz
OiBhcm06IGFkZCBzYW05eDc1IGN1cmlvc2l0eSBib2FyZA0KPiAgICBBUk06IGR0czogbWljcm9j
aGlwOiBzYW05eDc1X2N1cmlvc2l0eTogYWRkIHNhbTl4NzUgY3VyaW9zaXR5IGJvYXJkDQo+IA0K
PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwgICB8ICAgIDYg
Kw0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYXRtZWwtc3NjLnR4dCAgICB8ICAg
IDEgKw0KPiAgIC4uLi9wb3dlci9yZXNldC9hdG1lbCxzYW1hNWQyLXNoZHdjLnlhbWwgICAgICB8
ICAgIDMgKw0KPiAgIC4uLi9yZXNldC9hdG1lbCxhdDkxc2FtOTI2MC1yZXNldC55YW1sICAgICAg
ICB8ICAgIDQgKw0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9NYWtlZmlsZSAgICAg
ICAgICB8ICAgIDMgKw0KPiAgIC4uLi9kdHMvbWljcm9jaGlwL2F0OTEtc2FtOXg3NV9jdXJpb3Np
dHkuZHRzICB8ICAzMjQgKysrKysNCj4gICBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2Ft
OXg3LmR0c2kgICAgICAgfCAxMjIwICsrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9wb3dl
ci9yZXNldC9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgICAgNCArLQ0KPiAgIGRyaXZlcnMv
cG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgICAgICB8ICAgIDEgKw0KPiAgIDkgZmls
ZXMgY2hhbmdlZCwgMTU2NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYXQ5MS1zYW05eDc1X2N1
cmlvc2l0eS5kdHMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvbWlj
cm9jaGlwL3NhbTl4Ny5kdHNpDQo+IA0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNo
aW5pIFJhamVuZHJhbi4NCg0K

