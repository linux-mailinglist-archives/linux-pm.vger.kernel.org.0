Return-Path: <linux-pm+bounces-22762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B15A414BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E177188F349
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC011A4B69;
	Mon, 24 Feb 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yw9EcbNC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10AA32;
	Mon, 24 Feb 2025 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374806; cv=fail; b=HM21ib7YrL1EpjsV1EJ0KYx2ccoIdVein6HHxDZgtjosKKjVZreribaLuXu+UUxxR6g34B0GGxRI9Bsi8PeG0w0O3CsZCW/5qTfJ/IezwqWm+GiErtwVmHJUl8aXJShQ0r/eJF7x0b1/ttUa4mOu7nUIXR8bBPF9ISkyx/fBoos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374806; c=relaxed/simple;
	bh=f6A/dmZ7N60iUbPtWiipaH2fQfGv7TKmQNHnnc1Aj8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2A173GeeT6N9V/cYeslztkI7stMn2r7O6vFPlN63Jd6eYmZGRtm4OijhFtA3hg1RYYNT3Q4gJqpPAKelo1Cg3mRElEXZf9NnRNhU2KQHXTVXdtRo7IrhGSHgc0tPokz3NggMy61Q4BckxSlHR7tBecaHmdtpUF08mA0jtXiSlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yw9EcbNC; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEbSU3mUFX0pacQXOdHfrmIRNn+2CkOk+7bnoDhKBalEI6dgUzhgtxNL1qKAnq3obMKkW6SUgPOQCEjUR7Kjr9IdqW2J3QfTcp8kuit09zSTiYBvcWSM3W/xGyod+W6vlBvaPCysaTCoRRmrFuLoc6N8vMHB2S/AjtjRyY61OYp/NvLf6/7o6aGW+RKJxsaNUveXXW5GbREhkfUk9AQvQ8WmR65anCijY2BYUXdj6WBhRNsHT+8hfvj5GmshD+VuZ55PdK07zpzDouxn3zpynnR0LoV3xnF9GzNyKSo98hcQqILDbTImPmjG1tYAGsok08JSyAGANxooV/D19C8rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTcn7F3FsACvUTtCq3wDamxDayf1URSY1hsT88cNCiI=;
 b=nEQstEyoQ/IeZ8bh6LMLFBsax3rPenIFOzSnwqbc+o3mL4p70Q0A2WlQO0i87//q+1lwHQoIrWbGP52J1BaIaxsMAt2cXGlTzdug6ZbhKRiepA4kWQX17MMTpN53E0zn4m9VkUoN6/9dhjo/Ql1U+RbmA2QKKzFtwmx1Ws5d1az5Z20RzscmQYjLDzJbueffOaY3C0f04m3y/jG1I3wKFmitlfboiwS/HhGTUh6UkEFVlJJAvSaRt+emVGgaiDLe6XxAI/H0kD2JlyygefpM/eIWgzo7ceVt5SBwUV6zeL6JHkat7Wm3XwGr8yvlE7J1D08YdSr8rVycesET7vY9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTcn7F3FsACvUTtCq3wDamxDayf1URSY1hsT88cNCiI=;
 b=Yw9EcbNCjISEnTSzoCAhVN7htepnnx2VE/uS7TAnzC+pq9hgd2zRBKJ0X7aXq0G8ljhv3PU2q9DX6K9r40gid3+hx/2as08l/YxQxzdMFhvfKfXx0x/chQX93uc58w36Pd2onppc0eUZnqrZFjHG8PjSz+ff6rSVzmSmBlKT840=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 05:26:41 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 05:26:41 +0000
Message-ID: <7f7c9eea-c7c9-4eeb-b3aa-ec29a9c0f2ea@amd.com>
Date: Mon, 24 Feb 2025 10:56:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] cpufreq/amd-pstate-ut: Allow lowest nonlinear
 and lowest to be the same
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-9-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-9-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e4fa6f-f661-4616-1db2-08dd5493d1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qy81Y0g3bkFuVVI2eWtwM2YwRVFGVGlGUDloUXg1elVLeXZjV2VPK3lCaVJC?=
 =?utf-8?B?U24ydktxL2toNE1SMFV3MG9oMXRWd0d0SmhzYVUxUFFRNlowQTkrd1lVMUVl?=
 =?utf-8?B?QWkzY0w1YjhZb25xQmY4TkdlZ1UrbzRJTVpmRm1wNzVhVlUzSVI4QVVLTEpM?=
 =?utf-8?B?WUJqRFlDSkpzVHNua284TGNHMlFrNHZXY1VrKzZtZ29XTXFMTU44Um9VNThm?=
 =?utf-8?B?MGRBYnR6SFYyQllUbTBFVEVJdzVNWkhvZWRJZThsbXMxY01yYUV1SC9mUXI4?=
 =?utf-8?B?VXhUYm9JdzQvOUxRenp6SytZTmZYdkNzSDBDZVY2WjVzcCtXNjVBc0JadENK?=
 =?utf-8?B?OU1yRVRvU2hHNDR3VVB5b1dBN0tHOHlMM01HWmFnZ1U0bElrMFJYU2MyVnhX?=
 =?utf-8?B?UmxrUTBXVE5CM0dZUkhDV3I4ZjZNd25tWlRCU3p3ckhWaEJFaGsxNDE5THMz?=
 =?utf-8?B?SXZYZHgrdnA2T3QrcVlEeUhpbFE2TzV3emcrdm1XSUNsSFNWVkFyUVVpNGdH?=
 =?utf-8?B?b09HWDljamJ3Um5uWDcvNHZ2d3RrbVd4WEFVa2doenVlakRtYWpkdG5hOTJy?=
 =?utf-8?B?SDJTWElYWnc1YUFoSkhmNFh6SWpxdElIQ213UzdvNDNmbE9NVHBiYlh3a1FY?=
 =?utf-8?B?ekxROWRXMWdVeGF4b0N5QkRlME53S0M1Um1DenZNL0RFV3JYT2U4M0hYVitM?=
 =?utf-8?B?Y3ZITmUxZ3VHNDVQYm93ak1uaHVPWE94UWNETXllZmpQNGlRNnFRcC9wUXl5?=
 =?utf-8?B?dEtJU3A2ZTh4UGVNdXhnZS9oaTlRUUppc1Yrbkk4a1ZPYVdVRU95aGVLV0Yr?=
 =?utf-8?B?Y0xlMEdsU0xBQUVnUnljTXVGU1ZkN0laV0xPN3N5cDE4aEdvclV5SmQ0d3ZF?=
 =?utf-8?B?TWY2UmswQ3VEem9Vaks5T3JBZkYvRks0aGxQcG8xVk9PazRzTU5Uc0g2S1pR?=
 =?utf-8?B?Y1l0dG44cHl4dDdtYzJjTVhMUFNsSmdSSHVpa3VlUi9YOEZEbll0Y0FjN2lI?=
 =?utf-8?B?TThvUk5PMXZxTzRFQTRhREFVK3c2anpyY1BuWjlkU2VldWVkNEtTT00wc0pv?=
 =?utf-8?B?ZFlOUXhlQXhid3l3eW9teHEzZE1FT3E4RUhIUitDQ21QYzZWamdnVWp4eEdI?=
 =?utf-8?B?eWNZNFBpNjd0WTJHNkF3SXBlejNyaE5VT0xOams0WHJ1RnhORU5pbytMN3Bw?=
 =?utf-8?B?TEdIRlJiRkJwN3hnY3VhbW9ZS3V4QzZ1THNiTUtGSVA5NXg1YVlTc2EwSzUw?=
 =?utf-8?B?aTUxaTBXUGhVMEwwQUtFdGV5QmpVSUhBOUxENDBtTVYxU0swaTF2b09ya3U1?=
 =?utf-8?B?UGJwS3RMdFloY29sb2ttS3BQS3RNMmh1WVIwVTU2QSsycmZUbEl2QnZWbjZs?=
 =?utf-8?B?aFJPS2JuaUJDSFVGZVN1TDhuLzRVaDBHdXBQbWM2Yk9FTG83dkFXcGZqQ3Vr?=
 =?utf-8?B?dVo2cFlEd2J0azBkb29pMUMwVm52WGZieDVoMmhJTWwwMW9tWnJqZFA2N2hI?=
 =?utf-8?B?Ti93SFRvUFphWkIyR0pzUFlGTW83S1FqTzdTaEExT3FEYlA0MmVlN3lqdGpX?=
 =?utf-8?B?aVZMNkxVVHZET0xNOXVBd1pMUEp4bUk2SDNCeThlMDVhUDhUSVlRRDhCTzMz?=
 =?utf-8?B?SWtSbUQrK2lzUTVIejRkMDVSRmVyUGpoN1VRZkdSTUdMbUs3SlZuL3IzLzQ4?=
 =?utf-8?B?MlgycENaWWdPUzRjWkVpRXZtanY5TGNMSkYvL2RjL1hwOGpCRFRITW1QUGRy?=
 =?utf-8?B?RitBV0V1bDNiZHBYZFRkcTcyeSswcGQrTE13MWUyYmZrNHkrNXh2RmR0M1Zy?=
 =?utf-8?B?RVVEa05OL3Y2Q2hRUVpzd3FTOHVWYzQ1U0trNkpST1Q5ZTYyR09wWlZscXRI?=
 =?utf-8?Q?BKLAZAE/HTbSn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdsRUZYZ2tpb1FsYVlBT3dpMytzRVczamNja0JOcTJWSS9taDdRaEExUW15?=
 =?utf-8?B?N3NkVm02cWIva1FHYnlYOVBvN2I0ZFRmNHV1a2hmQUFCN2Jwdm1SM3NnZ1d1?=
 =?utf-8?B?TGRWU2hhQW8wWDdMR09GejlGcUV3V2Y5cXVMUW1XT2wxVEVHa2g0VlZWMDhH?=
 =?utf-8?B?WW1FUFhPZW5NeHdnRHBISTRGbXB6c2Y2L2xOMWFoNElWVFNhdXhzS1NjTnFl?=
 =?utf-8?B?RkQ1NEEydXZnTHBWdWozRExyRUNRZlpNODYvRzZqSUlSQUpsbnhJQm5Qd2Zq?=
 =?utf-8?B?SEhiRkRaVjNQUmd4bHpNbHhtbmdBWXM3bW02R2ZLdklORm9LYk5hSmk3SmR3?=
 =?utf-8?B?b3U2ZHloOE0zUEUzVnRzR0Y3M0lObXBOWk1yUnlxQnVDWnRTWXNVSDBMMjh6?=
 =?utf-8?B?V0xGeHYzSmUyNzVjbkhLeVY4UnlrR29tY291TVNTTnR5cWZZbk1YcFFRdVU3?=
 =?utf-8?B?Qkh3aTZRUkxjNFVpVUNvSUYySWFGYXorWlFsQ3J5OHNoYXpGdi9LbG1pYm1w?=
 =?utf-8?B?d2JuSTJuRUhoME8rVGhqSmJVMWRJWTRNeDR5aWFsdHBjWUVuckMzYi9Yb2N2?=
 =?utf-8?B?cm4zSGJGWm5HejdFejFtNnRFS0VsL0R0bGJoZG1PaEpLTzY2QWNrV0IzcGEr?=
 =?utf-8?B?UnBqbWhuYkIrR3J0bWdKRDg3alRhaVhOYmEzVk5SUzV6QjJ4OE9FdlQzdGdm?=
 =?utf-8?B?NEI0TXR6cmhKZUt6SGx6WnR1Tmp1WmZKVjllQktjR2NxVjdpeFQrWW9qZUJ1?=
 =?utf-8?B?eUhVT2YveHVja0pQNFFpSEZ0WVRKbndjL2xLK01YMmlKSnAyb25BNS9KSTNj?=
 =?utf-8?B?TGxMZllVbkRud3FIMTI5aGZialFmU241TzlNNlJLdFp3TklOUmZ3eURzQThE?=
 =?utf-8?B?cXZuR1JsQ2tUb2R6SXdKMUJkSXJXS2NrM1RpaXp1OFlMZFZRbEFLL3d1Sm5n?=
 =?utf-8?B?cnEwV2FZSjk5bXBnS2duRnpyMm93OUt3TUFNdis2dDR5cDBCdm1uM2NWelhl?=
 =?utf-8?B?LzZObldpNVhEWkpyOGhUWlNhOGFZZy91OXFscEFwZlYwbTBDWFQzaTdRRm9O?=
 =?utf-8?B?czNraTBzKzRPbVkyWTRoM2tpUkxlNVJ0RnY0ZzQ0N3lWYU44UjZBV2lob2J1?=
 =?utf-8?B?eWZyT0czTmNJVW50ZXZmZjU0dS96NDMyZTRFV1krbTRtWnp2V0d3ZUhEQU1w?=
 =?utf-8?B?a3ZyTmNLQ0czUkZrd0xtKzl4bVF3TlEyWk5XQnFjZXlkcndGTEY4VFRZOEJi?=
 =?utf-8?B?Yi9kZnNkUCt2UGIwS1lBZ0pTNXJ5M0xsd1RMRzJwT2VEbVloMURGS2FpYW9Q?=
 =?utf-8?B?S2Y3R0NNMUFMdmhMSUZVU08yZE02M1RLUGdwVEhxZWl2cnQrcTcvbnJmbkdu?=
 =?utf-8?B?cDRlN09hZXNtTzZLa3pNM2JMNlNYUFJjVFpPUDREUFVxNDM2MHg0eW9lMk5J?=
 =?utf-8?B?Zkl2SCtNRGt3UFFWZ3lEMlZyNGI4TytqMHNEd0tadFdFRWU0b29seitOUDVn?=
 =?utf-8?B?UVE0OXo3TXRpWWpPZERvWGs1RXFCV1E3SU0xUlFrUGNPVTE3Z1hJVXFuek41?=
 =?utf-8?B?WGczUmU4QlpvN3dEUFZGZzgvc1RSRDFSbUgxQURlMjJYVU0zY2ZOVEpmWUpL?=
 =?utf-8?B?OUN6V2UvTS9hNzk0RzQ4K01tM3Q1c3lMT3B6L3RCSDB1YVhiM0NBK2ZJZ3hy?=
 =?utf-8?B?V2VXcVB5WjBUOGg5eTZ2YW96SUFHNGxWamxwNnFVZkZNLzNkUE9kL1FEaVky?=
 =?utf-8?B?c3NqMldHRnVpNEtPdlBRSFAwbmJId245U2cyeTI3MUU3ZWxOQkhKKytmZ2lO?=
 =?utf-8?B?cDRDMDVtM3FvSDZYOXlDM05aNnVNWVhzYmJ6TzZmNHJjNWU5YmVmOFdZQXJR?=
 =?utf-8?B?SWNMK0cyMzU1a0RvU21yanVScEJHUGVLZlFjZGVHdmpVRWhhdXVGWmdJbzBh?=
 =?utf-8?B?c3JHalAwWm81UjFURndib3ZjTkFRTS9haUkvTGRzOEQ2ZC9GWEJZdDQ0TWxs?=
 =?utf-8?B?aE1hMkl5d1B2eGUwRDBRQWJEZGxocWN1Skpzak44d2pUbHFIWWlUZVdsUGVP?=
 =?utf-8?B?d2F5WWJaZ1poZWlJbXpJanJGMUU4OEt5WFBvNGEzaEZVNXF2M1VBVnIycXZx?=
 =?utf-8?Q?1hcesPqzVQGGIpbO4PIxfGay2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e4fa6f-f661-4616-1db2-08dd5493d1bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 05:26:41.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhvCYbhbBBWxtxze884BTwir2fMcRbOaclkR/TXX0sNUo5nK7l4P/+BXJ+ETLUTmL0bG/GPxgfqOn2bfE+6laA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Several Ryzen AI processors support the exact same value for lowest
> nonlinear perf and lowest perf.  Loosen up the unit tests to allow this
> scenario.
> 

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 9f790c7254d52..0f0b867e271cc 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -184,7 +184,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  
>  		if (!((highest_perf >= nominal_perf) &&
>  			(nominal_perf > lowest_nonlinear_perf) &&
> -			(lowest_nonlinear_perf > lowest_perf) &&
> +			(lowest_nonlinear_perf >= lowest_perf) &&
>  			(lowest_perf > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
> @@ -217,7 +217,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> -			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
> +			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
>  			(policy->cpuinfo.min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",


