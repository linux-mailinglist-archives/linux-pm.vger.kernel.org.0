Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3241F3882B8
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhERW35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 18:29:57 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:49760
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232020AbhERW35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 May 2021 18:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPPs3QmFmQxGwN028DPztT5SI9U5FsbQEAcYQjfvMDihpwK7+kXe3u9TcYBkhH7gj+2XPLavi+w4kaXJ3dUhCQx0es4Ma6bxtxw2E0QKULkEmnSMdiZHYCmK0iyFjll1EIdJXsJD7Hfm0LwNVgLfG2n4X7ujBrKrHglIt7YUxkvCz3u8KlEURZgEU6hGKcI7nGqUhIVsj6W9PBT3L2QPTpG5psZPUFZ+Tr7ZrFJhbQMUKNRMcNeFeJTzhsyMrWoDMbSnR8JAcwofb/2coV0t3uX2lHbeM+H30DPj8vAoYtfbJ1COxf/FvL+zRwVsqYv51XQFI4sSy2o4G0I1OuOxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXwdt5/9e0HngCsI0VwoiF/28u0K3YmD/EmwCcuSl/Q=;
 b=D2jLrVJzs5tsbuoW9GM2KXkfElDPotSwEWjIKVKKMaV9y++2Drmz568CZUR4lH/T6zUyK4qVLCVR7muXnqfSaUYMV0xrTl0csJ+NR7JSDsAV2UwuRQVgi5D4lhQj4/mkEvixJ9XdmZuWkj5ajLCkkyMX4FrLYp6AIgc5DPgnBTD1BY7lN2ELImfARTHqpbxMqTHOeN99zTz3hNI97SRwRThd/Y2e+pRrGzFusoacUNc5cvpu08HAnWE33xtY5JIQMQGDVxjqPy9fs8mrke5x8/Ue2CWJQCDxMH8bsX8AWAv3H6zhq502g7u758aF19agfawQ2gwpfIPJjRlpo7t8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXwdt5/9e0HngCsI0VwoiF/28u0K3YmD/EmwCcuSl/Q=;
 b=O2DX/Sv/liWsrjOpcvKvAaRM50oWqZM4ixqPDuRkluKgdNu5D9HUx3D4cAAR+xSfizcN9/SIkX+F6AM70HM/y7ogRJCEIwXFyPwsRJL3UzQL3QD3friopbBEYEp/LHqj0RvKKGKMhnRxyhK/mD+gP4jkH+kpFBeRUxzDNUD4+TQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN7PR12MB2724.namprd12.prod.outlook.com (2603:10b6:408:31::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 22:28:37 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::e95f:8dcb:b039:8f80]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::e95f:8dcb:b039:8f80%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 22:28:37 +0000
Subject: Re: [PATCH] powercap/intel_rapl: Add AMD Fam19h RAPL support
To:     Raul E Rangel <rrangel@chromium.org>, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Victor Ding <victording@google.com>
References: <20210518161842.1.Ifec9c629767197bbd80312ebea93ec8bbfafbf06@changeid>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <ccfe34ca-9487-1f6c-6ac2-18b8ac7cf57d@amd.com>
Date:   Tue, 18 May 2021 17:28:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210518161842.1.Ifec9c629767197bbd80312ebea93ec8bbfafbf06@changeid>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2603:8080:1540:87c:98b6:4189:ae0d:423a]
X-ClientProxiedBy: SA0PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:806:d0::19) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:8080:1540:87c:98b6:4189:ae0d:423a] (2603:8080:1540:87c:98b6:4189:ae0d:423a) by SA0PR11CA0044.namprd11.prod.outlook.com (2603:10b6:806:d0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 22:28:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a55a8482-2236-4855-b11a-08d91a4c47aa
X-MS-TrafficTypeDiagnostic: BN7PR12MB2724:
X-Microsoft-Antispam-PRVS: <BN7PR12MB272476E9362F2BF57465AA95872C9@BN7PR12MB2724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBsSRBP6s9cB8Va5SgyI1u8ERLQPMJVnYVtCctWAMlw6u7SCnJtYO/chNnZNYjKlRUl9PMVyES6PPKfybQ2vu9aqROuS+bsl5UnlB9yCB9crsITpfk6ykHWVCnTlS90GGd+BkGSgk46scGeFzWrvMPuLGr7X7umh45hnqcbDMY4ZwrGHazqVKQRLzHfiJbwxhu8pcdp+6QsCL6gbAXUDcdxQK30XvzEn+yAM64BCn8Lmp++jXaRLblbWFJyn5pc7LGL7dkhk5g58R7Ch/qYq17I0xr3wXh/tG7LVp84K0ikWOtSyv59H28UcW6AsPX7nqvqc8Y7PPSepgJ7kqsQo01qxuYr+GJWu10+KHw+koMP2wnH2CEKt6JHE9X+D65vt+VoctU4RFT/8DjbMG4sBdmkGwjde6whwBA4vRcf/ouilr295HDK7DbkUs1BjOYFzZljgs4JG/dnROMQvl02ZWTUcno1m6hrHmmn3NGJ9V9CeKv2AH8rGLKMgkN94ZGMQYIaoXfutSH6ywP0A5IEoiXb86z3HPhSW20QFo0ckgEe+MKXvPQvDPpj3L04c2zJCRA2XxWu8lOLtkGXil7HXtli/i4N4R2sdjUgBEKNawPHk6GbbtDFXg4XEmgpNgfFT6+hfHY57IdHJAvwfw/cp1Z3+MN8kxfYbQRakkAuqC+hMBBUC3+XaqA2tv7R3/EM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39850400004)(396003)(8676002)(66946007)(54906003)(66556008)(66476007)(478600001)(2906002)(316002)(86362001)(2616005)(4744005)(5660300002)(8936002)(44832011)(186003)(53546011)(31686004)(36756003)(52116002)(31696002)(6486002)(4326008)(16526019)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?19DsPTjMm2hBg3KHH6Ng/2/rgY6xMzpg2wp1dYwDG1USOUTqtpkC4hnS?=
 =?Windows-1252?Q?ttEfU2B9Xjx4RMHCKCQZTWVosGp/C69ligI7KFYrQ9r3Zfn5eQ5Y6fnk?=
 =?Windows-1252?Q?ummCk7myoky9YKlI2pF4v20FxMjqanZhAu74NcjSKq1vkTvMd4HGulqJ?=
 =?Windows-1252?Q?+s/2wEbokgyridIcGyUZGbQqPlliKLWCDw+5Pwo84b6ERiV1CM+Epp/u?=
 =?Windows-1252?Q?2UNVm1cjRQV93tL4ZV4t6HYc/2ouLFx5jwdYv1MMZGPtu4zMeeJ5ILpS?=
 =?Windows-1252?Q?c1CsshEGFnncOtiv1h7Oj9rqpK99++qxb+dRb+kDT9aSvhkk7Y9Jtlbd?=
 =?Windows-1252?Q?97hzMkRazQFOoiDZLWhoEuUrKtSs0QdhXLminEvqztjxCTcJLfF5XyMM?=
 =?Windows-1252?Q?sDVEQwbayrrm7Q//z7tNCbKGQKEo+JPKSFfZxRyIzZeOtE2N8zHIMzhi?=
 =?Windows-1252?Q?d1PlD554SbuLwE5En7zFNS06JoEFNO5VNZg9foaHt2mNYllcqJpVkRDG?=
 =?Windows-1252?Q?gxuJEn09PCBoi+Xq7BsOtvzVk5WYhT9JPJNmu6BKsB5pCnrWe/AU73zm?=
 =?Windows-1252?Q?HXBZE7HVa4fDpRL1LTv5igq3Zeka/O4PcsywYS8yh8R1+Zzfy8VrfyTH?=
 =?Windows-1252?Q?NxPhiPzXVBgvDgQ6HIASh5JsbJgpePECd9QlJhnDSJK7TLkYxijZFTkB?=
 =?Windows-1252?Q?2IGtyeR+Do3xuZk1vfdPj+yyw2dkT5Tmv6vZ1k+i9CxFB7LfnHK9EUN5?=
 =?Windows-1252?Q?r7Pll5y8Ok7Isa3VCm7pTjKaTwap+Rn3YvzGhz3mALRVsxb6DRD27MlZ?=
 =?Windows-1252?Q?WpDrMZWmBF9z7Alfp9m6mumLX1zh+bG9bki9wyqtBpX77Qqwb0tdkNdK?=
 =?Windows-1252?Q?kPii3knZYmnQZqtk1UMogwaSc0REKN/ubZgftk3Rui+TXDwZVdROrpqx?=
 =?Windows-1252?Q?9U5pUkEBm24Ybmo25gvXtt6RderTpqG3J96qMwJkPh6cLgx2p2aCBvbE?=
 =?Windows-1252?Q?oNcQiWushzZxAbj/0eVIVXr+k6DjYlxOoVqURlw3SmQm37CZ+bhzRzTK?=
 =?Windows-1252?Q?8Yb+jXrwbYN+NFagaFcK+ivjEI7wsLw41MWZXG7VOehdH0RkgRjgSPGP?=
 =?Windows-1252?Q?7vH+1CEU6HUsOTM66G9BdGjeKJWwW2j212iiigsVSRf8/afEldf0Wyaw?=
 =?Windows-1252?Q?YtkX7AY+kvB/ihydi7dmnHS8ujcR8LKghODNEXsHjjP3rroCdxH61Pk2?=
 =?Windows-1252?Q?SqWAnuky4kaAcdc/cvuheW6Wb9x5hQ02fV6OoegtPmuDgvCkSpXQUfYt?=
 =?Windows-1252?Q?p+u6xzzV7613r0TrxZfqWEVx1YHsxAHPrwCbwFqR6hwl6D5i4FuwkxDk?=
 =?Windows-1252?Q?6KT6Sz4/J/dWwACaCTiLDlxho6Gk246C1/7hH7IlzFIWFqF+WyYPa7eu?=
 =?Windows-1252?Q?e6FnbfnUH13GjbASp1k/sJc/BX+lrAd7wyNtVaNkjPPHx5R8WYdZvhuy?=
 =?Windows-1252?Q?+tpZUXZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55a8482-2236-4855-b11a-08d91a4c47aa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 22:28:37.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub/yLziuzUO/BvTW4fvLJ0XrIwOu/3LUPGp7qxOWls7uuFku/gDQRquc9U+JRhPDNzyFA7RLMzj0UwT06A3YOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/18/21 5:18 PM, Raul E Rangel wrote:
> Commit a77259bdcb62 ("perf/x86/rapl: Add AMD Fam19h RAPL support") added
> RAPL support for Fam 19h. This CL adds the missing powercap support.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---

?  This change is already upstream:

commit 8a9d881f22d7a0e06a46a326d0880fb45a06d3b5
Author: Kim Phillips <kim.phillips@amd.com>
Date:   Tue Oct 27 07:23:57 2020 +0000

    powercap: RAPL: Add AMD Fam19h RAPL support

Thanks,

Kim
