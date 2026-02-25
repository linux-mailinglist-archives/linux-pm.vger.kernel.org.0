Return-Path: <linux-pm+bounces-43187-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHE8MhB8nmlXVgQAu9opvQ
	(envelope-from <linux-pm+bounces-43187-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 05:35:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141E1919D5
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 05:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E43E6304916B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D62C11F8;
	Wed, 25 Feb 2026 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UaMXrOmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C64369A;
	Wed, 25 Feb 2026 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771994125; cv=fail; b=ZG2kvzFG8rGOBSFKXh2JK0jb+tgBkV9i5B8i0USJn1Pp1q5kPbzLcTKzpWmtaUdgH15cGV7kdDkI2L9f/PmTHI5RPDjA9qtHNsEoqrFTjzHqDvZP/eEmD+15QvDKQYTHYIwdj4oincsnk9PvjL/7LZim4XPwsxIaU9Yw274Q4ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771994125; c=relaxed/simple;
	bh=y7Sc9t+9ZxUUktZ+nPLsmQy6f/xlf8wX0kWHk5WGuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nT5rWOBdZpLBhwy9ohyFnKkNaXdDk5QpPb7WbZzPQasEWSmI191C+cLfMpqVPlSQAAStMBsYy2TlcqTB6trGlpm5GxrXAsDLTTd4lnD/wIlCu4XTnzCawmpcLDiO1FNqB0CME9ijd/UaP3gf4HHEzNqE7WuZsg6DFnYsRBFPk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UaMXrOmY; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Ak9V/fWZjc3dwJ+AjkMbnW4xpzDiiVGsbPENIpN4uS4xfpmgGG+dJFVVr63jMybCX684pa0dDVhSME3fXAdJTQ8mkMnFCSBMi830XdetdftelRirDCXvSz58LGb3aCQMA1XlixPWdGLSv2T1fQyVv/SZFAB/6etRwAHjcLOqcZG0GYwSNm9/e0vHJvGjUVuka7JluxhelgKpVWdOQZHDBdfyLsUu3VM1FZl8vYruXvp3SAF4U8W9jZXo8MxY7SdvgABVhp9zhVGyPaGlc7h71EnQCLzt3xxAyTaSnVGVGLBHhay8KVXEHBhIkqZnIuzM0O2XkQSRcsyK8XJ4+owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4SWVlFzOLRTNOdenyWbxTVPbPALSMslWZ3eG9GkXOc=;
 b=iy8MD8zqRQeveBQfhLMEujNTmgK4z/agYS6bZYtNp3VKioa1X7NMV6+zj6kTT9CTCTiFgeLuQoqdEp7Lb/F7NR+fbg0ZlhA4bImTpxWD2UUMvwzQmLfbmmiVjuEu30j/qa9fe7Ie17OOvYf4beG3Q2LMG8p8ni4qf5foGp338xaDk4uSQvI652YCK+rVJHPku3Da+BLXp5ZKX+5CWm0kKjJcDNm7BPtjC3roWZztPbHPCqGg0d3psnXBgN9/OZJ4nbhZdX7ZN/a8n5YecnsTJUQsdb5YNM/h5OZditgTxp/+esmcUJ4IZmEyM8nPRbzakATFj1rORzOR4klLr2eIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4SWVlFzOLRTNOdenyWbxTVPbPALSMslWZ3eG9GkXOc=;
 b=UaMXrOmY+3G1T61kYgof/0dqFUwVuTU6fYUuvwRYS8q1EFlM4ySCmjVpwn0SCxbqKCQgrQ1iIYsDliKews2g60c8Y6P2bmi1ShiP413+HMZBchCNFn6i75wnPk8g3T/kRZIqUYRSyVygi84iPWzMbfvtkKoiAbaR5T/su3kCmNI=
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 25 Feb
 2026 04:35:20 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::72) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 04:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 04:35:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 22:35:18 -0600
Received: from [10.85.46.153] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Feb 2026 22:35:17 -0600
Message-ID: <e61eaaec-2c77-480f-a875-3e42633a5fed@amd.com>
Date: Wed, 25 Feb 2026 10:05:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/turbostat: fix microcode patch level reading for
 AMD/Hygon
To: Serhii <spevnev16@gmail.com>
CC: <lenb@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260224023719.65165-1-spevnev16@gmail.com>
 <c0979077-a229-4584-9ac3-747dfd96650a@amd.com>
 <CAM_YkW65=Wam6or8KXdSdZFC2Q_XXqAfwREiomzH9+xgmFtERw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAM_YkW65=Wam6or8KXdSdZFC2Q_XXqAfwREiomzH9+xgmFtERw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1d7ddb-225b-42fa-fe3a-08de742747f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUliMit2eTgwSC9YNTBRa1RoQVdTSE9XVkMzTjRKS2REOENmV1NMaitGVkZm?=
 =?utf-8?B?Wm5tdjNsd1hTQjJjTWNIYXM5eTVnTktEUjE1NmJwSGlWVFhvbXowNFVIUGx2?=
 =?utf-8?B?V2h5VGpqVDFwcTJVcmhmZWpZQVd4TnhBYXdaMVo3RUZvWlQ3SUZPWFFGemZa?=
 =?utf-8?B?bHA2U3pRbDlxMkR2c3lHWHVpdGE3dGpwM3dxNW5pa1FvS25YeWppSG1oOWxj?=
 =?utf-8?B?Ykd0V0dCbXU5elhqR0JTSUlzdWNLMmJVdDk4a1dRVEpYZnJWYjZXdmR4ejd4?=
 =?utf-8?B?cTVoakJRMU4zTkx1ZURVMUhiR2UzOERUaTkzWVRpWkFkY2JHSmwvOUdTeGw2?=
 =?utf-8?B?bGpyblJYT3FvZTd5MmpDQ2R0bld3TUEwd2FUVXYxUlREZUF1aXNLNjh6NEc3?=
 =?utf-8?B?WDR0OE5xbFlDYXJsbmd5QmFtbG9sTDJnaFlBWnJSdUFHbndrS3lyeHhJUFpI?=
 =?utf-8?B?dEQyaHdBOW14RzJoU2JYZjYvRDYxY3BzR1ROcThjY3JDa054aEdwcUp5Mlk2?=
 =?utf-8?B?RmpWd0kxUGk4V0NESFRiMDRxODNENTdrZmZ6ditiK3Jha1Uyd0xWWEFYNFVQ?=
 =?utf-8?B?ci9pSkw3WjM0bVVjY203ek9OUnJHL0pGUlpVcWRlcldWRC9pVGtWeVJ2UFhS?=
 =?utf-8?B?VUp0WjBmVjUybmJQZnN3TWNSRi8reE9ReFdrZDNsZXloWlJRdEZDcUlhMnJO?=
 =?utf-8?B?dFlJR1RFUytpcTBISStMT1NnTmNJc0RkZTBLeGxKaDRHeGF0eUhpYWRFVkh5?=
 =?utf-8?B?cnJ5VVF1T2RuaytTYWViem54NUluTDM0V29KMHNScFc5VlA3ZU45bVFkWGhS?=
 =?utf-8?B?cnVHaUlFYjFFUDdUcTJXV3hQRjVCTlVBZjRJR0F6Sm5JSnJ4UjNlU1c1WE9y?=
 =?utf-8?B?WG5BK0dnRFVlTVBVMEdKdU5iZ0pqbnF4dW1qUzN0OEdEL3ZwY01JK0ZxNnkz?=
 =?utf-8?B?ejhicXUweHREaFNEckJ5UG5vVEwvcVRWYkloMDBnMi83cHlzMUc0V1BBcTJp?=
 =?utf-8?B?REhRVldvbzV2M3VsTGhzS05Ca000SFEyY2FlWldiQ1RmM3JldmJwQ0p1ZlND?=
 =?utf-8?B?aGU5S3BacVJCYTVSRk1PSFg5WFgwT0U5eU1veDhGTk8xL01Gb2EyUUxzcldC?=
 =?utf-8?B?bnlPbWdFWm1vRERDTzZ1UUcxZmpDSXFYS1ordFZSNHcrQjJ2dDM5UEFBMTlT?=
 =?utf-8?B?QWdUYlNGR2MweThHektXWE9hYzNIY2VaU3U3aUR3cW9KNlN3SjN6TDlXRHp6?=
 =?utf-8?B?YmZQNDF1ZGx5SXdKMW9CTHF3MFd6Y3dBNkNFb2tjNm9EUHFTTHBjL1lzYmtL?=
 =?utf-8?B?bVZWVjY3Qm9scFJtOE1Jc3daMURCYUFpZENjQkIwS1RUTlpYZXNacjI1ODA0?=
 =?utf-8?B?KzY3bWlDMEg4WWczZ001dmFIS01WMjBOZzg1UU5uZUxwbG4yTFAvTFlqa3Mv?=
 =?utf-8?B?aUxVWjA1a1VFbTJBek1IMHpFellVN051ZkIyd3ErRTQ0OHdTOE5zZzFSMkx6?=
 =?utf-8?B?c0RTYjZlS1pyVEdnclFwbjIxeUdDWmF0c1ZhcnZXd0twS2JkcFNBb2l6cUFz?=
 =?utf-8?B?Y0V4aC9Ea0VsWFkvMmJ4NmNPZnVXZ2ZmS0psTG1PVUZVNHVGTDJqRUpTbncx?=
 =?utf-8?B?dytRTXdzYk85OGR6Q3RpZlpzaWF5V2hZNWF3bHVBY3V2UkpIMFByZVR0SWUx?=
 =?utf-8?B?emo0bzFQRTlYR3NvYm1veGI4MSthUm9UYTEzVk5BMC9QRXZRdFZFSkdNTUY0?=
 =?utf-8?B?bXZnaUVwYzFKSFpUU3ZyeDhVMVQ5c3F2RHhKaElJRTc3U1dubGg3alhOY1hz?=
 =?utf-8?B?czQrYnl5TU1sZzNVdnhvaWd5VlFnZXNtcXFUUzYvdmRvdzhKTXYyQU54S0o4?=
 =?utf-8?B?S2pyMjRPNWkzZ054YmYzYjdOMGF3NGowd0UwUFN5MFY3RjYzd2ZLam1TbjU3?=
 =?utf-8?B?dWlycWJTbFdVd0J2Y050b1dlTmJXMi82Vmo5NHJUK2lvcDIzMTMwMDM1Rjlw?=
 =?utf-8?B?SjFpcFNQR3pKSys1ckl2bUlJZ203aFIvdWZyNkxYd05ZTmgwVXd0VmxtWHpD?=
 =?utf-8?B?a0Z2ZHJvTjhvZXNwSVl4eEgvNXl1VlB5VldZWVlUMEZWb3QyZjA1L1Jxb3Za?=
 =?utf-8?B?U1NwbU1wYU5tRHVOaDJYV3E2KzJEOFRhWEZWeERxU2lNK0FlZnFaVXRrQy9D?=
 =?utf-8?B?T1lxMnRVQVZZaXc1d2lJZnJ0ODNrYVRtQksrdEJtWXhNNVJoUTkrTE5vdGhU?=
 =?utf-8?B?RXNSS1FSaWsvak1MOE1qbkwzL3FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TdEsWR2kn5H3+7Vbkl7cnmbUaHBWaQ9qIYmC5hx5k8RrzN0roV/irLbhTj/BKBwUUFY0PNQVI0GCM5yhK9LZZDroT65OTMbhkfokrwCvl+RIvqxE1Pb+1fAhT3HeDaWtMI2WPr62ClJ0ZzC19kuubp0hDqDw1+I/GIiHBbFkWPXwARaJS2Sy8dwIn9JwqoVlHDJpbh0CiymMcmm5jhAE+yRi1I8EYuw4ZMVCqVvUbCjCXGHa+tgk2twM3g8zu3jHkCkMx1z0sEXXRQz/nRdVf2TM1CvHWvDbLTe47wCg940UxOLVWoN4YWPkoJizkc88SjOESjnzCuXQskUI6yM1qNNA2IHIXihQ7dwPRH3nQqlSbu9gUGrM+ket9Ey5BzMpIXNuo5xvjbZ0bx53C+MWQe+tDhRo0OicGsQ3XGz5OeMDyaNdmf6YiCOSRQcQnSrv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 04:35:19.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1d7ddb-225b-42fa-fe3a-08de742747f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43187-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3141E1919D5
X-Rspamd-Action: no action

Hello Serhii,

On 2/24/2026 7:40 PM, Serhii wrote:
> Yes, the only essential change is shift.
> However, I believe that handling the two paths separately is better
> because (a) using different constants better highlights the semantic
> difference of the values stored and (b) AMD currently reserves upper
> bits, which could require handling in the future making separate paths
> more appropriate.
> What do you think, is it still better to merge back into a single path
> with conditional shift for Intel?

I'll let Len answer which one he prefers but having 2 paths is more
code duplication for error handling when we are essentially doing the
same thing.

-- 
Thanks and Regards,
Prateek


