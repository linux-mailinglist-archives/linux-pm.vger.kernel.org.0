Return-Path: <linux-pm+bounces-42318-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNzSKu9HiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42318-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:35:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682310B2AA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E22230364C7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA353033D2;
	Mon,  9 Feb 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DhXhR1rB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YVUi/c9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039B2C0F8E;
	Mon,  9 Feb 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604376; cv=fail; b=gwkfSazzS1NKgZmdWMq8zogVvl7QZ8WNKsm1MxzERnuwxH0UtI+5i09bSofpqft5GMX4FCxWflip/xgjfl7XbyMOVhDPLof00HPrfURgECTfPOeKZOwUz15lv9SR6spdFmf7G0+isD2NvuQp4jxnBnuT2vpqpLcs0rO4NFd4Ks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604376; c=relaxed/simple;
	bh=TNAAObdjMCFPh6yReYoInFOlnbkX7tIE47BwA9BpOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQPxs9V4PKHeXkmgfvge05RRBwAMIZfdfxrPXtHumkS/loWBqd+uTtTG87+C/TvRWkiW542Q5LIqwfclfjvAfabEYW9tiIXBW4s9gkJUtu8ZXWLBXC7NpfqpPDuI/bRE0cxTbLWY0lD0qvjrl63PIyslEgqmrILZdijQ+uOh9Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DhXhR1rB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YVUi/c9E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Necup136611;
	Mon, 9 Feb 2026 02:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=; b=
	DhXhR1rBFevf5715XkaEMGaoQ56ECHGhtBUuuoMnzpvoI4oVx68WfXV0Xbw/HXKk
	+YynlsLjWNSUJvEPlee5jDOmG0H7JMud9+ORYfwqiahoi6OSK4wMgJy3qi3q+ecb
	dLXVOVsU3yX4ks/3AtPCCf+qNGFHR4F4/pPqzZHQ8xeld6F1Y3kW2CD5Z4uNOpgW
	abOCF0Oher7KQRRxq7zAaOwNNnjFqszFItNu0hvK4ctVcRE8Rbm5GwTZSUAd/NOs
	DmADuL9ufrmUpS4fSjo1HYvDCiZ0ZRLuNdnoXhe+UerBMrmJl7Vdj+F9yfSJx9yH
	3rKHFY1O6l5ij7a7U57Qsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu99mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618KWJlK031967;
	Mon, 9 Feb 2026 02:32:20 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g8bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbH5TLHmA7aLKqSZW7T92M9YC4bd967L1e1bvXqxrpz0PN/xEU1Yn93aC+h28JI7zw9d1yxoAtL3jNgclgETJOq6ScZnZVxbMFGs6T2Q8rKELhCjCKj/SdPbETTPdr8mwm7ipXc5QsYASMAhrYuOQ2kHyhCnLqdbls953KTkP7AckQnrRJf00XzbmlvNkTnBB/zrgkYZWGcE38LDLoSUUpc4rmzEdWZHtdZYw7pQuls+hQLjWkWUiq5LzF5IuNynrbs3vpPqY7GsSLetv8GwJH+n7RB0OpNyiehA5TtjGpmkk0kS0UywCODK89reol4gp86kYpidYxAWOFPmsSHUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=;
 b=VM7Hk5pn2R0MxM6yCpZ3mf5w8siyXVoK0zbFaMsBLeQoDBZDLRaWGen7tUMGlfaBEIh11TeAcKdiyV9N0IehUl80ZRYqgnOfyefRgRfOgwapdOv7DsyDQj067q9PJgfVvJroPLPs0zN/ubMF0fL4utTGjXAUJo/Mz4ExE+RLLWkD5cgA/SunBwuBlPoQntKN2gN37swTmJ61wXF2923cpw/KDf3YGpNEdVUiYiuRx66ljWM50mz+hvukBUTrknpm88WtjEWV1tiCK/Ycg/7+4sCwT+hdf2tjgKKWF4RpJgEsKoNRB12pt4po02hrD49sC9vAd/7BIFSEBFmFYUc3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=;
 b=YVUi/c9EkQW0v4iTR4kXo5N0fteOFHmt2Oc7zVwVuDImj2M0i3NK+7oR1wL1FQYdFgi7bDgpmhhPGd6MgTz5ZchQkmXrqrw3AHYiIuTV4deVo1xc7T+DkwaqQLSi4wVF/8pLtRwAv38cFmN9RIzI4BrL7cLi35vxTITYw8ti/B4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:32:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v9 09/12] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Sun,  8 Feb 2026 18:31:50 -0800
Message-Id: <20260209023153.2661784-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 024dd8f8-3e95-42b1-8838-08de6783714e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S5av1VIc8xjawCdmEHib2quhcqUIZvxYMlvMJUMzZZ3P8kFxYMXnaegAqjyo?=
 =?us-ascii?Q?WN0z9oRLKsre1UG/mTTgle/Sn5phpatGX7bjKZna90m3uKSFQK3E9y9AmRcC?=
 =?us-ascii?Q?BLmEaRggfR8faVue27y24sAzPiLmI5leKUDFiMfGexYMYvYMJd54kJasxpNo?=
 =?us-ascii?Q?lAAGBUO6IlzVz1tH7oDqaQyLZKT07ApEFK/K2O2w1nPJ6EUhHoaUadd3Mqaq?=
 =?us-ascii?Q?7HThRdyUuY+NIUSNKxNWEWiyahFQy4Ei21eXS4JYnv/iJe/Z1IQXAVauhi3I?=
 =?us-ascii?Q?rd2l9Aj8qfaF0ODrrXsHYNrq7qYulR0F/6U+a61cqSdyZ5Q1coOOWh3lH21p?=
 =?us-ascii?Q?ms8Njb27fhSkDVruiBShQXEsr5PKyCqWW0KQsuayB0i+tuCaoN0I5+Hhe8/L?=
 =?us-ascii?Q?J2dC4NGAlirUceAIsRpop5Gyqyk+3oK7B9njfflyA2ZbjrjxPlQ+Bg8o3ETR?=
 =?us-ascii?Q?+Msxejt1gBYwDYSf/PXTrPl4od5mM9/5hdbUy7tYmWX2P/5OJDnKTqXHHkQx?=
 =?us-ascii?Q?hqAd9Gyie3LLxTm1uZKf5oSs22+j5bTAAPCTGLMtJTAM91+YQmiTUFjEarJH?=
 =?us-ascii?Q?1g/lhouKpE/pF9EN2dMhYliugg4Fitl3WZ+zAUpJ2gfDnyzoPDCiJQ6R28K8?=
 =?us-ascii?Q?rFe2RE6EPAqfjc7NBe/adPZVkC0xtrw9/ocIo/thoBnv4M0PwBlV6TzsekWN?=
 =?us-ascii?Q?Qw6totX3QTldevtCfga2rf+p7ePJfGD4ejGPqoYecaI6IgRZt7NoKELSxQt/?=
 =?us-ascii?Q?VXTZdIzHzvcKshcsA1oa9znOQEpIXujem7MyaRFN+EhbtxBd0ZZNmmaWNa1w?=
 =?us-ascii?Q?OVrWV2iOm1L+PM4Q5xTwIInckOIQpI7tBJR7olkYwXUFlYjYoD+2iGX1S8AO?=
 =?us-ascii?Q?cPZSHD6TdSFMRljiA3IVry8uMbi+zi8gIJHBQUUSN+p+Tv1AzOmrtvl5LLWi?=
 =?us-ascii?Q?2sj7+CGeD8rdXObD+vBfPKT6t/Ie2KSqhCE+uxvmpe+GlzX2jmUHkIG8Z8tX?=
 =?us-ascii?Q?ejnDRNhG+nXA3ENsU8gqIu0P443JVEl6PmE7jtYpfbfxmdJxyKSXaTlMf8fu?=
 =?us-ascii?Q?xCM3hT2xHpgYEumdm2wz+A9m7EM8YjY2FpBuFsoMZzBp8W50EXBy112noo5y?=
 =?us-ascii?Q?4AchXF0y63gyDYmbwVquY9bQT2tnsMbjaA3FinLNlJPpoOn3ePtqA81FgGBj?=
 =?us-ascii?Q?ryQTp1DcfYZRUhLxDrJvGzPLTutjCfw3Kouhu5g3HHwTDJ8crnDP5rLJjwwx?=
 =?us-ascii?Q?+OA+qKAEzJ0KO6E58FnsZwP2qsntwignb5B4TK9uvRT29oLVxpnq6kYqEqai?=
 =?us-ascii?Q?QuxNs7QtrQQaTJ07/PYtCTVoKdzLEGM0KcVRjisaAgrQQWsDEy8d5IYyHaVG?=
 =?us-ascii?Q?SZQNupbxgvgZCWc4ZopBQobcA03dwXycLvCdOqCKkS5yuldw9KDS1rgfJhpP?=
 =?us-ascii?Q?x3E86BF2tsaViLndck4J2KK2tAFNA4QJ7zdoND6JMSohtXSUOqrWG5ofNgwx?=
 =?us-ascii?Q?7kQJDxX/mqfDzUDXAGpdxoNxuwJaZTgpH2zM8S7ouzeMt8BKvwJEUEwuAEym?=
 =?us-ascii?Q?9n6o1tE2D4IkcnWvIvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoLzlIw0rN6dqEuKdaoHLNb3j3G0e+7SUISDmxWAWfZr/7JOmWyZkQjqc41o?=
 =?us-ascii?Q?B15u8bf8aexhwGf6U7iyubv2npZQKrTjd1y8rZpDMAqlefktDE1vck4CcONM?=
 =?us-ascii?Q?p9aCeTYrk2aKA9tlOG7o9ORBJZDrFKLxwc59yJr77kyhsQCMsfZKLHS070+O?=
 =?us-ascii?Q?YukZt5HLpNOG9IJXxoU6rL5g9Dd70J7yq0R2Qs5UJFbR4IdalfcP4D5afXaB?=
 =?us-ascii?Q?lMor9IACm6ELyqzMHrZqDtDCqhdxeEI3Z/5Qa+Nf+x6WRNNr4X9+hrS6QtkA?=
 =?us-ascii?Q?cSOJE8SPRloGo5eiTnzutbawXGbcPr9YbCF249Ft0yTKpcJ7AvcW2RTWioDq?=
 =?us-ascii?Q?etDurSf3QcP9l9fvs9ZnAj+009+1hFzfFh8hlPbOEqo2PNrRVf7G+5olbMsV?=
 =?us-ascii?Q?+KNejSXwig35zcdN3LZoI3qRKHvNqiIo0GkVyPD7YCQqT0YVS7UwRHzCsocL?=
 =?us-ascii?Q?VIL3kH1skyjdPaSwYrup87AEtDv4DVUyztFRST4ie+FWTFnNB5e2XGfKlPFS?=
 =?us-ascii?Q?dOBLG49m0cLCvFw8MYqHHfapEhd6NDVKss3KFh08owDC5KkmtIW7YRQSJymM?=
 =?us-ascii?Q?uZorMW+XuUCRCz1XtzmtWhFAmPjhUoFDcF2/HT6wGB7MEirRv8V7pyjJ5yAM?=
 =?us-ascii?Q?myQrO6RZJ/4P9mIPuW/QBVVLdEkeyj0khM+7jjyw8deMAhJDWs85cqXFpOwr?=
 =?us-ascii?Q?AwqzK/XEOEJsmyvMTTAMxemZ90uZOR0sl7wIiLtDNHGXey/FEPBSdi1LGNzG?=
 =?us-ascii?Q?M7wNcWbLE/FBG1qDXC8nX3W4gulykIHhiM91fKpNHOAnIlL6h6uGyHT7g1lG?=
 =?us-ascii?Q?PSIOHwgpfeF/WCLIn+LPgq8CIb2pk+172odv21n0wte96mN8Yw0kU9QRMVtG?=
 =?us-ascii?Q?3f5VCtcJyl5sctY6rdCdRCWJPMBT4bb2xv3Ji5/mX2vZMDiO94GGwkkl0J7h?=
 =?us-ascii?Q?9lxxwtvme1pBZG1mtoCPWY7AuFs3HtqnCR6qSdRMxy4L8LPzzJNPl2xR/fzp?=
 =?us-ascii?Q?5qFiFQqo4buTnlfBDEiCrKf/Af9n866giwU1bL4d0DWadH9f6RRtZRUMY8y9?=
 =?us-ascii?Q?mA+jGz0/HDxt6LQYMfJqQ7vcIa7UWh4IIwNLBROUIS1V7NInW47QM2H4BYgL?=
 =?us-ascii?Q?KrzQ+nFAh7GFqh1CKBLhZ5lpADjZl/TvSDh1ccRoDjBK137Omh1eK1i0cG71?=
 =?us-ascii?Q?3Tt3DLYt5Yz7r/29Qfi9joUEevCgMDx15+WodCfcOPohYfcHXa+UlakVnkNZ?=
 =?us-ascii?Q?it0bRNCBQJ7pFCOytK8gMTJWxxKZ1yRKJGPGzwDKY2MiBkAC3IHSvDPJUblm?=
 =?us-ascii?Q?/qzaICMicEfg9Qk90m9nrKRJDmoOxIpDnFA2feYGhe4CzobvDIm8MLLybcyw?=
 =?us-ascii?Q?SZKBJd9o3fhT5344ymhCNsNeLRLVf3CeutThKqHWUa/BIpbdxhqsdW1Z2DhV?=
 =?us-ascii?Q?+wCWxkj8hOl/B23hbwelNIFW8ES/EoOiINZejIpouCUa8A0Z3dJKH5834cqM?=
 =?us-ascii?Q?O4XGpZ02X4G7dhclWFn6q4dvXBchcjNO5r+4VQ/pr6hrgPnRnzpd7aPXVG+r?=
 =?us-ascii?Q?cKFO5t2n9cKC3cH23y0yNYUxueYO5PJBiCQqk3vgHgXUdYJjUVGzDZS1YDU/?=
 =?us-ascii?Q?k1cw+4gRgt9OsMpzgrOop4Rb3hywzqHEHmnDxR58uDH5QwyTfIQBUpJs72ca?=
 =?us-ascii?Q?4hVY/5nV72wPO7xtdtBvKVUG0Rju3sqHamWlF8ctP9tEkNr70Gp3mjYLFLmk?=
 =?us-ascii?Q?lE832DyMLbTFfORuyN8LpJD5R6Kemwk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ljYrT0IuWJPt38kBbK3R7RVdEpYyRvjrmP/2QrDZTrbCznVIlzlUmJNHBwclZfh5QjhnkWYqThwepN7IIOZ4IGfMUqyXZTsNqMOiGpWYylX4k/9dzoLFFZJ4FpfQuMhJfJNFUhXvFOMl305oVS6Kfzr75RW9lNGfRbWhNsYi9OtjpNMi2wpF64L3q9gIZgQZln8a2czUsbvuC+ORZGwa5Kv85eRDflzI5mVIKgExjKO9su95vI644Nj6ZrTLku7fzE5r7Kn1ddOFLRJO5S41VUXjf4/UYc7zgkgYdA9bnbtch3LFJi24T9IjAnSUQhcrA5/gS/xEMJge9ATbYZ9y5jiA2Skv6BGu7VtJsFc6qPndElHI5fdsLOTD+tIZ4GimjkERLSlGMV29sJVMWlGpe9wJY5bOXUu3f4qkCWDx9icePIYvp2jVKZ20WtJOwklX2Uu7l/gAneM7981yJ8VjmQ6HRNg3WfwKpyE6kYjKKU+Vi84oHUyaax0WNOHkiopUMx4VAYKsPFvlL3ehs7lmiTatOi6TuWMgzJGTz5tLOEGbaFgl1Zb3IiX4YNl37k6aS7dbHZas2J4oWkUpzWqvpFn+NDinEqYeemgscfzNzzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024dd8f8-3e95-42b1-8838-08de6783714e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:17.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqhqaRWJR0TkC+Hg7+zCMolNQZN0Ux/vOvleXa7XrtG/2nS9Rwa7vB6BOlEOZJAiddVIs9uScYKZJi/x1rRhiCjhsSVwHKEZrexrln+5umU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Proofpoint-GUID: bNpwPTwvDih9IiTWD0hKhUJQTu3EbJTR
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=69894735 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=mCH88hr4Ii9tCPgkyJUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX2FCkTOIdMnLn
 t7ImlR/VBI4tNtHCpIFRe8LgdP//HEceJLYyK4c6J+D7KZK+NgCpo3yyfJVHkU/XwHzxbFNYvrd
 V5D3Hla7iaF4WQ1RMGUrczb31s+kcrNiKq/CAZkRMO1jexxbVwulpG9kPsRcRzJRvPzbb1nPKAi
 /cDcfJz4rDc0BypTouwiazCw28Se4BsFauT8CAa07crOftEuQVFB298J+4mpd5YxZs0Siuny2lP
 Vls0h/bOOiDnlf2MDc3wBzyNkliJjzF7/IHYd0yfzqPFC9FxDVDjBXth96+eLZeDCLdoJVoJaWw
 4DjzlZm8yWMeYSp2A4fkt3/KhGjB3t0cQ84v2YIu+BRiz1urnvwxp71EAQJEESVfuUQwmoPyU2m
 2QP96aT/bVsmWBRlSFCtKN+Tfc8wCFAU1pLECIqaIYht8ATnqXYX8On/jjPXkTPfkOEnECTMkIC
 cA49EVwzQnm1ZcKt4VA==
X-Proofpoint-ORIG-GUID: bNpwPTwvDih9IiTWD0hKhUJQTu3EbJTR
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42318-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2682310B2AA
X-Rspamd-Action: no action

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index f7d0c8d4644e..ac9b3572e42f 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -234,12 +242,12 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
+			(ret) = clock_deadlock((lock), (mask), &(ts));\
 		(ret);                                                \
 	})
 #else
 #define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+	({ (ret) = clock_deadlock((lock), (mask), &(ts)); })
 #endif
 
 /*
@@ -261,7 +269,8 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 {
 	struct rqspinlock_timeout ts;
-	int val, ret = 0;
+	s64 ret = 0;
+	int val;
 
 	RES_INIT_TIMEOUT(ts);
 	/*
@@ -280,7 +289,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -339,6 +348,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	s64 timeout_err = 0;
 	int idx, ret = 0;
 	u32 old, tail;
 
@@ -405,10 +415,10 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
 	}
 
-	if (ret) {
+	if (timeout_err < 0) {
 		/*
 		 * We waited for the locked bit to go back to 0, as the pending
 		 * waiter, but timed out. We need to clear the pending bit since
@@ -420,6 +430,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		 */
 		clear_pending(lock);
 		lockevent_inc(rqspinlock_lock_timeout);
+		ret = timeout_err;
 		goto err_release_entry;
 	}
 
@@ -567,18 +578,19 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
-	if (ret == -EDEADLK) {
+	if (timeout_err == -EDEADLK) {
 		if (!next)
 			next = smp_cond_load_relaxed(&node->next, (VAL));
 		arch_mcs_spin_unlock_contended(&next->locked);
+		ret = timeout_err;
 		goto err_release_node;
 	}
 
 waitq_timeout:
-	if (ret) {
+	if (timeout_err < 0) {
 		/*
 		 * If the tail is still pointing to us, then we are the final waiter,
 		 * and are responsible for resetting the tail back to 0. Otherwise, if
@@ -608,6 +620,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
 		}
 		lockevent_inc(rqspinlock_lock_timeout);
+		ret = timeout_err;
 		goto err_release_node;
 	}
 
-- 
2.31.1


