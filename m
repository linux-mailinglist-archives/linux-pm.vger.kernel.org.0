Return-Path: <linux-pm+bounces-40169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583ACF1482
	for <lists+linux-pm@lfdr.de>; Sun, 04 Jan 2026 21:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F385B300957A
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jan 2026 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D152D660E;
	Sun,  4 Jan 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNbCm8pw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oL+A+En8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17912256C88;
	Sun,  4 Jan 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767558092; cv=fail; b=QeRei9UCS+VdIZm3iOkGryp3pNBUAlrqxgD29Wl+msZKsEsL7cE5Sd0K9yiqUFcjIVJ5OVRD2l/JuPKbMJlc1Pvw/pmYUwkQTyVCzeiq5jPrloMPFw0W68vDJcT5t/X6bY8+wHsurswyfzzM52gStY4XU11B+M6Ie3jlGUs9oik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767558092; c=relaxed/simple;
	bh=nI4nD08wI1c2vHo8iasM5RkvLvFT0MOmkc3szVgzxIo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=MUxazARPtwldikWCVqIot1HwGcO13r/GOqxtY9fLZl7B6xx7z6ZVJ3bTX5JuszV9zqyECiMsqT3fW+zrf6IgyBsVZGH5DKmoXsHd8h7cKX5wyMQ92L5PZG9XvJ8EIvSfPYWTKQ7z38AnG6JSxIb+abBN6qzsH8nzTh3PRGY4eAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNbCm8pw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oL+A+En8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604IwRgb229877;
	Sun, 4 Jan 2026 20:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dso7RyEhmBMilREhQE
	l+ZyUoaaVd5r29BLnw0mdafOw=; b=eNbCm8pwbfwPY6MREtbulMR75HrRTura75
	JLmljSa5SixJtvP1MJBiKl/ALCg/M0OX9TsbqfyMSRg4xOrB8EmV2hOWxkOc3mk0
	jvZG7jK2o/p7GHjin03acMOviLMOXRZpDGl8X0b1qudSQKOJ2KpwYwyywAROrls1
	JunKLrlPBP6bIEommEuWl4m5Pvjyl251G6sIa5KY9vVTnn4oZBBUCu3vdby2Mueg
	oTr51ziUG5GKuJD4EZOqNgNiCT7FRxyyotncwuP6VEdNEUnjXEfy9SPmS8799hCa
	hUhRkvV/nEG3Ok4uoLCDY60GYx8CWM7su0Ae+2lLhXhaJInhozbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev2jgxww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 20:21:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 604HU6Gm015533;
	Sun, 4 Jan 2026 20:21:13 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj6fagb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 20:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix1LlZ0wTNDvl9nnDTS3q5dZuuTBkuBNPChzOdXc7m8eXZJumeWb/Qe8DvVGAjMWhg1gUzOOlrEksNXgKCZsj0YZs4rgxv9Hy54Y+Xzcn4N/797oNJlOzyG72KyC3HC0GsDFEin5sug0jIGFV4Q0v8j6ZCQ28cVnyrQpvRCZ5LIQvSMu3h3zQzxl1bDbmVcjFq2Oh51h+zeiuQjukOUGGihyRML0S5JHFcM8u7QtVoFPFeIOU1I00ricpndGgVS3GjexxBHU1ANM2fnixsDZi5R/p1gYxWBS22x//8Vop5+RA0EKyXjfMTVrLPu0olplsFAKHYpCh/wORJQ6lwOlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dso7RyEhmBMilREhQEl+ZyUoaaVd5r29BLnw0mdafOw=;
 b=dkW+f2s65oFeg4UhzQ5Tv+bWCSAp9Ah1n5JoxDMbdC1g1dcvTJXX/LFT0itrwaKUvSV5WOddPq0pNerV1Qog9azu7+tfhU4lzXdotevFFYTOt4XHuVfukVynDC3Dx9vSYVfLSeIMeySCPcHq6jjZOpZ7bf/E3SBmHoxw8y63cuCs0CfPFwV3ORR42U5B3roAvUaBUgym1vHszbiUyIBaTZ9hxgp/FylKgPDWUfIFFfI3APe3ME3a/Zc9VDGW+5xZsNUUTWgRnrhW7xUvXxRExt49ci96TtRWHvlMX/2BW60lVzkRiZil8FriLcx6KsXCMPo8nr2jQQYte3cc/GaVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dso7RyEhmBMilREhQEl+ZyUoaaVd5r29BLnw0mdafOw=;
 b=oL+A+En8zPaF2KBhFFRT0J/Xt9I4YQfj/fixDA2n05hinNpJDtQd+/FH/Q2XS1yN1hYWUZsmos+DWzCY806u11FeydjOdH5QpZNava9/C3wWE99ySmeVK1qnEcADOd44lWoBTD27wXy/sHRlTjrUnoWHSVQAKEMafG7KrBlSgxA=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 20:21:06 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 20:21:06 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v1 20/23] scsi: ufs: core: Discard pm_runtime_put()
 return values
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <2781685.BddDVKsqQX@rafael.j.wysocki> (Rafael J. Wysocki's
	message of "Mon, 22 Dec 2025 21:31:45 +0100")
Organization: Oracle Corporation
Message-ID: <yq1qzs5t9it.fsf@ca-mkp.ca.oracle.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
	<2781685.BddDVKsqQX@rafael.j.wysocki>
Date: Sun, 04 Jan 2026 15:21:04 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::22) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 652ffd83-7a8b-4513-a319-08de4bceca32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/8Xe7mMLJsEiwYtNU/UrSo4UbmqBJEBBRWEzYmQvKwNlFSqv/xqsI/43GAP?=
 =?us-ascii?Q?Ymx1LUZCnB9QDF5+XenqZ05IkbFCPRrUT7ujLkSmDquWX886fuwcJfQ0e9up?=
 =?us-ascii?Q?A0wH7oSoYJ3AxhpJekkcQ+L3CNerZX1MiC5vVtDkNZfdMmO6gogJ0B7YE+Hc?=
 =?us-ascii?Q?iBL4DP4UELesaIWApJ1uf10B4iKhBJ2z7r0FSw7RQFWl7n475Xh32BFbrp6G?=
 =?us-ascii?Q?1pT/rHEcV3d37IEGz42Cjk5ITpjuRYVSVDp2BRAAveSCjueiHIVyFxrwq8nw?=
 =?us-ascii?Q?2uqKooiK8RNrT0u+AkVCx/4UHvzneqHXcehdP6E1Yjp1uwOreKghOYX7pggY?=
 =?us-ascii?Q?HudUWlwYtdVhVCPNLL1JAguby9q0NhU08WazeRIO+YYFqpJmniC8iaWPJ1Ok?=
 =?us-ascii?Q?HJYtzpJAEP3TxVBzPPKyEm9tFPvOp8S+FWwauPApxi7GEcq0mlSqt3s7cwwr?=
 =?us-ascii?Q?hIkKTfPjDPEkjJ0Ma1QbOUv7W70z1IAm4C7tDDWunEx7mzxnam/hjD2OuhDG?=
 =?us-ascii?Q?C3azPm83UVOyH7nyFvOoWgXRWD7eWB65ZOAyHEsOhNnf9n7uDQGPyHW/+V98?=
 =?us-ascii?Q?OhxPRewCLyoPanhDoxjZ6YBWbdSQMdbsCESHFglkB5r45+wytgxFlZpJWuMA?=
 =?us-ascii?Q?/NXlJG76eoXRGNfIFC0j/RErIpeL6S3GtIA61M2K/zFDI2bQCqsKqt45M8WW?=
 =?us-ascii?Q?i3CcyH69bHvI2TCw2xkXnUDFoF1wQdK4u0m997AcIBMy4ISZocRU+WIs5vwG?=
 =?us-ascii?Q?OXz53IICn8J3i3wX0Vun91xpqp1j0UokRI0FwZvy1rMLSDdk1mhNnels86+j?=
 =?us-ascii?Q?NDgFhNYTzDupZSHS3yc2jacw/eMLoAHMq8/N/qBWbpPJkhR22K0lEDpI0Fdz?=
 =?us-ascii?Q?HrjIWdnxbfbmU8M4tN17/eD+Loiw2NprdLBgdbIlFGAa8mewl+aTQ0J+8eni?=
 =?us-ascii?Q?ZrvVxbG1fEBeeQYyjmBzWAAFp2dnNsQGkr2ToOhqdDpTaeinG5rAUZMtdIen?=
 =?us-ascii?Q?eGZSwTwXolSSYtmJJd1kpkKPaQ9a1aMPbCKkDOIxXTwXK7bWPhmjyee77+70?=
 =?us-ascii?Q?ZuA182e0b1sxvoD/Y6E7xpvT7RXHiPJmyUUFsAt95e8zlqtgQj9Om5XRcDZE?=
 =?us-ascii?Q?iY1JLOFqOkyzlgB+Ub6ZK6Szc84vN72NtJa1qr7TIUSucCThTQJAC4BLqCbi?=
 =?us-ascii?Q?uDGyNM/mXdPYZjL7t5NahNY/sSxUAfnedd0gE2H5o/+N7VSx9d+maLkBMBJg?=
 =?us-ascii?Q?f5vkr3orBtAHQFBHFCYEkbJDgW7d8nEpr2xXgLeLIAWgHT979zNmJkVdR3Vm?=
 =?us-ascii?Q?Ok3AxTi1Si6GGreG7J/yQi/Bzm02tRzeEgQT4F4Wlcd6IH2bEkCjgHxAV1M8?=
 =?us-ascii?Q?CzEFeokB/Y+2NV+XSl5uDDPwpJYsQnlIViFy8tdB+cD3J6q/fCZ8+Plkxino?=
 =?us-ascii?Q?PihOZmInv0XGWDQ8Wc58X51NH4RWXeG8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j8U6NSd8pYrpQAZ2cAshnMxyf3gwuPER/hxQaAR3dofy7dLwqQyGZfXKqA2x?=
 =?us-ascii?Q?YhhPHPHVas/n98BeEzDNNOVq09eXs/GHVb+rR2LEASr7Y9Lit9Ho08GieQDc?=
 =?us-ascii?Q?qo6KBZ5UmwQSyGPmvvQinw3H6vYhX3V/54WcRrCA77MfiGZG2M0W+QkjSqsl?=
 =?us-ascii?Q?JWhs3DAbzBF2Ao8TCuk9l4i+NYBk3lEu8wafSGMJe9PVLukt3+4x3l6jw9aE?=
 =?us-ascii?Q?lasdkRjg7Di+5EHXrODDsU6ZdknhpQF6IJU5p7CBCKyCyYt0pU/Yce5Nank5?=
 =?us-ascii?Q?Usfm/r16njiyDSxmd0zq5Ic+zGZPt3WV3d+rYqKEPqys0kfgHubNVZc8y3jV?=
 =?us-ascii?Q?WjvyvetSja7hgGduMAjHRpZ6P7IxQclJcg9jy77RyIlI/Dy2Cb1OKC4GPY7D?=
 =?us-ascii?Q?Q7wGb5WRtErWxtuS8zAK6iszhO42+GPVW+hBCy8tem5VPiqyedK41D3lLPv8?=
 =?us-ascii?Q?Gg9hooB3+zOZUv6ZgCET4okZ8PR4IRvobqWuMIQYQdBU+tk5SMsIUzq98NfU?=
 =?us-ascii?Q?Z/6VdFGkN8XMx31hQKbT6It2Y3Z3ev+yTq01AOscxJRCrB6h0c/dN6tDp5SI?=
 =?us-ascii?Q?Sr9Mpms9SjINDVK16tLXzOwLkqOYdfLokdAkOMLsDZBAL0aclTYLr34c3K6v?=
 =?us-ascii?Q?vBEMApUvnEWHoh4GM08YTu2txIPhrunIx5zNIRBfSRIcC6GhHwxl9vmWzJft?=
 =?us-ascii?Q?D9WUxVWaa0ysRkfGvY6zplI8EhSSi5w5PCgTv9eH3Mejx7zZxc0HQn5vPi7n?=
 =?us-ascii?Q?8k2/m29KeFD8TYektCrnbkcRkzMT6Ssom75+iJ6ByJZJnbWMacZ674zraxHa?=
 =?us-ascii?Q?lx4IfELqDBcK6NVot/y8P857x/kBQg/kqf3EiILriMdF35roniywW+Dgq1Py?=
 =?us-ascii?Q?9B+zj86gGbaA6H8vJyRiysK8sNr6fYNeyI0HtlOQZtDSJUsI5ZL3UUjW2Gis?=
 =?us-ascii?Q?d2PqghFdWg7eJMEtapMMfYBcNW/3RUrqC/+j7LugO9r3oTpSvKZSH+U0mSN0?=
 =?us-ascii?Q?EIviZb2c/KG1QfCjXkrMADUxzlzhtZhzSoOvS+gWAtldb1dBRgIQ54wWov/k?=
 =?us-ascii?Q?j8CyLyQDixFhhwsTGe0jyxQa5Vp3NF2xDn+h1XV1x6Hx9m64PJYe+tjYPbAM?=
 =?us-ascii?Q?1ydxboIEe2oVn+jbikaexQt87OmZ7xn/4Tc/JVzVnKNcZ5bp5inuOnd3Sb1f?=
 =?us-ascii?Q?U/XdUnubeFBGFkk8ppaNLbHx1UG/T0vNg9n/8E1HojTONvebarn9MDd5Xlxv?=
 =?us-ascii?Q?MFyo2E7YBCWugkX5l9zZPmqIh1kUWe0bkjJ8g9DsX/UsGdvT3e4embI2Y3VY?=
 =?us-ascii?Q?UWouIRSVbxRiUDUWmoFghD7iSVByv1bMH+rOOJXp75pOzyPazCoZ+NgCSX5X?=
 =?us-ascii?Q?V/QuAZIVDe+2QEhIiJuTt3yvMOdQQB5ABLH+wtjFrzlGxw9DNRskr/GP9TKo?=
 =?us-ascii?Q?24JLcvG0g2IWWGFAyQKlyhqnyDEoi9bIIApt6UucCg3A1OHYffmY+gHEZIUQ?=
 =?us-ascii?Q?PTWAYR2VV9AksOgAElbnuCyDkxATUSMhmnafqWhkwMbLatJizokuNj317L6C?=
 =?us-ascii?Q?nY20Op9qCSnwr0IN7w8M2MY2m9DVO6AuDXWShwgHe6860M9AR9tPh7HlAC23?=
 =?us-ascii?Q?RPh38pHwi2TFFbbjl2z0TpqlrNjpw3u2Lp8Y2nmb5gSZRb/yJmHXyJR+uY+2?=
 =?us-ascii?Q?FsAJQAGVsux0krs4CZ8j6m7sGFcq8lXjUopL8cNZoqWbNgcOw4gGlo2/jspB?=
 =?us-ascii?Q?nD8rsGte1BhAk2lN6ItMOozL8P0pOUw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LkVJopnWmANuLJtVj5ERcJIza0krM3PS1enTMQOJsnzpPS9iDGKZQ+hZrUUEGtxyf2MgKPg+e1zSr1bYMEf7xzbNtZMijWIYsfYiiEA2k4IiGooClZw5YLlp8boa2mj75nZfCF9A2F9CcT9J84vm41aYcXaVJSDdjWcRXfvQPFjFqoqE8zxr4Uqvk3K6QoZWTTuyNoS4yLlpiADEeHZpgZYznnjet44Wj1jmgFvwsYkdIMLa0sUoVyA/kQkBq5vVgkcShqmC8dSJ0fTxJoNmUzB7obxmLFsykbVgcFlmEefDjuZbB5Ear/qTbD8ISd5jIns+ptqz+yeqpf5qKjFkpEecU9Y+rYjoGxXdMhsBpXUNNM0XFx52NVvV8mz4wbKk8kjq1vTDFbmFmrzjTEaN8y6nEZJo38bK22GtYSQAGWSsSjrZaDgJglfU6nl7BGKlYVAC5Fr1gGub3DtV9uDTH8tAlEQtFsrLxPCW3hqXKZu6gSl5Zz43JnjGCvdyi559ayj5fCwj7AL1rl6bu0s/3oP2I9FWG+4z5cb/I5LZrQl7+NJRRwEX78G1RY65+Oy4ht59VqnDg+kgAhznL83/DGYLKPuavKTg+U/65A8NSzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ffd83-7a8b-4513-a319-08de4bceca32
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 20:21:06.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiPUhWt78DgMIWgNnk0lT+I4XoYggjrbVU0nCo8KfTHVVufRnjVEAkB/2mh34Jjf+bAlZ7sY2SQ51pN0nCasteiTczubPpsoU2RwXeN2rKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601040187
X-Proofpoint-ORIG-GUID: e_RR3YAkWP651WK_V3noYCvmf3OLxLL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE4OCBTYWx0ZWRfX2LeY4QKGCBxy
 BDE7V+0imeHjUGfzjNViFf6ewn1UVoSJ6m1OkkMiszL4uvOUuI/S+aiaxs/IrvgFtnmUF6Y6S3p
 s4HglKGk2yfx0fbTQD0+jCuqeETU6+gvJX1X7HGW2tKYa0RN6I0ZMhc7a3gCbH2SbZNTJkKQ4JG
 xIZQoxm4Qophol8/4Xf+WqEZnplPKY5w5UfIJGnZHEfq+sdu4/OSES1msr2oDrlgRKuIkbmw0Ka
 06GQzgO4NjeD2mk/dI8MQzJbvzRihlgE+eB//MnQW6MQ/XRsxwdxu7jkPPG37wmZvOXmWBKmBVq
 8CdIuR6l/WDP0MJFKwT7UCNoCdYY0wBp/vdmOPihrkavVMjZIwpt/P0BujfciegixBiFE5TOMLB
 skibuDOxZ2sOc9utp0BDtn5w4+wj59O/gIVY7cfx1xmorThA/mcQGQU2qKiA3x+x/p1za2jXkVC
 arAjQT4C/wPcatOFVMA==
X-Authority-Analysis: v=2.4 cv=A9hh/qWG c=1 sm=1 tr=0 ts=695acbba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=l4OZIFaCrTCNLvinuSsA:9 a=MTAcVbZMd_8A:10
X-Proofpoint-GUID: e_RR3YAkWP651WK_V3noYCvmf3OLxLL3


Rafael,

> Modify ufshcd_rpm_put() to discard the pm_runtime_put() return value
> and change its return type to void.

Feel free to take this as part of the series.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

