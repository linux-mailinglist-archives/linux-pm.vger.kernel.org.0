Return-Path: <linux-pm+bounces-13370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87B96916E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 04:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B4E1C2283C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C51CDA10;
	Tue,  3 Sep 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1JJfI5t1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058971CCEDB
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330535; cv=fail; b=Uo+l9nMZUSOxNCUY5l0nL61P/YY6nbra9IlJ6uVVNCyTi9K5Ds3GWO/PRoHXBA6SiPRzySaGuMtaZAm2XZUgpJIYMz87b6iWmb/hbUQEdoCjKV+46GEv022likwlkw8I06uO1syJBQJz0tsHSVMRapQMLyhePrMfWkWvXKz/V1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330535; c=relaxed/simple;
	bh=IKVr92UJYUrOKkSoLO5bpOhsQkIA8gua3pPRjNrDSU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4Y4lSDtCcMiCTKDBqglH1qfNuwWKqf1TdyJul3h24JGua0JINzrfWbI18Hj5Nyd3Q6cS08FSSQpgI1HeTf6BQyM9OidnLbmcaKq+A9pECoUoHXz8W51swESLS43NxAlNfPijX5BTfD9kajAY9QxNH/m32+6cI1dkuT7GXqX8VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1JJfI5t1; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrciBSoz3QxNcQ5Z70BrRDY31WaiZjKbmdcw0UKiIiVEd7qbzgrnCVnN6OULu+dtKCNGyXIhAytqECWkuYpzRWWJM2VYDGYghkxfg8b/TsOm5CHwAgKHopBMwv+N+itDg0/C2nla+vZ0/5B7yJSZNIOZZOIo0p0x+pze3CW0KT1UCt2ZDpPJRdz70X6luWT6hlZMhtJSm09DZsSvBZQAsNvvRRj/1o9g/swMDwvSXVvYL4X32kXU6SJA5WBtdhWZSzcsDpR37tWQIuzEkJxBxDWohs5UpWrXjWfGhRbE2GMsnUH9IEJH5vjV2bvArEDsuilR+1MwzRhrWPBSPTQlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKVr92UJYUrOKkSoLO5bpOhsQkIA8gua3pPRjNrDSU8=;
 b=DCrYeI3Q/v5rg40qmK8Xg6+M+TlXvDlJ+gBopNGM5XjiWOsJeblJh/GAn9nJSl1rgr29+w4pP2JSnwri2i6RarWEnnWs3F3x1iSwVV4/DwIoOEcAZO4rxz/CvLtHjPkwcF+Daadyqv4uWCGvtKCea7kumpx9Owg13NRrRMCIvEEQiHoEx6w2FNT19ndfZGrIxdFx3N7WCjwU5UGRby5IfMpvdypqIfLpGVDLWh6GF+DiFp15a8J12bf6smtlLUHzIRqnPnX1iWB0A5JG5ekK1Py4ag7uMTkdM52UrtMdtRi8FbJUo6N2yLqTrM0yGCAeiZaaPVPaqSnMbFVWteysjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKVr92UJYUrOKkSoLO5bpOhsQkIA8gua3pPRjNrDSU8=;
 b=1JJfI5t1zjJ+AsV7irHQ+HfQ+2+71SnuaSjJ4qADqCHFWiP0s5Pi6sueclhlxvw62Edy4kqGjwJza5HeaBiUSUAaSrwTRl+unsXrjn6Cdiy0tVH3JQVNAhH+Jq1jpPE7LSogfhBTii8ihw3N2ERaPj6vbi0eR95k9k99FXbagRw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 02:28:51 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 02:28:51 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: John <therealgraysky@proton.me>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: amd-pstate-epp: CPU freq never hits minimum level booted into
 OpenWrt but does under Arch
Thread-Topic: amd-pstate-epp: CPU freq never hits minimum level booted into
 OpenWrt but does under Arch
Thread-Index: AQHa/W1d3S/xas6ehkOj0M/djz7LQLJFVs2Q
Date: Tue, 3 Sep 2024 02:28:50 +0000
Message-ID:
 <CYYPR12MB86554E10C5F1A155B7F049F79C932@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
In-Reply-To:
 <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cf6cb4df-bb7f-4be0-a918-d289a2c95ef1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-03T02:27:31Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB7431:EE_
x-ms-office365-filtering-correlation-id: 3c44f669-1168-4740-e4da-08dccbc025e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVdTZDB6cTFPRWFWM05CUkdBU21TNEp0MVNONWhxeE9ybUVLZlZpbHJITElE?=
 =?utf-8?B?VmFKeWYwdS85QzVVWW5iM20wRkFxcUl5MFE3L3NXeXRLUXVQWU96enViOHE3?=
 =?utf-8?B?L2I1bUJlaDFoUytDdG15V2NhLzJwNkticGtxYW9EV3VvUkZiVWtLakwzSWpl?=
 =?utf-8?B?YUtSSXBWWEhtL1ZzVGxuLzNqLy9xaGt2WW1UcllrT09GNEZHU2xrdnpla0Ji?=
 =?utf-8?B?RVBVSGRQL3hJcC9adjZSYVp4N3kvVEFiWk9ONVFxbXNQUzNYMTVFUWFtT0ZF?=
 =?utf-8?B?blZUejFhRnNaMVorcUNOSHhua2w4Rm53Zjc4SVdqa1JUdnUzTmxxOTFnT2FH?=
 =?utf-8?B?RU5RdzJNYUZUOFNZbmlRaUlWL0ZwSlNHNjVSODE5VThTMlMremVOL3EyN1Bt?=
 =?utf-8?B?ZWtEQnREMG1jdHhKc1FEQ2lBOUhLNlpyczlFN0R0SkM4WDVJYXZuQW1KdHdU?=
 =?utf-8?B?TlhHY2lGVFAvNnhOWm5PczhmZXhSeXJQR05ZYXh5S29jMEROY1lJbkpLMjlH?=
 =?utf-8?B?QmJNeURvMWNPUXhuU2E4ZGlkV1ArY21sK0c0UlRXTkJvR3QybW9zZlkyMitY?=
 =?utf-8?B?dHdSUjZWclBud2VjNGxjZW43cHJPL2h3UzRsOHNJUDF0V1RWOHJ0ZncyT2Rs?=
 =?utf-8?B?ZHRnbVBqc29za1ArMFBBTW1PdGpsMlV3bTJmMGpFcFREOTA0T045bEkvWUlO?=
 =?utf-8?B?RUhCQzFkdWlwSDVMVkw2SmM4Skh4K0xrcW5MMFdQb3UyQTdjN1lrRmRNZ1dC?=
 =?utf-8?B?cS9XK0t6R2dFY2IwWG94cEMvYjNGNU9vSitiNnJZNmliWG8vTVgzb0g1TzlM?=
 =?utf-8?B?UG9CZ3ZKOUI4SHhrdjZMMGpXL1JjV0k5SjhMMHhvZ0pvZ1l0OUtCWUVpeWVn?=
 =?utf-8?B?MWZDRXBjTWlhaGVqK2tqd0NRUndKUTNTRThVWUhCWVQ5cFJ2cDJvcjluK3NZ?=
 =?utf-8?B?eUR6a3pURHBGaHBNanIrYUNiQUxhOW9NRU9mcDh0YzNCcnRLcE0yenFPMG1F?=
 =?utf-8?B?Rkp4bGJWRlMrQWtneUVZdG85R3B0ZWVIMFFWNG5sOTRzUVdET0M5SjhQVGRx?=
 =?utf-8?B?dUFGaWh3dGd3bmx6UVU1NWpES0JkaWdQQTltV1lHbDBoNXhXclVuL0hzK1Fw?=
 =?utf-8?B?QnJSVytRQVhoaE4zOU96aXhuM3lHUEh5dUtvaDFHalJBbUxML29paXZVaWtP?=
 =?utf-8?B?SkZORHo0SUs1Ui9xRDVSR0c1NVRrZTFtYW9KcFFpcnNnODhrUUpDZ1BRVmNh?=
 =?utf-8?B?WFVwQ2J1ZWhIN3dmdzU0Yk5TVTdrOXowZEZEYkR1M3N1OVNaTENTdUI5WFc4?=
 =?utf-8?B?VlR4c0txRG81ZGt1R1ZDUFdaTzlLQ3lyNFFGZXl3UGU3ZnQ1ZHFXMXE0QWxY?=
 =?utf-8?B?SzRUTVk2djh0cXV0UC9UN1lkVFpTdWpxQitOTmYzaTU5UFlZb2F5VTNJbG5J?=
 =?utf-8?B?K3F3czJxU0NkTXVNTEgyUjRadGRscHdGNkg5VTU0bm56cTlZSlhUMzVxTFd4?=
 =?utf-8?B?aTZRQW5jckVTMmZJTmNEQTNGZkhVUENVekpCY0JyNDNEZWVvdGFhSDAxblhN?=
 =?utf-8?B?M2xXbGNEc2tlbkFHa1NDTGgxZVF5OGhCSDBYeEdJN29tV3lMNFJkcVVLaWJ2?=
 =?utf-8?B?eE1RUy9YSjFPdUo5UUlrYUlmSnNDa29lazdwOUJGdEc1K0piSWFVOFhXbVVI?=
 =?utf-8?B?VDcrck1rK3NZMWRLSkNYVVhIQndhL2p1dGdob3k1MU5WUEpscVpPUlFXZUx4?=
 =?utf-8?B?ZjNEVmpZWXBwTXZXVTBpYmdGcFNnRGlYcEQ3YVAwcEppZ21ML0N3d05yN2l6?=
 =?utf-8?B?Sm1RdHZLdkZLU25PK0N1Y2JKcHdWVzdXcHR2UGYwaFlBUzVtbkRUaS9idFh6?=
 =?utf-8?B?NFYvQ2I1bGkxM25qcldVOUNlS1BmQUVKK3FrYU5RbzFkUkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1NiNDVpTEY0b1Rrd2xBbXV3aG5qb01SU1lZYjJ2ZGVaK0l3UkFieXJ4VHgz?=
 =?utf-8?B?NWxqTHRiYXBwd3BPNXM0NnUxUzY3M3Z5Zmo0SWpZbUhDSjFkTmhtRExrZ3BF?=
 =?utf-8?B?YnN3dyt2aU1mYkN2cmJqNC85Q1orUS8wYXVPQ0VnTHJNNGZPNER5OExZTGlF?=
 =?utf-8?B?N2RTSTh0V09TYkVKM0RtbGtzdWwzKzRJUk1XYWR2UWxMRitTUTBjMEhIM3l3?=
 =?utf-8?B?d3crOW16UngybnA1SVdneFFUWVpHVUhxQnhYa0xqcnJDakF6R3I2WnNGRXVC?=
 =?utf-8?B?ZnhzYW9jVHd2VHFFUzJoRXNzaERIckxKVHVUa0FIcDRxTkpsWHdyVkxQVXlW?=
 =?utf-8?B?VVF0bUNQRTNkTnViVk1zb0xoWUZ2bVVReXlNUTljd1YrdjVqQ3NkVjhXQ2xT?=
 =?utf-8?B?OGo5R0toREdDYjRSamF5Y015ckU5M1FOdjRRWVZnWHgySWJwUWkxNVhrVkFC?=
 =?utf-8?B?bUxlci8rOU5QNmJzQ2NqY0FpeGtDak01b0N3VGQrclRQZTlHbllkNFZud2Nt?=
 =?utf-8?B?dUVBUEM0V3JsbmZ1UHh2RVdGTUQyTU1qUCtCRWV3Y1JBMGgySlQ5SDJJOXJR?=
 =?utf-8?B?dnI4L2g2bEE0Z2VEci94cFNCYWVrRzFOcFhMeFhqQ0NhYk9tNVFYNk81b0FJ?=
 =?utf-8?B?MG5wTVJTQTFGRzlmWkE0UEVERjVlRmVDUzA3aEVlU2dQVGROK2JROVlDNTRJ?=
 =?utf-8?B?TkVaaDJ6UEVpMWE1VVBXZjd3c2xRUGY3TUs3Z0l0cFpYdW5Jc1FPUWd2TFFZ?=
 =?utf-8?B?QU9oODJjdzlEeGFveHZUL1Z3Q3h0c2dPdmFLK0NtNlU2RVB3aVpYeEJneXB6?=
 =?utf-8?B?bWtEZU4zUzlXbEJoNGIzRCtxRzQ4MllPS0ZKbVl3MUZUSmtjb0NzZXVDK1NC?=
 =?utf-8?B?ajJTZ3F1MllnRGlnVDUrL0tFMUlBOFRMTWlXOExaVlZ5djdvVXBTWHQxL0x4?=
 =?utf-8?B?S1dRdlBaUzdpby9Ja2JwU3NDWTQwaWRZV2ovc1RQekNaM1BUY0dRdE84bkgr?=
 =?utf-8?B?S285c25ta0tidnN6QmVIbEgxRXR5RVRjUGFJWGFpbVdhZnB1NGpMQzNNbk9w?=
 =?utf-8?B?UXd0Mmw2eVk0aS9OWFZ5N095RWk2blAyV0p1WnFqY3FSVEw2QlpabGxXcW90?=
 =?utf-8?B?SW42cytrejZINWRSdjFWNVYzL1JvRjBmRjFyOXd5Z2NrNm5EL0JzeUcwWDVN?=
 =?utf-8?B?aWVsSUZUck9WUnNrR1FzdThPNkZaN2lFN1ZROHlUcVVQNGt1Wkl1d1pMQldY?=
 =?utf-8?B?Q3JNN0R0WG5MejVoSkJCWWh0bVBxL2NyQ1J6U1Q1NU5Vc09LdnVIWUlGb0Yx?=
 =?utf-8?B?QWwxQTNOOHo0Y3oxNDJQTm5oTThObE5JZmE0STZpR09NMldkK0xTQnZUUGc1?=
 =?utf-8?B?OU03TFltelM1eXdDRHU4QndhLzh1ZTNZb0Qwb05JdDhDSTZhTWdNNFpHWENK?=
 =?utf-8?B?MHdtbWlpdE5nbVRPd1ZBY3NRejFDR1BNa2todG5sQUJKV2hFbHlVNU90ZkRy?=
 =?utf-8?B?YTB0UURGVWswQkpHbHg4eHpQQTdGamJ1RGxMejV0WmZxMzFVOExwVkZNc3hC?=
 =?utf-8?B?bGRnSDRVZVordFROZWJVU1Uxa283SDlYME1meS9mTUFvWUYzbW1iTjhxUEVZ?=
 =?utf-8?B?Wk5VeVZCZExxM3VFUU11RUUyOC9PTGxvaTRtQjVxMHdqVWdiMHhHUXh3RHIw?=
 =?utf-8?B?cjVWVGxnSndoek5kOE1DaGhvMGxlY1dLWGpwMnNETVJiYUNWZmZ1d2grT2ZS?=
 =?utf-8?B?eUFGNEtSd3NRSFFhemZTUGRxb3l3bHRZNEw0L0RMR0tjWHhwRGNBT09qQVBM?=
 =?utf-8?B?MTFTQWQ0ZjhTdFU3a2dIU3QyazdPTnU0YnlXaVptWXQ1WU5jTVQ0SGJ0U24x?=
 =?utf-8?B?Um9PNVdUM21pS0pmL2hxQ3pvZjNYYm9BdVV3aGJXbHFJQUdOazBRNm54UVNx?=
 =?utf-8?B?RHJKK2c0RkM0cjEvbjE2WlZBdnRuVVdXQjZ5T1RkZTZXZjZWOUsrYXl0d1Vt?=
 =?utf-8?B?OHlJWWxndFBvM1E1ZytsV0xqSXdONnFlT1N2a2pDb0w5U1h5RXE4ZlF4cnZh?=
 =?utf-8?B?N1JuTDNHTmhnelVpSC95ajZNdm51ZUo5ODFjcmphK3gvamQ2M3h6MFIvZkdO?=
 =?utf-8?Q?Qmfw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c44f669-1168-4740-e4da-08dccbc025e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 02:28:50.9474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1QPNrwCyYjmn7HJNK8jlG+YGJ/I4EPurhXIu7pq50DLsAGJylzg3TfmwKxpBiekbI+YntacOiRzaZc+EgffkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgSm9obiwNCg0KSSB3b3VsZCBsaWtlIHRvIHN1Z2dlc3QgdGhhdCB5b3Ugc3VibWl0IGEg
QlogdGlja2V0IHRvIHJlc29sdmUgdGhlIGlzc3VlLg0KTG9vcCBNYXJpbyBhbmQgR2F1dGhhbSBm
b3IgaGVscC4NCg0KDQpCZXN0IFJlZ2FyZHMuDQoNClBlcnJ5Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gPHRoZXJlYWxncmF5c2t5QHByb3Rvbi5tZT4NCj4g
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDMsIDIwMjQgMzoyMSBBTQ0KPiBUbzogbGludXgtcG1A
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IGFtZC1wc3RhdGUtZXBwOiBDUFUgZnJlcSBuZXZl
ciBoaXRzIG1pbmltdW0gbGV2ZWwgYm9vdGVkIGludG8NCj4gT3BlbldydCBidXQgZG9lcyB1bmRl
ciBBcmNoDQo+DQo+IEkgaGF2ZSBhIG1pbmkgUEMgYmFzZWQgb24gYW4gQU1EIFJ5emVuIDcgNTgw
MFUgQVBVIGR1YWwgYm9vdGluZyBBcmNoDQo+IExpbnV4IGFuZCBPcGVuV3J0IChzbmFwc2hvdCku
ICBXaGVuIGJvb3RlZCBpbnRvIEFyY2gsIHRoZSBjb3JlcyBpZGxlIGF0IHRoZQ0KPiBtaW5pbXVt
IGZyZXF1ZW5jeSBvZiA0MDAgTUh6IHdpdGggYW1kLXBzdGF0ZS1lcHAvYWN0aXZlLiAgV2hlbiBJ
IGJvb3QNCj4gaW50byBPcGVuV3J0IHdpdGggYW1kLXBzdGF0ZS1lcHAvYWN0aXZlIGhvd2V2ZXIs
IHRoZSBsb3dlc3QgZnJlcXVlbmN5IHRoZQ0KPiBjb3JlcyB3aWxsIGRyb3AgZG93biB0byBpcyAx
LDM4MyBNSHouDQo+DQo+IEFzIGEgdGVzdCwgd2hpbGUgYm9vdGVkIGludG8gT3BlbldydCwgSSBz
dG9wcGVkIGV2ZXJ5IHJ1bm5pbmcgZGFlbW9uIGFuZA0KPiBzdG9wcGVkIGFsbCBuZXR3b3JrIGlu
dGVyZmFjZXMuICBDaGVja2luZyBDUFUlIGluIGh0b3Agc2hvd2VkIG1vcmUgb3IgbGVzcw0KPiBu
b3RoaW5nIHVzaW5nIHRoZSBDUFUgdGhhdCBtaWdodCBiZSBrZWVwaW5nIGl0IGZyb20gcmVhY2hp
bmcgNDAwIE1Iei4NCj4NCj4gVGhlIGtlcm5lbCB2ZXJzaW9uIGZvciBib3RoIGRpc3Ryb3MgYXJl
IGluIHBhcml0eSAoY3VycmVudGx5IDYuNi40OCksIGJ1dCBkbyBkaWZmZXINCj4gaW4gdGhlaXIg
cmVzcGVjdGl2ZSBjb25maWdzLiAgSSBhbSB3b25kZXJpbmcgaWYga2VybmVsIGNvbmZpZyBvcHRp
b25zIG1pZ2h0IGJlIHRvDQo+IGNhdXNpbmcgdGhpcyBvciBpZiB0aGVyZSBpcyBzb21ldGhpbmcg
ZWxzZSB0aGF0IGNhbiBiZSBjaGVja2VkLg0KPg0KPiAjIGNhdCAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHVmcmVxL3BvbGljeTAvc2NhbGluZ19nb3Zlcm5vcg0KPiBwb3dlcnNhdmUNCj4gIyBj
YXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kX3BzdGF0ZS9zdGF0dXMNCj4gYWN0aXZlDQo+
ICMgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5MC9zY2FsaW5nX2Ry
aXZlcg0KPiBhbWQtcHN0YXRlLWVwcA0KDQo=

