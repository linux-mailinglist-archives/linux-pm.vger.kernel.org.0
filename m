Return-Path: <linux-pm+bounces-18075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131E9D89B5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BDBB37389
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6A1B0F1F;
	Mon, 25 Nov 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AgFEFGHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB918F2DB;
	Mon, 25 Nov 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545411; cv=fail; b=SMRBcjo+oOtG70IBrMRxQsVx/k0PBUZs6bf0mhs3kCqdO565PFDH6Q69vSZG3ZOHaX3bXXGL2oatJmfMLQ3Ku3j10oAiJG0zY+FM4nGSWy3N9fT6KYp4EIVBfDx0p93uiEXDCWzNTfTZ6hHU5BWoLL5AGfNpjwFGIcn+Yf75NdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545411; c=relaxed/simple;
	bh=bm8OmwIdmxC3ykWpRvHHqxTELSvZTs3uaNGvi1VPwHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBiUtdhntqrcQkpGPn02E1h+PveuXs9Ew60rPxVivIPOVC51zxkrfamKosxltwVx0gLu+RJRlMWtNc+cGiHpidVSxaAjHz7pm7TaYR9e7LEL9ZBJ2sBX4bILdWNKIHwKKrsaAwE5bi5AqLvJYFqYSdxv1vyH0XtClVXTK9C+520=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AgFEFGHN; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/zq/F6v4mKAABjmlL7/b19sdcupFoIj7qYjpiv9i6rJGO6Xpbpdd9fAW36qG4Ynqihzfa2nVkrXfkM6SSh0P+4rSZ/HW2zPAOZJ9hvpCdkxyOSg4hNA0jCsI8xLwxTMhKlM80pozLE6zh86gnRWMvzeChOPHPVtIrfFULqNZZoUMuhT+iLOLGy0V5AjSnikFYlXThqsvTqrdBxYaHxL0y/EPZ8HEedlhBXiD4tYqpmCQ4r6pxZWsQDkyE3R2r1naWCXLx1HPRxHcMifmgXJ4Jlms7wOFDrv2q8fgCVs9Nu/grCoekjVf7+As0M/+grlEPGTwsHISHdPLehhURSScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nht07RCaikevE6SKvkpMZI6AEcXBhmjton85hIM1go=;
 b=epkIsXcTwXdfAy7X4ZLPtdRv6m7ejh7VexgIIidHnTwAJezwYpSlA21/fwSPK4C5dak5bHV8eHLZ90FEiGNwi2MgPq12Jw+qpZXLnz3AmgPOiW6jOu5aZs/y6xFMSaER8TjE/AcO9URts5p6loxOtqOQJw1o7n+vMrX/12mM49DbDoNUfY4i9EieXT86RFmWoRqyCuDD0GFCGJjpY49ua3u/ovZlkuVRkIno9r+gARpvk8Yx54kPeaB1oMbUkgtF8ZGZHaKpN/80qQPzekUWyFusq084rwBWKnurc9VzDXf4EJ2pYxR/3DJ8rcCvunjmpP/AiIhgi+1+HezTjTQbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nht07RCaikevE6SKvkpMZI6AEcXBhmjton85hIM1go=;
 b=AgFEFGHN0lkqbCLhfAPMV60LXMOHpPdwFmlsJigUcnye4xYyXLZlDi6pkSX3F5I/1QYnI5decc086rW6iYTbe0lgdf7nLKxMntB6J2+BMHUd8pbR94bGho3hlGlVGTYhdxzGcR1lB+KtwSBfNemxJKDDLcFhchKMu9Z1IXk2o3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 14:36:46 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Mon, 25 Nov 2024
 14:36:46 +0000
Date: Mon, 25 Nov 2024 20:06:35 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v4 3/8] ACPI: processor_idle: Use
 acpi_idle_play_dead() for all C-states
Message-ID: <Z0SLc62MwM/4E3aa@BLRRASHENOY1.amd.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e981489-9e23-4b55-620d-08dd0d5e9667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N5ujF9HWCIF9twXGFMWWa/euRi5du9pLgPuv8CGgAkild3be+N+zJjipkDg4?=
 =?us-ascii?Q?LrMpT0zy6WdCCio5bkMfm6DYvnYIPPzlXBIddzFUK3zUnixNCYYqFd/ciDSH?=
 =?us-ascii?Q?dMWlCgj/xrfbT7QRYOXoMf/fM5Pq7rirbl9khTG8LJXbtIa0q4R+NAWbnGQX?=
 =?us-ascii?Q?EqIBi8B6TL4NIJrMovSVqbPMNLKWTdmy9o4S4dKUbB4V4dAi5y71vW+OSiVe?=
 =?us-ascii?Q?KeT1EQgAOHus9pqsAfrNgkLwsCL965r68osK1p6nubC4u8snNtzK0MXsqwJp?=
 =?us-ascii?Q?Q7g3kVnjARigXAzR7u+AsBbHq+V+tOL42kBZoBlC0KpYBeJYT0ZE04MQHgH5?=
 =?us-ascii?Q?ZONQQ7CgFg23GfIlIGLJFREOstxnRHAEymetJDzWe0NZJRXha1urXJdmhcrD?=
 =?us-ascii?Q?9PtaLBlJGsjKBCh70fYpkARVs2pUf54oFCmj+GbKHh7X25It8QCrQX7ppZ4a?=
 =?us-ascii?Q?U3eErbyu+thRqpvSim9uzLh7BDg9DzJ77YWt5Ev+wA76iwirOzDS/3vcEufa?=
 =?us-ascii?Q?6rSbRl/iDj4v+nA0aUE7iJk1Gr60It3+tTeFuCS+FhfXgU6YJEEceBl8FLn3?=
 =?us-ascii?Q?4I+5RJc1RmXijiQ7wmPCE8Mj/ykbcBVlRofbGzFhlU2cyx8pl/UJQ01VvO5c?=
 =?us-ascii?Q?Y7i36+nrzP2hdXj3wWjqrOooWA6RXRRakqGIu4R54a0oQ5t82kCLzOdnx6g8?=
 =?us-ascii?Q?Dg1h4bX/JXwvLZwOgN4LdfVzLSLEpH4OeGn3Xs/qfuG059fP9UPcCmHjXnlc?=
 =?us-ascii?Q?JJu5CxuTpqsyTH4HGthvsVEFNMbALw/EkBQyKBGgsPMlzOiYM26zCypq5o2K?=
 =?us-ascii?Q?hVASWX2lSWa0XwECZs0hGryniNdpkV4G2vulAKvP3QYFO0YeM1Vfqx0zJXUY?=
 =?us-ascii?Q?FxQma+Dv3NGT0cynxzpqn2LbV69LIalX74z7rGPcjRaVt2LJ6rdtccIXf1jK?=
 =?us-ascii?Q?2J4JQ5XaEyGHoF19OJYEH8LQ0VTZxqkwzf3aKO0Ao//vyUAom5ytXKB7cQxa?=
 =?us-ascii?Q?vWbLrjqw3KUo+Zcnnw3Bp/IHhuSc4FuUGVFe4JfRmme8OoetYR8JpwjO5YQ0?=
 =?us-ascii?Q?HyAAS4//BbHDbnKf0b3spwBbLjeYDy1e+31rxpEpbfouP1oIQEwICfUkCyJh?=
 =?us-ascii?Q?StSNo+e04ZhgTwjcy13sxNdYYYzBaQo6/GfbXpb+TfvrExAWmjeLCQh5xeN2?=
 =?us-ascii?Q?8L8uQBXBm2Kyk/TWrjeEPw+5uQ+1lE+yELnL4lihRisnwc8BIupbe1ePrf6J?=
 =?us-ascii?Q?OHoKo0GPFhd9g/XHqFykTFctyxNEhgCdlo7mxKtwYyV4vT+zIn1FCg7WG12b?=
 =?us-ascii?Q?NipOgusSKa5SOQsQtATMaXpA8ck2PACADYjxOAlGTWGMFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1iHUJGUT2oc1DI6ua55fMFICSZ5xoBCCz3YbP6sFoCA3/nsr27iF2U2oIbnI?=
 =?us-ascii?Q?69PLqj5sq14bgO3H0+pGOmCK9xw19m4XLIR5LSKQBs1hLBzFIQI/CTx9xVqQ?=
 =?us-ascii?Q?Mn6i4V0g1wzNU0TWUgN0JSXBvKF2iXnuML1COlYvsB2B6q1xba4WwRUyIWJz?=
 =?us-ascii?Q?ltPDB+odm7OpIClq7okWsI4L8V1UpzsSuCyyapACbQz2Q0UqE1GZ+0SAtNLp?=
 =?us-ascii?Q?Ou6NaKJhbxbUKepO1CKwQjraUkrnAluG1K3X1tZ3kFziMdeJF1thZUlSClRz?=
 =?us-ascii?Q?t6MhjpOB3w/SrWIp4zc+pjvLez8QDBFLn+UzTM05OlHRx8pYS865nmOy1aqM?=
 =?us-ascii?Q?B3ONrHKRYUnmdZyeK2TpfVqTUM1l08AJzIZxDsbH0ZM+eHlU5biudx6NPu4C?=
 =?us-ascii?Q?GmZaR4Y4fkWosP1ub4zfX/zp/WkD1300gdUUdMoSx2IjbWkTNUNg525ULiB9?=
 =?us-ascii?Q?MFAIAhm+RRkyjLJJTV1UpG9RV9ZKRE5rM/0VXyBTslvHeuaM+dJ8NF190+g4?=
 =?us-ascii?Q?jd2yNNlIgBUPamFkZ7gXF7J/5AGGERNd00Yh1mTxY/RNbNuHLcbABoiuNzGj?=
 =?us-ascii?Q?Dc8lJW7If5XKuEL05P7cz+CApS7jbC8EdQuIrJk97NfIKFQ2JcBQ1PHP5YDV?=
 =?us-ascii?Q?fDhTm4F02W1vp0+dK+GW1s9J/8Y8+QtQZy19BonkgZKswNf2+MRSSivoUjF7?=
 =?us-ascii?Q?/CY9cE2YXJ8uVizkwF7nuaCBBXqoNxKJFOv2GbL0uvVPvBVipjwGmG7cLycy?=
 =?us-ascii?Q?BiKhuC7L4jH0+GLF8QwoWHAa78g7K43xzeeTkLWLS8xvRwATDkEM7rDcRQWH?=
 =?us-ascii?Q?2Y+N3lk5QILeF9SL4ciNycuLMuh/WgiQ/r34mzECwbDM4bubAEwHyhu4IG54?=
 =?us-ascii?Q?90g5PGfdSpnWNRzQqP7IBjaCIzlKO3AwYLXhC2nR/kK01j0eyO11urahnTUe?=
 =?us-ascii?Q?wmpOXhugUF+LTc5hEimm+Aai4+ExBJTg4I706orZQWDzie2wE/RfCU6P+9n1?=
 =?us-ascii?Q?j/OK1W51XDHuDw8tL3z2y44G258NYiSTqSgL+0WyVQWrQG6TpezngEBKT4oD?=
 =?us-ascii?Q?msyYudE5Qp6xFxUBzzQy7W/tPvVhZh6th8qoAWgVproms8Y+3tARssAC4bEQ?=
 =?us-ascii?Q?BG6Ccmc7V42rBZQO3NO0z7g9maH0OB4TwEVpz67hWpX3pNx5wattirVN8gc5?=
 =?us-ascii?Q?D27I0O39yJhCcAtRXcg0HTia7tbfzx1bq5W385v0+Q3CYHTX10NHqIer7RuO?=
 =?us-ascii?Q?y66KtLC0hiOuts6mt5M2qxnug5r6uMhMJI25uNyi35RwEhab0dYm+KPjZSPG?=
 =?us-ascii?Q?TGS5gU3phZLl8fra1w+v7UXrPEk1HqggwY9TtklDE4bqd9GTWs0wM4Xu/SAa?=
 =?us-ascii?Q?XJ7KHt7MYq6kz/lRp02r+5vGR6Imy+c7Us23tads6Jj+JCrZ+kPK3uMH9Bxj?=
 =?us-ascii?Q?f0Sjm0Z0ZoW+pHHuK0CDniIz57rRy26ZdxJteNwO4MJPelOp4Al1C/cbiZVi?=
 =?us-ascii?Q?QHKBPy9RuUGqqYp4SpMKwoHxfGST+95sOJUxn1h3n1uY7mQyPUbhNZ+sogxc?=
 =?us-ascii?Q?QgSfdD5C212NtqF2wWbV3yIx5DVcbXXYbiu8r3ew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e981489-9e23-4b55-620d-08dd0d5e9667
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:36:46.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsTvJDuvMgBf5Hadx6w+AYs7kJV2SOcmqEYqpKGfEg0ocYNlbUkSoTSrVgcVP2+enzae0WCfBHndjnkCaE9+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

On Mon, Nov 25, 2024 at 02:20:23PM +0100, Patryk Wlazlyn wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Notice that acpi_processor_setup_cstates() can set state->enter_dead to acpi_idle_play_dead() for all C-states unconditionally and remove the
> confusing C-state type check done before setting it.
> 
> No intentional functional impact.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I am fine with this change.
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/acpi/processor_idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ce728cf7e301..698897b29de2 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -800,12 +800,12 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  		state->enter = acpi_idle_enter;
>  
>  		state->flags = 0;
> -		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
> -		    cx->type == ACPI_STATE_C3) {
> -			state->enter_dead = acpi_idle_play_dead;
> -			if (cx->type != ACPI_STATE_C3)
> -				drv->safe_state_index = count;
> -		}
> +
> +		state->enter_dead = acpi_idle_play_dead;
> +
> +		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
> +			drv->safe_state_index = count;
> +
>  		/*
>  		 * Halt-induced C1 is not good for ->enter_s2idle, because it
>  		 * re-enables interrupts on exit.  Moreover, C1 is generally not
> -- 
> 2.47.0
> 
--
Thanks and Regards
gautham.


