Return-Path: <linux-pm+bounces-25433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E1A895CE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571043A257C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A21AF0D0;
	Tue, 15 Apr 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rHB15JSn"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D471F4ED;
	Tue, 15 Apr 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703904; cv=fail; b=Jr6FF2OhUsu5brLj3wxqcaIxMrsrBQkfiitUiL3nS5VMVEwSSenHJ3jtvw2YdplxNUWsH5cBDPtpT8wTS88R/XB85WlXbR21GLxh19G1i20fbc/ZHC8DlyBuW3pRH8AS/uCFQt4KznaEKIaZjE9q9XbEUnHI/Fse3do1OPdqW4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703904; c=relaxed/simple;
	bh=mwpdrCIZoS4TtedKIF30LKFTek7PD48CK03TAEpuPJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MBzlNdHVYXGTsXUPaqeR8fruGZxjOxtunPFQ6fsufzn0nx4rFPvG+UZVAjIcnvTbZa5uQOvciec6OGf26doU4PxQOiN0ipNLGuyvxedthjy4HbdpxzPdiQAF9EkGPzN2CATlv0VNR9phHo3jjmiXp/wFWclKgJFP9SnrVdu92Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rHB15JSn; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+WS+POG2NNXKtXKjKKKX6aaHNJ+YKSbI7cLK/0/3bYtANZ63IZv4U+KZNNjT142eq6ytSMDzAy42Ah3J42dxktRNU/QRB46RWyycREfXlEBavYLmW9N4m9M2ABPGbM28OUZLh6MuPLSVZqIHGptWlf3w+dJ/FA69z0euphPkI6mYs10QH6baKVTTSX9A0kDAWIueBpDIg5/F7AsCk0p+FjHXX3l9fOOjbhCd/wLdhKGUyFZ9q3xKElVHzZ+Ti1kWf1WDwQcHhQ8luWo3HBcv73dtUl7dek96MNT/MUhoMGqdY2Ej43PegtebMOZBnMto7wZVo+1rNPIVTqU8SvQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ijQWC+Rxs2R5StYO1/Re8pE44TDLTKyv3nd/BXaltQ=;
 b=P8M6Uttf1kQ1magQdPnWM7FJGQf2hR79lDHkfRz/pvFbRTrT/R+iSqjCuwDa6PItgbNRy2ByO0zqKwUP04UnBMqkXTr15/6nlCykfcOFCeUAoDsBB7egvd/arIT5aZA+b1X8Bdt6mOv//g4yOWrTOxMxP9FqYuECMgEv21Am0yyW4vJbvUVLJojD8wyHaDNgBOj1Gx+d0WGVEwdT5yCdsiNkS87u1wJ6JKtcqxk2AI4IhGxJMQP8SB+S7VsQ4WEjYC20UifdtflN/qAntA2Z6+83mVukviavFhhFIwlFWIZPJWMGlJLh6pnXYJqewIsUcS1UGNfkp98AlLoxEy7yrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ijQWC+Rxs2R5StYO1/Re8pE44TDLTKyv3nd/BXaltQ=;
 b=rHB15JSn4AIUL4HV7b5y0VNji8QfUwx52JtMqgaxKF2hemkxnsQVPM3dEJb36IdVm1ytqat0yu8RHnO8BDkmqg09Jh7/i22G5mAELILsUGez5msQip/3noouZziD7D6ZwT6k1EMX3ndnJKfekgD0CLqWXdE/U6mZNGFv6wwqnEZQTnoYZVyBpCcAyJSMlNBpbQC3gS5L0aUhuGo8CrI5KSC6BgNnRvgLX42z8wjQNR+GfoScSJ++BAzezizUohT4+cpJM+zHMQbhDVeUiRt/8SLr7otSCC0jjEULmIbC+hbBcGCzPYhHLS1CT9TUpPAbBkcPnsM+ei54yFoTyzSWfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 07:58:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 07:58:19 +0000
Date: Tue, 15 Apr 2025 17:06:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Skip SCMI devices that aren't used by the
 CPUs
Message-ID: <20250415090655.GA10243@nxa18884-linux>
References: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: a23f85ff-7344-4e79-694a-08dd7bf348e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTPqnHZ74BSbjxos+mA/r6Gchoe33eEgMDT5C42RNILEY1dZX9s0wKBr14pI?=
 =?us-ascii?Q?eEv5zkBMtzIcB3r25iC8NhSGTf+SjFYdLlFNP230tvdIy1eyTt1zB0ecpDkS?=
 =?us-ascii?Q?aqmUT/ZihkbPOdRaLrjmZ79Pe8aKaxVhgjMhBOBTcJZnMFiumtwGmXPuyIrb?=
 =?us-ascii?Q?gy9EYjOrU9UPULWFzK8+hyV3k6o+iARzldRPafviFHtIezbU/MvD+N0kilUe?=
 =?us-ascii?Q?9cSWw7TE/i+UePIWWgbN0T10AeOzo3Zp5A+lD3T9nsqVMLMRsFyMboqVFFc6?=
 =?us-ascii?Q?caU4maxjn+Ns0sspS5n7EN8f03G6bGSdYSnNXC0HRNfENxHoZz7abdI6Br3h?=
 =?us-ascii?Q?uQ3APzwjTcalbbS6d4q0s0u10RrM1s+jIVT/X5s/CEiKpLcGlLggGBE+uGnf?=
 =?us-ascii?Q?KSD1tkNvH9fWl0WUAyUU4Clzzae8wNpVedCJ0Kb4aaHQwfWXsRtQPs+ZUyC1?=
 =?us-ascii?Q?goq9UTmYEB+WrJf7C//AGL5TxsD+i47Hw/Wrd1nwUO5wytY1kbONS4lTUm9W?=
 =?us-ascii?Q?bYZNOXNcL3P082OGj1+Xe70X9GZR5zfOW76wHT9HtfZniKBnlTYq8IAKov0M?=
 =?us-ascii?Q?CtnVNuv4S7cQVfj6awUHQ4P5Zq4WsyrgqpZ/dFl/0FoDYSSaEyOGurXgzv51?=
 =?us-ascii?Q?mjTNDLnrMEatQyy3kj9QQ7tA8PnY0tryLyuCVxePe4+YZ4Gk1J7cu7gQw1Ps?=
 =?us-ascii?Q?Yl1lPzzjuAzcQRuABuqlKSkuWhOGxrvl7q9ihkjxUkra8/WET03Qs73vOMom?=
 =?us-ascii?Q?U0w+YvILP8XfuB0qs23oGGdiapcjSpeda1/V33sMHu1FgAcC+JYDk+CdGdYL?=
 =?us-ascii?Q?5k3vd6Ua7I079uHkULlQfohGBmd37kMFMCI8liPyGgZOP9IkMA7rcsVrkt+e?=
 =?us-ascii?Q?5hjtKOebMUFJfywaqGKJ5ukrirS7otIPPt3Cv3+lQHxTR18/49whpTxciCeH?=
 =?us-ascii?Q?9gwSywwdUO/bpe3qrBk8hwRFpEFU68XNRsnnhzFr58WC8ITrVnoe1Xj+PgZ3?=
 =?us-ascii?Q?HMSKqho+nq1lkkpWG30e7Cx9pUrioz5f1E0X0oC59+bghQl+JIeDBZPxBf+Q?=
 =?us-ascii?Q?0E7scFFhLqX7SX/3+ZAEdSqjviXiKtuVecuqJUQKHY4H4vPvcT7TVM+ThjKZ?=
 =?us-ascii?Q?DAm369IaT6vVu4S/J5FFSTUpyUUTXJbZarP7DWZlff7UsBsbsrG+/RPakHav?=
 =?us-ascii?Q?3fGyZyNHBrfpLqRP42ILQnDkBRWBCCf3Lb4u1H4MvcS2YhodromKvEScnXSu?=
 =?us-ascii?Q?tRppOoNml0UNJy1yeBiEGWKyJLrUYR7tRpEJtGibelwIXmaHP7V1FvLEz9Kt?=
 =?us-ascii?Q?Jq1RYHX7q0uglVyLKTpLHXYkmbKpBT/hnRTUyV/uhAzditq4N7VimhRCsZhW?=
 =?us-ascii?Q?nmxAJ1HjOryCg5gaEaVZMzi8OP5EDID5SBPxfBHHGbqge6HfoFmO2UbAt1iK?=
 =?us-ascii?Q?ahMT2io7mA3y/Q1i56SHsbvk/m+JWXSoeI4L9W2avWtt6GXwYq1LWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mtglxv8p6Kj3vApMzF7YSu7vyyOhG/ryt2WLLoHHH3eEhTSNyLAINkfjtrEO?=
 =?us-ascii?Q?tqZzBMcjm3ThNn++SRscmiBK4IjrdWTzb4x+mK9Bs7ReRY/pT/ENC5GelzhX?=
 =?us-ascii?Q?JwGbhz2qbKUEWH5TX/WB9VVbMo0sTEb8IP6dP+/EpwdMimVupNFGOLSHIpWe?=
 =?us-ascii?Q?S3tI2BYJ1uuPNP7ZaU0+lDXfCRq0pgsc3iqPAnCjDYxYZ6P4WaUeGWzCbK52?=
 =?us-ascii?Q?RRVc+QW4W3AsLrkLpx+vLvbtfA45GevTLXPab3a4+8HaBSinw4owBkKAHIEd?=
 =?us-ascii?Q?TTdvip0aZBtVMrAx6JQi+H5O7vutEc5WEO7IB3SSpCpuTQi3PW4Ct37KKBFF?=
 =?us-ascii?Q?JUeMOpbO2cVT2oy7IAhlS4i4KfXIAR1HeKGTMWDADBGgekv5QwYubVUi09s+?=
 =?us-ascii?Q?+Tw41foRkX3V9zhDbgR5CjsfCneKd683xPID8sNkLyX2QNfmFSfiPDVQB9/m?=
 =?us-ascii?Q?JexACTatIljT6OCeZW96v7BgSxjoDR6Q35gMxv5SvFev/Phy9SHLi6132m8Q?=
 =?us-ascii?Q?YJDv8LtRdYx2f3mxcAI/SiWRGqtI2xdhim9lSHIplgOEvzO4QBwPYsWzxi5i?=
 =?us-ascii?Q?R4Yxfby5h0etRtWbTEYzK9aUMkyP8gfNME8JV7QgJofpFY6mHTdm7Ql9aP6i?=
 =?us-ascii?Q?v1ZWTtT5FDZwopC9WzRxTCnuLn4xsMnNCVijI6/IhiSJb315xk3OWMIFDniT?=
 =?us-ascii?Q?3eJox1fIioABTUvLb7jFR8fM1Z3TjrX/BB2CGHKQKd+RMb2s0OODOD2kcf/y?=
 =?us-ascii?Q?as0ZJe5U177FsbDyHkaarLFA5XDy4BTOq92d87vvG6Vp8qC0i/z2MaPJQbC5?=
 =?us-ascii?Q?PSqk9IGmKis/h5KKHjMgEfCWBEtKM/zV3aL4tiM5rW9mIkReruJeDxS/qmcE?=
 =?us-ascii?Q?A8jhs0mw5t09JFMR85K0GTMYxpZ4pTKAQ7CFPNanFypG9bn8IF3nq1EYbSZd?=
 =?us-ascii?Q?YA/eFccQUvv2hl4akxQCUVDdmjTQaPwm1EMlf22JTCDVTAzdnd/y8/fB+dHC?=
 =?us-ascii?Q?h7UjoWxSrJ087axWhFwCPD7B1rHQiYVQKNLa44LmI4w2dYdQQED5/S9OG5RR?=
 =?us-ascii?Q?7D1YH10FnpINHMurYgy8PjqAs0DsS+1JPQv9E1Aaq4hbMOCHAW/xz8QW+8pv?=
 =?us-ascii?Q?3lBIqJboEW2fXV8vl9c7suLhJTAJ1BR78utCrta0zAvr0DUJ+f+2PynZvvst?=
 =?us-ascii?Q?1NQL9QYNLbsljHimp/Ue8pBgwx02uQpGE6CKqYcqxUDEJfW4nUz95jvYgp3i?=
 =?us-ascii?Q?VNCPm5dCqSXmEQqdjLvbx9DVbwJSYFpNmf761WF5/vtVM3yCe44IlmLGtWsB?=
 =?us-ascii?Q?k/oPCI5t/XXIpm5nF+kJ38YfMU6pPDbn36ZrFSHC3MBpSIlUwnLDi0gidPCa?=
 =?us-ascii?Q?RivVZ6oeE/bjxB7XO2bbnMrBLQGY0B38/8QPxpPUi/8MA22DnHZf57sjv7zF?=
 =?us-ascii?Q?6Lcocz0R4ShQKd0IYwpMV6jWKlFLV+o0C5VYu/NNPkmJiN8QFj0WWLonIOpL?=
 =?us-ascii?Q?Ii45ROPE2pApJJByVek6pHrPmGkKR51h9V7FTU5jlElKtI+82Xsk2OsCL32u?=
 =?us-ascii?Q?3DZMDTswu+TiO+FMjglFc4glZy9CsgmQMyfD3tev?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23f85ff-7344-4e79-694a-08dd7bf348e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:58:19.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSCPr/G5oNFGrM6wDUGmETYmChRv1UsTy3jTCCnBrg5VyKEC3XuKO+4SonHT4ai7TL6VUrcEHBHNaTd5vOWmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8274

On Fri, Apr 11, 2025 at 02:29:41PM -0700, Mike Tipton wrote:
>Currently, all SCMI devices with performance domains attempt to register
>a cpufreq driver, even if their performance domains aren't used to
>control the CPUs. The cpufreq framework only supports registering a
>single driver, so only the first device will succeed. And if that device
>isn't used for the CPUs, then cpufreq will scale the wrong domains.
>
>To avoid this, return early from scmi_cpufreq_probe() if the probing
>SCMI device isn't referenced by the CPU device phandles.
>
>This keeps the existing assumption that all CPUs are controlled by a
>single SCMI device.
>
>Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
>---
> drivers/cpufreq/scmi-cpufreq.c | 29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
>
>diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>index 944e899eb1be..7981a879974b 100644
>--- a/drivers/cpufreq/scmi-cpufreq.c
>+++ b/drivers/cpufreq/scmi-cpufreq.c
>@@ -393,6 +393,32 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
> 	.set_boost	= cpufreq_boost_set_sw,
> };
> 
>+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
>+{
>+	struct device_node *scmi_np = scmi_dev->of_node;
>+	struct device_node *np;
>+	struct device *cpu_dev;
>+	int cpu, idx;
>+
>+	for_each_possible_cpu(cpu) {
>+		cpu_dev = get_cpu_device(cpu);
>+		if (!cpu_dev)
>+			continue;
>+
>+		np = cpu_dev->of_node;
>+
>+		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
>+			return true;
>+
>+		idx = of_property_match_string(np, "power-domain-names", "perf");
>+
>+		if (of_parse_phandle(np, "power-domains", idx) == scmi_np)
>+			return true;
>+	}
>+
>+	return false;
>+}
>+
> static int scmi_cpufreq_probe(struct scmi_device *sdev)
> {
> 	int ret;
>@@ -404,6 +430,9 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
> 	if (!handle)
> 		return -ENODEV;
> 
>+	if (!scmi_dev_used_by_cpus(dev))
>+		return 0;

Should 'return -ENOTSUPP' be used here?
There is no need to mark the probe success.

Regards,
Peng

>+
> 	scmi_cpufreq_driver.driver_data = sdev;
> 
> 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>-- 
>2.34.1
>

