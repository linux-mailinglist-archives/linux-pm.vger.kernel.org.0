Return-Path: <linux-pm+bounces-15238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD969923AB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BA71F2125F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8578276;
	Mon,  7 Oct 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qA9s63Y8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31C1292CE;
	Mon,  7 Oct 2024 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276024; cv=fail; b=ZmZzsMWkTDo3nCvmKjsM2l8PtloiPgxVQwI6S5HqdEw9b4jKbcpO9I7mYguS0GAOMEw0n2KIbuVP8TB382zgBNu1zfZpolxcZMiTTD+gC2E58Y1sGpHtJMgDJXlPcV+NftNI/9tN3u0yjU0myDT4le01ahmt8SLMCOoHj8+STuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276024; c=relaxed/simple;
	bh=otvecs/ZHC72c5bMOLvUvL51nK0viUbSTrAcG68W7c4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isUIVKHPHFPlaGeGy3F5BQdHXO1v46EKhpn7bsf+P1rr0AF+F8ZzAICweyAy79yWYheVyOHBYM7rBwUGcgZTZxB3Cr+ZZf6MDU+cZQ7AXUmDzYgbYM9PVtO936VymBelpZOlmXP6+mFp1m+4eAwOuO9cV0ucA2rYOHuiKqU2m10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qA9s63Y8; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7S0K49h/hSUA6q8u8+6HRXlp0Fcnu2BkkuiAsNz5rah0DGH/7jB59tq0yJC+r6dwmVTlB7m1XLTXX6XpA4kiJgWC9w1E02rtA/a0kLdtk6aL6tIRjpaLF2yRv4jxRqk/AdLR5Zoyyq1suXLndr9VMfimYiDPKU+V9nHyTc3jUAs+sVrYB9CqLvP09jmAxKK7bUBzuDJPsdfZYqkLYqLNrouL/3kfQb9X9c3Sq1CBCMV+WUmSznmsjYv7bDcWo4i0yNz2eXnG8+Qx4K35VDP4EwjuvWwPu4keLbBI/lImariIA5tSxev7tDj1WycQi8XT9vrLiGBDOvtiouueE9SaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvDLpSbr2LWAVgH6nkcY3e7ig4NM7CtH2xiz9Og9CvI=;
 b=ZVPDzPgmd9H53ssKxTb2zYVZsQvceYwyuryLMx3jOCBbOxV2olbIaF50bXpHhdkkHp8gVSZSl5dfnSwAwIEEiNM2nNBKtx2ON6mT/4AcNg56hpsh3HBLvrHiqtCm1cY5x9IIzK2kAFdQ3qYQWxhwYDC3m1WyV3Ka4gFLWJ5T+oc9vdpUMJNjNMBUzIqWsPNuhvEBjsH+I+wDGsodur+uI+W2uhJRayBXdFDGfNOv7T9Zy0yLSeMHws9nKoFYNjg0ZqMFJoiqcqTEWcC/3T03kIwLbXhk3vMXuOCgIGVehanbaRydjFzJINn5zRw0YxfLztjlv9OjNOV6MXMYcvFSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvDLpSbr2LWAVgH6nkcY3e7ig4NM7CtH2xiz9Og9CvI=;
 b=qA9s63Y8n07wsOWh3RPnUHRFI0vfWicg3i1VCq8B0m1z8jzhowim2Mjgddy5xZd8XoByUW69UDEI6lMqxvdk7bV67ms52nShoE9jwTSCHN9P5tx515WptxK4RIvYv6aD1xMR0z5t7MS3fc4r0URzUQANz/pHbyTcfjkJpOLzrM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 04:40:19 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 04:40:19 +0000
Message-ID: <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com>
Date: Mon, 7 Oct 2024 10:10:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 ray.huang@amd.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
 <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7956e762-1d1e-43e1-a546-08dce68a25ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFhkOFR2LzFGMnhKc1VwZkZ2b1A4bHNMd0JERXZrdWl5Y0JxbHBaZU9CRUU1?=
 =?utf-8?B?WjZ5ckdibFFGU1VKYjcrUGdxZ1BxSW9ReURFREYzZXFoUkIxMHE1d3VyQkF4?=
 =?utf-8?B?QmpEVnd5ZjUvUFB1SFljODUxR011bTh6bGsxenJyYlZEdk1ycVNOV3FWdk1w?=
 =?utf-8?B?UzRPeVd1eC9FejlEaTVXeXhLWkZ3NndHYThDMnJkd1Z2dFJCeFpCanJQRFhB?=
 =?utf-8?B?SDFKVzFRMkJVb2ZWZXZsMHFqV2JWMUhLcS9oZEFNYWhBYXdLNHVNWmdrZlN2?=
 =?utf-8?B?OFBldmxCVS8xeFFuWWpVSXZqdUlZejA4SE5zb2ZNSFBUaVRkcmt6VUsyZjNH?=
 =?utf-8?B?TG1xdWp6R29sdWhDcFBHZmpNWGpuTUJEM0o1b2xFNUFtaFAzRjJrNmw3dk9Z?=
 =?utf-8?B?QTQ0ZzZiTnVyVmVMZ1FvQ2EwWWtCOXRiOEhDQ01mYXdibmI5dUhnck1FbGdL?=
 =?utf-8?B?a0pKZ1oxUWhqYldkYnNyV3c2RTF4VzZhRm9ERitHTFEwbkRXU3V6amc1YVNH?=
 =?utf-8?B?dDJ1YU5KYjdIb2ZpOTJSR1RzS09LSUdoeHYvbGJjMGxZdGc5TzRETHRaRnpZ?=
 =?utf-8?B?ZkFCOXNLOVlZYzNleHd1ZFFtWVJnbkw4VmZDWU9NQ3djUUEzaHZ3QldKR25T?=
 =?utf-8?B?NjgrYmVJU0F0VVJOQzhpWG5VWmFTMERla1o5cUNXQ1MvenhNeDBGTVFMSjhF?=
 =?utf-8?B?cW9MYTlBbk96MGY4ZVFqdFJYUHJuK296N3R0QllDcVluNkpqWnFSM3V2YkxF?=
 =?utf-8?B?Lzk4V2dqREJGOHc5QVFrS0swZ1dDN0NFcVkvamprcHI2SVF5a3FtOHpOb28z?=
 =?utf-8?B?SE9JaXlycjVIK3JQcTBydFUvM3BJOVZiMVNWaTU1QUg5U0hoUUlzUUZlcDdk?=
 =?utf-8?B?aURxMFc2V1AvM2pmdmFVQjJNTTBoTGl0cTY4blBVTml4LzRWVkZTZktjTXFZ?=
 =?utf-8?B?dHNITmtKUUhyR2lEanhBWGJHbFIrS3JyNWRacW1rcWdxdWhKUm1Pcms2Q2Iy?=
 =?utf-8?B?NktxWWphbmt5WUZLOXBacVRyL2hjY2E5WmNpQ2ZUbjQ1QmQxdjRCSm51aUxv?=
 =?utf-8?B?VnkyY0l3clVWdmVoelNVR0lBUFZkN1B0WDJzOWtmWGkyQVk0MDQwZHFHSG9l?=
 =?utf-8?B?MlRrL0x2QVd0RjZpQ3hUb3AwVGgralJjT0ZVQTViTVM3eEVpc2d5R2c4ODEy?=
 =?utf-8?B?L3RRZTRidnNoOWJlZzBobEVDK1VtajFiYmNmclcyRk0xL2tXWGlLeXZLSkxE?=
 =?utf-8?B?a0VmeW9sVzVsQjRvb0s0TEFWbXRTN0dyZTdMZzFtZEhCcThid2tNbmlhOEFi?=
 =?utf-8?B?eUNSWko2NmhFQUVUWExDWHFwNXNFd3EzYm1uVElEVGRqN0x5dW9tZGwvdnIx?=
 =?utf-8?B?b2ZVTWk2aXpnNlZPS1Yyay93MmpicmhFYWJLV1pkcE45UHc3c1ZOTmNjWGRI?=
 =?utf-8?B?aFE4cmtZOVY0TElCUnVTZ2x0eVBoZEpWZWJvRFVPMTBhaEJOdlhvYjVYL2dw?=
 =?utf-8?B?UEVEa3B2azQrUlhZOXdadUo3aThOb0VrajROV3hPc1BGQ3dWRkxGcHdvOW9E?=
 =?utf-8?B?MHlJS3pQVDkvaFM5M0IrTzdJcERkYWFaVDZzSTY0bXVPUWFWa0R5eFoyLzVk?=
 =?utf-8?B?WFYySmJxU2xQcDdBeVNzRHNKcEFRYkR3MW1vaTlYWm91ZzBCRSswd3BiMVAz?=
 =?utf-8?B?Z3VpT1JycjRyLysxZHBjbG9wTGNwNUtkYWxPQVRDdEI4eDFUbUlvbmd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1RCdlBPbVVkajFhcFdWdVNDbEJ2OFcvWTNKQkxvOWdqbGlLMnNwKzNlYk9V?=
 =?utf-8?B?dmh1dm4wbVBubkNjVVpRZWFzbUx6QmNMdFB4MDV3RGFxZmVlZzhRcDRkK1hm?=
 =?utf-8?B?OEdVTjR5S2F2TWVSdnZkOGtycTh6YzFKRWswbW1vOWNkNGM5RnorOVI5b3lt?=
 =?utf-8?B?a0wzeGVBMkpUMHplK05wZ1FhcCtlaStlRFI3UEF2WmtkbVI4enpUelNSMFhw?=
 =?utf-8?B?R3FwYlZWQzNvZjZJcXRqeXZHMG9DdXIrYVlQUXNza1JuUldRWWV5SUFJSDN2?=
 =?utf-8?B?UVRrRGViQ3FPUTMxTzFLOUp6dEpEUUNoblhzK3VjOGRTVHQ3Q0FLUk1uUXpE?=
 =?utf-8?B?b25PZUNsdDY2Q090dGZmcVZNb1hVM2VIN2lDSGtzUWV3dENJMHVYM2JpbHZX?=
 =?utf-8?B?Nlg3NnNzY2R6V3IzSEJjeGpaZEdwOXpTNDJra0g2bEpKRzhyNHQvNzlYTXNm?=
 =?utf-8?B?UG5UMTF4c3dlTVFCYmxlUi9lN2RNQjNkZ1hZMnorcktwZndwQVpOTHp6bTIw?=
 =?utf-8?B?OVhMeENTR21Semx2VEVzOEx4L3lsNmY4UnhLMXFHTGkyODVXSFhVOGdKdmx6?=
 =?utf-8?B?ZERmY21aeGdONVBNNG43UUw3US9kbHhRNzN0VWJ5cXlFVVVjTENsSS9rRWpW?=
 =?utf-8?B?eGhsRmtaNC9NTEs2bEp6QldLdW9BTG9maTFmQmVKUk9nV2JxSU1iODJCNG1y?=
 =?utf-8?B?UXdXU3RkVVovdXdmQWUzc1pjME1vclh5TXJKK3QrU1RPUnB6MWZRcWFQeERs?=
 =?utf-8?B?dzcrQ216RVdUcE5XeWRISHFnTTg4dC8raEFmZGxnMjRYbldCYjhweXN5SXF5?=
 =?utf-8?B?amk4V2VUQ1FQSjVGc3ZGejA3STBOeFloZVFGL0ZoMnJvdzJOUi9TUTdITHNT?=
 =?utf-8?B?UXljVkRyZ29ZY2Z2b1YzemFYQW1CS2ZOQUlieUYvY0FPRGx2NXkyVnlnS3lq?=
 =?utf-8?B?VXRCdEdUT0p3a1MyT2ZZYlNNRTY2OXRlRU0ySXRwUXJrNnk1eWdMWS95bzM2?=
 =?utf-8?B?SEFmVUhKUjJscWJta0tHTkFPZTVWUFhxZHJXdkkzbE5JTlNydi9rcm0yckt3?=
 =?utf-8?B?aTNnSTBjZytYZE5IYWt6dVhNbkQ0VStvZmdRR0tKc3RmalJabHlOMjdKQmFZ?=
 =?utf-8?B?MlVZTkx5YTUvRXR1eGtqancxZlFzTEFQallUcnFOR3FpZ1FBTnpnRE5VNXJZ?=
 =?utf-8?B?NW1NVmFxckM5djMxcHpNSEVtbWJyTC8xbFlGUUdZVUUxTXlXbVpucCtEYzJq?=
 =?utf-8?B?eHo0cGNvdTMyeGdIMmozemp1ckdsektPa2ZSTEdtNWFFcmM4TzhOd0RoajBa?=
 =?utf-8?B?NXJReEN1RWhUeVFETTlIYWVIQXR5YllHZHdBNzdrdFVMTk9zUXEzb3lxZjA2?=
 =?utf-8?B?enZXTS9ISlJiNXNOWlUxdXRkWlVtZURGS21aV3FyUVkwSGhaWHZYTW54bXNu?=
 =?utf-8?B?Ry9Td2ZYN0hya3cyRXdQazRIZ2FydGFtMWZwc2gxaU8vYUZXQXVFUThnbk1M?=
 =?utf-8?B?ZitHcGZWczBIMXdMRDh4N1FLMXFhcEh2QUhKcVBzSytIVG16REx6VS9pblJz?=
 =?utf-8?B?NkxyRS9QcXpLeHNrWEo5Mm8xdkVaK3VVeVFhSGplV2h3Yk1IcE12ZklQSExK?=
 =?utf-8?B?WFptRjgwa3A5WE9sWWNGSDQzUjUzem51Ung2VEwwNUZHcW9sK25uSEpDSFlx?=
 =?utf-8?B?emR0VUp4eXlyTjQrZ3BoNXpOL0FzdDZlNmpEeGY2T3FsR0JYVEduWHVZdUpr?=
 =?utf-8?B?blVSTVBJbFJ6MndQbkM3Q0lneGxVUVZ0SFpHRUIzUlJnNm9mREpXbE8zbmho?=
 =?utf-8?B?STNxbm5RYjQ4YVFoVFVXL1dQZEUwbDdqNEV0SFIrd20zaU9JaVFzazY3VytG?=
 =?utf-8?B?cjREOXhBaTJjTEh0aUNId09ZZHJKTzhDRTNCMjByTUsydFd6eHRpN0ZtNnhi?=
 =?utf-8?B?OWRCNjh2YjBaM2dwbXVXR2JiTEFWemo5L0F2S01YamFFZkRiL21mdVhIaDY3?=
 =?utf-8?B?bUN2NVRkWXpIemlUUGlHQU8wa2UrM1NqOTFqd1o0eE8zU21UUU5uWnFiT1FE?=
 =?utf-8?B?WS9PbThlWUFpT2NCdGwzVUY0aWl6QTlBc3hQYWVxOHdjQmFyTEpObkFZanVU?=
 =?utf-8?Q?9qp2mB1UtK8g4CqCSfZfIyprm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7956e762-1d1e-43e1-a546-08dce68a25ae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:40:19.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vDNJm0YPDrGoHFUuobzKsuFQIITqd+o8OeWA1hRTWaqONoUGaqawALgU553c3gxSYb7b8fXaKP3dORT8Ankqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

Hello Rafael,

On 10/4/2024 11:47 PM, Rafael J. Wysocki wrote:
> On Thu, Oct 3, 2024 at 10:44 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>> Currently, there is no proper way to update the initial lower frequency
>> limit from cpufreq drivers.
> 
> Why do you want to do it?

We want to set the initial lower frequency limit at a more efficient level 
(lowest_nonlinear_freq) than the lowest frequency, which helps save power in 
some idle scenarios, and also improves benchmark results in some scenarios. 
At the same time, we want to allow the user to set the lower limit back to 
the inefficient lowest frequency.

Thanks,
Dhananjay

> 
>> Only way is to add a new min_freq qos
>> request from the driver side, but it leads to the issue explained below.
>>
>> The QoS infrastructure collates the constraints from multiple
>> subsystems and saves them in a plist. The "current value" is defined to
>> be the highest value in the plist for min_freq constraint.
>>
>> The cpufreq core adds a qos_request for min_freq to be 0 and the amd-pstate
>> driver today adds qos request for min_freq to be lowest_freq, where
>> lowest_freq corresponds to CPPC.lowest_perf.
>>
>> Eg: Suppose WLOG considering amd-pstate driver, lowest_freq is 400000 KHz,
>> lowest_non_linear_freq is 1200000 KHz.
>>
>> At this point of time, the min_freq QoS plist looks like:
>>
>> head--> 400000 KHz (registered by amd-pstate) --> 0 KHz (registered by
>> cpufreq core)
>>
>> When a user updates /sys/devices/system/cpu/cpuX/cpufreq/scaling_min_freq,
>> it only results in updating the cpufreq-core's node in the plist, where
>> say 0 becomes the newly echoed value.
>>
>> Now, if the user echoes a value 1000000 KHz, to scaling_min_freq, then the
>> new list would be
>>
>> head--> 1000000 KHz (registered by cpufreq core) --> 400000 KHz (registered
>> by amd-pstate)
>>
>> and the new "current value" of the min_freq QoS constraint will be 1000000
>> KHz, this is the scenario where it works as expected.
>>
>> Suppose we change the amd-pstate driver code's min_freq qos constraint
>> to lowest_non_linear_freq instead of lowest_freq, then the user will
>> never be able to request a value below that, due to the following:
>>
>> At boot time, the min_freq QoS plist would be
>>
>> head--> 1200000 KHz (registered by amd-pstate) --> 0 KHz (registered by
>> cpufreq core)
>>
>> When the user echoes a value of 1000000 KHz, to
>> /sys/devices/..../scaling_min_freq, then the new list would be
>>
>> head--> 1200000 KHz (registered by amd-pstate) --> 1000000 KHz (registered
>> by cpufreq core)
>>
>> with the new "current value" of the min_freq QoS remaining 1200000 KHz.
> 
> Yes, that's how frequency QoS works.
> 
>> Since the current value has not changed, there won't be any notifications
>> sent to the subsystems which have added their QoS constraints. In
>> particular, the amd-pstate driver will not get the notification, and thus,
>> the user's request to lower the scaling_min_freq will be ineffective.
> 
> The value written by user space to scaling_min_freq is a vote, not a
> request.  It may not be physically possible to reduce the frequency
> below a certain minimum level that need not be known to the user.
> 
>> Hence, it is advisable to have a single source of truth for the min and
>> max freq QoS constraints between the cpufreq and the cpufreq drivers.
>>
>> So add a new callback get_init_min_freq() add in struct cpufreq_driver,
>> which allows amd-pstate (or any other cpufreq driver) to override the
>> default min_freq value being set in the policy->min_freq_req. Now
>> scaling_min_freq can be modified by the user to any value (lower or
>> higher than the init value) later on if desired.
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 6 +++++-
>>  include/linux/cpufreq.h   | 6 ++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index f98c9438760c..2923068cf5f4 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1361,6 +1361,7 @@ static int cpufreq_online(unsigned int cpu)
>>         bool new_policy;
>>         unsigned long flags;
>>         unsigned int j;
>> +       u32 init_min_freq = FREQ_QOS_MIN_DEFAULT_VALUE;
>>         int ret;
>>
>>         pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
>> @@ -1445,9 +1446,12 @@ static int cpufreq_online(unsigned int cpu)
>>                         goto out_destroy_policy;
>>                 }
>>
>> +               if (cpufreq_driver->get_init_min_freq)
>> +                       init_min_freq = cpufreq_driver->get_init_min_freq(policy);
>> +
>>                 ret = freq_qos_add_request(&policy->constraints,
>>                                            policy->min_freq_req, FREQ_QOS_MIN,
>> -                                          FREQ_QOS_MIN_DEFAULT_VALUE);
>> +                                          init_min_freq);
>>                 if (ret < 0) {
>>                         /*
>>                          * So we don't call freq_qos_remove_request() for an
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index e0e19d9c1323..b20488b55f6c 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>>          * policy is properly initialized, but before the governor is started.
>>          */
>>         void            (*register_em)(struct cpufreq_policy *policy);
>> +
>> +       /*
>> +        * Set by drivers that want to initialize the policy->min_freq_req with
>> +        * a value different from the default value (0) in cpufreq core.
>> +        */
>> +       int             (*get_init_min_freq)(struct cpufreq_policy *policy);
>>  };
>>
>>  /* flags */
>> --
>> 2.34.1
>>

