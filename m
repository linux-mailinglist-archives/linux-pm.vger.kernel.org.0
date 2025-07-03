Return-Path: <linux-pm+bounces-30001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3488FAF66DE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 02:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C730A4850F1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCB2CCC1;
	Thu,  3 Jul 2025 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BUOloFYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46F2F43;
	Thu,  3 Jul 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503363; cv=fail; b=QEerTmiYaRKO8bhwjTU5LBW/WNf7k5nYjPVtQTxfFQh+6m85OJkfdSm90OoU6TPl/Gr0TcJFZAfOJph++BOx8Un4h4fNOFx7ch1PhVvXYf3ByW/tC616ih6KHlLyV12zZm8TAzaMDzsRtoB0I935iv1DGuUeN8fj82cG3qbM0JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503363; c=relaxed/simple;
	bh=Ycqpeaf4YKVYHifUWLnGFso0qg06rL+f6cPFXCsMcqg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=bMmunHVBau1H8ITQSGH3r3JrEzkrXHcPvJPsWgGKt0au3Rj2z1ojNroY3hwoRQV4lyPumT4PkAui8FjSt4nUXMkml+k86YKChSPQUXC4SuLLMROfYvsPX7fQ62yHunkhQbsWBMgAMJa3D6DdrDYNbovGwwanuJHBNAMxtqHrBcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BUOloFYz; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVsEo6AHZLvdpHtpGUReXJAABnZq8M44su9nqWFYIEjTWedmW8PwM7KzYbYO+3wle71lNhhpsbvDhf9uqwgyUPxymBydiAl+OrMoaSQsEf+mgS+ra524AMVv9auyRJ/C3eK9HJQ0bqm5b9PC84jRXO2btHRID7nfsZo+lWtmfAX5eqx0ikqKuxIL9JuoNWgzn0mWPnDVbqOzWvkVhSpbD+LWxAiisEj8Be7uaN0G6CsgpqjgPqraxerNG3OUe5gl1qerkEtr5qCr1mbC9UxmyE+wm0JZp7Nx2sr4/8wqXG8rKpCaytClHOBZ37PV1MCfuEl8Djse+bAa/8W7FRLQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxARdcXWc+uPXjgNOheKerTpvyXyZKyMzytYGRLJn3E=;
 b=DxO/B/SAC16sraDEL72Li4DcfcpkoIdEfDBaywzxp/ZyrqXkTxY9LegEBJ3wkiEXACzP3Kg+bMxyWUhJqfjL1cu9FcwbGNhAIncxDXZeWphNTkylRjbv2Arc660GyrBt+/8ZAfTcIdM1s5vBkMKVRglljPa1d6uZ+ieJGaBJHFynhXQoU1tOcET72NW1NHZBadUljNLuC3fUFWJhYUqFEKkel+ALamFKLD9OtYNRQoXn5g3hQW05G7aVH3Qm0gMAkwt84/WcpSCWMXZulIYcyp2Kk1Zd1naN8enPGJZ1ib4pKvDw3tL7URzpKXILkilWX/ZTPRy6pM5g60xF0L8yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxARdcXWc+uPXjgNOheKerTpvyXyZKyMzytYGRLJn3E=;
 b=BUOloFYzw2FNhbTUPJTZ0SL3EAPB5StVc1R8fzrz/TIq4wFHuyjGR9twpcOkt7rd9U+6JbeEnu5o3cLcIOi2mTYhNxNsCfyBQxbjCHCzStAJeZjs2wJVwVRWwgGUAKEHas4p0JD5wgnAo/8lfHmHj8jkQ8DsLYp+a6LlxXiFQoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB13414.jpnprd01.prod.outlook.com
 (2603:1096:405:1d8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 00:42:34 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 00:42:34 +0000
Message-ID: <87ms9mcdfq.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
In-Reply-To: <CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
References: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 00:42:34 +0000
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB13414:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e16398-a7a9-4c6c-8d92-08ddb9ca803f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOgJEip0bLH8+7H0RYqD1GM4IpvdSAmWB7CeZftaX6qGQLmzIZYwfq4NbDST?=
 =?us-ascii?Q?0KMBb3f9zA9FMnN6OykW4esjQBuQ6n0N/q+O9XDk5ZuppInMP9AJF4nSZNtJ?=
 =?us-ascii?Q?NRl2ugq5bmrE3QvN0bRGrtlttz4SYfIABUXeymHjhur51psSSGfnS5hSI35I?=
 =?us-ascii?Q?u4ADGWVlp2vZyGhw4AUWJX9oH+4fXVkB+ofEZlYhv3u4dtRpdi6YGVBj7R8K?=
 =?us-ascii?Q?nOV9Mbkbz+Bz5XUV0FCJMFRZNhsoXnsqeTEwPCSh3hbRVThoy0guGpfF9ms8?=
 =?us-ascii?Q?sg13dIr13JuuHd9gJp1cMry3c+HZ+FovMj5UqVVBPSt4AQz1MEPjqr2zqRFV?=
 =?us-ascii?Q?WOdne6pckYGPrsOcum6aorxVv8PAjQeh1UVWcqts/VsJ1DwFR7lxxKP9NUD/?=
 =?us-ascii?Q?r9m6S1LyFHM773Qs+QtQ2B5GuXLuu0KB/WiPRIOv8dfvsq4BHNR79WpyLdI2?=
 =?us-ascii?Q?HPHGXluzbb9hBcuKSj5Jg7Afhuw9SMZv+YVBfdWV+FrmbqfPY75tZohIzS8e?=
 =?us-ascii?Q?COl3PD3mzMDAY75YFin2SJDvF9nncYcunmULHvKf1hZKhqPffqtzke27RG5a?=
 =?us-ascii?Q?/AG+WpQYv/n9g0lM9qYYMW13Crnwa/5hvE95FvA/5wStkCVy4lcHa/GGgOtr?=
 =?us-ascii?Q?4h1bR2/txw3ocwKBWBVLgeN2U4WNCBTTcwVpai7q2Xg6/9kghuvN9VQHGnQS?=
 =?us-ascii?Q?Xr6JMuz32e/STzukwArPk7H+WJRgo1WlL6s4NuUCFEb8+EgMHCqIZIHptxX8?=
 =?us-ascii?Q?MoJ7qeiwDuT9YInbcI4VdnHO4XlsyDMFy/hBN9I73kMJL+aaHyZY1MU2TaRT?=
 =?us-ascii?Q?GJ0Cc3of+dnUsV2yDgkUJSI2kgrgYee6kSE/q0b4lrnyKht++DqAnOFzfTNF?=
 =?us-ascii?Q?clNDy5wROasi35MAlW18vz6WItfhfBR9ra3DqAc9uRn6WziaFTSQn6g9UozQ?=
 =?us-ascii?Q?F41zDjfr1H9unLJ3ffiKh6OxWqUelVlLcP9/6nP7atgm8sM/CzeLm3u1nFyo?=
 =?us-ascii?Q?hM/0JZJMJy7yqGsvcTmJS3T00nvIqqdn6bxTMeA7M/dgebNxWa7pYjQKJove?=
 =?us-ascii?Q?oWR0/2paVj2G7QVii1NUG3SbBxP3LbwvZT2gGgZDoGfKB5TrpK750204KQdr?=
 =?us-ascii?Q?T88rp6fdKxGcui72NQ2iyTXspD7vWdrI3XycrmWOl7s7bTlxrDgLx3QG7ZQn?=
 =?us-ascii?Q?CTmOd661bH36+spORPaIFjAV0KKO3EQQSyt76mjIH+O6MDKW4yhdR6fOf8EH?=
 =?us-ascii?Q?L1ZW2Jj0lKcHT+xv+hMYFFGgUn7cZnmosDnARmxxvTHZDbS1wGPSFNUSBCE4?=
 =?us-ascii?Q?XslNJChsDnwvKQqGvxanKnfNnyKftN25NMW13Ii8c13sI1N2DBLbMlarGRwa?=
 =?us-ascii?Q?2TZdx4Lc0P+EPK++8L+Hkn419UnpIJQh7zEvqWuUgqx69gANjHbwWf6bt+gP?=
 =?us-ascii?Q?nsUlIkJ2eAupMLkhhJp2pciAU/eGID4dvoUl3aiOt7TvrT0Ff9DW2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLdODDwPRRuZ7knx8/p4gp0/kDQjO/msXGbakx1iT6+s2YvXNWCRGTgizyg0?=
 =?us-ascii?Q?YsbDQV6n6C0u4E0tm0YPruK8sGf7e8SJ6kdtPT5BkT+g8FYtCOtjg4s2Z0LG?=
 =?us-ascii?Q?gWhS7VrvUEJbnZy33iiJGDvkPopSAxHqoK6runTn5XMQikAED1AaN0YqT1Kd?=
 =?us-ascii?Q?3FPaBQTHNvipL1NzLrEqlmRT5zCCXkGy2dnV2kU+EVm15GCqeocAdthVxGYw?=
 =?us-ascii?Q?m3SFcmCNnNA/fE9aZKoqOv6W6Zm8pPMN+j6od0gvFvlv2xmK0fC2NnqyDJZK?=
 =?us-ascii?Q?aR0lVIUl6MBqBmi9w6M0O4jb/xQOzXBsVxSozVYYaEOKtfrbFheQY3WfhQ5v?=
 =?us-ascii?Q?11TF4eF1j0yXxL2eiHECM9BrDaCaeEi1jIzFYpe7ezYv8LgollDGySbaWKeo?=
 =?us-ascii?Q?rcZlVeNZJhUw6CcV8ytphBjLNP28mxGiom9OBSe7nw8fp1Gl3IbUxcqtJrKc?=
 =?us-ascii?Q?mt6O+FEYUjqvhobRs5d7UyZ69MsEvAUKpUbDCpOF9u9VjMUE8zvXRD+pJhYj?=
 =?us-ascii?Q?Sq0oCAW0Y2uG4GmSaVD5ZdQpgvp99iPVhawLJRfy4tVcGU+aDGRuok4dl7HK?=
 =?us-ascii?Q?gVTQQ1dfdosBpHBfWJzFVnGWBLfN6Mpg9l+TLLPZmyhHyJPV7gh4H/s+Ch7p?=
 =?us-ascii?Q?PcPDZzxzGdaxFKmPRo+eExb/iSkZG8NGbattvTs1wCLvAcYzCE9ZfjaJP9Lz?=
 =?us-ascii?Q?gfD/S6jv/GoLMlTHxYZ1VGHw3MjJ6KZF/8jQOM8henmgPQgFcgRVokg/LB5v?=
 =?us-ascii?Q?MlaZlkD2ngOJNbsDDhBdSNj+8RpGGOeK0/PEUJ0WZ6/RuiOwDSFFkP36zmQs?=
 =?us-ascii?Q?MFnPNsw0AFLioSAm4FmDeS/DITtj2ri0NsWLVEr1/FZZzdX25odJzQi4kVbv?=
 =?us-ascii?Q?B5W55CYxzJAfHQhuyfSNiGIUrMtn0Xbj/kiia7rEp3IgD0VdZE3SXw74cnK0?=
 =?us-ascii?Q?Y26qXrprt057IMtUJz9hiR6fA2K2CqU5Q+wUn/w/qg8xprNqSbhwRN2c6Dkd?=
 =?us-ascii?Q?UoLRp4k7g+PKElnlt2h1Nd0LbqFUBTWnmLD/AptU+l7FlqmiyH8AxGcbSaf3?=
 =?us-ascii?Q?4hqje5j7LAKJC04ioOqAjF5fgTmfUe+L/7yE39n5br7mKUE8b+SQR6ZidZe5?=
 =?us-ascii?Q?pbjIhKOkMN7iEoOVHMpzu0eD5P2LkWsWCbNOJI8OVO+oE0cIXrUCe8fPf1Ww?=
 =?us-ascii?Q?1oh2qM0RNnVqyAUWooJe7pAcUa9YH6KIXucDbRcr1kwJaRAVzjNkXwMyfc4V?=
 =?us-ascii?Q?sT2c86R9hTLiKTiOCvPKhTFCzD8+QuMJ3+Vc0Rd95qpDePrgkT6ExOCQx5cN?=
 =?us-ascii?Q?yiProJvNPqpGrMKcwYNbn89WQnvxUe4xeOhewJJYow/MzpFxjny8DHJzbcsa?=
 =?us-ascii?Q?kPULqHlvL7d9VphCaAeKRXJPqOVuLKjp8StKbdyN6C61NAgyL+EWqHFlQClj?=
 =?us-ascii?Q?eF6K1MgxmoY+UijvjkERnnTfrWbR/KcSHKYKFmUkrNr1vUNreDEHVwija74z?=
 =?us-ascii?Q?ScPsERDbWiucd6JXcWtn+Ww4JbW96UnHVNdB7wUBu88N3NY+qD8jAq+gE2uD?=
 =?us-ascii?Q?TQP1EWTyyiy3shz07kjHv5w3eQBZ1nl++M429u8Lyi8hWKAguzbi6tLUssXV?=
 =?us-ascii?Q?hP9UIZ7Oc9yZSMzS8GAbaE0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e16398-a7a9-4c6c-8d92-08ddb9ca803f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 00:42:34.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKqimg40oYUPePK/jnHBnNmWb0CcbO4RGowz/WnOeLJWJVsHne4rwXjbTuP24AkzdMAwdkD0mFFnE/WT4VYPzXwtU02MqAmGwOsBosP/+pXGRS6zBYBWS5KVHMrHNPww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13414


Hi Geert

> > -config SYSC_R8A779F0
> > -       bool "System Controller support for R-Car S4-8" if COMPILE_TEST
> > -       select SYSC_RCAR_GEN4
> > +config SYSC_R8A7791
> > +       bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST
> 
> "R8A7791/R8A7793"?

I want to have both 91/93 for each, not squashed.
v2 will do it.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

