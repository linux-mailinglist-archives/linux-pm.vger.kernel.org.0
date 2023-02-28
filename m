Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE146A58D6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjB1MHT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjB1MHS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 07:07:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47222E0ED
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 04:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1UOMntCc6SkeTB0es2aJ3H8Yy/eEjPY0AMoisOsvnE8M1x5yHa8GMN2YDFisxml/+q53mgQoUGOu9R6082++wI0vxMAp9nhTaqwHy8MSQu91yFiLh2XDLzs57SAPdOgAtBu2qFreTqnT+VaVv/0GBR2yJyLUZuLEt2g/xOPDaFs7mDqiakxN+VEWdijZ1xKa7OQbz7YQghR8Rq+n9OKEenl3VEuFzeGgos6IqSggby2FztzuwBOOjgmuutTqjKvPN85kSBQzr4vZXtElra4Qa/UnIJGTnOvb9cVOiu0qwIBVc8EYInRYMJHUJ4AWHrLoFY+40w8e0SlZpTYEsR7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqvkt2X+xXzcZHskKoj60xfMaUxwSXDN1vbQG4iyDyo=;
 b=ZCdUlfgnUBqfvKgJNxwJk0aPCgSsNDFVKWR+E56QlGUWIh/eNaO0o48WxRHNAgPXue7k9C8zW9witsXp2jmcxD9uaFNbz4DMBrDI7SzXN1YJZbTzzxHU1PoNMpytCEJKykIJoM6vdwaYW3vHTqWLSwJCdV3AhcxMHidTO2UcwcHrUmNw1b6z+sM3kHsgu6PjUfYI7NxJDQ1X+mC+vK8U5NeT1s96zN7delJ6HTXneBWKCZWUOMKZ09+cUj8ruJZZxN11Rz7lOE6G4IalREuIRBfvXR1tajyBAQLkkazF1xJ76CNgjy3zPmxModzV7iY6PTYhFwOCQaQFt2CRkFmarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqvkt2X+xXzcZHskKoj60xfMaUxwSXDN1vbQG4iyDyo=;
 b=LZJdWejNENEfPylW2Qkjd5ha5Ds0w63UhEIdgldosVh0+FybtqEDZBbXWevzuHR+GuqqAWJIBfvvneawypLvcX1tDf+3aiVbVgTjSehDpenzWiZLMS/A3c4F1MNzQ4x+paPjDuNNvIGtIrcIpTz+phvTNnlC3G+8xZh7Fe+h0JiKbEItgK84WMjhu8gCTOs9GJj83yB9a8hvhLQWNNVmP8MVxHO/M20oDndTpDI/U8o6CaNjsUwvITxCjiOK9oUxN+hyAz7Gc+AxgY9HNdyQh1ALTlGT5j7JNZyzoGF2fo3tuHFX77eYJp2/4d0DmMhoVSxKjNrN5hcSWU4i/yjpLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM0PR04MB6929.eurprd04.prod.outlook.com (2603:10a6:208:181::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 12:07:13 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6134.029; Tue, 28 Feb 2023 12:07:13 +0000
Message-ID: <545bb6c8-8c5d-6553-469a-99c1f4245b0a@suse.com>
Date:   Tue, 28 Feb 2023 13:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Suppress warning on resume attempt of explicitly
 frozen processes
Content-Language: en-US
To:     Michal Dubiel <md@chromium.org>, Oliver Neukum <oneukum@suse.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz
References: <20230227121318.2116638-1-md@chromium.org>
 <ae60774a-63ba-e4ab-b434-d3c38cb897e2@suse.com>
 <CAPxDTA8BQDL1hrRRyUjCes77mQ926206i00q1nCEo55RB2CRzQ@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAPxDTA8BQDL1hrRRyUjCes77mQ926206i00q1nCEo55RB2CRzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM0PR04MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 29368d51-13a5-453e-5c85-08db198453a5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F45LRt9rkQTDSFd2OOA1ChWIvWyV7K5FogQN3RxCLp9gb39LWhS4QMYHU9PdO+0U/AsnwDT0xBTLTKIYNTIT+Eb5dsXd8/ltk7a7DxTm0TrcdHEOZ5+yjNyWL7nUvyZel16WYPrJxsbcbGsK4aI9TGL2iou/SgAWdWKIoXGB96mvBzCqtjkdZmxvcOpvRhpOhBGt3WZGl6CemJJyCoXA7legqHe8OkBjjDuIXAkdNHazmgnyQdH/BpDlzSEqolHwHuPDQ5nznUeei2iMlV+Vu481H4Tn04ctjL/CuVC/Q1ndEIqw1LTBrTbgq9KAEQGm+BrVBfnuCjkcY6JgKwfiP895XgCb3TOgG3hyWsjDki4b9iI9/jaKe6wyPXoi1fVH7sd1zmHbkvKQmv5urBP25CaI0Yqxk65EhSXjWIMJ3roQ6o+Mo7PTe6JvUc/hsU4dRCtlKHbQXaxqJm5SBy0kGmepIUA9DroMj/a+HvC1BSAoQkK7AkpI8UMnGZsgPUTYli7TlOYwoepy1LyOiFhYk13maYTFiSDg7hoVDX2BQJ7f/cVLPLVGu/B/tzAaNhNX71uPYEYF0/XfzgcbWJ4tNEYKOhEx2HNr+GVqyF8dlUoJbLMZzx8mXpikNap9nqYDJowjcGG01qIPrU6Yo4Nl6etIwNmchom5Dpniz1K0dxjXwaySd6kuzNXOgs50sSYq2h3OWP+qNudYTE3XtWxXXBPSkvHNkoMkF5y0PFb1ju8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199018)(31686004)(36756003)(31696002)(86362001)(66476007)(8676002)(66556008)(41300700001)(5660300002)(4326008)(8936002)(66946007)(2906002)(4744005)(38100700002)(6486002)(478600001)(316002)(110136005)(83380400001)(2616005)(6512007)(186003)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXA3Ym9DMlljYU1XSjNvWDJBRllaSWhITk1DWUpJN2dKUHhQdGs3d0lOY0Qx?=
 =?utf-8?B?dFBObGJCNEtMSFFmN1J6ajhVKzV0ZllBYWtQZWFETm5BSjZGNXo4OXZteWhX?=
 =?utf-8?B?VzNXbkdFOFhMZWplUEpjdWMrdWF5MlB2RzM4VHJMRlBEZDFkVjdqRzA4bGNt?=
 =?utf-8?B?cUlUTGtBejJza1U5RDVXSEgrUDVuY2Eyb1JSek50amc0dWlVTmhCUldTKzIv?=
 =?utf-8?B?eS9wL2RhQWl0ZkhDL3ZOZEpXMnJVUDI2RjlGUkJFMkxpUFVLV0Q5VVlieG9y?=
 =?utf-8?B?d3BUMVFvUDkrMk8yWDFmemkzdnRDbTRGK3ZEQ2ZpbVpkeSsrdlJtVGdBUmNP?=
 =?utf-8?B?czlBUlY0dVY3a0dBSW9SRC9hSzZTSFpGUXhMSDlCcmRFQ2hXcVVheUFPbXVS?=
 =?utf-8?B?Y2xXd0lKaVpkblFMMExuNEVIZjVrZUtpNjkwZnRvazZqMWdXNTF5WWIyaHhR?=
 =?utf-8?B?Ymg5LzFrMW1EbHpTWXE2OUZockFSVlU2ZEtqQXNYdm9oTmJvUFRVb3BnMHJT?=
 =?utf-8?B?cFpIc3ExNDM4WEtUMFJoOFkyRm1PZTZYcEcxUXlXQUpPeWNzL2JieHVzdWpY?=
 =?utf-8?B?NmdOeThXSEN2K1g1QnM4V2ltRUQrREVwWHlkclJoZWN0QmFPNkEyYnZkQVJa?=
 =?utf-8?B?SmFPeE01TVB0TmliejJjcjNoa3hRRWJadXZVa29aelo1bGh6OGQ0SkU1VWxG?=
 =?utf-8?B?b28zcmM3NEthNE5XK2czZmJqUVNVTE5VemdSeXVONGRReVVmMnpoRmJLZnkz?=
 =?utf-8?B?TVJPbmNwZ3IxZSsyQWI0MzFJUUdJT3QrV3NiOCsxd3lPbnJwRUVVdVduN3hv?=
 =?utf-8?B?M0V3enZrR1dkUFBaT0l1S09pZnBEdktRSzM0Z1pDS05DazRYcDZZc3RXeWJU?=
 =?utf-8?B?SUNKaThmdy9STlF1Y0wwcGU5TGd3bW5Zc05xS1p5cXMwanFaQ1NtNXQ0WUNm?=
 =?utf-8?B?MlVZeG9hb0ZUb0pmRUZ3NmNuTktVenM0U000UWxWd2FLTUUwQ3VCU1ZtNmQr?=
 =?utf-8?B?Sm1rcnFVYXNsakRRVE5BZ3NoVjVMbVQ3U0FkbFNaT1NMNE9Hcm5LRW5vaC8w?=
 =?utf-8?B?TWo3dEVTVzRIcFhHN1FReTN2NnBIZ1BHWVc2azdUd1ZoR2NTRHJ1RzFuMFh5?=
 =?utf-8?B?NnFlakJKVVN5Vjh6QWZFUkVBNW02aE9MSnpvQ3FZK0NlVDlwRkNiTkx6b1Zs?=
 =?utf-8?B?RFd0c3AyK1JxMW5BdFJNb0MwTHNpbDN4SGVSZjlHcDBCdGo5U0lybEd1MXk5?=
 =?utf-8?B?Z3J3a21NVW1xUHIydnhLaytFRW1uU1Bwbjg4SmJzMmVSZGcwUVl4WWMvdlB4?=
 =?utf-8?B?V1JOTmZ6OUZpUUhvZVIwcm1FSlBQU2pBV1ZVaWlmVkVndjU3bXp5dC9CM09v?=
 =?utf-8?B?bnVMSG1wM1NNdnMxYmEwNlovVllYckpVZTNNT2dhUzhLMnFMSDB0ZGkyeWJw?=
 =?utf-8?B?UFpnT2x5OUVJVVB0Zk9kMllPODhVWWFXaWl5Rjcya0RFYWMvdXUrMkJubHVC?=
 =?utf-8?B?bjZ4aEdhYUdORmZHaTJuZ2RLMGdCQzluWTVTVUFaM1pkSm5Wc2hQODV4NG0v?=
 =?utf-8?B?bkJzTEUwS0tNSTA1RHlNRCtoenYyWlJueWpyYVlKY0RpNHJSQWJVTFJXREh3?=
 =?utf-8?B?ZXVJMGxFaHdrVmRGMndsUFJOZnRLVTVibHNwZTNKSXJYZEI2OVlycEVNM21Q?=
 =?utf-8?B?b0phbUFzUEZLQ2p0VldWUWpPVHNhSlFSekZsVzhNT0lYR0lsY1EvUHVVL1FC?=
 =?utf-8?B?Wk5nRlBqa3ZyZ1puajJydXNHTGJyckVCdzNMdkg2VmcwMzBDMkdmTVVKakNB?=
 =?utf-8?B?TmJteGpCNHc1VldxdW5XU011eG9xMWVlRDNWRWRQa2JzSE05STdvMjNYYVg4?=
 =?utf-8?B?K1I0dnhkZklvSEg5Z29RcEtrMHJnKzh5VHZ5L3ZSSUMxMkt6dkpVN2E3blVx?=
 =?utf-8?B?YVVXb1N1Tm5RZHZNZjdpNzZKQ1hIR3YramNhckFJU20xRXJqemNoa1FISEZ3?=
 =?utf-8?B?UURoOC9rbERyWWZLeWZDSWRGUG4xVGs2MmxUYjVHbUVYVkRmSG1DVDg5ODVN?=
 =?utf-8?B?eWo3MXdaREtDVXdyd1lwSEVyTTZLK0JJRkRJVWpYSWVzcFNOcncyejhCaGZG?=
 =?utf-8?B?Tkg0bDNoa0FGcmlkaUs0RDBJZFYrSVFxYmk2N3lCckJVY3dVVU9Ec0hjb01E?=
 =?utf-8?Q?6nBHnvmIQO6oVRZeqONETyVzi2anM0BbnrvJ1eAi4rN2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29368d51-13a5-453e-5c85-08db198453a5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:07:13.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tplEqZU4aPsPglDMQMGCjp+W8k9Ed+8ZxYnb8nabgR1iNul8zNXTB85cadHCGzxVHm2d/j8FEoSl/bdKOACrNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6929
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 28.02.23 11:11, Michal Dubiel wrote:
> On Mon, Feb 27, 2023 at 4:19 PM Oliver Neukum <oneukum@suse.com> wrote:

>> Isn't the core issue here that processes frozen from user space and
>> tasks frozen due to a PM transition are not in the same state?
>> That is instead of inventing substates for a specific state you
>> should have a new state?
> 
> Please correct me if I misunderstood your comment. I believe that
> effectively we already have a separate states for task freezing due to
> PM transition and due to userspace requests and the kernel is able to
> differentiate between the two (e.g. there is cgroup_freezing()
> function to check for that).

Correct. Hence there should be two states also formally.

	Regards
		Oliver
