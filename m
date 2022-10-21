Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00945607470
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJUJui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUJug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 05:50:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B517A02E;
        Fri, 21 Oct 2022 02:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGILUnfIt1N8WfnWFanyVimwnXaz/0YWaKuYQhIgvRC2Q4SgQQAAnRFXq1YaQscipEWnr5zVB6JQjExXHcC3u2UvmI64xjLd+nSBghc18PhCL1jSTGjEjSDx/HtCYtIPYuy62Anb2JCZaalTTkpx/Id1MPgoVvada0V+6jF1DhES5If48+/S+EwMmnqeA3yvL7h0v4zFogIpdlyp/GdE3Z6Z3TflCiYcaN21aLGuUmp3u7/kP0v7AFNdg2bujEKaHMgqSxwNWPWrBorKP79MD8JPuTOSe97X5mdYal8VZDyarZOy/vifJPF5H13kxN8LCOUpDqEJlxvZQC/+jdT2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj+vnA5vYZ+tYtKyTZdchmsOMkb5wEjvWLUN7LLrQHI=;
 b=CoozlghMxpVkfuXv+K3ycBefZubHGepAa2hFp9fdM8UWUVR3vazetEzyYs0NdvOAmi/doxcIQhMFkZNXOLKFWdzV/oIpxmGX0uDlC1EgyIB7hCyyvzRJ04thnHqUCo5KxAZ5zx+3cHu7JY6TDiDAwXN21PT6FvsaQsTPw5WVcStjn1lQ4cd5PK3afCKW5AtlFBmKk0DYARU9FLSfFlnppmyDu2+JOJ+MdKsCKXg1QWoimRUWe1wjO6QmxOwU0Fl9paPkLm6ZSlFjzw8ArN2olLsqEBuajf1cZ0SFI7lZcL0s6nTa79e4gpWkLxTtDxCQw34nmAy0wtO8rOINPbDXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj+vnA5vYZ+tYtKyTZdchmsOMkb5wEjvWLUN7LLrQHI=;
 b=nPJED2ftsHFCsHJzx0Tu9EmdXgnEXJecfEQ8qIt8ijPiD6/xmRihW3vpmzMfCykdPTXr7inl3RQs70pMfdkq8UtpWyyw1wJkO6Cspq3rSoKJDwVHKMarJmGPvBQcifyPm0uSFivs+O01UoZLec+CTfb8SE/aMWTNVZ7zebkXEpqDstdM8Ut//jeipICYIwY5G9lUHjJBVcI3Xo6GBe5inx7JG4fy21NadwjoUzp2q3CfutfnNQ7C682klfvGcvDNWniLFfG99xf9ejJuQoiYrJMweJ2GpCsEhWwM/64VMtLX6mFML5JNNbem8//0miKa3F4f5VClTbDhlyEbRpNZ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Fri, 21 Oct 2022 09:49:29 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 09:49:29 +0000
Message-ID: <afe68b2d-72a4-3fa2-af63-4f71fa36f846@nvidia.com>
Date:   Fri, 21 Oct 2022 10:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] thermal/drivers/tegra: Fix crash when getting critical
 temp
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221010150311.40384-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221010150311.40384-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: b38ed030-bfe4-4438-e8bf-08dab3498bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBbczlHAu0iSKDCBgTh1sl5iwRkdN8flaZUAlDbfrrDA/C51AADYyw6heEFxUSj/X6cTnBj1GbfjEOJPmhwH9NuGoCwQjfLucyIRgXnz4uBPuxovPpxi/S0biFoB8zxFhyfqNr4Rx0VAduoODAjMF/KIFUUydyENlH8Ota7oshGDv4k4DTx8qjrvmHLn2lDgmKxz3bfHBkaTZaP3mpX4Y5bYjMPHdgD4zvZwMhgTp9yOAF+ZON3je7X5bL2qdCQNw0eN01bsYbY1/BCP4yE2J1XboF0cryWuI1nupIiqLX4eW1oV+mVnaScXI3Wi98duvDB/zxN3T4UPW9ne39BCxOefEjzV22JLbbQ2MPZo9qgd7mKpgLcw2Kb2r3GtuDKRnUSK9yJNHtXSJtH6fL38kYrOqvz9Pd9NehRBnqHi9eJrasUxMLbk6vPm9fgFoJZhD5eaVvq8SdYaPyTPKQJbw6Wuus+lCVZBuJbLGlRQIUoTPZOaAgZu4ARrqYQCKDLsCTKQ7/ghwSVMRzQ5OWKvimlaqBavw8gJwGhVnie27btMHJCWLSzbXm8WYZwcZsD5IdV3neXQmsaB0zTRgHkrP8Wy12m8+ulhLbs88nalSeXYzOB0BcHhJKI0cTAo/r3ZuB7UzJ8GYIHyNM5z3vPCPRw/b+USNWXz3+rIaP4+rw+Pt5ohTo+d+xgpNY+e5dcCeF0ee/igL1HckfWSUhc7/wV+17RSq6djIknDDYwr5nwNGdZkofvVQCQKnujF071IkBCiL3ceAl9jt+8Mnvyo9bydNTwp8IP7xKlrDpxajXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(66476007)(5660300002)(31686004)(66556008)(2616005)(316002)(110136005)(478600001)(8676002)(6486002)(4326008)(6512007)(66946007)(41300700001)(8936002)(6506007)(53546011)(186003)(2906002)(83380400001)(36756003)(38100700002)(6666004)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBUSHFsMmFKbFFETTZibmR1a0g4WmtjMGllS2VicVV6TGtBYmdzRnhHZ2pK?=
 =?utf-8?B?aHFaU2pOdGRJZnZ2enVGa1dyQlRTMTZTNUJsMEpqZExaWWRxSFdrQ1MxQjFy?=
 =?utf-8?B?UW9MdG5ONGlKdlAyTGxrRU9nWHp6a0dGSEFCY3Joc245UG1jS1EvWEZaeURq?=
 =?utf-8?B?SThLWlFHRURvaGZqNVNmbDBlZEpIYnBxa1RnNUw5NUtnNDR6T3pDQ01KdHYv?=
 =?utf-8?B?UzBSU0t2ZW0yQU5NaFA3dHFpWWY5NGNpMVluM1ZaaXNFakx5MjkxOU5UQXpH?=
 =?utf-8?B?L3dkazU2UlVGTUNtd1NMUFVLa1U3SStTSVBRN3gwNkR6aEU2LzJBMHBGWG93?=
 =?utf-8?B?MzFSVGVnSzA4cG1IWU1WTVpueVJzc2crdy92bFhoQ20xUHd6VS9YVXhTM3Fo?=
 =?utf-8?B?WTJoTVR1RXkvUDNMUHhlaGw0V1FINHBjUnI4cFIvKzRyNERvMkg1b3JKVng5?=
 =?utf-8?B?Rys5Zkx2elYvR05GM2xqekdhbVBCaUZOUnBqbDBuZEpUOWRXVHlMOVdQWVhq?=
 =?utf-8?B?RjdUbVdrS0pscEE5SlF4aG81OTVHZXJmYUtGQnlGYXdnck9QM3l3L3RRK2wr?=
 =?utf-8?B?eTdEOThOb0lFeDdXR3lSVVJ3UGtFUnBJVFdDbnFrS3BhRGhDMjRBVzdOck5T?=
 =?utf-8?B?eEMxYkdNUG9JTjBFbE45KzlXbWxRb0JDTW12QnZTaGliUldTQktCTWhFaHhZ?=
 =?utf-8?B?anNPb1VnZTdOdE1NeFkyUGVleFdVMWdZb0Vlc1dRWGF1aFFwNDJLcm5JN1Bs?=
 =?utf-8?B?K1B2N0JEWEQyMzVYSlhoRmN5ZENHK1FYbWNaczZVdStSdldqeXJWaSsva3ox?=
 =?utf-8?B?anJuc0cwZ296anhzZnVYZFNNa3F1RDFuUnEyRGVSV0RhZS8xWThpbCtVencx?=
 =?utf-8?B?WmcxVGtzeU5NSTVnMnNsTE1ORWhXc2xYRmJLNnQxOEVHVCs1NFNuQ3FUSTRk?=
 =?utf-8?B?bVpSTjNHRWdCQXlaNWowN0d4UnltWi96VFVvbW5xV2h4SlIwQzdsL0ZBRFBY?=
 =?utf-8?B?dGl4VGgzcWxtTkxEdm1sREJhdjJZQ0FFVWdFZ3BBQnZrUHY4RTNVRGFHam5B?=
 =?utf-8?B?b0dObHh5NjdpNi9FbHJCSE83dUN6VlF2bm1FeU1rMkxscG1pOHRxTXRoSWJW?=
 =?utf-8?B?N1RaSVgwVUliUE43M2s4dVVkYWVZY1FHSVk4cVhDUkQ5UlVhVHRkcW9JeDds?=
 =?utf-8?B?dkJWdWFOdEJOZGR6UHlSb1dSNTR4dkFrSC9TMFQ1VFFMVmVReHM1S1YxNlpk?=
 =?utf-8?B?K2ttYWs2cm1ETlBuNFZBM1E5Q2JPMDkvVjE5UWJmZS9ZMjlHMC9oQW9Jajlv?=
 =?utf-8?B?MzNseUsrQUpEbWEzZW03ZFlyZ0gyUFNaNDlSWkhuQi93YklZc0d4VmhaR012?=
 =?utf-8?B?L3lqdDRCRmMrUkp2aXIyZFRNaG9yckUzMjlKRnZIMU9ZaytySVlVNUF5bksv?=
 =?utf-8?B?dmNreTJXeG4wR1FJTVlpM2l1KzBieWsvZ2ZaQlc1UzdrSmdJTU5sdVllME5j?=
 =?utf-8?B?bWlxUzJic2xISVVzVWswRDlEejZqTVBMOWFvQ240QUJTNUhCVllMd2lTUXBQ?=
 =?utf-8?B?QitwdjhTOW5oVlplWTk0ZDFwUXg3bGgvNjBXazl4TDRxUWQxU1h4aEZxc0tL?=
 =?utf-8?B?QXJ6L1JuSFBIN1hxcG5mMWlhd1B6U0p3WmlKY2FOaUw2L3dLZEhSU0pXVEQy?=
 =?utf-8?B?SHRSVTFOZTJ3bFVMZzErMkpkNWFEUjUzL1Fsdmd3Wk1jaVo1QWtiZjFiZ3Ay?=
 =?utf-8?B?QnY4KzhIMFlqeUpURm9MN3RORVR5QjE0VTVVSzJSMDhJNlJFOVpMTEpxM0ZY?=
 =?utf-8?B?TmdKYWtHdGlramRQOUZaSVpCd3ViTDUvbkpLTnVIVHpNU2l4QUtpUWdaM3Nv?=
 =?utf-8?B?TzhFUnRsNW5DS1ZrNGNsU0UzMEF4RzNPTkNWaTkrT1hOL0U0STJZaGFDWDZF?=
 =?utf-8?B?bXNUd2diaTdxS3huaTY0L2JicWVmVGlmZTNUTXphQllVZ01EbkVVb2V6NG4z?=
 =?utf-8?B?Zm01SzR3Wi9Eb3krNHd2WUpBTWYrSE1CaHhsK3pzYVpjUXA5eVlyQWsvSndQ?=
 =?utf-8?B?MnBtVHl2MDJJMzI3NTlYczFsbTVscjcwTDBORDVYei8rZFFEbElsUzRiSTl1?=
 =?utf-8?B?TjNZbkJ3NTF2MlltZDQzWjlsUEdkbTZKRWpFNTk3TXVnM1YraldoVGwrVEdW?=
 =?utf-8?Q?v42LK/uwrnrIbzJeyRgvF0fgtkG5t4QISA/eaq3dopbr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ed030-bfe4-4438-e8bf-08dab3498bdd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:49:28.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1jobRNhJhcp2fDUy3nlKFkiuligC9jp4MnSexMfVbyVs9KTNO8yVAWKdlnqHRKkZRqhFnctWb2ee7ckqT99vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 10/10/2022 16:03, Jon Hunter wrote:
> Commit 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
> removed the function of_thermal_get_crit_temp() and this is causing a
> NULL pointer deference crash when attempting to call the 'get_crit_temp'
> function pointer because this function pointer is no longer initialised.
> Fix this by replacing the call to the 'get_crit_temp' function pointer
> with a call to the function thermal_zone_get_crit_temp() instead.
> 
> Fixes: 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   drivers/thermal/tegra/soctherm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index d2e454902689..4203e74e2f79 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -742,7 +742,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>   	/* Get thermtrips. If missing, try to get critical trips. */
>   	temperature = tsensor_group_thermtrip_get(ts, sg->id);
>   	if (min_low_temp == temperature)
> -		if (tz->ops->get_crit_temp(tz, &temperature))
> +		if (thermal_zone_get_crit_temp(tz, &temperature))
>   			temperature = max_high_temp;
>   
>   	ret = thermtrip_program(dev, sg, temperature);


Any feedback on this? OK to take this fix?

Thanks
Jon

-- 
nvpublic
