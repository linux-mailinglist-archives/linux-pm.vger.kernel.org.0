Return-Path: <linux-pm+bounces-14056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B00975E86
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DDB1F23293
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC7D1EA91;
	Thu, 12 Sep 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ejLJLxas"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EC53AC;
	Thu, 12 Sep 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104630; cv=fail; b=TOQbDbGw9oyct2Jpw+D1KOzLJniqbehUOR7v/emMpYCSWjjs1Tr/Vz5MIR3J8kfZHHdiKHqSo9BMDO8JbWKhYNZYkITyHXt7xhh0a9SnAxzN/mU2W9BDnxI4TGb79/KGLdF4FB8VrhxKgAxD5uxLRQZ0zOAUu+hY3XqkYMlsHo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104630; c=relaxed/simple;
	bh=f3617xKE0ZFw2sX8xv5B3j5h9udScE4lm/wG+pR9CHE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F5B803kpDeXy/tFWfj/K1fr0xzehWSD7VwQbldTiOdBAhkJhqrXmi9RrI/WNqljKrIhvzR4oB43hSFe5Zjwy6Y0yvHHYopS0Tnu4uIazDAaZzu5zPHdKN06qG5eISjUc345JpDFHo3tkSyi5Zyrnzv4uu7WIMqogu+1sIGxTYBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ejLJLxas; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDwv6pdntsx2JfgzbaZZK1MagWCGOGvuSxLfsdGsdaQCfMzTKgx1RJz16kSRhLK4KIok0F9mFNsbJ3D68B1dNW6w5V1CnhB2NSQNuamr7pcNCQ40f++H1RjNYYhq3ru0eIjVyASrIUSzY5CAi9NDdTjkW+u5VmmEVZ3DeI9n2K9iKUGU7+bFoCb3eY4FkEwcqHXKOnKEofVISOzHxn5tf8ZcCEZLAWM8FORksx/5e9hn9LwRreYzgjRd7yA+kap2R6/Rncc3LOShoRdcSAOMHaaGfhnYzGhWkBGESeitH1S8LyZGZuNvjDHYfCEfx69b30xXMcGg8i++rg2U1kxDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJTmisAL4HQ8lu23GwEaA/Ts3Rlft1WGRiZdEKSNHqk=;
 b=gqoodwJNhaPPi0er2P7XyWyhPaTJWaHtLdHKEumDI93aJEjq3+fD+d3+yHnIT64+YyDhuH6wstOE4QDGyoOEHeXwKcvJNfCumNwcilgU5X4fbiws6TsUBirXyUu0BQkQFyPF+zVp3xaD/oOeGs86NOtpGDsWDujStTAwLVSPs3GMnFj3lRmWUtyH7LKM1+9n7gXUfoGFqDny7TCdpx4g6rGTKmR/GZYoiBY15aDgypSkIE1N/RyYZzR7r6zCl1q4Yl4jVBNu1aXvrOCeYux2eSV1gMqiOp6oARvoxYSJoVfReimH54wR5h8Qfkee7Fq6snT8tXz5cSmMNIdp9A/hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJTmisAL4HQ8lu23GwEaA/Ts3Rlft1WGRiZdEKSNHqk=;
 b=ejLJLxasZ3hQdgjNG9XAoxfZ7X5O1g+tD+CI2atHDEaE1J1ly4wnTFXWrTkp/vX1KvJNHAg4PxWEaLPxDTBaGYHtNVBVBN/+b3/Cak3wp0DdV+XSDbULgIbe3Hp/1d2yGda+JySvUweW6JLw5keGGcw0WNyhDT1/tBuC0Jka3gAUqHfytcsSbwIBpFUMHAt1DEjl4QuR5BvP9q73udKIMJg9KHqaH5tngXomk5dAz7P899Wo5MHXgJLZWsWOCKb+1t1Yh3fCiTBrGHR+MtnPUuwQp0zbSBfEA/z9zFz9P6pE82w4q34YBR4R2Quf73xNrgDLPTliX4ArIL0itWYdsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 01:30:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 01:30:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Date: Thu, 12 Sep 2024 09:38:44 +0800
Message-Id: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 763d2ded-9fb5-4291-fe95-08dcd2ca78de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I93jpfP0QkJSwsIKBE0al2XnpMFGXjcWA0B/AdbbPwugETjW/YX6+kKpx0j/?=
 =?us-ascii?Q?NiwSoJo53nCPw341OyEuZ5zjwsH2zfBNs8iHFCB5HdgbA+rTy+MAGub9xL29?=
 =?us-ascii?Q?nSwEcL7+ICICAvcwmBwYjktVk5pLnJTDWJ+kwINy2CituctmP9e0gN6g5/TD?=
 =?us-ascii?Q?y730ALaSM4hiBH/NAEKGLsS+/DqB+lMCOeOJ86i9BWIJ4LsyDzhW2fc2QZu5?=
 =?us-ascii?Q?K9sdhyM9aXHtVDjCEI4++vgRqhTL/CbaRBaX/KaMJi1FhNYW+3IVGhye9EYx?=
 =?us-ascii?Q?AUDGNgQL2oDxefSKywuGSF31W6ncgNAukY4JjXVfbSBMp17pekpNSpdJ6VTF?=
 =?us-ascii?Q?zsWGbWFHzFQ9yx6tW9jOk6C5ybc/XcwW/pU2zgPTkk2W2b9O0cTzmgGIYcxx?=
 =?us-ascii?Q?C/XsAWP8kTJj3o7XVTj4QA3+61WLC7kojRqwnKK7//d2nTG6p2BbSiJe77Hq?=
 =?us-ascii?Q?QQM2YCfchMfZL22ADuajlIuzs11TVvhu3h3eaf66TbDLiH6Rc3atI1jpH+NX?=
 =?us-ascii?Q?3FagSyJ9UTf9KlYWRc0a2DhEm8Ju+bBFDzK10a/Z2wTBfCIn6xXap1kmQQKe?=
 =?us-ascii?Q?ul728vqWFN3nz//BNnqyuZ5ADMCsGYXMf0PX8CjI7RG6RZsZ9HH3aoPOuKzX?=
 =?us-ascii?Q?Fk4JJDda604zS6lefcnnL0K7wM9e+JjREzYEZ3xPbhI1eGRjp4tjZGKQAOZE?=
 =?us-ascii?Q?RKdMn0O6HVPC88exJxc1gEhq03r27yH2yBHKXSeh6UcO9El/ragjF7Ys6jZB?=
 =?us-ascii?Q?6x7B2n34parcYtP/VFjCSRpFfWNjA7Pu9p8nZskafz8bxGzilDEWHnT2jFH0?=
 =?us-ascii?Q?aafX6zUHqnEYeqS978x8eR5yIAK5rB6s0tdFJDa/n7h3IH3eIj2+4o54xpt+?=
 =?us-ascii?Q?2YK9qaALYAFSycEAduyYIkdeRa22CrC83alb+dlNQLUelAVwI+JScG7m13NA?=
 =?us-ascii?Q?nBff9plCx771WsDRlllQByF2loE6BppmgnH3DpBH4iTN349+8COJ2EPYxCkd?=
 =?us-ascii?Q?+iz69NlUEcE2nwu0NDcxAwaVV4whm2iltQHLrNf3d3TQjR8/fIGoZ5NHJ/v6?=
 =?us-ascii?Q?bx9TehMzg4zcPwocWFmKR46YTLAPiCjPyK4wFjWmkmOgnbOrYyfo6JKWX7/X?=
 =?us-ascii?Q?2iCsJuJffAUB57RFbElYAZZ3cpkRzXdUQMGOPlDeJw+9pWdyGBwd1ogLqtrL?=
 =?us-ascii?Q?cutwCv2rrhNSyyBiMylFYm+nfeIMUsLDDok3H87HN6H2zvDWPODBvk9qzGyY?=
 =?us-ascii?Q?J814qAs8DJk4iRn/2Tu+5cE1enXyNyz88VszmtIeUCOZDcWEnpvvgJ94Yckx?=
 =?us-ascii?Q?ReXYWzTSeN7w+OxzxYXfdnYS/ZzLRAtOCoWmN8LkOVMnAuncYLrv+9ULZVD1?=
 =?us-ascii?Q?XUTCiW1KOpjYl8Bw7auIL8KgkLdVJz5Oj8VL//N2hDVKpHbS/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4c8yc56kEzRFQfffpb35OSS0SvTSfzJqiUWKoUvSXxSpigL9FZm7KzeAJY5c?=
 =?us-ascii?Q?UW7iADpM9KGU9Uh7oY9pZp3EYZeQz2xBoZuK3sDDilWtPezgHoRDuaYezRrJ?=
 =?us-ascii?Q?1MuxHnw1aEH+ZLPHvUwb30XcAcaAN6s77iDA1nlrS+CE4gFjI59s0UKO5Y+r?=
 =?us-ascii?Q?dzYNfEz0KSOnCNMZci0HSD3nMQh152CdEq0vn6hdvMN2l84CwnHQxfxj0Y2Q?=
 =?us-ascii?Q?u/H+9gCPwWWSS9lgYlMaOU2Oe4BbojvehoOGsyZv4rea8GU/BykpcgP2mAos?=
 =?us-ascii?Q?zVyew5Q82al58cDSQbk7YuMs9ULxPSdP+j8E8i/uhS4sIXsp8YyLq3V6vQwa?=
 =?us-ascii?Q?TK9xLPu1OceoB038nPOh4uJ5XP1fDNAZ5VSRG1Epg5lyFV1Mw2NkXsSAraUx?=
 =?us-ascii?Q?xVbIbvTaXBrbRPUq288mnnghCyjTME7Eq16aGtZ2r6MBbwqHP1Nmw4czDhuK?=
 =?us-ascii?Q?wXBJ2UtvWBHllA2O/rNu9x0Xktf8sNhjT3yY9xywVqchSsrlZzoQxDgyJx59?=
 =?us-ascii?Q?0Y9lYldQLGBHsR+g4fO7hUVnZqdsa9p5/GBY9vh60DGTi1IlWOsr/CtrWkrd?=
 =?us-ascii?Q?EqNEC25rgl45JxKoeeHsSUe1Bo1oqZaO85eqGOa8Zq2QE4eN+WfxPq5OsVRC?=
 =?us-ascii?Q?DaDX34Ok9OpQjU0UnH4w6Sj5QV1E3yC7/lD27XpmczF9p14q2DAnJq5RImMZ?=
 =?us-ascii?Q?IEMOigogn1bkUJFYVRgKMTu+N6Mmyt1LWmXX7MO4f3kxD3AnnBri8Owb1lXI?=
 =?us-ascii?Q?g9z13ezAZiC/6zo6kfxF/woMOS9R16Nwhe9INEYAloTDt8VdsEyCBuvefRxP?=
 =?us-ascii?Q?N+Ktf9q9RttzunUDoAUwXM1s0RrUNVLLWDE9EbsupibGdY6Ck1F2jdBEbAmY?=
 =?us-ascii?Q?M25ybsaTK851PXBH7tXbAWHkrUy+7W5g1eqUlQsGzWSTo/XHwy9C36IcyJ+K?=
 =?us-ascii?Q?Z8jHCLm/c/VwHMc6EIE7qcM3X/vVoyqcqedqlWMfuPgyyPO4unSacNSSG4sM?=
 =?us-ascii?Q?BcCYJruxizmTlpiPx9432JLQvlpnP88v9mD20FiZGkTfIRmwOMiwF6d420Tt?=
 =?us-ascii?Q?bfXGWArvrjJy5uP4NWQ3YArFpw/xKS2ZxEcqQrl65E2mwNgiCGkIbOHlbGbB?=
 =?us-ascii?Q?26PK11oR6bWHds5X6rTs80zkL2SLTEjog8AbwWSXAAEdp0lEeqyIQq2P6i2O?=
 =?us-ascii?Q?1YxREUhJhnbd8DcqAchs03O9FVL9+o/biVPD8gsG+qjjU4Fe0Wo/S83nXu3m?=
 =?us-ascii?Q?AWydghBFThRaSXdMpp0sNvhcfXcfIbuBJQhvaQ/h5Zol2tTEp3MWsFx4jxVM?=
 =?us-ascii?Q?ZO/fxI4/wbZZjCAmdWa8JUEwP+ZLl7XIY67x0wx/9lHNKynWfaohBPeDUuv3?=
 =?us-ascii?Q?anwm+6flxvM+mPYVhPO/LZ5MWZUBgu5aVEv6DxsBBXGp0mfwRYs/7tw2jvxD?=
 =?us-ascii?Q?VNMduOb2rV3jnHZS/iZaJcTwu4vDGyugAorraQC6XCGFchuCKDaxdP1/G+uy?=
 =?us-ascii?Q?oX3+Wn8QwYQuXo6prmQLjor+gxb7OTi68gELoYy1XG5eNaEQdFloRfqQiKrB?=
 =?us-ascii?Q?YpizrIVj8giJv+OkLCb5N9Vk5C0niwolVigNR7ay?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d2ded-9fb5-4291-fe95-08dcd2ca78de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 01:30:24.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hN4VNs/cDgC6yhOcgwesnVInQNUg7gyl3+TDUFGmX11Ninox0eMCr31m4z6Z1e2VWafruOtLbWQh2N7ZhrTQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

From: Peng Fan <peng.fan@nxp.com>

Print out the config file path when fopen failed. It will be easy
for users to know where to create the file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..366b20f9ddf1 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -166,7 +166,7 @@ int prepare_config(const char *path, struct config *config)
 	configfile = fopen(path, "r");
 	if (configfile == NULL) {
 		perror("fopen");
-		fprintf(stderr, "error: unable to read configfile\n");
+		fprintf(stderr, "error: unable to read configfile: %s\n", path);
 		free(config);
 		return 1;
 	}
-- 
2.37.1


