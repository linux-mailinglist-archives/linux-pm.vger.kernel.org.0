Return-Path: <linux-pm+bounces-27126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC9AB65ED
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E734A62B8
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4421C9F0;
	Wed, 14 May 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vPaZbtwX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F94B5AE;
	Wed, 14 May 2025 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211264; cv=fail; b=QlmKX+UBRur09hgw3WMYT/pWnN9GoX3Td/ujO+QLkstrYQygVbO3BtKsWYeQayY9iQkl6E4zgND4R0vQiFGD57kpfTt47XIuK1fY10KlMYcbCVo5+UMvb36fFzVeNcnyVIPlEZW5s4+0dMXkzoVHviz1Nr5WcC4W3eAV1FDNIX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211264; c=relaxed/simple;
	bh=8eUGWn7OfSbjb0n9R4Slz/hMjdTtxb00BCiXIRUIf3A=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=dW8u3VenBfLokxoo67HH8EJibWfjLmHHpPs/AP+ghywPoqi2hb5iSxteqKGZaGCs3th1kpPukD/O1/oJ5xTQbexPyTgwo0Bz6A6wc4tAs99BNVwQqt/h5oNuRqJzQXqJdx1CFNGuOd+Wi3h48Vfgnb/Sqb5qcuS7SFE8hqzK5kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vPaZbtwX; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeBNqQNEmx0vmiJneSYB6A+dG+LeoaSlOMNguQkfw4q5zHkXSRsOCtjM8fdie5F2NqPItfolKtKaeX+mNSQkddDR80dHa3PnfLxFZZJRW9M8CrmHE0AUlgth7kvkm40nSKDPAnygaMyzZ6R0E6u06cdAZnbGF+V5FatJYOF+lKiLxrEkU/4vG0dUm4vdKMuyx0xvNN4hXYa+tHUWNpLM2PGXvHkjv/RbT5cWWU7b3ieXeTJVPQtJT3Fqt3Khoi4/0JfbRT4wDpmvE3kY/vXWlusfvWcLi/TollVaITQJsB9UlwPuFepU7rZi6oOywTUIB86BiV2mc1jWL2gALch3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbeo1W0kc6JE0sdriLEolApq8ThXhkZegu9XWw8G07Y=;
 b=aIpnG3y5KWzlxLr/4rgVs7LrOKV1EnPYKOZxtRB9dKbeDTxet/9DZo7OTbnJ2mxzVp0WZNSpzUUp6tcU9ejfB05dpKlgoHNzTB8B0tSQKT5zXpdb+nLy8RdLyIwIHxi1I8snhFekid/UFkTLPh68BeR4N1tw1tDIOrWoaKMhSqk6emy/+s2XgOG6mfEfWiqrCW0sef8+owI0Uj+38WsKDj+0HXFDSGV8wwu+9u520BHyeAKLmRZS0hzm4/vlD+aBc3CIJ4tfUIVofNj7I2TRtaQDq6DxzeZ+Ajf1LnJW+xZBWD33cD+JUgm0fuVgSPl2ljb4jTLxqkNxZVJiLh56/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbeo1W0kc6JE0sdriLEolApq8ThXhkZegu9XWw8G07Y=;
 b=vPaZbtwXrjdLwVPXoYJ4fjZqxaFiTsYAx8HP0MuCfgiUFDGOycZfX7+kpzGSVOSNkwaLxQpSwBn+V4lDD+MkSGn/w1CYX8YeERiqpnGUeD/pqYya2LUtOTEhs70/kn1AXWXTibm0zRAahIOktV9zaRxL9Pfvdfdz12jeEirmXwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 08:27:39 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 08:27:39 +0000
Content-Type: multipart/mixed; boundary="------------J9NkWtLlvKkNGfkSUtE97dPW"
Message-ID: <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
Date: Wed, 14 May 2025 13:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 yuntao.wang@linux.dev, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterx@redhat.com, sandipan.das@amd.com, ak@linux.intel.com,
 rostedt@goodmis.org
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCRMT0TlpFvpRGYk@gmail.com>
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: ce269e1d-2b28-49d5-bead-08dd92c12fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkJmbHVMYlM4LzVYdmNJTVlMeEdXT0tJYU44UDNpYXB0UlJrN3ZrdGVEclh2?=
 =?utf-8?B?aXZ0SUZ4TlpWUWpyWjZhb2VhRlJ6S3RYYWJrV2ZnU05NNmZqc3ZKOVhQZWJh?=
 =?utf-8?B?VzEyZ3A2RmVsSENvOW9xNmRqY0ZWVnpGdWwyNEZQM2pWdDNpeDRsdWZhbm16?=
 =?utf-8?B?ZEpvV1cyb29YQ1AydkZyeUEyWGNtWDR5WWREeHFTRElHdzBhMUVDTW9IUGZo?=
 =?utf-8?B?YjAyalBQSmJxUHR5NFplYnNWYW1tOEdhZmxpUEdFUXpvOGZDa2JsckJGaW9R?=
 =?utf-8?B?a2lTUmxIdHViNVQvNGxCdlVtMDhCRjRvelQ1RkR6Vk5lVkR5MWxrQW5xdVBT?=
 =?utf-8?B?dXBPZTE3VTVKTGdJQXYyTFBwUFpObDlVemROWkRyZFIwMDJRb1FpU2pvY1RW?=
 =?utf-8?B?OXozMFNmcjgwcVVKc3NSc3pxZjlUbGx4eVQ5alc2QnVKRmNNTi92NEpoNXpX?=
 =?utf-8?B?YkRwWVhhcjVidWlVVURtMjBmL2hJUThGWUYxTndyRUsySzk1T2h1bzZsTnJ2?=
 =?utf-8?B?aE55bytBSk5sSUphWEF1cXB6cFlqMmt2dG43bEtEUUlLTm1YMTRzcVp3OUo2?=
 =?utf-8?B?c2srdzNJanZQK0ROTTVqWUlseXFkWjc4NHgvenBqOHU1R1JUcTY2eWh4bkQ0?=
 =?utf-8?B?T2ErcmdicEUrM0c3Ukx2ME5LaXZaUUFOK1VZUklpTXE4RXllOFRYL0k0VnMx?=
 =?utf-8?B?YUdzZWZvalorcUlLOURmWkZRS3NqdlB4R1lNeUlUYm85MWRVbGtSNEsvMmFS?=
 =?utf-8?B?VzdsR2dVT3FTNW5NOXFObTRSTWFqT0gzTXlYVlovUGFGVVY0d21Hc1h0cER2?=
 =?utf-8?B?Y2ZTNGdqQlluSGRzYUVaTkpYazhhbHI4UzBtUU5kcERBQU9wWnFRRkRLQm1n?=
 =?utf-8?B?bmI5dDVrWlUvTXRnUFBqZkRvVmR3ZTNRMHc0eXFWVnBmekpyUWUrRDVZdXE4?=
 =?utf-8?B?ZkFWajNyMUFObm1jNzZBVnR5M2l5Z2xXelJjcTJDV0lOazFmdWZUcTRlUDJ3?=
 =?utf-8?B?b3BkSVlqZ0VSS0N0VXNMUC9RYjRNK2dYM1VGMG1ucmVobDFPQVVubmtuMy9Y?=
 =?utf-8?B?ZzE5SlNkMm9xcEhhS2M0UFZNdS9hUUhNVm90M2FxV3lXbncvaW1VbDd3QTQ0?=
 =?utf-8?B?V3UyZzU4ODl0cTZVOFMzRUFYay8zY0JvY2RKbXQyTW9DSTVvOExOeGZLT042?=
 =?utf-8?B?NXhMbmw5NDByZUlFNU1lS1RkYTVHY1h5Z2pHc1hCSkF0bG1aemxNZGtIZmlT?=
 =?utf-8?B?d1UxRHpLUytOanZKNkFBTDBRVERtZWc2T3RKampGUStyNFV0YXFvaW5ReWEx?=
 =?utf-8?B?dmRLMHRVbjllWitoTXZ2b0NxN2Z0Ujd2SXg3UE92SnFSTklPaTNIZ0hvTHZa?=
 =?utf-8?B?VUVyUTByS3N3NllDYjBrVVZmczZDSklaSWphVVBXMExLcEt5R3BndlNMMDk1?=
 =?utf-8?B?b282UEQ4V0E0VnBFcXNEUlMweTMrZFRtZjl6T3drS2hFU21GZksxc3hHdkhE?=
 =?utf-8?B?cXByaUIzdDdJV3BJTm9RaitaNVZDdlBXdDdqenhwOFJuRWZkY3VtWXNjSHlY?=
 =?utf-8?B?eEE5SkdCaURaRUFZZDV1bzJHSW53eENpOWVUZFhHZzFYcGFCWXJjU1dGa29q?=
 =?utf-8?B?R3FFalNlc3pRV1lpaUF1aFVwQlNZMlhkYlpIdzU3VG5NQzdSODFMTlNrN3Za?=
 =?utf-8?B?QVpvaC9MTGwvVkl1Vlc0VTdYdkdvU09YWkhPZlFhRTdKSFlTcXdZb3cza2dL?=
 =?utf-8?B?dEhObndXbGViZGovUktORlorSDZWMDh0QWszcEQrSUgwemZ6eEJxVVM1RzBN?=
 =?utf-8?B?OFhMd00wS2w3bVIzcGY2dERCNzN2SHhFVnI0TVZFTU1wR24vclBxMkoxQlkz?=
 =?utf-8?B?QzJ3cUdtbUxLbTlpeit6TzBkY0JLUTErb3dyQ0hqZzNQVlh1WWNwUVVOd1dT?=
 =?utf-8?Q?nAXDxaA6FMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0RaNVhXRXhFMjlXR0NiSjU4V2oydE80WmpOT0dZemdXTDVuNDlBcHhkZ0pN?=
 =?utf-8?B?eVZTMy9aUGRXR1FDZkY1NTZhUHlmcjA2b29EdzNBcWF1Z05lbityVTdhNS9z?=
 =?utf-8?B?WXY0L3NwcXgycDl0V005Nm5BdWkyMncwaElZNWtJa2tFWFEvcklaVWNkb3Bt?=
 =?utf-8?B?TksrSFJvOThPbTZNaXg1QldNZDl0R25XdjV1UHc1bXV5UERhWkNDb1N0Qm1s?=
 =?utf-8?B?ZnVxYjJDYWRvUFE2UGFUNm1YNkxaUWRuR3k0V2JFa05iT1pka1B0UVh1Rzho?=
 =?utf-8?B?VXkraUY5aVZOeVdzMGY4TEdHTmEzNmVhL0xjQkc3VjhHZldOdkZyWkdOOC8x?=
 =?utf-8?B?cnhMVEo0bWhMdlg3YWFPM296cWl6ZmRseXVsczNkVDIxQXpvK1h0UFBqS1Vr?=
 =?utf-8?B?MG43c0ttQ0liMjQ5QmFlTGFIcDJPSlJneEpqVTdmbElUTFNNYTJXaDJaQmU2?=
 =?utf-8?B?NHo2WHVkRFkxaDE5R1BhajZxT3hXV0Q4QUVHRHpuRlIzSkNQbUJ6eHp6dE9P?=
 =?utf-8?B?bXhicE9DNkhtTnRNWjdia1diRUtvcmZRYkRYVlRGdFJIdGxZdHN2Rmg4amlt?=
 =?utf-8?B?TUc2YVlDVUk2ZnkzT3ZzVE5aVlVKUi96aDBYZThZTTBCN1B3NzRqbDhmKzd0?=
 =?utf-8?B?OStFcCtCU2QraVBjVlVNbDhaNnFoRXE1ZWRwck1DVVZZNlJQbnpPWkd2c3NW?=
 =?utf-8?B?TUoxVWM2aWpEc0hKL1VYaW44Rzk1bkE2OXRrOWZlbkZPRHRGY0c1SDBWUVZi?=
 =?utf-8?B?WmY3bXVLSWtLR0VwM3hUbm5hb2NUc0NpY2xwWDhXUVdzeWVvN3pYVlBrM3Q2?=
 =?utf-8?B?RktnemwwNFd6aURuZHRYcUJkckk3TnY4TzhOMXp3NDd6aTF0Ung3NDE5WTJ2?=
 =?utf-8?B?d2xxVm9VWmNLVmswNVNpWnR2YTQ3UGdkZ1IyTVU2Zk5rZ2dWbmlXK2J5aS9s?=
 =?utf-8?B?MlJLZm9ZdW1nVFRKdU8yY0hOUXVGVHVCRlJ5bk9kbHhTZDJsV0hEYUhRWk1H?=
 =?utf-8?B?ZlhWMnNtVDdLMmYwZ0pObU1jaEFxakNEU0FFVjFVOGZPT1FYaWdEQmZXYjVI?=
 =?utf-8?B?T0tKOVFvRUdEcGJjVVdqSnRLd3ZPWldSTXVUSDhwMkdkNUNNb0RmOFBVcE9R?=
 =?utf-8?B?Z2xLdHNwcE1YYm1qZXhENG1EWWZLbTk5RFlxbDBSQVQxVUFzVUNhUnNqd0dy?=
 =?utf-8?B?ck1Rakd4SkZqREo0dTdoK3pMZDJ3ZWN0V2VhRWpHQm0ybHp4OUFBb3NqUEFT?=
 =?utf-8?B?QWJWNHRBQ0N5MGw5RTdhb3ZieCtmQzlhKzJwbkhMa2pyd3RNaVg5VkRPWkg0?=
 =?utf-8?B?WEhYYVU3a0VhVGcybXA0SmNOMkNtemNpK3ptWUlMNU02djhTK0N4U094UG9M?=
 =?utf-8?B?a2dCZFZMNHQvdW84SUpUTmR5YkxNSXdSeFhJUWMrd1JwSDVKQVlPQ1ZPQTM4?=
 =?utf-8?B?UWIrT0xNV2ZCR3daeGVXelk3dXRRLzdBM0dxbjFUb0ljeEFJMTZjTXkxTm54?=
 =?utf-8?B?SUFweXh1WUZnNXJEYmkvNzFzcXd3bVlZNGNsb2NYc3U3TS9BTW9pa3RoMGhP?=
 =?utf-8?B?OGNremMza0ptTWxlbTAyUFdQWXZwMzY0R1o2azE3U1I5aVNuK3Z5Y28xKzY4?=
 =?utf-8?B?QUpuQUdHcjN2ZDNIdUtMTFF6MUxWOWpjb0Zubk52eWRhVHRpWlZTMCtFMWNY?=
 =?utf-8?B?SkpvaUhxeGdReFRobis1bUpIT1RhWExMaUdnODE5VkRoNmE3S0s5L1FRY2R3?=
 =?utf-8?B?S0tqUEpwdmw4M2owblFPeWpSZ05ydlhZcTJUQkpZRmY1NzVjZHpndHZQa0N3?=
 =?utf-8?B?NWZZYzVidm9XYVdzM09XazJUbWszTGtTK2Q2WFh0VWR6U3BiUTF0eHRHSWhQ?=
 =?utf-8?B?andUR2RJMndGb0NNUHphanluc2s1VGNUN2VtWjQ5RnRNeTJkYXRoNklKbWF6?=
 =?utf-8?B?WHArZ2p0UlEvUTB5UGU4R2VEbGpWeGpXQlJiTEpPSUpOTW9LSzBSYW9iNjd1?=
 =?utf-8?B?UzgycUNCSnUrejhIZDhybUc2TnpURWwxL2lLZDhScWk0YXNRaDRHMkNQTDYv?=
 =?utf-8?B?NGprRWVVbmhKTFBjc3lxZnRmU0pwWjJRRzZkaWZsTGs2UkdHWXU4T1ZocW8w?=
 =?utf-8?Q?TUJRKgtZFBlC/UmptOFMVi8hf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce269e1d-2b28-49d5-bead-08dd92c12fd4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:27:39.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l20ZueUywtKfUp1T/2SWfOa5WY9EOg/RhYcinpozF6flrytvqs4lq0SUKR418rt2Tt9U7a2ezr6RJhhICNZ8Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

--------------J9NkWtLlvKkNGfkSUtE97dPW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2025 1:24 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>> Warnings generated with 'make W=1':
>> arch/x86/mm/pgtable.c:623: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
>> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
>> ... so on
>>
>> Add missing parameter documentation in page table functions to
>> fix kernel-doc warnings.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  arch/x86/mm/pgtable.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index f7ae44d3dd9e..8a5bc4545ad3 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -614,7 +614,7 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  
>>  /**
>>   * reserve_top_address - reserves a hole in the top of kernel address space
>> - * @reserve - size of hole to reserve
>> + * @reserve: Size of hole to reserve.
>>   *
>>   * Can be used to relocate the fixmap area and poke a hole in the top
>>   * of kernel address space to make room for a hypervisor.
>> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>>  #ifdef CONFIG_X86_5LEVEL
>>  /**
>>   * p4d_set_huge - setup kernel P4D mapping
>> + * @p4d: Pointer to a p4d entry.
>> + * @addr: Virtual Address associated with p4d.
>> + * @prot: Protection bits to use.
> 
> How about using the same capitalization you already see in this 
> description?
> 
>>  /**
>>   * p4d_clear_huge - clear kernel P4D mapping when it is set
>> + * @p4d: Pointer to the p4d entry to clear.
> 
> Ditto.
> 
>>   * pud_set_huge - setup kernel PUD mapping
>> + * @pud: Pointer to a pud entry.
>> + * @addr: Virtual Address associated with pud.
>> + * @prot: Protection bits to use.
> 
> Ditto.
> 
>>   * pmd_set_huge - setup kernel PMD mapping
>> + * @pmd: Pointer to a pmd entry.
>> + * @addr: Virtual Address associated with pmd.
>> + * @prot: Protection bits to use.
> 
> Ditto.
> 
>> @@ -745,6 +755,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>>  
>>  /**
>>   * pud_clear_huge - clear kernel PUD mapping when it is set
>> + * @pud: Pointer to the pud entry to clear.
> 
> Ditto.
> 
>>   * Returns 1 on success and 0 on failure (no PUD map is found).
>>   */
>> @@ -760,6 +771,7 @@ int pud_clear_huge(pud_t *pud)
>>  
>>  /**
>>   * pmd_clear_huge - clear kernel PMD mapping when it is set
>> + * @pmd: Pointer to the pmd entry to clear.
> 
> Ditto.
> 
> Thanks,
> 
> 	Ingo

Please review the revised patch with suggested changes.

Thanks,
Shivank

--------------J9NkWtLlvKkNGfkSUtE97dPW
Content-Type: text/plain; charset=UTF-8;
 name="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Transfer-Encoding: base64

RnJvbSA0NGUwZTdjZTI5ZGMwNjg5ZGI5NTgyMzBlMDI1OWE2MjQzYjRhZWQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+CkRhdGU6
IFdlZCwgMzAgQXByIDIwMjUgMTE6Mjk6NTkgKzAwMDAKU3ViamVjdDogW1BBVENIXSB4ODYvbW06
IHBndGFibGU6IEZpeCBXPTEgYnVpbGQga2VybmVsLWRvYyB3YXJuaW5ncwoKU2FtcGxlIHdhcm5p
bmdzIGdlbmVyYXRlZCB3aXRoICdtYWtlIFc9MSc6CmFyY2gveDg2L21tL3BndGFibGUuYzo2MjM6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdyZXNlcnZlJyBu
b3QgZGVzY3JpYmVkIGluICdyZXNlcnZlX3RvcF9hZGRyZXNzJwphcmNoL3g4Ni9tbS9wZ3RhYmxl
LmM6NjcyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1lbWJlciAncDRk
JyBub3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCmFyY2gveDg2L21tL3BndGFibGUuYzo2
NzI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdhZGRyJyBu
b3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCi4uLiBzbyBvbgoKQWRkIG1pc3NpbmcgcGFy
YW1ldGVyIGRvY3VtZW50YXRpb24gaW4gcGFnZSB0YWJsZSBmdW5jdGlvbnMgdG8KZml4IGtlcm5l
bC1kb2Mgd2FybmluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFt
ZC5jb20+Ci0tLQogYXJjaC94ODYvbW0vcGd0YWJsZS5jIHwgMTYgKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCmluZGV4
IGY3YWU0NGQzZGQ5ZS4uMGVlMDE5OGRmZDU0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wZ3Rh
YmxlLmMKKysrIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCkBAIC02MTQsNyArNjE0LDcgQEAgcHVk
X3QgcHVkcF9pbnZhbGlkYXRlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBs
b25nIGFkZHJlc3MsCiAKIC8qKgogICogcmVzZXJ2ZV90b3BfYWRkcmVzcyAtIHJlc2VydmVzIGEg
aG9sZSBpbiB0aGUgdG9wIG9mIGtlcm5lbCBhZGRyZXNzIHNwYWNlCi0gKiBAcmVzZXJ2ZSAtIHNp
emUgb2YgaG9sZSB0byByZXNlcnZlCisgKiBAcmVzZXJ2ZTogc2l6ZSBvZiBob2xlIHRvIHJlc2Vy
dmUuCiAgKgogICogQ2FuIGJlIHVzZWQgdG8gcmVsb2NhdGUgdGhlIGZpeG1hcCBhcmVhIGFuZCBw
b2tlIGEgaG9sZSBpbiB0aGUgdG9wCiAgKiBvZiBrZXJuZWwgYWRkcmVzcyBzcGFjZSB0byBtYWtl
IHJvb20gZm9yIGEgaHlwZXJ2aXNvci4KQEAgLTY2NSw2ICs2NjUsOSBAQCB2b2lkIG5hdGl2ZV9z
ZXRfZml4bWFwKHVuc2lnbmVkIC8qIGVudW0gZml4ZWRfYWRkcmVzc2VzICovIGlkeCwKICNpZmRl
ZiBDT05GSUdfWDg2XzVMRVZFTAogLyoqCiAgKiBwNGRfc2V0X2h1Z2UgLSBzZXR1cCBrZXJuZWwg
UDREIG1hcHBpbmcKKyAqIEBwNGQ6IHBvaW50ZXIgdG8gYSBwNGQgZW50cnkuCisgKiBAYWRkcjog
dmlydHVhbCBBZGRyZXNzIGFzc29jaWF0ZWQgd2l0aCBwNGQuCisgKiBAcHJvdDogcHJvdGVjdGlv
biBiaXRzIHRvIHVzZS4KICAqCiAgKiBObyA1MTJHQiBwYWdlcyB5ZXQgLS0gYWx3YXlzIHJldHVy
biAwCiAgKi8KQEAgLTY3NSw4ICs2NzgsOSBAQCBpbnQgcDRkX3NldF9odWdlKHA0ZF90ICpwNGQs
IHBoeXNfYWRkcl90IGFkZHIsIHBncHJvdF90IHByb3QpCiAKIC8qKgogICogcDRkX2NsZWFyX2h1
Z2UgLSBjbGVhciBrZXJuZWwgUDREIG1hcHBpbmcgd2hlbiBpdCBpcyBzZXQKKyAqIEBwNGQ6IHBv
aW50ZXIgdG8gdGhlIHA0ZCBlbnRyeSB0byBjbGVhci4KICAqCi0gKiBObyA1MTJHQiBwYWdlcyB5
ZXQgLS0gYWx3YXlzIHJldHVybiAwCisgKiBObyA1MTJHQiBwYWdlcyB5ZXQgLS0gZG8gbm90aGlu
ZwogICovCiB2b2lkIHA0ZF9jbGVhcl9odWdlKHA0ZF90ICpwNGQpCiB7CkBAIC02ODUsNiArNjg5
LDkgQEAgdm9pZCBwNGRfY2xlYXJfaHVnZShwNGRfdCAqcDRkKQogCiAvKioKICAqIHB1ZF9zZXRf
aHVnZSAtIHNldHVwIGtlcm5lbCBQVUQgbWFwcGluZworICogQHB1ZDogcG9pbnRlciB0byBhIHB1
ZCBlbnRyeS4KKyAqIEBhZGRyOiB2aXJ0dWFsIEFkZHJlc3MgYXNzb2NpYXRlZCB3aXRoIHB1ZC4K
KyAqIEBwcm90OiBwcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIE1UUlJzIGNhbiBvdmVy
cmlkZSBQQVQgbWVtb3J5IHR5cGVzIHdpdGggNEtpQiBncmFudWxhcml0eS4gVGhlcmVmb3JlLCB0
aGlzCiAgKiBmdW5jdGlvbiBzZXRzIHVwIGEgaHVnZSBwYWdlIG9ubHkgaWYgdGhlIGNvbXBsZXRl
IHJhbmdlIGhhcyB0aGUgc2FtZSBNVFJSCkBAIC03MTYsNiArNzIzLDkgQEAgaW50IHB1ZF9zZXRf
aHVnZShwdWRfdCAqcHVkLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdCBwcm90KQogCiAvKioK
ICAqIHBtZF9zZXRfaHVnZSAtIHNldHVwIGtlcm5lbCBQTUQgbWFwcGluZworICogQHBtZDogcG9p
bnRlciB0byBhIHBtZCBlbnRyeS4KKyAqIEBhZGRyOiB2aXJ0dWFsIEFkZHJlc3MgYXNzb2NpYXRl
ZCB3aXRoIHBtZC4KKyAqIEBwcm90OiBwcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIFNl
ZSB0ZXh0IG92ZXIgcHVkX3NldF9odWdlKCkgYWJvdmUuCiAgKgpAQCAtNzQ1LDYgKzc1NSw3IEBA
IGludCBwbWRfc2V0X2h1Z2UocG1kX3QgKnBtZCwgcGh5c19hZGRyX3QgYWRkciwgcGdwcm90X3Qg
cHJvdCkKIAogLyoqCiAgKiBwdWRfY2xlYXJfaHVnZSAtIGNsZWFyIGtlcm5lbCBQVUQgbWFwcGlu
ZyB3aGVuIGl0IGlzIHNldAorICogQHB1ZDogcG9pbnRlciB0byB0aGUgcHVkIGVudHJ5IHRvIGNs
ZWFyLgogICoKICAqIFJldHVybnMgMSBvbiBzdWNjZXNzIGFuZCAwIG9uIGZhaWx1cmUgKG5vIFBV
RCBtYXAgaXMgZm91bmQpLgogICovCkBAIC03NjAsNiArNzcxLDcgQEAgaW50IHB1ZF9jbGVhcl9o
dWdlKHB1ZF90ICpwdWQpCiAKIC8qKgogICogcG1kX2NsZWFyX2h1Z2UgLSBjbGVhciBrZXJuZWwg
UE1EIG1hcHBpbmcgd2hlbiBpdCBpcyBzZXQKKyAqIEBwbWQ6IHBvaW50ZXIgdG8gdGhlIHBtZCBl
bnRyeSB0byBjbGVhci4KICAqCiAgKiBSZXR1cm5zIDEgb24gc3VjY2VzcyBhbmQgMCBvbiBmYWls
dXJlIChubyBQTUQgbWFwIGlzIGZvdW5kKS4KICAqLwotLSAKMi4zNC4xCgo=

--------------J9NkWtLlvKkNGfkSUtE97dPW--

