Return-Path: <linux-pm+bounces-19171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4689F04E5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4241416A30B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646F18C32C;
	Fri, 13 Dec 2024 06:39:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020132.outbound.protection.outlook.com [52.101.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0515383B;
	Fri, 13 Dec 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071955; cv=fail; b=TRA97XDVnfL58WQ6yv7jIj5b7Vw88tNyTc6YdzJ6dBXbsVUXJMKgw36+p0aYV5HIRXvl31GCfbaIIANF5V5mxa5rbO4HUEUWJMZoN+KB0yKwzdlaT7RZjMJmA3R627OuCXSNiDgU4T+KPgEwmqFpLKZOiqQklf0rPiOFH42L3uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071955; c=relaxed/simple;
	bh=V+zSLnR9L+IpyKJvXgRVSk9XihMzR3Xg0L2TFcdiAv4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ct0egKYQRY1IX01Wd/XKsDWRD3Y3dkBVjrYuEdatqqyaxaQVdHWIW44S8+hJKVgV47b8KN8Jli7mSVBK3ymbFX4D5UXfHs3g8OxQq5VStykuM62khH3vAiaPA/VHSOjcDJiK8mErheEGRmWQ3W2n1NM/g4n/n2O+Y3+FrxCro4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTNJg8n7LYBKlfZ13DfQcfo7QQRSKblUKyuMCpolMdVeBkhpr59Nm94YY4uPs2DsSBeTuHJcYc81VwqVtk2T3ygv8EryCAROpV50Ia43jEgFi01J8yNESf5lPP5ajalL66a9pARDWOhffb6NE4KNG82Tx/N3eWJ/1J/jL3a9hcVo2ZHluol9DMXkiR8bQhU1nUR0AnBUsdeL2Jeq/zgupvfZK8wgXGbufvXwiTFsX2COiRHRcTk8DH/Ecndnk5sJzZ4wYHqXvg3LMR+p/LCgRR+fS2NwY0lXvvXBZkAG7lGHwwfzxednHVakiZMBQjEIDxJpctks088kPU5dM31GZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npEADGOmzJcQ8AHe5h3B4zh7cSxF81QCwGRI8y+BGk4=;
 b=gtj+xKmqTHswVqSjYYxsfTK0Fc0NBtbLwkO2+GHl/O93FZJCFcqUEiP+CaGyF64i2gbmf8N1ZVdBh9uqIqmL0ijL85+hh/7xXrKbAC+yiEPV+QIrDSX2/mDSrx/hNu+05v7Wkcu6vy8qGz1EEVDY1PUwe342KaZhypkpOBSRAXIiCMYpp9Zp+ElexHjRD4SR/eZWSZOIWgiqFNAuSZtqIV5FKR4jy4EbAB87olAhu0Qc8AYSbLk3iZyWZ+QhehlTymAs8FsZ1wa7k/XHeRteYLStF9FYhNaurzHsFixkrPhs+9nsfoAO8/7Dk9bluvq+xY7lLz3t+PA93dZzt7nxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MAZP287MB0053.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 06:39:08 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 06:39:08 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Fri, 13 Dec 2024 12:08:06 +0530
Message-Id: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MAZP287MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: 331d76b8-b303-4da5-2086-08dd1b40d849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amY5OGtKWXc3cDFhNit6MUJJcVAvZ2dVTzdRVEoyYXVQSGE4bVpOTittbWsx?=
 =?utf-8?B?clhLelV3MWFjbXRpTkFEWGJ2cU9kSkpBVDdFemJtU0ZNY1dPSzJuclBpTWZE?=
 =?utf-8?B?ZG9RYWlhSG5aRkRhVXc3YkorOVBqY0NNVWliMUF1ZDVxS2p5VWsxZHZIRFAv?=
 =?utf-8?B?WWQ3S1VFME11Qy9vNzZJa3daWjdHbE5pRzkxTFhYbXVrS2JmMnoxR3hxa1Yw?=
 =?utf-8?B?QVhuZ3FTVWtpdENZUmlwRlNHc1ZHSTh2dmVVS3A0aW04L2Y1Z1FjUmpXZGsx?=
 =?utf-8?B?Z0dEbCtmYmdGdmVvL1RpRys2K2k4MGd2eURPeERHcGRHZXRhbzhRRENoQzF1?=
 =?utf-8?B?Wmc1RE9SUDRhc1JkT21tSDM4a0tQWjZQS29Ea0F1YXAvV3RvZEtGbXUzL2kw?=
 =?utf-8?B?SW5yQlQ2WklCRk4wbW9RSWpwMHBwaHNFZnBqbTlMYXUrS055VjZaZVpTcUkz?=
 =?utf-8?B?aGNvc0xLQWdxeWNUcmFVVVBqb3JBTjZnemhIckc2azVpS3BvK0s0R0JXTUla?=
 =?utf-8?B?bmlzekhmY1ZLSm9lSFhlNWg3Yi96L0NYZnFkdS9tU0lyUjN6Yk1TT3NqdHZO?=
 =?utf-8?B?bm1kcmYvczFaSkFsNWthQjZVVFdlb0FKcndUM1NuUDNVdnpyUlBWYUloZDZa?=
 =?utf-8?B?b0tKUDVyZXJBL0pseFIwbEhMR24yNkZGeHRtNUZQNm1zTThFNWFNNkx1aUJt?=
 =?utf-8?B?ZEhWK3BnTjBmT1pBeStmbE9KZHVPZkVvZVVDOXFsdVBBZ0xRbHpZajBCUEU2?=
 =?utf-8?B?NG8xTHVDdEFTV3ZMRFd1a1VzalBIQlBGQmtzNTNvb29kWExrdDhpSkZ2cmRh?=
 =?utf-8?B?ZFRJdCtXYlRQcldreG5lZ0dHUEJSTExnd244YjhnMVpuaUI1VGpuZUIrNi9W?=
 =?utf-8?B?SHZuVGE0a1p3RE1rOSs3MXg1OEZBa1NaY3JUOGRPV0ZSTkJ6cHhaOUpwSjdk?=
 =?utf-8?B?VWtGbis5c3VQZVNPMGVMQlpLaFlMOWtEbjZmQ09ob2t5QjN0ZDRlSFl0NzV6?=
 =?utf-8?B?a2c4ZDc0NndEWEw0bHdKUmRBSjI3Z1lqemF6SGE2eEY2MFhORGFsVyt1RzBw?=
 =?utf-8?B?M1lrZjlpR3FIZXBNcXJjamVzQm1yQVRNYnI0ejNtYnZzU1dtYWhoYllMb1NO?=
 =?utf-8?B?ZnRWQnA1aDBPaFJmcHFxT1hWQmVodVA5Z3VCaXBVSGNtN1RMUDdRWU8xVTR1?=
 =?utf-8?B?cmdNS04wc2J5TWRIbmZDeTNOR0lvTERWQUtxOU96OXloN2ZqaGtrSkdxaEZj?=
 =?utf-8?B?SUFEZHJ2SFE5OEhKZUNBMXY3bytSQURhVURCc21BU0NZTjVVNjdnMHFycmg0?=
 =?utf-8?B?dVJXU2FLUjdvV1o3Y0RCZlFCUEt2THhad2xBckRTZnBhbXBMUHVHcTdqNklv?=
 =?utf-8?B?NVBCWUs4RHM3ME5GNXI5TlVlMGVlQmhLbWxjWm5DSFRqSDBmd0dlbktGWkV4?=
 =?utf-8?B?eERJR3JKNEE4NEhmaFlzelpmZ1BHM2R2UkE2SXpadDh3bUFlWmlJUXYrRmVP?=
 =?utf-8?B?OW56d0UzdmNoYTI4N0VjZnpzdUZHTGorV1ZSWXloUm03cytaemdjY3J4Rk0x?=
 =?utf-8?B?NU9aT3ZGMTdBWkt3OHZPbUhnbGtxd2dBbWRQaStseVJoWmswbldlajlUeFov?=
 =?utf-8?B?c0kySktiMEpUdkRvUXl4Y0NnT0F0VXZVUFBOUlpYbFN4YkdqTGp5QjlJZTlj?=
 =?utf-8?B?MUZrWnp1eHM2S2V2blV0TU9SbTIwVVNnMEpsTlI1dW93MVNmTWl5UCtnWGR2?=
 =?utf-8?B?aFdSZm8vNE1aTkNLR0hTaGg5aGhBd0d0UzJxb0R5K0dLUThEbXdVOVMxUjRi?=
 =?utf-8?B?OEp6UU04TnF3WkwwUjlPcWZkTnRrbWFqTWQ1aGN0NHd3aDBWeEs1NWE2RHBI?=
 =?utf-8?Q?rNT0lzcKV8LMV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWxsUjI0WlBBTWdNc0l0L2lqc3crd1pIV29odVRHdVJNZ0tVQ2RtaE9sTUY3?=
 =?utf-8?B?MVZjNkJmS1NVYWZBVFVQUjJ5bjV0bERMTE1tNysrNWQyY2tkTGl5bktobnBl?=
 =?utf-8?B?NmpvSE5Pa1pQTUkwVUFGbUFJTUZhbXp1aHNLWUYvZE5vc2I1cTNnR2ErWWZV?=
 =?utf-8?B?ckZCMndVTkZZYWIyTG5vRXdRQ2RUaFBpMkRFVFg5K2J6MjZGTElTWW1SdUY5?=
 =?utf-8?B?YjR3U0Ntem1FeklwOVlVSUMyVVBScTU2NEUzU1VjSzJUejZEMi9LaHgvWjlL?=
 =?utf-8?B?Y0Q5eU1tYURlK2trOWVmQzBEb0hzWHhXeEo0SEIvZ2luYXdDa3pmcnRzWSs4?=
 =?utf-8?B?NlZtZk8rUVFVdmhaSVAwV2xwTjYxaTJVWXFkYkV6SUJkemJ1WVlkdmVhQ0Zk?=
 =?utf-8?B?STB1SGUvbUNEdEdYbkMvemlkVFlZR3Mxdjk5ZHcyWXJCdXJzRXhkT3poTkNo?=
 =?utf-8?B?YVhhVy93TlErb3RlUjRaT0xobm1TTjhyRnM2b1BjQ3hmT1lxSVZRZ1NOTHVx?=
 =?utf-8?B?RU96YnZIVzZmUWRmcXlSdGxwR0syYUxsWGtmMFJZS0tJU2U5QVRNRTNGQ1ZW?=
 =?utf-8?B?SHJuT0NMN2d5b3hiRi9LYXJGSERGVElyZzFrVzFXU05RRURQN3hTS09rU1Nj?=
 =?utf-8?B?U0hOeDRxQmpSbkh4ZUNtOHNzbmRxUjRRbS9ETmtGZ05xeUN0OW93Q21xb3Fl?=
 =?utf-8?B?UkpOYWxoS3drM1lvblk1bWhuaDN0MndTT2tmam1RdnE2YURZbHVleGx2L1lT?=
 =?utf-8?B?NDZsWFVuTm9NeGtTNXQwZ1Fib09WVEg3SGVWbWlZamdhVVYzMVVwa2NRN2N5?=
 =?utf-8?B?ajRrVis5TWhMWE1sZXExTnJ3MStIK08yY1MxTk42NDJzSk81Nmk0cmZJREpW?=
 =?utf-8?B?eUpuanpUc3p6aTNyUnRabU1Hb2wxU2tmRDV6aHl2SkN4dzNsQ1ZCUEYwUk11?=
 =?utf-8?B?Vk1pSHRhWFJ6QTdWTENuRGlobkY4eGJhL3pPSEsxeDQ4Y0xsMjMvNkdwTUZO?=
 =?utf-8?B?MEdHOXFLcEhYOGNWSVIyVTJPaUhyYk1yeStqNzBTc2lPNG9VTTV6WlJ2dEwy?=
 =?utf-8?B?SWlHMFZZeWVLSkpGU3VkTGZBRmJKVUVSMHVrK3dxRkNmQVhGb2hiU3E5Q2NO?=
 =?utf-8?B?TEg5ci9oVU9nd0dDVG5pcERWdTM2NlZpbnV2N0RPYWZGTjE5RE1ERnZNU01O?=
 =?utf-8?B?ZVBGMDczQS9CT2VSeXJQZzlwZFJzbUg0SXVlSWJ0R1g0eWhHVHk3RUlnVnpT?=
 =?utf-8?B?WVN1NUc0a1dxM3RVQ2ZmdHNURGxzRmpzdW53VC9SaEtucm1KNjZhc0dyYnJ1?=
 =?utf-8?B?a2lDenRMZ0VuV3E4OVk2SCtPK0FRL042aDYzKzlqRnpjSW4wSmZEZ3J4MFdj?=
 =?utf-8?B?NmlJWlJIN2YwR0hSNUtZckJ0UVZlSGxzbnRaS2p6TXJCWUZJOXZSbjZocFM4?=
 =?utf-8?B?ZUNrR00reFEyQmhzdHJYMFMrcDJtVXRncGNqZGJCT3JCSEk1c0t4TXJUOVVi?=
 =?utf-8?B?dWZWMmxsWFNmMUY1Nzl2cllCTC9XZEFMMWhZV3pvNjhsb3IvREdGOVhGcjg0?=
 =?utf-8?B?OFNuMS84NlltLzR2WFBBYy8wenR2S2NnQ0ZOQklrZkJqTE9oRFRZQ3IrQnhl?=
 =?utf-8?B?d1owUmNLN00xNWIxTHVKVU0xbnFZSlkrV0tDOWFWRkUwWHZkamROd0hiOVJT?=
 =?utf-8?B?RGJLNGJibms5ZFVnY29zUjlaSjJnWSt3bXJaUmJ6RjJoOG5iak9hOGpHdDl3?=
 =?utf-8?B?Rm1LNThQVVUxb2pGQU9YY3pocFBBcmgycU1zL2dUTVQ3RGJyUGorSlRoNkNM?=
 =?utf-8?B?Q0VUYmVkV2VZLzFYa3lYc2taaU5NSkUrM09NQlZDN0N5UTFMTVB4VWRWYXM4?=
 =?utf-8?B?SC9PVTBlMGNWVGRLUWZpL2pVMGVOZUhBaStPUkRhVjFRS1Bkby9Kb2xKUFdr?=
 =?utf-8?B?M1gybEwyVzlEU04zYUhJT2hHVG5wUS8rdGRPWmI2bW00bUVJbG9Rcm9FaWdM?=
 =?utf-8?B?eEhteFFzMk54ZmZaLy9qdWs2M25ET3N6cmNINGVZMHJ2dy9ndmNvdUxPQmVI?=
 =?utf-8?B?bXVLMytCd0FhUXRqdFpSam95Z2lCeEhvTytZYXlHNHBxbXgydGxjV2hDYW5l?=
 =?utf-8?B?NUMyU0UyWkMwcXhmVE1PcWdTdXFnV3dvM1d5R0dkdkVmazVPZWZlck5NZWlD?=
 =?utf-8?Q?ahed+gxLK19Sgqjx4V7NOCU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d76b8-b303-4da5-2086-08dd1b40d849
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:39:07.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3kCiiqIDW/6Wa6ZVPvZb5M0WRAUnuuUS9udYu0DUfiPxGSkLyZg6rd6UNR3r3fenTnTEg/7p4HPMFkwb4TTx+wNi1t+iuHPZgYcRbynFVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0053

Adds initial support for the STC3117 fuel gauge.

Output of test_power_supply_properties.sh:

TAP version 13
1..33
# Testing device stc3117-battery
ok 1 stc3117-battery.exists
ok 2 stc3117-battery.uevent.NAME
ok 3 stc3117-battery.sysfs.type
ok 4 stc3117-battery.uevent.TYPE
ok 5 stc3117-battery.sysfs.usb_type # SKIP
ok 6 stc3117-battery.sysfs.online # SKIP
# Reported: '1' ()
ok 7 stc3117-battery.sysfs.present
# Reported: 'Discharging'
ok 8 stc3117-battery.sysfs.status
# Reported: '38' % ()
ok 9 stc3117-battery.sysfs.capacity
ok 10 stc3117-battery.sysfs.capacity_level # SKIP
ok 11 stc3117-battery.sysfs.model_name # SKIP
ok 12 stc3117-battery.sysfs.manufacturer # SKIP
ok 13 stc3117-battery.sysfs.serial_number # SKIP
ok 14 stc3117-battery.sysfs.technology # SKIP
ok 15 stc3117-battery.sysfs.cycle_count # SKIP
ok 16 stc3117-battery.sysfs.scope # SKIP
ok 17 stc3117-battery.sysfs.input_current_limit # SKIP
ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP
# Reported: '3704000' uV (3.704 V)
ok 19 stc3117-battery.sysfs.voltage_now
ok 20 stc3117-battery.sysfs.voltage_min # SKIP
ok 21 stc3117-battery.sysfs.voltage_max # SKIP
# Reported: '3200000' uV (3.2 V)
ok 22 stc3117-battery.sysfs.voltage_min_design
# Reported: '4200000' uV (4.2 V)
ok 23 stc3117-battery.sysfs.voltage_max_design
# Reported: '325000' uA (325 mA)
ok 24 stc3117-battery.sysfs.current_now
ok 25 stc3117-battery.sysfs.current_max # SKIP
ok 26 stc3117-battery.sysfs.charge_now # SKIP
ok 27 stc3117-battery.sysfs.charge_full # SKIP
# Reported: '3000000' uAh (3 Ah)
ok 28 stc3117-battery.sysfs.charge_full_design
ok 29 stc3117-battery.sysfs.power_now # SKIP
ok 30 stc3117-battery.sysfs.energy_now # SKIP
ok 31 stc3117-battery.sysfs.energy_full # SKIP
ok 32 stc3117-battery.sysfs.energy_full_design # SKIP
ok 33 stc3117-battery.sysfs.energy_full_design # SKIP
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0

v8 -> v9

- Corrected the error message

Link for V8: https://lore.kernel.org/linux-pm/20241210080954.5067-1-bhavin.sharma@siliconsignals.io/T/#t

v7 -> v8

- Add output of test_power_supply_properties.sh script.
- Change 0X to 0x in macros.
- Fix typos and Specify units in property comments.
- Remove stc3117_update_battery_status function.
- Convert voltage and current from mV/mA to uV/uA.
- Represent temperature in tenths of a degree Celsius (1/10 °C).
- Export average current and open-circuit voltage (OCV).
- Use devm_delayed_work_autocancel.

Link for V7: https://lore.kernel.org/linux-pm/20241202094328.14395-1-bhavin.sharma@siliconsignals.io/T/#t

v6 -> v7

- Removes extra spaces.
- Fixes error handling.
- Fixes the logic for checking battery status.
- Fixes typos.
- Removes unnecessary commas.

Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t

v5 -> v6

- Use shunt-resistor-micro-ohms property instead of sense-resistor.
- Remove the battery node from the binding examples.
- Add interrupt bindings to the example.
- Correct the Signed-off-by (SoB) order in the commit.

Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t 
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            

Bhavin Sharma (2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 608 ++++++++++++++++++
 5 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


