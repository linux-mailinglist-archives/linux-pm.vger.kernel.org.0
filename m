Return-Path: <linux-pm+bounces-10324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65A923A03
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC61C2109C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345C15098E;
	Tue,  2 Jul 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IM+jVdAF"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2072.outbound.protection.outlook.com [40.92.107.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61141448DD;
	Tue,  2 Jul 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912563; cv=fail; b=ISUEtpS5daTHgZXvhuimKT2XenSf7k5seXrNR0d2zwAZp8uig/d9Qm7iIuirxe1cZ68c4pTKM49IVOsWWlVpuYpjqU05qp9IXRjLVjncSGxztj2tnLa1OgfIBCfUJHYPtPLJk/bPmMEn4n0uMW2JmWQAZSTwPI5U5g30E+wcwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912563; c=relaxed/simple;
	bh=ocSitBsrfbb0zpwJXCfPxSch1FHNx0unxQS7ZAV1wDw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lXsGJPFcyPT4qK3YtaW6oOUdfnMHrbM/ueEiZRH2hcMkKJDHVuYaN+6FYYLLY1Vd+Mvt95o6OhYMcyhfcrKm0Cu4R+og0aoXVCDe6A4SN1Tfnceb1v2gV0h3JzVj0njrC6KyMAPAYLxhzgBJkJMefYcagROhVTzLPzgw/qiUT00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IM+jVdAF; arc=fail smtp.client-ip=40.92.107.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJe4Stmcy310UQQCH5Ywr+hyPkmWZIG8Lgko2QLFgXGH9s6slqaAK8KGTsVy8JDYhTEmz8vIiTw3DMumOtDkFWTa0Nn9HvX+uikF/N2NLS+lGTuEHzSo+8P5eUeB8mG0TMDAPaedhsQLNn3OxDWK+qH7I2p8SfuAS0WuJ3XVX8QwvG4sCoo6X5Ymlzhtwtur1GXSsWLDB7Xtpm8utUDZ5uUkn7bu6oCOf5ny7nanFRlU2KDfkDf5CAubq/FaaFqgBx8Vz86y+/kWJnEacDuBObA8scL8p7Ylrb9XTm//fmWuvwEq8EDhEDXbdcCUEHMWQLIgsiAmP9TGuWX7LjCRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wPto6yStXQTF+mmhWmBfgxZL8A7ed9JkuwQXXzMnC8=;
 b=bGUFrgRCfQ4A2qOWDhdHyuqhyPvpWR6NW9zQgsnu/kL7WREWIXW6uvlTae3Pm69NijchRr36fBBVCNyhcQC+NaTykSKuA7HcIAoErAsUh1qDz6dfsT8ixigqcsLupJqNpouyHb36sG+qcGEV7f0C5ObIfMrJVrD+b6PX36cwwNqAJ/9iZmaX/vE48fM+etkizeHAYuOEfLfBbg2R5Nrn3Su1xx+Oq4crnF2h9pexEStcVgiJHh2AUyNbDiXPVbz4X5Mb/rKIgT3DUhtdB3HMuZ40VH2nr6xnJOwYnXCxaeGZWQB3jKXOtZg8tQirgU5z6Qpc1+gBf/c2DVsgg7yVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wPto6yStXQTF+mmhWmBfgxZL8A7ed9JkuwQXXzMnC8=;
 b=IM+jVdAFr6VyeOuXch11Ur3TJB0qq1A1RhHqpt3VtHGtSreNTBu9zLQubbgqFjraJ6OGf9ZpVRpo0qyFJjmGpkFcHqHQDg/YME3ViC+VHieEmM61zGBqc5j6gE5+qgLgz8RcIapg1A+ZkwwsOnlr+PsuBoxaemyRWbLtHh5pXns1l9hobcbr7VqeWd5ITiT4WC97gav3FHBNxeslCRj3t6YiVATF9Lg+zC8O/mjxP4sNG9cbUtaI7u4+UhHiRxa0DNaADP9GH45FGV9T/UwdtX1cmamMTID/sNCFCY3r2Sb6J+Uh4HFfnNiB70NGCXbFKrOGzIASUt3+BUagis8pCQ==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4157.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 09:29:15 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:29:15 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v3 0/3] riscv: sophgo: add thermal sensor support for cv180x/sg200x SoCs
Date: Tue,  2 Jul 2024 09:28:19 +0000
Message-ID:
 <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VctJtdOsgx7Xr87gqJ3YWZulJDvis8Zz]
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240702092818.65413-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: c79ffe61-a28d-4533-0cca-08dc9a797078
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	jPcymg5SJiHco4LqFbPaTy5wRyEiMm6isylADqDaYWlLpMiu9zgKnhoGz0wUpwQtVdGwUyw02mt8MPsMlN4Klt5EAFZz726OYsm+djJozVMzbeKmr6MMxJ1MaEIeYDKsNsWlg0qc8Tu0Zv95LygXblI7+8h2C7w4jwjnugKBSDmRql3m6U/Wkw4MWgwg4AV7r/GvVenQD4gyizsOHAg8bE/uL2szNIMCJfRgCdheviuLY4xArqhZarocR778/DK44u9t7HDsiVWZbPa2qDt+y0fbAsHOC2qdLCx39u0G90t3ABgqd19e5l6hq5D1EUYMvCO0Q2K+Hui3ivwtq58npEnuSo66teNPsnUBRZ3UYWXehmes9RJHulskXJwd3gkEfCsK8CWqc0L51FH35k3VXlFu23Sz4H66ISv8ai1F2SMT8dxLzxu9DXOI1rx7M9CHMa4mQWiprFnJidxSDE5jotc7zEE+VfP+MikamfeZWPJ15fcnossZ8sPKKq8+rZNbEfnAxyumKTqAHQuC+6sr9oj+snP2cH/7Jx+G5NBZMsLP0dmm9rtR5HKgS225pnBXYU6pY/gVaDxDWujJoSQnwFV6vi0+2lkdZqMT1GakfjT5wjdV2+zNvuB/7phIDrMCjSKpUVQmM/e8CkUGftXsqg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XGXhK9q5iENvEeBIEaP9QBHFWHxzpAq/3jV0OoHO+4zWhonPqo/xq80oTPnV?=
 =?us-ascii?Q?1qQrRweS42ZCq7s8V5flL6fLcumvu7tjsCpdocAf8S+fuVSDJvEqFhSz+MAY?=
 =?us-ascii?Q?GqmKwyy7o+OXtJpvYiJuLICroZxi7pE7Mbs6kXH7nYreMofdjW7At5mzMBza?=
 =?us-ascii?Q?Xlfa/dLV6Yv5fmI6YGneUYLsU7SW+INR5Vkqy+wrPkRziL/FCKqKWL9/EZWx?=
 =?us-ascii?Q?UaJ4/8QJlJ86I+IC9I5zTqmdFxdzwxjDRjtfZvn9YsOsz6autKMCOZw9lTyb?=
 =?us-ascii?Q?maWFfhBjPoswhf9hLm+ocAUjRkw4Wrstz4K3RQWFxdLbhpVIqPP6qklLDI2k?=
 =?us-ascii?Q?JzlaZkjMZrB/NMpGgJU3lyfHZApfKJrvEWGu1Ln3h3LLWouSEfYUHKBMClJ3?=
 =?us-ascii?Q?FBS9+2cU0BPHs61KoLKoSu9K5eKZffvykMtPKxI/GJK/N4eaZlIyqrc2jwwq?=
 =?us-ascii?Q?iq/W20wIPVK/1e/kmHkuLfvMkch6m9m7zQU4pvJWBN/Nqind3VgkQYfw038Y?=
 =?us-ascii?Q?ETCkVW1eEwmog/YxEldmj19pOYAGWANokP+ZzR5BDE/4+qzb+BlL3nClibml?=
 =?us-ascii?Q?Nr4uIMdbT0Hp/e7Qlt5QMFl0HXNSnTaN3YupYISdkQSN86bWBHfvb+ZfqOGw?=
 =?us-ascii?Q?LKuOvANx32RjZh3zJp9GFvItfMvEhE18vgV0yz7dWTC7IsHBxUB3D8e9tZ0d?=
 =?us-ascii?Q?/JTqmWGdXP6AbLWM2NnDCAUuGej6q8NYaKAxw6VI6JfNe0//fWooE7JqkEjg?=
 =?us-ascii?Q?wCyrls0fyvy8wVAhpmyyQejcdF0BHBkUFZxU5MRdCY8QIdU6f+pKXhisIN8n?=
 =?us-ascii?Q?xOtwADyGC/Zgf73+PCFardiUFx1PlXWyQO8rYhyySVrsIta8rn3puO9EIx/U?=
 =?us-ascii?Q?EzTLZULSZaSYhsgZwA1Ctn7BC7FVcvBOyeLitqTqbwIVH7jen/0vuziiS1zx?=
 =?us-ascii?Q?apaKYzDAXSHV5bUWSwizk5XbDpWnlxcRAAOlcleXE50nHSuaEYhTpgw48jAe?=
 =?us-ascii?Q?Kon9Gf3xjQyzl61ysRHuTeQe8KLtP0T6LoHc313onkxX2CP7oBVA7Zrb54Yc?=
 =?us-ascii?Q?BA+r+zmd67K7UT4FH15L4O4ibl0wn5ZrSUImCN4xddZjLmhMquJn9tAwWQBa?=
 =?us-ascii?Q?DS27aXjvAdAGctE5NbJhjIR1ySCncs7QCTePsjrNBbV5kZBoPULnhyZRqWfu?=
 =?us-ascii?Q?bTyweHUKW6FTi8oNHOUCZLcHNt4oADu1U2Q/0nBxmOcw6epEj/BcxEjSQjQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79ffe61-a28d-4533-0cca-08dc9a797078
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:29:15.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4157

This series implements driver for Sophgo cv180x/sg200x on-chip thermal
sensor and adds thermal zones for CV1800B SoCs.

Changed from v2:
1. style and code improvements
2. use human-readable value for sensor parameters

Changed from v1:
1. style and code improvements
2. make sample parameters configurable
3. generalize document temperature calculating formula

Haylen Chu (3):
  dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
  riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
  thermal: cv180x: Add cv180x thermal driver support

 .../thermal/sophgo,cv1800-thermal.yaml        |  74 +++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  30 ++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   8 +
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/cv180x_thermal.c              | 281 ++++++++++++++++++
 6 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
 create mode 100644 drivers/thermal/cv180x_thermal.c

-- 
2.45.2


