Return-Path: <linux-pm+bounces-41785-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGHvIIzIfGnaOgIAu9opvQ
	(envelope-from <linux-pm+bounces-41785-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:04:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89195BBDBC
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973BD300A380
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF884314A83;
	Fri, 30 Jan 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEmrxYLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED062256C8D;
	Fri, 30 Jan 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785476; cv=fail; b=bN5Q9Yhb1uvpBqVNHuKdeiJKqs42zwHHFmjFOVUkoA7gCMMlSUZadHQjR8WLj0ZfUSCfSDDlOApiqeQgNoAj4saIZHGX8Ru8Y2aa/R/krQrXCp2/S3EDeBHQskOmBcoA0Vr7vQJycwxmC0LyWx9bR1mXtAs+Jt77JKt8xbjDdUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785476; c=relaxed/simple;
	bh=/3VLAI68Y4Y+wW7EJcAlK9o2Hwj5cAQ+eYmnfB4Ur64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUrri9xFse4U/2QU9WSDE7rSDoJnUHrDyHZpOFQVQ0N3TeLb6+vFsCPAWun3mkmcIDINgUJxJPeIrGqkKbFU1cT/es/RHmVFS4mR1k0vd0KDmzOpTa0Flkmtz4/LhrtvsWiXipnkDLrtrBIWOnfDAgSx+gHLjJndcMH0gdGdjFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEmrxYLH; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEv1VMSl1fjunpGHnP9+/9kED5WGwjl1XyDmNHVCukoyOFzTSP5f/rTqKOcNEFwwHjd7gNogz3Rds6zGah7ras7CYqdn9D14TLrc/3F9gG7r4WuFGF4mIIeWnEOc9RQwIKxjHO0wEZDy+LVs92+tiLsdROdEcuocCAyB+lTGv3tdiwMjYO9qqD6W+gOX6EfZLloV0s7H6pDMpRIcPPHfkh29aoLn6vq3z18fon9xwduRNwMZClgEppA546qlR4dg/Wmitu9CHAFRtEGXMqzFxvHVcR8PdYnxHUAlcq5YVJar/WpQbMhBWcdaAuOtUYNoKgj8GO5KN7If9hY9AH8esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn6/7HBh+piSTc9bIbgB2mtpUX0QqiliqgKqZpE5VxM=;
 b=kmX2Ka1kiYIanlLrUQi6pYTaRwOWeD9uRMJ5v+JnjorQOeT8oTNw9RipmqqBJyUNNt3wv2YJO5IACGs2BBK1oKXRpmNFdKYVdnHl3eQx93MP1WOF4JPwamNZK+I61NF16rTroEfBoz2p6ArYVxqL3de0+xnovm7yr+AoIftSv183gQaTQWyMAxk+oMdyUth4Rf+jcedKduh+nPiTmYgz/RxGcGdPsPo0syf6gWIgzCihMgnAu4Zgt27NenyCvM6qt6gwIjATu/0k1K68ElDOrL3wwuCW8xigXXAwLWywszzshT4a4j9cWvD2InIk1DdpMa/hU15TON0BanWcPbABxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn6/7HBh+piSTc9bIbgB2mtpUX0QqiliqgKqZpE5VxM=;
 b=aEmrxYLHvZXS1DVvPFudCKlDQKOaLvbYwKxQ7KvwmdcssZf28GGrICPieP0eNvNrtQLVE4uSrMS9u759/G40uHJq6EEC6rZ8itI08lUsnlDbn2vXGx45bD6YPHkkp7m+9/mtCB9P0npwL6O1xNdmnJR5ljK51nW4p4NAX8XUz2p83n23CJmlhkjz+RubjdzdDVkQDSa5PgE/sS+Yt5z9hYVtHyYYnEaJTqlfCvhemWbvRW+7/IN4jWxUaHPUETDjmNOYpI4OSSgot5Wqalk4GmIS1dSYv9/UjDYnYLJbPGOVxj+yAwd5HWADjzc9k+ZaO60QhBFjboLTSNAuU7gevg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10160.eurprd04.prod.outlook.com (2603:10a6:102:407::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 15:04:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:04:31 +0000
Date: Fri, 30 Jan 2026 10:04:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
X-ClientProxiedBy: PH8PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7670f342-feba-45a4-f8a0-08de6010df1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDNNYnh6ZDdLcjZhZFhaQkZGYVY3VFpmcU91TGMwTklqaFNRRHRXTEF2QTY2?=
 =?utf-8?B?dyttL2JqSnVLd3RWSXArdnkyQUZ6dWhQNDJNWGt1ckNKTlAzQ3dUYW1tUWJ0?=
 =?utf-8?B?RFhWRmx5U2VEelNmekl5TGRFUXA4aHloTWQvN2gwZ2F1RmpaZkVIVGJDUXRM?=
 =?utf-8?B?OXYyUmhsekthdHMxdGhsOFJFejZTbk1tdVB6YzhxOE1VSFhwR2UzN1o0MjlS?=
 =?utf-8?B?K01QeTRRYllDaU9Ud0I4QUx4MWpQQ0RGY2plcHZuQ0NWbkJYeW93UXhCRmh0?=
 =?utf-8?B?bDAwbTNCVFMvK1kxU2FUNEs5aWVzWXlGMVBLWHZMcUk0UHFGZzJXT3RIa1Z5?=
 =?utf-8?B?QjVGaEczQVh4MVIvSkEzcTIwcm0yNUhzMDYyVUx3YktYN2EwWFpSTU1yZ1Bz?=
 =?utf-8?B?Tm5FOXh1dDlWY3BHRzNycUt4THJybXBad0VNZXlHZEJHMllJRmY5c0FLcTFM?=
 =?utf-8?B?Q1V4YXkraU9IMDVIbmRmQzEwaU4yUGFzT2JjNU1oS1cwR0RpV2VZb1dkUjlS?=
 =?utf-8?B?NFlDUjR4MUxhSVNTaE03UXp3WkNxM2hkUWtEajd0Tkd3M3VqR3JEQVh2dytp?=
 =?utf-8?B?QjBxbVZaa1NhSVRHVktRUXNYQzRDZFdyRzFpbUJMUE9pUk5RdHNRQjN4aGdM?=
 =?utf-8?B?UEVpR2V5K2VvOVN6aDRwV3hWek5PNUl2YmpJbDZ5NG9kK0V4UlVMVkZoWTFX?=
 =?utf-8?B?RWI3M3lMd3l0L2VUT1U4aTFTYkgxUndEVW8wSkNKZTBsVldQb0M2TllVWlIw?=
 =?utf-8?B?aHNkRVU4VlYxdmtueDIyZGVhM3QzMVkwZWw4bUxMNVZ1Uk04a3BuWTlhNXVa?=
 =?utf-8?B?Sk1xdXVhcUpCbEc5STdZeDU4dkQ5REhFRnd3Zm9hV1E0amptbEV4REFZOEdm?=
 =?utf-8?B?OFg2K2paYmtlQXZaNitDRHV5dXVzNEhISFRyUzl3d3FYRUsrYTlSRVFlNVpN?=
 =?utf-8?B?WEZlYkdvMmM5VFN4Sm9DVFZkRTlVU25STFVyNmpzUGdRRzdDa3ZTN1lEVFhz?=
 =?utf-8?B?NjJrTlhJZmNYd3ZqVERSSEZoYm13SlBzWXF4dGVkTHRacHV0Y1ljUXZZbGEr?=
 =?utf-8?B?L2pwOFZudVMvMk9tMER6cllzS3ZmdGRaWnNnZlVKVnljdllyV21rSFJmYVhX?=
 =?utf-8?B?NHBONGJpUkZPSnpHVWszeXJtNkg5Z0grcXR0ODBrbHpMUGM0ZnpzZUdScGdn?=
 =?utf-8?B?RlhDUThER0pmbXlhdnVVbW85Y0lIaDR6TUpad1Bza0orYWNrSVNyUklBS01q?=
 =?utf-8?B?YUdqZzhFdFZLQkJGaXYwUTkzSUhnWE9RbmxCL2pQWEhzWXJ6dHlaQ2FjMnBt?=
 =?utf-8?B?Q2IvOXV1Ujh5K0N3QTJjQlJrdHE4bi85ZG1lbTR2N1h5UE9tOXY2eEVubHds?=
 =?utf-8?B?TFdNTkttUEJHZjJERnNQOCtBLzZGeWFjWW1WcmJCUjJTWmhQZzVad2RVZFJF?=
 =?utf-8?B?djJNVUVoQnpWN3dlSWFSK2lBWis2cHNFcTZaRVV3YW5rY0ptaDF3aHNHZDR5?=
 =?utf-8?B?Y0FQVksxQU04VHdNcTdZNHlNejU0TktiQzk3MjlrUHk5cFhNR3FRY2Q5cGND?=
 =?utf-8?B?dnBwSGQ4cmlSRkoxaVZpVEttM015ckdXYUNibzlXdER6U1Q3R2VVSGxoL2w3?=
 =?utf-8?B?eUlLTTRIeXQwT2IzMjM3cUtSQTJGeVpheWpsaVFNMHRINXc0by9PcnRKR1Yx?=
 =?utf-8?B?bWcrS0F1RDFmcEYzM0s3WjFXcVVWaDVQWlRVN1JlTGFPZzRpNEdOeVd1MXFW?=
 =?utf-8?B?Ry8rN2cxOUM0aU1EWUFYMFdoZ1FGYkx0d29pYUxTc3MvcWU0aDRjaDAwN1FG?=
 =?utf-8?B?MmxmSGprRkdjNHRPZVcyQ0had1RLVysxSlprN1oydU5sUFNydDY5ZGxoeFFy?=
 =?utf-8?B?SkFscFM1ODYwY0h2WG5GcmlBRmI0cnljWGRmZ1BCSjN3QlJCelpBY0oyQU9I?=
 =?utf-8?B?QlBuWkhQNmN1MSt2UVF6RDNTL1BVR0VVNEFOZkl1US9wdlp4RFN2Y0grTlk4?=
 =?utf-8?B?SHBjN2swd0ZrR1liQTlJTlgvM2xORWRQUFZtTit3S1NPS2FzYVduOUJkbDl5?=
 =?utf-8?B?NUpUTEgwSkI0cTdRd2dOeVBsOUlMaUJKS0QwVHJpOHBnQUJUQ3dwTWk5NVNt?=
 =?utf-8?B?Nko3R0RhRERSTFZraXN1VjJxVUVFc0hMK1huUVI4Si9XZlVyY0t4YWdxc0NS?=
 =?utf-8?Q?XlAPDd5yafL6QK7Y9BHbods=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG5uSkZ1cElQa0NDRzJNQ2NNVk5aK3FseDVQM0NPVFA0K2xjMHArbXJXdU5W?=
 =?utf-8?B?b21UektOaDVCWTdlT3lnSUYzK2hWdjNTNXh5SFZ2ZEZYY09WbTNXa3Q2Y3Z6?=
 =?utf-8?B?TUNYbDR4TU8rQnNibTRTZTBxZlorMFNrRVBLVngrQnBheVdSWEoxcXhmblpS?=
 =?utf-8?B?dXJBNm1BeHlJeEZwSHNlUk1WemhGU1JYamlacE5FUVl4eHZDbENBVG0yRVVm?=
 =?utf-8?B?QmJFbWFqQ0JNejFkMzBPZzRTNHdINzdORDViZlhtN0ZTdURkOVNpbEpEQ2NV?=
 =?utf-8?B?YWxDa1BhVW9hTzhBSFRpWjFuZjUwc0lXeHJJQmdqcjVCSzh6K2xVajFFeHI5?=
 =?utf-8?B?c3VuTjdkbC92eXpCZ3dZckhpT1R0U3duRnFJSmcwbW5DS3ozZjk0RkkvNXZq?=
 =?utf-8?B?c0FjWGJibjdPRXJNMEJTajQ4bVRtUVJ4S2F6QkFYSmpVUXMwRjYwREpZRDNq?=
 =?utf-8?B?ejN6OFloUCtGdEZjc0VtT1NLSjRiNzJMVFUyL2cxTFQxN1lEOEFSRTBrK2oy?=
 =?utf-8?B?T2VkV05hUFN5MlI5UTZHbndDRWsyeDlqMS9VSURmajB2K1JDYmR1SHJia25t?=
 =?utf-8?B?Ti9Dckc0SkNyM3d3YmZXVHlzLzdna09JYVpTR2xkYVdtcFNJQ3g0WGx2b2JH?=
 =?utf-8?B?RGFsZUhHb2p3VUZTTnBLaXV4dTZoMFl1clEzQWNMa0RYYzU3U2UvWE9oVlZw?=
 =?utf-8?B?d0N0d29PSmVwS2xjU00vSi95MWVYNnJwcmxaWUtMa01KbHpGZ2ZUbExYYkN0?=
 =?utf-8?B?ZzlVdmJWRTdzMW9Yc2dsU1FZT1RRMCtoMU1hangrVzlBSnJUR3ZUTUZBS0xs?=
 =?utf-8?B?OUZwRnBMOC96ZGNZOGVWQjQwUmpBNFh2V2VGcHJDTWRsNkp6UWYxNEYraUt2?=
 =?utf-8?B?dTQ3c20zTGxGdHNPdStIeXlIYmJjNm90OEpFazE4WjU4OTNTSHFaMGorUW9o?=
 =?utf-8?B?cEpMZzd0cG9GdUVUVU4rUTFTTmlMcG1zZW1VS255Q1BHcXZCV25nb0V1NVBU?=
 =?utf-8?B?OUcrSjFuU2xBQTdWcGNvczJ6M0g2RDhNeUhudWsxWk8zZUxIWWNIRGNiNTls?=
 =?utf-8?B?bUNUcGJwaythSmUxNmdNSUQ3MUJJZTVRSjFJclk1eGQvZXJYUGQwdFRnN0Fs?=
 =?utf-8?B?WXpOeGlHeDBvL3JBenUyWFZVVkJHQkhCa0hHWnlucVVVamJ0YWpjOTM2Y2xo?=
 =?utf-8?B?aXBGUUpSUXBualRUaW1BNnY3ZlB0dDhhdTZGQkNXenJkQXJQQ09IOFVwelYw?=
 =?utf-8?B?b0tyRXdwdHlPcDdBdjdMckZWclN2REloemt3cjRhWFF4aHg3N05iSEtnbXR3?=
 =?utf-8?B?RVV5cjRjM0w0cUFqL1V4TFl2aGVSdFlUbWJoYVpSM2x4enJIWWVqTlVhNkRV?=
 =?utf-8?B?cFZDUGdHYXMyOVgxWXJ2VDVXUlJETEVMNHl4K3h5bUh6bjV0dEdsRzkzbU1l?=
 =?utf-8?B?R1ZjY1NVSCtjYlI5NFduMWlvZWJrNlVyVlBobDdyZlhMWkpQaDJPZjdKdHc1?=
 =?utf-8?B?YS9xQnExMDB2UnVqZ29ObjhwZFFuSEtIbExXWjVKWmZsc3FqZXgxL3JtTkZC?=
 =?utf-8?B?SVRrWE4vaGpxM254RFFodHk5b0ZtcXZuMXMxSEdjVGxwNjhDZEQyYkxCWits?=
 =?utf-8?B?bi9LV2FTMkVmbE9PYm44dGY5R2R3KzF3YU5FOW1Mc3Z0VWd5Y0tPRXhvelVC?=
 =?utf-8?B?K0RBVzA0Zk5yQXRSMlZ3TzR2cHlqQk1sWHhMcDZJenhDdTdubDljS3g2cW11?=
 =?utf-8?B?Q1hmWFZDcXovVjFIZktOUUdhOEhjWTA0WU5GMHVvQnBqNDA0TTdLQjlFclRN?=
 =?utf-8?B?azJ0QU44QXR3dUdIR0pVWEZzQTJiNkxicEprUHdLdDg4ZzVKVGxxOFVGL0VS?=
 =?utf-8?B?eXhuZVNKR0VoRnJRdmJXMEZuNHlGTWphVjZkRG1HUmZ6bTJmUjlVYnU5dVI5?=
 =?utf-8?B?dW1nOGdTVUh2N1NYWTlkL0p2bG1QUkFPU09jdWoxVUdsVGswczB4Nm1nSy9y?=
 =?utf-8?B?eXV3QklqS2xnUTVZWWlwNUhqeUxTMWF2aUFjcVFKc0NVbEFQZkczdmdVcTJa?=
 =?utf-8?B?d3dDTHR0R3JLLytweDFhOUtiOE5XQ01zTEhOYTVkN2xvUit3L1pyeHI0bmll?=
 =?utf-8?B?TkVGUTBCN1Q3TVFGenU4endhb2VnQ3E5QlY4RityZXA5aEVodmttN1JQdjdZ?=
 =?utf-8?B?RTgwMDNUTGwwNmJyZENuOG95ZEFKOFAwakdIWGZrVXVRcEtQU1Vmd3J3SE1Y?=
 =?utf-8?B?UE1OWjk3eDNuVEhWNU5xU1kyQTE1cFlydEVzanlXV3RrT3VtSU9PREVCd0F0?=
 =?utf-8?B?aUVPREhNNExOb3FaUnQ3UjdpenlNVkdNcWMvS3FMMDVoZysycDE0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7670f342-feba-45a4-f8a0-08de6010df1d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:04:31.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X04rfa9WOfEvMVZmT7fYyDq4G+yVEDt7/DEJRfdZXRlZ2HdHqcW4K3+yXU0KveZ+m5NumhJVq7clUDD2dspLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41785-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 89195BBDBC
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 09:00:33AM +0200, Adrian Hunter wrote:
> On 29/01/2026 23:00, Frank Li wrote:
> > On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
> >> On 29/01/2026 22:00, Frank Li wrote:
> >>> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
> >>>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> >>>> where a single parent device hosts multiple I3C controller instances.  In
> >>>> such designs, the parent - not the individual child instances - may need to
> >>>> coordinate runtime PM so that all controllers enter low-power states
> >>>> together, and all runtime suspend callbacks are invoked in a controlled
> >>>> and synchronized manner.
> >>>>
> >>>> For example, if the parent enables IBI-wakeup when transitioning into a
> >>>> low-power state,
> >>>
> >>> Does your hardware support recieve IBI when runtime suspend?
> >>
> >> When runtime suspended (in D3), the hardware first triggers a Power Management
> >> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
> >> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
> >> the clock is started and the IBI is received.
> >
> > It align my assumption, why need complex solution.
> >
> > SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
> > queue.
> >
> > IBI work will try do transfer, which will call runtime resume(), then
> > transfer data.
> >
> > What's issue?
>
> The PME indicates I3C START (SDA line pulled low).  The controller is
> in a low power state unable to operate the bus.  At this point it is not
> known what I3C device has pulled down the SDA line, or even if it is an
> IBI since it is indistinguishable from hot-join at this point.
>
> The PCI PME IRQ is not the device's IRQ.  It is handled by acpi_irq()
> which ultimately informs the PCI subsystem to wake the PCI device.
> The PCI subsystem performs pm_request_resume(), refer pci_acpi_wake_dev().
>
> When the controller is resumed, it enables the I3C bus and the IBI is
> finally delivered normally.
>
> However, none of that is related to this patch.
>
> This patch is because the PCI device has 2 I3C bus instances and only 1 PME
> wakeup.  The PME becomes active when the PCI device is put to a low
> power state.

One instance 1 suspend, instance 2 running, PME is inactive, what's happen
if instance 1 request IBI?

IBI will be missed?

> Both I3C bus instances must be runtime suspended then.
> Similarly, upon resume the PME is no longer active, so both I3C bus instances
> must make their buses operational - we don't know which may have received
> an IBI.

Does PME active auto by hardware or need software config?

Frank
> And there may be further IBIs which can't be received unless the
> associated bus is operational.  The PCI device is no longer in a low power
> state, so there will be no PME in that case.
>
> >
> > Frank
> >
> >>
> >>>
> >>> Frank
> >>>
> >>>> every bus instance must remain able to receive IBIs up
> >>>> until that point.  This requires deferring the individual controllers’
> >>>> runtime suspend callbacks (which disable bus activity) until the parent
> >>>> decides it is safe for all instances to suspend together.
> >>>>
> >>>> To support this usage model:
> >>>>
> >>>>   * Export the controller's runtime PM suspend/resume callbacks so that
> >>>>     the parent can invoke them directly.
> >>>>
> >>>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
> >>>>     parent device as the controller’s runtime PM device (rpm_dev).  When
> >>>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
> >>>>     instance’s system-suspend callbacks from using
> >>>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
> >>>>     PM is managed entirely by the parent.
> >>>>
> >>>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
> >>>>     by parent-managed PM implementations.
> >>>>
> >>>> The new quirk allows platforms with multi-bus parent-managed PM
> >>>> infrastructure to correctly coordinate runtime PM across all I3C HCI
> >>>> instances.
> >>>>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
> >>>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
> >>>>  2 files changed, 22 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>> index ec4dbe64c35e..cb974b0f9e17 100644
> >>>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
> >>>>  	return 0;
> >>>>  }
> >>>>
> >>>> -static int i3c_hci_runtime_suspend(struct device *dev)
> >>>> +int i3c_hci_runtime_suspend(struct device *dev)
> >>>>  {
> >>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>  	int ret;
> >>>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
> >>>>
> >>>>  	return 0;
> >>>>  }
> >>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
> >>>>
> >>>> -static int i3c_hci_runtime_resume(struct device *dev)
> >>>> +int i3c_hci_runtime_resume(struct device *dev)
> >>>>  {
> >>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>  	int ret;
> >>>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
> >>>>
> >>>>  	return 0;
> >>>>  }
> >>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
> >>>>
> >>>>  static int i3c_hci_suspend(struct device *dev)
> >>>>  {
> >>>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
> >>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>  	int ret;
> >>>>
> >>>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>> -		return 0;
> >>>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
> >>>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>> +			return 0;
> >>>>
> >>>> -	ret = pm_runtime_force_resume(dev);
> >>>> -	if (ret)
> >>>> -		return ret;
> >>>> +		ret = pm_runtime_force_resume(dev);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +	}
> >>>>
> >>>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
> >>>>  	if (ret)
> >>>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
> >>>>  	return i3c_hci_resume_common(dev, true);
> >>>>  }
> >>>>
> >>>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>> -
> >>>>  static void i3c_hci_rpm_enable(struct device *dev)
> >>>>  {
> >>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
> >>>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
> >>>>  		hci->master.rpm_ibi_allowed = true;
> >>>>
> >>>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
> >>>> +		hci->master.rpm_dev = pdev->dev.parent;
> >>>> +		hci->master.rpm_allowed = true;
> >>>> +	}
> >>>> +
> >>>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
> >>>>  }
> >>>>
> >>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>> index 819328a85b84..d0e7ad58ac15 100644
> >>>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
> >>>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
> >>>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
> >>>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> >>>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
> >>>>
> >>>>  /* global functions */
> >>>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> >>>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
> >>>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
> >>>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
> >>>>
> >>>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>> +
> >>>> +int i3c_hci_runtime_suspend(struct device *dev);
> >>>> +int i3c_hci_runtime_resume(struct device *dev);
> >>>> +
> >>>>  #endif
> >>>> --
> >>>> 2.51.0
> >>>>
> >>
>

