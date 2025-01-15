Return-Path: <linux-pm+bounces-20452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92DA116BF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 02:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7316188A0B9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E343ACB;
	Wed, 15 Jan 2025 01:42:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6435969;
	Wed, 15 Jan 2025 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905335; cv=fail; b=XDpgTIgjDxDzXeFNZJMoSDr5HssHrRXiUkhz2WoJ5XXUsssp51MXMsHfPcrQc41WUn3rZ1RExIK9zEbXKyjFwVcUqwhJDp2ynnQp0xM3/UoS5btGcJoEHlipEYWvNUGIC721O/m9kNJXwJh0O/crIMXxaKZMmJxxvxYNWSdCb+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905335; c=relaxed/simple;
	bh=4luIqsJqYwSr0sv+SmVOsUpV9TxDQK7vXR9Jr78uHUE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aPFbR3zv8p/lNY7c5U7aIlI/kzHXnO5bOnzphMhmc0QMyAsCjDJs3qqoU+eIGYKvbigMJwUWzkGEaxbDUHHQi5B+3zNrLOcGlB85Tj7JxVRFRZNa7ZbWHqCQFvwOjYg1Gb0XR9z0bETnIT2ygeVLSZQh/FgoMhhXwq1e+g6yiTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1XBG0022560;
	Wed, 15 Jan 2025 01:41:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 445yumr5uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 01:41:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbFp16qyp2VcXRb+yquuLedGygJgw9B8P3aridGForBm/jBS/jWmu4fjScplJgG10uqrLP2dtTepYdzRyomE1w5d5ctoRi7UPLxcf1cIN4Y2OO4kgtagmG7g+gAINvoRUi7cgUsZSXKRLwhNDYcjm9YyroNg1EmzYS9ELwHsweJAaP55uKsxfOgX6ixICTKXD8vsJHLk1jK6MjKUAwnA4Y+xgXi0jjNDrDGf4yj1rHSDeOCDqDZPqQV0pIjFAZNBxkPxfhPeQCn3oORhD386DKA6+C8kOO1Mdh7nYjbiA5xIouI8Nuz162BwSGaDbWOA1+4OtxTwFrxdHQqk2FC7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03WhiCNBUDeb5FzDBFvAKt+31R954/IIlI03FQ9geQw=;
 b=E+/v+gl1rtemIvrNKNxPZ1zNpVmp73mQhHUX4FN/gevunPbKu3IOQbU40Bn1UEpVjCKyM6w8q/KsAcLw4e+XgQAT2t8j04MM9xAsAMU7Kn0tu+W+PxOnZZ8Cyda7oX63SC75xRz2HQXdtCPwmlMGWxwC0ZmUFrnAp/21osS2WdSUWdQZalN5VpafMF9Wb6pQZ5ZzJQjd3emgUvqFEVZ1e8jXvtPtuNsFstYzrdIWzRtUAnRIPqkqZIkBbC4wEKYQmHLyc2LVwzR2RXgV6t6aw7hnyhPOX9CwDI8hqXJfYblFMU1GzbqSNGhvyXo4KJOfdu63FwVibjm/wRg+XGCcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:41:45 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 01:41:45 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, Frank.Li@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de, marex@denx.de,
        aford173@gmail.com, xiaolei.wang@windriver.com
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3] pmdomain: imx8mp-blk-ctrl: add missing loop break condition
Date: Wed, 15 Jan 2025 09:41:18 +0800
Message-Id: <20250115014118.4086729-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH0PR11MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a104d91-3070-43bb-23bf-08dd3505c4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URuWVXdnxcBtHjkYcRmUDqFUgpnd+vu2jHP/qqM3HodoA53fUdthZg+Sjj3O?=
 =?us-ascii?Q?OJdDD6geD+cIRGPsD3im3iPj2ijf8gkcCpqnmTLbHjJA+T6reOY8JWVF7rzT?=
 =?us-ascii?Q?2pdpXHGE8DELkdHC/pdd93HPFv/TmPJnwZ0M/CPww0GLf0R8w8uoTtIIIzjb?=
 =?us-ascii?Q?4Y6fSHeMfDXdmhvKcmWJJ3Y3ANHlOyZFu3Z7Hwb9Jyeyfzl2stZ9Ls66lXQG?=
 =?us-ascii?Q?EXE2vovGzFf4z9YJ5AOdJ6P2uHwaM61Yohw8h1QHiDeHxEeCSMkd0/pU3b7A?=
 =?us-ascii?Q?Mw3JOWf4Qsu04s18D+C9G3ggBBg5XIzQGLQjn5Mlj27tdbLfLk1JuJyYnL8b?=
 =?us-ascii?Q?8xmtm3d/d0fqD2jDz0y3arZDME8qtquaQZBbdFczQ8NDxOsO27no8FUe2fjQ?=
 =?us-ascii?Q?VnzgLfz4AsRzKkEjvpPCIekHGA/F/YR/lLyQMBrTDl7GUrFKYbjKwI3GM4C1?=
 =?us-ascii?Q?2GYf6hDnfB84VJLhkyXY1VBzQnFWEFqDvNAH8YXzf3lJlIf9/xSb66O+qwG6?=
 =?us-ascii?Q?VmfZGNWVo4KvVngGHK4PWm9V5lhC//DkG5qbUP4I6/fEbOf7VcPtllykz0Zz?=
 =?us-ascii?Q?qzVbmn5tjJiQ4nSnysJAwL+l0DMuAXgE5Edvdc05dzU85gvst2jxuE7bh4r+?=
 =?us-ascii?Q?CIjtpdQQ4pKMqGQLo4JZRt2yL0QOv0rTgFDqWqnMuhuaXH2OLhhML7SOFYc9?=
 =?us-ascii?Q?gTVMcCJoRE1cy6w8NXg4aUuE9g87b2EnVQFOaxLWc6mikRjJgrV/NaKTQYSm?=
 =?us-ascii?Q?Dqg/gt2/GMqWkYZ997iZEu1HjYWu4uS+pKknjWdiIlSmB2Kmv/PVObNxdl90?=
 =?us-ascii?Q?aafb5qesO0j67fSpsCcAoUsF9W9WVz5L2aRZgaubcBWHo6U6TSj+RRDk6lkr?=
 =?us-ascii?Q?Ma2Lls0e16jsjn231TXWr3jPkZuymEcQ5NDhpEpA7XnX7lqFk8akG+0Ogn88?=
 =?us-ascii?Q?rH+G/2ikwII8Q/Pri+W8/eQp1/l+rlCqccaPUzLE9QXWvGVQ1uGrzqEXJJVf?=
 =?us-ascii?Q?jLdBFxdL2+YdVR/nvq0DTlpIG2zPzsFTBZDIwFGBNsobVi7fmRb8H5IRxnoz?=
 =?us-ascii?Q?lbimHluutJvBDb2vw62Px+od0sCne/NLzcDfsYWeGfnq0Op78/ETQrhNfnmW?=
 =?us-ascii?Q?fcJHRnnP/KBoe2TJFP/0POflZhEApOZV3aRzMPrMl+bUjms+ozMU5V4ECS1o?=
 =?us-ascii?Q?TGT4O4uUAWqkflIyyPJSb2MUp2Q16XWWV4Qj/qhTfj8f8Sr8P8kzSQiRRzBI?=
 =?us-ascii?Q?P7Wvaa8SyQUupq6SS+7GdT2AoLiI6UNnWU2UdhlhXhHBk8/Iw2OT7xbcDXil?=
 =?us-ascii?Q?+Y1kjJkvu/vcBbKyDyjwtvtMoq7msb6jQG2p5rMPEoQEfSzpDhnCN0tVKjCG?=
 =?us-ascii?Q?d1HHWYb6X86wSeWiHrEpPxOjiW+WgLYao8I+cTO251nlmk5hBTrUfy66vixA?=
 =?us-ascii?Q?Uqn/B83lvBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Plzc7+wJkqOedA4mCi3sqxNJCuBYPrwckmQsyLityJIGKph0p6dFiNJmMKOg?=
 =?us-ascii?Q?Sg/cee8VqtWFnxrHtOgOQ+/OdB3whGt8GaL3TvU48Y+W8pmRpNHIMIRJHakG?=
 =?us-ascii?Q?llk9QDiuakg6hC63yPqcuOXyFeNYrNj9/OFbaMkvwfAsSbkL/6WX5hHQ6eBg?=
 =?us-ascii?Q?7/jDCzYR7qMa9UBuO+bzKLoU+qvi1n3iO3tD/IXKFml5+DcsOh5/yZaIBoGZ?=
 =?us-ascii?Q?g9th7jlYXA/b6UTZM4PHXGRTycIrZM+NZ+A3PgO0Y5ZCa5Fuj5iS2puCAIS7?=
 =?us-ascii?Q?cY2ytSJgUUA7lljqo6b4v2/LSMIdLU1q6ZOKujdykaEvQmezGVPF52IJc39n?=
 =?us-ascii?Q?CMBtQzlu0fbPpj3WriQ5LEc7KmDqRJ+baxEbkvt+zNVnE9eGX+d3ldEbuZOG?=
 =?us-ascii?Q?2JYpT0DeRHYFMCnnHIfwiriqGFocNf0dKo7yQCH3pO2K3/MkH+FFj9gLOW1/?=
 =?us-ascii?Q?kSVRdkGu+GBmDSwz2HO9ST7mHi95RQxpRuuT1b0eqkXdiJ+FSZyigPwQYWJa?=
 =?us-ascii?Q?8WYEWKpHsGj1+egiEk+33xdNQFIO4aO+BQmzxfQwoFnVsAqRD0qeWSWC46yt?=
 =?us-ascii?Q?1Oc8TubRq5Wu7Zr9QUj0/J6751YPd59oDPELtM5GCKNm+rGKl6vAPEgfboKC?=
 =?us-ascii?Q?1nPVt0+k1OBd1qQ6k1+HWpGUT5eMt5Zmo+eE6wGG09ivYzbM5NtzyEUxBfaK?=
 =?us-ascii?Q?TX5DJQkP/3I8x9VLhUTA93lVXrVlPKY8H6xRwESzzgbKgYJ6CnvGdUJwglof?=
 =?us-ascii?Q?o37swS84yRPzfR+Ta7t9oqbW3fMI04Iv0Xi9pFSHk6exfkN4bClE8T7FlNA+?=
 =?us-ascii?Q?bQ7UFNM6sFW118Zbk6sJCjTLr472sNIuHhGA0iAKsjQq6rEDnkN1qORb52om?=
 =?us-ascii?Q?CPTA8j28fCiXpM8cpfwlJy/5XbYCmQjMHf3nEeB9KTQxCOMjmIRJVvXFaC3z?=
 =?us-ascii?Q?6wiSKNS8cwEQFK2uC0JakPa734oOlYW+owwCvcmkUPqKnTcvUDToQU9TzF8w?=
 =?us-ascii?Q?3Df/wrU8i9ktSqU4F/43v9GaHHqli+/WWAslQTL3jb2cx5p1/klqcc5Ez05j?=
 =?us-ascii?Q?Lv+vA2g/MlwzvOY2qgwx0G1UFXWg5j9yhVhj2ev40111JqQONBMWqUGZVbxu?=
 =?us-ascii?Q?RC1ziEeGzgeCFCPUvW9SruE7/asPihBBJ6fzixPW9TfsSxW/vpyjHWBJdrV5?=
 =?us-ascii?Q?G9wBrxnOlLifJyvViHsA9Szgas3fITJj8DwjDZFLhhs53r55IXPMAQGVEXhh?=
 =?us-ascii?Q?8EGceVdVz3Ln/bNw/xwu7+aLg+AeSLB/M6BJK1txxEoVFDYjtiBYOXvgNf/s?=
 =?us-ascii?Q?TUZx2gvfZilwkN5eIdtT+6ILzyYcEJbJTOCtaMeaNlKWuSE/0qwC+OqL8U7d?=
 =?us-ascii?Q?rVu35xY5sL10joKpp34jdMXRIYk7A9O1slbVzwRTv4QDqETHtvRxNskYPi6v?=
 =?us-ascii?Q?r2MJ4b7oRqCSQxr7MURfq35XLgfz7HNjiF2KWuPJvZGQ/iZtoEZ57rBKoyv4?=
 =?us-ascii?Q?09RmWUY0uNrRTggacjEcrjCNMJHF3OZEJY3G5MSqQi6/gjP30xAkNZbUtXkh?=
 =?us-ascii?Q?kAdYut6s7W76WfI3NX3UNDOgW+tL0lwYdJt4r9Huyy9ZPTc1OiQ4cDbHtHMG?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a104d91-3070-43bb-23bf-08dd3505c4bc
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 01:41:44.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lljC5K3QzmFW2cs9iAukE5TqWnWFsk8nm8FWPyJCKtuXCjUmcphXkzpux5YUYeAteuEmaNkrBRCuzvfvORgFy1FGKRqRWsTiltd/Vi4Lm/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-Proofpoint-GUID: QTInSD45onKbAS4ulY13vKGXJuveAQ_5
X-Authority-Analysis: v=2.4 cv=EeoyQOmC c=1 sm=1 tr=0 ts=6787125d cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=7giN54SSlXpMncPZmE0A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: QTInSD45onKbAS4ulY13vKGXJuveAQ_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_09,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501150009

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
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v1:
  https://patchwork.kernel.org/project/imx/patch/20250113045609.842243-1-xiaolei.wang@windriver.com/

v2:
  Update commit subject

v3:
  cc stable

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


