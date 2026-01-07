Return-Path: <linux-pm+bounces-40356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F21CFD0C8
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 10:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63552301E99B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849D33032F;
	Wed,  7 Jan 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TyUgKkjy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TyUgKkjy"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C6EADC;
	Wed,  7 Jan 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779932; cv=fail; b=GCgmoe9fJ093YbXuy6KP+QOnceUQoR3SmnwtMUX265UGd7Vd4r7EQbUqr8sBPck19wY7cM0Cbiq9Zki4iMXjxa9I7Lkq0EJ/cs7e8fwnDTuBTFZBDreD6Yn5XHW2xjFoyztj5au7Os4qfeeuzYQ1kCmQrVH4r+uWA8IDZsHy5fg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779932; c=relaxed/simple;
	bh=lgIRjuf1LXI/hPvs/ZTJHmBZVUUA1z3j7lltZXwcowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czMnriKgrRiZEBg8Fy/KSVUkNtq8kpfZVwcqgiA6EpuOc48qVeDAYA0n7W6468wv4yGocZmckxXXwguntYbSoxrmX8F9UgPeRj6el7Dy0rw3qUvqeFG9J39GfjapmE5sNSiRvPhhHLhGhKdPotdiUrMuiUcpbTjAO3XtsuHtkbc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TyUgKkjy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TyUgKkjy; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dn3mEzuN9/dt1xhzhaGyZ9Od3Gz20MZmqo7e/bvENdmLSuT0DbXh5f15GK7f+zMon6TXJ2mfpZySP3IQ8JCWhbNxcH9rwY6Ajxg2TcMQXSULwlRSnECPGkNaIA5SkovQTgUVGpTvhv1q2orsPz3jgTcGQPNj07Luw59wvpkVVjoRYjfCNz1xuyiauWOPCK6oPbFVBLfiROHNx0JMv3d1GpVYtpwmm1AgGVJvzgQEp1JzTIodMYJ/JcU88PY7FzcPvMEEXG1ftRn0Kr/7QGooewBRb6+9c47r5uOtoEk3MwFatw37jP2pmPECbUt6PYY9mAYJjYgPYzpGteuCTpqSWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf8T1R2TIGRp6jgJHxjKFsuPw91vY3tZ+tPTr5JGfM4=;
 b=YoadbIs/7+ifDGrcDMWAUWaL36Ga9AaydDO36k8cG2nvL1uVw7JmNDYLAGHWLqv9rWezCOLvDzr0grPgTK2DQ8A57hpvxiPPIMksiPLl+PX69GMueD+D9kLNoy419beylX64PyMedUOyXguSCtA5P7B8ROODgParNT/aWF3kXz37MfL5NI1Y9/4jmjxU0B/I+ODtauJIE9NtiGMlYhVpsBU28xhUF079BFAgP07vGAq+f9qQp6XPJ5ozWVzbuUWK9EMgyBs2Sn5J4d/ozx50yIGNXGiNF0fRIzlBPHauIlni0JSApbDUaL85xCBnlhx3OZqQkGLm4SgSGQcsN7z/BQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf8T1R2TIGRp6jgJHxjKFsuPw91vY3tZ+tPTr5JGfM4=;
 b=TyUgKkjyM9eNr9vnr0PBlJTJiLdu5srtgPpwVh4Pb5eaO1AyWWBHRdN63/N1Ue5jf2tRGWJpWwIamTNYug5la7M7ugZdU684xgMb8QEZRGk+e2ZmfS53nsV2VDpH1WlQ6KPBl2phMLOxfcqOP/sklohbvEVZdRFxQvE+ILZ/H3o=
Received: from CWLP265CA0453.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::22)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:58:43 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:400:1b7:cafe::7a) by CWLP265CA0453.outlook.office365.com
 (2603:10a6:400:1b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 09:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Wed, 7 Jan 2026 09:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pugzS/c7PTyjxqafcTXBT8Tv4FQ34pAmbdZcr+Corbp3x6EBb0uIZGOhLJNrOkQ2ff8pRqOqH+aTRjJZKgEYAWTtTSHmg3a1ELkpZWO83r6N4o3EjZc3Ws4V96KKSkirtq0TmRcV7zCpsMKSy0YUZcI9BWcRbaV7adQqjApjUUO+sup1NHDX0uTf7tCRYmJauyiL1e6G+7YcVE9oDYwle7NQxuQ9nmmTgZn8QzkqmO0g3qtyMdDJifdD91v4rqMG2ZSGTKLYD2/DjXb1b8jIYFqqYhl+61Os21W0GI3HmAjH9qll/HgaQgm8+F38QZymRVXJDUDdPlpGjVUOBbSn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf8T1R2TIGRp6jgJHxjKFsuPw91vY3tZ+tPTr5JGfM4=;
 b=jMTtX/pEMG/aRBhI8K7OFUCt5szPiI3KIzTPdJIIKWiIPx8KYHoze1px6mwlUZCWByyAYvGyhHHFWTOFTHl4JAP++MSz+P9jgmVOmcL2Eu0pw0C+Ydhg8DD/mX7f9ly1G5Ns7yfyUuxk6WB5E6uspN/XYZAdNtnBVQEnMrIXJeta5BqMoqzK7atkJ2wMz4xjxmHwr5JK8jKh92exZ4CZLgxz5AOFoOeA8aP4/Y2IOKN04aARel7ZSdTq6nfS82BIYslVWY1oNX77AUXVhi94gl2Bp9GEeIhI2Pxes3Be2oy2RHTRNgpqXMsuIdsDRLZTtm5EYf01fU7d7UX/cUnszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf8T1R2TIGRp6jgJHxjKFsuPw91vY3tZ+tPTr5JGfM4=;
 b=TyUgKkjyM9eNr9vnr0PBlJTJiLdu5srtgPpwVh4Pb5eaO1AyWWBHRdN63/N1Ue5jf2tRGWJpWwIamTNYug5la7M7ugZdU684xgMb8QEZRGk+e2ZmfS53nsV2VDpH1WlQ6KPBl2phMLOxfcqOP/sklohbvEVZdRFxQvE+ILZ/H3o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8380.eurprd08.prod.outlook.com
 (2603:10a6:150:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:57:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 09:57:36 +0000
Date: Wed, 7 Jan 2026 09:57:33 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
	ryan.roberts@arm.com, yang@os.amperecomputing.com,
	joey.gouly@arm.com
Subject: Re: [PATCH] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
Message-ID: <aV4uDW2p+WBCitwl@e129823.arm.com>
References: <20260105200707.2071169-1-yeoreum.yun@arm.com>
 <af65f271-5af9-432d-bec9-e44638db9b9f@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af65f271-5af9-432d-bec9-e44638db9b9f@arm.com>
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8380:EE_|AM1PEPF000252DE:EE_|AM7PR08MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b040be-a4fc-4dc2-077b-08de4dd3575a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?gnfLzhbgo5fWTnxpeK+Sef2H6to0O2I4Luw1Gd/TCDEJ4HCsXrSeGkRcoY?=
 =?iso-8859-1?Q?F+O+QzAGsmO7jL+ycFj1rMoL9orp4sQE9cccSDEb2F3W2YlZs5OT9TkHzb?=
 =?iso-8859-1?Q?hgXAYOzfTzp548hicfkRg/mu1txQMKQQFQwh5mq8dx0VmQie12QNDDqrzO?=
 =?iso-8859-1?Q?r8yiGzhwJeLs0QsVW6Z3BmAWo/RbNLvuCtLkyN2RKm8hMBVNWNCsZCuFID?=
 =?iso-8859-1?Q?+F+i3zWFVU0XxIK/sDiEiAqaspI+ykKfggyXynNe46CjbiSKOrKgyFVH33?=
 =?iso-8859-1?Q?GhYiS0C+hDUm4Wq1IS0GwmfYitaQAtcyoMAB8uBjhSG3ITx85AjFDsRWNO?=
 =?iso-8859-1?Q?LFWBBKfA4eWU1WttbhIRuVTcpfcVsfmBMRi65O26NYXVM1t7zng+oWqcdI?=
 =?iso-8859-1?Q?hcu+G267DEU5ABCZ7DPlkwvHSg7Bwi8R6hY3JKiTVaM7JFEZN8PM9LeRFK?=
 =?iso-8859-1?Q?P26eKBXmw5wSgrBL6TnBLIGyD2m+bcjeuBcS6rFpuEx0m2xSbWNTyJRyLR?=
 =?iso-8859-1?Q?r1he+HHMT98JtagGlSS8j/EEFyY6grJaSFofYFSa+H36sr3WtWRuhUvU2g?=
 =?iso-8859-1?Q?dPWQoFWRiFlS5IFoIFbucgbHvRn5AuvDzEKqLx+tHi4pxcXekcnYzk+MRp?=
 =?iso-8859-1?Q?8/lNTTK5GopS0CYf1zmKrZrCqF//Sg9yuRVnkF5qsT6Kw+9ZNRHQCAQMWZ?=
 =?iso-8859-1?Q?W7hFcS6fpASsQ+LG2cOO+VplfNc0N0CGpEvyig72Bu3pyq4sVo+fYG5UsK?=
 =?iso-8859-1?Q?3R/pRwlYp7O4a/CYPL1T4+ht3SlXk18WCDbv2KseY90EHhhyi+UUc4sHsX?=
 =?iso-8859-1?Q?whaxAZr1D6s8gIG0/NfC7ce7iViwxs6ojoxh4HW/ZYuc9gB4VH4VVrwjjU?=
 =?iso-8859-1?Q?gf6ozDU2Ua7+HMN24F15+G380QP2ua4D2nH9XaCfbCFNpqIe4IJcoS/Pl/?=
 =?iso-8859-1?Q?bsRMYojL2MzTSL1VgOrG+lDGOEOSOp4elldffHqjPi+NQurymJuSW6SqIt?=
 =?iso-8859-1?Q?LvWqFNCaF9CXQh9HTqe7uhvpvM9+OLXdY+5Pndx/Cvuc+3bpvwcNszA1E1?=
 =?iso-8859-1?Q?ts9GCctW4toQwVGPLhcMcv7I9C2Ghk5clxqAFZo+sr930yK+3CSVq+PPN/?=
 =?iso-8859-1?Q?lCs14tj0m+3CDFvbFJ+HyNBrLnBWa4ETFgGz5lDSr6JwNzYUbjkcbfFlwP?=
 =?iso-8859-1?Q?vs1kEzGd9ol4horW60HAzodP+0wjppL3iAM/ZlWUKIwqHChuC+WdrtQw1f?=
 =?iso-8859-1?Q?x1gvQDE1GvtOBp8IXZcuDHKrtr62SC09bgCWTqvOfADQWZni6pK543x7kT?=
 =?iso-8859-1?Q?VK91tX4tZiZgaeScfF6NDFPT2KAwssfBzZNlh/uYP7Rd56E+vGKIy0x5s2?=
 =?iso-8859-1?Q?IxAQjxz+EtBC6yQrm9+60pMCk/P/xYRTZAYp0I1QrzJNx4q9cd53QMdBcc?=
 =?iso-8859-1?Q?8tqE7/XIp7hDSRtYq6Ch2FwYAh4Y4kgepTikp9teKYXYsB9YUzWk9XBwsZ?=
 =?iso-8859-1?Q?SqcFGTqXpRBAKZs7R5YkCa?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8380
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7773a307-d1e4-4ec1-4bc3-08de4dd32fb8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|14060799003|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GpxphLuTvC+Nxj4qx57GF3XJ5jdA/w3RH4Im8yf0XzpCJPCFtjteMug94d?=
 =?iso-8859-1?Q?Rwg3RIjhyZp2j16/FtsT0yTdzARfIDTiyZTI0WCnVPeO2IU7MdFatH6HJl?=
 =?iso-8859-1?Q?MTG27eOJYSW1SWhLm2TsEQay+9v29ZPckEEUUURwq5nYFm8Va3A0o4E3Os?=
 =?iso-8859-1?Q?AQPq/6vLhySJr8PwmLCzKqNWAzWw74qcL1ml9KDE5LLGmW25hXj7EwVOLu?=
 =?iso-8859-1?Q?kPmH86u4PcAqUdaXLZigDPt43flulEjvHQjZ19WGLhun7BD0i1K5HEqtMx?=
 =?iso-8859-1?Q?mzgVFPtE2jNKnedvbL24kiLxF/ep1WJYNyJ3Z/sMbyNSF0c0QX/2e1ZNqh?=
 =?iso-8859-1?Q?UhcntwbURmcD/m+r9kGEBLIgxmoky3uTui9NVU6Vg7b66Vhq0jNDkmWbZP?=
 =?iso-8859-1?Q?PZF9RzScePihVgya4P5A0B+AZxqb8CRPbz0I9QhwZBViUIQPAr6wEdfbnX?=
 =?iso-8859-1?Q?e9E9ne/KWvS8uKSFD45WnABn0eDLgkO8Pi9KtleG2n2igp1qabJfhqPvdf?=
 =?iso-8859-1?Q?JFvF7nDizOTyCGiKLISpQSfe5UBvK5rOjKFbHQmNpevykvsG4HlEUtf3bc?=
 =?iso-8859-1?Q?M+QOJ5eeut23G+tT1+tvLr8ujB8Iw6a2RrtOh8sbwBsQywWDyHjqewzo1a?=
 =?iso-8859-1?Q?eR6fDypwtmnnW2Ptxt0AXxHSsueHoEHQ2kccyIMJ4r5GuZoJ9l05ojY3j/?=
 =?iso-8859-1?Q?TfprWbcSUj1B0tN/cbKojo4guo/6xj8EWm2k2UrQQp/kbei4qji/VjJdYM?=
 =?iso-8859-1?Q?70phP+G0OW3KV+Y+9D7CH3Zb/AZ26rzFy8m4vlFZn8Cm1gqlDrqMiHFN44?=
 =?iso-8859-1?Q?UFzwynFl5s/9OWixDQC0d8uP5I+CVBfuVStMVAqZ5zLHg9gInNKJ7llc8M?=
 =?iso-8859-1?Q?U9sZSsuT4/mzElaNg4t/KoV8SOin6QyyKuuRfJ8GFDzREqRN9OEKi/U48G?=
 =?iso-8859-1?Q?5w2Rerg8mwIw4ELcG6twChfgIYnwnJZizSpaepv6ConfomteCvExOmimWP?=
 =?iso-8859-1?Q?2Z0eoTE0HyLiF9/KXVUf9sScVWZUUxZBMQR0ig85+6eNyBIJduQnc3mRoZ?=
 =?iso-8859-1?Q?0aXbpROB0zYMdMkz7NnaR85RvEWRh3h2QagoctpBHmvibHy3k638J97xxM?=
 =?iso-8859-1?Q?aQRJ1j1Dn+M7mhw2AMlp9pKp3ylwjWWawGmhBhveWrBgvtteQ6y9DedO0w?=
 =?iso-8859-1?Q?+oSSmj2oeX8R6NzLE2kckGbEZvPASlczp0UOd0ghSS6xEXBUruvoZEDTjc?=
 =?iso-8859-1?Q?pC8+P4yo2w1a0k8l7AmNKxWVdJ+Jm63VOLWStD4Auw0W8unNrwbu/wEXVB?=
 =?iso-8859-1?Q?+BbHlB6avXEAzmDXqnwyjhdafnOB73YckqmglzJQVXBp3w7RdVr1l7cNDf?=
 =?iso-8859-1?Q?sQLBrHZXE5PndiKtEuP9OkbF8Vd91DUimbiNKMB2jj85yDnHcdqxRTqGX7?=
 =?iso-8859-1?Q?Y0esiWg4VWPoBP5TkArB/NSkZJEIKumQyk5MN7t0Z3Rp9c5JB/pYnDe92K?=
 =?iso-8859-1?Q?QCpiqaLNE7l3G5W2eMQ3AUrXGNXL4qY4/7jigiIIjST8DQBIojDPuE5qn/?=
 =?iso-8859-1?Q?XMnsRL/ogttF1HakL6XoJDT8aAtWTAVTCvkkDwMZcd8gLM50FWmSnS7Af6?=
 =?iso-8859-1?Q?CuNyEOb7NQU/8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(14060799003)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:58:43.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b040be-a4fc-4dc2-077b-08de4dd3575a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350

Hi Kevin,

> On 05/01/2026 21:07, Yeoreum Yun wrote:
> > TCR2_ELx.E0POE is set during smp_init().
> > However, this bit is not reprogrammed when the CPU enters suspension and
> > later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
> > and there is no save/restore logic for the TCR2_ELx system register.
> >
> > As a result, the E0POE feature no longer works after cpu_resume().
> >
> > To address this, save and restore TCR2_EL1 in the cpu_suspend()/cpu_resume()
> > path, rather than adding related logic to __cpu_setup(), taking into account
> > possible future extensions of the TCR2_ELx feature.
>
> This is a very good catch!
>
> > Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
>
> We should also Cc: stable@vger.kernel.org as this should be backported
> to stable kernels that support POE.
>

Okay. I'll add it for next.

[...]
> > @@ -97,8 +97,11 @@ SYM_FUNC_START(cpu_do_suspend)
> >  	mrs	x9, mdscr_el1
> >  	mrs	x10, oslsr_el1
> >  	mrs	x11, sctlr_el1
> > -	get_this_cpu_offset x12
> > -	mrs	x13, sp_el0
> > +alternative_if ARM64_HAS_TCR2
> > +	mrs	x12, REG_TCR2_EL1
> > +alternative_else_nop_endif
> > +	get_this_cpu_offset x13
> > +	mrs	x14, sp_el0
> >  	stp	x2, x3, [x0]
> >  	stp	x4, x5, [x0, #16]
> >  	stp	x6, x7, [x0, #32]
> > @@ -109,7 +112,7 @@ SYM_FUNC_START(cpu_do_suspend)
> >  	 * Save x18 as it may be used as a platform register, e.g. by shadow
> >  	 * call stack.
> >  	 */
> > -	str	x18, [x0, #96]
> > +	stp	x14, x18, [x0, #96]
>
> If TCR2_EL1 isn't supported, we store and reload an unused arbitrary
> value. I think it'd be better to make it all conditional and add it at
> the end, something like:
>
> � � alternative_if ARM64_HAS_TCR2
> � � � � mrs� � x2, REG_TCR2_EL1
> � � � � str� � x2, [x0, #104]
> � � alternative_else_nop_endif
>
> Same idea on the resume path. This also avoids the noise of renaming
> existing registers.

IMHO, I think it would be better to sustain the change since
it seems more simpler to maintain  and x12 is temporary regsiter
so leaking whatever was in x12 does not really feel like a concern...

Am I missing something?

Thanks!

--
Sincerely,
Yeoreum Yun

