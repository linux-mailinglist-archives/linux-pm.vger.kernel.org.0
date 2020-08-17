Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EAF247A8B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgHQWiQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 18:38:16 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:22688
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729098AbgHQWiM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 18:38:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxEDcSXInDWk7rYYaX24a3AcBN1bM9SbTTg2y0QNWUg3VilsZ4L2XmFbC/bA21SFSSahnXTsjvBQbpvybDr/YBb3XL8Av9+a8wA9evaHfrcTNOIR5hWt3rrs9kK7vrsq0MhVLLRV8Ctavz+ALZytnyFm/DiAqXy/Wgg1/MV5tMUWtI6xJphNA1q3ZJuHQFJgFOdtYimF617P3sqjCNypXGtjk58mbpR05mg8adkomilgjXYR6zvaaPaS/UxOsGBmADuIra16lkAzLOBxZcIb90AV15XOwRWPTKsX+2O1HFzUDLZviZhos/tGpAuRX8PxHHqn4cPZkwoc+C8f4E/lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2UD46nJdeGWUoIx3iSWqkWHGOKDlGW0PR3KhsUvnJU=;
 b=ZZYXRuTeIyrZzCyYvtAp4J8ZeD8ktjIxUtzISZTjpKrp1CUMjZcIx0F1HuDMEEx3rQvSkg/0h9xAl4xf3uQOlPOVsAWLZza+zSeruq6xnmpSLFTfZFS0wfAZTWpoKyqZCV32IWM6u34FbTBYu/I6kISZjsK00cQbvBC912BO8XsFtAWrPjycL7Rvm8Yh3K4PXkNczYlL70Jzo9k0uJcgZCRLugzOL+Z4+avXsKMX5BVW1jhSOcWGCXCFGZaBLhz/+7ksSokl6chFsizxnPbt8nMejTJ6ms6/R+o7mryn5iyKbsZXK5+hORaS6kT2UfSOGuc4CKWvAd9FcYXJ3NYbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2UD46nJdeGWUoIx3iSWqkWHGOKDlGW0PR3KhsUvnJU=;
 b=1BOeuz4LgkIime+uVUWQvqXyEtqHCnWQCL4+RiLoc32cdNTOIWP6gMTLBSSwZNFIDCzSWzSytV4zjZ5xrNBZGnyOEkNHOif2HZkomPkTIDDqRgxtOBhFy1A38Y9e8VcSPoe6VlY7yeqAF8EDNIAvt4Zj+TTXOMBVqKPncwp/cao=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0145.namprd12.prod.outlook.com (2603:10b6:405:4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 22:38:08 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0%5]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 22:38:08 +0000
From:   Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 3/3] powercap: Add AMD Fam17h RAPL support
To:     Victor Ding <victording@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org
References: <20200729105206.2991064-1-victording@google.com>
 <20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid>
Message-ID: <88a9a82f-7a6e-2f19-4814-5d4e6869b905@amd.com>
Date:   Mon, 17 Aug 2020 17:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:404:13e::29) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.221] (165.204.84.11) by BN6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:404:13e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.15 via Frontend Transport; Mon, 17 Aug 2020 22:38:06 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db5d59e7-e708-4ddb-da27-08d842fe36ef
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0145:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01452DA87BA2973E8507FBFA875F0@BN6PR1201MB0145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOEcwO88iW/5x/ebwovNRi2GwhigdhL7zF9y0LW8SxinofNtruQYiNQECUAeQrux2vz5nhPYPlMfV+lAwpXHAFBwE/A7lDxVj3CGHk8DIR5Xlm8IUrbEAGVd/fCjNhtqFMoE6ZdEKtxKMJFqsjc9zxSPZ1jxT7oaTRSHvzYPHvct4NwF/T9hQPWtcqbtwphPEI6uHAOt/8tw95jDzUHzeSlv8+kYKQujSf24Zxyxqg3iuo/gUFkeE5hHO0M1PJ/glN1wZ3uhhpRd95JGth5aF8VtuO3M1ImI1BEFcamGAnQp9XzJXJdOIFJeNBGbN9sL8/gJAQ5Vs+tNJBr4tPFRcubtjDCLWGE8/XqQ9SUyfISKtrEKb1CvvLuVEtA4a0rh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(186003)(16526019)(2906002)(26005)(44832011)(31686004)(4744005)(36756003)(54906003)(7416002)(2616005)(53546011)(956004)(110136005)(16576012)(316002)(52116002)(31696002)(86362001)(66556008)(8676002)(66946007)(478600001)(5660300002)(4326008)(66476007)(8936002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QtdjSrAkwziRuNfjTk82ehGMtnCcqLVHvZ8VbmDOyPoWvsTaUHi06wXNtp/WdhK3qiiwVXt3WZ9oZMQgDGI/rkFv0SEoYHtzNzWf1AS83BuT+hqp9kJTH1cAQx0jKpIhensl8ICn+biWbDrrUx4sckmKWqU9NMEVWL6/h5XfkTW5t1hAdsEUkEnB1p51XKZJ2axXnGxtrSOUdp1KcrLCTu8GZPndzfrRdJ8/tPnMuapX/J1PGBzNGQJSVEIAjnLJbdMOETh54bgt+XoN4wCQiEwW1DG+hVoqFdBCQ59o9ZUjmcAhdPGTEXH6QXN9NxWeSE9IKSf22Ikjmu05cyGy0RZYF5QIqiFcFTonH95nPdoM1z+nZtiN2K4Cb3ru/zWR4treqwHBryYkCoYtQz09jsl5Idbew69suxhX0phkDASYfC+H9PCEbnD7TGHHnEyThtDd6Uj+NE8e5/Uc04VhCHiRjNUfP+vsU94p7wsw4IAxbNDOCEMboC9YhYCUhSC8SJT6/3NGkzLDVe5lcfcwgGSKaByQNfU0k8Ll3EMybglt3c9meB9jlaDUlmZ9g98d/LXQWYjfrxosDmULXaFSbNFUuMK3hMCsRvCLT26sS9BnAXKwV5ZqMnKmD2vZi7c442aZAoKw9Rl+HXGm8CUL/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5d59e7-e708-4ddb-da27-08d842fe36ef
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 22:38:08.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7XGOSDCM/Kwm0N+41EOMme0eWwWls49mPRBoR3LiyCC8p/2Cn/ZctYN0XGucU1SkuU4tcTNtDdUfcZmUdsepA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0145
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/29/20 5:52 AM, Victor Ding wrote:
> This patch enables AMD Fam17h RAPL support for the power capping
> framework. The support is as per AMD Fam17h Model31h (Zen2) and
> model 00-ffh (Zen1) PPR.
> 
> Tested by comparing the results of following two sysfs entries and the
> values directly read from corresponding MSRs via /dev/cpu/[x]/msr:
>   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
>   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj
> 
> Signed-off-by: Victor Ding <victording@google.com>
> ---

For the series:

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
