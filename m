Return-Path: <linux-pm+bounces-36479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3134BF28AD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A0EF34D191
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6CB33290F;
	Mon, 20 Oct 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CbM0aGT/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RApF0DCE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E583321D0
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979133; cv=fail; b=eDfb0FNJwS6fsNspwGsgayWLl8CGnWu7e7xIlAgptJwc94HMHDYZ/wHhrUgEQ4h6cDc/jTIlQuCXBut73zFHVk1X5CsRqHtIiOCJ5BOrzc4+ExNxs/5SDfLgFjFzlfZYdAriReNPaVZ01Aj/8JX8XsVlHnu3PC451bFa21pTkG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979133; c=relaxed/simple;
	bh=5jrNUtKscU+07+MhrikgFd2D1v/tZxF6jMOeiG0x8HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1AevRRmD9EbHpaADudSsZB89sh21lVcwxOPuv923/anqYYCCKgX3wVG6yjVfmZrm4zXrd7s81jBmmdx8xupyMh7+BqXBfvHY2y03UgTf6DmulYurjfo/vPt5JlmaDpA910F0/KiXQrUUYPsQ4hk3m/ReO6NKUTzEQLZDCGXy/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=CbM0aGT/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RApF0DCE; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KCopia1834433;
	Mon, 20 Oct 2025 09:52:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=5jrNUtKscU+07+MhrikgFd2D1v/tZxF6jMOeiG0x8
	HA=; b=CbM0aGT/tFTZg7Spjgp3WVcyb2DTOULB6/c6n2XMdU7a0oJFJ+KgOnVuA
	RV63EtPXu8av59GW88OvpdTrl1WztUePfyS8P6R9rz7aOgD5uB5XFolFYxDYDfRA
	MS9a53+m9T18VMwiHQ+hcnDoNzL/n74a/+8kLqyumUub6SlDqjMjZjXT1JzAfgBt
	LnB4r9vC6k/XJlSrIvk9PdksGtDBv1yITfxNBSdDq+eKPk+PJgXl1phLjc4AlGkw
	h2F6CPSX6q5gaJQ0wc8pp6yDbdWI+OX+HE131q27SpkCwR30rG478V71q5BK+PxU
	4mrpcvGkro/ZRaZ+HvUy81CxC+QrA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021139.outbound.protection.outlook.com [52.101.52.139])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49vaevbh57-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LemIlg1kbP+yb4mIGpnZ+0rbDSu+dKfpyYuUtZhiD/92wCn6KV7X5CFMzJHMtkphGVPEyj43TbjmWIddPQn0RvAPFItFuiBKke6KsikfuhWW95fqFsfutd0imgQMJH41zBN+l2o4NVKS9MNT2qNssxF1vIZSUpyjF2K10+HDlwZuLTql9NjR9ybbQOmPloegs7badfoQalHNX/q7Q3nSDCv9/9Q/gZ4vx0C3ntdWdBR3qRqqjH2j/vxzTsvk1a44mDxLrl8D4Jh6q6FwugTRugv44OWsjMQD7rL31fsljept9nEctZHkwT1PLPHzy9BBKukkTfSPTdqTx9Wainf09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jrNUtKscU+07+MhrikgFd2D1v/tZxF6jMOeiG0x8HA=;
 b=QZr0C/FIbONoFLWlieBoWK0Sy2i97yNra91zR+JAFYgL9tTBJvwDwau1uyaoZJ12Ydo2m0nOubcRKZlIPv1gFsmi4QJxdbnnIlgS5z/CEr20EXar/OnZSMFv5zzr+h43hLMe8ppYWcXIA/9q0RsAxJtGZBWGJzZ71/HIWZ0US2EoejpXjTwKqI+Q7hXYBXQQAKZ9Yll7E2pBtG2AFDyI1ECjlapcSlW8M9bcOYOfsjBXjcLnZybViIeMAU1wMy2DK+hse5NL6V2XpM78UcKRBPcTuwdeWIlncTYanbCSgECbjK8E8O9+AEAKPJRazP/lJ6V4GoeladWhBl9CHHmzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jrNUtKscU+07+MhrikgFd2D1v/tZxF6jMOeiG0x8HA=;
 b=RApF0DCEzb+Vh3PE4gYgNmgZ8Y7Lgb6tR8WAjmYjFCqIgN5ckv2w2GW0QZOvd9UmlYXbLPvInYNvuomYlvmWOAbH64QXSOmfH1aCDAT4/gs558WOUlIuGnWO/emO0GlDWXOEZcnuo8naVVB+lZ1cC8IuamL0aPIL0l0exWYXaPAbq7yZ94OwCmX31Rfs32JcibWceq8YuPC/HGjimb0/NeCsUeNFA83oOyIEq2Z3QEWG4IQwTHzluWJAsesGb6wqdVZXEVkYzAQZ/NsKUEijbl6wXp5xaAxWZHPv/28+YPZzbX+6Wk+z7JpO4RdggIIsMnpuEdzKEVOMHIb+aWqrGw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9615.namprd02.prod.outlook.com
 (2603:10b6:208:3f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:52:03 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:52:02 +0000
From: Jon Kohler <jon@nutanix.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
Thread-Topic: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
Thread-Index: AQHcQeHbox2ytuUuKk2TqR7c+97Tyw==
Date: Mon, 20 Oct 2025 16:52:02 +0000
Message-ID: <2D60A950-95E4-496E-9E25-3928E9D22B7B@nutanix.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
In-Reply-To: <20230710093100.918337-1-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|IA1PR02MB9615:EE_
x-ms-office365-filtering-correlation-id: 47dcd9db-6f2f-41e6-9600-08de0ff8fe80
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVN5UU1yTVZrUVFNL2hDZkM4K0JiYXl3dDJvUk1PcURUYld4Y3RLK1AxQlR6?=
 =?utf-8?B?bkJoRlhhcnNwdzRZT2RHZmpibysvYmxzaFFFejRQRjZqN0dxSEx1NUxBbTFE?=
 =?utf-8?B?b3R6M2FoMCthdkw1K1ByYVFDVU9nT3pKQjZ3TlJFZlF3bjUrRXdyRVkvRms0?=
 =?utf-8?B?Vk9KWGExWlVvRXMzVXQ3K0IwWCtma2VQS0dDOE1KTzgvbnJIdVI4Z3R6L2ti?=
 =?utf-8?B?R25Md0RkYUtZY2tNem1yaVdkTG5YWVlBNndBT1pnY2NJckh6Zk1iQUhzYUxt?=
 =?utf-8?B?MDdzTzN0REdMMXVwNElUUVVNeGRZaDRXYjNWNDcyTnNBY0hDVDNYZitwWlhi?=
 =?utf-8?B?TDlQbCtQZDZTam9HMEYzYjFGdUpoRmQramZsMnBuZGhiNkhOVkpRQlYrbUdT?=
 =?utf-8?B?TVRicVkrYS9ibFlybTBLMDFIL2cyTEF1bm44N1k2UHdtcDE0Sy9PaThtSS93?=
 =?utf-8?B?SGFTNTIvNHBudnZGQVBZa0N4Ny9IM3NsVnZDWGJhTUhPZXBwWExDOHJLcTk0?=
 =?utf-8?B?L25tNVFQaEhnUXNEVDBXMGlNbHM0RUpKL0hVM09Gc0k2MkVjcnRRbnVJOFJz?=
 =?utf-8?B?Yk1Cb1QvdWdaR1dTd2dTVnllV0pYTVQwTlFCQ2xmaU9kaGtjSGMwczdkaUJw?=
 =?utf-8?B?cHg1SlFGUTFxM2lNOGlwRlZVTUhyM3VIRXRTU3ZlZVduSWx1QU5oK2t4R1NI?=
 =?utf-8?B?dHlBaWI1VlJWM1BYdmRBaDNmWHBUdGtlRWJ1ZHlHUVhqZUltdWtldGVDMmlo?=
 =?utf-8?B?YlNrY1llbDh2eUNCV2pYa01XUjZSMFhUT2NUOE5ac2tBUmpKMHNrdjczditD?=
 =?utf-8?B?SlhhUVNwZW9nWE91OEt5ejdsclk1QllpdlFUWHlFWmxhdUFENE9paEgzSkI0?=
 =?utf-8?B?bnRrS05yN1M2SVo4dEZpWWRoNFdPRXB5NjRtVWIzVHZHSFBPaTNxZmxhK2Vv?=
 =?utf-8?B?aTFlL1lrZ0p0QUJnVUJIVDBwdHBnWXdMTVJFb0tGRGxkbCt6NmFXTko0a29V?=
 =?utf-8?B?bmh2UVNQWFRpZk5mNUNMRTN4SDJiV05TUUZDUkk2dlFyYUEzR3o0YVc5Nkd0?=
 =?utf-8?B?R1ZlWGZPRG1RSXg2UHN4WUF5TVVXcmVwQUVMUlY0Y1daRE40KzVUSDFUSk95?=
 =?utf-8?B?b0Q2Mll2eUIvUjYvek01YjdCUGw4OW9uNDV2dmdqRHZoQXN5WGNsd1FIcW9C?=
 =?utf-8?B?bDRSK000NHV2ZlB5UnJQOGRqSm1jVHh2ckhxMEE2N1hMTHRpMnVyVjRzZWRN?=
 =?utf-8?B?d2x5MmtENituNVovOTF6aGgxWUhsNmFyZ05yMkVhbTVrS0RLR2FQc0JvOVBy?=
 =?utf-8?B?eW16TXluSGc5MDMvZjVLU1lzeVF0eTdQMGVmZlZNbjY0b2hHYlljcHc0UDZl?=
 =?utf-8?B?U01wY3ArMTFIYjd0MER1dU1CTmpZNWZvQjFqakJaWmhFa1gzUVlDQ1AxQVR3?=
 =?utf-8?B?ck9hYW9obFk2dE9Xb2pXWmp2bnpQZ2t5WCtMVW9vcHdSMWdBdGY5ZTVuVDB5?=
 =?utf-8?B?Qmozcm9CYlhLU1dHYVNNMU5RbUw0R21yR2RwN1BWVHRiU01MLzVvU295M3Z5?=
 =?utf-8?B?ZWlndG5tcmRQNWFzMGVDQ3JFN1BmN3F2aE9leDlYNm1xekVzNmovamFtV0hT?=
 =?utf-8?B?ak1Ic1U3STNDYzludTl0dVpEWGE3dDFVUmVqbXZmZVFpUGN5VkEwWmJyeml6?=
 =?utf-8?B?SHA3bmZjRkcxeGtQM0tySC9LWitMYlNwckF0cHpyYWI4R0xhbWVGU1JWcEx4?=
 =?utf-8?B?V0tXVVFlbnBiVVRlbzBIemkrckpKWnRQdmFzQkFwU1ZqWjhaSEpxS0NXS3RL?=
 =?utf-8?B?ZXdsaWV5Z2ltTzltQXJuUkVjUU9hVXhEMTBoYWhpWFYvVVdjSER5VWYrRm4v?=
 =?utf-8?B?dytOamFRZ2tuOXFQdzMyRkxnOWVtWG9PWWMzT2FhcnZURHcraENDUWw0Kzlj?=
 =?utf-8?B?UHdsdjlzSzBUOTc5TDJUTHYzNXBjZEJMRzc0WjFHbStuWmxtTVVsaHhpeWRO?=
 =?utf-8?B?dkhUeU1JNExTdUdqV3JQalhjcENxN2pyb00rVjJBalMzQ1pVZkxUczF6eEIv?=
 =?utf-8?Q?fv4qzE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VllJa2lIcDJ4OHp2aGV2OUhSR1Z5ZW9jRUFhREs2cXRSdHF4NWliTEROeXdt?=
 =?utf-8?B?OEo5QytLWmJoSFNXVG9xUU92U2NCTjlkV1lNUEhybGUya0pZSGRxZFozK29V?=
 =?utf-8?B?U3Q4Z1JZN3FENXRQVTUvbzkwTkJhUTVuVkx6NkZWcjl3SUVVcFNJZGRFd1JV?=
 =?utf-8?B?Tnc4VWdSdFJvS2p3UHp2NmliZDJ2azdZVHhVMlBFTlAvMmxDdm00NU1jTkRx?=
 =?utf-8?B?VytFMjdjN3AxeEprcmpxVElLdDdsS2R6QUNVcDNZUk0xYjlFckxqWjZ4QVlI?=
 =?utf-8?B?MUI1TVRMQUR3M2l3QXQxRU4veFBlTlJyK3F3bjAxdjF4UFNaZnNvbWJMKzg0?=
 =?utf-8?B?NDhBK1VuVFlhd0FwaFVZUlJzdm1kOHJUcnZoNmI2K2p0NFlUUjB6Um1mV0pJ?=
 =?utf-8?B?azVVeXV3YjZqeE9SK0FSTGFZdnFRTEtuU0VYRW90UzhWOG5KbkdoOWRIM1Na?=
 =?utf-8?B?Rm1xUGVhZmF2MCt3YS9Jc09ISEVsc0E2eHk5bHE1c2l2K2M2M2tRVUJMRE9Y?=
 =?utf-8?B?L0hZNG5XTnRsbXdqNkpybHBTa0ZWSDVDWHdHeGIyb2xnTnh6b1BVV0M2WmFm?=
 =?utf-8?B?YVE4bGFDRTRUL0JLY2ZyaDF3dXpGYW9ZeUVUaTJWM1hDdFBudmFBN2l1VTE0?=
 =?utf-8?B?YlFaOExNa3d4RjdEL0F1T3o3Sk1RTzJLK014RXNJVWRmNFMrSDkrUWNZMmp1?=
 =?utf-8?B?MllQcnBwT1ZjTWcvMEQzSVVhNmE1VkttVW5odVZDajhDWjQzczAvMElMMkNO?=
 =?utf-8?B?azJlN1FLRUtWTGdVeG9YOGVjVW03elcrYnFVVmhQV3V6b0FQYnIrYzYwcHJw?=
 =?utf-8?B?MXFyYXNpNkVDcmhUemVySEVydTFWQTZIWUwvWlNjcU9VNXRVT1d0TnVualZu?=
 =?utf-8?B?OVhLQXl0U3lyWC9VY1lVMVFMclRYVHBiVzBqdFVidk9lSkhkZ29sTVJXdjFJ?=
 =?utf-8?B?OUJGT3dTZWxoOTluamZTVGQzeEtmM3lpZHl0dU5xY1NEcUVlV1RpeVBvTXRI?=
 =?utf-8?B?SEphRStybTVHTHJML3FCZ2Jrbnkza3JzM2ljK3I0NmJWTHZzenFvL0dhRXMy?=
 =?utf-8?B?UC9oT2t1VXJoUUVIbklKMnlKZFpvNXMzYUlYSUJkNFBrZktWODlPZ1ArN2FU?=
 =?utf-8?B?cktGUThKd0FlTll2b1lkVzJsbXdEamcrM3FWMTJadStTUXNuT29lcnlFZWxh?=
 =?utf-8?B?cHpnVHQ5djVQL0ZNdUVua3NlVklnbHZkTWpqMlR2bGYvYTFEaW1qakNYb3N3?=
 =?utf-8?B?cVdVcEZCaVJBUUZHclM4Z05VU09tYVVCdHdNQjA3djhFRk9JNmk1UlJ4cGti?=
 =?utf-8?B?Y3Q3S1ViSGFjWHFzSjE0SmF0NWNqWEZGSk51QkNoVWZ3a3NYVVZ4ZzI0K2Fk?=
 =?utf-8?B?REc2YzRQVlNHejBySmpvQitEU09kZkFROG9lb2k3MTJRKzhtNmV2aVhrb2Mx?=
 =?utf-8?B?eW9sQTg3QkgrL2Zvbm9JcmFwVXBuNHkzanp5Y1k4TUM1Q2RaNmRDM0duWXdJ?=
 =?utf-8?B?SmJuc3dFcUFEamx2VXRuODQrRHpkd3l0YzhlMzZraisrRFpEVy9IUmxVM2Rp?=
 =?utf-8?B?VE4wT0tSWWhJQjdzOU5zVVNqVmpKcVI4dDh5VmtKckRHYlpmNmU2SlRJbjNi?=
 =?utf-8?B?MU04dGhxZGxoZ2g0YTBMTEY0L04zb2FGcjVrdVFZUUhzMi9IQ0gvenRTWVEr?=
 =?utf-8?B?dFFMYVB6VElTemhEVW93aEJETWdXWHdsRGFIb21BODNQWFdVWEhMYzZwOFNt?=
 =?utf-8?B?eVZqbVJtdXh3Zmhmb1hkWTdTaUtzU1NteFB6L1NnWnZ3Y0hEVDE3L3Jkb2tv?=
 =?utf-8?B?TlM1bjZXM25uT3FpL1JWNFpJa1ZuZUNKUStlWE9kRlo1eXNNcGdndHJGRmox?=
 =?utf-8?B?QmRXU2lkWTdnZ0htMDZNTXZseW8wRkh6WE9pS2VML2ZSOC91ZEQzZmkvQWFM?=
 =?utf-8?B?WHpRbzBKejFqa0NqRWxyT2hjbDF5MEtHWTVLeHBZanpIaFVSblFyQW5Ramty?=
 =?utf-8?B?UW13bVB2RDYwZVlGNGp3MVl6VVRoUFdPQ1ArbW4xeU1QM0lQRkpuaEVORUZU?=
 =?utf-8?B?aXhmL2NoRXk3UWNFQ3FiMllNRkZoR1VDQnNjMWJTaTBMVGVrUVNmRWNVNllD?=
 =?utf-8?B?ZWNrb29HWmpOWVQrS1lXcW5wa2w3MmVCd282RU9vN0hzS2JEa1JycW1DaDVP?=
 =?utf-8?B?UURjUEZla0xYZm1TZ0MrRmtDTEY5TFQwSTRpek1MQ2tYelBXd3RCYjVkZm5J?=
 =?utf-8?B?QWZCdFFOOEwvRnlrOFgwdG5uSitRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F41F586665D8F4FA2046641A861DCE4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dcd9db-6f2f-41e6-9600-08de0ff8fe80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 16:52:02.9241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxLj4oaggsEhUqXfm5DtoQTcXvoSYtZNKeHP6PzoKPkd5gUfBfsQ+8IJLyjU5Dv2d5zv9JntGcRPk2eqXP9Tb24NxZXJkS64tgKJAG4FoWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9615
X-Proofpoint-ORIG-GUID: 7bQ4RIMjR6jYcBPp6u1hzBtYcghr7nAa
X-Proofpoint-GUID: 7bQ4RIMjR6jYcBPp6u1hzBtYcghr7nAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEzOSBTYWx0ZWRfX8p302jW7M2jb
 v3GGcb7OloAvAMBQMu3W18rpEcAHSiOq2h/kB5VgVdit3HK+d63BGj83kS8eSx5pzIeLjNZkAFS
 B0lZckz20Mnhfhvqqh3pcP2lFBEz+5KebSzeRF1MVdbgXd8OQ9bZmtHM60mITF5ajN+t9pu71sD
 1+suYjJLwmCpjC+KNLWXECjjxojqnYy5Q7rFcY/iPthxeVjO5cZ/OmCgboqmLTkxN7M9DOSXStl
 VuoimOii0L7Nvmxv9n999x5k4AVdHFGZwBiXfP4kkgSsuq0X6QDGuX1Hgh/7Odrd81hrizOLvc8
 EN1qVUFYdTiczySWNqW9pkI+5eGprKPGoRintBWmFr3QzjeIaNJaY7nPLg4BE+/2sBsdZnAFibW
 U74gOb8dgI0Q32Q0NQjEQ99ZO7inUw==
X-Authority-Analysis: v=2.4 cv=Fs0IPmrq c=1 sm=1 tr=0 ts=68f668b6 cx=c_pps
 a=Wom93TYtTqcYiR1jdFbvTQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Za15VTt6e7-RNbSm0GMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVsIDEwLCAyMDIzLCBhdCA1OjMw4oCvQU0sIEFydGVtIEJpdHl1dHNraXkgPGRl
ZGVraW5kMUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gRnJvbTogQXJ0ZW0gQml0eXV0c2tpeSA8
YXJ0ZW0uYml0eXV0c2tpeUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBCYWNrZ3JvdW5kDQo+IC0t
LS0tLS0tLS0NCj4gDQo+IElkbGUgc3RhdGVzIHJlZHVjZSBwb3dlciBjb25zdW1wdGlvbiB3aGVu
IGEgQ1BVIGhhcyBubyB3b3JrIHRvIGRvLiBUaGUgbW9zdA0KPiBzaGFsbG93IENQVSBpZGxlIHN0
YXRlIGlzICJQT0xMIi4gSXQgaGFzIGxvd2VzdCB3YWtlIHVwIGxhdGVuY3ksIGJ1dCBzYXZlcw0K
PiBsaXR0bGUgcG93ZXIuIFRoZSBuZXh0IGlkbGUgc3RhdGUgb24gSW50ZWwgcGxhdGZvcm1zIGlz
ICJDMSIuIEl0IGhhcyBoYXMgaGlnaGVyDQo+IGxhdGVuY3ksIGJ1dCBzYXZlcyBtb3JlIHBvd2Vy
IHRoYW4gIlBPTEwiLg0KPiANCj4gU2FwcGhpcmUgUmFwaWRzIFhlb25zIGFkZCBuZXcgQzAuMSBh
bmQgQzAuMiAobGF0ZXIgQzAueCkgaWRsZSBzdGF0ZXMgd2hpY2gNCj4gY29uY2VwdHVhbGx5IHNp
dCBiZXR3ZWVuICJQT0xMIiBhbmQgIkMxIi4gVGhlc2UgcHJvdmlkZSBhIHZlcnkgYXR0cmFjdGl2
ZQ0KPiBtaWRwb2ludDogbmVhci1QT0xMIHdha2UtdXAgbGF0ZW5jeSBhbmQgcG93ZXIgY29uc3Vt
cHRpb24gaGFsZndheSBiZXR3ZWVuDQo+ICJQT0xMIiBhbmQgIkMxIi4NCj4gDQo+IEluIG90aGVy
IHdvcmRzLCB0aGUgZXhwZWN0YXRpb24gaXMgdGhhdCBtb3N0IGxhdGVuY3ktc2Vuc2l0aXZlIHVz
ZXJzIHdpbGwNCj4gcHJlZmVyIEMwLnggb3ZlciBQT0xMLg0KPiANCj4gRW5hYmxlIEMwLjIgaWRs
ZSBzdGF0ZSBzdXBwb3J0IG9uIFNhcHBoaXJlIFJhcGlkcyBYZW9uIChsYXRlciAtIFNQUikgYnkg
YWRkaW5nDQo+IGl0IGJldHdlZW4gUE9MTCBhbmQgQzEuDQo+IA0KPiBCYXNlIGNvbW1pdA0KPiAt
LS0tLS0tLS0tLQ0KPiANCj4gQmFzZWQgb24gdGhlICJsaW51eC1uZXh0IiBicmFuY2ggb2YgImxp
bnV4LXBtIiBnaXQgdHJlZS4NCj4gDQo+IGJhc2UtY29tbWl0OiBiZDliYjA4ODQ3ZGEzYjFlYmEy
ZWE4Y2ViZjUxNGQ5Mjg3ZTdmNGZiDQo+IA0KPiBDaGFuZ2Vsb2cNCj4gLS0tLS0tLS0tDQo+IA0K
PiAqIHY0Og0KPiAgLSBBZGRyZXNzIGlzc3VlcyBwb2ludGVkIG91dCBieSBUaG9tYXMgR2xlaXhu
ZXIuDQo+ICAgIC4gbXdhaXQuaDogdXNlICdJU19FTkFCTEVEKCknIGluc3RlYWQgb2YgJyNpZmRl
ZicuDQo+ICAgIC4gbXdhaXQuaDogdXNlICdfX2Fsd2F5c19pbmxpbmUnLg0KPiAgICAuIG13YWl0
Lmg6IHVzZSBpbmxpbmUgc3R1YiBpbnN0ZWFkIGZvciBtYWNybyBmb3IgIiFDT05GSUdfWDg2XzY0
IiBjYXNlLg0KPiAgICAuIG13YWl0Lmg6IHVzZSBwcm9wZXIgY29tbWVudGFyaWVzIGZvciAnI2Vu
ZGlmJyBhbmQgJyNlbHNlJy4NCj4gICAgLiBtd2FpdC5oOiB0ZXN0ZWQgd2l0aCBsbHZtL2NsYW5n
Lg0KPiAgICAuIFVzZSBpbXBlcmF0aXZlIGZvcm0gKHJlbW92ZWQgInRoaXMgcGF0Y2giKS4NCj4g
IC0gaW50ZWxfaWRsZTogcmVuYW1lICdpbnRlbF9pZGxlX2hsdF9pcnFfb24oKScgZm9yIGNvbnNp
c3RlbmN5Lg0KPiAqIHYzDQo+ICAtIERyb3BwZWQgcGF0Y2ggJ3g4Ni91bXdhaXQ6IEluY3JlYXNl
IHRwYXVzZSBhbmQgdW13YWl0IHF1YW50YScgYWZ0ZXIsIGFzDQo+ICAgIHN1Z2dlc3RlZCBieSBB
bmR5IEx1dG9taXJza2kuDQo+ICAtIEZvbGxvd2VkIFBldGVyIFppamxzdHJhJ3Mgc3VnZ2VzdGlv
biBhbmQgcmVtb3ZlZCBleHBsaWNpdCAndW13YWl0Jw0KPiAgICBkZWFkbGluZS4gUmVseSBvbiB0
aGUgZ2xvYmFsIGltcGxpY2l0IGRlYWRsaW5lIGluc3RlYWQuDQo+ICAtIFJlYmFzZWQgb24gdG9w
IG9mIEFyamFuJ3MgcGF0Y2hlcy4NCj4gIC0gQzAuMiB3YXMgdGVzdGVkIGluIGEgVk0gYnkgQXJq
YW4gdmFuIGRlIFZlbi4NCj4gIC0gUmUtbWVhc3VyZWQgb24gMlMgYW5kIDRTIFNhcHBoaXJlIFJh
cGlkcyBYZW9uLg0KPiAqIHYyDQo+ICAtIERvIG5vdCBtaXggJ3Jhd19sb2NhbF9pcnFfZW5hYmxl
KCknIGFuZCAnbG9jYWxfaXJxX2Rpc2FibGUoKScuIEkgZmFpbGVkIHRvDQo+ICAgIGRpcmVjdGx5
IHZlcmlmeSBpdCwgYnV0IEkgYmVsaWV2ZSBpdCdsbCBhZGRyZXNzIHRoZSAnLm5vaW5zdHIudGV4
dCcgd2FybmluZy4NCj4gIC0gTWlub3Iga2VybmVsZG9jIGNvbW1lbnRhcnkgZml4Lg0KPiANCj4g
QzAuMiB2cyBQT0xMIGxhdGVuY3kgYW5kIHBvd2VyDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiANCj4gSSBjb21wYXJlZCBQT0xMIHRvIEMwLjIgdXNpbmcgJ3d1bHQnIHRvb2wg
KGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC93dWx0KSwNCj4gd2hpY2ggbWVhc3VyZXMgaWRsZSBz
dGF0ZXMgbGF0ZW5jeS4NCj4gDQo+ICogSW4gIlBPTEwiIGV4cGVyaW1lbnRzLCBhbGwgQy1zdGF0
ZXMgZXhjZXB0IGZvciBQT0xMIHdlcmUgZGlzYWJsZWQuDQo+ICogSW4gIkMwLjIiIGV4cGVyaW1l
bnRzLCBhbGwgQy1zdGF0ZXMgZXhjZXB0IGZvciBQT0xMIGFuZCBDMC4yIHdlcmUgZGlzYWJsZWQu
DQo+IA0KPiBIZXJlIGFyZSB0aGUgbWVhc3VyZW1lbnQgcmVzdWx0cy4gVGhlIG51bWJlcnMgYXJl
IHBlcmNlbnQgY2hhbmdlIGZyb20gUE9MTCB0bw0KPiBDMC4yLg0KPiANCj4gLS0tLS0tLS0tLS18
LS0tLS0tLS0tLS18LS0tLS0tLS0tLXwtLS0tLS0tLS0tLQ0KPiBNZWRpYW4gSVIgfCA5OXRoICUg
SVIgfCBBQyBQb3dlciB8IFJBUEwgcG93ZXINCj4gLS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0t
LS0tLS0tLXwtLS0tLS0tLS0tLQ0KPiAyNCUgICAgICAgfCAxMiUgICAgICAgfCAtMTMlICAgICB8
IC0xOCUNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLXwtLS0tLS0tLS0tLQ0K
PiANCj4gKiBJUiBzdGFuZHMgZm9yIGludGVycnVwdCBsYXRlbmN5LiBUaGUgdGFibGUgcHJvdmlk
ZXMgdGhlIG1lZGlhbiBhbmQgOTl0aA0KPiAgcGVyY2VudGlsZS4gV3VsdCBtZWFzdXJlcyBpdCBh
cyB0aGUgZGVsYXkgYmV0d2VlbiB0aGUgbW9tZW50IGEgdGltZXINCj4gIGludGVycnVwdCBmaXJl
cyB0byB0aGUgbW9tZW50IHRoZSBDUFUgcmVhY2hlcyB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQo+
ICogQUMgUG93ZXIgaXMgdGhlIHdhbGwgc29ja2V0IEFDIHBvd2VyLg0KPiAqIFJBUEwgcG93ZXIg
aXMgdGhlIENQVSBwYWNrYWdlIHBvd2VyLCBtZWFzdXJlZCB1c2luZyB0aGUgJ3R1cmJvc3RhdCcg
dG9vbC4NCj4gDQo+IEhhY2tiZW5jaCBtZWFzdXJlbWVudHMNCj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiANCj4gSSByYW4gdGhlICdoYWNrYmVuY2gnIGJlbmNobWFyayB1c2luZyB0aGUgZm9s
bG93aW5nIGNvbW1hbmRzOg0KPiANCj4gIyA0IGdyb3VwcywgMjAwIHRocmVhZHMNCj4gaGFja2Jl
bmNoIC1zIDEyOCAtbCAxMDAwMDAwMDAgLWc0IC1mIDI1IC1QDQo+ICMgOCBncm91cHMsIDQwMCB0
aHJlYWRzLg0KPiBoYWNrYmVuY2ggLXMgMTI4IC1sIDEwMDAwMDAwMCAtZzggLWYgMjUgLVANCj4g
DQo+IE15IFNQUiBzeXN0ZW0gaGFzIDIyNCBDUFVzLCBzbyB0aGUgZmlyc3QgY29tbWFuZCBkaWQg
bm90IHVzZSBhbGwgQ1BVcywgdGhlDQo+IHNlY29uZCBjb21tYW5kIHVzZWQgYWxsIG9mIHRoZW0u
IEhvd2V2ZXIsIGluIGJvdGggY2FzZXMgQ1BVIHBvd2VyIHJlYWNoZWQgVERQLg0KPiANCj4gSSBy
YW4gaGFja2JlbmNoIDUgdGltZXMgZm9yIGV2ZXJ5IGNvbmZpZ3VyYXRpb24gYW5kIGNvbXBhcmVk
IGhhY2tiZW5jaCAic2NvcmUiDQo+IGF2ZXJhZ2VzLg0KPiANCj4gSW4gY2FzZSBvZiA0IGdyb3Vw
cywgQzAuMiBpbXByb3ZlZCB0aGUgc2NvcmUgYnkgYWJvdXQgNCUsIGFuZCBpbiBjYXNlIG9mIDgN
Cj4gZ3JvdXBzIGJ5IGFib3V0IDAuNiUuDQo+IA0KPiBRJkENCj4gLS0tDQo+IA0KPiAxLiBDYW4g
QzAuMiBiZSBkaXNhYmxlZD8NCj4gDQo+IEMwLjIgY2FuIGJlIGRpc2FibGVkIHZpYSBzeXNmcyBh
bmQgd2l0aCB0aGUgZm9sbG93aW5nIGtlcm5lbCBib290IG9wdGlvbjoNCj4gDQo+ICBpbnRlbF9p
ZGxlLnN0YXRlc19vZmY9Mg0KPiANCj4gMi4gV2h5IEMwLjIsIG5vdCBDMC4xPw0KPiANCj4gSSBt
ZWFzdXJlZCBib3RoIEMwLjEgYW5kIEMwLjIsIGJ1dCBkaWQgbm90IG5vdGljZSBhIGNsZWFyIEMw
LjEgYWR2YW50YWdlIGluDQo+IHRlcm1zIG9mIGxhdGVuY3ksIGJ1dCBkaWQgbm90aWNlIHRoYXQg
QzAuMiBzYXZlcyBtb3JlIHBvd2VyLg0KPiANCj4gQnV0IGlmIHVzZXJzIHdhbnQgdG8gdHJ5IHVz
aW5nIEMwLjEgaW5zdGVhZCBvZiBDMC4yLCB0aGV5IGNhbiBkbyB0aGlzOg0KPiANCj4gZWNobyAw
ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvdW13YWl0X2NvbnRyb2wvZW5hYmxlX2MwMg0KPiAN
Cj4gVGhpcyB3aWxsIG1ha2Ugc3VyZSB0aGF0IEMwLjIgcmVxdWVzdHMgZnJvbSAnaW50ZWxfaWRs
ZScgYXJlIGF1dG9tYXRpY2FsbHkNCj4gY29udmVydGVkIHRvIEMwLjEgcmVxdWVzdHMuDQo+IA0K
PiAzLiBIb3cgZGlkIHlvdSB2ZXJpZnkgdGhhdCBzeXN0ZW0gZW50ZXJzIEMwLjI/DQo+IA0KPiBJ
IHVzZWQgJ3BlcmYnIHRvIHJlYWQgdGhlIGNvcnJlc3BvbmRpbmcgUE1VIGNvdW50ZXJzOg0KPiAN
Cj4gcGVyZiBzdGF0IC1lIENQVV9DTEtfVU5IQUxURUQuQzAxLENQVV9DTEtfVU5IQUxURUQuQzAy
LGN5Y2xlcyAtYSBzbGVlcCAxDQo+IA0KPiA0LiBIbyB0byBjaGFuZ2UgdGhlIGdsb2JhbCBleHBs
aWNpdCAndW13YWl0JyBkZWFkbGluZT8NCj4gDQo+IFZpYSAnL3N5cy9kZXZpY2VzL3N5c3RlbS9j
cHUvdW13YWl0X2NvbnRyb2wvbWF4X3RpbWUnDQo+IA0KPiBBcnRlbSBCaXR5dXRza2l5ICg0KToN
Cj4gIHg4Ni91bXdhaXQ6IHVzZSAnSVNfRU5BQkxFRCgpJw0KPiAgeDg2L213YWl0OiBBZGQgc3Vw
cG9ydCBmb3IgaWRsZSB2aWEgdW13YWl0DQo+ICBpbnRlbF9pZGxlOiByZW5hbWUgJ2ludGVsX2lk
bGVfaGx0X2lycV9vbigpJw0KPiAgaW50ZWxfaWRsZTogYWRkIEMwLjIgc3RhdGUgZm9yIFNhcHBo
aXJlIFJhcGlkcyBYZW9uDQo+IA0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9td2FpdC5oIHwgODUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+IGRyaXZlcnMvaWRsZS9pbnRl
bF9pZGxlLmMgICAgfCA1MiArKysrKysrKysrKysrKysrKysrLS0tDQo+IDIgZmlsZXMgY2hhbmdl
ZCwgMTIzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KDQpIZXkgQXJ0ZW0sIExpbnV4
IFBNIGxpc3QsDQpJIHN0dW1ibGVkIHVwb24gdGhpcyBwYXRjaCBzZXQgZnJvbSBhIHdoaWxlIGJh
Y2ssIGFuZCBzYXcgdGhhdCBpdCBsb29rcyBsaWtlIHRoaXMNCndhcyB0aGUgbGFzdCBzd2luZyBh
dCBpdC4gVGhlIGRhdGEgbG9va3MgY29tcGVsbGluZywgd2FzIHdvbmRlcmluZyBpZiB0aGVyZSB3
YXMNCmFueSBhcHBldGl0ZSB0byBwaWNrIHRoaXMgYmFjayB1cD8NCg0KSWYgeW914oCZZCBsaWtl
LCBJ4oCZZCBiZSBoYXBweSB0byByZWlnbml0ZSB0aGlzIHdvcmsgaWYgaXQgaGFkbuKAmXQgYmVl
biBraWxsZWQgaW50ZW50aW9uYWxseQ0KdG8gdGFrZSBpdCBvZmYgdGhlIGNvbGxlY3RpdmUgcGxh
dGU/DQoNCkhhcHB5IHRvIGhlbHAsIGxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KDQpDaGVl
cnMsDQpKb24NCg0K

