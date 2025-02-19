Return-Path: <linux-pm+bounces-22451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D51A3C292
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FEF7A20B5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB961DE3C8;
	Wed, 19 Feb 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JmR2gsMn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jy9ZNifN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C818DB24;
	Wed, 19 Feb 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976614; cv=fail; b=Wslq4fd8NpJ00mDtGvUus+vQ7Qu7GgNRXBlVIz3U2p14WV46FeH1RBX2hIzbBSDBVFzJqu9qAMZJSvt908FqpT4SsNPOG6WdVX4P364JpsNB1ljFWUnK9e2ZF6nJbH0VSp/P/pF5UtSpmBrzSk2Cgrt3BdWij4M634HJgX5kqIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976614; c=relaxed/simple;
	bh=rDpUPGFxBHmq4htSNxMAokqO6X8+Lxgv33EgXT+j2ek=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=mwigkDfiDR4Qnl2WpkxcW2+Nf8UdyHR5EPUqOw4plWh49ISl6DuZsty494wx5RjJTPdch3eIEAcqxiyXcvnfhSkoGGB+L3lVn8wazrfK6/iphn31JXtNyi2WdZL7dKUnXYDONx9ys1Ufc3YTANXLeUVN/har3pdTE94An1xwAT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JmR2gsMn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jy9ZNifN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBaNq022104;
	Wed, 19 Feb 2025 14:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jb3+tfzIJC9e5ubF5r
	omUbkABz3lxlMYFj92U4/ROl0=; b=JmR2gsMn/qIQPtgSayfNGsXAOCgKDxIVYi
	GDciAArz3ox+ZjaCeg208YIMJ2VR/kydhNE3z8LX3pWPq883CUE707j9RmxxZqnS
	Ult/x4WiuTbt7E9wnlTNo4U251ZPhzz/0R2sT37RTgaNxzJY2DKyWchhuFn/YmAH
	s47AvT1IqesihI+OekTzF5K9VMQcw3YXxLvzBVpqibDcdQGeH78VlCnxkbOjkdXl
	3kPYv0tcQu2CvbochEG20nkV0Zy3bRNo31uFgwovVVlSxkmnmLtB1SBwC0Ri0Nyz
	lMl6/ylYexHcrmO6pb6WTazd4hrGEWNRkdk02bMamjmXq4aV+uPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n1t45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:49:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEi082010612;
	Wed, 19 Feb 2025 14:49:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07dkq9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpBjITBVi5/Fbg62RPKqEso/+ZXYndmiYFsTuRdolKTdwnt6/Meld2bq9/Yts/dPWlW2eVl4JdsSSaWVm60fJF3uSODoX2aGbHMGHdc7PP98HasuKaoeWhmpK850YGLF8nvHCes9D6IeaYoUcygcFfGBBhANTiQ09NfTXSp9a1W7hX8Pm3bhocjNIcr9e3b7DK+iRho7DM1C7uvIYplOg9cFjTivJdJKUInd6HsDL/G7f5ELwVGKvHprfqw/KHaXMU1s1/X/cNAHVzMk2MgaDjUO3ZAHunSQU08MxyiS1oaw+KksSblhqf6Wub9O2qkPFoVvNKdhx+73MxfFzEGN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb3+tfzIJC9e5ubF5romUbkABz3lxlMYFj92U4/ROl0=;
 b=dP15XGTGFfVYEzHay/YMO40jWd1J1OJUSW56flMS1ty0yAmL7Tv/IPsePdbJojfMATRcYPS0sWcZNXJ21tOMFbzQid1JPx1sDB6fYnXlie0G4/DkrngC/5CU9phrpJMH0Ab3qgQQaZL/6UC82CqRsuyw8G2Hdq8z3ZH6aRAjfYmI8HrEPbp/1s7Jy/A4yrJXyScENtkWW+lb3zb304h9Tj0BRExD2a57tgdSD7WOUlH5MxJmwJT4+Kw609ZC6lNYSQDMMUh5xohE/GMQz+pmuTw37z3OTdGIwCEIW2kD92eYqbweRtgNJ/UxQbofipT7LLbMAlRhm4ewwnQuXpKX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb3+tfzIJC9e5ubF5romUbkABz3lxlMYFj92U4/ROl0=;
 b=jy9ZNifNOyXh6oTWFBRLqzbwZOzBiPDgt6fhSWRfxlmmgCzqrMYl5VO6tNitLqRb70xSEXx5wfgm/pHjyUXyiuc65rg3/jIfIH/47A/mvmmJBYJbyr/zLx2R+y9lXeN63DM6Lnp3mwbZ/3Rez0dNVaXd76kC3071Dj3Pys/xySo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN7PR10MB6500.namprd10.prod.outlook.com (2603:10b6:806:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Wed, 19 Feb
 2025 14:49:39 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:49:39 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Shawn Lin
 <shawn.lin@rock-chips.com>,
        "James E . J . Bottomley"
 <james.bottomley@hansenpartnership.com>,
        Rob Herring
 <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        "Rafael
 J . Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        YiFeng Zhao <zyf@rock-chips.com>, Liang
 Chen <cl@rock-chips.com>,
        linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <CAPDyKFqMJRXRYymhijyWD-e=ScvEc_qbAmJBi--WsJd+zkQu6A@mail.gmail.com>
	(Ulf Hansson's message of "Wed, 19 Feb 2025 12:57:04 +0100")
Organization: Oracle Corporation
Message-ID: <yq1h64qm1o9.fsf@ca-mkp.ca.oracle.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
	<CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com>
	<yq14j0y25hd.fsf@ca-mkp.ca.oracle.com>
	<CAPDyKFqsiBaSV--a_SvJ1n0733XXjSoONztf0e=jsGTZhKxQJw@mail.gmail.com>
	<CAPDyKFqMJRXRYymhijyWD-e=ScvEc_qbAmJBi--WsJd+zkQu6A@mail.gmail.com>
Date: Wed, 19 Feb 2025 09:49:36 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN7PR10MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ac255f-4a90-481b-14f7-08dd50f4a2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ooMzg+XuifblIwEO18giJCpYZyqIpJ5o46s/IQqnWO2k7iWFHKs2ndhnPFqj?=
 =?us-ascii?Q?sEvOJFDvYaAzyc+BT2InStFDAXplnBrS6e/uetCbjlrPIas/RbyCTxZnq7eg?=
 =?us-ascii?Q?Su9gt3LVUTfAaiuuBi1J0X3RJwgkwKWgamAVj4sjJPKMQ0PEy6W9MfSmF4Gj?=
 =?us-ascii?Q?S9l4rpC5GpH8Pa7lyb1Pcz7Ezte9dOtoV2eHjkCAtiGsWA3uomNHuD25SpoB?=
 =?us-ascii?Q?gpIdaAUCuCM3xnDT35xUGY0xOpPDNEo8jbvBheBNYLI1JbSMGlzcBaFqrVHu?=
 =?us-ascii?Q?lVg9FrS0LLipER4B0JyRTFEeL686GaG7kW/tewCAbtOKSGhv/nc1VKwhoRas?=
 =?us-ascii?Q?fSOJUOnBwPGRHXKnC2nN+4B4B4OTg704v2bHebf5iGdaXj4QI+39v8VVx2wa?=
 =?us-ascii?Q?7SJ+qcR/WMiI/6+OFhVsTWE9My7cZxtFKZFl0LEpAWcIZILRrmOGscK4dHsc?=
 =?us-ascii?Q?ctps/eEvUJdf+rPk/wU4hBgfRacGrXacNw5V59yYQviilmWnfQdLBjsBDB/f?=
 =?us-ascii?Q?6bSt3z7Ci8BszHQNNzicrLxtNtbxN4OyYz8d2EcXrlfE0hvCnKlsQ+1Aulh6?=
 =?us-ascii?Q?nPJc5zmrqaFIyO9IIwH1kTaeU+8rpV23SEjzW3OsPQnFDsGuOYS+COsc/TSZ?=
 =?us-ascii?Q?M4sNyAWSsHRtArJbg8PfaOiA8Gw+4jjSYvIY7UZkWYf9ER3ongQ+K1e6fGsb?=
 =?us-ascii?Q?9C64g0dptlkYwKjAXN9R7XwjsDxWQ2ro7uIRzj9YbORZJrxFU8trYfhZ6X9Q?=
 =?us-ascii?Q?RKd/tv6fF43Zczewsoc4mO7G2z9cKBsVKKgGVTCk3COErPt3g7rUd5p674Og?=
 =?us-ascii?Q?lGIu/V+iZqdCW3P2U03L3cfNMNKiuSzxwmU3aid+AEMHBK/Md8lSeVapfDjr?=
 =?us-ascii?Q?8gd+Rax8jBTr5bRXkC7BcnSCpjDm8ed95qb/xu9hmdfOxLDnOMUUo5FCf/Vn?=
 =?us-ascii?Q?N8NmEZNI6KICTtDlMprU5n8v+pS1WqWQYN3gAYEAilRkvVkaoAGvLSBaF1Ct?=
 =?us-ascii?Q?AzAHU/A1oFffTGOWZ61CImz/PAwtwRXG8oB3Warz5S814+fmcogmZutHX43P?=
 =?us-ascii?Q?Cl0D59zWwHMhMDEoi3j9qvpUtwg1ksXpUp9w2Y12Vb/uYXCa74aRrM4SXjPc?=
 =?us-ascii?Q?mqhJ9Qs+TB+Uh5PNelTSGE7SAUgU8QWTEkOqtppQ95C1RBddjvfk10kXfsss?=
 =?us-ascii?Q?/IdOHxvnXyLlmdS8XLPUk+Qfxo8RMH7QDFh3BLmRtzJa5zu13kk28BP6TT0G?=
 =?us-ascii?Q?16zJJfsavBZZVvuTKdv/b2mj3jdI8duf9HiUZIpuWew3AYwQaGM19f0J+cNj?=
 =?us-ascii?Q?Sw5dkFTfRE98qmwBZSzsnzk2wCEbykDNCzF9yV6cwpmQWi2C9GMyZScVP3GD?=
 =?us-ascii?Q?AiZx9A4AiKBI0TbGe2jqfN0eYEZ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXJArzEfDl0elIEgh8VQaVs4vLt5hIiy6jFoK9WqObrYHtNlGYsQ7CXQFSR1?=
 =?us-ascii?Q?i/cwrtlRYIwhJU6n818CbdYgJV0uOWdDgfs9meMaZquZHYtR2wo9xk3202lT?=
 =?us-ascii?Q?l5jrTYd3dfhBOFoV6LUEnLXIK/A3hekOjvKyEL4JZpViClPU6PoWrD9n02ZU?=
 =?us-ascii?Q?oBgwyWbj4dS1QeaH+wPPAJSdY+qlRArfQNb81aX5jczBjWfNpP6GgyRI5Yze?=
 =?us-ascii?Q?GMr/s9xpDiOj9tOP66AMoJxI3A6RAZ52PPrBLurfkklA/kKmhYnB4F1iMlpf?=
 =?us-ascii?Q?sp4IyueDKJbK1DQR4yInw+Dp/RFQT2/AcDkqXEwFNtUck90QVVx2JgFzBjDS?=
 =?us-ascii?Q?e1A8oSWHAIFR0vilMBPaH0Cds6gAO/7dcRRSZflgOS0ijWNd9s06dA6nvztp?=
 =?us-ascii?Q?fWTkUCKQsqyDUB0co1iEJgNod9sr9KYeiS74DFjdMP8kcmFvJvavHpL7z+Rq?=
 =?us-ascii?Q?tzJT6Il36Gej1hQKAj9l9xVn9bpDTKOjSFRUm7sX8K1ES4/DAa8adfQrVxQv?=
 =?us-ascii?Q?MIgnx6Xu2tCvihYClqUH9NWHGFUulSqSldDkPVLLcs7sNrVkMlXfZgrfSqpe?=
 =?us-ascii?Q?hEzZAOMQPYzrbfw44EnlVU2FjUyMUKdm5mXUEzLcrm0b2Db7MsjHa78/Byxi?=
 =?us-ascii?Q?0Xz1lwjsM+G6qXphw4nYDID6zQamdSuqsTRp7vxP46kX7uG3v3AX/B9Fks+z?=
 =?us-ascii?Q?NFCahX6Dxgq7aglZg7tGKHr9Va+kjthVLIj98yPTixDkSot4HQ5WUoqbrnIw?=
 =?us-ascii?Q?jltcVPjL06mwj6iMAYAVS5NnxgE4LpoNrVKRzZ0knPvLhd8pUTZRcnUllQp7?=
 =?us-ascii?Q?OfGMruDVHBVEFs/NIi4BssQwIZhwoYCegAwwc4XBWmomcUmUQ1NBsYZlEitH?=
 =?us-ascii?Q?d+o5VtdKGsAmEaOz7xi7oIdocC0cczudQW2vcFXOPCpjQF7A5MlaMHi4PhNt?=
 =?us-ascii?Q?fpRmjcozalDimg+/KTPibHM6MkM+ni4Kmq7MLsXIsye6ZYzlG9dAGf03af/3?=
 =?us-ascii?Q?diDEtS0tIKlDHx73mNH2k/vcCSlMBNbjgwtmsiLvGfT3g3MI4Bq7W3tNRsd8?=
 =?us-ascii?Q?dQY8bKmY5ecINIx3k7aY5iAY57UvxogXfgc8Hxa1ZDueoKM7m9nQYQM0yHoM?=
 =?us-ascii?Q?bcNTS9U4UwVAbMFA5jI8oniFHJiphuq2FNuHoDocMdtVXfFjDNGuU5jTCugS?=
 =?us-ascii?Q?Cs55qNuoVGc6O6o6G2BqesIXJbClP7hGvVwI2MEEJyGSU4scs1zBX4kawzt7?=
 =?us-ascii?Q?WYA8UO5RC8K1A7cf9vwXiIFC4NfMjJkFnwNgtgK31SyRLOxGmVTURiLvk5Uj?=
 =?us-ascii?Q?qXwokMfLcWtZqoJjytlquBKzfm/uVf6xMFYrPa4SUH1LX7e3KOzWIPMDh+YO?=
 =?us-ascii?Q?iv57O0vdJRhuyot2hiXy6aJ7kJq7FH82cu7e5MVKjKZMTlL3/BP1gGTTkcuZ?=
 =?us-ascii?Q?WQIuLSteM3Fh1mtC7vWgH1p+Jcus41jlVL34BLQSol22hRKzhFzgDAUIuOiB?=
 =?us-ascii?Q?NSNgW6Mr4ujcyjInsij798uhErNPtP5qntRb5I9Mn/an6wz3ZgDs208pyvgB?=
 =?us-ascii?Q?wi8fpirxoWd5O5t6786z+5wIMmhDtvf/gg05BCPQVZfnjCKmbSK0VH4ztn+w?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qZvRQ6wA+e2CnSyIK13tG1zGjNEVuzj7wNu7Km7FiDKJXzExhyQ9EuU79XvOzwhfFtgDnE5cGS8cKdg5bkVChG6ePQ6p9QjpNcN0Ve+zyKthCzljE+qHKdDOUJxu7O8qsC6np3AgDCalnp3QSvFNP/ANvZaHFSYOKiEy4DKN60rcw1Ec8YgLZuZ6nIrQVtXpvzkVyaDDG/CkHzQrsgyLMxi+lw72YFJXsNv1hSh/wBl+GbovUVVKtNQpmihUUodrPlAAjrd9YssLeusvMhIIUJonqvVJfKBLuIYsq+BQY7GGJ3sJbbljWis5zoHfKf2NP00uEmHJ72TcEMi/MiTtmtnxu9YQI39jNhVxYQ16Z1VD111nKCp2S3sgNMA9Nz4BC+g/YUoF5YQqRH4T8Zcgdhs7cCTxeutw0XH5DGAxqa2RQSVIQ6jA1VkyJ7NDvPZV6vR8E8KzfGlkFK8ht2qc2sgwFavuH8EJbWeYanNOcC699hnrZybwh3Olkl1eE3zn8uXTQ8IKjB986hlhYi0WndeM+jcQiskIR/S1g1xhwtPAANcRKOPeK6Hd7hfTsvUy1us1zMqDSuCBVK6db9KmYC2o1WVXfrfoRZCUasWLX6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ac255f-4a90-481b-14f7-08dd50f4a2c2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:39.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XQWsGOJxkg5oL1bC4e0bYXs1qKAhmBzcT5eVwpTQnbXvbvTwoj4q9xwpq6wfOKg69c/uX+TtY87btV0/aGRkZpJ+D6UOeUkmMPVR8N4ToM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190117
X-Proofpoint-ORIG-GUID: 6qdeIpLG-5M0JCvtgGRpTCoGLviIWbTZ
X-Proofpoint-GUID: 6qdeIpLG-5M0JCvtgGRpTCoGLviIWbTZ


Ulf,

> We got a report about an issue in the branch above a couple of days
> ago. The problem has been fixed and I have just published it to the
> branch above.
>
> If you already pulled-in the branch to your tree, please pull again to
> get the fix too.

I already pulled and have this sitting in a dedicated rockchip branch.
However, I ran into several build errors in ufs-rockchip.c with gcc 14.
So I haven't actually put any of this in my main tree yet.

I will rebase on top of the new branch. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

