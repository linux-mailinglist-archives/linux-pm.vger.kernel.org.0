Return-Path: <linux-pm+bounces-20289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969CA0AE91
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 05:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247A418863E2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C2192B66;
	Mon, 13 Jan 2025 04:57:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E4170A0A;
	Mon, 13 Jan 2025 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736744229; cv=fail; b=g1fkjtIABojgaBEqbexB7vkcfHBsL0A1lkffbsF72UB8ahWzdSlMgEjU638i4ByAMX61ddbgqy2JXQl1/uVYf3p1syJyj7jaZKvs/pDBfrFGK9AdHWWRHXOPOei6JZzkxeHF3qxSVHB6o8NkgDsmzdFcaiZ1B2byHqjKUPzoiRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736744229; c=relaxed/simple;
	bh=OyeKQIO66bW4KqlrHWHwH70KWpHGGN65u1l3SaWQ4Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=umrIZ0WD6QP5o2S5nPtEQv+GIpRvngtcEXcrGgKWFHHfUTPZuJ967BIvkWVV7lYLW1yRSWpWY/GHE1oGCiEwfWoyfFkW6Oaf7RZvhbN/sfijrmblslbCG6JgOXXsWDt4qTG9cF9rcoJoMYe84U4IiJ171WT2uMrG12pGDJqVXA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D4LAig028166;
	Mon, 13 Jan 2025 04:56:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443fm89dur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 04:56:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmvMggIGiy2GoJC2Ga9V28j2B9gVkj34OIMMFSohiIVapwWXFwuVwW4luswaljChblOfqPVNPPqAUfpJHMwLio0wZ7vcRiy3qVXTLITvreu9/IT5gPMPalEa4ajtTwKsdGJvFnceRqUtqFQDWvFU1GR/e2r4U95HQQM08NxU+XsGDEUCIvzg88DYHc1fBSr5fiCnJ/Td6HJTllcaV6TKd3LjGPlXa7nlmGH5mz0AaRgsU6eqEYdlIpR9FCUcAmpFup8c9C0fgacIKbCct7zXHY+D+QEgBxI0ohnbJr5UUNBbyAt61LRanWbjqj0aW1tzrsKMu3OZ55B8tKSR5jZeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vSZo2jVKKsDcMPF8iLmfJFQmPhpEEow8JUmKSxbYys=;
 b=nMownMHA6BDzDno2RJwVrJrUZIUFEYkn+BFKZS6cFVGRTt6n2qoFX4hLHrO0oLtYQlExTsXrqK41hAHxgxS0YgOBxX8koQM6rJTnTDGcp5XuNDVoQMzj/WOgk2J72HNm0gHA0kv4mHbTJH7htjF1/EvqTr/Patyer9JBdVbWuo1wsvRisX9gdWKTQ9ZuWzXUgEw9oV3onKb6DZSIyaeriQ44TtqxdFGL7nmeQHUB5UvHLv9cR7AmqGzJtY12BAzeHPgUmKai2Hb1h6sbuMTQ/30U4baaspaa16wDaJLQ3L1uFtKhmaZdZ3sTYRJ0uQttL98Y6YTINrwzoAbY68XWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 04:56:28 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 04:56:28 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: l.stach@pengutronix.de, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, aford173@gmail.com, peng.fan@nxp.com, marex@denx.de,
        xiaolei.wang@windriver.com
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: imx8mp-blk-ctrl: Add a missing judgment
Date: Mon, 13 Jan 2025 12:56:09 +0800
Message-Id: <20250113045609.842243-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c085f8a-3a3e-4134-9ce7-08dd338ea3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8Dkz5Voej4GUA+tOnQsJQuAjBRKLkYk6EF00khyP00SX622QSFAnNvmBmof?=
 =?us-ascii?Q?X5pZBUPLv9XNPk7p/JjYhUBr3u2EanZ1FuOVy/OYJY/hQ4yWMCwD+Q/RcpZP?=
 =?us-ascii?Q?bLlcAiHeXw8XepdZ6Or5N67gllOq8nynE525muGJg9PsplE+emssDvRxb1n3?=
 =?us-ascii?Q?aQ2z62DXhX2Gc/aKB/idW56gjY+UQdXKvTY+u3HEGWF2RBDvMfpeJbjhIzav?=
 =?us-ascii?Q?l1sBewRMO2DiY9LAIfq0Xc31w2hxt3pGXkwJXyHavCutIJGl/bi3ZP0vqYG4?=
 =?us-ascii?Q?6DILkmiZUELu8CapBGznFreCMQ5jhJTY+C1AjndxKDkv2b19AU0orHyMEtEC?=
 =?us-ascii?Q?fRp9sqn2HWdLRONADE3Zu9NS6Kk0PZES0V254GjifKBplprY0/7FONTr6djb?=
 =?us-ascii?Q?Y4lRqPNchlmU+jkYiwZd4RyLb9e8qPoZFQwAx+Yd2xbZ/uOWr27aJVDqnJBK?=
 =?us-ascii?Q?OEagKEwip0TcdxDFhefU5Q8Sod1NPA+34ca3YwIng8rSyW4YEDR3qSWLdu5O?=
 =?us-ascii?Q?+Ln3uhdduGBJZuoTS942EQbTpoCDnH5HsFjsfTRTdInAfVSRa6HcWNNGBa1Y?=
 =?us-ascii?Q?ataeVXekK11QjFw95AQtRouDRG0eA5jvYIVBZ5lJ7b1vgj8KHZurXisjuYqQ?=
 =?us-ascii?Q?8VF4WdMe4pc4Sqt1yKBM12eEyGOlwAjrhwnr576iHYSKOhcU+k4Uib6hqWl2?=
 =?us-ascii?Q?b0RplwkQRXprO3NYP7UQpPUIKcEXdbGmBO0+ShXjOpHnobcHIaOQfhmrQ9bL?=
 =?us-ascii?Q?+vOBgWk9OjlragCHqmnJwas6gfm1q6jKFddHEy/ZVFbIjuUHk457yEAu0AXH?=
 =?us-ascii?Q?zz3mWzbueICdD2VKrq5YQG5mS4hyIE3FiJOrdMOLrNeZJ3/86rxVBuAZcoTo?=
 =?us-ascii?Q?6MwL+19RLTeFQ36IZg4B++GL3d/wMmqkC2zxwXSsv9koVF2nhhKhlsms/GBD?=
 =?us-ascii?Q?2S+MRutlV3Xg5PzwD/Qt0wl33BooOtQYMXyfK0duvMHoyOGDmPBbcbjFvLTU?=
 =?us-ascii?Q?c64/BHIXnWPh4WvG914gRV2RKiAW5RynlSvfDo3WUNUt6YIfJtvQLAfQmt+W?=
 =?us-ascii?Q?xwuN60448RKoC8IlDbHi6wUTrs/OmlcNKX3wdtsi9v7RxDU/DM7tzAkjM0Xx?=
 =?us-ascii?Q?tWF5saIrnEteEmAkEBRyKSeX+Nz98bAdGOE2rzy3L1lQXRqNc6zKDpCS8gj2?=
 =?us-ascii?Q?Y6pN//ie7wh39RcGmU4TtZL8zFLfHielir49+7eMKO6zmXmUOAnxNZzwWQVs?=
 =?us-ascii?Q?wMltpGDs7eNODUCh3Bok1tNK/jjGR5RABRqWGrUnLkqiJ4NY0XP86pLqFpE9?=
 =?us-ascii?Q?fEC5/BGorwY86krXTNdNTZsN4jJFhhdrAtrE7waZACE0ec+gRh8XwQDjM5FJ?=
 =?us-ascii?Q?ekg/eQVjYzgCptOje1jjmgrA8jQ6bunlfhMBZm9SdZDesPb2UGVpy4mA/go1?=
 =?us-ascii?Q?et5by1vORQKzsWZpB0pRiBP9Z7dGThbgcblP0VqPbGepnOJ1NomW3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPC3y5XqRnJ2d2kT1Miasz/d8U8g4MVLAKiyZiAJXo475JrB3+ay9ZFCvcY0?=
 =?us-ascii?Q?aBSbe0q/m7SVcNIJu2xDzZRyp9G7cyqL+OPF2n+MwoPd5upi878bscwvFHuR?=
 =?us-ascii?Q?F9s+9R6FvM2XwxgiI0mrEfXnZvLkRoUwyBejBYUc4PUfQOdqdnZEzPZvIOyz?=
 =?us-ascii?Q?SH7McvG6pfMw3WQOR9p5az36b2a1Hot1wI9foT6CI+rqPORLFcYzI+p2ePkO?=
 =?us-ascii?Q?Lx/8vJ07laHwzb42jRKiEG3krlhbY/EJHYgfJ681wxBBoA4+pi5FX3DSiQUz?=
 =?us-ascii?Q?mtfZcvUhmvxCFerwD4XWi9MUkMwGa8/dPSejPrted+e6SWHqL+gXFTt1Xh1i?=
 =?us-ascii?Q?LSaVUn26boOM3WuPQsSLEQZAhUUnTPyoc23VztdVVlxJ9m/Vuu+kn/pXXUsw?=
 =?us-ascii?Q?tWPCrTm3MH6olB1O4mtMo47VtAY22qJb5zrGuOX3LQem59a9VzDUBDwIgJNS?=
 =?us-ascii?Q?xSDx8NW0JOdQV+E69lSUiXBhHyzPnDnOU6mSM6BFjdwqsQYyoghY4NIjaO3I?=
 =?us-ascii?Q?rOFOIXacVct5FqTy23uEgVhjryE+1xAs/gK/h0TdZJWjy8ziOMpI1T/5aFOM?=
 =?us-ascii?Q?ZKdFYpjJbf43YBo86plq2lN7n0DvTRFL7tEuhKzmjwt4XVPNdwk3JIXcdh4g?=
 =?us-ascii?Q?0Re7Y2b3cTyLHf58D3bUu947wLfmgaB0IPZ38e9tdXaPLmZ+cnHG4L8Id9ne?=
 =?us-ascii?Q?XOeC93ZcIFMNqOy1EYmVFLZDqikYGnST4NDJs+dL1bt/h8hgmt8kiMrNnPIm?=
 =?us-ascii?Q?kCClx9enjtoslv8k2UHfEYAaOh+NaLJbj5Q24tks65TpqKN/oc22hLnhj+U5?=
 =?us-ascii?Q?1QKIZ/LUbx/3yG8cfqI0T+USgei9mcnBQMb0yHcmZLm70GmfekrhnGEkkGgx?=
 =?us-ascii?Q?unrdUkCMt7ntvURauKCE8SUh2R+MnziuXvyug06wVzTVfmYxH0MhTBBl7ffs?=
 =?us-ascii?Q?xNaRuUy+qzDemqwAb5PlYvTOJ1A0nt+PsyN4euQBcoKZr44eYNgZR2+KmziK?=
 =?us-ascii?Q?Dwge8l58U9ij5JQ/9l0nFBn4Ztc5WS5t7lGzg+PXwFri1nNR59Ef4kdjgy5T?=
 =?us-ascii?Q?uizOHkuWnYRNMGjp8xDiE0ck+TbCZJ5bKFihLL4L0kfpwt5XsS64k1VRpwNn?=
 =?us-ascii?Q?EW3V8kuKBjzyLvKDwjTokcjfwZsS+nfHw613levrhjymNF9PM/U72URTk97N?=
 =?us-ascii?Q?tmVTirpE2IODPnS9G4b5xoQ0fOewzSTcyN5ayAeooy6UG4qVo8ch6aziVdN7?=
 =?us-ascii?Q?CcEj4nSipiS2/EpI8lRgZLTxy7h83cd70Sj/qpaokw3amj/6C+PIl2jPZwtf?=
 =?us-ascii?Q?/3z9uPeJ9x61eOJHxAR2oLC9ooz7AEBkpvr8fabG81YO9DBh8arCWfVtBPOX?=
 =?us-ascii?Q?tWUxHwJDYeETi8fTwNgxW5JqeTpmWDD9blzGJ03+UvAOvNxeXKKSjIU3LumU?=
 =?us-ascii?Q?vJ4auu7qmDJVlJdFEldGhXh9pQ56Ct9dPD3X2W2nn3pXs/C6XotBeAYDEkv/?=
 =?us-ascii?Q?FEZWm3IXEmbLZR+lIAj7u4NN4H5UmewXBfA+TNlxROseDRRBUI6SZXmbIKeB?=
 =?us-ascii?Q?aNHk1EfxVAIdJgxJCY5BAvMUrV7TkdzESW6nTrEETAr1YcE5z2c50zlU+XRu?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c085f8a-3a3e-4134-9ce7-08dd338ea3cf
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:56:28.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDXIeaT9jFhByJa2BD8DYUiNmNcM4LuseIQvwfgRVv3kxaTxL/ZCV5k4Oy1UZIKC5lFmftuq4vYyIN1yoTCft7IE5iC6Z5j2V5BBgxbNfBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-Authority-Analysis: v=2.4 cv=Mtmo63ae c=1 sm=1 tr=0 ts=67849cff cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=7giN54SSlXpMncPZmE0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 9-S2nX5eRmmFMibgnX4HqeNwKHqr9aAV
X-Proofpoint-GUID: 9-S2nX5eRmmFMibgnX4HqeNwKHqr9aAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_01,2025-01-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501130039

Currently imx8mp_blk_ctrl_remove() will continue the for loop
until an out-of-bounds exception occurs.

pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dev_pm_domain_detach+0x8/0x48
lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
sp : ffffffc084f8bbf0
x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 dev_pm_domain_detach+0x8/0x48
 platform_shutdown+0x2c/0x48
 device_shutdown+0x158/0x268
 kernel_restart_prepare+0x40/0x58
 kernel_kexec+0x58/0xe8
 __do_sys_reboot+0x198/0x258
 __arm64_sys_reboot+0x2c/0x40
 invoke_syscall+0x5c/0x138
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x38/0xc8
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x198
Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3a0f64c144c..3668fe66b22c 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
-- 
2.25.1


