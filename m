Return-Path: <linux-pm+bounces-32214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5CEB21E9C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E492169F27
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094326FA77;
	Tue, 12 Aug 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BzrfCvR2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BzrfCvR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C927311C18;
	Tue, 12 Aug 2025 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981496; cv=fail; b=eumzYYOsJ9fQiSse5Gmi6hqKTN91pFnayxGK7DZ+oWeDrIL6EuKWDLiVS9jUzEpCzIEU1EO6jQZuCs7JGJHRojtvHls0wbNYXcj/JOs+1YgUidzvPk6xaIaedk8mPG6M8+KCUtr76o4fQ3N4ruHFCEHy/qrgU9ERRwhhwPzdWwE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981496; c=relaxed/simple;
	bh=IKuQcxbkqMZ1Pbb2g9YdZ8K4UQLfULYlNxcrUTG0028=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s81OhYkRsp3zN5UzOp2N1B9On1wiC2CJA5QwYfNrObc8dYS8X6S54wsKBFvrmBOS1Io6QYNSnn5SfgcX16wmVDYoSVDuCEgXrjxFBuUdByCNa5j6fNe/QFVkmuhnBKFKcezdNovlhzhcI4gk4dguThEI28uaMFqkHA/WRRrzhDw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BzrfCvR2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BzrfCvR2; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Vw2m/UXhbMf+1bgLJtKO2GlVyrsitsR+qLWGk1Bif3pAJjCvAu7vZA7pUSLjhA4hwYrotgDI/3pVaKKUlSQNadcgKBHPlS1aBeNMt44H1ZQtmZUeuznd2IEGzP8T2d9vTfp02vQnHJ0V2BwHXbA/F21vTymPnMkNJl28b20RBvfCZq7XeVVnpCKwisKtKoy9a7w5HgHE/W1Ko9r7iaEqisA8oylAVSwIh2tJTI73wLSSqZ+zZ+tir/9+P4bG9bwJRfY2PhC+yJoLc/CVg4+IZTD9bwY7A82JeN8gskn4EWvE/jGcnX5lZ3W1taua+kjuanCA2BG3hWWsUVbUh9N6Zw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fphoEJ0N6eLXmrArp0JEn3QRS2Vvspa2gEW/2TBn6XA=;
 b=XJ/ddk2CCYnDXMLC+OFbPdyItX7HE73uDH1I9n2RItzHmlub4KHHqnvNTCU7D6xqaWFzk72dj1m+tFHP6RJ0Z526Zl5VXB2hAWaHxNayRoGJAag2vQHqo+XKmO5xO5Y++3a+c8RqjdIH8z3RtpFXDqhBN/XMw+HWWk6wANCnHAPzquwCBRh99j1kKGwf6lSc+ZjoWA7BFSuMvE+8bdkNmjmCn7n1h3+nE8WlF3vzVvidNdZEbcIAZv86G1Wp8PH53QSELkeNrYvFc+Yr8i6wHYJ4GmhNbR4PRni3qwqVOmIhYHdWvikD0ORtjRew5QLlKfavS/skIc2wn4DcW2V/rg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fphoEJ0N6eLXmrArp0JEn3QRS2Vvspa2gEW/2TBn6XA=;
 b=BzrfCvR2yb4eG/HQqrsL8QWSQPg+oXDmAH77ywnxhq92IyOjz89/IhOjnhRenFd54DphN/vtE6poBMJgUVYKf59Of71uopQpQDFLOb17lgqZ20qlk4OFZeG98uZYukw7aGILwp1x/hC5dkcbtdTGwBW0jc1RBJmZYfHqVYLYowU=
Received: from AS4PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::15)
 by AS8PR08MB6232.eurprd08.prod.outlook.com (2603:10a6:20b:296::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Tue, 12 Aug
 2025 06:51:29 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::36) by AS4PR09CA0012.outlook.office365.com
 (2603:10a6:20b:5e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 06:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Tue, 12 Aug 2025 06:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/cGgjoY10WxlQrdakzrTYCX0NUstiBt70VjyS3dftmVFQC/Jbpp+FM48sPbFaV99Mo1ffimcpQ8WTDEiDshLBIcU7qTiEV2tk3YEdOojSo15NdeHngmG7VQR1PNJ73ZQJq3EDYYBCX28J7RWEjEwD/JrefJ9Sb9pmPFr2vehhNFho6DesM5C9DOyx3qwNdgVV1aZ3f0CP4nAKQ5UZuCl+jetHlu+dvHR6ITwHNYAosEaFgp/spgxeUM+RejgPwPMGtLyEyGbfiKG/PyxQK62XGWBWOoDF/8WrzUCLR38Deiisso/4Y8jA8TqBmK3+n0oAveCMBtPQZ52vSW7JA89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fphoEJ0N6eLXmrArp0JEn3QRS2Vvspa2gEW/2TBn6XA=;
 b=HVsKSwYyWjBNnBZwAqWA8b1xFmREGHLfQVr2xJ715C4JxuC1+4ns0059RT12f/Du9ry/7hGyyVn1A5yIGMoiPRP26XUMt8Jv/dLoKMww5bDTLcfH52PicdWqkR8KU4iliptCMZtK3M4eX8H/p5vH1Sp5K4NhLf2LoJpALwkFfNA3pwJFCKUkcg05Z2+8bCvrk2u9ekBdD00Ej2EZZ/vhuEyeK6h3Ew9NsTjurURJnBedLTqLMKVP6/D2X8WTlNb9IP5q7Wu+htXSotgoUfr1yoEg2UMOCRKBVCj5HTcoAZ6IFdcssvlTlZeMnrtpuudUcmGjUu8qj1/cHYF7/T5a9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fphoEJ0N6eLXmrArp0JEn3QRS2Vvspa2gEW/2TBn6XA=;
 b=BzrfCvR2yb4eG/HQqrsL8QWSQPg+oXDmAH77ywnxhq92IyOjz89/IhOjnhRenFd54DphN/vtE6poBMJgUVYKf59Of71uopQpQDFLOb17lgqZ20qlk4OFZeG98uZYukw7aGILwp1x/hC5dkcbtdTGwBW0jc1RBJmZYfHqVYLYowU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6104.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:50:55 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 06:50:55 +0000
Date: Tue, 12 Aug 2025 07:50:51 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 1/6] arm64: make SCTLR2_EL1 accessible
Message-ID: <aJrkS9tEFtWfXDGN@e129823.arm.com>
References: <20250811163340.1561893-1-yeoreum.yun@arm.com>
 <20250811163340.1561893-2-yeoreum.yun@arm.com>
 <86sehx92ev.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86sehx92ev.wl-maz@kernel.org>
X-ClientProxiedBy: LO4P123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6104:EE_|AM4PEPF00027A64:EE_|AS8PR08MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: c6071aa5-710c-4a89-1a04-08ddd96ca931
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lF3vV0IHSR42+F2YpuGO1t0XUu/SqUkY+OdE0rX71dxuI0Yth/n/zMVveXXI?=
 =?us-ascii?Q?cfyjBeQMWp7KaoDw0ORrYXb1Fbu6iVE/jT1fwvY5+ZvEMDcKfjVlKs43Jifb?=
 =?us-ascii?Q?O7HnUsL4EzkcV76GSlvfxZlGfxrt2ghdRCpdYafCA1ePDql/sUGLI1CUpjfg?=
 =?us-ascii?Q?yFMIfef/bdqYhHnf1raNOwhDvSwGnUjqaJgRRfEDlfwD3EXa0H5Edz6jJwma?=
 =?us-ascii?Q?I4en0JiPtxfTpAzrm6rOGNSfWFNSKwC7mdpsJ6jPkq/oFlovmYrndnZrc2BV?=
 =?us-ascii?Q?jlPk926sernV0tJehir6N7Q/C5wxPxb8XfeVtYBjK8NUW6p3ibnpC5/LbCy3?=
 =?us-ascii?Q?v9Pqe15ayf2XqvKnWwGvKBz/DxeRpluEEmUHMQn8z3fhi9QUO9HN9sj+JTZg?=
 =?us-ascii?Q?lubhrfWOPgWp1JZW0FpxriW11N1GNnSWoyRrYdvahx8fzJKCfiWtr3LLWDkG?=
 =?us-ascii?Q?GNK1xxuE4j65czdOFo5uf38X2DsIheqlKdJfiQlIItE/dRRcSf1zHVUymFDn?=
 =?us-ascii?Q?2SVtEvLwvxjwZaaJozIGJgNgwAlFfrP2/A6g0R1kd3EzyrfB1YOM3sOvhWs0?=
 =?us-ascii?Q?zIgi5G2r6s6wJKzs9CcxRvJqPGgRgj2x6zflJC+AVlgVWHnTd875golX4GtI?=
 =?us-ascii?Q?ezo3MzLltVx8tBeE9YA0cix5dcnHibXDtIYSqIc+89hOy6Bg2t7i1+JHHmy2?=
 =?us-ascii?Q?b3tZQ69Q00wEXgV+FAlr88KJu3BGZWmyMdJRvuLaepnAC5ri+VfvQnAZE/pp?=
 =?us-ascii?Q?T+pdJJUF+Mgr9kLgzDU0MnvYY6be+Ma41tZL6AiGzwlXaoRMFE3A1+FbG7w3?=
 =?us-ascii?Q?bsHs3k7O0Z0dQ8nkPNlYUYKTrtQWAj9hPzTmuXpIqoj8VFWVG+Eb3G//0+L2?=
 =?us-ascii?Q?veG8NYuBPKRklA0SVm7l7OxUcDbjF5OxOIYXtc2w+Zmplzr4Y4cj9aeHUrAr?=
 =?us-ascii?Q?qamVi8x/TA7jh/kcLOWemwCyLXY7EG5XMWZ3jZ7TIWO2MjjvvqTMZ4H3UetD?=
 =?us-ascii?Q?Nan2H7n2hxwn5lW+4pp4/AFAqONUMrt/VeVulCiDooCZDFLYZlN+5L+3OjtV?=
 =?us-ascii?Q?IxpE7GT8xQ2WINdJhlU5obEuiA4r0I+QcHE3J5A/LW+e2EIE/LtyB/JTPN7c?=
 =?us-ascii?Q?7TRJtuM4IjDgIsiVAOxExBs4Sv6u8bOKPSNeCnpzu/63DWjbg5tu4iBACPQ8?=
 =?us-ascii?Q?sqSknSoZY0ouN/PbSAhg5z94xwdJfKCSTnUHrJjUDueFke8jm062Us2l9HVJ?=
 =?us-ascii?Q?ZjSMdgVfyriKayRlN0d99eBuNc9IJZLn6YV/9PVHdlcx4nj6MwZQ1+yXmNh/?=
 =?us-ascii?Q?BC0Z4cBkPqjOaGeui12ZM05IRuKQzJMLcW+lr99IRzm2VzSwA8Ff8JMB99bU?=
 =?us-ascii?Q?ZXztonCd/QiDFgz295yeBuJrkeyU9DjPbUeGkOOJpwcLV03+jkRnBPDqeGCF?=
 =?us-ascii?Q?4ZxmhEJr7NI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6104
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b7d755f1-698e-4ca4-71c0-08ddd96c95bd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|1800799024|82310400026|376014|7416014|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5cuwc7IW2uPd1WFh8yf+ExBOBNeZNes8yXXDXPqeqoJe4j/vKgbreIQ7C0a?=
 =?us-ascii?Q?CxrNtRM6MLLSdxYe9p8sf8Y9qzHsgfTo+zKH54X8mDjSHwjvlYNevi9mGXe6?=
 =?us-ascii?Q?iuJb6vjf0KX0HAXuQ5U9bbfiKnZ8ghge+UqInHo2X7G2xrR3KwiH9y/rWfm8?=
 =?us-ascii?Q?wnAEAkB2rEt1dK89uexPJUho/T40nhqRrA39L7NgPcdoMGYHE+dMNmURUBZd?=
 =?us-ascii?Q?y4Y6x17ZbLhAqzxCSZG6jZPwlpzKgPUW06tXNWEXNMxcnkhqAiys6/xzPqP8?=
 =?us-ascii?Q?5DN8fT2F5/Lvi16fpyxtVNv1JoF2fii8BFcgXtQtgSphrekYMEb/5ApR+9pb?=
 =?us-ascii?Q?pqnKo39yIiAIufPk9q9lux5i/8C96eULmawzNp5YXbGCbKjxwaFw2HBkog+T?=
 =?us-ascii?Q?WVnkfZWmJUW5c/SPcncfMMEgeDlYJmiQH18wM8Uz2pvjBZnM/bDir0MW6P76?=
 =?us-ascii?Q?qPR2zMJVBK9gwlyIU3hRQF/T2cvAZ/DjtmSfpW3Ka1v8rJ5VmWEBCHhi5le6?=
 =?us-ascii?Q?oO9jhPqsr8zb+BTFBfQKF3+Q1kFUbisF2gasMkWRF5+hFsVexGWx/ExRHc0A?=
 =?us-ascii?Q?rWlEWzlVYGKdaqWOAlbe7RiRq21Zf7wu5K+FnOLKVeLxvV9/Ux03DfQ5dvaK?=
 =?us-ascii?Q?j7K8JJyRQyv3SbwaAP1zLunqxPGDmc7c7gnunUjH7Axgid+zLPruq+dK2WRJ?=
 =?us-ascii?Q?GTDd76/7d/+xodHDmlO39eOQVeuB/fgNWRFO8j6Td1en2QrurO+MnM4IDThQ?=
 =?us-ascii?Q?ZRrZCNMxRqFBvl4Qns59N8sUDJJFPhY1Uy3uiREjW0P/+MD7MpwlGSkB93n4?=
 =?us-ascii?Q?a8fI1COcuIF0LKjNC4ECcC2Fhs2wNUH6hUaA9sGf39kOuXfsfDTxjk47AoF1?=
 =?us-ascii?Q?drZGA23DGku0ezv7CEF5sMrursbYrYxG03rFCi6W9lr6l0e1X7s0V8FVYI64?=
 =?us-ascii?Q?2OEgRXySf4/LIaTIebuUEkzChA56z/YiKOHD+THxtVh885oy6/ixAlSearB0?=
 =?us-ascii?Q?gz3nwrVkyFYkMYBUIUe+Bk61L/8uUR1EFlMzV6t5MBK2ukFmXKdLNq0bEyII?=
 =?us-ascii?Q?L4buNngrSz1hqAgU62rbuFkIEhZUMQ/d562yGjPi0j4rITcE/XD67DxcHda2?=
 =?us-ascii?Q?PHkbTS5SmPvENq3owxghg/uWUVTYT80BJOU0APA5CQiQ2YH6iOiYEwvAFauq?=
 =?us-ascii?Q?BgBL11fbiKvPoWT6LnnU6Px89neMrGtYGOQ73YndV6tkGvIkVGj4y3zKOqej?=
 =?us-ascii?Q?vQmSZ8ODo1JuMTUMGdn+KFUzZqsaxOkqk7SE5yB1+nSBvwFEPZT0YBQMfg/g?=
 =?us-ascii?Q?+EwEuUHG4kNpJEaUF74EzsDFDsVovBGjY5f6DselZpTCJ6GNaWGWeximEWcb?=
 =?us-ascii?Q?/YvOA6pTWPKM+CZ43cy62BVG9oxuOZ5FVUFpsmznZpRhGukrXGgvuKRyWg5S?=
 =?us-ascii?Q?gj1YC9VI09DjoNRMmNP2GCuxXZgr61gz+EtCUBGTbMHmPxZVobRP10hzub/9?=
 =?us-ascii?Q?HrtMKjh5q2e52XV1YSEj3iP2CKgr5MWOVQ9V?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(1800799024)(82310400026)(376014)(7416014)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:51:27.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6071aa5-710c-4a89-1a04-08ddd96ca931
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6232

Hi Marc,

> > make SCTLR2_EL1 accssible to initilise it.
>
> nit: "accessible", "initialise".
>
> This could deserve a slightly less terse message, so that someone who
> is not very much versed into the boring details of the architecture
> can make sense of this patch. Because, frankly, if you can access
> HCRX_EL2, why can't you access SCTLR2_EL1? You know why, I know why,
> but hardly anyone else does.
>
> I'd suggest something along the lines of:
>
> "When the kernel runs at EL1, and yet is booted at EL2,
>  HCRX_EL2.SCTLR2En must be set to avoid trapping SCTLR2_EL1 accesses
>  from EL1 to EL2.
>
>  Ensure this bit is set at the point of initialising EL2."
>
> which at least explains why we're doing this.
>
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/el2_setup.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> > index 46033027510c..d755b4d46d77 100644
> > --- a/arch/arm64/include/asm/el2_setup.h
> > +++ b/arch/arm64/include/asm/el2_setup.h
> > @@ -57,9 +57,15 @@
> >          /* Enable GCS if supported */
> >  	mrs_s	x1, SYS_ID_AA64PFR1_EL1
> >  	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> > -	cbz	x1, .Lset_hcrx_\@
> > +	cbz	x1, .Lskip_hcrx_GCSEn_\@
> >  	orr	x0, x0, #HCRX_EL2_GCSEn
> >
> > +.Lskip_hcrx_GCSEn_\@:
> > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	x1, .Lset_hcrx_\@
> > +	orr	x0, x0, HCRX_EL2_SCTLR2En
> > +
> >  .Lset_hcrx_\@:
> >  	msr_s	SYS_HCRX_EL2, x0
> >  .Lskip_hcrx_\@:
>
> With that fixed,
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Thanks for your suggetion.
I'll modify it.

>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Sincerely,
Yeoreum Yun

