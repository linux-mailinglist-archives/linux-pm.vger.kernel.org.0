Return-Path: <linux-pm+bounces-25346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78627A878BA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9503A558C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63D2580ED;
	Mon, 14 Apr 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RvTsITje"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E912580E2;
	Mon, 14 Apr 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615804; cv=fail; b=jsL2VykAi9dnCxE9JTi66ewwgGlGV6SEeQLFz4Qp5110Qjdp9ZjrwFhjeMlC52uu6Ij2cP736z1iza/HjrIuHNMu50CIzEWpa7LoAi9gPpSgboG30TjXirqNSFUy7UIFZ/t3jAAcIlzq56Gc9tSR/fTQXoaYNmiYZvMHdxe3o0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615804; c=relaxed/simple;
	bh=j9rmK+JF/+WyGOGexsbedMRO96VN8FfPpUCByn46kYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5fF161jP1S0i6H90nApRA4J6hmVAM/QDhatVz3YeMHJHEbPMuLEyI6qE0xRvR0SFdD/S7EltaS30Tyqikl22Yz/kiSL5y+O0DHBtvdCTVTy7PU7wMRQbbzdDg+DChMV0wimIZIcNAg33YP8SmmnEI3CIfNuKUvK1TJPVTTBdeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RvTsITje; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTI2noXXcpH3CwyXVPj5XR+Qvep1ZVMmQ5qGFdBrVD6VYwIO8O2A95kem8kuBGTTmbg3rHG9wUX5boSYaD8yMXwNSJJCeIx5PwvMl+fqR7AQ3Co8bXYzymZw5sWVsWDWpxSIXEZT3/tg7aw68B/Q7a7gOmj3UrtqzDNeKfLNocy6pGgVeTMTYgfW6ULV9T+RoD77XmU2yyqP3HYUolKjdBecBgnvanAsPPyaIagfw5iywI8lPID8x8YF4TxGDUVcTQafgi3p43cwG8580o6eoNXAYJxl1Myku1wPGABgX/lMiH7BJ66xq/K1kFdUJ4uxuCwJPQN3R2d+gxt0qQ0Jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9o0jXCE5hD4daEBKAOIGXyiE+qpD7JfaS2c+IxirS8=;
 b=LtQQ2mkRvjs18Ewb6D+glwNxaCwny2xY/x3ms+I4xhHvE3dvVKWTa3VzXQ9X+OU9UPOkeP0UEZb15a+HHZNI7TMdt/RmRUE+bR+SGHiZ1Eqq70g/v9V42j0LI5jKEhjVsWg89hWDUaqxmhjlxhMQBWBUrWlfleR/46/6GslZ6DPcWd5gVvbviwLSHiFtOFvxa5uCW2exvgIpdXwRGXeTmB8jQfizpuPN1QEv162SaYLTRqpJ7OgAhdDFeJoJ5Es2kXGnJLG28oJ211NBld44PQjQ8gV7XqD/eSz4f9AgJOaCQyy9vj0qvUijtn9DiUK5n9Dt0BpmyDpY3VVIqhqKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9o0jXCE5hD4daEBKAOIGXyiE+qpD7JfaS2c+IxirS8=;
 b=RvTsITjeuuIjaMT5jiyEbbyQ9J7wdqbH2Zk+oId//CUxJjJVxDbCMF2QwIAt6xXzZPnvYAzZA6ef+d0QXn4GwXePZ5o3vz5pTFxiNNt4m6MZo7X33MEhTcsya1FoXwMS0ldWlYq4iRalHvUoOimrxitSTsxx4jxc+i11BOQQnscDJsjr4Fy4KFy0B48nCYbXZIdjOtCoeXnjEj6xXUt/pYmhZAkt/DBY6raBTj69cPGrgFOm2llzN++7FwoGueMRs9MYUk3CNRKZQNGVwd6ofHkziQcmP19HQqzj4xzBbtbaKULeEKkwPbD7slod1US2N6YDgN2RP/xhBeBaTFkKcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 07:29:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 07:29:59 +0000
Date: Mon, 14 Apr 2025 16:38:32 +0800
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
Message-ID: <20250414083832.GA19563@nxa18884-linux>
References: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: ef84eed6-58c0-4c1c-f4f8-08dd7b262947
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUapr7E8/1ngRYu8T3VZBAv/FrL2H5TPnEIpXOeDhiS2jocDOWgOUvPiTNfi?=
 =?us-ascii?Q?cQa4u6/HkqZ/Yop2iStocgyWVMb7Ksvl8nxEib5dlUpKB/DLGEa3gDhq2Z77?=
 =?us-ascii?Q?vMyzPENp0S8inwMhncl+NkM5hiPiRLZzJGo3IZNwpI0ZaccdLNsBQTKgyS0r?=
 =?us-ascii?Q?c7VUsl9GSImituiwl7sWpZ9OiipmDgohuQGISAHuhus9h5tZVpsGDEX7opYZ?=
 =?us-ascii?Q?emjTif3+pqdFqjay36t/54CCghv6beiCtFWDw09JDSGBWpu96aYVSH2EKRLe?=
 =?us-ascii?Q?BTkwavNg3nuJe6PwZnkEbcmJv2rFE3uOlsC4QmysVgfg0m/KhZIQaQEWsMqU?=
 =?us-ascii?Q?LKuEmrjQXsf6o4D7PYfgJNoUyN806Smf92GdNDPyW4NwhiGBAKTdqlMeqCj1?=
 =?us-ascii?Q?k9KytVFaYkexjYD2MCP8UGR5TEJ0l0uDwYOUWqt+IKuqNco64w/hqFKCmQjh?=
 =?us-ascii?Q?yyfn+C+IOFFFeRxUkSyWULwKFz0+/b1MpeL+6nhlXLQqorv6h63PsDCOrFzm?=
 =?us-ascii?Q?8n3ssacsoqLsAQ/9HV576wxZBcrNqR05Mn3NR1cVUFz/AUQv0+zsx9Fw/FhP?=
 =?us-ascii?Q?JDH/vForzlx2Uq1jNX7oz0m+3snw6EpJ0b+TFDrPthESmKMmHd7PITiYY73C?=
 =?us-ascii?Q?hS5MFueq6RHNOFxrmmeQJ3awro2FSL89jk9G58S8IWgFLQwRJAx22eFn8yP9?=
 =?us-ascii?Q?oPxeMlJVuBTh4+oh9cB46IfcDEvu1+EccWdMC+J0uQ+MPPIzDAH9SeJyzK/T?=
 =?us-ascii?Q?dTNkq/ZgmtKJLavenYJLW1aXA/UnhWlbiNS+o0GDJbamrvplLDCMZB3G9T1y?=
 =?us-ascii?Q?HzdWxFw77qyj9+j7/Lk5i9SpGHnDrwVGa+T0Nla3aJHxwvkdncMXDMljtCvq?=
 =?us-ascii?Q?o1u/JlAbfLWgBCTV7jt5eM7A2PpfL8l8C3Ar6A2mHKsvIJOF2fQ6lbzGkZPU?=
 =?us-ascii?Q?XwqPIECYTTlMnLs6VWS0jCC8VSj6PHZYGxu0nS9OYFv7nuToznLUHZsguUHj?=
 =?us-ascii?Q?4fVE8ArmSZBQ0tGfCZ2CGp2kdEUUjP+iz6Fq6OgKkBLiM+0jSrPoH0Xe1rus?=
 =?us-ascii?Q?Nlae2CmCbzOjWSCAcHAJSKLl094DC42dHWBIGOmpowt7RtfujNATwmTGAiWL?=
 =?us-ascii?Q?wTtDCDx5bqPGBXnsjNXFjXfDgBquDZFwySGo1Nz+FDcsa81NaTgb7gPoTVwA?=
 =?us-ascii?Q?CXNSQzxmFNr5ioDzoTW+v4E96a4Ct44hkqKxJ6cvpuUk1uwq6dG0U22vMIRW?=
 =?us-ascii?Q?Y4vvNyebd8zFkHcUK45ZPFkLWHJ7qhvP6aLLibiX29QNMBU+BHAXbpnaDplW?=
 =?us-ascii?Q?UgNRtnHNVow3/xkzjZPSJiw2SJGZtzZjVmcbh2sc2qGVpWBp16kgmnXJkSaA?=
 =?us-ascii?Q?vJTjtwkISHHajsoy6nyPU6oPDXaWo7v1r9RFral9XkO1RaQxx+m4g7HneWSB?=
 =?us-ascii?Q?8NAuKVVj6cAWEzjz7kkC1AYIRVkHGaaz95x99ehbrq4BKkmu2VCRyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBLaYWOzeCcyBkctEsgBBzyexYFgdgCmbvDiOgb4bCeVPsiHnCy+XpBm61iP?=
 =?us-ascii?Q?KW529Cah6pjWP4rNzZqVPyYYsq/fQJjGQplzoMa3OOEpwrs/whHFfgI5UI8O?=
 =?us-ascii?Q?CdsBuPAZg+Xp+0zvVYFolah0I3YDGnF89928A1a6i45lE1w55NrEL6eZukFB?=
 =?us-ascii?Q?vjgPIvZ7X8ienzclU0E34ArMsmgBKxKwyCBe7Am7ZSjzcsgydZkifnFDfSTm?=
 =?us-ascii?Q?WjG9eMXKz5uEdbZzX8gHHF/6BZtsmChv+OQqN7Aoj47klYGLQxEADzhBbK0s?=
 =?us-ascii?Q?wUUF2vzunmXdlbbYQ3apLR9DXkR3tbeWFth1rgwbmSlRKm/XARDyGCNNZVKO?=
 =?us-ascii?Q?TtZ1u074XTK3lW4CPGjc3jAYWkSpp/a+egCQ1meRNHrEo05sdvvDyGSykbj2?=
 =?us-ascii?Q?pvy8OrCOn3wCyAX+NeZNBPy2O1vQ2CDkPtpaR2jdzmtuWcTFVdBOOGzB/DvB?=
 =?us-ascii?Q?LhkNj54hkbMsvXGtjqi1y/6fjh3XjOCWdwKlJOqKQrYwplQwmKwq9NlCHWV8?=
 =?us-ascii?Q?/yy1QTi6EUHscRYhXPxb+UzFt6ZWMRJe7kCGE4z4oeWu4R/x/0ES44s+LdaJ?=
 =?us-ascii?Q?L5jt4q1fQQqlzZ6fG4yzELZlviaAQrRG+qnEdYexReONyRPa9JvqbmKeGJam?=
 =?us-ascii?Q?0WbFMbpR4jF6VmBj2auHhWyAf5/mPtl8wuLKwRYPYIPs2xs4ODG92t3tMBqN?=
 =?us-ascii?Q?wux2H7ukOfrhKaGE8Tb2jZ5vA3EW1m9UKaa+YfM4ZhcZg1Wv0qyUtgTsAske?=
 =?us-ascii?Q?jfwUbc3ToiiK3/v/P1zNnDrp0B3cb7u2HzOo9Xu++pQx7zRS45Br+CAnHvWZ?=
 =?us-ascii?Q?aEGrebQqS5lhx3d9JAI82wGVbQIq5ivqoIcQfVPMpnBK8R8ajkqNTWPFZgkL?=
 =?us-ascii?Q?kGsTMgrPFwj7sz1gVlgLtUqnnUxPllT3AazHjoSMFL5F3D6OGeW96WYR9Le8?=
 =?us-ascii?Q?tHY0idvCbhpI7EFR8IA10yG8+nfanCp3GXVfGgvC9hH8HbD0tQuOH0m4IG0N?=
 =?us-ascii?Q?hP1rrx5RpCkc7miuPum6vvHiJe6izBQAzA26Y/cYLdw4jxqkzrMgAJ042So/?=
 =?us-ascii?Q?KM5GI13RipGHAPY7bzD0xCDukjIN032/98k5fyXDPVZkuBy+bTy2e/PcgQBs?=
 =?us-ascii?Q?I9FMjUHJVFDGGb0mv1fCv8/qEe3O3YqPfKk+48yZTJBNunFRLRjvW64oJk3z?=
 =?us-ascii?Q?er1tYdeEhM+J5V0ZuQ1RldSqbMMlg++ZnitGiHcw+Dp1XXDpfc81zErXxpNh?=
 =?us-ascii?Q?vqWR9hafpNp7oo4hRqn40scSkyMxNDNslpXLSNi5YSYVYIV4OqKJ/IS+m2ki?=
 =?us-ascii?Q?5zGie8tVcB0C/R+k+EeBQK+uPl9ABPIPQ5hRmyaNzusF/6MeTWWshjh5ig9Y?=
 =?us-ascii?Q?G7UmSSaTCTnTHigjoYe0bjkPhsEc4M5Xx149majuxFgEW/pj6JuOX6jey1IG?=
 =?us-ascii?Q?lW169B8JJGmTjiThr+8Jql2eNbPFjUF9moIM82ylkUAAi/EV6N56mlepAzGu?=
 =?us-ascii?Q?APAbzsZD6o3veGzrAsuJVCyGy2hvIGcACGvgKS5vR082mzmop9SQDebQTMR4?=
 =?us-ascii?Q?q0Z1gD+2LjvODA9i+yKib0bBiL5AxAbbgo1BooWz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef84eed6-58c0-4c1c-f4f8-08dd7b262947
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 07:29:59.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLq9O1TREi7ntmsJdM8RfvBArbwX00QwIA0QTbWytRrQXhxnGxPhwUmNBQz6D//9DPTDwbndHqRCOEQcPgVdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

Hi Mike,
On Fri, Apr 11, 2025 at 02:29:41PM -0700, Mike Tipton wrote:
>Currently, all SCMI devices with performance domains attempt to register
>a cpufreq driver,

The scmi cpufreq device is created based on entry
{ SCMI_PROTOCOL_PERF, "cpufreq" },

So the scmi-cpufreq driver could only probe the upper single device.

How could the driver work with all SCMI devices with performance domains?

THanks,
Peng

even if their performance domains aren't used to
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
>+
> 	scmi_cpufreq_driver.driver_data = sdev;
> 
> 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>-- 
>2.34.1
>

