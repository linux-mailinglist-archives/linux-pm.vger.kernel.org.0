Return-Path: <linux-pm+bounces-8238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFD8D1713
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71079285BBD
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCA13E051;
	Tue, 28 May 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="pQwB1NDG"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182017E8F3;
	Tue, 28 May 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887884; cv=fail; b=szH2LE0SdgKntj8LG3GSq6dWOSBnEkmxl5KryPs2m31PyoZBpRGnP1KeIXML/SAddntZDN3lIVHL9W29OzMA6hiWlwM+YihG0ifpSKweDbekaJYMgLvEJvaIh5N8LH17w7rfmHi/EUE1y6OtPw4tjYByQSeJjB6imxPX45pLKSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887884; c=relaxed/simple;
	bh=da5pG61SRUxEF3L89X4Jtf913PkScCkWqrFMOLm5BZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNpkLwcA84qTuowcUH487B47StNGaOMNYC6q5UWHW4+6ti3jzQYwHtZajzOxNucvc5b51ZoyIflGv8pqzKBIsPpgSBK3A6LNrNPrqa/z1erlKvRpgyFSTluVWw4xFu5oaC1+8my1YRdtUyheqoutAF/fArzcagxGyn8CNquS720=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pQwB1NDG; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmwZzN48JRlp0knlHNEJ3g62cIp6MzVj9e6ufrNd3+UmUgtbH/mQP5lMUMJQw4w2SfeBYKJQgKoSz6jp1CPoEpVwbrGtbZGz5ZwG07yxIs4cAIj8/+lF2aj7YGjjiasXqTnmIbbrr01Oa5Vve494wYTywxR1snJPubpgs2+ukBKf+yn+ARaGUP32WQenTN82zIUca+EfyDGiodCm/PNUI/Ko8+teXcM/KYeVRNNRsKVNIxaM0WmuauvjSzMaIwUNP6vJ0jASmJImWZBvDAgbjRTdaMLPaCDewpxMOiUyFAyJrclw6knAoWC0+5zrxRvokyqI+zCReOy2UTYYrIcA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQTPc07KScn4cD9SmT+lZDZ+gJ8IjGy1b+DrDeluYnY=;
 b=QmwbLjv0er8eLNIs4rhTwyFpRB3SX/jIaO6VSO0WhMW1c7r4+RJ0Sg2OJYF9XtE5PYhh5vinQnI6/iDE4RXZ4oS0p4PX7kEWH01RKTN67vqr3uQNt0Gh3XM3MY08OF+9eOoY6nDNyeDeGvwNou3oJ8bPmYbvs5kltmc+myuo5H3QXhMTLzltKPT6nKzG0HqCkN8tJCgBBKtxQzMWWZF8Kkd6mOsVViBM0qZOs6CqCpgDIgBS64qdA5Bo9b5eDU8fUBiVl5gtSDWSlvz+wwgyUHSP16oJUEJAlpVKTVhrrdrJgq5lWM9KX9iXxwZcQh/T9VpxB+9WENUb0KYGl3EWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQTPc07KScn4cD9SmT+lZDZ+gJ8IjGy1b+DrDeluYnY=;
 b=pQwB1NDGNGNHFFto/29vwWY3O95RXw/2RdelZgccgbk+7u9VjoDaHeLiviDPWprUJ4abwZgnC1bAtUgEd8klLz6uUXgrBnXDYWHXQe4RFz2KpNOZxsljPG5YEEir+e64rWcFNbVc/FFYe3LdtARMYAzeZ267YG0M69vMKlmmauGCA3Zr7JPyHkegyhKs3IXymESjJLzJ9lypCZEPy627CClmmk30eD7jvkFl0m9LVfU2Gt4hhQ1gFFwc6QKx06V51arIp2UNE8FEecRXGoxh8+UB9IAGUbqZfKyXiXGdIvaW1FBQ5HD6GAYrF8nshDcmIyS+M0fpGyPFxstG5pw5ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.13; Tue, 28 May
 2024 09:17:58 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 09:17:58 +0000
Message-ID: <9489c21f-d397-4d19-a1bc-81dd6078ea24@amlogic.com>
Date: Tue, 28 May 2024 17:17:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: a4: add power domain controller
 node
Content-Language: en-US
To: neil.armstrong@linaro.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
 <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
 <c97b12bb-8b56-4129-a292-588226a0ec42@linaro.org>
 <70083d10-483e-4daf-a408-020f0147c5cf@amlogic.com>
 <fbafc16d-d6fa-4c57-8fc8-a1db09d03e05@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <fbafc16d-d6fa-4c57-8fc8-a1db09d03e05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 7add3a97-bb49-462c-b2d8-08dc7ef710b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjAreDVXc3Zvc1l2T3FWeFk2Q3lCNEwyRFZKSDl5clZYQWZQRmFROWVpRU5x?=
 =?utf-8?B?ZHVtNnRzbUFCeE5NRVIxS0xBM2RxRFloajFlUXBXZzA0U3NmenFHQ2lXenlr?=
 =?utf-8?B?MkowMzdWUmRmMTI1cFR3Tm03bEJrQnBYa1E2NFFndzhqZ0lsdW10UVJGMHdw?=
 =?utf-8?B?Qy9FWmFiMGVhV3FwMmRwK1ZVMVpHZjNZNFJXYnZWTG1haU9nWEplazFla2xT?=
 =?utf-8?B?RHpQOUpJa3ZGbEc5UEV2NVpFR0VTbEpKbTBOT1dmOWpCMTRpTVM4aHI1M2x0?=
 =?utf-8?B?WWdMdThBTjJSQnl5NVhkUkRpNFNiZVRMYm5hSktxSjE1WHdwRyt6NHlhbkN0?=
 =?utf-8?B?WkRNWFMxaWlzVXhhd0RNcHlVdFpWTitqNC9CN3Qzek5mMTlhZyt0cEVvcmZ0?=
 =?utf-8?B?Sm1ZMEhZcXpPQ1hjTjRxM1R6bmZSWUtSdGVhZjl2Q0dCbDhJNjJoWit5akln?=
 =?utf-8?B?YzVJM1hXRzFiUWVHamdRbUI5b1NJVU1MdWhBQ0hLaGFEemoxZDZlWkRNVzYx?=
 =?utf-8?B?eTdqQitoMnN3aE16WXI2eWJObzFzZFc2QmxsWGI0OUJDZ2FLdWEvSjJzaW91?=
 =?utf-8?B?R2hBeW95eXRIQmN3TVZMWUM0eHkzbWMwTTFVU3Jmc25LcUpGQjVJYXhSTmM3?=
 =?utf-8?B?Vlp1bk9sbjNheWczWkdHUWUxK1VFUzdneExKZi9KcWpZekpIY0JxcHppY1B1?=
 =?utf-8?B?enpRUWs5U2ZGMXZXTTMwZlphV0E3elpXQ0hqRHBLYkk4MGo1amlESUM2NzhW?=
 =?utf-8?B?ZlFPT2tkZDNlQ1lSU2dkNHZybkN3Mi9UbTA2Szl1MkRhUjZ0LzEzUlJhL2Qv?=
 =?utf-8?B?VHRvTUo3aENXSWZaNitYak8vb0k3OTVwRTA3Nk1VTURFYmhpbThlMjN4SHVL?=
 =?utf-8?B?QjhzZmpXVTV5ZFNYMVBBcXdJMTI4WGdpa2d0dEdOOVBSYWJyUlRKK0RNbkFQ?=
 =?utf-8?B?MHZjaXFCN1dpQ0hUVzRKN3ArVHlYV3hrS1Z5cWcrR29JbGpueWFVbDY1QmZj?=
 =?utf-8?B?QWQ3ZDI3bFVzcDN2M01wZFVjSkpPTWNzbW1uZk0yN1BEdWJyZFBnbmVNTkhz?=
 =?utf-8?B?T0RTbDZXR1NTdHlaaTk1MXh6d0NSalVtSGhsczZEY2J2T1lJYkVaZGxHUnRM?=
 =?utf-8?B?T3pQWkVLY1pzTC9BM2JzZWgyTVJ4ay9URk4xNTdjWGlnd1kxeUhHd2IvbmI5?=
 =?utf-8?B?dEVRbXc0ZVR5R2NLTkxNUzhwc2t5ek92ZWVVTkd1OVFEU1QwRFZiZ0R5QkRr?=
 =?utf-8?B?QzFrZW52MjNLSWR3Kys1RTJuMGpGSDhjYmZuK0FRcG4vSFpxZUszYnFpOVl0?=
 =?utf-8?B?alg4dmI2amowYnlIUGRjaGlGWmRsd3NGMDhCNktMTTVXcGxRRDNEOTcvMWo5?=
 =?utf-8?B?RHRhMGVGMFRCMkJkcmYxSE1wZEFaelUyZDVKcEZDWDFUbXFwMEhTNktCU2o1?=
 =?utf-8?B?bHVmdDVEbEVieHlJNW91cXZkQmxHTkw1MDk3QldrOG1UaFhpWWw1d1pVMnBS?=
 =?utf-8?B?Y2VFV0p3MkZSM0xVSXdPMDVKSTcwZWVOM3QzOXdxbnpuYW5HZWFRTTlmNFJn?=
 =?utf-8?B?cmEvV3BhVFhmaXVrTkV2REhXTnptaUVCS3NPV0tUQ0N6WlBva1ZNZ1NoRFVX?=
 =?utf-8?B?QWhWZm1KZFV1N3BscVZDdEYraEc2ajdxTWRucW5sVFp1UnFMS0hXcnJUT2VJ?=
 =?utf-8?B?alpMRjJnak9VeUtXdk5XcTdWOVJ3TTR6WDZvVWdpMnY2aTYvS3FEdDh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEUreHhpZzVMaW5MaHQ1dEJPYTkxRHplZDJJeUh1eTZaeCtCdFMwMHZpMmhX?=
 =?utf-8?B?b2hJMCtWRXZiTm1COHE3emRMdklOcmFVUDhFcm1wT2c4NVRkZmVMZCtpejB2?=
 =?utf-8?B?NmVtWmYwVnJSVU8xZW5oWE5pQ3dZZHp0L1pTdlFGNHFOQ1lwN3VleHBLNXRJ?=
 =?utf-8?B?R2tJUG9ETjhlZytPMXdPa2xBN05SSXdaN2dkeXE1anJVNW82VWlyNndqMThw?=
 =?utf-8?B?TlhkNDVvaFRPQWEzZllkS1ZKVGxTbTNHMFY1SGJ3RnM5QjRNTC95alFYMnoz?=
 =?utf-8?B?a0Y0ZG9UNDVwVTNHSG9QRDJQTThHRzVYdHZsaFo2bU9BZEd6WmtReGt5S0ZJ?=
 =?utf-8?B?WlMxVEFzZGlsZ0RnTnBES0U4RVVicWo0SGJVdThOcmNSNE42Zk5LajdkUFJq?=
 =?utf-8?B?Q2JtU3RkaDkySFk1V0JQb1U4MGRUUnFPMnJtQ1h0bmdWaEQyY0xEdFl4Zzd3?=
 =?utf-8?B?TzY4aUxrdTBvNUFvK1NSRzFIRGp3c1F1R25WV244WjBjTjFDc0ZIc0k4VVM2?=
 =?utf-8?B?elExTldHRysxb3NIc0tLVWdqMGpEN3BYY3gvZ3ZPOHA4cHRIWG1KeGhoYmc2?=
 =?utf-8?B?RzlNS3V2R2JpaENWWHhOdWluZVFUSXdCeHN0ZWora2VMbldZVFQ0RThoWlll?=
 =?utf-8?B?eVlNNjhRdmY2YUJiU0RWbThkaGwzWEcrOTc4ZVA4Ukd6WmdBZml5WlRuRTRP?=
 =?utf-8?B?YlZuS0hyTXNFMkgwWGpoZ0tEQmFEVDFWQkd2M2dnYXc1NldEVlZqWTU0WmNl?=
 =?utf-8?B?YkhUQzE0MURmYWhDakI4MWdnK3F1cVFDS1JtQTdNcWV0U0hpWnlEeVZGdDJB?=
 =?utf-8?B?bWRLVEZHYms1NFBXUVdMNEhnd0lsK1VXOTZ0NnYzeDJzWTZYcE02RWlWRUx5?=
 =?utf-8?B?d0JRMFU4d1p1c3RtdW9UOU9KZWxwbmJKV25jWlg0eEtsOCs2VXVpNmcwMmVE?=
 =?utf-8?B?Sjc5SkpVazRoRWxLUTREK3FGbFI4WXNIcm1jd0w2VkYzSm9GVmNwY3pUc0RB?=
 =?utf-8?B?bXVhSE1MejBDaHJvUFB3U2ZFYUhMYkZ4bHFCZjBsbFByUUJZOTd6WUg4RWE3?=
 =?utf-8?B?bzA2WFltT09Oam9mTHB2aWRZRmtNb2dGNHBHczdCMDZ6NlBmeFRrR1BlZU84?=
 =?utf-8?B?dG54UWNwbzhpWkhsUi9zVjUvY1gyMzFyN2EzL2lyMGJLMjF3UWFkUlExUzVF?=
 =?utf-8?B?YUFaZU41UHZlZU5qMStQY0lnNytmUjllOWZrY2RpRHZ1WE9nbXhRQkFPNmc1?=
 =?utf-8?B?djVoYmpTdmVCM2VVbUh5M21kUkQvRVZHMDlOOFZmMjlnUkFhWUVPNzhIY3dE?=
 =?utf-8?B?d3R3Z3M4ZlV5TmZmOUtzM3lIU0szZ3UrVEVqTVk0WkNiRHlYaHZ2N1pEaVEz?=
 =?utf-8?B?OVI5VEs4R1JiNU5NS1dRMGFXRmVDYzZBU2E3eGZwR1Bzd3dIN2dZRzUvUmtN?=
 =?utf-8?B?UVlxYU8rS2V4MnZoWXozK2tPNlh2eHpmMXFmVFJ0L0EramdXRXBwWWZJeE9x?=
 =?utf-8?B?bllTVVliWExHQ29DQnhLYWhnSjRFS2RxOHZhbVBaa2w3L3hCNlRQNURQbzRy?=
 =?utf-8?B?amJuR0s1Y2tkaUttV21SV1hlbm1qMmswYUJHVlhvREZWanBaemFLSGhvVkZZ?=
 =?utf-8?B?TVNpUXRkNWxLckxkZ0FsbkRDVWgwTmE0dFByTkVzTEtDQllWSXZpL2tTNkJH?=
 =?utf-8?B?M0VQUlVlVU45cjg5d1Y5YXZWYjAybkFVam0xZEZlSHRGd3JrQllsMU0wWXRI?=
 =?utf-8?B?NWlreEpOc29KZWt4RzBxMTBRUE9tWHQ5RFphaWJYZGtzZm5vWFZrVFZseTdw?=
 =?utf-8?B?VStXM0FkYUthSWJ4c3NxSnVxNURaeHoyYzUrNGhJc1ExSER2YVQ0cmlabzlp?=
 =?utf-8?B?bVZMb0paR2Y2aXJqclEyUWtGTlh0Uy9KK0svNUF3RGpWRmhKSlVDNXBNcTJx?=
 =?utf-8?B?dVI3eGgyY0lBRFpzRE0vMGJVazdaRWUzTmM3U2xyV3JDRVJDb3RwTm1LbzEv?=
 =?utf-8?B?T1djNVJ4YUxueTJuN2QveU5DenRoZXNSbDZUTkhCWE9zNXFGVURISC9zTkY2?=
 =?utf-8?B?UDJ1cEx5MFMrQlU1aVVQNXgwV3Z1enY2clR6Q2lIWlpRTGU4bVdhcjF4Tklo?=
 =?utf-8?B?VXVYN09tWEpDaDlVckdZYXhZV3BwdGJNNjlPSldWSUlFeUR6N0dBdjVNdHdY?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7add3a97-bb49-462c-b2d8-08dc7ef710b2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:17:58.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i06XNdKrm/FzARZ7CCdg9gdoZvn6GoAx0bmamgzGviwoBSkiSNol0Kv1Vbk+QXLIZT16lk/1xPIQ0PmSQkOAYvirvPih935+QoK+RNJwARc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

Hi Neil,
    Thanks for your reply.

On 2024/5/28 17:08, neil.armstrong@linaro.org wrote:
> [ EXTERNAL EMAIL ]
> 
> On 28/05/2024 11:00, Xianwei Zhao wrote:
>> Hi Neil,
>>     Thanks for your quickly reply.
>>
>> On 2024/5/28 16:46, Neil Armstrong wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 28/05/2024 10:39, Xianwei Zhao via B4 Relay wrote:
>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> Add power domain controller node for Amlogic A4 SoC
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 4 ++++
>>>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 5 +++++
>>>>   2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi 
>>>> b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>>> index b6106ad4a072..eebde77ae5b4 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>>> @@ -27,6 +27,10 @@ xtal: xtal-clk {
>>>>               #clock-cells = <0>;
>>>>       };
>>>>
>>>> +     sm: secure-monitor {
>>>> +             compatible = "amlogic,meson-gxbb-sm";
>>>> +     };
>>>> +
>>>>       soc {
>>>>               compatible = "simple-bus";
>>>>               #address-cells = <2>;
>>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi 
>>>> b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>>> index 73ca1d7eed81..917c05219b9c 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>>> @@ -37,4 +37,9 @@ cpu3: cpu@3 {
>>>>                       enable-method = "psci";
>>>>               };
>>>>       };
>>>> +
>>>> +     pwrc: power-controller {
>>>> +             compatible = "amlogic,a4-pwrc";
>>>> +             #power-domain-cells = <1>;
>>>> +     };
>>>
>>> pwrc is supposed to be a child of secure-monitor.
>>>
>> Considered writing it like this when I wrote this.
>>
>> Here are two approaches: one is to include secure-monitor in the comm 
>> dtsi and fill power-controller by aliases in dtsi of each chip, while 
>> the other is to directly include secure-monitor in the dtsi of each 
>> chip. Which one do you suggest?
> 
> The bindings mandates it to be a child of the secure monitor.
> 
Will fix it.
> Neil
> 
>>
>>> Neil
>>>
>>>>   };
>>>>
>>>
> 

