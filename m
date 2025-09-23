Return-Path: <linux-pm+bounces-35254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F9B9739C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790BD7AE77C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53396302157;
	Tue, 23 Sep 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l1GH+wO4"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A905301705;
	Tue, 23 Sep 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653054; cv=fail; b=t0QFBm2B6WQajuQDOwOA9p5kzhzq+eyelgQu1nPLUIJW6bAZRMKTWmD/jm6MY5A3F2K0KdG6cFh3SZvlyP0sKADw7FQdNscbiYYQdnwPCgENYBY5oe00makdqlFRBJM/A4APDyE7yym4ypX6/BphV/LZXZAtsOafCNv45RbjcfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653054; c=relaxed/simple;
	bh=YuKeLORI31BaSZ8MbhSpax+P0NbaCnviYu/2mkpLHDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1Z1m8s64RqsA2iVslvs6GK5Yi6HwSmJQYtZ1YFaYLU1nuijkyTVDtgpks8UK/DzzNHESPPoGoiQQE6oVAOKVwn+gBPh0gbpnOmbxkDtEKb8NaaSj+rQJkhrvxiEiPgqST6+mEFpTWc1TFLAxgvmD575Fz161j+xSuIFMiV+kG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l1GH+wO4; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9VF8JmYTFaCGY6WimAGUXqIDjMye35ltv/zFOxAdSlkMFCc02gRhp3p24Sl2e6e+rGLofDzjrHA/OdTEPU4EEcgN/97WaNsd6FcLb4+foVHTWJivUk6J/jBEBsUzHrIszlY14O55v8ri/9xN/Q6ZuT/s8Xpb0TmIemubihBDcQhmj2QL89u4/6IwRVbE0pkRYJ8LwA6GVP8h0fl8VK2PIuPJpP+PjHKb3R9/1lLjxU6IlgiE4Kga1UnVqzrHi8PJw12EoIFMr+v2eYshlg4kacgMxHndUQICmoxugWADmTebdfot2M7OhqtqbHcEnSBMzaQKPcUkK1bCbnGQHx0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFWz5h4MF3Aaddu4H8v6BhZLO0zhrBrjr+sbtIBJTVo=;
 b=hDpnGi3T2Ei/3DuZq8maADMTz0p2j1zo3bRHmn9TNE/7oFzz0rF+q5/Hs8bNj40y5i/fpf1kPwmJXG5ySq910D8rU2xR3umNhUKgqAvJALTbcWf8xh9YYoOvlxrJOxrigNS37u8rwPvz2zEkU0/P4j5nf6pb2QuU7NRZxzgLN+6gwGiA0Eapmvfv5MBRUDi5j9uRPEAvzKxVyE3bAYtv4U+uvTQYgcp8vpnx44sX+AbHLjUB33d4KJIpkfDn0+SiQaocjs/R3GWd61RWtfSIMsqDrI5PATJfIIxDaB73rMzELByLrMQppyL/t0TQWOSHRXvw8k/QHtl+7QSsEnXm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFWz5h4MF3Aaddu4H8v6BhZLO0zhrBrjr+sbtIBJTVo=;
 b=l1GH+wO4o+zYfAUgQ37sloQiDjXhgHOBW7vySjXTBPWuCmKJh3XK5vgRxkHgODgSaTB0ej8qIlUml34GDr2aKXGxNjwNP/AaV+Y8kWZW0TKCcPtY1qZCYggZoN3mUf1SUZ1SI2fhwuZ+fPAodByaSWi+PMGZobI/Mei4XxF9X2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Tue, 23 Sep
 2025 18:44:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 18:44:08 +0000
Message-ID: <41b869ec-a59e-4ddb-a231-ac4e9d39094c@amd.com>
Date: Tue, 23 Sep 2025 13:44:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/x86/amd_pstate_tracer: Fix python gnuplot
 package names
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
 jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250824200902.163745-1-visitorckw@gmail.com>
 <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>
 <aNLI7VBQc+NFrmo8@visitorckw-System-Product-Name>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aNLI7VBQc+NFrmo8@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: f2526b83-42a3-4bb2-4b31-08ddfad12dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eloyWVBTbDdac3dyQko4S2R4OHZMRmNwdFBQblRnQTV2b3FvdzkyZSswTlNE?=
 =?utf-8?B?czZVRDJjUU9PVHcrRXYxVHlaZTM4L0pCOG5kb0puU0hBUE5kL0NRVFlTK05y?=
 =?utf-8?B?ckNDY2FYeHV2eVNtQnlaRXZ4dzA4bVhzQVVEUDJjaDBBd01iZ1dVK0xJYkdt?=
 =?utf-8?B?R1ZCVXg5N0FHUXpqM0NBa2hIZkd1c0NOSVpNeHVRVW5ONWIrUFZ2Rmk3aFdC?=
 =?utf-8?B?V3F5MWd3Um5MeEcyckdWRnFIc0twZW0zMmdrU1FzTzBNZ2R1d1A5T2xQanFJ?=
 =?utf-8?B?aktGcFljeWttTUpTVGpBcGF3YU02NEppR3dRb0R1RktJNkNQZjNDOVZrKzdN?=
 =?utf-8?B?SXhqc294OHZhWER5REVkb1htc0RFdUlWKzVoMlU4eGFOSXdyNnFMb2NUWmEy?=
 =?utf-8?B?ejJMN014ajNxVjM4VHlLZXFZZHZyU3RwZGtYVTVzdDhKbXd0MU1FbmR1K0dt?=
 =?utf-8?B?bU1sNWdoNy9LRWxkQ3RmSlNlTVg1ZmVVckUwZ1RZa3E0YXhjUGVtZkVwUWN4?=
 =?utf-8?B?eUg1bi9jNm4rOFlHTGNKbm1aZEFYWjNRVHB1U09VZ3JRay9HbndJU296YUpr?=
 =?utf-8?B?UktWUGlhcDl4QmZWVWpTcnJhWG1HN2Q2ZFRMNmF3YkpOa042SjN6dDkzOG51?=
 =?utf-8?B?OHdVMTFBSXhDVWNDYkdaNlBSUVovd25GVGM4c0R1Q21vbUdxcHBCeUhyY3Iy?=
 =?utf-8?B?Y08xeXpTajlyQzZNSDlUN212UzFuY08zYmk2ZzVqNFEyOVlEaXZLOVhpSFd1?=
 =?utf-8?B?aGVLSmo2bkpsb295S0pUQkNFTTh4VWFyL20rUTZ2NlNIeWQ5UUtuUFA3U01G?=
 =?utf-8?B?VzNreTZUQ3NabFcrNmhnbk5OaWxneFlCN1MxcERGRDkrTUIzUjFUVGtHNHZ6?=
 =?utf-8?B?VDBRY3Z4QlRjU0gxaGU5SnJ0VTJvT0M5V1Nlc1FpYkJMVnpHbUlWSUZhVnpl?=
 =?utf-8?B?UWFENHZMek82V0xOYTllRTIvdHhMWklPcGdvN2E4dHc3bVE0WUEvWnRHNnZX?=
 =?utf-8?B?RDdzUTNuSUVJNERwNFJrMzNIb1hlZ29odXhmRG0vcEZ3WjhCczVVZGxtd20y?=
 =?utf-8?B?RVBUMEJ5d2FIRWRRSzBLSXNzTVAzZlgvdnA3eFZ5NEtrdVpPLzhxYUpwc2pU?=
 =?utf-8?B?NnBCSXFVMzNmM21ZWXQ0TmZyQ0lJbVhQV0VrRVZDcUU1V1hmaTdoaEFwL05W?=
 =?utf-8?B?aVZVWXNaRG04N0pzcXlzMzlNeUduMW1pNUFZOVp3aEQxQ0xINSttaUp3UUx4?=
 =?utf-8?B?Q1hqRHArVytBRkxsMHp4bzF5YjZLQWRYSlBoWHhNUFQ3d3U5VHlzOXgzUk5h?=
 =?utf-8?B?V09tL1NwRnNXamJ2UUhmVjFEVC9iU29XQTBvWFJwTG5vVXJhL1lJelkzL082?=
 =?utf-8?B?ZjF1RzhteUU1NlFmNStpeWxDUkcrYkY0YTlhbXJZL3ZUNjJmS3pQRHlPVTVG?=
 =?utf-8?B?YlFEZVBnNGNjenArcjVmK3lGTmpmSFJ0NmVRSUdiTHBDNTloWDFNbHlLRURl?=
 =?utf-8?B?YUFRcStKb1kwVmFlY3pZN052UDkvWmJGR1JMVnhHUHZubDlkWTNtK1BlcytD?=
 =?utf-8?B?NTQ3Uy9QOWtRanVuUFA2MUVoRVBYZlpTRjhCdEExbzNzWEk5UkZiaklaU0lT?=
 =?utf-8?B?L1AvOXEvWWpzNDJxVUNNd09ORG92d0JrZnViQkEzUnZCczlnemt6WVRUYXdu?=
 =?utf-8?B?UEcySTBkQm16MVp2UXpxaVVaR3ZmZ3Q2UHYzUkNETmZRWnVOZkYzRWVvYTN6?=
 =?utf-8?B?SjV3K29UeTlVZ3h0bmJxc0pDUEFqWjhXUyt5bisrTkYwTHREMkZWdXZQUWNx?=
 =?utf-8?B?T3NCVFVWcWt4SWpvd0RUSlNLKzRTcW9kVExtc0hlVm41NXJlYWs5ckgxbk1j?=
 =?utf-8?B?R3ZjR2dKUlh4RUJDL0J6ZXpNSmtuYkJvcytySGJ6TVg4eit0KzJ3Ny9UVEtP?=
 =?utf-8?Q?NMqHuTMmsks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVpM1o4QXB4MExvbllWcFl2djFneDRuZ2dtN093aGd6a0EwbUxIKy9QMHAw?=
 =?utf-8?B?Zmc5Qm91bUYwR3VPQ0JWSlh1VXcrY0VyMG5uZW5sSlpyZytBUG9iTkJaNEVi?=
 =?utf-8?B?WDIvYmY0YU8wOWNUbzl6UGZ2UGJISVQwZkMwYlFNUUNNcnZsUVd4ZG5JUmVq?=
 =?utf-8?B?YTRrLytzL0pHZERZT0xYblVycDkxWERxS1RoNVM4WlduM213ZDVkNHV0a3hz?=
 =?utf-8?B?VDA2bWZXYTR0c1Y3aFhNYmtIdWZ4Q2JmTS83NGZUdHo2SENDaVhXMWQrT296?=
 =?utf-8?B?NXBJM1M5R0NNc2lrRWFxZ2cyYzNDWkdXbk9lT0duUVpDZUVqR1h3WndmZUNF?=
 =?utf-8?B?bE4wMitUZzNRTkk5V3lKWnRRMUE0LzhRMWZaRmViUGp4UVVBTVdhenZBYkk3?=
 =?utf-8?B?MlhUUVN6VTBOWnZOWWxlTldVZXRRQ3ZScVBGOHJ3MVdxRTRJNGZFYkVodG8v?=
 =?utf-8?B?Q2dNdis5cHZBQWFVT1hDbmtmWjU5citkNXFNY0htTWRhdkdmS2puNDA3T1RE?=
 =?utf-8?B?WEtkakRKNWNENmZNQitnZFliWjUxN0t2c2p3aFU0eHRObnFKTGU2Qm1RbFVV?=
 =?utf-8?B?Tjh1ZHpvZWt3bWtMMEtiVy9CYkl6Z3lWYkhuRHdHOHlGOC9sWU5vRjB1MzZI?=
 =?utf-8?B?NHBBZUYxUktxYWlUUVlsZTduNkwwc2EwZWk2SjVaZ2Z6QWZxdWhVeVcyam9B?=
 =?utf-8?B?ejFLbGRxNEVsZ0JwQkRtSkgvRUlUS1puYXhlQW1zTWszTVVQMGNvcVN4a0F2?=
 =?utf-8?B?QjBDR0NuZmFVSkpMTjZBVlpRQmx4OFBVNDg3OWxhd0RwbUplQ0VpMzJsd09k?=
 =?utf-8?B?emFFSGpmMEJqYU5ZbFJwUmlrYnFSczNsT3ZZcnlKZW44VmpjVmNUSzdLb0xy?=
 =?utf-8?B?VmYxdlpFSlVQb1g5NEFzRzQ4empqa1VrN2FsQm5yNWN3a0M5V0dVSVpUK1ow?=
 =?utf-8?B?cEF1YXB6b01WWjYzbDNwUkdVakJsV2VlUHM5dC9LR0ZRMXZmS0F2UDZRMW9y?=
 =?utf-8?B?Z3REbkRFbUJCWXo0S2FFRkhPelVXNmhvQ2JWdmpRMldlZHpmakgvTmxzQXhX?=
 =?utf-8?B?VCtCdmttSW9sajh6cGVLRFlkRmZFT2hubXNTcysrQm9YMjBVbnlpTi9iYjQ0?=
 =?utf-8?B?WlZEeDFCZVlKL3hUUUZWYVRpanZKbktGUFVIN1pIQVFDdDMvTkhub1FNM1BD?=
 =?utf-8?B?VzF0UUhDOXBHdW4yYmMyaVNabnpMQ1VYZ2ZZREJxYzREUjBDSldGa2JuQk5N?=
 =?utf-8?B?L3VIZTlXUWZXaGVUc1pSMnZyNXNyeDUyMTUyd3J1Z3o5VnlyNzgxMk9JckdI?=
 =?utf-8?B?OG9WREgvdUdwM2JlckpHd2V3Nk5hQ2VDQ2txQmg2VjkxN05YQjRhT2NybXFp?=
 =?utf-8?B?MVR6aEpCNnhzY0JUOUFtSVJ6UXpMUWhXdFRtaHVXM3Q5T0JvdmJTZXpZRFZX?=
 =?utf-8?B?aGMxOEpaUWY4bm1zN3Vxb21BYXFkWmEwV2E4aGJxa2lLWHVJVWprTlZJSC8y?=
 =?utf-8?B?dWVvaXBnK3BROG0za0lxOUpxdlJ5OGxKRlNPc3dJV2cvT2VRTkFRcHlkTHYr?=
 =?utf-8?B?MU9vSFJIWmtxVzhhVjJ1MjYvbGZHdy9GOGlZWHMxMno4MGtFYU1LK2JsSEY1?=
 =?utf-8?B?dHVUMW5JTUhnL0JLZEZUOWhZekFFVlg0V0srWjVyT0U4aTd0cmNQK2dib081?=
 =?utf-8?B?UmJYYzVsSmFrRFpFUDluc0VtNEJUenN4SmNhUHBhdlUvSlptaitGeUhJei9u?=
 =?utf-8?B?QUhoWDVYNXhtbkk1RmduR2lDY0k3QzBxNjUrQ21KTXh3S0NKTUlBclViYmk0?=
 =?utf-8?B?Q1A4U0hxL0Z2K2JkRElwSE1DYmNzT1lTdEZlUzFlUFJTOXYyVkkrTUhCWVZz?=
 =?utf-8?B?YnczekxhNFFLVG9FSEp2S2liYXhTbmpTZ1Q4SlVDN2gyY3VjcUZRRjdXL1Bw?=
 =?utf-8?B?R2Y1OXVSMTBuVUhnYkw4V2tBbmVxZGtMaHhpbTdmdWM5N0hpd2d3aVVDdFpz?=
 =?utf-8?B?M1k1aFFEZ3lhNmExK056cWpVRUEveWNSaDV2elovOEhIVnZjNFpuWEl6TXcr?=
 =?utf-8?B?VUFXNXczdFdQNkFhaUpHTURUSU5md1BEVU1uS0xQMzJob3pFSnIyY3JQVnU2?=
 =?utf-8?Q?hz8vwPOOQHUmK1SdSObpsK4eD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2526b83-42a3-4bb2-4b31-08ddfad12dd7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:44:08.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W74P3N9KTnL8VtDGIJ5yKr7xV/Ady0YHDZtGZj8j2y2IkODmtLdRpT+eI26rqhQW0elcAQfr3cpzCJvJWdAxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360

On 9/23/25 11:21 AM, Kuan-Wei Chiu wrote:
> Hi Mario,
> 
> On Mon, Aug 25, 2025 at 04:25:58PM -0500, Mario Limonciello wrote:
>> On 8/24/2025 3:09 PM, Kuan-Wei Chiu wrote:
>>> The prerequisites section listed non-existent packages
>>> "phython-gnuplot" and "phython3-gnuplot", which may mislead users and
>>> cause installation failures.
>>>
>>> Update the names to the correct distribution package names
>>> "python-gnuplot" and "python3-gnuplot", helping users avoid confusion
>>> and saving time for those following the instructions.
>>>
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thanks for your review!
> 
> Since the merge window is likely opening in less than a week and this
> patch has already been submitted and reviewed for about a month, I
> noticed it still hasn't shown up in linux-next.
> 
> May I ask how we plan to route this patch?
> 
> Regards,
> Kuan-Wei

Sorry about that!  I had thought being tools/ someone else would pick it 
up, but I suppose it does make sense to go through amd-pstate (followed 
by linux-pm).  I've picked it up and will send out a PR for linux-pm 
tomorrow or Thursday.

