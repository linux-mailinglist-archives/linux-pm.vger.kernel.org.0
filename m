Return-Path: <linux-pm+bounces-27521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5866AC122E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 19:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156561B668FE
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938818DB14;
	Thu, 22 May 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qmHTnTRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D618A953;
	Thu, 22 May 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935324; cv=fail; b=W5vmvmQRhFOSsZVgieLsR4s7rixSWX13QVKsx6i38b+zYi4CzxIUQolP/s88DHTP3bLFM08uCIRfCgagAjTVzJzO1txT48ub6z9JKjrv6bmjuUotGRzVoPgae4o9KCcacPMYGXIH9VWSxRSBny1UzEr7nBGzghewrMkfk+OdgrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935324; c=relaxed/simple;
	bh=Vizhp/KkhqdVWEVIIJobWSyaU5LKTiW8rTRuddW28h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7gvt/gyzkfuLf9yddM7LYZiPXzKaWAXGjXB4tYMpKZX+WOT2IkpkKYIMYxdO0Z4kjifjEIFm8TQgcJXbzsMS3BiIidR8pXMhsqqzrAX3Q+lF0wmdsDkOjHPoslpY5SJa86Sadq+FRqYpXE6pgghK2x5nB4S4SZc5wLyxFdoLY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qmHTnTRl; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV6gyEWHcoXIB4DXXl30kobHqIoAekCefUFgaMI0kWQTDtZGGDmxiwjRYlmxqdavLktbfYDBqhIhyrd54shx7U6oJlWBq3EvbWSmqP8PDkdgKqP6OP99WcTHzPjkOfRbL934U5ElnMzFnslXJuqOSPVLtS52VpSYJmTmUJWaUYeSbsXASwjFFBKciU9Ao58M57UVQn+E1HSZSO73K+olSRwI/J/WWsdF+9oQnegjEUZF0e+E45v1Immf9h4IhzONKybKuefL3Nu9ifP+WIGhYYhuZ7yl7wwTnzZnsVx/WR6bqCkeziKJu52EnPqpoqnZyxWUejiUGQdamPmyXZEjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vizhp/KkhqdVWEVIIJobWSyaU5LKTiW8rTRuddW28h4=;
 b=r0VtOBRpCUYD2QYc/geNKvaONXVE9YSh6JF2z5wQv13DSJqQZGuVLGPZu7XoF34ulHTeyPLe1vm1O5XUzI2XJOn8qMNt/jYo82LZcaZvq9P2TFrW9rR5K1Ogk1ozkHp6xw29tJhHiBOOBlqHetNI1zHONVHw0E78zMURoebARon7eNs+DyoFb4BBDQ2BUNhBcb6vUj1W+VaahdTzU9q1VBvpCJP85cn/BxBDr7/ERyPZjKlmDJnALMBRQsEPEq4k/Mk0rFMS+JhbVcbyGWpKjVfTB59lmEbgbLtW+ZdlmtTVmbffGuADaANv2JCk1Bw3QbhEfAEx6HS2kyolt1jSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vizhp/KkhqdVWEVIIJobWSyaU5LKTiW8rTRuddW28h4=;
 b=qmHTnTRl/GyIG4qgNE4avJbMMQav0ZYMTC9Z2BX/C6HF1VfF9JJzjvMFGuMjAnmk9i77lf/T6hQJuhTBH57+GvU8t2UcLSJ9iZXYm3YV0Erz/ZIBjCMcZQDe7BhjhuF1aYZRLfm15vVmD+ysnIKlRNrvrsxF8qbkCcEGdJtiSXg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:35:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 17:35:20 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: shouyeliu <shouyeliu@gmail.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Yuan, Perry"
	<Perry.Yuan@amd.com>, "corbet@lwn.net" <corbet@lwn.net>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shouye Liu
	<shouyeliu@tencent.com>
Subject: Re: [PATCH] Documentation: amd-pstate:fix minimum performance state
 label error
Thread-Topic: [PATCH] Documentation: amd-pstate:fix minimum performance state
 label error
Thread-Index: AQHbyueBxW5x/25Q30emo42khx8+XLPe6feA
Date: Thu, 22 May 2025 17:35:20 +0000
Message-ID: <d1281f23-69c6-4386-9d26-6f2cd95343cc@amd.com>
References: <20250522070140.17557-1-shouyeliu@gmail.com>
In-Reply-To: <20250522070140.17557-1-shouyeliu@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: 9ff569cd-0882-4eb7-9675-08dd9957062c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUM4WFcvemh5V2FGYy9LajdzcXk1cTF2MDQ1V3B2RXN4THJsOGFqTld1cExZ?=
 =?utf-8?B?bnplaDhhMDRiM0Y0T2NaZ29UMXZjd3d1cmpEU25rM3FiVS9jMlgyY1pwSHlY?=
 =?utf-8?B?WWoyaUlKQ1BkMGk4b09FRXdwbHdzZEZZVWVVWTVhcy9ZTDBQNmtEeC9Pdzh4?=
 =?utf-8?B?bk5Pd24rOGlGeGVXRjJscE9EbmtYbTZKOEFNd2ttN3M1bjRWelhVb2FlMVQw?=
 =?utf-8?B?QWE5Zk9vWEtUblJGbFpXZVNRQU1lUlVQTjBDWU5MRGdzUi9IT0ZBSjNsQlhB?=
 =?utf-8?B?eXVSZUpyRDRoWHpsOXdPekJ6N1dZcVc0enRsVkZkWWxweXFjTnIxTVpxMmtI?=
 =?utf-8?B?b3FNK1pJWitiQ3dUVzQ3a2hPMjJDUGR4OXBRNzVlQmIrZ3loWXZiUzRKSExE?=
 =?utf-8?B?NHE3MmJHcHhSV0VCN2s1TitWTlBOUG82SE0xSVVCRGJSTGtjY1ZaUElORlJB?=
 =?utf-8?B?L2IvLzdqN25wcURVZWYwM0RLeGViTUdrYUdiVWJUcEZkY3R5MTZLdkVrT0o1?=
 =?utf-8?B?ak8vMGt2dURDSDFOTXJkMDNicUUyaEtuaSswaWJtVk1iMU5sZ0NsQkFXWHJv?=
 =?utf-8?B?Vmo2d0o4dzhLQ012NDJnQ01Ub2N4a1VXcG44d2tkZ2YzU2prYWxxZVg5eDh5?=
 =?utf-8?B?S2tRaVlnL1g0dG0zTUdNaSt3aU1LMG1CbEs2K2JFMFZkR0s0Y3o0Y01RdDUz?=
 =?utf-8?B?VVAwYW1pRExvTXh3TEJDK2ErYm9aTWxtdTVWZWJHbVZ5S2M2SHF3cG4wOHpB?=
 =?utf-8?B?aExLSnFJNVhzekFZbUUvbnBMVnQySGQxZmZ5dENrb2FYa3B3NVN4TVNSTTJy?=
 =?utf-8?B?OWVtNFVRVWs5UkQzSi9OdWNQVDVyZEFZa21IM2I2aHg1NTdzWDJoMjZYZHdL?=
 =?utf-8?B?b0pXV2JLKytpMlVYTldObG1EMHM5eWcrQW9mQVd3VE9iSjNSb2ttYTVDQkhH?=
 =?utf-8?B?NWR1WkhpaHZlVHQzcEtTZXVKbklQbmtyTWU4NCtubkpKM0JnOUZUWFVPb0hT?=
 =?utf-8?B?SmlOQ2J4bGo3S0lxcUdaVkxqNjBXMlFRYVpCem43enVwMkwwMGpPeW10ZFAx?=
 =?utf-8?B?RW5XeVJTNGZjaXdiREdENkg1NWM2MDBWOHZxY0VFQkVYUWtMR2NEZVE1TndC?=
 =?utf-8?B?ZThNekpwdno5OC9MYlNhcUtNcjNITGdHeEQ2ZGJDK1NTaDFOd3Z0dmVnY1Fx?=
 =?utf-8?B?c2VNcFdwVm1oS2VaUU52Q2dQNisrZ0hHODB1UXdaV2pZaU9qY0dtOE84MXY4?=
 =?utf-8?B?M3NYTTJDcmdLckFhUjRJSStKY3hOUVFiUW9GZ3V1eFl4WHQ4amJxNnJyTERp?=
 =?utf-8?B?WkZhVlJ4MllJQVd3UU1oQ0lCc0FNOWZCYkpRWitBbFllRTVnaHJuMXc1eTdp?=
 =?utf-8?B?TlBmZzR2NVVsZG1FbTNZRFFQN3RWNWVSZ0YvTzJUd2toQ1FUNFN1MU54TDlU?=
 =?utf-8?B?c1JtY05aZ3VZZHhJUmxSejkxSEl1V1V3WXJZSHZRVGJIY3F0Y0tMS01JRHJt?=
 =?utf-8?B?WmtKdCsvRUswaGFJSjFGckNNOGdVOHhBY0ZOK1ZjbU5IL2VBakdqZ0RRcVpW?=
 =?utf-8?B?V1l4M2kzMG5iaFlFVlVicWxwWlN3SXEwOS96N20xWmduVUJwcUFWbFhzRFlS?=
 =?utf-8?B?dGx2a3hBNlV2b3UxTmZkSFFyMU11d0RRYlRNYUltRTYwSGpFTmpBbWlZeUo5?=
 =?utf-8?B?c0h0eE5BWU5kQ1FXbUVqT0UreHdMd0Y1bEtEN3RFUERaY3F4WGdLRkR0dUpO?=
 =?utf-8?B?SEs3YTE2L1NtbjRKWjFxYzFSaGphRXhaU2JQdi9XNk41QkU0Nm9QTXgxeUxI?=
 =?utf-8?B?dG1hNDBkZWtiUzZUZnBYby96MEVMaForcGN0Sk13bmVkcWNlNWU0Mmw1cHM2?=
 =?utf-8?B?RmRVVlZycUpFb0xJS1ljNGU5STRiRDN0WHMwUFl2cTJ4S1RJQ3BnazVPcUkr?=
 =?utf-8?B?WUVlY1MvbHN5cFZiREx3QVBCYjZFM0VDV2p3L04zUUFhR3lUN1g5NnA2alhn?=
 =?utf-8?Q?o/2P1L850OGq/3voz/kzd+Yv9QGKnw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzB1dUY0d0s0cFltRGhhZkVqdmY5VE5DR1JSd3hHait5RENFWDRDZ3dqeGs2?=
 =?utf-8?B?eEVMQzZlYWZXcHBFSTVWM2NZSEZzd2J2QUxXb0JKY25sbFp1UUczV3lzOWZX?=
 =?utf-8?B?S0pqM01jbExwM0hma2JET1JYN3U5c2p6d2hCVlZXVXVPRFB1Njk4YVBjZVdX?=
 =?utf-8?B?ZG5FUzFuVE54TUdHZ3JXYzd5OCtlMFAyTmpZeFhnY2M1Sjk5c2dCdFp3eEYx?=
 =?utf-8?B?ZVF6cGtPZ1JHVkpXMVNLQnh4cUZTZm82SmlDd2RmRmdKcTh1cUdBZkRYK2Fh?=
 =?utf-8?B?WGhWYXQ1RnVKMDNIWmRnRU9RRmdSZTMrSGJYaVI2MlNvd3l3aWNDVjVXYXhN?=
 =?utf-8?B?Q1RqOXBuN1krQlMvN0ZuMHR0WVQ3UFBUbm9CUkNhMGR4Tkx0Y1d2ckRkOGJy?=
 =?utf-8?B?clVUeWRlMy9hekprUVZoUW1mSFJrcHJRcnZVMk5nei9QUytrT1JncDdDeHV6?=
 =?utf-8?B?SVZuQlV4Ynk1c0dJUWV2K2Q4QTV2WWg4MnlZd2x5Wkw5L3FFUjNQMDhjZlZH?=
 =?utf-8?B?VWhYMTUyT3FPZ0w2WVVkWG5WbjFsd1dqeUlpVTJxcURuNVV0NDZBWGlYMHo4?=
 =?utf-8?B?b1RleEUxWkVGdGYzNm92S1JiRFNyWjIrdjIwU3ZwQW92NFBpZi9tNU5iVkpO?=
 =?utf-8?B?K3FEOFIyR0Z4NFBFdEpWa204VSsyODNQUXpqWkM4WnNlZW1RYkM0ZXdMOHNR?=
 =?utf-8?B?aXBHeGNaZWJvdlQ3a01pUkR3enpLYnRnYURLa294cGlDaVhzRUREcTFydTJO?=
 =?utf-8?B?QzJKQTI0Ty9oSzZOSDNTRlpQTldBQnlXTEtscE15NzBZMTg1NWxFM0dzS0Nk?=
 =?utf-8?B?VlRpWmdEa1BtMmRCRzN6amJMRUEvMmNwT29CTDIzR25BdHV6ZlptUElMYnFv?=
 =?utf-8?B?dk4rZGJ2SjdlczdWT2IvWE0vSkF6Szk5a2J0d1NsUUxBdUgrK054dm1xZHE3?=
 =?utf-8?B?RVA5ZXFBU21vTWp2cjNjTHVqOUJOOVJ5ak1tMHRrWjg0UlJIbTFWNXdzT3RH?=
 =?utf-8?B?NFluZi9TOVVPUFI3NjJKb3ByRytHRjYrQUw2UDE5ZlNKeFUzSjVkdlNJQU9K?=
 =?utf-8?B?VHVTN3k2dXMxaVFycHRDbCtLaGcvcnVRQ21QZ2tSRjYweW1YR1JBQTRUOXpi?=
 =?utf-8?B?QTc3WXArYVdHejMvbEMwN1IvM0JtVXkxYlVOZ2Nob3A1QlVFM09zeStUbDcz?=
 =?utf-8?B?ek1EUTZTSnhpR3JKK0pHMnhKaVZ5UlhmK3d6TDJ4SFR2MkU4bnF5dVgzcEJL?=
 =?utf-8?B?YTNlNWdUOEJBSlpMT2FtQXAvTDJYSS9uS3dGVmwzMnNtWWk5NUo1REhvS0Ri?=
 =?utf-8?B?RHV0cXdkb3ZRRDQwZkUxTnBVVC9jRDdMK0FxMmlQMjRmOS9oTmdXRHNvdmRt?=
 =?utf-8?B?S3JIaGtSekxUS1Fqc1Y5ZG8zVjFySEh2aTZsc3dVTEtrekxuM3RiSVVjWm00?=
 =?utf-8?B?ZHNPQVJQaFJXQlNhcW03M1NhMWIyaXdwajRKNGxBZWN3SzNaRkFzbk1tTTNu?=
 =?utf-8?B?c1V1a2tySTAzZUo0b0IxdlFtQnNHSjRuUkgrRWw3a0NsdXdEYTJGaitkT1ZH?=
 =?utf-8?B?K1RjcnJEK3ByQjJQaVFrZEp4SGRUTlY4TzJaUXVUVTBhcHMvZXRBbTlCN1hG?=
 =?utf-8?B?aFhxN2FGdkdrSDhuZzQ0QXFQa2pTNWxHeWtWRjBNbWhOWTFENTdBUEFuaHhQ?=
 =?utf-8?B?dDdId3JYNEk2cHJVNjlzdjcxSzNMekYyZXR0clFKbmJDQjlRVHI4YVZBWDN4?=
 =?utf-8?B?Y09MdmpyRkpkZnd6b2tVUDIvRUpoK1dIcWs3MkpZb0JlT0F4TUVOQVlOMWh3?=
 =?utf-8?B?NlJRQkZ5L2ZmcDlsYkszaFNDQVZMT1B5YkdVaG96M1R1Z0tVUjlBeVZ2cFFl?=
 =?utf-8?B?SFJGTDlVY0lBNy9aUjdGWjBvL0N1M1h1YWptNnNnKzhSUmZmZFpFVS9CZUVT?=
 =?utf-8?B?ZzgwNWovTFRHelo0RXRzRDNxZWRjVVRpNDNzRHlaSGhnUWFhZ3ZXWG00eC8r?=
 =?utf-8?B?d2MyM1RXaWxQUTFrb1lnQ1lkWXVUOE96dmdkdTJSMTJOVXh3Q0V3b1NEUGJh?=
 =?utf-8?B?M3dOV1BIcnF0REZOZ2FJM1JtSkRWV0c1YjEwdEltbkYvTVp1bzdEYnZielFN?=
 =?utf-8?Q?A0Qo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8AA35436AA5B146AFD48D1C391C8A48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff569cd-0882-4eb7-9675-08dd9957062c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 17:35:20.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vis5CTzvFVCy/cxRnDImOXUR2VC6QobHV82LBFXVmkyop/IetvygXO8imHRN3PVroDqm2C8HyjmH71dzgwOISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

T24gNS8yMi8yNSAyOjAxIEFNLCBzaG91eWVsaXUgd3JvdGU6DQo+IEluIHRoZSBBTUQgUC1TdGF0
ZXMgUGVyZm9ybWFuY2UgU2NhbGUgZGlhZ3JhbSwgdGhlIGxhYmVscyBmb3IgIk1heCBQZXJmIg0K
PiBhbmQgIkxvd2VzdCBQZXJmIiB3ZXJlIGluY29ycmVjdGx5IHVzZWQgdG8gZGVmaW5lIHRoZSBy
YW5nZSBmb3INCj4gIkRlc2lyZWQgUGVyZiIuVGhlICJEZXNpcmVkIHBlcmZvcm1hbmNlIHRhcmdl
dCIgc2hvdWxkIGJlIGJvdW5kZWQgYnkgdGhlDQo+ICJNYXhpbXVtIHJlcXVlc3RlZCBwZXJmb3Jt
YW5jZSIgYW5kIHRoZSAiTWluaW11bSByZXF1ZXN0ZWQgcGVyZm9ybWFuY2UiLA0KPiB3aGljaCBj
b3JyZXNwb25kcyB0byAiTWF4IFBlcmYiIGFuZCAiTWluIFBlcmYiLCByZXNwZWN0aXZlbHkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaG91eWUgTGl1IDxzaG91eWVsaXVAdGVuY2VudC5jb20+DQo+
IC0tLQ0KPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QgfCAy
ICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRl
LnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QNCj4gaW5k
ZXggNDEyNDIzYzU0ZjI1Li5lMTc3MWYyMjI1ZDUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJzdA0KPiBAQCAtNzIsNyArNzIsNyBAQCB0byBtYW5h
Z2UgZWFjaCBwZXJmb3JtYW5jZSB1cGRhdGUgYmVoYXZpb3IuIDo6DQo+ICAgICBMb3dlc3Qgbm9u
LSAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICAgICBsaW5lYXIgcGVyZiAtLS0tLS0+Ky0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rDQo+ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+IC0gICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgIExvd2VzdCBwZXJmICAtLS0tPnwgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgTWluIHBl
cmYgIC0tLS0+fCAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiAgICAgTG93ZXN0IHBlcmYgLS0tLS0tPistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKw0KPiAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfA0K
DQpNYWtlcyBzZW5zZSB0byBtZS4gIFRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9u
Y2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0K

