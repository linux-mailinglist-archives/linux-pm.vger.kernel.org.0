Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6D21F7F7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgGNRQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 13:16:04 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:6050
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbgGNRQD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 13:16:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktujMN4mSm01mBiiOojCOaZzBFK+yvpkh7CPSonVQjZo7xsOiKjis9BnRu/QXkD14+3sKVBdiR3tUMRxTjpw1r5imqubTlZtGqP4H2F2MQUXbHPI9TBUz/nAHVO23CtQhTcWZQ3sibxb09XSLG7LBVOsb+hNL62t4vozY00B3xL3W189EJqZ/1aY0SGEMdbrBiW2ijA2z9Lu21/Gtd3s5yc4CSj7cpPBNsepqtKV98OBKy+qiyuRRpdKR/NvR2M11NSRBFFaGU7ZzJgC/NU5TjqFLgMlz1hFRZFC63a+QqTpnbsX8/8YV8Jo9qskotQ25bS8TrSZ5b626G9+gJygbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbBY92KwgpYEniy5lcR1Z7maCt3W2cjGiK+EvQhyxrY=;
 b=IUXd+R10LFirJfUlVY0vRxPWrmsxqp7VH8qAh6s/tE5EqcvTDht1QU8PBAXcjy2pTgN9zzHZsr7lP2LsdpIA4wpAPc5oabYYByLyHs29VeQEjP9iwwobLShrV5mg97yRTL+lZMQOtgcW1nlsyMSvA2jPMJe03xwEVe7tPRAmzCf+t3Vke2S6M9fvvE1n4hViNRvWSUivWYGam9ouCDaYJfH6tvwsQuh0AiNiRfOI1UQryaBTnCEQpbYMebNh4RzFkxfgvCYnVGdXZHTVk1uJAlRSlv/50+cAmF0QGvgUbziPHqHx2k1oSd6GLHxcYbrbNukKYGyUIB6/Ir4o7kMWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbBY92KwgpYEniy5lcR1Z7maCt3W2cjGiK+EvQhyxrY=;
 b=FRdzIM7AxcpFYiLsk5p4ExTI/EOMAMDQwaPgLV9UHrGSgv/v3mvCYZWw88owg0NJxAfqYdrPp7pQxVe2pGLBU+8xP3rFCxM2ZJNpT5NZfJkQpXqHLGbfO4n4mQsoCjGUTw+5vs8dwg9JAmV/SW9eAVz9mRvG//meELhn3+7ZhzU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB3636.namprd12.prod.outlook.com (2603:10b6:408:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 17:15:58 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 17:15:57 +0000
Subject: Re: [PATCH 13/13] cpufreq: amd_freq_sensitivity: Remove unused ID
 structs
To:     Lee Jones <lee.jones@linaro.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-14-lee.jones@linaro.org>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <6101e041-41e9-22bc-488d-38124c139bc7@amd.com>
Date:   Tue, 14 Jul 2020 12:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714145049.2496163-14-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:408:ac::32) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.5.212] (165.204.84.11) by BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 17:15:56 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10994425-cd75-4a17-3817-08d8281992c8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3636C19A991CC327065BBEB487610@BN8PR12MB3636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNdrBaNFaN0E/Nln/rmAoghTf3R4NmezlZSoe783yHDRswTF4vz+c1tgl8UYWwRn6Xkb77Rdx9ss72Zcj3QzhJx6IAr2UJqX/48uOTXiVUBEMo5zQGdwjvyRle84pxqujE9sj3Y5g5TEQLVknqdke3L4B/AHt/GlSsxDbhNak1XdOn+T/ZXp2bXV8TukhYDUI798UQ0g1WH6VQWKifvo8J1senuAf9N8cnE+uFwXrFFJZX0LsUhcGcuujevYDIBQf4/DybRo0iQrEd7MUZcEk1xie/ipuZ6FsWAkceF4gG6wDImFptLpwOtJpYB+vaGXGb0SH7Z59KOrEvcB1xqQLelJ8RDqFbuBK3WuMHQDhDu/O3wZxeNtRJf6xg7QMuh0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(66556008)(66946007)(66476007)(16576012)(86362001)(52116002)(316002)(83380400001)(2616005)(4744005)(8676002)(36756003)(956004)(5660300002)(31686004)(6486002)(8936002)(26005)(31696002)(16526019)(2906002)(44832011)(53546011)(4326008)(186003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i/6xYyC9DjJVJc6mGlRPD7bWoeZiQpWwcux+/s1GVTJrf7/g8/wgtiip8x7jzKfhS6G+lg59m5J3Y/XPJsCymHVtIUaRUNjgL0NmB1avUsgKq0vwaA1QdmrkgRVf+CLTN4lVacUi1yGwFRemJcJ8FavgQWaboflG4nSp5A6GyhC65rZF4G/8TBROaMI+myNgawNE6M9yqpQf391QHoylxbU9mJ7NJbbrZx158eRwMCspb1KpNSvgIgGhPqAeAoxiZVHdjt3LdeVrC5ZjuE1YgNAWOKpAwlCiEgIn/8ZZq122T0Jx8P6Eqq2gdYmBd7UGcbg3m6uyUu0hHyDxpccuVJiLo0P/jD4YHSr+icPRzGB94ON0Q/0nqFRc8xDPwzqUA77sFgQQt1uPl7KeYkb01G+oTxqpdul8eDPLUbW2oq2UynNJyQLnI1FHd34/U8nx3XCNinS6nhsodZwaBkTDUOzcdF1PY4cCL20VPZHPHGk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10994425-cd75-4a17-3817-08d8281992c8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 17:15:57.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn5XjOMGTkR/c4t+Aa+sKY4c6SGodqAzyb8X+/5kbYCRRxvOMPUrSvS+O/hK2pKAhEgzoI9r1ma0JW1q3DeLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3636
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/14/20 9:50 AM, Lee Jones wrote:
> Can't see them being used anywhere and the compiler doesn't complain
> that they're missing, so ...
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
>  147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Jacob Shin <jacob.shin@amd.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Same comment as for patch 9/13: these are used automatic module loading.

Kim
