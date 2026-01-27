Return-Path: <linux-pm+bounces-41552-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJYYNmXfeGkCtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41552-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:53:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9697217
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D5B3074059
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B258347BD9;
	Tue, 27 Jan 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="joKt1+dE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T8lXGFy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FB3559D1;
	Tue, 27 Jan 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528741; cv=fail; b=YscQi6XJYPrbKcWr0n55drzrLe0i7AN4BSfF3nkzW4Oxor4/sIWojLpjRqR3odHxibVgZ9T0GBWyA0P+CBJzLzOurBDLPxkE6zGkK5sjr41AM4tXrx9AJwUGR8Z3/X04nRXoh9ahhe7bj48MEZlkSn3Ey41jiZ0GYLxOO3XdgWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528741; c=relaxed/simple;
	bh=Y/01KPIDQVuGe3k9yEMvXZKiPL2XXaTfR+v3cHpjIhA=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=H2TmCEUE9Mif+sW4i3m8ZoK5W9jxYilcmtpYtMB9RMEagrW4fpkI0QckADBex7peAJC2cxqCywwIYxppzcrDKvXKgnNWz+8x4qrXfF+IP1lAq6aioEyvYxQoEkVidBIxCuA7XaamT0eZipxmqslP2fjvw0nnpiu2OzNXvO6HWkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=joKt1+dE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T8lXGFy9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEfk74056597;
	Tue, 27 Jan 2026 15:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aRh7giz/OT7zh15h/1
	lStSZNt1UjYFYxpGbO4zQ1H10=; b=joKt1+dEW9Y5FT19vDfiktuh488Qyrs1YX
	rlTK3znCTIQUUsPoDfeW8vUuj4wtQBgfRv3QYf2/JZ6zYwIY8fUBbOmqA6p5K9Wb
	k5M0wgAp3Cy1yBqWFVQ1R8tDeWzRRcaJ9vOLNvy5gUOvzn5biAkUtE//BO7320O6
	KDoRq+l4aApgw8siTiiFdz+8GNuTdih/BQQTqZ+7IRL/fRslw5fKPlU7kp3aWTmY
	6k3gPS4Rx9uICtPdUxsPS3AQ6q2M7IE5ZEAQspCzQ63gtX0BxM/Br/vIqci08ucb
	Gxa1PTKtyC8SaOY+G0p4K/lWmiLIQjRVOkqZNcg0/Er/GBJ/Ve9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsc7rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:45:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60REawAi032698;
	Tue, 27 Jan 2026 15:45:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9k0tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:45:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME6JnB3ZyNZicGc2Clc+ErFbz9sqH7I5EGX56KtUiD/ViPrTbOh5XsexvvXb+7uC8Woug7tx991chhe48ZU0TPrLZW4TuC4m2Tsqwhzy0yI+Ml+9Y9OeM6bjMHeyvtuLmMhnWeHUuL939tARh8J4MtQ7FW2eSL667tfi6nm33HK8eMIgNQh6Z4hemTaNMrC/Js2iwezEKBVCn64qPnpS30oWsv3MbnV1bwf5s3vcP8+lJG/hoB0ol2STL6LNmvypMTUi4NkjEMdlnzI1ouFiWMPhrOIPx4zCCRqpUDW93ua2BrAdHbOQlWab7tR/qWAX/F/AoCFgLTUXKcy9p7vETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRh7giz/OT7zh15h/1lStSZNt1UjYFYxpGbO4zQ1H10=;
 b=Mo+PDXfhVPgdn58ytVXNo3SDzZ9svR+LA2N7gQ52U1cNHf9bKv525yF8BJmPMY4kGGLOEglFZkMwQJQce/FN21r3mUqz/zVOMokoO43OPl6gbMjCho8WxBTjxz3u41rwmHoZGneRapyWNlACVPY3IqisgDI29NQOXOqbq2bgh6fYaz1Dy8bt10+CBqWCdFitIce+MzPa6kaKDrigOWFeWwh/R7zYpTURQeslhVNPGv9od2dYXFX/7XrdgQYGVwZUptxDfp3hmJNFB71ClDdJi35RyEOhNrKccLeWXxbiW9X47ANdkTrK/cWmDn5aCHsqtJDrocp233IOrCm0FiE7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRh7giz/OT7zh15h/1lStSZNt1UjYFYxpGbO4zQ1H10=;
 b=T8lXGFy9Y7LRsZKT53pKLofm8NbiFtS6Eq7FzN5vxcYxlWxrK26CAtG2vWp0jB0v4fYPq6RVgFkXGsi0FW65q+Q/L7+6573KiAS5eSDnjTuA/gHjfYiqIBpvl7wjXRWCykgI4Kfc13i3/ng43ue0P+Wx3D4a+7D3IqNkjBjpsZQ=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 15:45:23 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 15:45:22 +0000
Content-Type: multipart/mixed; boundary="------------L2KpcRBxCLWtqNagOGRtJfQf"
Message-ID: <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
Date: Tue, 27 Jan 2026 21:15:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Christian Loehle <christian.loehle@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Cc: 'Sasha Levin' <sashal@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
X-ClientProxiedBy: PN2PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::8) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cbfdf9-7977-4f5e-f628-08de5dbb145e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ljWXo3UlNIWXlURHZnaWxkdmNiRU9pQ09LRWZOODNQaWhROVdHV29HNnpD?=
 =?utf-8?B?bk85MXpNZXIrVzhQN0lBSHNiaXpCQ2lzUXU0U0tGRFl5RmFMa3ZCVTdGSGZZ?=
 =?utf-8?B?M1lsQXZybDhicFY2MUFyNW1KbXFFNzAvaFFOci9PeWZERXpxWlNCNkRnQXFl?=
 =?utf-8?B?TFB2bUNiNHdDNmZLL2M1V1R0Z3ZaZ3ZqVmRoRFVZMDk1NmhhdHZ0U1ZXS0Z5?=
 =?utf-8?B?QWhyUnJhNEhGUjdBR0JxUHArUFl3Ti9QZm93R2VrdGtWcXFTMGI1c0NOcE92?=
 =?utf-8?B?NzhVQjMwLzNPckUxa25PRXJROTk4QzBvUzZKSlgvRDJvSFc4Sk5DUU9hUXlo?=
 =?utf-8?B?WnhWSDI0L2xRa2hvUnhJSUxvRDhNVnZoc3VDK05IR01Va3VJUmRDRG5CdSs3?=
 =?utf-8?B?aXY1eFZJWGpvamJ2eFV0MmlWczQyOHhjOHczLzNrQUxSRkJveEIzRHhxODlK?=
 =?utf-8?B?RXd0MDNnaGZoRmtmVkxldVhxd2YvTVFoWmRFK3IvcXR2c2pJdkczOVllYlpn?=
 =?utf-8?B?WXovbnRuS3BwRUJ0TklGTXZ1ZTg5TkZTUmlKM0tZVjFBOE1Ca3V3S3ZxMmlG?=
 =?utf-8?B?c2JTb0c4WjVEVHp5NjYrdnJrd2xrY2dyYThpK3NLV3REeW9xcWNCUVA1VGgr?=
 =?utf-8?B?UDdCYjVDVmMvNUoyVnQ3Q3M1VDB6K3ROZzlXWWtscTFGZWpxMlBFMmNyNGtM?=
 =?utf-8?B?cFFlWm16Ui9nRHJLeGlWTklmNVJIMkt5MTN3bnVOWFJ5QzVPQjVwdU1LcGlv?=
 =?utf-8?B?M1ZoaDVPTXBDeEZsRTgyVE9BcDZSVlFhSWVnT2pETVk4aGtTKzNiSjZRM0p6?=
 =?utf-8?B?Qm5FN2RsTVpmZDNOMlVpSnNwQTFpTzFkTnhGZ1ZSWlQ0azV5Vmxpa0JOZDR4?=
 =?utf-8?B?TDcra25TS2hRcnZzcjZIekxIOUNiQkM4S2VBWERuY2JRRjJuVWlWQ0VNTWhH?=
 =?utf-8?B?NEVVVFBrT0VGZ1pxOUJBQ2N5QlVVUzJoS3haei9iY2lXWnE5RTlqSDAya0I1?=
 =?utf-8?B?MWhnQnVaT1FBWGFEdlp5YWFkMGtJTE9RUlNSYzc5ZWZvUGs2azNCdkc3SFFW?=
 =?utf-8?B?UHZFVU9TeHVZbyt5Wk1ObkZLVTVjcjBRaSsyUTFEaFNRdUdETVR4RjNPemNa?=
 =?utf-8?B?SHQ0YTJ5T1huQzVFVGNQbWJaNWRQN0phYTVPUzRKeFowZzlwbXFHZE1jR09T?=
 =?utf-8?B?dWdBZ3R1c3ZhS0YxSlN2aHdFV0oxNmJOUGg4eFRqbXp1c3pNVERPN1pENGVN?=
 =?utf-8?B?dlRkSEc0Wm5EbDY5NC9nNUFZV2ZEWFR1bGRCVEJJYTJyZDZlYVVRTmJGTmlY?=
 =?utf-8?B?TnlLLyswM0EybWNwR3pCUGx4dksvK3FCbE9KUDdRRG9taEtTOTZvczFkZ1U5?=
 =?utf-8?B?cUJram1kTk11SmMweFArdzcrb0lneWRnMU9xZmpKaXhKWVV6aEUvcTNqUmVH?=
 =?utf-8?B?Q2U5MUszSDBaOEphYWRpN04xTnV5enJsZnpuOE1CVVdTcHNweXJDcG5NeU1N?=
 =?utf-8?B?dllIYWpaN1ZhekxCck1aMXNZVnpXblZ3QWtVVXpoMFhmekQ4M3RkcCtySURR?=
 =?utf-8?B?ajhQZFB2dThoOVAvdWxkR0ppcGNxbnE5WnBlWm8xQ0dwK3BrNW5vcTYxNmw5?=
 =?utf-8?B?M1hjR1VMMnVlcGVHTzdSRUhMWEZYVFMrLzNnTWRMbXpTT2o1R005VWpmMW1s?=
 =?utf-8?B?MnNxRTlVMWtid29FcmN1VkRETzA2dFdaWkpvSzQwQnRGc2xWRFBoRUZnY3BO?=
 =?utf-8?B?c0FpdnRWNnpiampEb1g4SzFydXNaRXh1SW40cktWcURGcy9NSmY5MnZDNTNK?=
 =?utf-8?B?NHRpVEpneGxNZDNUa09vd2dTeG1UZFFVR0FnVWdoZ1plUnF1c2NBNHhlbmpB?=
 =?utf-8?B?bWdxN1E3S1h4bzlCN2xDWlZkTU1neFB3UnB2ZElRRTdZYWRwRjR2WFlmaWFO?=
 =?utf-8?B?L1hGSTZwZ3ZCR2E0TlhSVXNpUDN2NmxiRmJSZitPMndreDE2ZEJZNWVzZ1By?=
 =?utf-8?B?UFU4UUk1V2hBdFZDYWFrU1ZDeDhwQWFoSlpWakFNWjVsZDRBd3puWGwrZFpm?=
 =?utf-8?Q?kT1S88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZIMGxsN1lNd2ZLc3BKV0MxWDN4ajEwd0xZVi9KYmV0SnBoLzNwUnpkbDdM?=
 =?utf-8?B?NEdyZU82ZEx4NEdpN2JTbS9WTzJtQkFsWi9lM1hyY3RaTWFiakF6YnZwakw5?=
 =?utf-8?B?alF4eHQvb1VyNmdtd3hYanRSa1RFZDc2ZEhnNmRqM013UnB3Uk5YUmFZRTZL?=
 =?utf-8?B?ZW40elBnZENXeitYTXJBQzBUakxGSFFEdk9iOU5xdUZoVXR5dWl4OFlYMUVw?=
 =?utf-8?B?N3FQZlRzUFlobXhlb0dsTEVsV1kzYm1SQnM4WXY2ajVuN2VwaDc3Y09TNHdR?=
 =?utf-8?B?KzJ4OEZkZkU1dVZpN0RWRWhNRUhXOXkvRDRWaldhYWRNMFQ3V3lXUHZ2L0ZT?=
 =?utf-8?B?YmY0cTR0dUJna1FET1FxbW9OTnFBSSt1Z2E5UHh4K1duQ2NXdFlmUk9NSVlw?=
 =?utf-8?B?OFlKVkpQS0ZscnpCR0MvSEdxS1hIRmxUOFhYNWwxNHVJQTF4TldVVzI4TG5M?=
 =?utf-8?B?OElSbUhDVmgvRi9DMWFhb0s5OFBjaHljT3dkNlhaSW9KRUFDL2Z0UFpDaGF6?=
 =?utf-8?B?aGNqUTRIOHQ4dHE0VkdtMUFUUVhZbFd3NTJ3SXpGQmxOSG9sL3JtUHBXMXZv?=
 =?utf-8?B?R3U0WFJmOFloNU0xTTJocUhid0haZjkrVU1VNS81ZWVwenMxUFJKc1pQbUlM?=
 =?utf-8?B?NHloZ0s2UlRFQ2RLQk9Ob1B5WW42NVcvK0lLNHNjTDBEalJWOXd3bFkxZkV4?=
 =?utf-8?B?NXdjWVE4WS9WNXhmZnl3WDFoKzBiZjBncFBNNlBpZkdxak5mVXlUWjYxRmpC?=
 =?utf-8?B?dVVYWTBkank0Sm9QT2M1NjFhVDhtK2xTTWZxWGRMTGViRXNRTVRhTkxoWnVQ?=
 =?utf-8?B?MFFJeTRJSkFYK3VFNFh1bHptK21oZU4vZDdMUk5tdEpBalR4QnBsTzIxdk1H?=
 =?utf-8?B?T3FBR2ZZcTRSWUdzVEJVL004aVlSeVlaU3NnbjVPVjJnRDZsSXFJenpELzB5?=
 =?utf-8?B?UmE4U3NqWHJZS1NkSEptVzk1cmkyeEJ3YXdhdkVHN2lHSWRVbFduSGVOdjdz?=
 =?utf-8?B?Qno1cUNZMkl3TEc4QjQ3bExZWmJISTVxQzZRenpVR1RiZUt0ZDN0UUtUaGcx?=
 =?utf-8?B?Q3R6dDIvSVpPdWVhenRTNncxZTlkQTJpSUFNWTQvNUd5aGVPWU9vamhkYkJ1?=
 =?utf-8?B?TGoxM1JiV0Faa0h4QWUyV2dwUWRyZkZwdTBGWU1rTnd5Y0NUSlZEUHZTWDha?=
 =?utf-8?B?c0txbzh1NmVlVkg4QUlERXBjaVQ4SEpreTJWR29XWHFxellnZ3Zrb29SZWNy?=
 =?utf-8?B?Y0FHZW4wWnNkMUdBZWhRUDdCcEs3ZzQyT0dpdmR1c1BIaFp0VnhldGhWc3dD?=
 =?utf-8?B?SGtoR2kwZm5JY0lDeFhPaVlVcXl6bTEzWkF5VEZpK2UydFMybGR3Wk9uU3Bz?=
 =?utf-8?B?d2I3U1NlVTduekhXTHRiZS9lcW9hL284OGRCT2ZOMG4rTUNNTHFyQmc0Vk1S?=
 =?utf-8?B?OEJ5dEcrb2pkSUJkajNTMGxwdDNtVGlueENlY21IQ2djMjMwUUtEdnZvUis4?=
 =?utf-8?B?TnU2RXNvNXNTcjcrTkU5WktBNlFXYlhBZ0YwOUdaNjlYN1ltd0Nwb2tGWFBW?=
 =?utf-8?B?ZmRWUWxueGEzTjE2RnluK29JUVp5cEZOUnRhNjZSTXZmcWVkVnlQeWFEZmxR?=
 =?utf-8?B?TEtCd3RxbjRzcEY1N25aVDU5akN3cktlVHBwRDhPWlpmS1VrbHZkbklEd1Av?=
 =?utf-8?B?VFE3SWZvbm10OHJaMWx6ckFJK0FNU1YwR3JCVVRKNVllYUZuTkgweHdCc3o2?=
 =?utf-8?B?VHNJcnNkZ3poNXJONEkva21HemtrcXdPNlVQZ3R4dGdrS3BuUTBGYTZqZVZL?=
 =?utf-8?B?b0hrTmRGSnhTUVpYRjkxYTM1SXVISkFWek5CZUJaTUVJdHNPK3E5TWxpRm4y?=
 =?utf-8?B?T0doSnB0MHk0YUxNcjBVOHJ6U0FFNDZ1Y3FZTnJ4TzFRSk1MV0lZZzlMc1FJ?=
 =?utf-8?B?RnNIUU9DUVZjMURXdU5sdHkrVDR2TWpmeTVyZEZha1NNWGgzWVhhbmoxN2lT?=
 =?utf-8?B?cUV5aUh0QXNHdEdhVkF3dEZaSXVUT2crc2ErT1J4YUZDblQzei9UUGEyZlha?=
 =?utf-8?B?WlZsOUxqNFR2MmFwZStxSWV3NkJuWDBtZmswZDUreUJwbENsZTZLK0hEMFhZ?=
 =?utf-8?B?dkREbVR0Rnd6dm5JR21YMzQ2ZTdvUzRXeXBFVlBzODVqOGhzUTFxZ0VCNitl?=
 =?utf-8?B?YjRpMHZ2Unp4c0RtTzZjeGpMNnZYeDV2MkZCb0tvbXY5YXlTSVVPLzROTTNl?=
 =?utf-8?B?S2VOajlTa0REUzJWajVNcU9saEc1cndodDVNV2lKWkhVSGxCWk9VUjNCT3ow?=
 =?utf-8?B?R29hRFptSGV5UVBxbEJnR25Za3FDSk1QQVlhd1laajhobWE4SGV1R3RLeG1t?=
 =?utf-8?Q?iSWSNtYI95gQCE7U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+pBKt09oAca67cKOZ9RHM9K/+E2Pz9Iaw8uxfkbUs4D8gDLrg3/l3yo0Y+Dcv2rLMkqBSg9zvD1Wt78xncVMj6i3Y4XnJ3RoJnHevbkLiUr+8S4xMqCvJeC50Kc6d4N1KOORiPb6EAZctZwqsmLG5rxbgxkuIFxaPAU4n33FPeBO+En3ockKRVwO3+DeMTTPim5LnlFfD+2k4FLUcx4Wg6Lvs3jz0nW1F5R+LAPDHOXStXMsJQxWIGGmduS9U+M4pIg1dIHf86HJbcwl4JJ7IHgeUdap03UlZ2oCrf2KrxuHXacHJQUVAKPGn1iZi6DCpwg+AC+C1w1MrNW3XYc+l9x6lDKF8juBagAgHVYQbWYNCEVIDHqqT5C5qiBUVD5Bl9QdH/5YQuNNXd76gPRaRfMOYmIEZmakOwuTZFoF7ByW+hWkNGVmHm2FtgrBmhjk20ssGRBDHMPXca37zMKlGqeUq2ro2/le++A2HL3yMVCjx1pptH1uuhQrrW4ajo/dN5hOXolB0QRYrpkmEnMnGg6HdHIvHlBcth9sjBn+cYmYNhBCNgvdwoilLocjjz/BZa8bKXKdUXF/AyYVhaptTg16Uumetqg20zNjkkpkd+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cbfdf9-7977-4f5e-f628-08de5dbb145e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 15:45:22.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb18+pu7GkUx0E5tZRgoSVrz43QmxhXthoREnyl8iIGgag8VVqKbu56YhNZ6el/zCoa4F69QVeEr5uyKZmBjNr4EUX+YcnZiwqCpMQ15R+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270129
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978dd9c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=dHxpzvolIU7PBfdXntwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=K6fmY_D8uwEYcJNbPs0A:9 a=49ladYHvHUoA:10 a=mpd-woop7mMA:10
 a=HiLRGq3uS_oA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Xb9splopOCiKwwSVeFfUpT3RHX527d_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX7H+U6GhXwecq
 U0zVbErK2VHciOyQUjSL9gIUiVtWaB8kl3I2GM4vZsWSHAihFHsuqX3fJvACFyEGtf8jUh7+IpA
 1/6VtwdahzwleAV1G7BdBvGL25rshDD91GfQ6FgDb1w3reo1ugkOM16dEusLiF98hJfzxePuQVt
 AWRCAJlTnjTP7ayFBTx0PuY5VYkhlc+QcABfMvkmPJnBZZRdxxXLUCcsnXV2am6BLTv2TAtPIn8
 A3CopDMs2kK0p3pa2FSPbKdSzAMFdmcBx1RtQA4vmx7HWFJUTfDZyrAGxiP+9P2guwb+YD2eDuu
 I7HGrskUMcl1T2gSgfKTTOWFgeYMuD2cTphGunwcHvr6SjKVb0aJnvV1YJnoViUO/Qm/fXKaIBy
 JZf/hRfRpZwtoP7cBAI3Cl40TEZJjgiUxvjVtWPmIo2N/phtFiMHjioNX/EjaPu3VBpv/Md7aJD
 WWp5oOw3y9sQwKpGjpg==
X-Proofpoint-ORIG-GUID: Xb9splopOCiKwwSVeFfUpT3RHX527d_4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41552-lists,linux-pm=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshvardhan.j.jha@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 34B9697217
X-Rspamd-Action: no action

--------------L2KpcRBxCLWtqNagOGRtJfQf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christian,

On 08/12/25 6:17 PM, Christian Loehle wrote:
> On 12/8/25 11:33, Harshvardhan Jha wrote:
>> Hi Doug,
>>
>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>> Hi there,
>>>>>
>>>>> While running performance benchmarks for the 5.15.196 LTS tags , it was
>>>>> observed that several regressions across different benchmarks is being
>>>>> introduced when compared to the previous 5.15.193 kernel tag. Running an
>>>>> automated bisect on both of them narrowed down the culprit commit to:
>>>>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>>>>> information" for 5.15
>>>>>
>>>>> Regressions on 5.15.196 include:
>>>>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>>>>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>>>>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
>>>>> thread & 1M buffer size on OnPrem X6-2
>>>>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
>>>>> 1 thread & 1M buffer size on OnPrem X6-2
>>>>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>>>>>
>>>>> The culprit commits' messages mention that these reverts were done due
>>>>> to performance regressions introduced in Intel Jasper Lake systems but
>>>>> this revert is causing issues in other systems unfortunately. I wanted
>>>>> to know the maintainers' opinion on how we should proceed in order to
>>>>> fix this. If we reapply it'll bring back the previous regressions on
>>>>> Jasper Lake systems and if we don't revert it then it's stuck with
>>>>> current regressions. If this problem has been reported before and a fix
>>>>> is in the works then please let me know I shall follow developments to
>>>>> that mail thread.
>>>> The discussion regarding this can be found here:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA-b9PW7hw$ 
>>>> we explored an alternative to the full revert here:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA9PSf_uMQ$ 
>>>> unfortunately that didn't lead anywhere useful, so Rafael went with the
>>>> full revert you're seeing now.
>>>>
>>>> Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
>>>> will highly depend on your platform, but also your workload, Jasper Lake
>>>> in particular seems to favor deep idle states even when they don't seem
>>>> to be a 'good' choice from a purely cpuidle (governor) perspective, so
>>>> we're kind of stuck with that.
>>>>
>>>> For teo we've discussed a tunable knob in the past, which comes naturally with
>>>> the logic, for menu there's nothing obvious that would be comparable.
>>>> But for teo such a knob didn't generate any further interest (so far).
>>>>
>>>> That's the status, unless I missed anything?
>>> By reading everything in the links Chrsitian provided, you can see
>>> that we had difficulties repeating test results on other platforms.
>>>
>>> Of the tests listed herein, the only one that was easy to repeat on my
>>> test server, was the " Phoronix pts/sqlite" one. I got (summary: no difference):
>>>
>>> Kernel 6.18									Reverted			
>>> pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3	
>>> 				performance		performance		performance		performance	
>>> test	what			ave			ave			ave			ave	
>>> 1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
>>> 2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
>>> 3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
>>> 4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
>>> 5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%
>>>
>>> Where:
>>> T/C means: Threads / Copies
>>> performance means: intel_pstate CPU frequency scaling driver and the performance CPU frequencay scaling governor.
>>> Data points are in Seconds.
>>> Ave means the average test result. The number of runs per test was increased from the default of 3 to 10.
>>> The reversion was manually applied to kernel 6.18-rc1 for that test.
>>> The reversion was included in kernel 6.18-rc3.
>>> Kernel 6.18-rc4 had another code change to menu.c
>>>
>>> In case the formatting gets messed up, the table is also attached.
>>>
>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
>>> HWP: Enabled.
>> I was able to recover performance on 5.15 and 5.4 LTS based kernels
>> after reapplying the revert on X6-2 systems.
>>
>> Architecture:                x86_64
>>   CPU op-mode(s):            32-bit, 64-bit
>>   Address sizes:             46 bits physical, 48 bits virtual
>>   Byte Order:                Little Endian
>> CPU(s):                      56
>>   On-line CPU(s) list:       0-55
>> Vendor ID:                   GenuineIntel
>>   Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
>>     CPU family:              6
>>     Model:                   79
>>     Thread(s) per core:      2
>>     Core(s) per socket:      14
>>     Socket(s):               2
>>     Stepping:                1
>>     CPU(s) scaling MHz:      98%
>>     CPU max MHz:             2600.0000
>>     CPU min MHz:             1200.0000
>>     BogoMIPS:                5188.26
>>     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep
>> mtrr pg
>>                              e mca cmov pat pse36 clflush dts acpi mmx
>> fxsr sse 
>>                              sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp
>> lm cons
>>                              tant_tsc arch_perfmon pebs bts rep_good
>> nopl xtopol
>>                              ogy nonstop_tsc cpuid aperfmperf pni
>> pclmulqdq dtes
>>                              64 monitor ds_cpl vmx smx est tm2 ssse3
>> sdbg fma cx
>>                              16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
>> movbe po
>>                              pcnt tsc_deadline_timer aes xsave avx f16c
>> rdrand l
>>                              ahf_lm abm 3dnowprefetch cpuid_fault epb
>> cat_l3 cdp
>>                              _l3 pti intel_ppin ssbd ibrs ibpb stibp
>> tpr_shadow 
>>                              flexpriority ept vpid ept_ad fsgsbase
>> tsc_adjust bm
>>                              i1 hle avx2 smep bmi2 erms invpcid rtm cqm
>> rdt_a rd
>>                              seed adx smap intel_pt xsaveopt cqm_llc
>> cqm_occup_l
>>                              lc cqm_mbm_total cqm_mbm_local dtherm arat
>> pln pts 
>>                              vnmi md_clear flush_l1d
>> Virtualization features:     
>>   Virtualization:            VT-x
>> Caches (sum of all):         
>>   L1d:                       896 KiB (28 instances)
>>   L1i:                       896 KiB (28 instances)
>>   L2:                        7 MiB (28 instances)
>>   L3:                        70 MiB (2 instances)
>> NUMA:                        
>>   NUMA node(s):              2
>>   NUMA node0 CPU(s):         0-13,28-41
>>   NUMA node1 CPU(s):         14-27,42-55
>> Vulnerabilities:             
>>   Gather data sampling:      Not affected
>>   Indirect target selection: Not affected
>>   Itlb multihit:             KVM: Mitigation: Split huge pages
>>   L1tf:                      Mitigation; PTE Inversion; VMX conditional
>> cache fl
>>                              ushes, SMT vulnerable
>>   Mds:                       Mitigation; Clear CPU buffers; SMT vulnerable
>>   Meltdown:                  Mitigation; PTI
>>   Mmio stale data:           Mitigation; Clear CPU buffers; SMT vulnerable
>>   Reg file data sampling:    Not affected
>>   Retbleed:                  Not affected
>>   Spec rstack overflow:      Not affected
>>   Spec store bypass:         Mitigation; Speculative Store Bypass
>> disabled via p
>>                              rctl
>>   Spectre v1:                Mitigation; usercopy/swapgs barriers and
>> __user poi
>>                              nter sanitization
>>   Spectre v2:                Mitigation; Retpolines; IBPB conditional;
>> IBRS_FW; 
>>                              STIBP conditional; RSB filling; PBRSB-eIBRS
>> Not aff
>>                              ected; BHI Not affected
>>   Srbds:                     Not affected
>>   Tsa:                       Not affected
>>   Tsx async abort:           Mitigation; Clear CPU buffers; SMT vulnerable
>>   Vmscape:                   Mitigation; IBPB before exit to userspace
>>
> It would be nice to get the idle states here, ideally how the states' usage changed
> from base to revert.
> The mentioned thread did this and should show how it can be done, but a dump of
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> before and after the workload is usually fine to work with:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$ 
Apologies for the late reply, I'm attaching a tar ball which has the cpu
states for the test suites before and after tests. The folders with the
name of the test contain two folders good-kernel and bad-kernel
containing two files having the before and after states. Please note
that different machines were used for different test suites due to
compatibility reasons. The jbb test was run using containers.


Thanks & Regards,
Harshvardhan
--------------L2KpcRBxCLWtqNagOGRtJfQf
Content-Type: application/x-gzip; name="cpuidle.tar.gz"
Content-Disposition: attachment; filename="cpuidle.tar.gz"
Content-Transfer-Encoding: base64

H4sIAGLXeGkAA+y93ZIlR3alx+vzFHiBltx9++/lGDUXY0bZjMkk06WsexpN9ohGjACM2Ty+9rc8
QRYyo5Db46CrgGIlm13oQp44ER7u+3fttf7rf/8ff/3zP3/7v/7d3/AnpTRa+0Z/9v1nKnX/+fLz
TW7Zeq7+e+OblC2X/HfftL/lTf308z9++PGP3/ut/NMfv/9v//THj/+e/9pf/vIL13l5jn/983fy
819f3v9//6fvvv/uX/76P//ww//3z3/98dfdD/H331I38/ffS7Ov7/9T/Pz0/v/y1+/+Zjbg6P13
3r/13r++/0/x89P7//7PP/zhhx+///aHH/7w47c//PjZzn8bQ+c/fT3/n+Tnp/f/3/70p9/C+bfq
v8j5b+nr+/8UPx++/3/87rs//+H//fb7f/n2nz/X+beWMuc/1a/2/5P8fPj+//THv8nrP3v/xvtv
vY6v7/9T/Hzk/b/89f/jT/3jt//Ln779y3fff3v7O3w9eq0fe/+l1bzff0u4//pNKlnxX/oVn/Oj
P//O33961Pz49l/++Kd//vbPj7//L//Xf/rf/uE/fvP3//n/+I/f/Jf//A//8A3/85H8//hfj1pW
XX2U1fR3s4xH9f+kh7/Df73I//5//4f/9H9+k/5n4lfK4+/zY/9D9l8f/TFXT/7P7ZFHfvsZfjkn
/9D+1uL/KSn79+S8qv7qz3/94eef8V/P3MPfm/591vemh6cQw/94/Q1Fv2P2+PuuX6v+69Pc3uTK
LY3KX7dxd0n6zP5w5nf9KHW8vya9LhsPK9Yfuc5HLhfr+HZNcrdp6cFKniyJ/9lmdE1Wby2P+ijZ
pv797TXxN6Gb9lsf9v6StNHW8g8kloT/Hdomea02lv+llcM1qSW6T1ae3XL2+5rLvys96v01aWM+
pr+PB19f0np/Xfzjqz/q8vPq9+B/4R+OLIxZ8ZOQZx1HCzNHzdF1sdz8//1LeptssHV3WfLkTpee
jQP/7qKkOf3IlNr8M36KH/71kTXx7+SElnl4gEqaLbwoabo783scs2G67Ladras8ui5Q6tsvf7tR
emJNzKYOT24lZGfzzNlXvRwblVFTdE3Synk0N4/dDyr/vt1dk8JO8fd9bR9eLcmsK1f/zWr4EYxE
7OTU5ffqX3m2IO6uwhbFZvbjaViArK+9vUk8enpgSppv64DjMT8uvAe38DlPLEpoSVodfrdjtqMl
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
kgMA

--------------L2KpcRBxCLWtqNagOGRtJfQf--

