Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60246476A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 07:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbhLAGzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 01:55:10 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:38340
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239448AbhLAGzJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 01:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6nYHgzEg9DB9L8Cdw6uGfPYXyGon3aWrzHyX8GBhT3ipMs/8541an6HUk1Q4daKbffqZ3HkECSlv0lUOPu9JXdxRsFhIk5NGbLt4goM4wsqCUjhOhhKGdTO6CqhnY8AVtlH6C/Me0v8j3TIoEA+LvCqban8P2pIVMqqLdoYYH2gOSxjgCxq+b3gSj8gvIy5ZsFKu0eWeMTdnyIRWLnZdFKlwUGEZtloUFN/ZjMYoEfK3ygsEsgRyfV19VnZR+GjA3ISa0QSBYs9TuxeniScYqn1icUG2odyl26t8Q5vWYHHuEZKn+dy0igFj19Muri25cPRpqcV5W226AN0NLWYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOju2pR6gy+q2KUKPIucrmunaZKJ/kxE+M0LlSG29j0=;
 b=iRcPxkpXB293Rs6KGlUE28nHTID/1oIkC84GC+/WpqJ14gDOPfK3qDy23yPTg3lRFkXokRgNXFZJo/QyPSep1CdxHpvOghiifBxSW5yBENYyXgGzEdJvJ4sNphTjKH9t5qhSUnYcOfXP29trczPZqX0hZJ8RZIaKeDSDXkRUmFCEu/xtvDGgHlk/KhoFr6zg+0FerJVZ7qixwwAcA+OREwc9nVdRWHrAFEqrrrWKVGfPfg1XmS/8+K5Hn0WTa04MbzgaJDRCOih4d8w7gHIJERRUZ8hqwEuZVSEeCPvZmO8MXzF/KG2w5DrUJj7P03JRGMCeefGJaVzGni0LgK0jGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOju2pR6gy+q2KUKPIucrmunaZKJ/kxE+M0LlSG29j0=;
 b=n2PUoskspqViLPSxDpxx06l/jHbXOFJCbuyiLREvy8VaTJS2TU2hmX+57Nc6YkDaDHy5kr+6fPo3Sr1HIAKWWANvqtcwTk6YHhbvLl7Chj2nqWumZYnpxVIVy2TthDW9OaqAcZJd/ABWbvj1MIogFnnxN8RPsQgg9yXiEoHcDpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 06:51:41 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 06:51:40 +0000
Date:   Wed, 1 Dec 2021 14:51:15 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: AMD Pstate
Message-ID: <YacbY0XD+p6d70Mj@amd.com>
References: <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd>
 <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com>
 <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
 <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
 <DM4PR12MB513676A292976E478227E133F1639@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CAHbf0-G7LEUuEtsh7XsK0Nv4xcKJQQbV9DAzUxxeJUvkhky9JA@mail.gmail.com>
 <YaYB6UoC1iqsNuJL@amd.com>
 <CAHbf0-EWVeD8xehHZc8ff-4vYbXC69z=kMf0_=RXJsHKG_2M7Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-EWVeD8xehHZc8ff-4vYbXC69z=kMf0_=RXJsHKG_2M7Q@mail.gmail.com>
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 06:51:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8be99f-9da1-483a-e13a-08d9b4970746
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3525AE9D2680B0E6ADDF4428EC689@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eruuBNjh1EsWcFe4d8y9yC0S1u0wRkHTT/s198rKGdSN3o1b6VcdjpWG5gPmfs4szsfOe3hmO5ibtux2Md4Ydre3NmGDTPaDxfoDDY4zFoH0a7LcneFnukcbfrOIA8B6f0ssxMbke5BcAYC7W7Yo5nUwNfDBrpFj2ETd8Gbtd3Tcld3i3thUIKaf+RPbfJgyddruT9VYI2HtBZ3cfedkmFSO+qMhTd5WJc4cqa75y6i68hSVs1yZewlVcetfhXVI+f75QijmKhSDMSSbIru43OLCmOMUx1ERguNqkDbXcA7CINL+72CnJL8gOk+jycHQ3xJGTQZCDy99sqMvpGpXtOYReDfBxUySDDRp481gNOTIRkL4kAA9wk8vbt1mTEW5hadzrgeV9mHryvnUW/aySxSbCd8ton6p07Qp2Chm6k1TXfCdNw56S//jg5PhhAkUy/UD8DrgYShHyGZX5Me7TDdH7CMszFq6uGwM2pL2h3uko+lcHq8I9gGzZ6T9q4eu0Rsf1Gw9qIvltxNBga2z0hMoDj43l2Q4xBNovAGBFoB6erb6EUVoFAMKOaMnvHb9Xpe6b2qUMO8dvJuxcFwgPyhXQtBDo0FSITERGnlPHU/ZqwdVfAM6N//7e87l+fY5DycUdklFt0C8XDcLmkG0HZKuZE0bhfVGkQGPnR7gVME5oik+l/j2u60HIMF7wl7AXmcxWTB1Zq5NH3cq0tD8sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(7116003)(66556008)(8936002)(2616005)(83380400001)(54906003)(66476007)(86362001)(956004)(55016003)(8886007)(66946007)(2906002)(6916009)(8676002)(5660300002)(38100700002)(6666004)(316002)(4326008)(508600001)(3480700007)(36756003)(26005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iyTMH4vcQ3bFj8vb44Idf13NUvAQU17JDWKB8SN53bI1C7V2EjKaC38ViNQ4?=
 =?us-ascii?Q?f89WZTgD/XZQOwxG10j4f7xkR02ZfwsTC0/0rOOdSfn7SDJ1b0b2Vb4l8gNE?=
 =?us-ascii?Q?opHBsILTfa+O0mf49yPIUPxAmSVK3+h7YFTHdwr/XE+0M12LoU8e0lM4Pvir?=
 =?us-ascii?Q?UiIemiFXDR8QEQC5kYLbyjw5hauswq/68hWWTIRirWBu7Xzn/MSx0glR+US8?=
 =?us-ascii?Q?AEEw0rffo605inNwUDo1HdA28t7iAuyBzLqYkXVCB0Ovo+JDjgXH/XQfp8ES?=
 =?us-ascii?Q?w78r07yTI4nNpOpbOrhaCk+2YlKUhHcPqcYqNKuf6T0Y2KoyUIn0J5P8o+Tb?=
 =?us-ascii?Q?97IdUkzvS2WyE6qkH9sCxc/JM5+iPMbrLD+dTJ0u7icOCAaRnB9toV3zPdhR?=
 =?us-ascii?Q?+p56rHTshNmg7pKmG9WuEeFvKVnHqibYgHVRcr+Xso0B7WeGtjrC5PyK/sZz?=
 =?us-ascii?Q?Q4LsRA+j+QSEOwJWONh+zglZ/dApjVFK6Uae3TPptJSTjjK9Zx+D3zZYAOsb?=
 =?us-ascii?Q?hUceD+vrGY5AG7ZB3qjCebZyBrS+0K6TmEcV8Pe5Tffh3Vw7KYiMHYo15jVx?=
 =?us-ascii?Q?qBVt1uNxvklJQTKEakhibJzGlOo5MXDOQktdndUGzlvg98Agee/ObWlTxasl?=
 =?us-ascii?Q?OmKG71zprk0qtJtv97vWlWbcpQ3ffnmWFh4ujFw5dZB38Xrioaapu2VsqKTv?=
 =?us-ascii?Q?q4pOTfFpG9BY8LZHyQBgxyDqiLNOuvGCNQuEJc1nxckLIbSEL+Cmlw9RBr0e?=
 =?us-ascii?Q?AeNlcKDMhueorQ8SDgN2Di4hnULbaQbKcXL7Gy7V/RgtLf7QyaQvNjpcFbkB?=
 =?us-ascii?Q?TQ/kldzekAYtoYnUcA3g2XiIAGxGZhrXps3A75PHHyJmJR5YZYJ35Js2TiTn?=
 =?us-ascii?Q?RrD+MB96rAhgQL9eVdJs2W4ELR8LChNRmEDoNaJ3bH8v3k9weTUHvQHYSkvp?=
 =?us-ascii?Q?cpWhmXeksc1tqilBKR+PkdKstXOtU9vhOD/XPJ2hU96TSeVak+R5wNzEjfXM?=
 =?us-ascii?Q?W0p8v3YMvHn9CtQ0SjiV8AydDwp0tHeNQ/xV9Le6aRKdn70BmgWHNlQQ6ARB?=
 =?us-ascii?Q?LMigIZSBKdx/jVhO6TJ3J6jBAYXqAjk79A0vRLTdugEpL8HuEiKSYK3DYT0x?=
 =?us-ascii?Q?8jPdXBBRPrnuV/oWAdDEF4I2xYZAKNsZNQRdxWOnI+0Xal2MG49b1SCFnpPz?=
 =?us-ascii?Q?DeT7G8kzYBzXHRfn7rSLIkSH8iOGdH5wesGSC4w2hBAng8OVHOji8CEo0hXZ?=
 =?us-ascii?Q?w4yIGr6Bnn4jbVk/Brz1tAMFjVF38ZLbehQYsfcR+lHaznH82zojNKrdNRnJ?=
 =?us-ascii?Q?Ii0/DND5kze0G3ZIk6XbeOOk1n8USawleQSwrE9W/LICN0Qjo9kSxeBV51dp?=
 =?us-ascii?Q?QyC7LxnEgbzZt4cd30ruiZmyxfq2kXwndjD/pTZ73FgflSy21wixK9K7aoEj?=
 =?us-ascii?Q?D2S+EmR0xB3jr1fZsrstazg05HoL0QmGuWegUKN9/9sqvvaW3CnJ/PitI8K5?=
 =?us-ascii?Q?5mryCKkp0At6bDlJd/3E7mYUgDcrj+hI46cttYbhIfHbgMEbhfIRr2SBKxL3?=
 =?us-ascii?Q?HapZPkkLKMkwEa7RNzXvO4ahEtxu4LpXY1NXQuf8gEJO4EAbAnHTaWthTU5O?=
 =?us-ascii?Q?4LpcJkmGUD59SuucuilRV9w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8be99f-9da1-483a-e13a-08d9b4970746
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 06:51:40.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85M35CpF9L+GwkYmvgjsXmrOETCQ5UAP3XzezpcngbHVr0oH4TRjCPkudsfcbHn/PuaZUBykpChugZRyCA9tSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 01, 2021 at 01:40:52PM +0800, Mike Lothian wrote:
>    I've just tested v5 of the patchset, the warnings are gone, kconfig
>    looks good and shedutil seems to be behaving
>    Would it still be useful to get the above trace?

Is the previous issue that the cpu clock stuck on 1 GHz still existed on
V5?

Thanks,
Ray

> 
>    On Tue, 30 Nov 2021 at 10:50, Huang Rui <[1]ray.huang@amd.com> wrote:
> 
>      On Fri, Nov 26, 2021 at 09:24:43PM +0800, Mike Lothian wrote:
>      > So
>      >
>      > 0 is my 6800M
>      >
>      > VCE feature version: 0, firmware version: 0x00000000
>      > UVD feature version: 0, firmware version: 0x00000000
>      > MC feature version: 0, firmware version: 0x00000000
>      > ME feature version: 40, firmware version: 0x00000040
>      > PFP feature version: 40, firmware version: 0x00000058
>      > CE feature version: 40, firmware version: 0x00000024
>      > RLC feature version: 1, firmware version: 0x00000044
>      > RLC SRLC feature version: 0, firmware version: 0x00000000
>      > RLC SRLG feature version: 0, firmware version: 0x00000000
>      > RLC SRLS feature version: 0, firmware version: 0x00000000
>      > MEC feature version: 40, firmware version: 0x0000005c
>      > MEC2 feature version: 40, firmware version: 0x0000005c
>      > SOS feature version: 0, firmware version: 0x0022020a
>      > ASD feature version: 553648226, firmware version: 0x21000062
>      > TA XGMI feature version: 0x00000000, firmware version: 0x00000000
>      > TA RAS feature version: 0x00000000, firmware version: 0x00000000
>      > TA HDCP feature version: 0x00000000, firmware version: 0x17000024
>      > TA DTM feature version: 0x00000000, firmware version: 0x1200000b
>      > TA RAP feature version: 0x00000000, firmware version: 0x0700000e
>      > TA SECUREDISPLAY feature version: 0x00000000, firmware version:
>      0x00000000
>      > SMC feature version: 0, firmware version: 0x00412e00 (65.46.0)
>      > SDMA0 feature version: 52, firmware version: 0x00000045
>      > SDMA1 feature version: 52, firmware version: 0x00000045
>      > VCN feature version: 0, firmware version: 0x02110001
>      > DMCU feature version: 0, firmware version: 0x00000000
>      > DMCUB feature version: 0, firmware version: 0x02020007
>      > TOC feature version: 0, firmware version: 0x00000000
>      > VBIOS version: SWBRT77321.001
>      >
>      > And 1 is the onboard graphics for the 5900HX
>      >
>      > VCE feature version: 0, firmware version: 0x00000000
>      > UVD feature version: 0, firmware version: 0x00000000
>      > MC feature version: 0, firmware version: 0x00000000
>      > ME feature version: 53, firmware version: 0x000000a6
>      > PFP feature version: 53, firmware version: 0x000000c0
>      > CE feature version: 53, firmware version: 0x0000004f
>      > RLC feature version: 1, firmware version: 0x0000003c
>      > RLC SRLC feature version: 1, firmware version: 0x00000001
>      > RLC SRLG feature version: 1, firmware version: 0x00000001
>      > RLC SRLS feature version: 1, firmware version: 0x00000001
>      > MEC feature version: 53, firmware version: 0x000001ce
>      > SOS feature version: 0, firmware version: 0x00000000
>      > ASD feature version: 0, firmware version: 0x21000064
>      > TA XGMI feature version: 0x00000000, firmware version: 0x00000000
>      > TA RAS feature version: 0x00000000, firmware version: 0x00000000
>      > TA HDCP feature version: 0x00000000, firmware version: 0x17000025
>      > TA DTM feature version: 0x00000000, firmware version: 0x1200000c
>      > TA RAP feature version: 0x00000000, firmware version: 0x00000000
>      > TA SECUREDISPLAY feature version: 0x00000000, firmware version:
>      0x00000000
>      > SMC feature version: 0, firmware version: 0x00402d00 (64.45.0)
>      Thanks for information. Could you please enable the trace event of
>      amd_pstate_perf before you run the test.
>      echo 1 > /sys/kernel/tracing/events/amd_cpu/enable
>      Then dump the traces with "cat /sys/kernel/debug/tracing/trace". We
>      can
>      double confirm whether the amd-pstate driver program the correct
>      performance value in your processor.
>      Thanks,
>      Ray
> 
> References
> 
>    1. mailto:ray.huang@amd.com
