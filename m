Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD46A45DD
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjB0PTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjB0PT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 10:19:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093BA22A30
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 07:19:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDpYVWG0m4t2a1zmExQi6l6AtZG5HHdMCucRlv7/Pr/GEYJqTwTFqeF7v6W8Z82jg0InayQwDm6KYy4Z2NJQgj2YuW0dtc+bsP9jb9vvHj/fnQQ1Y3wHOlrIuYWK0bOX8trXmK0Uuf/iig9YnfG8g1qd63iuZPtznSLjYwPOUpqPS4l4dQwq8GOYx8lU1wbNEJuf4NY5Y6yrbDLhYcrU+IWXfO63O5pmK/qKzi83O1hR1ANFq9DEuHtbyW5Axzf/VAI2U8JXBrHa7TUJXqXSGr6rL+8T2FVsAA5NCkCCczdNcA2Iu9H3qSLgxoYvntMW2oewKu1vBHoDJRmA9ddsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbGemWKXnUCZTJPeWMmMBWwde5IymCm0pcrRTjpcwaA=;
 b=CcRJhtkqAHM4Ce7U82Qj/163eDyNeFlurv97Q1VKD+fmJhxm2SOShE3YeeCkwksBD95YGt4KXzO4fz1p8SWQlxwX37WMVDRzwwbc6AF65wjMVvVHuMYE5s+DqsMz356nYq+cv6+SFl1ajueEoS4y+pPXi5+yAVx0uRkQzXL6n+DEpYtBVcElrqzK71KduR1VCJ9V6KXU3lrIn2gNmtg3MjSnNWlKlkiTAzouNgREUIW7CoTgiKTN57lmBilPutffewL9dodM4R4VQ2lZhXkURO1EzbHpT+67dOGvUhHtuOlDT4olgUXKPHiva+zQBVB5YmfgZQeNsUKHXFhfFjQbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbGemWKXnUCZTJPeWMmMBWwde5IymCm0pcrRTjpcwaA=;
 b=1Gzgfm5lTsBRnczl/1DjKdfyWqURuqFhF/JN+AgmIVCVOspkqDx89URhbHpXPuqEtn3Tn7qjhfXE+RckV0EwmD+VoAvROCj/GFKPwMwDI9zBG5y3NvgH6in6bLaHS23lS4kHF5n+nx9fqPaZUVAWjBfzeHoc2WhCqsENF4cIoWNjB9Lurs9MP2RLeS/8HQapUkDuSun8tjo1KFeU1UMtot4ytF4hl0dvA9ZrrxcpDxLPEaSQBtfHCfRJ5pzXVtns1pPWtFs8hyflE9GfFfi35GYYvNmcahQ0qUKCivrygDsSV+qa11sRtOtfgjdssA772LqIvzApPOUOT7Q/4dThzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 15:19:18 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6134.029; Mon, 27 Feb 2023 15:19:18 +0000
Message-ID: <ae60774a-63ba-e4ab-b434-d3c38cb897e2@suse.com>
Date:   Mon, 27 Feb 2023 16:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Suppress warning on resume attempt of explicitly
 frozen processes
Content-Language: en-US
To:     Michal Dubiel <md@chromium.org>, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, pavel@ucw.cz
References: <20230227121318.2116638-1-md@chromium.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230227121318.2116638-1-md@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7be5a2-5b5c-4dda-96dc-08db18d5febf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VCfl19WLnvgatlxx+DFQM9DFRD2ArqjsZqEwsUF8i3NZt/5gKQAqUK6LRXeDobCdf0tmvnqLgd635/tavHxzAtWsuJyjxsXfnIAS1IyPx7DYoPrMhlZe0nL6zN7+LXHOLBKyY+ax7uxPUJqt1AeLk8rOesbXTbVS9xj6jraAUPYYFlzwoXe7siLI3hT24l5FSRjV75LfMJkXNB1k0ONyF1HY23eqfCLXa1Ly9n5p+/6V1Wwl2Im41v05A/Jg/mLzpbV5yk2lrMT7lr8ysE4Tgif1O0/fdmnyKtzf2iQvP2ayqDKXIAI+LDgdsinXvDWH2uIblrRR0ENKCBW77TN+daU9fuAO/OFSmsKWDjjTqEhDedIFnMf/oXiIIW8mIS5PCaFPvw8BsU26/IEV2TEHHcAI1MYkMhucvREnSlPdfDBvvtpn9AAoZkx0NQRz7R/KUjC3bC4pDIJo66EgxQ0uyd3JiEq7oeRz8GZSf20X5QK4ATkJM1lYlJhCwNojBQZplDI5g7MJgrAYsJkm/itM85Sp30xZoLXD0FPJzbdmvOtpxjSPOw92a5onMuA50NIm8+Nm7L6oCwlht/OxhMw0W2rhAwV5NAisouHXvNqRLptlf0x3zUHzyTYe/Uk/X2Hf0hkFh5g5nzbzl1EOWP8eD7BbzbBDZEJpUaeyiPyCU0eGTiBqNWUK1nXRfxRSy2FUSCdHz0nrDm8ZkJqSxuL0a3qoBR2w2wxKn2o5ve9Sf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199018)(316002)(2906002)(31686004)(31696002)(4744005)(36756003)(5660300002)(8936002)(86362001)(6506007)(66946007)(53546011)(66476007)(186003)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6512007)(2616005)(478600001)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFErc3gyY3pTWkcxUFFkME9CclErRjAzdFg4Q3ZTWDNPWC9kMTFPbTVNSWhN?=
 =?utf-8?B?NEZsL3hNTi9pWDFpSThoWmkxUzk2R1IrQ1phMDRGNXBSYkpTUjNsNE1BRE1K?=
 =?utf-8?B?aitNNGpXaFcxSmhKaExZbHdGalZQdkN1YmtmUHVxTng5eVFKMGZwcXRJUzRN?=
 =?utf-8?B?ZmI0Nm10WFFSbit6bnF3dFhnMGp4NjIrWko3bUJKWnpCdW82LzRZUG1PWWl4?=
 =?utf-8?B?Zmd2Nzl6M0dvZ1QrMGpkYmFVQXNVNUhYQUpVMDg1dTI2TzJuUjBqVFpTZVc1?=
 =?utf-8?B?STIzc3JhT0tnWTE3WHNQN1BSNEdrcEhxSzA2L3VqdGhKcmZNa1ZGQU5RMnly?=
 =?utf-8?B?anQxUnQ3djlSa0x2WnVEVWd2L1lhU0d3eWxDbXNSMlc5R0IwLyt0YXJveVJK?=
 =?utf-8?B?SEt6MEFodVdzdXJHQXdybjNvQ0FhMjNWUmpON1E0QkNrbm5CTlhRWUNvd2NT?=
 =?utf-8?B?Y2c2dWZsSEFHLzYyV1NKcFNyZ0I4TmVkNE5nR2QrRXY0aW0xaUFmMzFza1Z0?=
 =?utf-8?B?ME92UjlyNExrZVlGS3BVM1R5bWJrMXQ1aER5L3NTeUdlaHdUcW9hSnhVMmFK?=
 =?utf-8?B?UWNPOWJnSFhsM2V2TVYzemVhR3RDek50ZTVYR0E2dDhTQkpTOUxJai9XcnJn?=
 =?utf-8?B?RVJJY0RDSXNpcWlHRWlZRTQ0RVRaV0ZVREMwTHlseXJZeTIxUzdkUzhpZWVD?=
 =?utf-8?B?ZUs1MysxTU1zTE1ZM3B1QTlyWVVlNDJvYmErdUUweEFGQitLRitIeXppbC9j?=
 =?utf-8?B?S2FPRkowd1NJM05tMFBCaitBNHJjOFJvU2Jjay9iWC92Y2IrR3QranR4a0cx?=
 =?utf-8?B?WCtQVHg4clkvem1XNjNXUDFvZXI4R0hxMVpmb3IxSDdyT2llMEpHclRXRnVt?=
 =?utf-8?B?dkN5c0YxSVhubDRhQmJpVE53eHhQclJsSGs3V2xBYlptaHBqTGpMRXBBVVFi?=
 =?utf-8?B?WFhhSFRES1o0bWNGOFFDUy9mMjMycUtIeHhBOEs2dzZoZ2QyVHV3UmhBVWFS?=
 =?utf-8?B?QWVkeHpneXhCNnNmOVZIU2piK0ZlTlF6SUpPRTBFTWFKdE1zaTJDaGN2RExJ?=
 =?utf-8?B?bXE1cGU3dHozd2tQRFRDSXE3R084WFE2WERFbEl6OGlrb3I5UVJrT1hOd29j?=
 =?utf-8?B?NElSUmtQYmhJRmZwS3hnb05HMlpER0twSVZLS2RrQkhpcUcvV0lUN1pCdzJl?=
 =?utf-8?B?SWxoaEpVSnJCVHlhLytHV0NEdUgxT0dtVjQ4bDhGVjFUUTBjYTRzbDZ6NU53?=
 =?utf-8?B?N3Rlb2FSVThiRlJ4My9rMk14TDluNDZJMlZPNHhDWERRWmZFNDVEb2NUalJ3?=
 =?utf-8?B?Q0taV2lNbE8yQWMxWGx0b3ltM3l2cXA0dUlkU2NKVnVYYTFEdmFQc29SQTVQ?=
 =?utf-8?B?TVJjQnVPUjFULzdJWFZabWtMVXEvTXVjV2t2SVgxa3pYd1UzZlBzMExSNFhy?=
 =?utf-8?B?WmEvZnA0dit4UXc2Ly95RFV5K2V1YTdxaWczU1BmemMyYi90bzd4dG9GRHVZ?=
 =?utf-8?B?L2ZzODdPdlNJUXlBekZUMnFMNVpDdEZxRWowclFhcFBYSy93VzNhVVBFN3V5?=
 =?utf-8?B?ZUU3QzNxcG5SWFdEVUtDM1FqTHdEa2w2TjRkSEtubXhEcWFuSWdmYUZJdThn?=
 =?utf-8?B?VTl3R1lBUklmL0dEWmJVZkJBL24vT2VoSDdjbThtZEt5R3Z5RlM2ZG0wQmdQ?=
 =?utf-8?B?UFFTMHphMEtBN3VPeStQRHdBQlpOQy85TlZBSzhqV2JGVnpsZ0VIaGJ2OUlC?=
 =?utf-8?B?dXVGY3I5V1B1UWVvWHZ5SVVoSDZEbkxjTDNOTEg3eEFLTVR4UWp6NVIrT1BR?=
 =?utf-8?B?SytJNE91R0ZEa3ovdGRXZk5WakJ2TjJ6R3NPR3UydlVIU0FDemhkTStLTzVX?=
 =?utf-8?B?czhOb0pvZ21LVVFiODA4VHJldmhRejN1QWMzbC9ML1JYN29NRks5WFo5WDRE?=
 =?utf-8?B?YkJLSXJXVVFKUkVOSWgzYU9lTVpYNE1BWENOb3kzS0tMUWxjMzM1T0lsNmVr?=
 =?utf-8?B?YVA2UWFYZ3M5ZXUvZ2NOTVBFVFE0YzIxejRLZE9hb3F2RlNwSjluWXorUC9Q?=
 =?utf-8?B?MEJsdStmOHJwWkQ4RkJRVk0zMHE5M09JWjI0ZlJ1cWcxK0w3K0dLQUgyb253?=
 =?utf-8?B?ak9zRWZKUjYySjBXc3djaWgyMU9HQVdvajVsTU1IdG4xbC9uMU13cm9MdFNI?=
 =?utf-8?Q?G626uX5ouv7HkSt8bgtr1LgcvRvxxx3AcisS75trqhhD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7be5a2-5b5c-4dda-96dc-08db18d5febf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:19:18.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDTLLJaxwOpDxgcJaBjaP8In+sOURujpAWBE0vLDRgzqI/NT25jDpm5yOSpTM4/6Y81ZA1eo3PV5iA8DEg/bTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27.02.23 13:13, Michal Dubiel wrote:
> Hi,
> 
> The following patches disable warning message for thawing attempts of
> processes that belong to a cgroup that has been intentionally frozen. This
> happens in the following example situation:
> 1. A cgroup is frozen by writing "FROZEN" to freezer.state cgroupfs file.
> 2. System goes to suspend.
> 3. System resumes from suspension.
> 4. The cgroup is thawed by writing "TWAWED" to freezer.state cgroupfs file.
> 
> On 3, kernel tries to thaw the frozen processes. However, the processes of
> the freezing cgroup should not be thawed in that step, but rather in 4,

Isn't the core issue here that processes frozen from user space and
tasks frozen due to a PM transition are not in the same state?
That is instead of inventing substates for a specific state you
should have a new state?

	Regards
		Oliver
