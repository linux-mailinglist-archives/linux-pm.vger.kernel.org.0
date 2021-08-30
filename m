Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9853FB745
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhH3NwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 09:52:14 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:38113
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231669AbhH3NwN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Aug 2021 09:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoAoBcSM0rMstJPX0EWIfd1FUOScgcj64yDwVsiHDOizsXZCHoq40pg6TUetcCmfcY51VuZaJvdlhysl4q0ikmp0KWRdugJVf+YpsFpzqaYI+vQdxnQ6xsvB2a8v6PrIQLmNlal1QBUsL+LmyJaI5wokRpzJS2s8PNIYqrSrBNEl0HiJy7bTAHW/sBAH/dhhV7VFhQc4PLRGp3S6aTcjxXEtdS0p3NdVewvC3yD0LyXv5a5WtUWCRivEZ49MG8Ig3FZuS/cNzzREa0++TzaitGLFcmHtU7iMvQ6UsW+VSN2nCgsjxwI4CX2ZSsfvqW5QlTTDZFTj++GcnTORq403cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68QXAwfjJ9u44KWMW1egOm4uQM36+EiaxHBedE6DVUY=;
 b=oFyr6ySpWHudUMCrZpjXyBqpJzSpPpv1YJUSEfEHnHx2br7mzVQD1Ru3Ay5gwz3jhZutdc08imbQCewCWZkU8wXVePF/K/sO8s99Cl6EeZFdHwKt4+7ndDVbDWfQ1WrtuK2qr65EmeMnvmoCkIdJ0JHAJNq9vY9tBaXi9AfQpO7EX9ZwOSUFMTz9/d8fc0rn8wMFPBLEDYSeZ8lNKRj4ej1h3YflUDHFLAPyunsXjFcxhEhXmQf3ZyiM73fV0jgnULVdRpYzD8UTCnDt0waxB+pW/trjL9eDArWjhupXymMiazLxRpBd+6GwosXtxg6k3AZJ6e9A0PAf43zDDQ3TFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mec.at; dmarc=pass action=none header.from=mec.at; dkim=pass
 header.d=mec.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mecat.onmicrosoft.com;
 s=selector2-mecat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68QXAwfjJ9u44KWMW1egOm4uQM36+EiaxHBedE6DVUY=;
 b=mblB+1thkoBm10OrgiP44GzNoDs+Jeiv4u/qYH3xjZ2WDpl7pyZiDHv0O6r3PR0LiLRzUrnEzATYwmfxSCvIrZtQhbAhLMiq7PAMXwKe1Kui4HJTjr0EswJyjhtKvhFsvmEbrROf5eiLoI0Q1DnDwKc7BFnNv4hmZ9yzNeIy6Tk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=mec.at;
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com (2603:10a6:20b:291::8)
 by AM6PR03MB4024.eurprd03.prod.outlook.com (2603:10a6:20b:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 13:51:17 +0000
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::1c91:76ec:b39a:da43]) by AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::1c91:76ec:b39a:da43%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 13:51:17 +0000
From:   Thomas Marangoni <thomas.marangoni@mec.at>
Subject: Communication between kernel and user-space
To:     linux-pm@vger.kernel.org
Message-ID: <93abc004-eed6-d78b-9311-a6626e7a0ff6@mec.at>
Date:   Mon, 30 Aug 2021 15:51:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To AS8PR03MB7079.eurprd03.prod.outlook.com
 (2603:10a6:20b:291::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.176] (213.185.161.83) by ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 13:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a97061a-705e-432f-2265-08d96bbd3d8d
X-MS-TrafficTypeDiagnostic: AM6PR03MB4024:
X-Microsoft-Antispam-PRVS: <AM6PR03MB4024BD699403B3579D0688D3F6CB9@AM6PR03MB4024.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eEREYBpPNC4jrfdW6r808u7/ClXLLReo8a5t58JoCIGge2AkFF91Z+uHa7hivLfLXD2yU4CYchRXVDKSMRTb3lVJdfNwkjxmKZEUKVoHuQOFq6dHQkaM40Kga9ekCeXXaL5VLx0JqBp5eo8EptvsebWX4nm/nhw+2adQ5C4ABue+qYuSt5rITWSMrIt28kAspA16eCELgVIxMooqZRzxgor/FIhLwQ0htRZUS5z+B6TlqyMLzT2Gwfoc8cLuHxkNtXPvWmiF5z87BxipwWe93x/7lfxjk4yN55HlhW5dMXU0CSF79/hsqMdIlTjZMA9APVcjltvfmLF3EJi7IrzJbwVWzolBqMAu85j66aVmGBlqZ7qrzdtl9QgOb+5n4bB3k0/HZ4t4Uy8R5frS2axv3oNlY2ouAlGoqb/FxgUEjf3gSJe/TKhoqlN8xu2u/PuLJv53xZ6+w6qzehHmBcF46QBsqCvDnnkfMqe4bHolIDNVNlMkA1cHdHLLAPwV8NJe1t2ijFgYj4nJAQjq2+72D7NHFGS1W+i1Uzq2tv4Nt7jCA2KRpZy3nd5MLJZzwc1ThL9ryCWe9Ak+WCWLz1ZhUX4qgAPC5jbrCHUhqHrA8i4puOrzuRuCgxskHS8Ebgriost+yPryqAj42gadpDiud3f7fxaZuyohv9hqqaYqDCYzzAMQwudf4+7ZwfUsE9LGUDsL128kA/aEqN3dKhYzXI8UaWNtBcgeaEUWSE8LNeVhfU+yW5H6znNfdFWQlV8Ly1OEAr9m5gSJMzl9i3eGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7079.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39830400003)(366004)(396003)(376002)(8936002)(66556008)(2906002)(2616005)(5660300002)(36756003)(4744005)(6486002)(38100700002)(66946007)(316002)(16576012)(956004)(44832011)(478600001)(26005)(186003)(31686004)(52116002)(6916009)(86362001)(31696002)(83380400001)(38350700002)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0s1M0pPeWdvT0xQWUFaMEp0M0M0ZkFKTnpqRkMwa3lTdU42ZmVMbUIxRFB5?=
 =?utf-8?B?UUs5ZmR0eTdIUVhPM2NmYVcxM1c3ajMySHJRREVFbVNZM0tMK2xsaVB5SURC?=
 =?utf-8?B?YmZSK0gvTW1HWldCMnpaRktlWGxXZTNYTDhFR1V2eVk3WW9TU0VNcStpMVBW?=
 =?utf-8?B?UFBwRFlvTTZLWmI0cWRBQ01iakhsNkg3aDlvVXVVNjBrVzREOVUreVB5eFFR?=
 =?utf-8?B?cFc2Ny83bGdLVjh1K1ZjVXVSZUFTMTVGZExlV01MNXZ4bFZvY3Z2Z29yVEdK?=
 =?utf-8?B?N1lsdUg3TWtmSnd0NkNpeVlUbW1aclFaMFBqNUg3Qk1hbFRBc1N2QWpPU3Ar?=
 =?utf-8?B?QjR6WlNNMEQxa01xSU9UNW5CKzFQeU9yRWVOTFRKdU13SDZXOURhTW5iMVdS?=
 =?utf-8?B?V1lxZ252OHhtYVFxUHpSL05TVUpCYkVtU1JIZk5tY1lWR3VmcFVjUVZhYTdu?=
 =?utf-8?B?dUUxTzNLSVVzTU5Pc2tIMkIxMzYrZ2FwNm10MWVLZStsVFJTdnE4aXMxbGhO?=
 =?utf-8?B?K0dPU3VEMHVJd2lyRDNISEdsbk8vVVVSaWZnbmE5S3FmM3JOc285TndTSHlS?=
 =?utf-8?B?M3JQRTR6S2xuK0VGR1B4ckFkOEJWUTU1WEpOSjNCa3IwRTdzRFdsMUlVOGxL?=
 =?utf-8?B?S3Z1NHQrWllNQXJOOTBNaHpQeHJRTVowQWtBTmY2T1BvN1NrUjVYV2huRURi?=
 =?utf-8?B?bVZia1B0TUpOSjR1RlUrM3E0RWxIWS94aDlCNjNYQXdIUHdnT2N6SFI3Ry9R?=
 =?utf-8?B?aWpQRVZEenk1cWhzR2N2R2RiaVVtbm9LUEw5VkZLV20wQXA5cXpwQWl3MjlF?=
 =?utf-8?B?OTR2Z3pDdjUzd3pudWFNeVRCbG9oYm02S3FjMlpJaXBvdTBRRXg3WmdvbVVM?=
 =?utf-8?B?VnFSUC9uNjV1R3JHck5WZVBoWEliMzFiM0VwSE5yTUFJb0F5a01SOGhZZ1c2?=
 =?utf-8?B?bmoxZWc5TFlXdUVGcG9seVBKWGR4N0taR1hUM2Zvb2pOckxvQ0R1Rkhodm1X?=
 =?utf-8?B?S2haU1cvendRUWw3UitYcExvTUpOeDlSamJ3b25EZUp3dEM2b20yNDl3cGV4?=
 =?utf-8?B?T2tkcE0xNTNqMlZlbWVTaGI1bmV1YmNBQTJJRE4yNWtjZ1pOMk1COHhMQUJu?=
 =?utf-8?B?dnZxRyszSzU3QjAvUFR2RmtEdFhJWUFoME43M2ZqYTJxWWJCVFk3WUc4ZnJW?=
 =?utf-8?B?RlhhV05ScDdYeFptNGNtL3B5MzJlMXM2eFJDOE0wQVNNeWF6NkxQWGhaZmY1?=
 =?utf-8?B?SDdPbHd6NE1MOEIvZWlFdTJ0dGtLZGFiUkwrQ0E3anJtOEFzTEM1NmlGSzUr?=
 =?utf-8?B?NTF2RUl3bDU4a2xlRTdLZUJHUU9TcTlrVHJaemxuZ2FxeWJiazRCTGdPWkhz?=
 =?utf-8?B?Vk1XanBDN0VvdEZZR1B5TllHdk43Q0FEVVNjWUJpQVdzYUpsb2JJMW42bG5N?=
 =?utf-8?B?TnBRaXNpL29RUTI1aDNuNUswb09aakZPdDJ1S2JUSXVqMHZTTjYxa3k4eGdF?=
 =?utf-8?B?c1d6MDVZQ3pqSDNOUndGQTU2aW5WbCt4S05ST3k3OGN6cGVCOWdCaWUrWTlQ?=
 =?utf-8?B?cnZEbVJoL3pXUlJ0WDROUlZoMjZ1cUdmTmRDaFUvM3VvMFh0UDQvZzdwZkYr?=
 =?utf-8?B?NUkzU3RRMFN6a0xnMlhYQkhSam5aajRFbnhHL0lOcTM0WHFUa0dpSTRkWUVJ?=
 =?utf-8?B?bTNENEVRUjJmV1drSzZqdis2MnpHa1p5Q1l6ZlU0TFo1K3YwSzZLKzdZYUJD?=
 =?utf-8?Q?EevfZVrQrg3G6v7lBFvkYfg0Ukn4cxSUfLX4RIE?=
X-OriginatorOrg: mec.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a97061a-705e-432f-2265-08d96bbd3d8d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7079.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 13:51:17.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f47e334-58db-4591-b50f-1937a70d1a07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TwKwsNTA9KMK1EeJy6Krp+wkIST2U+OjXLcEWAt9zCCTbiyjKrkN1KivZTtRWn6TAhIwJbvq1UL0PbjXu5Lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4024
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I'm currently working on the axp209 driver. The device has multiple 
warnings like: temperature too high or low, over-voltage, under-voltage 
etc. What is the recommended way to communicate such warnings to the 
user-space, besides dmesg, so programs can handle them? Or should I just 
create my own attribute for each warning and set it to a specific value 
from the kernel and let user-space applications reset them to 
acknowledge them? And if there is a recommended way can you name me a 
driver that is using it?

Thanks for your help!

