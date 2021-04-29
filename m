Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2936F0AE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhD2TsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Apr 2021 15:48:07 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:18528
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233984AbhD2TsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Apr 2021 15:48:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8P/19UTgV/jkTvuht7O/UrUl7sIhN+gG473e+fqadFqLmnT+/kasSsT34Tpwr3VQrmp9sE9vetiNRXKtx/i7EMw8QI0xYBBBcQ9KOmuFiyzrQNOvYvlOuNdtkaR+uMfLWJ26RZNLEWfVvadMtp3boZlZEHMBy8hMGwRhRWgkxgrkXASrFlfPC4SJ1dFD+750OhB4avjai/ApmzMJuJQP8zGQb1CqGJRcEBwBdJY0KD4ZXyUiUBHHyfnBZUuCPpqKWYKQmeUnyRUEXf8JeJ+3AuZ9/ueXODfARi+Fe2sZ2Pu8jPwtOzqjq9PbVFtUgUlwnqRcQmeguIdrjTOnx18CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEjun9L7td11rWYyg5qHN5rlM9zJwHwx3vAyhzhsLIs=;
 b=oKv1uV/wMOkbL16yfrd6nmEN0dM6IA9Aa2wInhmtSTUevTWBkTShDzcCTl4kmWU73Nf4gaGcm6/LLjUS2XljWnWfP+kQXq2Thkv7R5l7t76mu1tLb5gDbWJrRkF8MCt5l2X39gdx+0mp3qH1mZ5jldqDq/kUusj1EgZFFIzK7MlBaWEdOdSUQCQTmbFt/JYymQpq0xECTwHeKWIELdF55mI+3eS74gZcgzsHVgZ5rs71uCSytPpPvn+bj/XK8pitplDvPFfV8UVZtT1jjSIoqDRwaCF9FO48ls6vQxpUo06fZRvCBSzq3YUkqs7Qq9wvEBYTJQcLcelCz1klD27fVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEjun9L7td11rWYyg5qHN5rlM9zJwHwx3vAyhzhsLIs=;
 b=mp1xjlAKeq1Secqq0BA0GgjyUkK/6y5D6DjU54L9vM+RS3W+XBKfOV0asErL6gUzWV18dMbA9SkanjEHqf00wybCvlcmRUj+16ur3f4iIuJ2FD9prGDw4amdgJb/0urqCOtPPSiCXllnemUGpYGMyIEQ3qUPd33hCLzlC5bq+d8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 19:47:14 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%9]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 19:47:14 +0000
Subject: Re: [PATCH 0/2] tools/power/turbostat: Fix long time duration RAPL
 calculation
To:     Chen Yu <yu.c.chen@intel.com>, youling257 <youling257@gmail.com>,
        Kurt Garloff <kurt@garloff.de>,
        Bingsong Si <owen.si@ucloud.cn>,
        "Artem S . Tashkinov" <aros@gmx.com>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1619600637.git.yu.c.chen@intel.com>
From:   Terry Bowman <terry.bowman@amd.com>
Message-ID: <98b16cc0-f69b-d443-8a75-076a8117946a@amd.com>
Date:   Thu, 29 Apr 2021 14:47:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <cover.1619600637.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.186] (165.204.77.11) by SA0PR12CA0004.namprd12.prod.outlook.com (2603:10b6:806:6f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 19:47:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 336c2559-8f18-4edf-d479-08d90b47964d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254428EBAF9124F90A29EB8F835F9@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRoarT7J7k+VsVj/hTsfjr6lH5TO3tJQtNDhwZAgwTeQvIwHAK2nYDP4TNqxt3fEfxhwYqpMAVDp++CxIsmSsvv9vitEbhwgmw02eb/89NGP7az5lB0zFv26vFuo8iFpd9JDO5lLYpsJfZRO6TAyo77qepfROtbedRn9jw6fJAoXGa8CNE2XjhI/R7JQrPnS/nGqXECx7f2d61Z4RvDdXYxNonwxfO8DbBOp16heQGKzuOpL9Ebug1IzxtO66CrqLsFsbCkmWv8Xn71x17InvrPhzMqE/Cdrpo6cx0fEO7R51GXEQRJXs8tWEk3BFdiNVvPbrRQEg9mMRpCcUs1VtEC5WX3bph5Az5z8db7zaGnBRANv0ffpF0P7VFmdOasej+nPw6Y0hU98p3k1OaOeCl86gl6e7pIoJVXKHldiqUqK+cF4kKQnqT4em7NYcC2AL6TGPE+bCuPdS9wuDeRyMm5hxI9buBgO11GCV0kfSJt3d/oV4CR6ekOYoxQLXS0YTdy5YF6KizWnHs+uCwAzKLOknXc14uX4dPWThvfTBzoXmDlwXQDleUI/oqFTsVAXMzGH/tnbYlUf1+ex3T0600rGkhZwAfhxAoVt9Gy2ca3gCNh3hC7VF/QzNk/yl0VVXgHQ1dBOIeq5o0ho4b2nyeKNO8VziQSqN8CYxnF/sIeETMbDN8yxY6BU7EKuCbwa1pz3Sqe8wNrPDLpvMj2xtHAMBGjkvz8LkfaYfZPVimE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(136003)(346002)(66476007)(956004)(44832011)(66946007)(66556008)(52116002)(26005)(83380400001)(38100700002)(38350700002)(2616005)(4326008)(36756003)(31696002)(110136005)(6486002)(316002)(4744005)(16576012)(8936002)(86362001)(478600001)(16526019)(53546011)(31686004)(54906003)(8676002)(2906002)(186003)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z0Fmb1k0RUlGcXNRdllZVHhSejczeFNwSjZoczl6VTg4dXQzVEdMMCtMWm1z?=
 =?utf-8?B?ZUFETVZ1NVU0QkVHNjN2cGUxYUkvZitXV1FPMXlHVVpWSElDUUR3VkVyaHhy?=
 =?utf-8?B?YTBJUzBwd0RIcFh5Y0doVm5Sb09Lb0pBTTRkUTAzaHJMN0VGclVldUd0bWI1?=
 =?utf-8?B?bzJCTzd4b2FhSnJtVWRmQU1LMUEvYzRSb3A3Qko4M0cvR3JyNkNDVlNPSVR6?=
 =?utf-8?B?RWZ6VFJoNmFWVGRCeFlDTXI0Y0hCelA1a244L211MWhvbGtIUDNXNFNuY3F5?=
 =?utf-8?B?U3Avck9UOWVWSFd0QVFzK3ljQjZaRFk2NTgwYkwvRVdhZGdZT3A3eWlJWGVD?=
 =?utf-8?B?ZnpTb01RVndBVkx4cG81ak9lV2s5RWNJUW9RUlhpZ01ManhrQ2dKVytERk9I?=
 =?utf-8?B?bkt2eHpqbXJnMU9xNkpMTGg5VmFFNlVUYmIxUVBHU3ZBM04rOGRjN3ltbENm?=
 =?utf-8?B?SXR5WlExcVpkZ2VyS2I3WFQrY0NyVlRPWktnSXpMTS8xYlFES0FqL0dwMGh4?=
 =?utf-8?B?ZEd5SjJVaXNNYmpLRUUzTWVhREZGVXhRemlsam5CaklZTkUvcFBDc0Q4MjVo?=
 =?utf-8?B?eDVUVzBtN2VQaG85dEpvcVAwbDJPRnl2Uk0vMDNqUzZPc0g0c2tXbE9ZbjZh?=
 =?utf-8?B?WUVPQzBKOWlkSDJianJJNkEyMEhjYy9jbDg2Qi9vNERCZHlzTmJ3YTBFQ25l?=
 =?utf-8?B?V042OExxVkFuMS9oNjJydldOZ2NVSzhtUFdGRzQ4WFFETW5RT0R0ZVNadHdh?=
 =?utf-8?B?L0w5bzFHMHlMa0V0SXdEQUl0SHFyMzBmc3cyQks0d0lIQUxOdDJkdmwxbkxL?=
 =?utf-8?B?QnhXYVRRQ3JURjgxMHl1emNPbis5Tzh3UWZLd3VYN0hVOTNpNGMxcVRzT3pi?=
 =?utf-8?B?bUg4VXA4Sit0TUtnMmI3T0Z1SUtrQ1hZL2VOSGo4QnJvRW80dm15S2hZdkRZ?=
 =?utf-8?B?eUpoRkY4WE9ianBYcE45bERyQnZFUHMwQXZ6QU5oT1VRcTBTVmtLemxpekxw?=
 =?utf-8?B?RXFvclAxMVNEaXJFYXI5Y1VES0c5QzFDcmJkTXBpNlpENlVld0xyVzlBRzNm?=
 =?utf-8?B?K29YWHkwVWNiY0lSV2NVMkc2c1dLaVRoY2xyVE1YSE16a3c1a3k2eVhvdGhv?=
 =?utf-8?B?Z2VhbFN0WGd6dGlFWHhYQjc1bjhjK1dhS3VEVkZFd3RFWXpheWk3blZBMlVV?=
 =?utf-8?B?UDZGQmVzTXZwWmhtcFphR09rOG11dkM3MEMvcTNpK09pMCtUcU91NjhYT3Z2?=
 =?utf-8?B?djUrMVUzRFNNcnNPWG5aSEo0NW1kOWFuWnJycGxTTmh0UklrbnNqREdiMHY4?=
 =?utf-8?B?VHRLa200aVowcVZBVXRTZ2JPMmkzeWd6VHluM2RSdGt2MFlsWUJFRkEvMEI4?=
 =?utf-8?B?WHBjRmhOTlZmM0RCUERTL1psM2pYNEk3TEtrSnJJVHRFby9YWnlGdEZkRnI0?=
 =?utf-8?B?RnR2THRtVDdRbXNsRWtyZmNoOWRxUG1DdktKTWREcENvaHhZdncvT2pvMXRM?=
 =?utf-8?B?Ym95VEdCVVZLUG5kK3p6RDNBTmZGOGxnZWh2VnFuYVhPOWFIU2hLbVJwK2Zo?=
 =?utf-8?B?SGVhQXl2Uk04MC9mUC9Ua3F4SkY2UXJLN2RoYXluWFpibzFwWnR4aTdsbC9J?=
 =?utf-8?B?RTdJOXlZeURxZWpadDJHS1NqYXlQeXZRL2h5YTB2cWdVNUlaY1hqRDk3TFR4?=
 =?utf-8?B?SUFUWmo2OFVtQ2MzVDQ0eDNsaHprNTdWK3JjaVN5dStoYjY1MVkvNHUyRlBm?=
 =?utf-8?Q?MK5XqajPA6Fk9p+vN2vEeUGD7x6Sem3lXKlB7N1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336c2559-8f18-4edf-d479-08d90b47964d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 19:47:14.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4PHLGZq0opXvqzvy7NP5c/hYxIAGGkkWYeq62aayrYsKw0a1eB39GXz73crkBBfnneZBJG5PAEGd/doE8ciKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both patches look good to me. I tested both on AMD Epyc Rome. Iverified
the missing output is fixed and used instrumentationto verify the
sign-extension issues are resolved.

Please add:
Signed-off-by: Terry Bowman <Terry.Bowman@amd.com>

Regards,
Terry

On 4/28/21 4:08 AM, Chen Yu wrote:
> A combination of patch set to fix the recently introduced long time
> duration RAPL calculation issue found on AMD CPUs.
>
> Youling, Kurt, Bingsong, Artem, could you please confirm again
> if this patch set works for you on your platform?
>
> Bas Nieuwenhuizen (1):
>    tools/power/turbostat: Fix turbostat for AMD Zen CPUs
>
> Calvin Walton (1):
>    tools/power turbostat: Fix offset overflow issue in index converting
>
>   tools/power/x86/turbostat/turbostat.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
