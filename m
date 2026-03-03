Return-Path: <linux-pm+bounces-43525-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IRwCUNAp2kNgAAAu9opvQ
	(envelope-from <linux-pm+bounces-43525-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:10:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC001F6A70
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C410330F1ADE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161739659D;
	Tue,  3 Mar 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hE4BPRUj"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03644392C28;
	Tue,  3 Mar 2026 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568555; cv=fail; b=CJYQIj/NVVatRTcLmAKz7gnqV76d7sfLwKZmGBSMRSqxnb2oXnyaO13rz0wyMu3m1HFtB69g2zyS4Ky5L5FddjuD7qwAwlxJsf2fltuH9qpiaCDYDi1kifq8GIHdPnSkCTwckbot5uA592e44kiTuPZ5DWV+X7bt37Y4wuspClo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568555; c=relaxed/simple;
	bh=R6PwcCisOSEFlHT5eq6eKrIklwlxQtIuEE6zcti9zrU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WtHGFzp2MfHH650RmhCpz0q8yenfgfzESP5F1TBnFX20CJlxz+mRgFwaJOKY12o7WSzSG4m+2yS/kpHfCqOdmdJzElknD5INhhf9sKBPR8cXzGV5wXMKfQzYfVS8XtQAmpK5p8qQzzbvxLVW9nRC8QJa7z/BS/6p6YAldwooCdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hE4BPRUj; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch9NCkBc7x+s5IqDHkTXseai4FZbbtrwaeRZRSfn3h2G4KfJX57ooH0uUkmH7ziMIHFiYZbpituPD3A2wTF4k0rEoccavuHJrMiEtgDMDP+4dgFBhZNE+LRj89Ex60VLEDKBX0M+TuXo3fTa7ibEVds41cVw+qB9xsjXgsvvHIWkuLLcr7TSSYEf2qvJwDupJTzz9mwmJ3odasbnz/zPsmsLaz1fM0VDux9u3eleTQH0lwBZcAu27EnBbw8KiosK7ubvTDjbr2aaNpb8Yf0+FuKZOi66qUScxdzLj0bB1r9+bJLK28nZPOrVI2TbsH+849PLTYUKCoYaE0913u7Iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/VHWhXnGBClQUIzaraUcabUFgCVEMWrKlPFqGY9d8c=;
 b=yFx77kS+NZbjU/lnNoFQasFGA36L0hQZp1J4fuVmdDnSov1cFDFfaQdo8q69kw2PVkG7bxBHbt6jfFEIVmPvp8/saWvizjcjJw/Kp181BqKBWVYr4Q3my+nGKi8+K15zQDaujfUAUVzEGL5sWzVdjyOmQrbOmdeCd8qhggNp9Y31NoI5pkCZyRo70xqdsvz3b7NoOhDU2nnZLsemnM+cgfVi7j7DoooKItMb4zsthtTIz65WmtU59ri7HASgSUn6P6KIReZPD6EB2Ehk7mJ2fvv6obnKVWTF1eqUOzHq4j8d1ArGw+Ct3VoAIJgDSQabfNzpGnNMfd1Tu0uibj5eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/VHWhXnGBClQUIzaraUcabUFgCVEMWrKlPFqGY9d8c=;
 b=hE4BPRUjgZ3zeXco87xkCNJq+hZS+HgxQu+95gO4F/5Izrhp1wMMUGIwgI7izsU2zHw9HMGdtQn4cG3K4ZaF5ZNt9PuzprI1E7sXhuTHGAec27h3zNXN+mYi3+vvQpWqO5qib9xoldwMDz/EUZ6ABvQKbQPmxqrccg1VqkraJhY2TpmlinbTjp/qJPJ89FTUdGlJ8k3FwTrv68CwqpnSt3xzg7Vqf7lgeS5GRgAnASPjx8yA2ATGFBp4Zvge53MbB3H/t03yPV882Z2Ob1/61FOBqgpGU2Bq71ET/kDN9K9nThg19EeJxXln1UExaCV91QaiNiW6H8m0NG8SI4rOUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 20:08:45 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:08:45 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH RESEND 0/5] bitmap: cleanup bitmaps printing
Date: Tue,  3 Mar 2026 15:08:36 -0500
Message-ID: <20260303200842.124996-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0746.namprd03.prod.outlook.com
 (2603:10b6:408:110::31) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca6503a-e86b-4e73-cb81-08de7960acb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014|921020;
X-Microsoft-Antispam-Message-Info:
	sJ7aX3bjePPwEapk4Gi20xzTWSn+/8H0nztQVzs15dh9yi9fbONIA+cVXkaU9H0Vms9id6iID8DAYXMI6pq7pgWe6BJVVXUgcAket28ojSdUqAnMQvQNPBjzhfGFRofExKnvTgsxLMd9nzXqV8XjiZB6JQVHE6sHXmg/QU+VXN+ycgesAhGHcRAYDlyEmWW6YT5oHVy72vEjUD+ManMA9uJizd+j4yeWTZ3sk9q3/sZkVRc7wnWVXchOgig+IWK68MDHfUi2/NWJvmXawhzTwmM+bDGTv1/+omUZUDX0uF/qRcsgXh3I2/yl8ZyBSMpzvn5zzg0HuI0JRClwyG5sgu71EcN8JtqjL401N0eXT3FlitNlz11QVKfZkIAiA44gtHystHQoKGDkA9SVv5SjzTe4o99LSq6czg7HG8FFb5C6JsBoHI2uTc43Nk99SeKZIJbyhQMseb0rl0+Q+Fdlz4+uSASKIHP0B5U8kDeAZ7ye78PPsYDSFyrWpVpA1cfTx4CbxMfC/g0fbNeqHU7jAVRc9xT4wSd3WxfpPls5f9i3rS7EvrXZtbqNBVBhppDSSMYD3Jqpq/doUSYtfAwpGyxoHH4CKQ3CYEiTOz/vaZZATpVOEPfuyOwBqcXvUsZzds9xFrrFlXHy1lskIQaYnyANFp4TCo5PELOA89c6IckZ7iJjt8SYVwRaxcin8f/u/Eer/Le5gBuRjP1sosd1H02K6BklQXURGz04VAExWHI6YT/BHuCPKaoVd2z9UCIy7DpJ4rVhHYcQfzD6yWFbJU4JM1xT8TTax+WvbBHDgh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUpTSEZHalJBWUN4MlE3bXZsd1ZBazdjdGJrcnJoVkZSWW9OYzUxWncwazJN?=
 =?utf-8?B?dDA3V0lFcExhWHpNb1VRVUdqaDdvWi93cEZGNjFYSDJ6SytCOGRJLzNGY2Fh?=
 =?utf-8?B?bHRYUFNLMnhFUUJPZlgzSktlQTROTVplSXdIdGJPdUg5b0t3Y1dyeHhqSVdU?=
 =?utf-8?B?OEJ1NElYdHRvNjZBeXB4ZXBxcVF6WEFYL09xWDdlRndVTG5NMWxpUXRmTU1i?=
 =?utf-8?B?cnpLcll0VHVzM3JGTGd4NndXNjl0TU1QQjhKOTBIRmdPRWtidUNITUlhbmph?=
 =?utf-8?B?SXRGeG52aUN2TjJuZDYwYy9rc0owNjlWRGRFTGwvMWYzMUpLTHJXK1hNOGdh?=
 =?utf-8?B?aVJFQzhpNCtKbUFFYlc5UHJKVEZNY1E4R2tSTmZCdDIwdW8xWm0vU3JEcjZB?=
 =?utf-8?B?cUNNY2doaHU1NmE4aFJ6aUE0aHNUWXZtV3NXQXJJdjlUSW1tT09FZEg5NmU2?=
 =?utf-8?B?SXErSzkyVE9rMHB4aVIza0dBRnpRL0ZDQjlwLzl6L0RJZFBvRDZpeGFVb3l2?=
 =?utf-8?B?VmFsZ011UDFGeU5tVWp3L3MzL05DUGZveVdLUkxONUkzUFVLdkU2ZHBmTjFs?=
 =?utf-8?B?M2sxMm9IcC9YTkR2aW04YmE3bFlRbkJRZ2tvM21PYnpLaGtWQjlpU3k4TUU3?=
 =?utf-8?B?TEo1ZStsWnk4K0FIUSszN2t1VitsR2JEamFSdHU4Z0dwZ0ltQ2VSRVdudHVJ?=
 =?utf-8?B?Nzdjek9qRG9vOWZTM2FvaGJaRGpJRUVrandzQXlkeUN6TGVreFJBNmJweVVn?=
 =?utf-8?B?eDlLYzJzcm9SbUQ2eVJKR004bGtBUlVOYUtOdytPTm1vK0owYitCSGEvN0Iw?=
 =?utf-8?B?R2pDNWVwR2FmaEhNcWN1V0FwL1M4SnM5YmNZalBYMjA4bHY5b2tRaC9QajRl?=
 =?utf-8?B?T0FHUkgweFlzRE5qQ3Y0d0ZaclYySHhjU2VZdlVnN2lFQ1ZzYmoyQTRTUUN6?=
 =?utf-8?B?RDlZUVU2VkZacGkxS2FkMHpncVlpS2w3Qm4wWGdZOTNUZDdtaS9zdjlNb3pZ?=
 =?utf-8?B?QVV1VFk4SEhvT2JRUkNRcTFBRjY3Z3E0MmZaRkptNlE1UXFxM3dZUG9kSTJD?=
 =?utf-8?B?NlYxZGY3T3FZWVVkUjVaS0dra21Tc0ZpSVczMmhrVGt0bzlhSVczLzhyVmJQ?=
 =?utf-8?B?OGwyUXF0dlEvVFhEQzN0R1ZxaHZwVG5DMFFDNUY5WW52dHNLNldyd0JaNUxw?=
 =?utf-8?B?MG94VUp4Z3djY1FyUjk5VmdlM3AwYnBXeVZZS0NVRzFNRk1jQmZkYW4yZll2?=
 =?utf-8?B?d0dzbWp0ckEvTGNWVmZCUmVTN2wyWXV0cVdCNmRGYldDQkpkdlZ0c04zeWpz?=
 =?utf-8?B?VVc5OVVzV2drd2JGbDFrSXJ4Nnk1dmlhWnhCUXRiUk1mVnZwL0JiMVF0RXIy?=
 =?utf-8?B?OC9uSTJkR2xCL3FoSDVEbERIZkJ2S1JFTENScW9DaGRueWdkMTQwZm45aW1S?=
 =?utf-8?B?eVAwZi8va0hpUmllNUZiV0ZuNnh3cG5pNmtPbU5iMVdjZk9wVnE5TW1VeDlI?=
 =?utf-8?B?QmZ0eG5ITGVySWttRkV6aDF3VWNJTHZrUnJXVjBobFlZQm81UkVremJkUDlk?=
 =?utf-8?B?REsvc3dYbnlPMGMxMnVveGw0SUV3aGU5NnczZ2I5dXQ0UlhYQ1RYSTAxdUxZ?=
 =?utf-8?B?b1dtRDBSakNHWVZGZ3lzU0JJRExGS1RLV2FQZnJsWng2dFh4NHhvRWxOSnE0?=
 =?utf-8?B?c1ZpTnRlVVRoQ3Y0bnhqbTN2OTdwWG13NXp2MGUxbUpuRkdzSzd5eWdkN29G?=
 =?utf-8?B?ejF2UklVSUplTzJpWWt4QUdoQ3p6eEVydFNZUU94NXZhSzhrM3czS1dEcTVD?=
 =?utf-8?B?WGdOZVRBUCtXdm5vSnVGZjBKVVNmMktpZG5RdEg4S2MvcmYxYnNpWmNrb0oy?=
 =?utf-8?B?Rjhub0UwMENEbDhhUVMvQVIxUG9VNTBJYTNvazhLUFV3UmVmT1Z1ZERRWTVx?=
 =?utf-8?B?clJzSmw2aDJhQThjME9CeVRVcGxKWFNMbjcwNldRQmNvWWZlVG1Zd3JNTGx6?=
 =?utf-8?B?ZFF3YXBRTVpMNi9RdnJsQ2dZUXFvMnJSWGJWSWV0S3JHRGRVZGpSV2JBUWxj?=
 =?utf-8?B?RGJnTXV6ZFRwN1JiYlpST0RaL21BdlU3cm10VmpLUVc5M0Y1OUJ4bTk0S3ZM?=
 =?utf-8?B?NC9pZUJhUVpYaFpWMlVyREVTVEVVczhoSTlwUHl1Z0dzeEdpQlJQZ3BvcVJ0?=
 =?utf-8?B?c21Ub1hWYktQdDN3SExTMDViakg1d2JQdlNrNVhrbzRCR0Nrd0tzSkloU1BN?=
 =?utf-8?B?bkloWDNvQTZpTEkwMFo2ay9Mc21oK1p5T1Vueno2SDJzaWRoVGpqQTlUYlp2?=
 =?utf-8?B?eFNsMG5TdnBsRVVCZjhQMWJwc1ZvcVJkOWVMSndOT1AvY2hRYVVWVy85RUQ3?=
 =?utf-8?Q?s8RAJ9Hqv25fI/llcGesIJaQVIgMohgcu/JCc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca6503a-e86b-4e73-cb81-08de7960acb2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:08:45.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OXHWcPdoepvfO7oAqFy/D/uSE6Ska9sfLHhXkaLF4UoCQ9RMC6xd4ZRErDjqwjmW38lc1cFLJX0l4JUVI8PVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
X-Rspamd-Queue-Id: 8FC001F6A70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43525-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,infradead.org,linux.intel.com,linaro.org,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,linux.dev,redhat.com,weissschuh.net,intel.com,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
print bitmap into a human readable format, making sure that the output
string will not get big enough to cross the current page limit.

Some drivers use this function immediately before passing the result to
scnprintf() with no modification. This is useless because scnprintf(),
and helpers based on it like seq_pritf() and sysfs_emit(), take care of
not overflowing the buffer by itself, and perfectly print bitmaps with
"%*pb[l]".

This is a resend of non-networking part of [1]. Patches #3,5 switch from
plain scnprintf() to sysfs_emit(), as pointed out by Thomas Weißschuh.

[1] https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/

The networking part, for reference:

https://lore.kernel.org/all/20260303185507.111841-1-ynorov@nvidia.com/

Each patch can be applied individually per corresponding subsystem.

Yury Norov (5):
  powerpc/xive: simplify xive_spapr_debug_show()
  thermal: intel: switch cpumask_get() to using
    cpumask_print_to_pagebuf()
  coresight: don't use bitmap_print_to_pagebuf()
  lib/prime_numbers: drop temporary buffer in dump_primes()
  fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit()

 arch/powerpc/sysdev/xive/spapr.c              | 12 ++-----
 drivers/fpga/intel-m10-bmc-sec-update.c       |  3 +-
 .../hwtracing/coresight/coresight-cti-sysfs.c | 32 ++++++++-----------
 drivers/thermal/intel/intel_powerclamp.c      |  3 +-
 lib/math/tests/prime_numbers_kunit.c          |  6 ++--
 5 files changed, 21 insertions(+), 35 deletions(-)

-- 
2.43.0


