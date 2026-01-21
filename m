Return-Path: <linux-pm+bounces-41217-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOUrGFWHcGkEYQAAu9opvQ
	(envelope-from <linux-pm+bounces-41217-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:59:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BD5327F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DF4830BF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414646AF2F;
	Wed, 21 Jan 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C51WoeAy"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E546AF0C;
	Wed, 21 Jan 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982338; cv=fail; b=oS9B2N6ohmk5PGlSsRwotAaLqd0he6Bwc/ZKN1P48lAcK87dEfA+5YGlI+8z3H6kFqcQymsA675pM9m3wFPpna3QDwhqRq4nNyE9P5FsC/vysEvN5OgN2UmlODZ+/2jHGKAu+EsjD7DdB+tX+TD7aW7PlGrGD56NBEe8CBwQdUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982338; c=relaxed/simple;
	bh=O4w65Xpacdw2iqHQ8yvdMeuMCB01bt6QSiO1VU1MJPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUCC1aj8gDkZxMOjsyldeYqrPKBaaI2k7ppAxaYGFe8R4dNtHhNOoUGB7XXhSc5acDonMMkoBfrQ5DbDN5f7ew1WpThk0pN0RjtMCg3EG52bkk7VnGLEUHvdOdT91eKBapRiw8h0biCmKQuQ9c0GHII4o6ib0gsOKG1uA3U+/Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C51WoeAy; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCu4hdWy5CgaFI6w6W1kF+JnWeGUzBzLsyDX3kkblm0qrUReh5gMDlNr5VSm1WfNS9eGwX3wFxW9FyfL0f2qUkbf94XaIFt5ar5VDB5hTnMw+j8vgh6rqihiAppa4Wydh3P5laxZNFnSZ/opgEJqamvOacC3BXhLpzJ47J/uBiX+YqXswhx0I/njMhszCxePptwyQ9+xgZdDZye5Ttxi4YA6GEAW9foqpoGsY3+84GYJGoQ8gBtgbgG36/rWcA5hWfF2iNBUJiu0F6IzGF9prYBPfChT7Py9gDq2vs6Ymt9r8oKOEn5aRAgQO6Qcdmwyx7RNtjj4HPfQ5AX5hs856g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWbWZMYrAhbdToz6LYA5cX1a+Q/hrke6tnA7UKh3aZw=;
 b=LrZ5gxhrvl9sm9xrfhiqHMP7x7mehcVFMa7u/lEkm87oxKPsdc1o8AXxeOg4XHOiojTdiiiUKoZQZ+mMvriK5bVv2M8Ch+/bgC/m8suD2BAQmWTq6ke5JW+wAJAKWiAWDBkB0eX9rHT5XPwg4zcEUPy/6TQBn2vls02O6BC9A5sLqFIyiDKbAQQXTZ7xQzE5UiapqNpwT7YLbVp9q5gKUlsPUSiM1gcAeEiAq39f2ytecIRr3aP3FArAA22UzohhQ4RYL/fH7eOhh3ND25LRWc5jlJCv+RBUb/X7Ur4TESPEb/4NLjl6TIXHOFTTY1ozu8mIWKj9qK85U2WbrLoO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWbWZMYrAhbdToz6LYA5cX1a+Q/hrke6tnA7UKh3aZw=;
 b=C51WoeAy3XOP6duuHEgkl32lPFAcKAgBhG+pxk2/SSdmWCJd0tHgYF36qGAJx5JBx57hfAjGcdr15LjBfSaH6c8tm/qNuuebpbgTfCC86fZ0qcWDKMWEoPPw2xSFTHG+s8S04qNO+/vP5ppKgt5424hk9FqYJBUklsnIzGzjr4pqDPsCCEMoT3yKkRtRqPMSWSttfTvZ5H6rrEziH/eYH1HhwA4CPK0wkwbwqJ88o3muH+6XhHh8LIb5OkPDOsa9CTQMsa91kFNcDOgDnIEWw76HvxDahNyp7RxtZlXC1yo+4b8EaZgqvUf3S+Cleb3InI7RRP30euuD3Xk2PwctqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 07:58:50 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Wed, 21 Jan 2026
 07:58:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 12/12] ARM: tegra: add DC interconnections for Tegra114
Date: Wed, 21 Jan 2026 16:58:47 +0900
Message-ID: <7513834.DvuYhMxLoT@senjougahara>
In-Reply-To: <20251125120559.158860-13-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-13-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe43475-a6f8-479b-b289-08de58c2e9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVpDYllMNGY5V1hUS0p6QUM4RVJXWEhsNWI3ZEJtYmpPTkQzL1BmSXRKMDQr?=
 =?utf-8?B?dm9kSXFzS0RwMUZ2YXhEWXVXUDd1T0pyZVhoeXJqTllnKzZaR2ZJbVN0VkFJ?=
 =?utf-8?B?blFlV1V2N2hGZTdWUmVSMzlUVi8weWd2azBvYlBXb0w5MllTZHkyQ0FwZHNZ?=
 =?utf-8?B?bnd1WFhpUjFRU2JDZEZ3aldja3BwbFRoWm51aDNkamdvWFM2UGtEcTgxZ2Va?=
 =?utf-8?B?Y0NBQ0wvdzAzWVJ3Y0diRk1xYWJBb2VRVyt4KzlaVU1qWm11Mi9rSEhzQzhw?=
 =?utf-8?B?Sy9lRCtCdWdBcWIySnhMNXkvYy9lR3l6MVhJVTM1RmVtLzZWSVRoaUxKeVpP?=
 =?utf-8?B?VFJvZERSTE42TGsraUF2S3FQdHFzbmRTQVM5Qk1KTG13Wm5iWmMrMVJCaFlU?=
 =?utf-8?B?OU5UMFMzZVVVYUY3bmIxZnFiYTVRTGZUNUllS2NMdEMySEVjOGdFSndCWldH?=
 =?utf-8?B?alJkTWlMN2RMQ3V5anlaOGJXZGZteHovWEJKRlN0U0pqVFRxWDgxMUtJS1Zk?=
 =?utf-8?B?M0VDNG9pV3J5SE9GcHZESzhOYkpGRGtzamdkcXNIdFIyMk84bWNBNVFDWW15?=
 =?utf-8?B?OWRHTXMzeFJUeGM5NFdFNWFQSWNRVUlXYmdyZDZaZlREMmsyK1JxWEorTXdn?=
 =?utf-8?B?OXI5Ry8vQlJQeHJoV3VDekxEdUNLcXdVN1JHU0RhS0RzOVk3d29DMWV6ajNH?=
 =?utf-8?B?dVlWSWRqOUpyTXArRDFtRWp4QitDeHN0UmJWalRaaGRidmRrbEU5NW41N2R0?=
 =?utf-8?B?Z3lLNUlpYUFrQTFrbDJsU2lZQm5FWkNad0g2VVhjK1FhTDV3WlJ3RXFTZ08z?=
 =?utf-8?B?cGkzQitwUUJVUW52bWcxL1FHUWRhSldwSUZtRzFoclVPR3d5R2hvL3dtMmZN?=
 =?utf-8?B?ajdmSzNWZkRCNWk1MkwwQ0FYZmRPUGNURHhDY2d5bml2VlJQaDVlei9sanlW?=
 =?utf-8?B?aldNcmVSOTZaNlZpSG05dHdUdFEzOHF5aHk5V2p6QzRtbFV2NHhGTnBMcThw?=
 =?utf-8?B?N1VOQWdSc0VVOE5MdVVUcVJDQzNHalRCOUxmNVp2Z2tPL1lxWEJIcS9hREht?=
 =?utf-8?B?UEVGVVNOSFZYa0NrYWptWE5veW9SclhqME5Bb3prZVJNTkFPK0FYWXBadFZE?=
 =?utf-8?B?ZzR5OFVib1FUSmlHdEpVSXVHc3hNQi85aWVZa0NqK1U1M1A4eGtqTk13NU5j?=
 =?utf-8?B?ZjZyUXEzYUtPcWFqaGNnc2l2MGkzZll4SHJaSmM1YUw0RFF1Tmx4QWxxbWtp?=
 =?utf-8?B?RVJmM09ZaFJzQUpYNGNkZDJZa0lxK2lhTkRIbTgxKzRWMDdDWTl3SWVQeTlQ?=
 =?utf-8?B?N1MvNmhtUWg5MnkwUTlGYVFQUHpVTytzeHNUOHdWTUdadGlZWCsvdk5BbkI3?=
 =?utf-8?B?VnZXZWQvK08vYWErUHN0c1hTUmVJS0UyK29FalVqbVoxVGdTVXBiaThtVm1n?=
 =?utf-8?B?U2dEbGlMZlRFRzZCLzhtRTdscitNeElsKzAxZmN2ekxxd0ZqNlFOM0tLSGlL?=
 =?utf-8?B?eit1VmNNVkZwYnRKL3pZUFVzQzhmdVN6L2dkQzRSaTExT29FSDBMRUkwT1lU?=
 =?utf-8?B?dTIvOTZpYVFmZjZPYVJENHdmeVdoVnhwcjl1dlJ1bFBNVFNrWllDRnpVcjJv?=
 =?utf-8?B?ZTVoUDZ3c1dVM2g2TDBwT0NUTmJGREpIWUNPaCs0Q1VoSFM2NFU0elB3TDkv?=
 =?utf-8?B?eFFvS0NEVEpJS2VwaDhadlBmbFJ1NzV6d3lwRVJuTU9oSjIwaTJmRk8reXpE?=
 =?utf-8?B?eGJEenRnNEtxNzhRRHZBSUxINGhEVFZnUE9ZU0ZRMzVLZ1J0b0Zhd2ZzU3h4?=
 =?utf-8?B?UHptSGFmT3VvQ2YvcEg0U1VSVUx0anZCSHdhSUtEa3crOHNxb21ZTTA2TjRQ?=
 =?utf-8?B?dmJMbzA3aXpacjlGamdTSGhpMml4ak5rL25MdXdPVjJLQkd5NlllVnEvWHNj?=
 =?utf-8?B?aGtnVmZqY2kvV0pycDVmWGRITWFQb2RoaEg3M1Q0aGVtRzlPVkVhaHB4SnhI?=
 =?utf-8?B?S2pyc01HTFdVWVplVU9jditUMHdTQTExT1JlWTAzOEdvMzVScmZiWi9ZTEtH?=
 =?utf-8?B?dVlzWEkvMmQ0VUZEYklydkprdDcyY1ZZVlVNVkxzRDBjNGpnQzdyQ3lVMWJk?=
 =?utf-8?B?and4Z0E3MFE4UEdaSU1XRVlBUUowNm8rRHk3Z1hwNkFxL3FFaUxTN0NJRC9j?=
 =?utf-8?B?QlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDhsbjloTmEvNXhodFBUSlRFc3JiVDhzRTJWeVJYa3JGd1NhZHB4UWt6cEdB?=
 =?utf-8?B?UWNmaFhaY3F4YlNKSnpKcUVaRHNhQzY5VmJnNjFOM3g5TEJVZGhwZFMzRVlH?=
 =?utf-8?B?ZmRVb3VQZHBHZ1Z4OG9VY2lsOWppRW0rVnlMYnlpK1RGenNoZlh1MFJiYVFr?=
 =?utf-8?B?QkUyM0R1akxvSGlla21NT2gxYWlFUDVXd1oxRElsTWx6TFhhWXpiblA4Z0NS?=
 =?utf-8?B?Rkd2Um1YamhHcE4xUlZlMWhoVFpHQWg2VTY2RzYwNlB4NCt3UHdCeXJEaVBa?=
 =?utf-8?B?RHYybUgybEJKazFlSTQwc0o2Rlhwd3ZOS1FxSWRIMC9qa0hWKy9CeEVJRm5R?=
 =?utf-8?B?Zy9lczNhei8wT0NLVk5EYnNIem40RmNDR2M0NDdTK0JXRlhDNnFaUytsMnNT?=
 =?utf-8?B?UzFzNTEwalUyVWpiZXI5aUtKdmI1dXpuZ2xYblpaZ1p6NzZ6dm51eDg2dHlG?=
 =?utf-8?B?NHpUM3BxcDVLQXZjN3IxQ1I3RkNpTXpDMUJ5dDBQZ1I4UERoRHMvZVNqSWMv?=
 =?utf-8?B?RU5tTXNkRGxPemhXT0xrN0dNY1NXNlJ2K1FUU2NESzIvS09taW5FWmlhZlZh?=
 =?utf-8?B?ek5hTHMvbzAvRW1XWnJNd1ZybkxhSVFSNmVpd2tOMjcwL2lsNDRDRVg1Tmwx?=
 =?utf-8?B?Q0N0dWZWdUk2NThhNVdBbWdEb0FWVXZwL1FHWnZKK3BVblBVZG92ZUVFdzlw?=
 =?utf-8?B?cW9JMmNNZFAwaUZOTjVhaG0xajg0RU1SYnpGeHc2YzdzSFRiakZXeTBvVmtY?=
 =?utf-8?B?dStLczBWWmhkeDhxS1JIWlNUbFVkY2FHQ1BZQXVZU3pjek83alBsTlhPOVZK?=
 =?utf-8?B?a0lqaFFsVTZZRTFyR1RyM01wL0ZmeGREcEF6dzBwRFFsUnRuVmtVY2szYmM5?=
 =?utf-8?B?em1nODhzNkRudXJHUlhUSldsY2xhNTBqYUl1SW0rWWFQeHdXNkwzSmZkcUJn?=
 =?utf-8?B?bnhnbllpNGFxejUwOVIxYlhpR0xzSTN1R3dERC9iTDVvblJDaDZkeWlCUG1B?=
 =?utf-8?B?amtzZzBtS3RQNmU3SEFpbTE1VUpIeEkzSlpvT0Nwb2czQmF5c0lIM3JmcXRQ?=
 =?utf-8?B?TVpaTXdRQmthSWRvM2JZamx3SmtDSVJ6azVteEM1ZUsybVV5T1BPTnZkTTE3?=
 =?utf-8?B?MEtpNWtRZUttSW9NN1VFVlR3UmhJNVQrcFZvdzhDQno5OEFvRHpQazVoNEZ4?=
 =?utf-8?B?WXduWHROamFDRjBDSjRDWWdudlk2eFBBOHdjQ0RxZG4va3dDaXJhbmlrbzZW?=
 =?utf-8?B?cXBhTFk0Kys2Y3MzSkl3V3NKMkVtQnR0ejdFODVZRFR3ekJBdlN3cEc2Wk02?=
 =?utf-8?B?NE13S05tTENsSlZraUhTcWx6VkFoN2RsUmVSbDlIT0xxQ0JBRDBKV3VhbG1I?=
 =?utf-8?B?K2FmSFNXSDBDTHBtdXl5M29qZTBPQjRaWmFrVjhaMXdnMW5xTzJqaVZ0ZVpp?=
 =?utf-8?B?bTBndUFZWlVwNmhmNFlnWjQ5YWlNZmJwYjdMOUhQejFSbjR3NTNid2Q4SVg5?=
 =?utf-8?B?QVFRaHdSYk02eElHTktSYS9CaVBIR1owMU1TRERjMk1oWnN0dmw5cVJKN1NE?=
 =?utf-8?B?alcwc1ZkblBodnBXN3VCU0NQU0VicllubmJ0a2xGU1RMZFBCV2EyMHdzN3ho?=
 =?utf-8?B?T2JwRUZUb1FaVzVIQ3lPL2RlRUNJZEJrWmpjb0ZLaVFOcVNmNlgwU2xhM3BF?=
 =?utf-8?B?enBVdmE4ZFlJbzd6bXE4RFp4TDFIUG9wUXNoc0FtbmNwdDFrREtucWtHNkti?=
 =?utf-8?B?d3B3UlZaKzRkRlFDYmVZb1ZnRkorVy9iTHJjdVFTZDRrT1R2Z2FXWmFiRnhq?=
 =?utf-8?B?akxPMDBaV3cxTEN1QVpzMUxOc1ZtMlpVVk9aR1p3cjFZN0RITHY3YXIwZTA3?=
 =?utf-8?B?OHdsSnlVbEROV2VCMGpsTjNUWVFzejdaNHJaYnQ4MWRoK2pPWVp4MzFFN1I4?=
 =?utf-8?B?UG5GZmxlUUhONVorZ2RlQjNOVnM4eUlNdzNEUkJUTTVXVWZpUWNIRy9vK1h3?=
 =?utf-8?B?RHNnc3JZc1BHVWdHMS9oZ21TR0RQUHBWaDB1K29CcDdESE5aZTJUVDR2aXYz?=
 =?utf-8?B?ZUdIeGNWdEJJMndiaXlrZm1UWkY5c0F0U2l1MWNZM0d4VDA0ZllKbkVXbzZS?=
 =?utf-8?B?VE5zNXRDMDVPSTRXQVNpRFl2cVhQTVdxM0RDWmQraXhvM2dielFTbkprZFdm?=
 =?utf-8?B?WDl5Uk9hZDRtd2xZRzdDRVZnamJVdTYvWVFlaXQvVEpRbTFJT21XcXdhdU1K?=
 =?utf-8?B?L29MQmpPbFV4U1RMSjFyczMyZnRCQ2Y5K2FVQWZSeXg2RHZ5eHRNODlsT1Fr?=
 =?utf-8?B?TXJkTm8rREkzYW5hZjJYV3ovSzRJKytIWjJFdHlUWEJ1WkhkUUFzeUdtejNW?=
 =?utf-8?Q?Dj6igYuK3hMQEn6iYKiv5Sxu55ZgbvSZ2e7yWfjY8RLH0?=
X-MS-Exchange-AntiSpam-MessageData-1: cCSj6YuINTbUyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe43475-a6f8-479b-b289-08de58c2e9f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:58:50.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxsuWx5ueYTez9Z2z63KvLwY9H1LSi0QCC43IrniL5y4iBTrrtfRFbJlj6mAfqg6Lt+76DDPQZLUjIzovx5Afw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41217-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nvidia.com,gmail.com,baylibre.com,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_PROHIBIT(0.00)[3.59.163.0:email];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,3.59.6.192:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4F4BD5327F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add DC interconnections to Tegra114 device tree to reflect connections
> between MC, EMC and DC.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/n=
vidia/tegra114.dtsi
> index 6221423b81d1..732f8b5b4eed 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -125,6 +125,17 @@ dc@54200000 {
> =20
>  			nvidia,head =3D <0>;
> =20
> +			interconnects =3D <&mc TEGRA114_MC_DISPLAY0A &emc>,
> +					<&mc TEGRA114_MC_DISPLAY0B &emc>,
> +					<&mc TEGRA114_MC_DISPLAY1B &emc>,
> +					<&mc TEGRA114_MC_DISPLAY0C &emc>,
> +					<&mc TEGRA114_MC_DISPLAYHC &emc>;
> +			interconnect-names =3D "wina",
> +					     "winb",
> +					     "winb-vfilter",
> +					     "winc",
> +					     "cursor";
> +
>  			rgb {
>  				status =3D "disabled";
>  			};
> @@ -144,6 +155,17 @@ dc@54240000 {
> =20
>  			nvidia,head =3D <1>;
> =20
> +			interconnects =3D <&mc TEGRA114_MC_DISPLAY0AB &emc>,
> +					<&mc TEGRA114_MC_DISPLAY0BB &emc>,
> +					<&mc TEGRA114_MC_DISPLAY1BB &emc>,
> +					<&mc TEGRA114_MC_DISPLAY0CB &emc>,
> +					<&mc TEGRA114_MC_DISPLAYHCB &emc>;
> +			interconnect-names =3D "wina",
> +					     "winb",
> +					     "winb-vfilter",
> +					     "winc",
> +					     "cursor";
> +
>  			rgb {
>  				status =3D "disabled";
>  			};
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>





