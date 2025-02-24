Return-Path: <linux-pm+bounces-22773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E058BA41549
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5708A3AD8B7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F771C84AF;
	Mon, 24 Feb 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVkAJ9ek"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F21C7012
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378207; cv=fail; b=aCDIbknneROUAZBmZVCJmRDrSaUlxotu3XMZ8gjO6Hp7WiX/fm93y0ZpbdwlG8HX8IWSwKECQsGeePVZ8/FXxOGm6oYxCvbZt13Zr6qSmWxiGuL0/x5IIMpsH3y7RmZ4+qCywrqukVaq5wW+fQ7uTjAfqYDEZIP9y8VlcWM1s9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378207; c=relaxed/simple;
	bh=fbma8iytnNipvQFU1N/Wu4vg2NgEiVrGE1HTZeaWN4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=opuEOZNkqI4dR0UgrKjNSYVEs6HCPxUz+6EBJfs03x6MPyOB9ICG8/KLRayo8c+ZtYJgv5CpqpAYKZcIaU0FfqIZzzsAg1n4oMdRjCjrOJCDz0WyS8jVOoPjKFKkLMfocDlr7/DQMFhjtyFwrkUIv6RVM1iFYg4Cw5EgsEvvu5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVkAJ9ek; arc=fail smtp.client-ip=40.107.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxrLA81tuyUGApXxocTjlyxbsHd4bSIHm+yq49fC1nu4S40Wbsngjt1nHor3KTX6dVGyw+cou2FpWGY0MDfuLNO1OJ5xTH2cuXsPbGIw5a1vnD/zAs3Dy0wzO2hK4gSSyyU+2O7K3SJ1sp4bLix8KuLE0stWgpvzToEfww4bH40WJ17sT531G+meyQkHDkhHVzUgmWzC4sw2zjeYW9ZZqW2Bz2W3f4jA0f1dek3xNN6PUybwzQ/clUuNKsVrSoQDu4e1GVvsVuYKwnHN4pJKRxNWPxOqd/Apt1PzpSeYk/kUUOhqDdV2wQS99ZUuSUeuo9rgdNl457rFZQmp/g077w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVrdDACLZL/SJJeRIl3793OwN6Vb0eMRbWMHU+vGG6Y=;
 b=NVqyVDAMcj0DmHldgU8HGP0hvR3cJ0zFAXMmRu9TG2xP4ytKPrMX80kPOBhTtxcbjSeMog31LohBQfKhMS+Q1RHjYt/VmUy5wAoWZtRN9ERxDoCsMbFw9wLyto9UsIHYVLH253h40gS3SrvcK/156PpAVUs3BwK+OaWZBWxMNAeaBOo+dxebU35OyoZYXuhlwyPIgCtGKy96YdUbVWvjylKapqI0fQL7S0Lb9oVPRt35HZBDlWuhEGpMvBJA10dzHxrfua296DylOc9O/1bLPYd33NvXORfVxKYhWIrvkFYkWBMjj8mIdnRUoYHrOqqRIkXM7Fs+byB5hEZ8hOFzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVrdDACLZL/SJJeRIl3793OwN6Vb0eMRbWMHU+vGG6Y=;
 b=NVkAJ9ekqCbtRbx6DSKqO+Pel/3RkhmSQ9ZqdgD7svgOqxiq9pBEChFJ2WrBNZD3ysmaDKVai2Kv/91w5DSy4CubPttzKaycb1CvoayRLhzVcbiKIfLQc4aCf1kKbvBqRPeImYwO3qa99YTJazkLrRnGcOLgGDDGxTbHi+GrG30xry+urLaOhTz1AAY9yFZiCGZU6P1o2QEnQKUnndW2CLoGJevXZv66/jgfbceQkX7vXWAgFn7ODp0WeJ5AB3jJdXAD81mzoVS6gHnyz1EHPPCvzf2HtFDb8+TOCeJM3PMX8VyjTd1jboFYGkyWHSg7+zWCSqqbrF+bHWArJc8dbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB9414.eurprd04.prod.outlook.com (2603:10a6:102:2a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 06:23:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:23:21 +0000
Date: Mon, 24 Feb 2025 14:19:59 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org,
	dakr@kernel.org, stern@rowland.harvard.edu,
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH v2] PM: sleep: core: Clear is_prepared if no_pm_callbacks
 is true before checking power.syscore
Message-ID: <20250224061959.xzsk5eddj4xjlenq@hippo>
References: <20250213105840.2864654-1-xu.yang_2@nxp.com>
 <CAJZ5v0gGO95FvSVg1xrG+5B8rbDCXbVyfBm8jDgiKUXieTfVPA@mail.gmail.com>
 <CAJZ5v0g40qBahsytn9AUn_dPLG-1E+UCQSucA=8kCGdi3bzq8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g40qBahsytn9AUn_dPLG-1E+UCQSucA=8kCGdi3bzq8A@mail.gmail.com>
X-ClientProxiedBy: AM0PR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::48) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ef9cc8-0304-46b1-4584-08dd549bbc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkNib3J2Y3l3K05TUkxuSGR2TWl6b01lUnpHLytqa0phR2NmblBKVTR2bXlL?=
 =?utf-8?B?NG1UWU9QeEdKd0FSYWpuZ1pEYjNhRDJFRDZSNFlWU3ZKbEp1TXVucCtZcVdK?=
 =?utf-8?B?ZEtmMFpsK0FXNGNaa0ljekJjaG5JWkp3YjNjbjVzSUw2WVBUY3FwNlg5RGhC?=
 =?utf-8?B?RjYvYjllblZpdkN6U2o2bzRwRklRZ0VHUkxWRjRTNnd0alFKdGlFNm9aSnRC?=
 =?utf-8?B?WHpXejFOZDVGUnlLeWRWVUc2eFJmQUhTVXJyd0RUUS85V1duZzN5aWlra05X?=
 =?utf-8?B?bWpwYWQrd0tpR0NROUVxTE04TWh4dGE1Y2hpbXExbkhHNVpTRjYxUlM3Vmpj?=
 =?utf-8?B?bmpxVVNiVnNCbzZkVlUyaEVPRFFuaWcrOUZZRzA3aVZ2M0dkNm5aSk0vUmV0?=
 =?utf-8?B?WU5tK09tYW5IeVVQZkpPaEFoWEdEcHdkU2F3b1RLaysxQUF3L0o3Z2h0Z2VZ?=
 =?utf-8?B?cThHNTFyYjhzUVI3OVdMcWtSRm5PYkI1c3grdEFwK2ZGemV2L1BtRVZuYnMx?=
 =?utf-8?B?OSsyMllDaDRQam9ZN1UrM0JvdmRHNjBKdVh3QVN4dkkzeTdwM3NEdVJBM3BE?=
 =?utf-8?B?c2Z5ZEhNaWFrOTl5Z3o1dkJqSnlWbG9qVmNSQXlJaFYyU3dWZXFuVk9pbTRN?=
 =?utf-8?B?dVRPSGF5Z01GTGgvREJ3UGphaFV1Tk9aaktQcS9adTNmWDBvakpwUEdnZ0la?=
 =?utf-8?B?emg5NVhmYnk0bzdFdFVCOEgweWpQT1ZWU1FiODNWYXY3d2x3YjJmdWhrQ0sv?=
 =?utf-8?B?ZldxWUZXa25MWFU0ck9pb2dDZ0RhSEFNQzVHcDhSbjlsSzlHUWgrL2NJUEJr?=
 =?utf-8?B?N0pmZm1wWS96Z1h0UHR5eGRvM0FkVjc1RERuODB3MmlLV0F6THcxM21jQ2xv?=
 =?utf-8?B?WTFZUlhwdzR2Z2Yzano3ci9NQWRrUGxHWTZldG9mRnd3NFJjREtqSzFRcmJQ?=
 =?utf-8?B?c1RwVTM1ODFBTEE1Qyt6RFhUc3diL3I4Ymo3YnVMK01kK1dMM3JUNlgzSVBS?=
 =?utf-8?B?V1ozSkF5c0kvUk4xQmtVMGNmWGRxMi9QQTkwYW9mL3BEd0JEY2poWjBidzZo?=
 =?utf-8?B?TDVJREdtdVBrMWsyaWFkWFRKajd6eUV3b1FhL1gzUGc5bHJma2V3bzhNakJ2?=
 =?utf-8?B?Unc5K3JiQ0VvTUo4U3VEMzBaa0FJQmVBaEJmd0JhVHpYbWQ2QXJySWtCdito?=
 =?utf-8?B?dXl4aXhieFFnTXdKbm5ta3A2bzBXam9CSndUMy90VlhzSkxTS2JTZ1dvcUpX?=
 =?utf-8?B?clJNV2ttVTlrbFkxa21lRDl0eENJSENUcFdQQ3FWaXZaOXBqQzZOYVpEZzlQ?=
 =?utf-8?B?NlNIaWRxN3lFc3Y0b3NMUlo5eXF0M2dEbUdwS3lMK1JwMk1SRTFsd0V3MFg2?=
 =?utf-8?B?QkpCSzVCcCtXWWxBU1EvRG9MaHowTXo4NkNYV3dtZTh1aTk1YTFBRmFFN1l0?=
 =?utf-8?B?S1NJRkVUTDFKakJnbkdLQnZSaEhRVUtCTXpoOCtwL2E3SmFkcGhxQ0ZnMGM1?=
 =?utf-8?B?VWhMcnl6ZVJwUDFNcXV2RXlLWXBQY1VzdS80TVJQdGJqZFUxdXVnOEdxWVV5?=
 =?utf-8?B?THAwWmdRWnJkWm9yRVVWVU9aQk1uQStweEtHQ0VPRDVERzdyb1YyU2xEaUZC?=
 =?utf-8?B?QXY0cXRGU3l3WmwyWDhXMGVSUWRDY3Rya2xlcjJQbWlIblp1Z2drUDJaUWJ0?=
 =?utf-8?B?OEhNbXJoUDg3TEluaHhhU0FKbDJQUzN5RzMxaUhGVnF1RVgwdnpxZmdPRkxi?=
 =?utf-8?B?d3NrbnEyU0hRZHdOS0pNbHpBcm1uMi9qblU2MTdMUnBSY1BjT0J4cC9JczRt?=
 =?utf-8?B?aFgybzBTVE1Gc0Z1SXlXSU1VVUJyQjUvNzFmTENoenEwZyswanplcEZ0K2du?=
 =?utf-8?B?TVFlVGl1QU1HVm9UMHVBb1NkMnRydlhWby90Z1BRaWNxeUdsL2YzYzNKUVRp?=
 =?utf-8?Q?6iv1hLH1R5rbpF8RuS4JmNR1gcvji/Lh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJWa3RxZEVhTmZ5TGt2ci9tT2F0bEFtWDg0dThSQlp6Vk9CMWxtMVV3Wm5p?=
 =?utf-8?B?VVdrazZ5MFB1YnA4bGl4bU5kUjBSK1B0RWVPazlpV1d0c0RPOUdLZVl6MTcv?=
 =?utf-8?B?SS9wOTMxdlN3NEJid1hxcXl0TklTYWxOR05lUzdScUNsVmdDOWM2bzZDSXVW?=
 =?utf-8?B?RXFydU02MGhObG01OTRrTFdVSGpBdEdVMEt5MnErdVIvUG8rSm1GMGFZdncw?=
 =?utf-8?B?MDdwamZ3QnpacGk5WHZQYUU4ZCswRER3Q2VURERXazBxTWkvbkNQVWVJUnpQ?=
 =?utf-8?B?TmtleExHeUVxaFlhc2dsZ2VDMlI3aGhpYlNZczR6bmROMzNnRkFwS3hyTjZD?=
 =?utf-8?B?ZWxSbzJEY0Z3UmhpRE80RkpPcG5nT042VU56c0RldkpwbWhYbGRtMmkvQjdN?=
 =?utf-8?B?eGNmWHlYU09McVFkVGNheHRybVlMdkpab0hHeFk3M2xGcGpnRkxVbVNSVFdi?=
 =?utf-8?B?T2p6OHdOT0JJUHpxd0x5d2d1OW8zK2ZUSU1nMkpibG1MU01xSVVHUlY2dWo5?=
 =?utf-8?B?YXJkcFV3dHBlY1dmbkx0OHBJcFU2UDVYNFhTdUxBY3BiY1VkZDk5Tzh0MkFH?=
 =?utf-8?B?TVdvVnBSWkhyWkd1U3BUNnNtVTdmZSs4eFRrYlJHUE94dU9HT0QrVHlZVkxJ?=
 =?utf-8?B?N204eDcxWFhTd1ByTU1BVnEwTnh1NjZEbnZJQ29NMlpCdmo2YzZWS29oV1ZP?=
 =?utf-8?B?QUMyZ1k2cVVJMEJZSUQ0M0ZUNFlKbklLd1VJMkFiMkl5cHRRbFJhbGFHdVVB?=
 =?utf-8?B?a3M0akhneXlkakY3WEF1akF6RHZzS3h0UkJoOXlvdEVESzRHU2ZnVm5zbUxQ?=
 =?utf-8?B?TFVBVU5vbzdJWU1PZjgwRUFIMFFRNjFXTHljSVlWOVRZVnpJek1vdW9NeUdN?=
 =?utf-8?B?eWppMFZQM050bTFvQ2RibUNZYXppU2dLaUN3RmdFa2lWU095aklEV3k2UE1N?=
 =?utf-8?B?MWdtcEhjM2V2UXNQbU5DeFRLTkFKdmM0YVB3WFRkZXljYTdUK3JUUXBmSEtF?=
 =?utf-8?B?ZGtrTzRoOUFKMnFxYjVRNC8rUmpGSWNvdGxWVVFJOVlFanhGaEpvUUx3WnNH?=
 =?utf-8?B?czJQbm9oTnpWbk1mSE5WUjNrbW91SktUbE1LdDJHOVhVQzFZUEZjRitHM1Jo?=
 =?utf-8?B?OUwwcmJnY00wU3liZFhDNkE3MTlSRXBwQ28wK3JnWmNLTk1seC9uS1JranB6?=
 =?utf-8?B?WlVGQ3I0MXBqU20zemttTWVBK0UvNTBDQnNlY28raHgwNWdJZy81ckd1ZWRV?=
 =?utf-8?B?SFF0cFFXMTZYTUJCbVFJTm44MjhIYjN6dHgwaWZQR1FqRm1QaUxNenFoSGxx?=
 =?utf-8?B?cXFrdEJiUTdtZTQyK0gxMlBsbEVrOVNWUXQ5TzJJZnF4V3JMdXdIcXlrN3BQ?=
 =?utf-8?B?UlR5U2wrQXd1b2ZrZk1HcVlZMGo3WW1xOVRScDZDVnlXMWJMREhMdldHdGRY?=
 =?utf-8?B?L3ZIQWtCQUhJMFpITlljcTJBN3RobzhIMElyQUZlR0p4OWd4VDFIMjdQc09D?=
 =?utf-8?B?cVIxWFM3NkZ3SFhCZmQxWHBCMHJIVDU4RTU3Zmk1aFJtWkMxYTFZVkpmZWtp?=
 =?utf-8?B?alZ5dkpIRDVmQnhLNlI2d1pMRWk2cUx5SlVwQTVLYzI5ZG5pbDgxRkY4MGNF?=
 =?utf-8?B?RXBMaWtaRVJJOUl6b0NDUi9jTHVHMjRsVE5OR3loMjQwOHBrU21JVHA4c05H?=
 =?utf-8?B?QUNwcVhoYVlmNDlkaUpNdVMwRmtkM0VSTUVSKzZMaUNlUmdmWDhwUFdXTWFR?=
 =?utf-8?B?TjJxc0ZUYmZwcTNXSkduYlZXbEZwNnByZ3k3d0JuS2QvbElvdzRqb0dwK2pp?=
 =?utf-8?B?YVFWSVB2b3JWWktXVk1nS0VRS2RlMGFGbitGaldpeWoyMkpBMGozaG5MY2Rw?=
 =?utf-8?B?N2txU25QOE1XVDRqVThSd01zcTZDZzRTeFhSRDlQMVp6aVQya2FNaHJPLys3?=
 =?utf-8?B?anNRQTEzYlJxR2srT2R3cFl3NVlXQlV6UEpuRmhFbyttTW03aXNUM3d2SDJy?=
 =?utf-8?B?OFAxbm9HVWhTRXZJQXZFSTIvQ3FQdWNCMUdLc1R4d1Zmam1EbHVrdzRVM0tl?=
 =?utf-8?B?OXRVUG16TnQyQURzbFMrSklNYkJtbm51S0ZibVY3cmF6aGNwN0hMMWgycHEw?=
 =?utf-8?Q?FN+DLMV4pnqBnoYyuqRYg4tNR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ef9cc8-0304-46b1-4584-08dd549bbc1b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:23:21.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C47w1Se8UMCOlJT22xX5y7O5wRfSQS3SjLvF6CZSaTzPQ0IPhUE7Ji5jD5H5qwqcquOnBQ7b/OCPzZSQUXSIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9414

Hi Rafael,

On Fri, Feb 21, 2025 at 09:49:11PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 10:33 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 13, 2025 at 11:58 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> > >
> > > Currently, if power.no_callbacks is true for a device, device_prepare()
> > > will also set power.direct_complete to true. When device_resume() check
> > > power.direct_complete, setting power.is_prepared will be skipped if it
> > > can directly complete. This will cause a warning when add new devices
> > > during resume() stage.
> > >
> > > Although power.is_prepared should be cleared in complete() state, commit
> > > (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> > > clear it in earlier resume() stage. However, we need also set is_prepared
> > > to false before checking syscore if the device has no pm callbacks.
> > >
> > > Take USB as example:
> > > The usb_interface is such a device which setting power.no_callbacks to
> > > true. Then if the user call usb_set_interface() during resume() stage,
> > > the kernel will print below warning since the system will create and
> > > add ep devices.
> > >
> > > [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
> > > [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> > > [  187.105010] PM: resume devices took 0.936 seconds
> > >
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > >
> > > ---
> > > v2: clear is_prepared before check syscore as suggested by Rafael
> > > ---
> > >  drivers/base/power/main.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 40e1d8d8a589..5e69cfaec661 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -926,6 +926,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
> > >         TRACE_DEVICE(dev);
> > >         TRACE_RESUME(0);
> > >
> > > +       if (dev->power.no_pm_callbacks)
> > > +               dev->power.is_prepared = false;
> > > +
> > >         if (dev->power.syscore)
> > >                 goto Complete;
> > >
> > > --
> >
> > As I've already said in the other thread, my initial feedback was
> > based on an oversimplified view of this code, and the problem will
> > need to be addressed differently.
> >
> > Sorry about that.
> 
> Unfortunately, I don't think that this can cover all of the corner
> cases.  Something is going to escape, this way or another.

Agree. Although I don't know how the corner case looks, it seems like
a risk in the future.

> 
> To minimize the number of things that may escape, I would first treat
> direct_complete as a special case, so only clear power.is_prepared
> early if direct_complete is set.
> 
> Then, clear it only for devices with power.no_pm_callbacks set, that is
> 
>     if (dev->power.direct_complete) {
>         /* Add explanatory comment here */
>         if (dev->power.no_pm_callbacks)
>             dev->power.is_prepared = false;
> 
>         /* Match the pm_runtime_disable() in device_suspend(). */
>         pm_runtime_enable(dev);
>         goto Complete;
>     }

Thank you for the analysis and suggestions! Combined checking direct_complete
and no_pm_callbacks seems like a better solution and this will precisely cover
the issue I reported. I will adjust the patch and send v3 later.

> 
> This is not perfect because ideally the device with no callbacks
> should wait for its parent and suppliers (if any) to resume before new
> children can be added under it safely (in case the children depend on
> the devices that it depends on) and is_prepared may be cleared before
> that happens, but those new children may be added by the parent's
> resume callback and they won't appear if the parent is not ready
> anyway.

Understand.

Thanks,
Xu Yang

