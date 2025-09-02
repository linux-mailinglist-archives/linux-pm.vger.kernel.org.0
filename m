Return-Path: <linux-pm+bounces-33632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B153DB3FE8C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F947B3838
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0137309DCB;
	Tue,  2 Sep 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E9mmKEsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B63090FF;
	Tue,  2 Sep 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813567; cv=fail; b=ZrMdukJ0SxIf0gOASEySEVnzqQA+y6Mj6HbcsA7AYEi+/J11LFMVtfvoVQv8fB/O4bAMvlq4PFktGDeuVr7PQOvno+OEDUDUUB1wHP79ssKXBO2fHaVTFGOrApqnZ9YogAtvOlw/ifK+clsBLO2TY413U6+/KZRdcoZaTj7NTrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813567; c=relaxed/simple;
	bh=vRI+LV2OAiY6wLbBWcHITJ4lIW5nDj1LPo22RDFTKT8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h4LSBuDBmK0hOZLr+3daYz4b0EjPmeGr9SlE97cLkgYa/gs3tY3jyYBGaHhoknF54fKh9mGF7mkUMzMoiCHtbFxYTLs53s4vOWT9U8qlEnbmWbXA/6eC1yzDcUl5JyBx7zTDWzTAJXIhFp3zd2pCldbfGRnrlvTO506KDI6h8rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E9mmKEsc; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQl4enKZw2OUwq7tFYlKGmrVKAKTlyRErr0Yktnzoe/93xzVAvXJKYIFu85Tigcg1ca5Qjgc6YV0mdFGGNAnErr5kZG900Iw/gq98rdCzBZ2QGTOuUH1CusOo5D3+Z7mg1uEYVM9pzFTLQafWAaBtMrBvyBNBbc+I1ceIvUnYjtIkzVsUoO/8uzfyoPpTCB0OFFtLdzEMcUu0hhv6t6nC81qxFnQ2qvdMyYED7K3owVcfzbwbrc1UM6+DADFlDWcx2OTx44x6l2WixrpAhcH86zdSiqUJGRCjluSGDxuUYhS926oeRysm2nSBXLRjpIebkeVEDrd0Yj7iTaWOHjTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGIZxr2U8zIZhRFCm5ueDCdsGqQTTaBnYoXULTConhA=;
 b=kBNeJdP6r9PEB3pQMuKb7oFT+yr290/7gpN4UPA7AJvxCvF0KN124brN9vzzdwXeOZBPZuENuXz057srLzpTUUMd9+t90PKMhTmzO9Or2xkbG7puxJokRxL9VHmwVa3+yTAqmu+gg7EhWkSxti3UH4OfjQzK24097YDAp/W4WdFJIfjSi7Gx8QDcUGPg2Iza3WJV32VoRNPzt8cSzIBJEbAH67VZHBDQ+s/0/gOiNCD4b9mFANJCK/gtmDKoDxSdrGKDA0lo8IuNA/yZj2m6asgNkjn0N83kho7trDLrhjSCgMLPx1cpAUQ3t6lvkAb+iQR+i1TFqbriFr08OS5flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGIZxr2U8zIZhRFCm5ueDCdsGqQTTaBnYoXULTConhA=;
 b=E9mmKEscbSwfPzw8EDoaqLI0q/lURpRo9zeQUuQz6Cw7rnm/3t6AizVjlZmIiJVAgcf95v1XGfS0hUAWd1LHjRWXrnvMJHkACEfaTGY1F5lnxGaAuaGtoOkJKpDzw8vMJGup8A5m+yzG/VjBYEABSl4q9GXeEz+o703Ak0S6Buq3Ysybr6uIeVyNb/cI5ulmSb4Xc9WoZRZL0IYSX4TL7uFSaAw3rNJdQcmFxxUGedTJEZRSWHpQkbpU2l+payYqndjM5UluCgwtfKfSgW69ebFebTXvoSTSLZwgtEc7jPFgRGOMWGmRAwb0aMRHoBc+ZnbXbhYkz41C+TY1bGL2aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6256.apcprd06.prod.outlook.com (2603:1096:101:f2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 11:45:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:45:55 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v3 0/3] cpufreq: Use int type to store negative error codes
Date: Tue,  2 Sep 2025 19:45:41 +0800
Message-Id: <20250902114545.651661-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: aaffe4aa-9874-4eea-66ea-08ddea16464c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PnvC0H7H7jtsQsrxxGO/G0ZLbUQR1FMIlOEl/+D2voOaxRY5ml+ipFsu1KNK?=
 =?us-ascii?Q?muHlgG5+xOLb585HpzEgkUqBy94GkbpTL7R/CRLfhtqsBOUk8OKLOiJ3vNhH?=
 =?us-ascii?Q?6BbafFT7rg2vT1vFCivmTfT8WYSrNBEG5/ezfqd06h7ypNlAlHxUw1M8JBju?=
 =?us-ascii?Q?t8wpIvWXKCsd97R4QRpUZewhCkpAWuBZWysymMTW4QTdTZUyS9pIT3uRUCTr?=
 =?us-ascii?Q?izmIEIEHckAVcYVVmPgMVheAL3SMx67IH2LOo9gBjL0ndV2irZjFW6E5zlZI?=
 =?us-ascii?Q?6UgoqXr9C44fXPnyzVNhs47LMNEpmx9NUyCt2eN7REThPYgYfGMWTk8sDaXx?=
 =?us-ascii?Q?Rlw1Ny2QaiioJN3I7x6WpkcyKMXu/UDHXvin7pe7rkgtHGUZAbJPnUhb2BVN?=
 =?us-ascii?Q?5mFwmgAsa65miFUnfHNM4raOAOgOR0jNGzB4BGaZiZFQFCrKAL9WboylX4Eg?=
 =?us-ascii?Q?VaDHDw3Khz/JB7YJ39ZJ0HUrqwVBVLhqkyRAiiGRiFqs91UChgzQ8gh5z1Se?=
 =?us-ascii?Q?4GP0WYzLZVl8XUlMGfjDM2AeVcrYdkSN/unQeX385uQ4Nojbj1klRi2h1mg8?=
 =?us-ascii?Q?YSpu6bSX3ZdCgnqTzoAODtwszNgPIisaMLiPSfXss2O/hT/c0yepOFLkKLgE?=
 =?us-ascii?Q?9pcuaNm3BRWqZyT1xqq3652/zYFVWy9uMIL1clg8fYU5kQlfGzj6L2cXag/A?=
 =?us-ascii?Q?THAKXo949Oovghyvxfn8ewPkSBD0Ly5tD8D3CZlBSAdqnOL3MLQMZkwdyYP5?=
 =?us-ascii?Q?84RnIqZa+RU2zVmGdzVPEC3232AXnXXJq8q1rCgu++kiUirH4C5MslPeff4c?=
 =?us-ascii?Q?jtcay432SQ2ZNZvuV20ftY5Tln2L60H9PODV/pTaCrCVQwL6IvH3hMLi45bT?=
 =?us-ascii?Q?NkHNoPehrNTbfAZGKQu/Fxdf61UxxP6ba7KJC7c9OncnnK4fplxVX9cpvy92?=
 =?us-ascii?Q?yBUf3y4d7EDrRIqB2CjKsV29WzSCfzdxMtQfov2ufYFkzRvHqivsO6d++JKv?=
 =?us-ascii?Q?ag7norVM67CFsIMkrRPqgyliB3Vth3cezyZwlvLXVvT+fiS3F6iTO0S46xyq?=
 =?us-ascii?Q?6+YtSDvBoLEIBu2kHwgm/r7QJ+rX1/ws9FrQLiK204CFgJ6y6l6p6DHU5PHe?=
 =?us-ascii?Q?UL/9qEbO06AEwOHxPXtT6J+GrH409R687VSTMRc4YY9cCzWoCsaOKb8VHu6T?=
 =?us-ascii?Q?GGnjEjytbm2C8eM2ygU/IdAu5pjA7+mzIxK/zV5tlm76CSvkyJj4nq2A6kR8?=
 =?us-ascii?Q?ESHTE1nmfvVTokcBKxfAxTtQasd5Cjbsin5olmVTLjoH2n7SWyjgdhc45iBx?=
 =?us-ascii?Q?0efDoFzsqYYxs/MAxD871ZjNEdYWkwuHJO2VE4i6es0TqYW+4sXoVVa1qjGM?=
 =?us-ascii?Q?RWHQWm8fTlyar7QNJ4MUTMSf0s27O+kYSH5koka6FobabcQbV4po0bUKJZpJ?=
 =?us-ascii?Q?G09QY4MdBXAcZV4adrmpDdHx/f4eXfyRqrfiNEZfyz7kuX/2ntCjNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTKNZmkCkcpXD7Z8PM45ZI/sL4wUmKjbI5CK7ESn6LyftEgYQ8pG32kb1EVD?=
 =?us-ascii?Q?7Lcb08qzx4aoX0ps88IGlqHbK7v/gRXmuKmZ6FvS0h9rQtVYzmbKEaLw78D8?=
 =?us-ascii?Q?UePxcf/pAgkrTKFSVSNh9ILZLp48vjhw7d+Sjnrzw5jO8sfFEAA43r9nxqeT?=
 =?us-ascii?Q?ZdSO5TvSd8vz6V1VuiyY9aaKyeKtmVysg0ajqReTVvzw2jC6yjYewRp4WMkw?=
 =?us-ascii?Q?Fs/4i8nkTAreN5u3mVcHrH37lQHkr48Y0wZ5Q2mO1qJfqJf+dv/e78serPCZ?=
 =?us-ascii?Q?Hv59+XIiwLaP7uOEv0XFe2AUSRMDW6eS1jEuNdQoe9S/oMPhUVlck/kUbri9?=
 =?us-ascii?Q?c8WnYtCUHqqFits+m4PU4jJlNeCPDw2rm8Q09I9nGECICLSHckgBBYBCh+F6?=
 =?us-ascii?Q?r3hCke+5EZjVu9GRSmkN43WLriXHynsPWQlN+syCD7aFuq98ik+PFn96rRqP?=
 =?us-ascii?Q?3ouMhukr5uhj7DgOo+T5GaWCPPw4g8vgsQzsWNEcgr6Ed4/Odd1ju/dRwRyJ?=
 =?us-ascii?Q?FhJAZz1t2YZUObYMJRx04/TYBTbkphJO0DIQTnw7GpNjbnqUTnStAAexIXjw?=
 =?us-ascii?Q?mox8ouca0tKJSxYt8anNf2nDCwA8U6l/fF1ylSp2VlbE5QTm2moH71GhjrPp?=
 =?us-ascii?Q?TqRYJjPwtnk6ei92O4iDyN5D0uIMKf1F0Nk07IWeSkoic1s0EAj68R7zCsXz?=
 =?us-ascii?Q?lKGNtsY1ksBMXXsc8KHf2rU4XUaDDYjA31s2ElqKoRCGYP2h+VI6LqRtE7Fw?=
 =?us-ascii?Q?sz4dVsgFR+CxgVD9W5QdtAdGdp3c4gsGsC9ywoJ5ZfmLxnBkU0Fj1c3CjCYM?=
 =?us-ascii?Q?4oL255Na8iW76C6AM/N6vtgGcnXyw2EWm1sz0fqDT+CCt5tFu8wM2Pbhh8Tv?=
 =?us-ascii?Q?sKIgsG3uwwWKS+Y9oSZrFdlgGzz6js8MnOUyDrN72iR32Q7wvJS0xCfFWcPz?=
 =?us-ascii?Q?4fQw7SiFANgHhIioHu61v1p7NIOI4urEUvAs3FAigRwwyD/GoE8y/ccYUC+a?=
 =?us-ascii?Q?Yfs2sRD3ElsRWD2pK/SwFUxXBBQmcCc3IbW6iYJ/bHhqy3e0GhTEAfvFfMfe?=
 =?us-ascii?Q?VSxGrkTgNRuFUM+lIWdcA2GN4MeFAdYkNMBHXJtF3wLCL+4QEuKErACKZPpK?=
 =?us-ascii?Q?nQvWO4rOQfVXi3fNDXFFh++NAUr0Dv8aiIm1QAMWM2fNoiXsxlilY+961KCX?=
 =?us-ascii?Q?86B9ziKjQA1vdsCB4BzaWX1+JcZeDWNywMYG9W+Y6KXICOcaUbD81wcNGaRb?=
 =?us-ascii?Q?DIry3LQwDgqmtemCkxbq+z5TNr7ZZ8qKoYnvBI5uggca3PMW9nRq0ynTrtgb?=
 =?us-ascii?Q?ZfUHnJA44kI3GKyqBD9+FeA/lxfdzimFJEYaKHvoZ+UNFsc8oHxWOLkTS66p?=
 =?us-ascii?Q?NkBMFqRgWD+GNO0zwrLyDH1+u4y9dPYdiBsjXcjUoDECy1UXecS+3VFhMOyr?=
 =?us-ascii?Q?xAzcZRxizLhHZQNCTLrdFWYH855wg4r4cPQAPyslN5LZJ8ECFFaqP+PRtTib?=
 =?us-ascii?Q?yH3H7AQ21qVWh5Kh3ayqSGt34fLncgJXsdcTwBv2BWzWTOarS3jt4lA/6w+B?=
 =?us-ascii?Q?KAUqJPlW+en3NLkZo2K1k1DbHPGAK+LjObHF6+KN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaffe4aa-9874-4eea-66ea-08ddea16464c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:45:54.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmoiBYWmKR46SzpYnzzHmvB70TDtvYQqVCHuchAKZvTsa72v276mJ/Oz/1QaLhSPhxjob3Jw3dIslsKaCStCBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6256

The 'ret' variable usually is used to store returns from some functions,
which return either zero on success or negative error codes on failure.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing.  Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

Change "ret" from unsigned int to int type.  No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
Change in v2:
- Modified commit message.

Changes in v3:
- Split each driver into a separate patch.
- In drivers/cpufreq/powernow-k7.c, remove the 'unsigned int ret' variable
  from the powernow_decode_bios() function; since it is only used in one
  place, this simplifies the code.
---
Qianfeng Rong (3):
  cpufreq: Use int type to store negative error codes
  cpufreq: powernow: Use int type to store negative error codes
  cpufreq: speedstep-lib: Use int type to store negative error codes

 drivers/cpufreq/cpufreq.c       |  2 +-
 drivers/cpufreq/powernow-k7.c   |  4 +---
 drivers/cpufreq/speedstep-lib.c | 12 ++++++------
 drivers/cpufreq/speedstep-lib.h | 10 +++++-----
 4 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.34.1


