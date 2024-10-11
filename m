Return-Path: <linux-pm+bounces-15544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A656299A8E2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C472857C7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919E1993A3;
	Fri, 11 Oct 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pEGrrCt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2091.outbound.protection.outlook.com [40.107.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53C1990C4;
	Fri, 11 Oct 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664196; cv=fail; b=ttVNnAwTtMn2ksxFbTryPy1VkGpPG9hL9rk8xqCiWg7fwmwrXirm3E2iTM8S70CE7e3kFBehokHqGChSW9NrdE6xlvFSXwTDsnaRR6d/LsJLK+CVuE3geqEZfGSmAUR4GQBqcQ8AJa2hdVCdO1MiZO640hFfzISHVTj99kfBOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664196; c=relaxed/simple;
	bh=1rSqwKi0l/DOvI+FeXCtewEjnFMgujvGmZPxniRD5Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e8lk7NwdoVNEbpJUl1E1bZl4bcp6hkUN7T4vSYUg/MQ80fc2uYMSH3ZOWPF7pUT8jvbOI6PvkibXz0DxlppL23ID+Mdh3dnRkqT1s2kYCFON71m2IKXSxRiQTIGQBzfMKOKyYYl+EraKHpjfE6bUr/kziI4z8Ou13QSvfTsTMkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pEGrrCt5; arc=fail smtp.client-ip=40.107.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtcxB8/4Tasl4cG8bf1JaK00KGrK2odnwPH5zf+jbi6zYAgYD+Taxzd1owZgsy8Ng16+mPZwoDdCHsVvKe+2IhepSujEJAbI/RajBQ/tteccoa2oZG0L79+JLcNyK3nvtTVUXeC9yn9NECXaM5Q+eVSJO4JlOE7ahIM8yj5RI1pDtLZMLa3+zw/Abb/6lGoWIlAlCnp6wzbApBcqNVetaC+wQRZlRtZVpa73k4yup/k0iwEEHfrR/By63Z+or7BCjB2ATHWisQSKwcvOvBdolQBNDcVYjHeYapb/E3no7aMsJ3JyY5QwADtvqdXaZmNTNUQfMxcNrKto6jK/xBtRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE8U8MvJt91KctZWvO5CowbqLozFofy8O8pDy7Y6zCg=;
 b=IqShDy58Sccf+FIaUEfCPYR8tGBRQQZSS029o7twJUSEKXmSrjwgie9L0s5LCMQ2yfTXLhyt+tFwv61XhYZgZ2swhLdzKppY59pYIrk01Ql61vU4VM/lvFfgf/jGDQUK2+0iCeGl9yx+kb+gG1E9srVlrDnnhFgQ39kA4nL61UNj96bfD0sq8ZmAS3c1rzFhHOqpEibJ7ryEpfhoifzPY24YglfSl+ZvUJLhOk3uwNLSvpQASbdoPC3WUcvixVZqcjLuRTaATQuyugojF35oiF4/eUPbzK7UcI0/o9miRtMJzQex50NXfNor5GTky7E7fkQTqZNGkH/0ynlD+VSpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE8U8MvJt91KctZWvO5CowbqLozFofy8O8pDy7Y6zCg=;
 b=pEGrrCt53HyN79XUaSKZq7nbVbXO/wD2ggk2xEhSguVguIWwbaikw+Lwqn2F3s4oIYfS+4ANVEcfwMcGxlKHRJHpqAjvA2e6E8mqeVbFpmO9GDbspelVp1VcRiaFIy+xuDVbpY0kTssuufQ4y/ZYMEjkadR3LZjW0SlpWBZSvoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN6PR01MB4176.prod.exchangelabs.com (2603:10b6:805:a9::14) by
 DS7PR01MB7854.prod.exchangelabs.com (2603:10b6:8:81::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 11 Oct 2024 16:29:47 +0000
Received: from SN6PR01MB4176.prod.exchangelabs.com
 ([fe80::da3c:af32:2ee1:dcdd]) by SN6PR01MB4176.prod.exchangelabs.com
 ([fe80::da3c:af32:2ee1:dcdd%2]) with mapi id 15.20.7982.031; Fri, 11 Oct 2024
 16:29:47 +0000
Date: Fri, 11 Oct 2024 09:29:44 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: viresh.kumar@linaro.org, Sumit Gupta <sumitg@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	rafael@kernel.org, yang@os.amperecomputing.com, lihuisong@huawei.com, 
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>, 
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <evllzzjufritriziohz22gm5qs44jedpft5lcfjfwnekarqtdx@eg42ik2l7bxu>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zwe1p0La_AFknglf@arm.com>
X-ClientProxiedBy: CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::25) To SN6PR01MB4176.prod.exchangelabs.com
 (2603:10b6:805:a9::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4176:EE_|DS7PR01MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aae9f04-d423-4421-3674-08dcea11ebe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ea8IQ5FeY6hy/LcTiunUonY+m/i9Wc4iUW5W8ThzbtqhKSB5WGI/Qb38n8pU?=
 =?us-ascii?Q?OPmrXgW7wr19rRU7PJeSUHD1/le8FLR+HF080cy+5Lm1NJuhd8mUeqBjVGhd?=
 =?us-ascii?Q?5JXLcKCeOtJ8Z1sncJTKAkrUfriwwgbg2SU2pKUKHjywM8qkJS+hxAZDBL3p?=
 =?us-ascii?Q?ETlNwmyTYODirOuKxINUB+dwDkeicoc69H55jEC0WpPqotAasqA8AkEC5hH3?=
 =?us-ascii?Q?Xa4tH8wJZrG6A1KdS1AZXlRGi1EoeomYXRDMvxfPYVZEuTwB13cA25LOyh7/?=
 =?us-ascii?Q?HmHL0Wn+agMWZ/KfxvI2V48/CF0cffN9MMnYfvH8TUYcF7PfSDJ3xRlMbeZF?=
 =?us-ascii?Q?fuYVHm2ADnuIyaEJK97aDCh8FNg14m2vCG2XqEKSpbMazCOyd8wcN0mHty3A?=
 =?us-ascii?Q?swD7dDb2cMwGY5ZnIueMY1XFRKFMUh/cx9YfzfspXK7Lwrbg7uJyU0ZYZEMS?=
 =?us-ascii?Q?zFfjVii+/FrJxjAgXBOrINdpwjd0Ki2f1l0DIn2UwxUsI6fHQWN4coDmZZTD?=
 =?us-ascii?Q?J7XmDrIR7H6U1KgVpyQ6zbnGdwboVsWs50ijf53ZPthHU9dBurTBz4XU58ZF?=
 =?us-ascii?Q?hxCron9FraYoTU60zE3VWDjDoaBjxsyTZBeVfwEybugFxX7QDGyWF+xD1FPV?=
 =?us-ascii?Q?F5i5jyxnEuRdEFEj2V4MQwy81ZG4EF+cIYIxxjnp/X0lBV3qX1feD5tja2BP?=
 =?us-ascii?Q?ku30EkVnyEEsvAB9ftRBQUPE9OGP6iDWeL15T410U/8AUR6+V2Mfsyyf7Ll1?=
 =?us-ascii?Q?BTDkFa9G5Yi9Zt7AmuusRT8tDs4taH9eUcfiV00ICk5diyvxsnEYb3nk066w?=
 =?us-ascii?Q?642PDzcYhMn8ARXQoU6ui/hdoFFa4Z+9cDh4Sv4u6AnIVptf0KHEBkgvPj9P?=
 =?us-ascii?Q?ylyZAFINGySebEUQQnVKN0qkRX1cwvkGs3PKaevLS0PudcDIQfX6/oWMnJgp?=
 =?us-ascii?Q?WYJvka8zDseM282ic2rj9/olKFg0Ba9+haAQ+HbmkXgNCRmbZH57BV6ayjQ+?=
 =?us-ascii?Q?SGD0eOM5CLIdmByx3tt0oK5kV+4cTgTmSKlX7H++1k9adfQkK+rL7IRWpdVv?=
 =?us-ascii?Q?z66Q48bqswGpZIYBI7Pe0dJudzTPmwAI2JnG/CscbeV1sUlaZ7WxUqzEaquG?=
 =?us-ascii?Q?1nci7VUdK4i1bl3NZ/jnHsAhq8Qk7Arplsuuegs9U0qb2nUAgZcwXuHORIAF?=
 =?us-ascii?Q?0IagYH3YYPf1pnvTz0Q1k9MSwa4M/5VS75hstaQQ2G1BtnOsthzxv5+18JFo?=
 =?us-ascii?Q?CYsxofwqastq+S6YPX7sCjDtVpTVXwQnQq5CiIO+uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4176.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQHJob2d/AYv3ysLV4vBQxBQpA6F0hFgpqgjDMTiwwnYP2T4HSQki9ZLdQ08?=
 =?us-ascii?Q?P1kFVCR/5echJo7wtj6qOkvFrZsHqdUDeyZT0OmzgKOw6c1kqlFSi3saoz1W?=
 =?us-ascii?Q?uttYx1dvvQI8POlqi/ZMRVNxsOoKAheukF6/IYepSsTVbeko6/EdlUh7efCo?=
 =?us-ascii?Q?JjjhGsnJ/p/dWffGOUwEIn4xx2O1Lyq+axMLvukScM+45UOoZ+l1C/RoZhwo?=
 =?us-ascii?Q?u/glAdRTqlpG4ypOXOP7jkpOAVho075Whi5w+oA+217R2G446lbqo6RPZ35b?=
 =?us-ascii?Q?vWAVx3ExGBCYxzC2byFVv5olDNHR1UT5+hJ3v0CY/pSSXzrrr7tn+IelG1Z2?=
 =?us-ascii?Q?/h5FWAch+u8ONqGPcPakiNRtFXHZV6VHgD5k/W6IRc9a13+D7gFU0Tt28GMf?=
 =?us-ascii?Q?gUtmegyoygXBr0EVPm+e7OO5LVENr+EzMkyfN51jXRdz5o+jXa14nAhU1nGu?=
 =?us-ascii?Q?kXckF4lndKD51pqm5dx7YbVzDCuVUmj5XJ+slS/kbM9nB0utrPBAxgPrKjZR?=
 =?us-ascii?Q?HcwnvUtiRyxC0eotGrJYKJjNGzjej3sqPLCjHSfQVc7FTOmksXRz37oxuEld?=
 =?us-ascii?Q?n7ZxyyNL5H0iNzK3VNrthJPNQR3rUtsx24oDyBc9eHVEf4X6rbU+1VmdSdN1?=
 =?us-ascii?Q?ZhwxfVQ85a+iQnQD5mWdTEb32wnuU/BELvsbUQ30gI1lpUfk64QBUsvdxlFA?=
 =?us-ascii?Q?BC6DZfm86S5q8K25gV5Gz6XuduhiHuUNqDw7g+L12pfE4XGLmL9Ro93jUGXx?=
 =?us-ascii?Q?iHM3vfSMoZs/aJx2uGMOBDg+rm50YAlU7NdVN1nQzBfWjQH4UAvmTEwyHaez?=
 =?us-ascii?Q?Ojo7F6I3WooTacxFaG/gc3EoAv4ORUngVes4P4sMnBHEYfU5FhPRAybkrffb?=
 =?us-ascii?Q?XQ8+/RyXsYmpmXj/4dZJgfcLv6fCk++M5kVJdiRo733KwkAFNXAxIbPY8Ycj?=
 =?us-ascii?Q?FeOQVrJlycdsRDEjWM7fSN807IP3e4VuP0u337bzIb7B/5ee1bj8bzeSUl86?=
 =?us-ascii?Q?s+AdsCK2AH8br3COUFAXivNvEX6duUdJ+S/8cuD3SKDbuUaQQ4IGKBhvFrgi?=
 =?us-ascii?Q?xtr0NYDSkjASiv9s1vjcIs/0XNdru0lvO+J78RXKYt3CF5Hbs0m0wBz70jh6?=
 =?us-ascii?Q?r044iNuTHQ8cVmhHybJT1uWH6jOwDNUQrxfGtxm2AaL/ieMzzWO7PXX8Z5Zv?=
 =?us-ascii?Q?FR8MW2rBR6jsY0OveKoOuDLX79A78zNbcEMILPydK7HyqDrwmn66mtg1Q4XM?=
 =?us-ascii?Q?07U7CR5C5qvUCz3Ctqj3o1B5wTkFjxPIPBFbz1qUtLlgmIgGOSW1IUi/dGJC?=
 =?us-ascii?Q?ao2vn//25p68/AMGHOCOzfjpd5nSjLuXfTCUQPyDHFYQi9FISYHN52nsrmVr?=
 =?us-ascii?Q?juwbEpchPJ+CCMBJqMW/ZAuH4ptEC2cqo/2a59J5uGi8bQNUAtV1ln7AAhvc?=
 =?us-ascii?Q?juDhfNBJF/s7lCUkZtwI84yC7HNYuMUBc/unByn4S6WK54O3UqMJ/HcYQ4MF?=
 =?us-ascii?Q?EAnw4bMOG+5edB1u1JfBYuTXOPiLsmGMOLHfA6Qj1IaGBmIEFhCiHPoUOV0M?=
 =?us-ascii?Q?LamZ866s5Y/+uwiuyJrvxcfuIbTU55KC8oNSjWt8HCIOyskgAqBy+/mdcBCF?=
 =?us-ascii?Q?nBIqaiByFsVpKEuBiH1qpaw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae9f04-d423-4421-3674-08dcea11ebe8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4176.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:29:47.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tiVsjcpOV+7UGJY5eY8rSCAiixP5hOvplCEZZREkXd5wEUkzSqJWbOOIeyrT9U47prMETbVeZzl36hN8cx+wqiD0dHHljvz+nc6aN4AxPVJxKZV1h/jF7ZC0m7zX4W+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7854

On Thu, Oct 10, 2024 at 01:08:23PM GMT, Beata Michalska wrote:
>On Thu, Oct 03, 2024 at 02:54:22PM -0700, Vanshidhar Konda wrote:
>> On Thu, Oct 03, 2024 at 11:39:54PM GMT, Beata Michalska wrote:
>> > On Thu, Sep 26, 2024 at 04:21:14PM -0700, Vanshidhar Konda wrote:
>> > > On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
>> > > > On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
>> > > > > Hi Beata,
>> > > > Hi Sumit,
>> > > > >
>> > > > > Thank you for the patches.
>> > > > Thank you for having a look at those.
>> > > > >
>> > > > > On 13/09/24 18:59, Beata Michalska wrote:
>> > > > > > External email: Use caution opening links or attachments
>> > > > > >
>> > > > > >
>> > > > > > With the Frequency Invariance Engine (FIE) being already wired up with
>> > > > > > sched tick and making use of relevant (core counter and constant
>> > > > > > counter) AMU counters, getting the average frequency for a given CPU,
>> > > > > > can be achieved by utilizing the frequency scale factor which reflects
>> > > > > > an average CPU frequency for the last tick period length.
>> > > > > >
>> > > > > > The solution is partially based on APERF/MPERF implementation of
>> > > > > > arch_freq_get_on_cpu.
>> > > > > >
>> > > > > > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> > > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> > > > > > ---
>> > > > > >   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
>> > > > > >   1 file changed, 99 insertions(+), 10 deletions(-)
>> > > > > >
>>
>> --- snip ----
>>
>> > > > >
>> > > > >     ..
>> > > > >   freq_comput:
>> > > > >     scale = arch_scale_freq_capacity(cpu);
>> > > > >     freq = scale * arch_scale_freq_ref(cpu);
>> > > > >   ----
>> > > > >
>> > > > This boils down to the question what that function, and the information it
>> > > > provides, represent really. The 'unknown' here simply says the CPU has been idle
>> > > > for a while and as such the frequency data is a bit stale and it does not
>> > > > represent the average freq the CPU is actually running at anymore, which is
>> > > > the intention here really. Or, that the given CPU is a non-housekeeping one.
>> > > > Either way I believe this is a useful information, instead of providing
>> > > > stale data with no indication on whether the frequency is really the 'current'
>> > > > one or not.
>> > > >
>> > > > If that is somehow undesirable we can discuss this further, though I'd rather
>> > > > avoid exposing an interface where the feedback provided is open to
>> > > > interpretation at all times.
>> > >
>> > > Would it make sense to identify that the frequency reporting is unknown due to
>> > > cpu being idle vs some other issue like being a non-housekeeping CPU? Would
>> > > returning a value of 0 make it easier for tools to represent that the CPU is
>> > > currently idle?
>> > That is an option.
>> > Another one would be to return an error for those cases. This would make it
>> > easier to distinguish between valid frequency &/| idle CPU vs tickless CPU
>> > (EINVAL vs ENOENT) ?
>> >
>>
>> That seems like a good idea but I suspect it would be confusing to the end user.
>>
>> If a user runs `cat /sys/devices/system/cpu/cpu2/cpuinfo_avg_freq` they would
>> get an error in some cases or get a number in some other iterations.
>>
>That is a fair point but I am not entirely convinced using '0' instead makes
>things any more clearer as this is in no way a valid CPU frequency.
>As long as we document the expected behaviour keeping the interface well
>defined,  both options should be fine I guess.
>

Another option could be to list out the reason as 'idle' or 'no entry' instead of
returning EINVAL or ENOENT. These wouldn't be valid values either but cat on the
sysfs node wouldn't return an error.

Thanks,
Vanshidhar

>@Viresh: what is your opinion on that one ?
>
>---
>BR
>Beata
>> Thanks,
>> Vanshidhar
>>
>> > ---
>> > BR
>> > Beata
>> > >
>> > > Thanks,
>> > > Vanshidhar
>> > >
>> > > >
>> > > > ---
>> > > > Best Regards
>> > > > Beata
>> > > > > Thank you,
>> > > > > Sumit Gupta
>> > > > >
>> > > > > P.S. Will be on afk for next 2 weeks with no access to email. Please expect
>> > > > > a delay in response.
>> > > > >
>> > > > > > +               cpu = ref_cpu;
>> > > > > > +               goto retry;
>> > > > > > +       }
>> > > > > > +       /*
>> > > > > > +        * Reversed computation to the one used to determine
>> > > > > > +        * the arch_freq_scale value
>> > > > > > +        * (see amu_scale_freq_tick for details)
>> > > > > > +        */
>> > > > > > +       scale = arch_scale_freq_capacity(cpu);
>> > > > > > +       freq = scale * arch_scale_freq_ref(cpu);
>> > > > > > +       freq >>= SCHED_CAPACITY_SHIFT;
>> > > > > > +       return freq;
>> > > > > > +}
>> > > > > > +
>> > > > >
>> > > > > >   static void amu_fie_setup(const struct cpumask *cpus)
>> > > > > >   {
>> > > > > >          int cpu;
>> > > > > > --
>> > > > > > 2.25.1
>> > > > > >

