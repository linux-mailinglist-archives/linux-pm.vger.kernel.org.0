Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1A3FC2FA
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhHaGuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 02:50:03 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:14880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237960AbhHaGuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 02:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXhpkv+/86JfLMm+jmj/lmfVa1R3R2Gs4S7JPXnOViwfTfY6i5/nteEuVZ1TBvTJs0zyn+zeNt6utFq3M/pnjx6GCaOvDJRuhnrn1vgrZH9B9mY5mLSSajPTDx7btqmFFjQ+66DLdYDzNSfxlyhkz5muNK/gQf9PSNLSeULz9GB6GGes4hQwZAGtmqwD3hDhPOR9wzpW4NaKfjn6dF8FBma/85pTMuzHkqePo3cuTVfCe4//XQLXU14l2l1H0YKZ3mwi8iG1ZuFAFD6KsxhrvMBqWxxsvX7bWqfp6cJx8Rw4T3pImUV52Lkon8h2CdtoE68+nl07SVZhIT1FE2dJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3MNc3cmGdbtXGHLbupoQSVUbHWmpo+1kFihTZW1AM=;
 b=dWpPp29KP3IyKvjPHP14RygTaVRobzh6oeRHSmtvGqveC44xTW6noafrDYeA6xwCTniM4OyU6+qMqDgP7eMdi2YJKjiCUrX1JjdTRuDuNk+S5L9B57CiHtcBpx3y0N0g1Z4w8oC5JBGF09jNmbCvgC4SQ1GMxrqKUZxRKcv2UHSEqfXbuDIiZxz4G1zBwnbgB7ZdEYOFUtE5h4EYIpF535xVr+B0CaZyaHPKECF5vegbyT1fr2eQn2zOMXF92DpW84/UMm0fmNZDLpGnY1CpsiKSiLW6Y+oitgOs7qTM2wwYxcjdZjlgGQPkOeeA83gfDdZvPQd099XQPCfMUxtLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mec.at; dmarc=pass action=none header.from=mec.at; dkim=pass
 header.d=mec.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mecat.onmicrosoft.com;
 s=selector2-mecat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3MNc3cmGdbtXGHLbupoQSVUbHWmpo+1kFihTZW1AM=;
 b=VS1MODzkbyMwm0xUo366LjN7Dz4ZPKIf+BDsipumCIEOxhBtW1YA7rsvjbb1g4c9kv4wz7iFxUGWViXfQs3EFoznd0MG1dszBBz80ImMjdDfkMlD8XRmwDl5p0X4unxJKvEh+wKR9tjr6PNnnUjFJwT/nYmUIFjjZAzRXlDeW9s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=mec.at;
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com (2603:10a6:20b:291::8)
 by AM7PR03MB6514.eurprd03.prod.outlook.com (2603:10a6:20b:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 31 Aug
 2021 06:49:05 +0000
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::1c91:76ec:b39a:da43]) by AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::1c91:76ec:b39a:da43%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:49:05 +0000
Subject: Re: Communication between kernel and user-space
To:     linux-pm@vger.kernel.org
References: <93abc004-eed6-d78b-9311-a6626e7a0ff6@mec.at>
 <CAJZ5v0ijNPY+33yYPZR03ZEQbCXLog32aqjU0LMTPkcvDwvNYA@mail.gmail.com>
From:   Thomas Marangoni <thomas.marangoni@mec.at>
Message-ID: <1a26c976-81da-c29d-948f-fb879ecc1aaa@mec.at>
Date:   Tue, 31 Aug 2021 08:49:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAJZ5v0ijNPY+33yYPZR03ZEQbCXLog32aqjU0LMTPkcvDwvNYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To AS8PR03MB7079.eurprd03.prod.outlook.com
 (2603:10a6:20b:291::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.176] (213.185.161.83) by ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 06:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd10884f-7e32-4fce-430f-08d96c4b6cc9
X-MS-TrafficTypeDiagnostic: AM7PR03MB6514:
X-Microsoft-Antispam-PRVS: <AM7PR03MB651442E20324F32B38726D2EF6CC9@AM7PR03MB6514.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rW0TiN1tkoYPl7FnD6u2Ud61NFrT2TX2AXR4g1ujS1wxDEwKZ47nj3SGnMEOHvdaCabuG/fIsbeDtnbswUgKWJhoaJ4uIa7ea4Dkk7FuVWbjTkTKcM7egg+nfvAxlEjklzyYofCLSa6HETAE2rGPYjFALu75UgLx0TzYYdUKQqjrHvHidqEWjoBcSgjHnZ4Er1kWhc4dCQ2OhWEGCyjz2i+mbAj1+7ldnw/qM+1ZFTiJohaeMKer/k2ZjiFrPQn/96iCFDO7WvsZCQpaUnVSxy+heKDEWniuTtWqTfiIF2CMHm/DK8H2wsxPHOE69MsSFeGpDkFpXK7rNbZ9Rr9AyCLTfByb3j0IUVXRV4r6b4cwtgfaFn7u/5rsHrDmbSK+84qdTx904dH398ZhjxoH5qcDSy0Z0DAEu73Uj6sMWCL41GT1GiY2cUVotGTu7OR2r8u/ZRiLD3JWpc4qdzBDd6BWQ+L+TSzEr7/zkoD8jRwA+M1uriUUYIUcnp8goWL4D/+kzSeUCM2sX9ztvn0m78dAchBWvyrvVlF/s1UxcGItrkSUfkiE78pLtKwYh20NJPPvozMLfuALQwQO/NaDbmHaXrY08M2i4/vGp9Y87a2Ew6galyPuVSwuosnJEN213FdI6+eAUz1KSdKcNjr2juiy1sota+hTB7UKp/fcyBmiUjQjWsUz2+oEGxFcBBEdEXBIsahppZSXNS+fk4cAm4vGjO3A2HQ3ViFWftDMYSRjRDVNvKYGTOteEMeszONTN+LLpwNJF8dtLiM35lfezQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7079.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(136003)(376002)(396003)(8676002)(2616005)(83380400001)(44832011)(38350700002)(956004)(36756003)(66946007)(478600001)(66556008)(38100700002)(16576012)(31686004)(66476007)(316002)(86362001)(26005)(52116002)(31696002)(5660300002)(186003)(8936002)(6486002)(6916009)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZLUUdZbDlMK3R5RWZHZzZwTTBtY00yamk5WExPZGllUUNweklIV1FSTFVV?=
 =?utf-8?B?VFNYWEpnS0pmNmxXeWlwa28wc1lyTTBXd3FwVmhBMjd0VUl4cXBEaDZDM1dL?=
 =?utf-8?B?eEhZK3IzU25vcHNoaUwySmVrMEZsNElxeHBlVFNzZ1pHOEJsVzNqMGJhVm9i?=
 =?utf-8?B?SzBpMWllYk9wMlVRZGFhYjNnZ0dGZDNJTDJ5am9jc3Z2Z3N1am9NTmxqUStQ?=
 =?utf-8?B?UndJL214RE9EQ1RkRGRYSHpTMm5ORi9rL052cFlJeFRwYXFzN292SmtxMVVL?=
 =?utf-8?B?Q2dIOUJkcG0xQkJlREtCN1RIaTJ1U2tOdm53TzVoTmV1cVFSazcxejAyWjc3?=
 =?utf-8?B?a1luaUpabXhqM1JodC9PVVJ1R2drOThvZCs5M3htNld1NnUwU3N3N1IxSEhY?=
 =?utf-8?B?T2xPa2FCd0hXeC9VOFA0elpVL3Mwbnp5NHlLdjdLNVRrcThmWUJ4S0lydmJt?=
 =?utf-8?B?STVkVUNRSVRzZVRvQ084dENmZVdSV2pNZXhoekdzS3I4a0JkNEpFYXM0aVZ3?=
 =?utf-8?B?cVJxOWpmOXlhRTZkOEtyTzh5QnVUa0xYZEFneVJzblRyMlFFZUljd0orZGZ4?=
 =?utf-8?B?bXJFOEljbkdsWGw2UkY3L1J1bUdIUDZxZ28rcTEzd0tGNk5zYTYvM20yTFli?=
 =?utf-8?B?NDJweWgvLzY2OS9PVzhBVVgyWkhvcW9zTklUNkI4N1RLeDJqUWUzcWpkd2p0?=
 =?utf-8?B?ait6S0dTbnUwNWN0YTN0QTdNUEhTUDhwRVVjV0RwUTFIK25RWDEzdmxqdkdw?=
 =?utf-8?B?TmlWSHRhWGxwdDNSczd4UWhDdlJvb0NRWDc2U3NjckVnbC9rc0djbWNmZTMx?=
 =?utf-8?B?N251cHdzVmdnSFZaRzRiZlR2YUZLcHZuOGd3ZysySkR6MTNjdEc5YmpOY2J3?=
 =?utf-8?B?c0xDUHdGSGRYM0VhUjFpTEV6STBjYW4wbFd2aHdoeTgxVVB3TUFZYkdLMmFt?=
 =?utf-8?B?U0lHZmZrYlBMNVRXUmFZanJzcmJySnNUMFlQdDFPa0l4NWFZbk9pR2QrM0hX?=
 =?utf-8?B?UnNHTyt0TFBjSzdNekNEOElraXlySzFBWUNWaGw1bk9rZy9rUnprSENFNzVw?=
 =?utf-8?B?U0JDTUtsNi85LzlMelpMOEp1WGlIN0twRndtV1FTNUpmc3R2WGtNWjZoOUFL?=
 =?utf-8?B?akIvWUVkK0w1bTRxc0hEUGljUk4wQ0hXOUhtZDRwY3U1bFVJSVFIOURNZmlx?=
 =?utf-8?B?Qi9zOE1QWFdubXlUbklWZHYxVjBKL0t2VUh5dHhYZTMyVDFoMEVodjJwcW9u?=
 =?utf-8?B?QlNLSlFtSjZBUGY3bzFiRUo0ZkxZS2k4bzNaSXBHSTZsNXdsYXk4TzM3SDdx?=
 =?utf-8?B?S09RSmVocWhrMDFheFJRRHR6U3JVYVROcWVUY0VmTCsyekUvZFNLUE9ubjh3?=
 =?utf-8?B?UkhCMU4zWWR3ZytqckJhTXNoNVQzdWxqbVVPNWdsa0R4KzV0dmVZWWdSK08x?=
 =?utf-8?B?L1o4bTIrZmw1dEhsdVdxVkwyaWlVaENGTjBSSitVQXVSRHBxb0kyU2ZJY3Yx?=
 =?utf-8?B?SFlKV0dJWlMyZHhWWU9RMDZrZVhna2FRMDRyb3VmbW5PaXNKSEJFRGdOaUJn?=
 =?utf-8?B?Q052V2E2TVRCSE1yaU9sV1Qwdk01dUd5N2ErdllacFNTNWFDWmlvOCtCQVFt?=
 =?utf-8?B?dWlxeHhFU0hnNTJsZmdRNUNSa2xPNHUwYUs3ZWZHdm1qU3FMYVprOWNteXZ1?=
 =?utf-8?B?OHUyY0xkY3ZKaGE3ZUNSSzVSVml0dngydlJQOGRUYnpZYzZjZStRT2h6RlhX?=
 =?utf-8?Q?ELXzy06l1zwqwQODwooww/iOqTmJ+6rHCltC16X?=
X-OriginatorOrg: mec.at
X-MS-Exchange-CrossTenant-Network-Message-Id: cd10884f-7e32-4fce-430f-08d96c4b6cc9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7079.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 06:49:05.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f47e334-58db-4591-b50f-1937a70d1a07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lThvZPxDkdN9rCK2Rvpv+J5C6bbkJEwh9fPZ9+3P8GSfa5IOzaQnLBz+cCPZqrexvGs5ocR9+klOvLlW3Q/SfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6514
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> What kind of devices is it going to handle, specifically?

The AXP209 is a power management chip for e.g. Allwinner A20 (ARM 
architecture), I want to focus on the axp20x-battery driver.

>> The device has multiple
>> warnings like: temperature too high or low,
> You should be able to use the existing thermal framework for this.
>
>> over-voltage, under-voltage
> But there's no generic way to communicate those AFAICS.
>
> The question here is what user space is going to do about them, though.

Events I like to communicate to the user-space:

- Battery Temperature to high (as already mentioned, possible with 
thermal framework)
- Battery Temperature to low (as already mentioned, possible with 
thermal framework)
- AXP209Internal over-temperature (should also be possible with thermal 
framework)
- Low Voltage Level 2 (shuts down the device)

- Low Voltage Level 1
- Over Voltage
- Under Voltage
- Chargingcurrent shortage

In my case the application would prepare for a shutdown if the low 
voltage warning level 1 event is received. For the other events the user 
would get a warning with instruction how to handle them from the 
application.

>> etc. What is the recommended way to communicate such warnings to the
>> user-space, besides dmesg, so programs can handle them? Or should I just
>> create my own attribute for each warning and set it to a specific value
>> from the kernel and let user-space applications reset them to
>> acknowledge them? And if there is a recommended way can you name me a
>> driver that is using it?
>>
>> Thanks for your help!
