Return-Path: <linux-pm+bounces-34123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46134B48445
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D5E189DDD0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4922291C1F;
	Mon,  8 Sep 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jEj28KGn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7A28CF5F;
	Mon,  8 Sep 2025 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313580; cv=fail; b=SqecOflHANLZX59s9DfzJHCqE0atl1cXtAuGEZ+NwyXkUhu1j5wgksxqYG00FUKMOMEj239/zHCSn5n0i3s/b3ltfMcd4MEWyHU3hgReNhE3rx8XMqPw0NdXUvB8inSlwBTLZsYPfRUu8zcCVSicDQDRLMz1M0EAOy7BAgF9LIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313580; c=relaxed/simple;
	bh=Ft0wHRFRdMhRNtic7zS1qKLRwNmqwn12F1oWnskfk6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYZX2iM6ME8DDbaZ4qhQBfsM/Pz575Kl8U3qDWm10ZS+g+ZbqZIyjG/y7Bf6IsLIDQev7Alx701ldb+drIGzPBduFUEqxY1gHkTpTb+UhHXpT0ccabMrGjIAm3aKBA4JcfDRtp1b5OJEBKNguAczabHOI1ye943wKomyBkKm/Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jEj28KGn; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBxn+2g7xF+GWYqKJT3HjTghub8+/uAr71nCPw2zkDISYx4RCljZIGGcku40D8AHKbpnA7fF+Xsx7LxvKBB8hfcJE4GB1Lk02eppSyltjqq0A2UO6332h9CEZhH4wRg9+geOB/NZpP0AFyU1QfTao7chLVhnGuO7+yfrL+yjmwUz+cmcVkLVgUoWeNGTA5vS7E7vOYiYZ0U45e2jvWaneb26SOBiyhkjfgzAJc80f38N8ywaG1IdFT2WIfctagUH/tidqYCZRnJ/5roWysX0EqNgnyWCL7ZQSexx/XfylpeXNJ8p1KtBGNQTxE39NdE9ckHUU/TA/XJTa/IqDm20CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsAhi1HTNeBMdrp4Emzz0mb2aG+OZlJJV0SZLInSQOk=;
 b=dpiyawg6IkHRcgFs02M9Xnb9PVgW858zHuRvxDEt7xv/dP3TajdG0TDkFv/BIYTU0L70Lia1uaiwIjmM0Kqb+4ouuATC0c/Mb6rWhg2f+CItrgSH1Wg4AoKLMC8/RHHcZ+d+te8rmTDM2ytl4bvrYFAn+E2YKSudUQWhuexWEjahuWXvMKt9cH5EaTDzSweQgQavy/P9Bje1Un8P1AlHsRLVP1R6LHOuPwCuGNIX8JBFc7TupCZHh4YYa9uC/WwFdBzT57eMQJuY2AprjWYi3o9xGJk+X7PxBUbfUbnjVPDsYy+NoGDYl0fduLkJ4zLZqggedEn1IVlvGf8rEFPHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsAhi1HTNeBMdrp4Emzz0mb2aG+OZlJJV0SZLInSQOk=;
 b=jEj28KGnvh+tRbVCqPfEJ3H6NK8zQBPGSxAtfHfdYDkE+ShI4NCtrnER0+ZQjwJnPKQwQMMmQSWlTaFlnQrHit8UPzQlGqFwRfiBj8X/QvrP8ITNZrREMqNyq8tqf62IfOaaLAUXmfHDVsxZrzhB6PA9oCoTsa6YEbr6oAle08s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:39:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:39:35 +0000
Message-ID: <f0b4aacf-99b3-4ce6-b42a-807f90282054@amd.com>
Date: Mon, 8 Sep 2025 08:39:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: thermal: versal: Add description for
 Versal Thermal
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Salih Erim <salih.erim@amd.com>,
 Anish Kadamathikuttiyil Karthikeyan Pillai
 <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <cover.1757061697.git.michal.simek@amd.com>
 <c46889536b2555c25aa6f17facdf085956b648a4.1757061697.git.michal.simek@amd.com>
 <20250905-rinse-haziness-93200b3de9d9@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20250905-rinse-haziness-93200b3de9d9@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0065.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a08217-abf9-4175-a619-08ddeea2799d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cElGMy9SNmhxL01QTUZ1OUc4NTJjV282c1FPc2E2M1J4UTc5UGZYdWdoVE5L?=
 =?utf-8?B?WUxjdzh1QndHWERMbUExRElCckI0WUg0dDV2TlRzZTlqcWRzbjRIZEdIVUlC?=
 =?utf-8?B?VWtiVFozWGZhaVVPc3RicExMZmxTRXRBWkxXMkFGTW95Z2tJN2laZXppaGlO?=
 =?utf-8?B?Zy92bks5NU5yT0hHand1dVRHSlU0VTRUSzAvUjlnZ1VpdVVORHEwVjlOTWdp?=
 =?utf-8?B?aklHSE91Y1E4Vk9OcVpPTHBGY0R6ZHU3R01IeVhpejVHN0pRUEJLK1AxWG5Z?=
 =?utf-8?B?VWs5OVpvZkVBcGhlbkcrd2hzNHVxWXNPenJZeXJLUld0R0tjK3dmWS95UGs4?=
 =?utf-8?B?QzBETzRkYUx4NTloTXhxU3RLZTVYSmNMYnIvN0RoU3NOT0JhMDAxODRsVFJx?=
 =?utf-8?B?d2hUc01pbVNWQnowa3ZIdklpc25kZkhpOHkwa2pkU3JrZ1JnUjFEYmMxTEhl?=
 =?utf-8?B?SUdDdC95Mm1nSlh0Mis0OXZvUVM0cEJjMjJEb2FZay9YVzRzWC8xamdFMER2?=
 =?utf-8?B?cWtWeHdCcjdVZFoxK0NWd0I1NVMxYnhEbGhGZjZnVDMzQ3ZhazV0R1JnMHBq?=
 =?utf-8?B?YW5jTEdiWWVNTHRMRzJpbFpvVFZqR1puZmMrRGl3VVYrTVpFY3E4dXRqeWt6?=
 =?utf-8?B?YTJXQUlIclRDMy9jS3JTN0FsM05tTmVwQVV3Y0xLVGxmcGFrTXNpN3RZSmpN?=
 =?utf-8?B?SzNBZkVxZlR2SjY0eWIxRGcwNjBPY1VPVGNzZm4wK0tUdnQ1NnRsMjE3VUsw?=
 =?utf-8?B?S0FoOWhZbFJhQW9pQUErRFBrcE1JUTlFSkw4YjVjNzFtWHNueUJVWkZITERX?=
 =?utf-8?B?M1psS1FJVEVnZWFjYy9hdlNaR0tNQU1PTnhuc1N5VnBDWGRFdWxQS0tRamY3?=
 =?utf-8?B?dkJodEpjbG1IaDdRMU1GZGtDblJFdmdTN1ZtbzZ1TjJabGZEU3lmQ1BpTkNZ?=
 =?utf-8?B?aVF0K3N6Yk0wNHFRbWs1Q25HRUZmWmo2NTRLMlFySWlrMm9nSUd4SWVnSUdC?=
 =?utf-8?B?M0ZtbUxFZTFCdU90LzFwaVFFeXRyTXYvWi92NFh4Snk2QVBIR2UraUlnRmt1?=
 =?utf-8?B?T2Fka0swdWk4eERXNFZ2Ukw5VCtaeFRGR2ZySzZ3M0VvL2Y0eitTcjhYdEQx?=
 =?utf-8?B?czczb21zbmpnMGZmcmVWY3JreFl6SjJ1Nmh1Mno3Z1FVTmpZQkJOVGxEaStW?=
 =?utf-8?B?Y1ZmWjVVZXZuWXNjbmFXZXFXbjhaZHVKeXAwMzhKMFYvQWM4aW96ZFdxY1ZD?=
 =?utf-8?B?V2ZQOHVETWdrUDRuVE90RnorSXJLY2cxb2tkOGtIcktCYmgwTTUyREFUVVhh?=
 =?utf-8?B?L0wvZFU4emxNSllEZnM2ckEyMTV2U1U1bHRtZDRyVGRwczA0aEFLdDBWdVl2?=
 =?utf-8?B?WTZ5bWFwMEI4T0tGU2IwdmV2akgrY2ljT2h3UDRSOTJxSVNSL2dpTEpqRTk5?=
 =?utf-8?B?aDNRQU5ZTU1PaU9kQ2psTnNrZFBFZnkwakVLVHRCOVJJdWtySDRtRVU4RHhZ?=
 =?utf-8?B?ZWMweSswUGx3L0hXN0RudU9OMXlxZU0xVVJOSkZTZ3NxWGdNVW1Xa2tWZnJs?=
 =?utf-8?B?ZVY3MVNFNSthcXZaSWNNTGd0VkRuTlRNSitFYk5tVFJ1TGl2dkFSREM2MSsr?=
 =?utf-8?B?U3AxRlNyWnJRbjNrdWFoUnIxUldKQ1F5WTN3QzVudnduUEc4NmVMblFyNU0r?=
 =?utf-8?B?K1lnR1BNMEJvUFRFb2JSdXYxb3RwVm1mYVBEcjdHTHdoaWlZcG11U2J2M1I2?=
 =?utf-8?B?aHVINnVOaWhMQnVVb1UrVWo2VlcrM0ZSR1lsQm5oWGFTZjNNbHZ6SFNKekxJ?=
 =?utf-8?B?MlpONUR4bkx6TXQ0cElwL0RMTDVXeXlMZTZEOW11ME9hNHVHY0JmWFdjTWhL?=
 =?utf-8?Q?Z/g/Cs7RwGzpu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBtb3NKQzRqME9BQmR1UkdKRnBTZlFTWEJnQkRxTlJ2QkpOakNsNFNpUDR6?=
 =?utf-8?B?c0RudkVMUjMyNzlsZytKM3hqZ0xZNk9yTmR1dkoxWXgzMDNuVG1yR2Ntek02?=
 =?utf-8?B?cWVxV3o0T0FsTHFsSmx1dzBmQU9Yd3pXczkwMEVhTzdHRGpjTTJrZW84MmhS?=
 =?utf-8?B?K2FGYWpOUWlCZUE4a1lUVzVVZEN0dUV0NUM4dmVQMkZWLzJCZHVweDlEWm5j?=
 =?utf-8?B?RDJDejVSVGNNdWJCeURuWE5TcFBLb05VZmNOWnBMSElVditpRFBHZEJEWGNG?=
 =?utf-8?B?Qld4TFd4N1prODVRSmZERDI3bXNoRUo5UzFIOVJuWkRxUWlFUlMwMlpCRTND?=
 =?utf-8?B?M3d0MDVvczBzb1BxZkdjM0RLVUpsR0NzT3JwUEF2Vy9HVHBRamRBb1Bhb3N0?=
 =?utf-8?B?ZGhCbGJxeUxlbzNuR3Z6SGZFaDV6bVdUbTh6YW10VTVqWERkNnhWSVp0OXpq?=
 =?utf-8?B?cTRzWXhkVXVCOXFwV2d4R0xkaTU4M1hvYlVzaFNwcmJLcEI0V3pyQ2lKK0Jl?=
 =?utf-8?B?cVgrQXA4WVdqUEY1cUNUMGV5VGkwbGZtZG9IV3pKV205UmgyK2JjMGhlRyt3?=
 =?utf-8?B?YlpNbjYzazdtK0FjZEQxeXlOMU1NVDhCZEJrNEczUFVaVFFJeEhIQXE3eWxE?=
 =?utf-8?B?VklNRnIxTnEyUjBacUgzcWtWNFdsWDloSjI4RFZIQ0UvQXBCRi9vdjBqdWla?=
 =?utf-8?B?NGZGL3pjS2JJMWE0QldvSUFyQ2ptOVhPYzcvemkvblV0YUVVelZjTDc2MkRp?=
 =?utf-8?B?cFQvN3VWZk9DaEpjbW9Bc3lDQkluMzJGREFPM2IvNG56NXFhY2lqM0tjZlVv?=
 =?utf-8?B?NWQxQVJOem5NbjFzZzcwVGdWN2FIK0ViYUV4YVo2QWY2SDM2NDhOUXcrRjY3?=
 =?utf-8?B?U1Rxa0pHQ1p0cnY5OGhRSVNwcHE3VkFBYkZ6MW94ZjFZcmdpMlhkRFdEdnZZ?=
 =?utf-8?B?OHJmVkZpaVZHU1NmU3hBWXJmcW5ZTUNtbXFXbG5QOGxBeExXQ3c2VmFlVUxF?=
 =?utf-8?B?U1FOdFF2NWk1bmFkQmpONzh6UHhKQUNPc0lSS1EwNVVwSXIxdXFtRThEa0hr?=
 =?utf-8?B?YmRWRDVBUVAvalV4ZzRtb3g5U1hycmVTdEVzak1NeDVlVWxIaWN5OW44RlNL?=
 =?utf-8?B?NU5CVUY4T21uRmp2M1R4d3gzSlpZZWZDODd3eEcxUTlGZjRaMmRNSHZpdEdz?=
 =?utf-8?B?ZDZWdnYzRWF2WnZPNVQxbU00M0hKYVQ2eThYVWdaWWQxRzVvWEtMeTJ2Qy9m?=
 =?utf-8?B?MlBpbzZDU05ScXMyc0hrNGd1b0J1QThITktUemhyQmNjV2VML1UzM0V1a2Fs?=
 =?utf-8?B?cGxURGRENWpOOWdxV05aTFk2ZXVUeFJ4NXJJUlNHcWZDMGxIVTRVYTRnc09V?=
 =?utf-8?B?eVFLcTNEWE1vV0lTcFBSMU1TZ1NYNHYvbUpjdGIwaGtSN1pLeVIxYUdPR2pX?=
 =?utf-8?B?b0hVbkJvSTFxTDRFeit4UFdPMnVjSG1qbHBpV2h0VEV2diswdFY3ZEp0dTdw?=
 =?utf-8?B?T1VGNVNYeERoc3VWRWN6eWZFN3Bma2FEQVFyb1hyYUl1YzB3TW85K2tON09q?=
 =?utf-8?B?L2NKMXhrMW5vSzVseVBYT3R4Zm1OSnFPZGhjVkxxMGpieFBYQWdJemVGbW1B?=
 =?utf-8?B?SjRvamJpZURVcVpjY1AwcWowdlNrME1IVDFlNjd1OC9FLzFJZlRzK1BVdzk4?=
 =?utf-8?B?eFFDc1B6bGpKczFhY04xRGd6bnRUTWlPVEd5RkRYaWRmS3R0ejJZbGhlUFpT?=
 =?utf-8?B?VEFhY3RsbkNRa3lWTmJDbzZZVlNQZXd4ZmZIaEhPdnRySExiaTFJQjRGcGZC?=
 =?utf-8?B?cEtJQm5ySHJjWDVDUkhhTkVaWTNmS0FDd2tVdktVU3phb0UwUXZZMG45V0Rz?=
 =?utf-8?B?Z1BIemFqaEFiaHg3NlN2TDUrNlloWmdvM09tNGppR2pFN2ZiaFhsWnE3a3dy?=
 =?utf-8?B?MXJFWURZT3pmcnFYNHorUE9HbkFBOTE1VzdGU0pGcDlSdE9WTlpVV3l4SytK?=
 =?utf-8?B?UFRUc2xXbFdtWTlycHhsWklIY084cjlCdUlHMzIzQVdvc2NQaUZMUXVUSms3?=
 =?utf-8?B?QktOb0FHcEF3VUpWd0ppY1NPTWVQTlR6YjBoaFY0NmFmdDZYN2JZaFpVcHdV?=
 =?utf-8?Q?yVALMKQEsk+2gFKQU8aJ48XiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a08217-abf9-4175-a619-08ddeea2799d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:39:35.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgBCrjVR6Y9YKlJL9MneSTSc6U3POOnmHNIi9UZJy+2QwY7Ug3V5MCp7HFrF/CoC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679



On 9/5/25 20:30, Conor Dooley wrote:
> On Fri, Sep 05, 2025 at 10:41:47AM +0200, Michal Simek wrote:
>> From: Salih Erim <salih.erim@amd.com>
>>
>> Add description of Versal Thermal which describes IO channels to
>> be binded to thermal. Constant channel of "sysmon-temp-channel" used as
>> mapped iio channel.
>>
>> One temperature zone is used for the AI Engine temperature monitoring.
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
>> Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
>> Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .../bindings/thermal/xlnx,versal-thermal.yaml | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
>> new file mode 100644
>> index 000000000000..c374d7ae2d2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/xlnx,versal-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx Versal Thermal
>> +
>> +maintainers:
>> +  - Salih Erim <salih.erim@amd.com>
>> +
>> +description:
>> +  Versal Thermal uses Versal Sysmon hardware for temperature reading.
>> +  It works as sensor interface to be defined in thermal zones.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,versal-thermal
> 
> BTW Michal, what's the story with using amd v xlnx for bindings?
> Planning to use amd for new devices and xlnx for stuff sold before the
> purchase or something like that?

yes exactly that is the plan. Newly developed drivers or SOC will start to use 
amd prefixes instead of xlnx.
This is the IP which is around for a while that's why xlnx is still used.

> 
>> +
>> +  '#thermal-sensor-cells':
>> +    const: 1
>> +
>> +  io-channels:
>> +    maxItems: 1
>> +
>> +  io-channel-names:
>> +    const: sysmon-temp-channel
>> +
>> +required:
>> +  - compatible
>> +  - '#thermal-sensor-cells'
>> +  - io-channels
>> +  - io-channel-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    versal-thermal-sensor {
> 
> Drop the versal from the node name here please.
> With that,

will do.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Michal


