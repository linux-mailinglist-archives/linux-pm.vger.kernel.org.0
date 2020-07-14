Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23B21FFC2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGNVNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:13:38 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:53984
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgGNVNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 17:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNnJLJhFhi+yh9bUFIrSqmFw/GExDnk6+voePrR2t2HJ42AhZ6THwj0uqlsZQXPdDICaEwux6WaEefAJIaeUT0b0MBj5XaZrW684z7ZSKLtI3mQxKu3g0MwPBqTE5Ldi0Kdd8FgdKfdH70cvgl33kYNUQEWAiR+pMAPtPphHsVyE4aGm1EEeLl5MQkX6FOn59vTICzANnKxoBwX17HZCqSlZV5+vwaX1iQ/txQwI3OpxFhx8CdfoyMewBfLeB81mVNUTK3igngT4dL6AziCu8CmMIvFRj6lIpXJ/fwRtFcz8y8x+a5Qk5onnO6KMlvMZ028SuHp+lQE4DhsjWxJS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjhGRwR4u0axIPgkha6M9AvWP6W20uXRNVX0N9UBbQk=;
 b=YSMyKOd+282+ZPOOzz4WC14LFhetprsd4+wGff1PhNTThQOQIjQMvbB+rtjc/8z9d7dHOUayHLqrh9vHH15jsR753Rqit3dweoWIPjfL9RDbMUh+4AAyBoxdf9hpWK/zzuasxkm9TuJo06yaKbnb7l2hXFAZeGC0SB8c09tFkve0uoOC5pRqRAMkUugFwZmekA9NeqNbpxzmkSw73FFG0TrSYCfZg0Y0GtbxEoO/wN4kXITH4HfKjdO0PQjKteiUO1Fu995siwHWzaAOeqEoO3aa0EKfGgftJvuSFOH6ycfQmiw8pSo/t7GNLIAEkanqbMl0q/RVl9wmB31eEOitag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjhGRwR4u0axIPgkha6M9AvWP6W20uXRNVX0N9UBbQk=;
 b=G7AYZYDTqfqgmKbWlhwNhYmtXQPsCygSI9z4YkU1/RkRb2XntrJWRrR57t0azp1mDM2fVIlLOrmg8ZVZ58kkCZ1c+BwINjfc777Gvdsom79hs0RNJ0Do04PjCFMu3saag3+CuQ8ufFM1Gav4IDwLakICOSCaKQw+i+jGD3dgtWQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 21:13:33 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 21:13:33 +0000
Subject: Re: [PATCH 13/13] cpufreq: amd_freq_sensitivity: Remove unused ID
 structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-14-lee.jones@linaro.org>
 <6101e041-41e9-22bc-488d-38124c139bc7@amd.com>
 <20200714210218.GH1398296@dell>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <8f7f2325-8c6a-b005-1f27-67e4b640da31@amd.com>
Date:   Tue, 14 Jul 2020 16:13:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714210218.GH1398296@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN6PR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:404:b4::16) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.5.212] (165.204.84.11) by BN6PR2001CA0006.namprd20.prod.outlook.com (2603:10b6:404:b4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 21:13:32 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b3e804f-5ab9-46df-a285-08d8283ac3b8
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0209536BE641DC518284941487610@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsMf/Yy4lfGmstk9in2OWb8H3BbsuSBuf66OQkGsu+tkP4RQvh6coV5+s16jCp6ejVfU9QN/+CK+PnGUjoYe86+ycChdYGOO2cSH341JwnMA9WHRlCzwjLOyJnkayT4h/kIDZ+utSie9x5ZozAL5fUgfwdxPuRpiWjyxnVp1IyjRt9oNkl1XUWzAX0goZQxktgj9Fh/Kxhx5G9+VCnrQQDUDlVgbVnxwXg7il73TAwNYlhIWGH7QZVlP7/es9nvNAuu26GFK8alouP0apKLs1UIBT7WDWbSsafj10gWD/8iOUQT1zEpsXgNx/2B6Vsr4sMfNuFBZfVC3vmHHfCv56MZkGjJYwtXflnhkJ4xkDKja4Ar965L25+ulYLQzAfzg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(2906002)(2616005)(956004)(31696002)(86362001)(52116002)(26005)(6916009)(16576012)(31686004)(478600001)(44832011)(16526019)(186003)(53546011)(36756003)(8676002)(5660300002)(6486002)(4744005)(66556008)(66946007)(316002)(66476007)(8936002)(83380400001)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: riN6dV08FZyyM9BFJJlwVEk63E8XRDK7x4BrrgeLOJTYFUDftTmU1iw4WLd+gyw+KFBl8qndrZTwt+z2+LIDgT7kbWW5UXUg+CFeKVof07A906hx/klTaKg2FbuwseZyZIjCnKwmvu4Cbg1h8TFU1o0fw8ZASyCqOFXKXa9n/F1WRnfOUDHVYBnXjpqbwGwekGxPSqm9g+R3NVeokQHcmRLAVMvhdGyGc1AkrxDclKWgu0U239invL5iZshQ4GbopOnKOo/ZaWKLjwsWxRfkXXPperXUPYRrQ2rPTZ0d4xA6xnEdBSssbyqOgTtvxFRpY6Cq/buGfwudKnCsChXrWf8p8K7mCHi/T5QW/UeLWzhhzGzQwyEEtfYfIQNOd34A0FfYb96fIv3od7aIUWVY6P7L/2QrC+Lc1HeCo8sX6DxseC7ZoACt3PWm/JfI+WatWwTDl5juMbEX3udsdH+GEbHvlIbja6NYo4tQIIWQAD4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3e804f-5ab9-46df-a285-08d8283ac3b8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 21:13:33.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XL2A4dbkUvveNAA7qyfH2KnIOfRwWtFbSKVBxQoHsBzgH7eS7nrSC4Xwc7SYPkBZO7jil3wZzRW9iUl9vrjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/14/20 4:02 PM, Lee Jones wrote:
> On Tue, 14 Jul 2020, Kim Phillips wrote:
>> On 7/14/20 9:50 AM, Lee Jones wrote:
>>> Can't see them being used anywhere and the compiler doesn't complain
>>> that they're missing, so ...
>>>
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>  drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
>>>  147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
>>>  | ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Cc: Jacob Shin <jacob.shin@amd.com>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>
>> Same comment as for patch 9/13: these are used automatic module loading.
> 
> How does that work?
> 
> Could you point me to the code which handles that please?

It's MODULE_DEVICE_TABLE magic.

Kim
