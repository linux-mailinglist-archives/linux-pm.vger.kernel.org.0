Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC444C8ED
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhKJT1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 14:27:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:9144 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhKJT1G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219642256"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="219642256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 11:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="452434182"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2021 11:24:18 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 11:24:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 11:24:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 10 Nov 2021 11:24:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ3JxhrAxV+vWcH1FUqXm8TGMnL+zhV13lHBW8cE04l7oELWJDFVxQeNbzBbocqRZy4ABoE8g/TyKmOnl0+46ttF/itnlnYUElbo0U9kmsapMvIL1tukZfU7D0Y+hQiHQSSoPLPrXfMGi/b53xv3XxwLYzGTN72o59HSFbCT3GDYbGvuLhAN95220SwwCS4dcXiV9YZEXUQDEh8Qnq+CSY4jTfO+YJPWZQVE6SPTgRQgKGYQHhHBtVsB3pGyoGab0Iv6xtRzW5QxOrnIO33Vs8bDKubp0r6DF54pdJtRY3+bqjNJiZlMBpawzRMqK4OPO35LDmzFohGQltaGP42DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqTEG5WaZdFHK/Z+fcFyMhacEQJGCL2LVO+HMruC8oU=;
 b=mZgm82yxUoAgigFzQc5sgQEXkm6k/lb867Vpvyjo0yqAfWkDvZfDXbKqX2rbf2UerX2bqYXMdVv7WxAlRAkx4ipQ3QI91oECQkqu1m4ttXLyDL2xH5ZTko7svgkXgz39NqspfLp2LV2tQ1I4/l5KgsavLKOFskQoA/0komfMRdpoFqJ5KQm/J+4WZWHXdHuIOrgeMYYPoYu2npWFmNtH1SqDXkqM1+zxAIMm6rYj6Fsi3dH/t6blQSB7ymutyKitsh34NF9Y36bw4J/YZb6S9T1zQIyQsKryvxdq7df/7xhauDV7XqacG39TX3TeJQEPr5q276XArzqYCU/0HDJjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqTEG5WaZdFHK/Z+fcFyMhacEQJGCL2LVO+HMruC8oU=;
 b=CRqdPyGRPLkyMHjLwI6TieILt7pqBwM0EiXeKgDsd7ZPl+KnJIRQBu7opvQjHkxActnlPdE+Ft2aOUOTmLWs23gvJmoXJgDxk8PkTbyvjo1FqVvCNU/JM3z6Qq8rATIZnGGSz28GAWEtyuRJWxADendvSBzQWvxABWOL4uGutmA=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 19:24:16 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::1c89:2776:b68b:6ce5]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::1c89:2776:b68b:6ce5%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 19:24:16 +0000
Message-ID: <2d01125c-facd-6db6-23d3-b0b1b608c4e8@intel.com>
Date:   Wed, 10 Nov 2021 20:24:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] PM/QoS: resume latency 0 should be not latency allowed
Content-Language: en-US
To:     Youquan Song <youquan.song@linux.intel.com>
CC:     <linux-pm@vger.kernel.org>, <youquan.song@intel.com>
References: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
 <CAJZ5v0jJ+tthguYtq81EbapZAxLkUkz=B=quDWcMzHQFcWAnrA@mail.gmail.com>
 <BYAPR11MB3205164D85635F784AFA4C429C939@BYAPR11MB3205.namprd11.prod.outlook.com>
 <20211110105833.GA30301@linux-youquan.bj.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20211110105833.GA30301@linux-youquan.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.187.20) by FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.8 via Frontend Transport; Wed, 10 Nov 2021 19:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6765e9a6-411d-471e-93ec-08d9a47fafb6
X-MS-TrafficTypeDiagnostic: DM4PR11MB5263:
X-Microsoft-Antispam-PRVS: <DM4PR11MB52630EE746965040BDD31661CB939@DM4PR11MB5263.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tW5oBAlNmE2QNwY3YejOijSNP2xGSBaNqd/p5ydOTdTFUD7m7u1Iy9P0NTUVueyxjfUtvfAGBw43A4U2LMrUlaPsMFs12hGjinEQGEvJ4gzG/sYE2fSus+TObsi1riVF9os4aJxg53uQeT8RsazqAwaqWtd7mgV9jpgmkbrX9y2RqL7Y8xKobmKB5zqdDHxldQSfErcsjC57trUTPD5+5sCm5JVsfeZ+zRYcQ1ZYW/PLJEL89RrMBOh+0TDhih427ps9EP5UmzIwbVCYh+pGHW45YS97QQypCwe/AX1WFdK21+jmF2TJ9Scwqa17E6Zp5Pm1VYj/SJSd56buZAZBeeHCheyRHjQ1Nvynf9Nl2ygXm+BWdGnJ+M4/k10EPnX77v6o9TiuqqfgJAtTM73wnE5etJP9TYbZ/tDXsZ+ji+TRf+pZ1PQU74+vS5MaDA6GU/ez9ta9z0HJ2GbWDXa1+y4TwNXlrlsWQCXOluXzWE6mdP5z3977uYecuvGQGfMSMy0sPDnl5krsdukeOuphqU2lBgtSAkl/+IXSQuXh82+yKWZ1EXu1ZbAB8USaVYVkni5gPWoa3XpjQVDl04b2hKIHX4eKkeUtdIyhb+5WhM5JxVmPNgNmS4sA3YVoTZkbqdlwFuAOhweqdNGQdxiJWvDcUQ8QnEwnkV7cltEakzi3iTYwC3VRvQYQnpLF2z9no6Vg5i72hoXDBiR0hYz6g/i+bvZ1kc/asjbbsakoEqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(6486002)(66556008)(6916009)(36916002)(66946007)(31686004)(4744005)(2616005)(5660300002)(31696002)(8936002)(66476007)(86362001)(508600001)(956004)(2906002)(16576012)(36756003)(26005)(316002)(8676002)(4326008)(53546011)(186003)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFoZG8yYVlMKzZFOGxlWVB5aUhNL28xMXNzTmNMdVp4WEFjYlJWQklBQlBj?=
 =?utf-8?B?T09ST1NhWXpJYmdmMVV0YlEwZkwzR29SakkrUExCRE1zSDF0Q0JKR0ZkMmxQ?=
 =?utf-8?B?bTF2UmpsN1I5RFhrd2V2eDVzWU10Vno5dTNGQkdES1NuS0wwcVZ4QmZEaDdr?=
 =?utf-8?B?alpRd0N6ZW5nZ1YzUUFLajBJaDJRMmVFQlVRdU1aNnBPNk1MUFlvNDhpcERM?=
 =?utf-8?B?NlpYUllxd2J2Z055c1o5WWdKckdoWVVFMUZlNjhqdTR2Smk3Y1FVOEQ5dUZv?=
 =?utf-8?B?TjJlcGhzaS9iNk1lKzZpdEhzeEdraGlBYnI4Ny8yaVlXOWtjWjNqYkM1eUNi?=
 =?utf-8?B?dHFmY3prU3ZOTGlDOVkwZy9QL0ZsOHo4dXkxaXMzNVdYY0hEQStUOGJWT1Za?=
 =?utf-8?B?Q1NlTGcxNzh6WStWR2w3TkUyS1V6QlVlV1VvREM0LzQzYlQvWGpJMFovbkxT?=
 =?utf-8?B?YW53a3h4ZXNzNllvUlB1b1hxRzJSL2VPREFSVmpJbS9CeFJuQk5KMU12UGpt?=
 =?utf-8?B?eVcxd3Z4eDlGQkF3dlppcS9CaGFXQzErd2ZXb2YraVhNT0NzNVVkdUsxVXB0?=
 =?utf-8?B?TEhlSTJOV0VreU1VVFFhWFd3eE5xYVlUV21INlBlbmFmaUQxeWx5dGxtWTZM?=
 =?utf-8?B?aCtkeTR6RVE3d0VZZUlpUzN0UlNHaTBqTVM4STBjMkpUNVJ1OU9VUWNHUEc2?=
 =?utf-8?B?ZXg0M2IyWTJrRnlVNVVhakhDaUlpSHNrWFpHR2Jjc0xOQjA1VHVRM1hmcEU0?=
 =?utf-8?B?UE1paGhsU0QyMVNpNldGVkFRTWdWZHFTb05JNVU0TFBzd3hxMUIvVmJONHhk?=
 =?utf-8?B?QWtrTnZVczcvN1plSnV6OXkwWXpYN3dEdm5WWm1rZHI5NkRxOXZzQTZRNUlq?=
 =?utf-8?B?Sm1IT1czeGI4L0hBTUJKZCtLeE1uT1A2TUZBYTlXN3g2cEpPRDMvN095Y0xW?=
 =?utf-8?B?T0NKcjdpbVE2UXpjOGtmSEVTV3dFT0JtbDBLYjhxakI1T2V3TWN4clJrTlFm?=
 =?utf-8?B?d2pTUWEwT0VWeGRwbS9QUkxRbTF2S3pKQnhmSnBPeXJwa21JeXhLSXRqdlc0?=
 =?utf-8?B?NWo1QzJSZm9QWWdiZWdrR2k4Y3ArVUtVekQvenE2UjBNUE9VVTJ3bHVURlNq?=
 =?utf-8?B?aTNNSmxZdEZzVFFRMGZNVWt6V1dTbGxwMkhMWDBWY3BnVXhTd1k3N00xMkt5?=
 =?utf-8?B?a0IrMVNZYVdTNU9sUkpMbHFSRWpyZFdpYi94NHQyTnZzVTNWT3pIaFBsZU9l?=
 =?utf-8?B?anJkNHpvamR0M2s1N1VpT2h6eWFTTWRldm5iaytlZkNGN05LeVdQUnJ0QTFK?=
 =?utf-8?B?NTZrSjQvdkxnak9ZUXlVZjdTZjJBeGZHb1FUZEplNDdrOVBiLzRONkpZdHdI?=
 =?utf-8?B?eFEzbnZmeVJZVVJaZXlOUThoYkRUUm51VXc5a0FoOVZNYy9GeFU2L2lUbWlV?=
 =?utf-8?B?TkFKNC9XMEFERlQwODJvSjJLbnJ5b1AzTlBXZ1NzV3QwREFuSjl0MDVkR0xY?=
 =?utf-8?B?cFV5aXhpbmhFQ3NsUGd5MWk1SHBVT3pxM0RrVG5GbmVsWGpxdGJmL3l6RC9n?=
 =?utf-8?B?Y0Frc0g2NnJPMHdPeWlRRFRMc3BlUGd5bmZLTXlFdXViNEtKVGFEWFNNWFVa?=
 =?utf-8?B?d3NYM0VhQXBRKytOUCtmcVY1STZFbHNRc0RIc0ZJUk5DZlZaT0NqT21Xc2Ez?=
 =?utf-8?B?cU9ndmRSLzZOZHFLSTlSN1Z6TW1rQlpSZ1YrTlEySmh6K0Y5WnYwZk5zR2xx?=
 =?utf-8?B?ZXZPZmdmZ0tUaVppbXZJbko4QlN1M0FUMlI3MGlYT3FjYzdvSENCVUpESjBY?=
 =?utf-8?B?cW45Uy9NZ09FVkxjRWpJeXBTUVVEMzl0ZStxSWVUSklUVVEyaWJ6U1BGVnla?=
 =?utf-8?B?bXpNZ3N4VnhYV25XZUVHRDZQVFNSQmIwaFd1WGMzVDZTako4S0wzbGtKUlVz?=
 =?utf-8?B?T3k3YzNyZkkxQlhwb09RMnhNVUYrRUNKcWt2Wk5WaXFIY0lpclJIa2JwWlhK?=
 =?utf-8?B?ektzc3ByNWJmTEhlUEIrcGRPWHluRm41cDFkbXNCN1NrUS90WkZiaE1NUXBN?=
 =?utf-8?B?SVF4THowSld1dGQxRmkreVc3YWxuNDBnRFhtRHdOU1hCMUMwalQvdUdGT0t3?=
 =?utf-8?B?ME5Od3ljMHUrSzlLVERTUW00UG5BVCtFYlM0SVlacitwZEh1TmVwUDByQ3V0?=
 =?utf-8?B?YkZ6VWV3WW5Rc1UwTnhFVnFzMG4wMGxsdTgzaE53eFdCRndsU0RZdWZ4ZzRT?=
 =?utf-8?B?c0lBUjhNUWlnR1ZLUC9CRFcyWmpBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6765e9a6-411d-471e-93ec-08d9a47fafb6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 19:24:16.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEcacfn1TxC0NxHx4DP/Xv3pgh88s/iZp6YnAdtm5v5oAUGUuMfd1xwXZAn/RC8tRfJPE9bkpcogMZtHDnaYtL8IbUgtubPPvUX5PJbDqxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/10/2021 11:58 AM, Youquan Song wrote:
>> But do you really need to make these changes?  What problem is there with using the interface as currently documented, ie. writing "n/a" to it to get "no latency at all"?
> I think so. "0" is "latency is not allowed", but "n/a" is "no latency".
>
Actually, "0" means "I don't care" and "n/a" means "no latency" which 
means latency tolerance == 0.


