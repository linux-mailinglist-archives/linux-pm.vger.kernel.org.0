Return-Path: <linux-pm+bounces-33633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED9B3FE93
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C2E17A6C1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425930BB8E;
	Tue,  2 Sep 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="USEsiuEE"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7703093DD;
	Tue,  2 Sep 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813569; cv=fail; b=qJccbiHZHOvn5KoIDTcK6rN9bHAHg8tzDBv3v5Kt8GKJkkfsjhmwXnmaRfmcIMwg9sV5fpM8A1rtwRU93CgwM6f2Wf9c4q4Vbozgc1v+Wl0aBb8Wn9j5KEpISmlzf2vu6oBwDIpCpyZh7ecGCAuoKgl98gruXypaFymKfEBExJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813569; c=relaxed/simple;
	bh=eEFOJaYmhKivhaDu1MpMd3FbRLPD7P//nZijdztIhSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pSTDiCfNtsfwTMs114xUOkIdw/iXL289g78VDGfd4UPXOjYTIaJxia0vhbAtVtuq2Flo2vqFeoCuFWNmH6jnGsN1YTAyQE3re0emvWKbLIcIM9fGorS/SS0GDYhHuD/3SQ0Iue2d4v3UDl5+j/e75mzyIsPol7sOnhdHkWg+2p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=USEsiuEE; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npoYF6Um+z/jjDjNJCf3Oc/EZM5ZZc1nvmSxG2QdmQPXUq/54be9WkTuhdQG5HWCmmlBxo7rPB4ZoORhdHsVm4wfUhBHDx4ptxJBMzNW9zzH9eo24eyRtwJDBfUcmMukCj2fuQ/xCWg4b8Jeh1H9VtckQpmC3/Bzcx93nKE2IVAwge2Vroy2OVXWSr2JiORoIth+UqpwIQ+THE7vgAWT82BsMjcvD9w+D23pnUYLca5w922ugCA0JHoOsdE3VSrcRJHKbfuBhgU+WeCtlJbOLBaQ8n5AocBrPBAKzKtnvqQd/iizffd5KDLIfXwBE8tSaWWS0zf4t79dDDXQpj7APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZEA/yK8cAdQjzieEjvLTRHT98sArIcgAPLpcEwCzjQ=;
 b=YIYQ3lACBi7+HzBhAfozeJw+3+12xw56uV32EJSZ3C2MKMIA1UioKCLbI78mjnYDDkk038g0c2jS3Jk0yIIqLt6tPKvnDV/CPslf8NO4aqEZBVJx2770qx9B2uDJhIhJr3rxNH0LJKqjgThJN5D1kIgCeqRFv71YXHRK/F12EEuxDpNKct8vAK+9QT7qFfbMTzNaqxyikPUPwcaE7j7EtutkdOnu/vLvUrukvkJYQ9NOi74rNLGf1ajWtcZVt/XKIt+KwXpJaTf8N+dTtuGOIBZIgktwdV/tHwDaUPgJj8av/RVdAT0DgE0kaD2Fle0EA5TAeEeL+66yx2O9f1F0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZEA/yK8cAdQjzieEjvLTRHT98sArIcgAPLpcEwCzjQ=;
 b=USEsiuEELU1LFuRDEKZKxjex0pqiTTA+S/yteafCldVujoEaqX69skVbjnl05tZ1j/Kh6qIjy5D2Xcbw/qKBkpKoIWdsM1+eWY/Brh3jZiKyQkPnjbwNoFGWEN4mxBnv8WZj0Gr25QVDk4cLbGJCzxYdqlWpwKkQznCn53MCvsf7suHvXzmCXIq+YNWNTufs2hbl16Coez/n2lB1WqFNgeKgD9n+FrspR+1uaNeOjP8a8DpkJDGGmw/qoCLo5P4sp/57XqISYssrBBfFtvRH4vUWPWx8Td3YNOvnmbgczXYIaeDeKamlvFNuCSwQCf2ePHMsN31npnXxwMqldmRI3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6256.apcprd06.prod.outlook.com (2603:1096:101:f2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 11:46:00 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:45:59 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v3 2/3] cpufreq: powernow: Use int type to store negative error codes
Date: Tue,  2 Sep 2025 19:45:43 +0800
Message-Id: <20250902114545.651661-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902114545.651661-1-rongqianfeng@vivo.com>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3df799af-383c-4ac7-b057-08ddea164955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UVsvTnL/2NHK8Y62ZEXdgx1Dybv+u+SfujaNsrCVSknV1VeDbA96ISq0w6j?=
 =?us-ascii?Q?dQzmzdH4LFlZob8DF7RQMbcku7gs15127b+HbPZ3TQAbr+zWFnHaMAxK/+5Q?=
 =?us-ascii?Q?I49OOvTunqzqAF3mlPT/9qfce23YFD0XfISKXtk/5DO7BH65cUwwLqURLW4k?=
 =?us-ascii?Q?aO4BNr7UdhioLMIlSQVrq3A+kizHztngkhgWq0KaomPlbffhmMbp62gV9bux?=
 =?us-ascii?Q?FVQ/goUog/vZeuonFusQ9p5jzcMirNG7HNObolB+O50m3rUuJGoijuee+u0R?=
 =?us-ascii?Q?SqNUJzj9lcU2JChZYsPEqbA4EDwIi1ERZhWLNOm5vuvgvLAbODs5xKmt4UdA?=
 =?us-ascii?Q?u9vwRIB9h2AkWniuNevL7pOdyoQkM/q6QyajSsNJNoYMlv+PzDcTCKjWge/G?=
 =?us-ascii?Q?44gSH8oXy9MiNYk7QjmPUNplxpfPbO0D/eVI1jGIWwPoqBs0iKDlHt6uowuf?=
 =?us-ascii?Q?EZOBTpuR3U9AeLuEIsGUjfIk6wqjdEvs+6fx3gsOyd5nth1WnA8r/ul3bli4?=
 =?us-ascii?Q?R5+We5WGjVeJ0jfQAk5HuwfTRnoc41eNwYHsl4Be/G7lmxeRhwGcXpxdHJy7?=
 =?us-ascii?Q?zPdC6eMm+ZkwqPwCJZJQaYWEpaIsSvU8UNNaCZf2vuBDaAbwZ74p8Vx1+CNx?=
 =?us-ascii?Q?plEKb9Wip1K+ElfE2zXXDR/c6K4UoiQD5BpTgx+vwMDocEX06Xfad2s9F4HR?=
 =?us-ascii?Q?+Nb25ZySNuUu6hmXUzp6Hjtk+tVJjMPhvTpOykDDUyZu9vUqvyXXKQkJgU47?=
 =?us-ascii?Q?OiID889iedBt7IsADyHh/u9l7+1aQlgCYId5c4xkx8IL0FWjSushr+j1I/yU?=
 =?us-ascii?Q?0z1JAaDWQG7LMCPURm4KFg1/Sw57+M57y5tOBdOFbxFj8V74yjZHFVlQ7Wsc?=
 =?us-ascii?Q?XXpB8UcJ2UuNpBIzk9KZ0mStNCiXLagI3Q9i8Vph2CNy6fn+rpAaz/dC3ir9?=
 =?us-ascii?Q?kbqVtnjKQbiO3QdUU+B2m4UXsTYOB+w7xXEg9HwEeaPzdbTi/URXD67wfgAJ?=
 =?us-ascii?Q?blsQJBtZs3Y+zRr5H6e522X0+JGCs4mOyUSTBG+/Sx7wVOZB+Fz6B0Fk5B9a?=
 =?us-ascii?Q?sm45XfI68Xduckzebsy44fkOf+2M2pdJsw4gWiD+16tFnh8qsGAQrwOkT8yc?=
 =?us-ascii?Q?1F00g8y8rb7fdwJZuHnlFovd9cjYlxVueMN8EF0wI3l/qWheTdpmtfeECk5j?=
 =?us-ascii?Q?L8dA6QRFBdVXw7DVee/8R0JWWa43YouTd/Scjv/nvzl5Fd1kUz7/FaIrvXb7?=
 =?us-ascii?Q?i6WZsoNnwiwEo92ew619l5xf/rCKJbp6vASq8FtcHGGhMxHYIyKEqlFQIMSo?=
 =?us-ascii?Q?7pb6IQLdJabgrj28SH62z/hIQ98lPHZuCSgaek4diFON+bTaEeE0ad0hC/Q6?=
 =?us-ascii?Q?aa0V21MS+UqiBOmAxjg6IoEQsAkZgZ9j68ocdt3p+y+wlZPRqO9UFNIYKjfj?=
 =?us-ascii?Q?bLrbTAQNRtzi6k/InGaAagN5hgTF1kHuqe0ab03uA6HsaH+RR1lOfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lf03CfAp3OlAopNsAKHItGKlo/y18uZdfwT4RMjj3keI/aAFTrB6WNEHKgl9?=
 =?us-ascii?Q?m4Ia/qVqmtKr0iLPUO0fQNcSNpg5SUhFZ7Pz+gyUOm1ntb7SjBKLG95gyK+g?=
 =?us-ascii?Q?1HG1RxAHqbZJLl0UEWvXBLRIA2F776TS8EBWgrsoKx7JGKSOhByB7OdbpAAY?=
 =?us-ascii?Q?pTuXDMeaz8HPeI+2xy/iw0udhV29N1O3H0Nlx5rkCmBqhfvu5X97odRbQta6?=
 =?us-ascii?Q?cYMqCjoxityVRpB/NFFJMpTKlUY6HoEGT78A9ynwwFnpTmZuNSOhhRJqoLB0?=
 =?us-ascii?Q?8EYD2zqKrB/kkOsBl0N3fXKjHnkbxEtFn31ZUDpuaDTrrqzSHvk++PpfljEl?=
 =?us-ascii?Q?9aHUOdDiVYDu3goU5qrXwjtHHVAzgIWRpDkskNXov5mlAFcKYUvn8tRk1fzX?=
 =?us-ascii?Q?gKGEAO/qgplvL1hpM3HoSjHGusJdL1AzJ4srDm9lzyetYllQevzkN5EFKWmo?=
 =?us-ascii?Q?kKDB/hCFjnhLoyQQlSsNc1HXgU8R/p4ez9cDNZC9D9PMPwI3s3wk0qkxtGRv?=
 =?us-ascii?Q?9Wv/cdllCwmSLAaprGskzAVWa26v/Pg+SuTaDiGlabkHyg/SZ8017EE/ACtX?=
 =?us-ascii?Q?5oru1ca5R1AkgNhcYB046baoHT5aa2nX6rXlwj2I68dIvWNAlMWmlN2eG8xz?=
 =?us-ascii?Q?IChA/BcZbB6ycMizF/E8KU1NvYw019mg3NZSzcu41OC6yXpXBLYpBJCtVn/0?=
 =?us-ascii?Q?ErjKjWj85s7tflj7qB0evjwNOF8yG+I9/wTa4IMvz+gEeEhFO9vR9Cagj2+V?=
 =?us-ascii?Q?Xq0aQ47qiJYn1fj5wzMK4ye+kZCDyHpaXfK8Yrrr/c5b4fSqnYk11FVIbHgu?=
 =?us-ascii?Q?CnOzV0kFceYbmTYqPw5jO/LLzyj5ZdQH40spxGRardneRdCTvc8AXqZ6XZY7?=
 =?us-ascii?Q?AYbxqmU8asLO9eWHhAhv0VSTJwjHpjkZpvlmOge6l9Ix+9amBARbkQJwh5lB?=
 =?us-ascii?Q?K0e0a95fLt08ZWd4l9cQRcC93ji+L6YYqw+dgKYtukVZ/vvZOW3R+2Dkzdwx?=
 =?us-ascii?Q?ZbokJd0eyXBpKmTffxLVEohQ16R7V6CYjDuK8sZupRK8H6IrQprxy9lC/2Tk?=
 =?us-ascii?Q?OuhOmFKr2jr7bGeACpp+kci/BlgsQKeAhYUJ5SibHwRrUzAHA2kfSd38+QmS?=
 =?us-ascii?Q?Fomq1ugP5iizo0EkMVoqOrtuGNdgEL/c3C+TDu3yNi7bdFwVZjK7c3f9mLdl?=
 =?us-ascii?Q?XYWrE0WncTHsDr7bqRnzEl/ryYwWubS76QNrLGn5sHtqWjqEOGAKP6lfDpkh?=
 =?us-ascii?Q?lYSsi06hHJwLOxPMEuHJdpNue4PGOqwX1+uR1yoKhpOKLFeqou9QNuKTb2UQ?=
 =?us-ascii?Q?oPgJSlR+JLg2Z19WXEkKbHgl1Zw9L06CWk5zsNRBlW8xypEn5mfSG0dUWNPQ?=
 =?us-ascii?Q?sItKGLeaHEb9MkTrNgoptiG7Rd2VFDvXqAm75x7iAm07eXFn1otGLZ54HJFX?=
 =?us-ascii?Q?1fFb55ZvZJA0lI+gv5YGYE33HuqW6Psn9NOrQZtuFOxUGHuMTOg1lUEP5EVW?=
 =?us-ascii?Q?/1KCe3Cq/Ie+MNr3snalNkUEE0P/6cq2s8c99HLHbkNwwYaluNSxR6+o5ORI?=
 =?us-ascii?Q?uBkcrIXy8XDC3HcmcZETklef4Ky/XjPpY7PZQaH6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df799af-383c-4ac7-b057-08ddea164955
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:45:59.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zX0RocCS7NAovIWpOCVipZZYDMnVRaOIEi7ZNA8hf3LSEGItIqxJjE7dLkcX+GZSo8QFabxM95TK1PaYhA6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6256

In powernow_decode_bios(), the 'ret' variable stores either negative error
codes or zero returned by get_ranges(), so it needs to be changed to int
type.  However, since the 'ret' variable is only used once and can be
simplified to 'return get_ranges()', it is better to remove the 'ret'
variable.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
 drivers/cpufreq/powernow-k7.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..72430c3c5500 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
 	unsigned int i, j;
 	unsigned char *p;
 	unsigned int etuple;
-	unsigned int ret;
 
 	etuple = cpuid_eax(0x80000001);
 
@@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
 				    (startvid == pst->startvid)) {
 					print_pst_entry(pst, j);
 					p = (char *)pst + sizeof(*pst);
-					ret = get_ranges(p);
-					return ret;
+					return get_ranges(p);
 				} else {
 					unsigned int k;
 					p = (char *)pst + sizeof(*pst);
-- 
2.34.1


