Return-Path: <linux-pm+bounces-6724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542348AB30C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C107A1F22385
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325A13049E;
	Fri, 19 Apr 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EjTf9Di0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302112FB24
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543211; cv=fail; b=MI88QP/O21S2YEL3PiR7nQjfgmBGhQF2vJ99T68fTBDsMJoTsE7IOWQJDaHUjKxC4CNkib9voIkAToheLxRWhjUfLZXSgK9AEtYZFfs8lU0LBHErhQ8o0+kmSh54cukxAj6pz+Ugdq0jn5xWQ1mC8s1vkAcW+zrtPixutMhmyPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543211; c=relaxed/simple;
	bh=FVcwKc7K3BU51svfUKgq5PBus4Vmu363nIxM3pj7498=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfgqOorlBs2klAglWyrpt2PblYTX8gVdxLa79D8EDH2PyqvGuEWq+Mxw4RE73ve3An6wAY6jycHYEeBeoMLVHGMC4caWvM0moLqOB2omFrSu2pBhfjRh17nvYeBoCFCAjoYxDNfnWBvQw/erVZVSXWTChrz/8Dwd0Zr2ANF3z4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EjTf9Di0; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxP8QCWiEWLTLKAYOQqlYoLgN20aB5Ri4sYU6es3X8AjmfgSu7Kme9NTI961AhmvU1A1GfmSmsIqGDQmo4psj0IWVEOkitASF8AEsNBoQaA4wEb3ayQQ4ZJAklEbrjO5uhZ+5ODpx/UxMViXeJDRmAqQLSOuF7yeZieF9Gk3SDzUWMyMyYc14ucnFg+RZ/q0JmSHtXicKZg+EbmEuTwF9+4Dag0/Fz2j53+uZuOXP6A3sh0bxnqfCEEJSR29wEhRyb7NZyiKvxuvOBwg7if/7DJlWlNUFWoam6aEqf7tuwnLvxfke1dBTfPil+v8wjf0FpPSOdibDZvtB7V8mvYnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVcwKc7K3BU51svfUKgq5PBus4Vmu363nIxM3pj7498=;
 b=EE2goBJC+X7+qUVNEKSg0QBPNcwMkAF7vwaZEu0POkkDUuqC3p25jQYe1d3c+eQIn0+rR+OXOUREU+/xvY4aF+2CzT8d53lFfhWkpv9rjxgoIAjzxLpwxFzEc/b2lrq2KnVRNf85QAJ7ttfIBzgG6C2SR/qcLTtxFFtl27r/puL17Is+9ObDeZ7qYsp3+oSVDKAcqgn2GyQtvRsx5iZWZxVuKwTHYvW+cXu0ed3jvrszYQuVvE8UCEaOfYa68qEk64YmQowQ4xzLoTgx2W8t2h8CxBk5NaK1XdbWnw1iVQlchKoIE0IM/Rzqd0ACBXayplug68hPRUw71V0sXlTJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVcwKc7K3BU51svfUKgq5PBus4Vmu363nIxM3pj7498=;
 b=EjTf9Di0Tc1Il17q8LTkB9NLApWh+kjIz+U5xclsjDLXaQdjQL4YNp1wsifUNahc/JrFpQQ22wWhWmS6snIuv5Nt93IQ7zE+KNXDsImO6tHK1y7TxfXr9eR5GNvaRyNjBJn0O7cm07kJjHNMIp1K+DNILll028pcNZlT/Egb8hk=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:13:25 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::5404:f658:2d07:451f]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::5404:f658:2d07:451f%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:13:25 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Huang, Ray" <Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
Thread-Topic: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
Thread-Index: AQHaklWBH45X0FQ9VUSP0bWK7WzAK7Fvwdcw
Date: Fri, 19 Apr 2024 16:13:24 +0000
Message-ID:
 <DM4PR12MB5136C2314DDEA0C7A20C4E5FF10D2@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
In-Reply-To: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=21b75fd8-9b73-4292-b0dd-a0ecf55401d8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-19T16:04:27Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|DS7PR12MB8203:EE_
x-ms-office365-filtering-correlation-id: c4fd5a02-da28-458e-8108-08dc608ba420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VfmzMnsImq9B/2TecXFSMDipw9h7cPxPj6cG4saJrvTSiD26xPZvRyYAyLvxwwNY/DuGtuS1khgdRRaKM7jxT5BNb9a53w8mB/936THcI7HNLP0bw2CqGKBwSjwJHWmRuVxI6zkiwgXeGt99dVuAUUQrGoMx0UEiNXznEr2uRjGMofc/dckMdbyB0zC2VRn9PJsq+/GOaK+x6qvDcIq1++4TsaaJfJlcLgUpRenXnUJRYWxoKtQNsWaUSGrNX0FFfi87p+wJht57EfBJLDLcTkE5hhrLJCXArEtQi3nThMuZOP5GkkqhBTbMTTX6CGayNZKPaUye61eaRpYXaRNuw0yCoiymj5KXV+tyDpDyfOtnTZ4MaidmQ+HEs4fyy6fRlpJ5mYzA+tzIbgfnAY73eIyF+z8C+YPE6+EveNIEgdsndJu1iuibr4g1ULRullb3QNDYGrppZCl5pNBR9MfNHKvYyxIj6HD9F5yvyHKk/dz80GAV/XjaqOoyICZ9sws4zkMVET42hFITfJUKS01UDvxEXJ9klL/LfLgWr4TSIl0OPIrq7rX0k19vzByiNKFEyglZsaZE5edrLX5CE9KR3zE30wOGa+Z86TDMUoro/RyQXSZhFZByDShEzDw2BrwZd+zaAji9zw41R6Nu7Mm4N1wxi8W3eZEx1XLWQF7ow0WIKfvtpSW/J2ZQo+WO3zvjmUEp16shpuAUtuySZKfBSjuFNVqk+BwEUk/z+AOQKhs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1kzNG5xVG9tWTRXZDZ6SUc4cFhNUnRYTGxXTGN0bW5uakZrbWZWT1dEZFA1?=
 =?utf-8?B?dmVFcURSTUFZVm1sb29FWFl0MEsybEhMZ2FIY3hqVGVUTmVibGk4YmUybGlN?=
 =?utf-8?B?aXJ4MkJoL0ZWWGkxeFNHMmcrdFNOV0ppdkd3RWRkcnpUT3dqL0NYMnRTd0xL?=
 =?utf-8?B?VnFaSjlwYlhGc2p0Yk5WOFlORnh2L2QwZ0N5RmNJbm8wTTErR3NycnczZkRk?=
 =?utf-8?B?Nkc0b3crSGhLVWhCeDYyTE5CY204UTR5NWRXdElvZ3R2TVVRMTZKODdLMVIx?=
 =?utf-8?B?aDhKYldTRFpEWXl6bHZ4RnV2cGJRUlA0cVFmY1ZiQXhoNTFmM0pUZ2xEbkwy?=
 =?utf-8?B?TmZPbWtQMGJnbkpoTlZRcVZOam1ObCsyZnJvOUpTazR1YTNsK2hoRlVaSnV3?=
 =?utf-8?B?anhpN1BxRUtEYUZBeGpqOG5rRVAwQkZPUkk1Ui9BVlRrRGp1dk5qcnp2aFZv?=
 =?utf-8?B?S24zejEwTDY1WlpQSlVZWjRFR0RZaXJlRlFDRG9ucU90cjhPTmJ2eXJNQ21o?=
 =?utf-8?B?ZThyRE9udVo2KzZ3VUxyRVJZbE5mNm9nd2FTN3Z0QUdPN1I1azkxUGxsUTNS?=
 =?utf-8?B?UDluU0NibjVDL1hKbSszNEtweHJueTJGVHpzS0ExK1VqUXNydk0veE5sQm1o?=
 =?utf-8?B?V0lnUUJqM2NYUkxXUG5WbmVUaTVaOUc0dkpud1Examo2clBaeDJKT0ZFTWFi?=
 =?utf-8?B?ZHRzYnBFbnhnVktSbXVUbGJSMVB5bldoM0RlRVNMUnNtL09jd04yU0lIVk1u?=
 =?utf-8?B?ekprbE9XbTcrVkR1Mi9CbWhhR3VOek5LNTZsVVU4NnB0Q3V2cFdVUkJPazI2?=
 =?utf-8?B?UGg2TDN2YmFIY0lhY3Rqa1oyV2hnd0tRYUM1SDhiU1AxSjBmWnFKOXlucnJy?=
 =?utf-8?B?VEs2TjV3ZlJiV3VsVGtqVEo4cCtmR0djOGxlWm9tN1NoeTc3VE05cWFXUmNS?=
 =?utf-8?B?Tkd6MDBVQlJSV1pXMi9xa0RIS202cHpzcVZNOUhCNEU2MGFoVGowdFFQWTds?=
 =?utf-8?B?dU10TEZCWjRsUzJzYlcxVHRIL3Q4R00vRkZ0azBFRWROR0NzeC9JUjZITDJH?=
 =?utf-8?B?bm4xS0VDTk9CZ0pnUWJRVmdxMDVaVFk2RUU5VE1vWHlYbHFSalBKNndQbzh6?=
 =?utf-8?B?WE5jOGxNYjk2THpJYnEwejI1TGRhV1NkcWpiWStFMStjREppclpJWjZSWEl2?=
 =?utf-8?B?N1Rmc3hYNG9pcUxha241L1A0dUh3S2xhVmovQzhiMm1ndVVqZmx2dXZwMzFa?=
 =?utf-8?B?cTY0TEswSkVBZWsvYW9vajE5Qkh1R1hjZVgzNjJwdE1DbGFFckM1V3YrclJW?=
 =?utf-8?B?R1V4WUljeGwrclpmK0orR1AxTHFqdHE3L1JKTUtNaG5QbFZqMTdHNmt2Q1Jv?=
 =?utf-8?B?SlR2K0g1cEZVNFA0a00vZTFsNzE0RDJHYTJKaGVZQXA2eVhEVTNrTDFJQS9I?=
 =?utf-8?B?SktubGE2VFljZEpVQ3l1YXA5dnovOUVlWDRlbjlEbEJBSEJYaDNVckt2a0Yz?=
 =?utf-8?B?ZzcyQTNmTlVEb0xXbGJKR0N1OGcwV1kvUXhGMjNUby9Vci9sbllaWE04L1Ir?=
 =?utf-8?B?WkMrRWpjaGpteXBxVTJEUXFwMVZjams5UEZuSG5TQ3lTMzZqMXFaNjJVdUhO?=
 =?utf-8?B?SndmQU9mamZYZEhFQjRicmdaazQ4WktvcXhTMjdFbE1seHZHMHFPVXdUQ2F3?=
 =?utf-8?B?c29UeUxhYUc2VFBLZ1ZkSU9VeHpmdURNRFoxdHgyR0N3enluaVBlNjBONGRB?=
 =?utf-8?B?SEtQamJIMFl4UHIvQldOb2orTGxVYnFKcTZlSnI3SmhVdHQwbWlVSlpxN3Vm?=
 =?utf-8?B?a0w1T3Z4MG4zdEhQbE04OHFweml6STFoTkdRL0pMTFgzQ2FZRW1Ec29nc2xM?=
 =?utf-8?B?QTlTUnVnbmdLU3Y3WU50Q1ZDTEIxaFEyTkVFZmNZVFV5b0c3V1JTNnJSVTNo?=
 =?utf-8?B?S3p5NXRJSXRiY2pic3lOZUxEWVNRWGVrMEZBYXp5bXQvRUQ1MVBxc2h6QVFT?=
 =?utf-8?B?VzIrOVVFVUVEVGRSRndVQ1VKcW0yTUUyTEU2K3FNQmNpQ0hLcXlmY3p4b1pB?=
 =?utf-8?B?TXdlbjZYQkc5MUtjMDNTcnp5c005Y2tHTlhkUWdQdHk3UWVpRWFqM0o2R1JW?=
 =?utf-8?Q?OJPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fd5a02-da28-458e-8108-08dc608ba420
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 16:13:24.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99ixlvMGisYR39Fzzr3vuJ+Vlr3o3s02c+Jpsz+w4PS0i9Bukn6BpQdKbY7Dg4eMy0rlAxKzRLTlTTQj+uozXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldvdWxkIHlvdSB0cnkgdG8gY2hl
Y2sgdGhlIGNwcGMgIGZsYWc/DQoibHNjcHUgfCBncmVwIGNwcGMiDQoNCkFuZCBSeXplbjUgUHJv
IDE1MDAgaXMgdGhlIGZpcnN0IGdlbiBaRU4gYXJjaCwgYXMgSSBrbm93LCBpdCBkb2Vzbid0IHN1
cHBvcnQgQ1BDUCBmdW5jdGlvbi4NCg0KVGhhbmtzLA0KWGlhb2ppYW4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQpTZW50OiBGcmlkYXksIEFwcmlsIDE5LCAyMDI0IDg6MzEgUE0NClRvOiBIdWFuZywgUmF5IDxS
YXkuSHVhbmdAYW1kLmNvbT4NCkNjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFdhcm5pbmcgYGFtZF9wc3RhdGU6IHRoZSBfQ1BDIG9iamVjdCBpcyBub3QgcHJlc2VudCBpbiBT
QklPUyBvciBBQ1BJIGRpc2FibGVkYA0KDQpEZWFyIExpbnV4IGZvbGtzLA0KDQoNCk9uIGEgRGVs
bCBPcHRpUGxleCA1MDU1IHdpdGggQU1EIFJ5emVuIDUgUFJPIDE1MDAgUXVhZC1Db3JlIFByb2Nl
c3Nvcg0KDQogICAgICQgZG1lc2cgfCBncmVwIC1lICJETUk6IiAtZSAiTGludXggdmVyc2lvbiIg
LWUgbWljcm9jb2RlDQogICAgIFsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi45LjAtcmM0
Lm14NjQuNDYxLTAwMDQ1LWc2Yzk1YTlmNDYwMjQNCih4QGhvbGlkYXlpbmNhbWJvZGlhLm1vbGdl
bi5tcGcuZGUpIChnY2MgKEdDQykgMTIuMy4wLCBHTlUgbGQgKEdOVQ0KQmludXRpbHMpIDIuNDEp
ICMxNyBTTVAgUFJFRU1QVF9EWU5BTUlDIFRodSBBcHIgMTggMTI6MTA6MTcgQ0VTVCAyMDI0DQog
ICAgIFsgICAgMC4wMDAwMDBdIERNSTogRGVsbCBJbmMuIE9wdGlQbGV4IDUwNTUgUnl6ZW4gQ1BV
LzBQMDNEWCwgQklPUw0KMS4xMi4wIDAzLzAzLzIwMjQNCiAgICAgWyAgICAzLjU2MjM0OV0gbWlj
cm9jb2RlOiBDdXJyZW50IHJldmlzaW9uOiAweDA4MDAxMTM3DQoNCmV2ZW4gd2l0aCB0aGUgbGF0
ZXN0IHN5c3RlbSBmaXJtd2FyZSAxLjEyLjAgWzFdLCBMaW51eCB3YXJuczoNCg0KICAgICAkIGRt
ZXNnIC0tbGV2ZWwgYWxlcnQsY3JpdCxlcnIsd2Fybg0KICAgICBbICAgIDMuNTA2MTk3XSBhbWRf
cHN0YXRlOiB0aGUgX0NQQyBvYmplY3QgaXMgbm90IHByZXNlbnQgaW4gU0JJT1MNCm9yIEFDUEkg
ZGlzYWJsZWQNCiAgICAgWyAgICA1LjE1Mjg0MF0geGZzIGZpbGVzeXN0ZW0gYmVpbmcgcmVtb3Vu
dGVkIGF0IC8gc3VwcG9ydHMNCnRpbWVzdGFtcHMgdW50aWwgMjAzOC0wMS0xOSAoMHg3ZmZmZmZm
ZikNCiAgICAgWyAgICA1LjM0MDY1M10gd21pX2J1cyB3bWlfYnVzLVBOUDBDMTQ6MDA6IFtGaXJt
d2FyZSBCdWddOiBXUUJDDQpkYXRhIGJsb2NrIHF1ZXJ5IGNvbnRyb2wgbWV0aG9kIG5vdCBmb3Vu
ZA0KICAgICBbICAgIDcuODkxNDU5XSBrZmQga2ZkOiBhbWRncHU6IFZFUkRFICBub3Qgc3VwcG9y
dGVkIGluIGtmZA0KICAgICBbICAgMTIuMDMyODk0XSB4ZnMgZmlsZXN5c3RlbSBiZWluZyBtb3Vu
dGVkIGF0IC9hbWQvaHlwbm90b2FkLzANCnN1cHBvcnRzIHRpbWVzdGFtcHMgdW50aWwgMjAzOC0w
MS0xOSAoMHg3ZmZmZmZmZikNCiAgICAgWyAgIDEzLjI4MzU0NV0gTkZTRDogVW5hYmxlIHRvIGlu
aXRpYWxpemUgY2xpZW50IHJlY292ZXJ5IHRyYWNraW5nIQ0KKC0xMTApDQoNCldoYXQgY2FuIEkg
ZG8gYWJvdXQgdGhlIHdhcm5pbmc/DQoNCg0KS2luZCByZWdhcmRzLA0KDQpQYXVsDQoNCg0KWzFd
Og0KaHR0cHM6Ly9kbC5kZWxsLmNvbS9GT0xERVIxMTMyODcxMk0vMS9PcHRpUGxleF81MDU1X1J5
emVuX0NQVV8xLjEyLjAuZXhlDQoNCmRvd25sb2FkIHdpdGgNCg0KICAgICB3Z2V0IC0tdXNlci1h
Z2VudD0iTW96aWxsYS81LjAgKFgxMTsgRmVkb3JhOyBMaW51eCB4ODZfNjQ7IHJ2OjUyLjApDQpH
ZWNrby8yMDEwMDEwMSBGaXJlZm94LzUyLjAiDQpodHRwczovL2RsLmRlbGwuY29tL0ZPTERFUjEx
MzI4NzEyTS8xL09wdGlQbGV4XzUwNTVfUnl6ZW5fQ1BVXzEuMTIuMC5leGUNCg0K

