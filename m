Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07250F9CF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiDZKN1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348627AbiDZKNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 06:13:01 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A82252B9
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650965749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xu1qflR0DCLVp7SnT85beMFsFbXhRNs7jZcCpgZgPto=;
        b=QHeVnqJ8GOBvNcccwC7HSufe153EFp0nlGxmSqziM8Rgo31TJqrkxcGLU99OUyEvf3isMJ
        38h+MkgzEHTIs2Qflr7V/qZA4MSyIClCf97qYpj8jVPCsU0o9lB87ZB91z7uBb+7qt3q7m
        nUBlAZEatqKGGlqu0BtS7hV34Y44T+A=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-liWjc4_0Pfyz6sYdiE6XPw-1; Tue, 26 Apr 2022 11:35:47 +0200
X-MC-Unique: liWjc4_0Pfyz6sYdiE6XPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRv6D8aNGWIP+WYtHj6UcfNJ8Lv+VezNVMOSUmMyC2W7P/aj52CmQkYBEsfz5q9CegLr2jzCOCOKgcXUw7fdk4NVaQxxTr2/lmjwNM/sRlOSm+tVTMs5jFr3z1TKLFfRigkq+HkzuugnVIpbTVQy6D2wZVeeFmvSm28+dwNcoa/K49XzvjqUZAeO4KaFLNfRaqcSjic7/RjAa5N0MQzGoOMH8Y5jz8vs5bWU0e4AooJG0jCIKjc0Il9Y72OBQM00NeFtqghocymaFEZv6ceN/arjGQ9zAyzgy8GHKC+uzf0Zc1b+g0j6jM9AeUqi/RnEEDCFu7xniQeQM/z+06VLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu1qflR0DCLVp7SnT85beMFsFbXhRNs7jZcCpgZgPto=;
 b=mFcm7LQyun17JiNJlCDBI6oLTfP/MvrkVSlQ7b9IkEG5vqgJhQcxKDJ0C0HDJ8SkXCbDNLMOFujzlPfr8uYwSZoAXV8bKRB1If9AXFVoX9DGHWv+BLHoemw7EyYCLMU+ybH0bW3pNRyE+V2bKXjkH5V5sTH2vt8PalHfPqkP3S+DVI9uUelEHFZM1BlQtwfJscOiJ96IJ4rzOe6l+blFkKeO4Yrc2FXY1ErJo6xrRWj1G15dBXhpF1KAOqHiv7t82x9y80mWmlZDNQT+l76TG6FBNAVN2yXxdriVw54z7xDRlQTQovDt/np2GjjzZMuBrhtjyNGQS3rpuRmSj+zTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 by AM5PR0402MB2915.eurprd04.prod.outlook.com (2603:10a6:203:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 09:35:45 +0000
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f]) by DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 09:35:45 +0000
Message-ID: <af7b829e-0d4c-8e4d-faf7-e86f2813cdab@suse.com>
Date:   Tue, 26 Apr 2022 11:35:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: your patch "intel_idle: add core C6 optimization for SPR"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0491.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::15) To DU2PR04MB8616.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2f8d85-089c-4c3d-1837-08da276823bc
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2915:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2915B877FD479A5BE04746E2B3FB9@AM5PR0402MB2915.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ca8T9gN0do41u1FaL1/n76f6wQi2P1H37GCG4UuK8oyk7xQvft3k/55mQb/vnrbHl9dlGIeg00ALTgYJoQj9jvUrYC5f+C59fF9l2HMLvlc72NWry102XlgGUMm91YM5ACezd7iTF59LPQhmlcfoGOv9DyDL4JqGF4xQSZB7TdOQ+988ZKd15D8nqvS8igJmB0GANfWru/YXCVv2ZnEI3coWOkm2Km/KUPHYujMfVryodDm2gQyu6gbYuJCwanptqSNH7mM/PzfoTbNtFmGqPX8eEBbanErqXFKICjDaM3iHCzojczyP0/TFE0tocPGNRT9WlaLTlBk5baJju9FeX4WjR1BDViNI7JJaylW3tN2FKk4bPtx5XkSqUL/i+RJhR/eEDbV6FxIpWKpNgahEGGUcL6SjdiT9IWhjhCoR1uiMbyx/Gz3vPxx26jfddDWA0S6dNiMzidPEOemmlB9Wz/aCr7UOHcS6YnHw30a3IRIpv4OVdou82YNZHbG3mNFAjImTvtueLMtxyhxLi9wUHS4PK+rxq9m0VcLdFBvqONx6k/g7muysAZuZiKzz1mW16Ej2Y+p8EMZqnsruYvNSkxdNQiSITGkjrHpJUdVrCsZ038TRc9KofPGLlCc9OlAm6YH1kPB0IQSJ+p3Kj6bISvdSfy/5qvYGVD6xtD/+54N7albo7I9MullWgrtbi6dfeV/pTCcpsUjk45xIApcy5/Son93JJZmMsXvgKFQVV8kAskEybJiT2auWNUdiGDjM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8616.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(38100700002)(8936002)(2616005)(66946007)(66476007)(8676002)(66556008)(83380400001)(31686004)(6916009)(36756003)(5660300002)(26005)(86362001)(4326008)(186003)(31696002)(4744005)(6486002)(2906002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtrVEZkd1pHNkRWYkQ5SCtQSGhPamNCRVd0YTVzMXpFUURscXM0OExYTjBO?=
 =?utf-8?B?TitIc0NNMllLczl0b2pkeVI2eW5sQ3R1MG0rQWs0L1BUTkhRTTNLUkpjNndC?=
 =?utf-8?B?S2RvWWhuRTEvM0MvTDgvc2dGa05obG5hTXBhTUVRLzVQZmFYZmp2cXpBTEFX?=
 =?utf-8?B?L1BReHlJOHNlM0pBNjBpUURBTGlVVlhYbUZya1JRVjZyU1A5Q3Q1VVBLdWpX?=
 =?utf-8?B?NjFPUFZWU1JsUlRheGZjbGM0aGFTVGdYUUJzcWtoMklEaHlEd3R3MGViZ3Jl?=
 =?utf-8?B?VkxqQkc2bEhrVWlhSW16SCsySGFoR2RxR3RUVFQrQWNqSGtyUkNFbHE5bjJp?=
 =?utf-8?B?dXdzWUlLaDd0UmdmMjJVcW9EamplblA5NktKeTNTbUY4U1A1OENNem9VSitj?=
 =?utf-8?B?SGRJNHdnTERtNEs4Qm5nWXFTUzJ2VWExMkJxaHFWOGpoQll3K1MrdWRvYWI5?=
 =?utf-8?B?b0ZMSlRXcmxhdys2K0MrOFhWaThEbWtYaDJ4bFBmQW8yTUxsd3dxbGV5ejZn?=
 =?utf-8?B?aXBrdkRrQ1dzUWtxZmlJQlpXMDd6ZWtUYnVQRkVYRTNuenEreUVLeDVXc1pq?=
 =?utf-8?B?a08wRWR6blJvUEw1OGVYamxTZlZ5c2E4TjRDNy9PSG1iK3loL2J6d0trUlNG?=
 =?utf-8?B?bi8wRG1RcEFPMXcza0paakJMSDRnZUxuSUpwaW95ODFubU1RMjdGQjhWelNv?=
 =?utf-8?B?VU55VFRYQ2VLZm9uRlRUNSthRTRtSC9RSHdkZTNIMzFGN3I0NkVGTHFmWUVM?=
 =?utf-8?B?bDhMb0JwQ3BadCtzQXcyMjNqRkFpdEltamx3V1ZscXFzYm5IdzVmQjB0R0cr?=
 =?utf-8?B?bmlNQ0tPdmxFVjRncEFwN1QzRDg2L3ZRYjQwSy9CQnFSWHkra0tFRkpmQXNY?=
 =?utf-8?B?bUk0Vzd4R0tVUjYrdTlwaWpBaTBKNmYwRE0yNkdYSzZ3OUdocjBjUDkzMFF2?=
 =?utf-8?B?VWlrWWZzeHVhdEtZUkt5NUZaUkh5V3NURGtSblEzNXJvb1kybXIzSFRWWTVu?=
 =?utf-8?B?VHVoN256OE1nQUx0SlN2cndzQ21iVG9YZG9NVjlqa2lpNVFQZGNKRy90R0Q2?=
 =?utf-8?B?QW5jU0xnSnY2eGE0ZkhYVVZhQjlEREg5V2F3cFBNOXdUSW1ZaU1qM21UNXly?=
 =?utf-8?B?dFYrRG9iSFFlYis4L3ZpbzBER3ZWamFydjlOcmFTRkFTUHc5TC8xVTVZajRr?=
 =?utf-8?B?TG9WMmxpQ0l3K1dkTU13UnFqS0ZSRUNNV3dDbXJla0NlMDNuQzN4YWJBZTdW?=
 =?utf-8?B?TmUwdkpyRHFBS2UzbDV5b3BEL1pxcjJRcUNnTlZkbUMxbEtHZEVzd29UM1Mr?=
 =?utf-8?B?NVRmK2FpL0lKWU1vUHNleUhNenczbGc3ZnZCdjROOHJkUHNmR3F6Uyt3a1dp?=
 =?utf-8?B?TWRFQ2RhUXpRTmhwR3pTWFpid0xUZDgrTVFXeklOa29yVDUzZlM1WE5WMVRm?=
 =?utf-8?B?KzhCNDZEaktXN3YwTEZKbnRGRVM2NzVmNHJTOG0yZXhEUzdUaVV4eUVTRXRR?=
 =?utf-8?B?dnZuUUpuRUNiaTFRUXg3Z1RJZms5K1k5Y2JvKy80STBPOWl1U3FiU1pTTUh1?=
 =?utf-8?B?MTU5eE5HNzNHZFZ2eU9aTGxFQ2h1KzNiR1Z4d1UraDE5TXZOTEwvYVgyeVlN?=
 =?utf-8?B?WktwaTFmRHRkSEt5RHM1N1ppZ2Y5cnAvNlFrQWpnb2hUWlVneklFK1J5ZXl1?=
 =?utf-8?B?R0htYmtjbXNYa3N1UkZJWHVpUFE4ajZ6QXlBSkJsTG1Ra0pxNGFRZHo5NzZi?=
 =?utf-8?B?aFJtTzFUUlZwdmlSRGJ4bFlXY3dGZEtlNFU2YnppQzFQZGFVcVNOZ0F5SXls?=
 =?utf-8?B?S3VUTUNUQ1RhcVRqUVVtME1qSXlycWRmQVpzSXE1emczUjRlc3JSQmVYYmxC?=
 =?utf-8?B?QVljS2wwV2w1OThpTG5hNmdOL1czVWNxeUpWelRLVzVxTHUrWGd5VERjRTQ3?=
 =?utf-8?B?Y2NoaWg3clJVNWJ2T0hhVk1uSzJxNVFOV20zT0dicUIrTE5rbW5EM3l6ODdo?=
 =?utf-8?B?dU9XK3g0UEhteHgybWZkMndkNVlyTHlOVGlIU2pIZ21WQXVZRGFpRGQyYkts?=
 =?utf-8?B?WWZ3bTRjNG11d0NQMjlKU1dpODF5Z3JSWjVLRXFUY2x3bUN2WEU2S3BCWjV1?=
 =?utf-8?B?Rm11QmsrMDRmU2FMbVV6WGdOc3I5dTZEZlZ2SGZNVjZ1MjJNL0NHYzdnV1pM?=
 =?utf-8?B?eER3S0MrWkNNTVhDdGZUb3pFNTNMSjd4SGR5MkJ2NTNLTmZtdVVuNGxrU3Uw?=
 =?utf-8?B?L1JxbDMvanR4ZGtrb0ZNSFNBbUdsVDA5V2g2N0d1ck1INVFUNEJlczdvYnR0?=
 =?utf-8?B?cGZLUnpUYUxONkdIMDZkZ1lGOVUxZCtQVjg0UnN3WGFFMTVzVWkwdz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f8d85-089c-4c3d-1837-08da276823bc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8616.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 09:35:45.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EO9Grmy79Dq/qkiZB+baSTiH7uaqh2flP6XPPLOVeXgc0jvMs3GT1Y5B4ib4OdlkrW7uXAAYf3n6xK3wR6Lmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2915
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Artem,

somewhat similarly to the C1E patch, while porting this one to our
driver clone in Xen I've noticed that the code added here would not
be reached in case the user specified a conflicting C1E-related
command line option (which ought to be unrelated to C6 handling).
In my port of the patch I've converted to

	/* Check if user prefers C1E over C1. */
	if (preferred_states_mask & BIT(2, U) &&
	    /* Both can't be enabled, stick to the defaults. */
	    !(preferred_states_mask & BIT(1, U))) {
		...
	}

Jan

