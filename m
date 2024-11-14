Return-Path: <linux-pm+bounces-17531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E209C8309
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16713B2219C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BA1DF74E;
	Thu, 14 Nov 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6uN2Gq9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176B2905;
	Thu, 14 Nov 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565466; cv=fail; b=jSSNmU2AJqC2JF9GoZAOzHxrVH9TFSmioEPmQO2QcgMXYFYzuzCOt5wSuwGjkDzDI3kYZezW1idLZv2wcS8HrW3C0I2QhD4taCY5Lrgzeltuo6KvRjpFa5oelRQVnclsarkJcBnW6lTYSg+0J0k9/fHDm3oYIObKdb7epQPcpFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565466; c=relaxed/simple;
	bh=uz6tu6VPdv4p/IItgIYZdHutm2IepgVRIQoh43QR8qE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4IRW8byUT1g4gbGwOhlA8YjCHKNfYoqwk4DUc+iurqQ8xKGFgUnjESmRAOhTX2PDEY6+GV9QIBXUs2NreyU+sSsnC3dMi4yLmJfcq/AsATM5zvoLukVwWRAWSlieDcYi8u9j6u/A48/GRF+QiWcdNXVZhK9mW12kzIXebpNwVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6uN2Gq9h; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5KdvYrWlJGY/QgA1kew15avJehSpFNqb5QxKQdvfD4Iz4JRxzjDZLo6P9rJ2GgXEUcBPdqumW9Vn9xWN876wFdWPWKrgUr9BK/vdDEHe52k4MJoLMMERaCQkFINa+6Kj55Nti4oozsaqDomJZoQGF7/CIKEeRdwfw0RiaJu+ZTqeNcvuX2+3G6ISFw4mmiNpRiVfG+Xx2ZA970SbCZLI7L11NLA1mM83vMsJACgIJrcbGIIoG/V01R/OGnRvHFMahmJIZJUEWdU9lTh21P9msocr3BqWnktBLC7w0kEE/lLVh1HtUx4DV9+vt3bh4TXu/0h6zFcMsX31ikjsn7CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz6tu6VPdv4p/IItgIYZdHutm2IepgVRIQoh43QR8qE=;
 b=I1mT7avl2npXUoJtFLOgoI7X4NgMnd2zg24/LmCUEb4Z3SDMQ0gXdzjt+Wu7/pHUFsYBEw4g4pTgvRR5HMmP+e9htW6OQLjH6L9PlNGr7wy2GcsufVi8b7YkKW9p4/wAHu/Zt4muyENFVQ3u2YfvQ+IwseMpDahY2ZDclel2ALNE34HNfi8PO2TGfS0S5TUyNm+Ryb5DRZddSPTW8bJID2jJoO+gmB/+AuAyezRbmOqJRmILIB43lZOygFtdu8l9LuQL1HY3yiCHUI3PfkFUVCi62MPUYp33aTQZc1zrvVJn2nMriEI+auHiYZm6+CQklpQAjLbz0l+SdG+q8upMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz6tu6VPdv4p/IItgIYZdHutm2IepgVRIQoh43QR8qE=;
 b=6uN2Gq9h/fLrYsFOLhjhSoPmoJOrn6jAp2J/I9hTt2N/PrD1ZL/NIAsInNem5vPcoxPbq44RzNWTrmTtWgnIETc2VIWTH8A3zoHggPq7gt4pGxurIhDXcElKXIhNg3d58pyH3q2EF0T7zzkLX1hrNyMUwckci6tp6vLmP3oMogyb+AGsYzSWgrgs6avn5p8oo/PGEZrH/FIxZosEwFzHpOBc47/DGQLNIyii9YnUWS/bGYvIkhVFyb1k6EiSf3RuHro7PILWUXnNwDovy97+1dwoTvIauIqzsMfgNYf8f4kjw1qEwmrTgfxYF32qaIw1XhiZ2/q2YH7MPyz8kqHkPw==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 06:24:20 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:24:20 +0000
From: <Varshini.Rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<Mihai.Sain@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Index: AQHbGww0eNfdnuYAy0uOwjFkVwXjc7K2hZiA
Date: Thu, 14 Nov 2024 06:24:20 +0000
Message-ID: <f9dac699-b085-47fe-8efc-4c40123d0297@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|MW4PR11MB8266:EE_
x-ms-office365-filtering-correlation-id: 0ab7708c-7cf4-4e53-4b9c-08dd0474f947
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEg5Z1pOdUZyZ0JtRWROa1FvNFprd0c2SjJTdFJrcklyemt0eVFYL0t6Uld2?=
 =?utf-8?B?ckZFQTk2T0xjREpjOVVyNXhLWStTZnZEc3F1U0Z6VGRZREJYSlVMcHlZRkp6?=
 =?utf-8?B?VjJKWWZUR1VzSkhSQTNVM0FQdGwvVHBiUXVkbStnYWlBQVBxNjBvMG5FRFJS?=
 =?utf-8?B?VFZqaTFPUzJIRUVYUzdjVENMclNMUFJSakx5c0ZpM29VdlhLZ25YYU5EbUtj?=
 =?utf-8?B?QkFPWjR5NmNqWGZNVkxXYWN5Uitqelg5ZXZEQ1VIVzNoZjk4cjgzUFA2ZFRh?=
 =?utf-8?B?TVFtZ2phcm1kaW9SMm91ZDZMYmlWODVNaHliM2Y5QVVmSWVvdnkxc09OQlNp?=
 =?utf-8?B?NVliYU9ZODc2aXU1MDlaUy9Kd3V4aXErSk5wdkEySWRldzVrOFJoT1RNZm5p?=
 =?utf-8?B?ckRVYnBURS9ZTHNkTkgvd3ZWMzRPNk9IODNIMzVQcS93TzNTNUNoM2o2cGVv?=
 =?utf-8?B?Smp3bndISDVDamVDQnF2TXhiTFR5SXVlTlFMZmk3WmtycUx6OFBmcUVQYXR0?=
 =?utf-8?B?Q1pQdmpIeS9sUnNxVEwwelpyckxTVzFkeFpmOXBleWxDVnpPbHhIZ09LSERC?=
 =?utf-8?B?LzFueWRDbGR2NkNHSDJjZTdJNzZlTkIrd2pNcFllMFlnNUpOa1kwUjRGVGNn?=
 =?utf-8?B?bldOaFZHbHk2L0hxblQreUlwNnorZUdQa055NjJQRHo4MlFjMEpkc0NFaDh0?=
 =?utf-8?B?bzU3OVdNMmJVMERvcGF5VWx1cU12RGUzM0x0MTd4cU5wTk5oMkMzUllSdGdZ?=
 =?utf-8?B?NDFSN3hLbkFIZVcrblFJcnEvWDgrdTV0Rm01a0FtWEdBS3VYbHN6VHJ0T3pM?=
 =?utf-8?B?a002YjV1UDhZTjlzaW9TOWl4RGZ6N1gzRjhhN2x1QXFGUFcwdm5McUNKa3RB?=
 =?utf-8?B?VkhBMDY2WkdEcDl1QWxKQkp2VkhSVUZEZTJtYzJ5R0pVM1lPb1c0T2tnZW00?=
 =?utf-8?B?TFpVQUhmdTEySkhndW0yZERDZHlHbHpabTBFcnRSazlUMC9FdWM5OTBQb2Vh?=
 =?utf-8?B?ZmgrQW56bnl5QnZOQjF5Y1djZDczNEhReFJaMEg1S2U1NGh0MnZKelY2LzVa?=
 =?utf-8?B?c1MwejRCUjBLSjExNExVejVYNG1pelBZdlhGWEw1cUhYZDVmSG5tZG93VWw4?=
 =?utf-8?B?cFRJY3d5aDhQUllLV2xSa2twR1lFVSs4ME9IMSs1dEg4M0s0Y3FaUmdWcjBK?=
 =?utf-8?B?Y05KdFVKNUtIbFJrblNGMmE2Q1Z5eEpXMGliSHJOOTVTUVUvRU9yKzNHRnNG?=
 =?utf-8?B?VjcrSzhpTUVxRTdwWjZOOE80UzhaS0pPTE9MdXZsTVFIOHdzNlZDTWZ5UFhq?=
 =?utf-8?B?dzlkeEZIOVVIZzh5SFBpOUsxTXNUTU5jZDl5UEI1OEtMYUMzM2UrK1JDODdB?=
 =?utf-8?B?NE50T3pHZXEwRjZBMFhsaTVabEwrQVF1WWVhK3VSLzRYV0h2SHhSSzdiT2d6?=
 =?utf-8?B?aDFIMFcyZ3Nzd3FLd2s3UmlWUHNnWUtkZTdDSFZBMHFZK1J1UE8zZzZMaFpx?=
 =?utf-8?B?N1NBb1E0cDFaVnUrR2F6T0hyczlIb3Y5UzZnNlRjQUl0eEdEbFA2RWhIT202?=
 =?utf-8?B?emV5VjJMWlQxVEIyWXZ5VFFMRkhoMHNvNnhlVUJ6LzBZN1dHK3BpMXorVzBU?=
 =?utf-8?B?Tkl3NnVuRG1MVFgwT3orWUU4eEFhaHZWMGVIV3p6c3NMbU1Xc2kyY1lWczI3?=
 =?utf-8?B?MnREb3BUQ1pIa2dtbjcxS0JOMUltYjNRQ3lhV1p2cS9yODYrKzl2SG5tMTNj?=
 =?utf-8?B?QnlqUjVldU8xMjNSUng2Zk12azlRNHVQbGxHbGkySkRlT3MzaTJyQWRDWnhO?=
 =?utf-8?B?WE9vRHRiSExBdFVOV3dmdEExdjFuaUZjN05qLzlmVmJiMWROa3hneGFVY1E4?=
 =?utf-8?Q?1cUGn7pE086lM?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVlzRHBBaDFSUE5EMXRDS2xaYW5RRGRxb29pU05tL0FicWgzS1hkU2RyN0Jn?=
 =?utf-8?B?L2IxUXlFNzV1Uk9ObmlvcXNiLzREN281NjNSd1VPZWNMeUxpdGpWZGFIMnJu?=
 =?utf-8?B?ZXN4bEN3RGhSWmoxUDhDR29WYnhNVXJRMklWTlp5Z1VvRTE2ZHdXSjl3MjhF?=
 =?utf-8?B?Y0hPemJBU05TMElvMitTZ3Z3NXZ3MTZyTDRWUFBKTG1Ld01ZUjMyMHBpZkVi?=
 =?utf-8?B?NkFGaHBMTkVuTFpvQjZmN1dvUDFtZjNQUWtRM01IcXBwb2dabmRYZk1rbDdm?=
 =?utf-8?B?QmFhemIxNkk5T2pFdWJ0K3NvZlROOVVWYUZRM0NxMWl6VWg4dDdZTXloQTNx?=
 =?utf-8?B?TVpnV01LYUkxR3JLSHo1TTgzUUxRUHFKODlmZTNGQW02L0NQNXMvem5wRVpV?=
 =?utf-8?B?OVNTdFBxU290dHlVbVlZZXhhcWY3WU1WcjQwbzdqaVFRMldLUVFiT2VXelJj?=
 =?utf-8?B?Z0FlR2hjb2dzSmZ3U3B3aWRmcW5CM3pZbEgyWUNjaCtSYjFyNmVicnhMNDEw?=
 =?utf-8?B?WXRYd21QWVIvOWRUZWVneFhHRzJZeFRsQnROTGNmWGZsQ3hKbTNSdVdWTDZB?=
 =?utf-8?B?NHBJd01lMXZLWk91WHh3STFuK0V0K2tETVEvL2M4Q3JLbVBVaWJVc2s0SEky?=
 =?utf-8?B?RVFwclMxVkVjRmVsU3BFNm1jS2FaRXJIbnBZaEMvLzdDOTBaRzl0QVpNZEVQ?=
 =?utf-8?B?eitDSldpWmlQVXFSZEltb21RWGJZVFB3TXRJSGxYY3dtdU5qeFN0SFVhM0Z6?=
 =?utf-8?B?aWpMS1YrQjlVQzNMakdvME1YSTZXbHBHRm50RGl3T3MrdmpEZEVDNkNTL1M2?=
 =?utf-8?B?MFVJUXRNOHorVUgzUmo5d1BnWVZQVnNoTmZjdU1Ja2haaUdwZWl3d21RRks2?=
 =?utf-8?B?NXBsYW5Hd2xnTkFsSnJnVmx0WmdndEpDVTBmT0NKWVVQUkhzZXNlR2xtYTBr?=
 =?utf-8?B?UHlCbXVnOGI3OFpGR0I0Q0psYTFSb1dRQnRIK01OZi93dUlzZmllaFFJRHhZ?=
 =?utf-8?B?N0dhQmVHZHJJMm8rb2d1aXY3cUpJQytRamE2cHlUY05tVUhaOGZINURIZExM?=
 =?utf-8?B?VFdsY1I4aG1qUFhPcSs2K1lRaUUvd3pNM3BPa3VRbEd3cmJlcS9NY1N2WUJY?=
 =?utf-8?B?bWxGcDFiaHNaN1ZDSGJ0VWY1eE5jUjV3d2oyWG93ck9YdkVEUVc3T0Jzc0Fh?=
 =?utf-8?B?c1N6Y3U2QnpmMzFLaEdwZUxjN1h0bjZFdjNGd1h6ZDZQZTFZVlRqUFJLUmZQ?=
 =?utf-8?B?QVpsUFhEdFNld3p0M1BpRU1qVnNnaTVlMDQ2RnJhQU5UbEpGWXprMlZrYkRO?=
 =?utf-8?B?ZmZ5TzBiMUszbFhaVlNpQlJMWkplU1E2NWNFMkp4ZUFSZ3M1Z0IvRmVSN3d0?=
 =?utf-8?B?M0lsU2FHWmF5c3dVMGVvM1RNcEFLNWpLa01WWFVhcS9Xck1VOEZ6RzEvTEQ3?=
 =?utf-8?B?ZFNNdFg2VzlmdHkvajQzL0xDakFWbTJkaGFodDFJRWNlWTRLZjc4VTZ5YU5m?=
 =?utf-8?B?alRmSXBqMldQTUdZTGFoMDJld290TnMrNmdaN3hLUENjcW1STWlBWFhIWWhM?=
 =?utf-8?B?V3FVU3U0aTEzcGkvclVSb0Y5RkZVRkVLaFowVTZmdUtOZmo0RytOOVpUL2xP?=
 =?utf-8?B?bCtoalhjR1FyR0ZGL3NTWkdGeDRFUzVGR2RsZjFlcUFBek5wdVhTNXdpRG1B?=
 =?utf-8?B?eElmcHZxemtyNVhtTVN2THdKdnFEb2tzUk5pYldzdjFmcE92cVEzcDVUeW9T?=
 =?utf-8?B?MFlSTlROYzBZWVEvdm1DYzdSbmgzTUNpR1A0SVc2UnRYSHVZeTkya2ltSnJq?=
 =?utf-8?B?Zk5RVDc4UjljMGoyYlh6R3NPMzVkU3g2a0RERzBoSGNxcUhQUEdqb2l5YVlF?=
 =?utf-8?B?K0JHQlIySC84QkZuYmVVSzNjWTJ3SGp0Tzh0RWxGc2Q2QXRmWFo3WlQ0aUUy?=
 =?utf-8?B?U0lxYjFCZVU5SFlsRmJWK05qeWN0ZlRTWTNPQkErMkticC9HVHNMWi91Y1Vu?=
 =?utf-8?B?RnlPREUwNGZnTTAycjM3N1ZmQUsrRFMyVGRyVFRLNHBrYVQ2OE9ySFVMTGxs?=
 =?utf-8?B?bjZ4RFk3dkNiN0EvbHhpZkdRelVDUm54Z2xOWEUzWFVlMUp5UEROR3I3NGEy?=
 =?utf-8?B?Z3BaZEZKZmJWU2ROTnd0N3o2cWNJd3FDbGFpRS9ReWJrM0ErbFN2di84VWM0?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B85C1CCC782C14AB32F15D8D69A39C7@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab7708c-7cf4-4e53-4b9c-08dd0474f947
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:24:20.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l2wy0JsMsJvNTVsX0RKPFqUZ9ceSnsdA6p1ihRiM40QfgUCrEcflkpuw1gMoAeSjZa2lR0tp5WORbC5yAFtYb7IpRwNEHSLbgCmMk0tX4YspTfmVu4wO7o90BjRv7c5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266

SGkgQ2xhdWRpdSwgYWxsLA0KDQpUaGFua3MgZm9yIG1lcmdpbmcgdGhlIERldmljZSB0cmVlIGZp
bGVzIG9mIHRoZSBTb0MgYW5kIGJvYXJkLg0KDQpJIHdvdWxkIGxpa2UgdG8ga25vdyBpZiB0aGUg
cmVzdCBvZiB0aGUgc2VyaWVzIGNhbiBiZSBtZXJnZWQuIEFsbCB0aGUgDQpwYXRjaGVzIGhhdmUg
QWIgYW5kL29yIFJiIHRhZ3MuIExldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgb3RoZXIgDQpk
ZXBlbmRlbmNpZXMgaW4gb3JkZXIgdG8gbWVyZ2UgdGhlbS4NCg0KT24gMTAvMTAvMjQgNTozMSBw
bSwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPiBWYXJzaGluaSBSYWplbmRyYW4gKDkpOg0K
PiAgICBkdC1iaW5kaW5nczogYXRtZWwtc3NjOiBhZGQgbWljcm9jaGlwLHNhbTl4Ny1zc2MNCj4g
ICAgcG93ZXI6IHJlc2V0OiBhdDkxLXBvd2Vyb2ZmOiBsb29rdXAgZm9yIHByb3BlciBwbWMgZHQg
bm9kZSBmb3Igc2FtOXg3DQo+ICAgIHBvd2VyOiByZXNldDogYXQ5MS1yZXNldDogYWRkIHJlc2V0
IHN1cHBvcnQgZm9yIHNhbTl4NyBTb0MNCj4gICAgcG93ZXI6IHJlc2V0OiBhdDkxLXJlc2V0OiBh
ZGQgc2Rod2Mgc3VwcG9ydCBmb3Igc2FtOXg3IFNvQw0KPiAgICBkdC1iaW5kaW5nczogcmVzZXQ6
IGF0bWVsLGF0OTFzYW05MjYwLXJlc2V0OiBhZGQgc2FtOXg3DQo+ICAgIGR0LWJpbmRpbmdzOiBw
b3dlcjogcmVzZXQ6IGF0bWVsLHNhbWE1ZDItc2hkd2M6IGFkZCBzYW05eDcNCg0KLS0gDQpUaGFu
a3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4uDQoNCg==

