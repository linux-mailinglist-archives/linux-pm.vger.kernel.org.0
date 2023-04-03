Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B346D41E2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjDCKXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjDCKXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 06:23:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B01981;
        Mon,  3 Apr 2023 03:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JciQhlUbqGmPYwk0iCt2hEaluxvYHbSrp0HbKuVzco+YC7wVjslHfx/W6djGnan0BevCUEHUFGawakC+Rd7dwNbhggS2/dDhzhJUkKuaqIG7AY61poTc2hWwn+jivdz/yJHB9FTk/ooQ0M3mYEXHWqK8h8dO4155/WSpkzk4I0uFj51kCXMeb8HHUPN5Rk430yCSIfSy+NPe4wDvtn8W8IcgiPiLTtcz6eklaPyABfeiwNsW/SomhCeySK0UmF9fIK+NZOdd8NOvsYgHmGb5e0v8LetClvHYakO6PUdK8yk8MzYnDGtm5Okygf02KKYQJW5mnQ3y2mWu0ugkePDRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1m5tPGc+ZXh1fYpWlABbyr2vbKVIkNc407RfMRTwKI=;
 b=oR1+7lm0B7QZeKXkpuPBjDaQClF/eCO+OyUBmq0HiUARchLT1Ya+90zXafK3m8iWwHLzFa4EGIcQqcBGQcF27TlD5RAK6pBXQ4lFcrSKdFKfovp5PQYJTUO9Ve+BiVvgKwAIZl9HAa6+j+PVWnoa40uHYym1K1EM9Yk8i3DzuvsauVeIAiAfnJu5q/guNURappz+PR0iYalvIpYUEGQOvn3zSZ0CR6VV3eUc8uYmAPhvsqQunJwNFZLhxLo0VhLF3+6r0S9NwojcI+aFf4kz+pIxKLnowIgKunzKjWugMyiDkT/dbjeXLfIYdpnoo2un+HPeZLSfNl390swJlFJF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1m5tPGc+ZXh1fYpWlABbyr2vbKVIkNc407RfMRTwKI=;
 b=rCatHO1YRzRIFwXDA2OV3qvufRYqhL8mHZXYJcWwP75Z/nGGZYHUx91wBha7eAyyG7VTmIfsgZEzxkiBuTFXs0mOzBGvp2o8zdBXiEeKF17xgR5fS517uUKkDSshUCxhc+OBOk/L/9KwcZIkQR8LD6OjVu1RL+TPa+eh//TUq8D4cXaDt1yZleqrRfOuZhpvECff93Ncd+FJ3z2IzbOGmIg9ymtIBIaV8LKqNWXuDF7qg/9juC/q9eAog3mb36zHNv5Bj5xaTdbm8pxWMKNfDzFwZaAl4vzuPCmTwjnmIRbys0AYmcchRiJJMW+9AZ7CLMey8eQvCbpI8tfH5ubrrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 10:22:59 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5dbf:5052:da60:647c]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5dbf:5052:da60:647c%4]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 10:22:59 +0000
Message-ID: <d7435a96-3480-280e-d996-73fea690c373@nvidia.com>
Date:   Mon, 3 Apr 2023 11:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
 <Y9KTrO+WqJJwuEDf@orome> <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
 <Y9KfcSwYt7utbcg5@orome> <e716eda4-edfc-5946-4e6f-42aab5f73b0f@linaro.org>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <e716eda4-edfc-5946-4e6f-42aab5f73b0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0221.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: baa0caaf-a5df-474d-d3a5-08db342d65ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BeTpmoamrFUwOLv956k2VUxhefPG7TQTQWwCPTexvBo+uVKR9co9eWKtsjwL3IFtc3DUUCemTTS+6wTYSVFWr4lCY0/ih6DGR3e1+0f2Hgu52RIDI596qH1Nh54T941LF640xkMYLm+62/ZQQXaGRaMDuETGFviSS4IFlcu7xMGLhXNFG449U96tMpB1FuJqXBigl1UiMY/F+ajxupycEYZaVi5zboGS0wgGXhAZNFlSA2nHd4AfhrhUElA/laDGQdaD48yEtSun02eE84UWE1HMig86lrMlF1D89B/EleB7BD8dLymss3EhQzDZy2TH0nxxJrRHnqrblqBfH4+J2utQ1NsIbmK+Aa5RS4+N3eG3hbrvgK2r0h9wq83aPte4EJ1fjho6jgH9EqESyjXLVxYLo+ewyL/aBE5y8uRot/zgl87f2r4obiZC7X0H31XgAN8u4LhPw+2bA5pE0CtTP02AGx9IKc2GcYQt1JHF5Hid9w30fh6XnqV8yiW1HxnJ+gJtRNMPx05bGQpupU4GICFVA25ZAFnH/rQlH4l6urA7j8fdeeCH9hx56kAHcCHUXT5LkR24G+C4SyUKJXit6pZnfkOdNkKbS8uvUH1WZ7GfXY+wEgDYur4d07cmxkZFHAZr5mlDApRSOIiySeR9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(31686004)(2906002)(86362001)(5660300002)(8936002)(41300700001)(66556008)(66476007)(66946007)(8676002)(110136005)(4326008)(36756003)(6666004)(316002)(54906003)(478600001)(6486002)(26005)(6506007)(6512007)(53546011)(55236004)(186003)(83380400001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpNc3FEZUVPenFSS3Zkcncvb1h3eHRmUzRzbzdVQ1hRbkF4ZjR6MmNpZDlX?=
 =?utf-8?B?enVmQnlsd2hTZC9xNk5mdXBmRXRSS3ZTMUsrRFVhYzBFUC9GLzBrc2ZvYUtM?=
 =?utf-8?B?QmRhOGhmQ3BERG5rRXJZL2ZkRk56UVdyWGhBd2dkRXN2dEE0RXpQNGRQTVVx?=
 =?utf-8?B?NVdhR1A1VzFmTDl0ZlI0VVF3VXVKWE5JNkM2QVR3UHExSUJHSGZCN2dkVnBu?=
 =?utf-8?B?aWFRS1lMMnAyZ0FvclJKTDQ0Qm1wSzgzRjA2Ky9pdllkM2hHakMzWGQ3aE1S?=
 =?utf-8?B?UktZamswYVNNRFRVWUhNZnYxQzk0dGpPNWg3aXEvWWUrU08yM0pzdWRRdk1n?=
 =?utf-8?B?NTFUK1FIaVZybC8xWUpjVjhxNGtkWnlxd2JXS2piRTR4ejNnVC9KaUJaR3B6?=
 =?utf-8?B?RmRpRWo1S3ZWYitEM2h5UTh1OEtzOURiNGg2VXRTUFdlK0Rsc3V4WmVRZDdv?=
 =?utf-8?B?Q0Y0MkE3anVmak9yMEVBT0lYTmRvZmtFWXQwbzFvcmhIZ0k0OFVwTTlWWHlS?=
 =?utf-8?B?VnVPNURyUGlPK2UxTUJYcWhPM2QxQjF1amtLOUV4Ri9qOHRFelNOUGpCU0NV?=
 =?utf-8?B?aDR4VzNzaDkrcWpIcnloTjFuY0xpcDhRWEZpblhjeVl0UW9GQ3JvM3JvWDVC?=
 =?utf-8?B?QXdsSGN2aU0yYzdUSFpBdk1HQ3NvNldRbW9FdTlBOGViNHlqcTlrTmViS1dQ?=
 =?utf-8?B?NFpiMUlUZlRvYzdZUnROL3I0WGRQbVQrUnZaTVBySHJnbGF0ZEY5QVQwK2Jv?=
 =?utf-8?B?MFBML0IxSks5TWNxazlHWldPdDV5Rk81dWJobTJLekR1aFltWEVWUWdoYmJx?=
 =?utf-8?B?am9RVFp3RGZzSkZDT0VUMkY3UVBwQUR0ZW5RY3dzemRCa2ZETEVkcUZNZlVt?=
 =?utf-8?B?K1RuYlpHZDBXd2NHMTNreHExSHUvUUpzbmI0TnpNMUp2dDRmTUFSQTZDQmVG?=
 =?utf-8?B?ZWxpZVIxYnJFdlFOdDh5ZEpNSVNRb3liZU1pVmh6MkkxY1lZaENrL0ZMMnI3?=
 =?utf-8?B?OWRySWdFQnljdFR4aWlxVW42R2RvMlpaSTlTTEhJV3ExbXQzaUJ4Q3lkOGht?=
 =?utf-8?B?NDVzRnhMQXc3c1E3YlBZQ3A0TGhLQUdNdm4rMzh2djY4K0d4QmxrR0F1SG5v?=
 =?utf-8?B?SmRvNkhmRGErZHFsQVNHWkVvMDlzZjVVNCtqWHZ2TTM2V1NscVpZWlo0Smw5?=
 =?utf-8?B?RkVucmtwK29ld3FZQXJzVjBSVDhLdWlCN1dyOGY1bzdES2JhWnNEdlQyZW9D?=
 =?utf-8?B?ZUFYVXBSQ1phclhnTzhYOHFma3U0WE1NQTdyN2xyUzdtT1Z0RUZ5T05Oc09s?=
 =?utf-8?B?c0lBUGhEZkwvbnUwUk1UWUFYcWs2bG5yNVJCMWNCem9ZSmR6L1FkWVpXYXNu?=
 =?utf-8?B?SUpuOTBhcTNjbkxORGJneFgwL1ZrUGNycjROaFRHWU5GeEJlTUxFN0VzbklD?=
 =?utf-8?B?aHFNTnlPQ0FYOHAyN1J3OFQ2S3FOWjJPQkhrdGxkbHR5Z1pXRkc0SytlVUMv?=
 =?utf-8?B?TlVJajgvY3VYTWIwWkJLL29EUmF0NExlak9NUk1Kc2FsblFjMm9NdldYaGhj?=
 =?utf-8?B?MWdxOFJFclJKYzQ0ZmUrc1laVis1NXdZcyswMnR2RmxpS0UvUjE0aWhmTVJJ?=
 =?utf-8?B?aGpFWnp4QWpJMXk2MUUzUkpybXJmMTk1Y0Fxd2x3SFdlRUI3RXZMTW9kZENO?=
 =?utf-8?B?NDVuWjRZemtwTWkwLytEQ2ZGYjdUbTQycEFYRUlHSGl3Z29RbGlLUHRKTStQ?=
 =?utf-8?B?djlaL2dUR0FQbDd3ZU5lS2twN04xTkdwN2J6dWMvM1JMZzdjditycWphbHlZ?=
 =?utf-8?B?WTMzRDc0YVhha2hpUC84aXlzcWFCQXA5K3hTTFBiYW1jbWdFclNVbUY3dks2?=
 =?utf-8?B?K3F5THVsbDZPZTlyeGprQ1Q2c25Ed1BGeDJwWm9TVmRjQTJGRzdJZTZwZkpp?=
 =?utf-8?B?cWJkbnpWZm96aU55VUFkWFJtdC9sN2Yrc1BSWlhMcXNPTmNXTVg1UXEwUkND?=
 =?utf-8?B?c0xyUGQ1N2xWbUNYNFNYdFBqcUw3UG9CZDFZWnpLTjBVWXBpZ3BCUFJuVWF1?=
 =?utf-8?B?NUpCejd4akM0alplRUFVZEYwYzRMTm5HNkZpZVhCN2YyeXVZSzVRUlBjNm1P?=
 =?utf-8?Q?hJ692mEY9fhnzfgaeUWxCLRi3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa0caaf-a5df-474d-d3a5-08db342d65ab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:22:59.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRHvkYsariyI8SVGbRGLqOSwJoI/OHwhqe54v0LPSOj/9gVfCVuRmM5UR7Hy3NPVltOYo5K550YlndvdcMVQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 26/01/2023 16:07, Daniel Lezcano wrote:
> On 26/01/2023 16:42, Thierry Reding wrote:
>> On Thu, Jan 26, 2023 at 04:08:03PM +0100, Daniel Lezcano wrote:
>>>
>>> Hi Thierry,
>>>
>>> On 26/01/2023 15:52, Thierry Reding wrote:
>>>> On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
>>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>
>>>>> Check if BPMP supports thermal trip points, and if not,
>>>>> do not expose the .set_trips callback to the thermal core
>>>>> framework. This can happen in virtualized environments
>>>>> where asynchronous communication with VM BPMP drivers is not
>>>>> available.
>>>>>
>>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>>> ---
>>>>>    drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 
>>>>> +++++++++++++++++++++-
>>>>>    1 file changed, 51 insertions(+), 1 deletion(-)
>>>>
>>>> Applied, thanks.
>>>
>>> I prefer you provide an Acked-by and I take the thermal related patches.
>>> Especially in this period where we are reworking the framework with the
>>> thermal trip points ;)
>>
>> Sorry, my bad. I misread this as belonging to drivers/firmware/tegra
>> which goes in via ARM SoC.
> 
> No worries ;)
> 
>> I'll drop this from the Tegra tree. Feel free
>> to pick this up:
> 
> Ok, thanks
> 
>> Acked-by: Thierry Reding <treding@nvidia.com>


I don't see this one in -next. Are you able to pick this one up now?

Thanks!
Jon

-- 
nvpublic
