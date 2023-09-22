Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5C7AB057
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjIVLPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjIVLPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 07:15:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D1AC
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 04:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgnRvoEZX42VqjshyYepm7B12WFY9X8P6rZHd5thprGrteVvHGodKM89eNDRC5m5p2MaZafR2GD1FxBk22caTd1HU67KzmAmR+fgYI/NRNxScZn/SXqjvnKgs3RcoFvzIfQYGz3PpEA8XOrAa1rOCXWn5csA4p7jSZXOiU6OEjFkF+Y5Ht1SX/S3eY5ImBu58pShnDvXp14F9K6RvxiPOd4UQxALoyQ+fxcNZdWFHphpmSiKEcGkeeSOgrAq/0+MK3ODr+MpuxECi2SHLlWDvM4dgjartQQtRLGlMWHh82Bjwm96v4DfO0eV9+nUYnYnfZmUIIrEXDtEVgo7iASviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3cJKR9z8Gd63OIsUV2CRINBIR6e3JQQ2n57AxmXKMM=;
 b=Xi78lWrBpbN/kCNtAjBU33kdLfoGgyx27Dxlke7E5xnTG0xVFnBG/ZHFgJmqKDjYkgbBiEuLoYHs91pxtxSLmTaN3e6RgwGsVZSKytjZFtOQbOZMrNYKYtl6x6syhyHHJJkDWrM5odmtlnxkYleOV93qJLybHeLQZrRcbCppIQQQ1pA4sl+gQ7ycfInnXsvYN1xQOYhcf0EAbY2OLHMXnKL6apUi3ZYAVMVb1G5DaVaQCilLgp8/zbQ624ayP4apDk35GJkNEhjwH1SdT2dkN/HbB6IdVxKhxsQTCZwhc55Z+Jf6qnSFs8eMK5PsOZjWcLSZEfCRw/9zPQ9g70sZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3cJKR9z8Gd63OIsUV2CRINBIR6e3JQQ2n57AxmXKMM=;
 b=sTAFIuK4GmO7qANwpXd95cMXHCxYDnWA3yHmPlknK6sLBaFSalgA7JLzOB29VgXwCaYvjZpeIMEcbvu6tEmraJ8txqhJsiC888hIItAPw3U0Kj07C7zH+36g48FqXUhk4F2R9ZAVlJ4Imln0YpSoe7L//5U449Nm6FFVGPHXIauzg88RL+T7K8RUq8HILfr0kv+8eG0/oIJpCu7JcEC/iZYcV3c1KtTJFJ5oJW//2RXp4sThTSJMwxF6ZOFTLhPg7K8e4eLF/2GHPQW8ACrXszrmFRZ5u9e55kOEYwLRaFZe8gFx423BUJyp+5l8S1J8Efm1tvFUR0wMmI5LY8Gjqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 11:15:24 +0000
Received: from AS8PR04MB8835.eurprd04.prod.outlook.com
 ([fe80::25df:77c1:a4b:d21]) by AS8PR04MB8835.eurprd04.prod.outlook.com
 ([fe80::25df:77c1:a4b:d21%4]) with mapi id 15.20.6813.018; Fri, 22 Sep 2023
 11:15:24 +0000
Message-ID: <eaf4ab5f-2ce1-4e87-a31c-f2b5ebd15c19@suse.com>
Date:   Fri, 22 Sep 2023 13:15:21 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [RFC] docs: thermal/drivers/intel: Reading trip point previously set
 to 0
To:     linux-pm@vger.kernel.org, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::16) To AS8PR04MB8835.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8835:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: cb47a10f-bd20-4149-1a39-08dbbb5d3785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m68BBauj6FMdGzeNqnocbtbMt/Og9L+UPZZlOpQ9Z38jzOCCiN43O6ZUGGHCUg4JnCFHlY35FMFHCu7pbia8KPNQDC6qxIaTInoM4DXayVFNpgAoO1HiOcIxZrBdaebSb8Q1Sw29ExH7eos+NrpJnFSHwouaCSm9vwDLldwAVrnJoEBebvqcJNWSzOO2VtormYYD10ispahnhZ+aNNXciJOyCfNNnLLYBdihYam5yltC7IOxEmnHTBy0Jb2NwHwR+Z5WQ3D+6fVKa1uUHnhKFw/CJ6RL570AXDsW9ajXoJAbhYt3PVYb7QA1SOdaaSoZ+WvLMiGfwCmpNRiQLvVIjGAmeh8rUQVUTMVlbkBEOhsGMSkisWYQuo1OOJxU38FO+9nRBPR52rKcVvSuu6U0pWj4ZdvggyYCEshLBHIHCvPQMz2Sdj+g8qHirqhD741e9du9u2I4gpzuDwZLEcT8p8TF2rbhD9hq9pyoUk6CGjZEGDafnzWDFQMtEawOPNbo1PEpBH9l9yuWj/BO4wUoPKJLxX+F/qS9YXmEqQiV/0E2oDEmi4FON4hze/JI87VFIfCziwTUDvikH/S1zZypKjkxBEZgJxjYnI/216Ml1RmjHW6Ha9Fl/eca0A5Tkcu53fL9kWcEhmwIIxb24jBvTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(1800799009)(451199024)(186009)(26005)(83380400001)(8676002)(2616005)(5660300002)(8936002)(6512007)(6506007)(6486002)(6666004)(31686004)(41300700001)(478600001)(66946007)(66476007)(66556008)(31696002)(36756003)(2906002)(38100700002)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJ5ZkhlN1RSS0FCL2lFTHVYaEg0Z3NXKzd1bW9BYUZOSTFoQURCbFdDU3hz?=
 =?utf-8?B?Mmd1R0lmeXpnYXJZNVlyVkw0MU41TmtKV0tqVitQTHhrdzlkVWZxV0R4YmxJ?=
 =?utf-8?B?NlU0aEJDTVhYY1NXUWErUFhUNlQ3elgyellwbnRmUDhZdU40anltdVMwU2lB?=
 =?utf-8?B?TTA1dEMrYkJvLzZxRWtNb2h2RmRlZWtDRVhTZEdQRWhTMDM0L2NycmFUUjFS?=
 =?utf-8?B?UDRlejc3UEV3Yjh0N2U0b3U4VTdVSnVFbzI0Sm1KWGRSS0xoQ1lWRnVzZ29x?=
 =?utf-8?B?eEZCUWE4bzNhdXl0VU8zMVFjU0M5Q1QvZ3E3TW1BSjF2RjdFNXFLUmQvTWZU?=
 =?utf-8?B?SlZpS2NIYkYrclF0cFJOYnoyRHFvSW5TSlo5aWpzWW5LbkdCdXRhMThsVmhn?=
 =?utf-8?B?VUFxMk9MQVZUS1lMemluUm1NQmZORitLQi9JYjBZQ29KWlQrdVA2VGpQay9D?=
 =?utf-8?B?bGFxa005Sk45YWNIUUpXb2FXTHN1OFlTbnU5L083TUdLVFdKVjJDTkdkYk5W?=
 =?utf-8?B?bG5zOEUrNkF0VGo5QjFjeHV0eklGNmJLM0hwNjlPZ2ROb0ZPU0M5dVZNN2JT?=
 =?utf-8?B?dE9WV1EwQmw0bUlZS3lDQ09pVGRXUTQ3cE1Sc0hTeTNqb3QzVVdrSTd1MThJ?=
 =?utf-8?B?Z2ZJTWlkMkRabDhXQmZBVUxWZ0VRSmg0QlZ5a3BQK3drbTJBcTcyTTlyS2Jx?=
 =?utf-8?B?OUZ5SGVFdWZjL3BpaTlwNGJIMjdFYUNoWUIvRFRTc25wWDcwcGVjVkRSZkwz?=
 =?utf-8?B?ZEQrQmFRR002L1dybi9nUXY2R2Z5L2xYOW15N1ZrRTFXb2xwbjN0N0E0c0Fn?=
 =?utf-8?B?bnBqWWtEOU50ZW85T0tPVXh6SWlIT1BLN1VXcy9uZThTNHkvVGtYb0F1UG1Z?=
 =?utf-8?B?bkJSakc2SzFBNTFQbVFIc25XSG85dFZhSC9aM0xaOE5zeGs0Rk9adUFCSmhL?=
 =?utf-8?B?K3F1RlJQcnBKQWk2KzVPdSsyenpBaXBZRmM3ZFVCeWxmaTVIMjI5cjNxdHQ0?=
 =?utf-8?B?by9jWDNJQzc1THJoZ0JEQzU1ZVd5Q0g4emJjdnRHVE1WR0xxVm56WGg4SDlL?=
 =?utf-8?B?Y3BNa2FhZFJnWTNTM2w0SkR4bjdnUHpOaHdTWVI4a1Q0TDRoQjVmMmZ5Y0RW?=
 =?utf-8?B?RHdZd3BCNHcrYXpvNXpkMlg1UjdtQ3pOREZPaFFYRGY0TjFnWWw2ejE3SFho?=
 =?utf-8?B?bmo2cnZpaFM4Z28wZnBrdmlrZTRmMG9ZOWJpUWtxTTRzOU1oaTlJQ3RSU08w?=
 =?utf-8?B?L2RpL1dkaUZLUzZCdkJsOWNvSEozZlYyRmhsdjV5cWZ5ZklTVjVxbVdwRUJ1?=
 =?utf-8?B?azNETVlWdHFiSDBoejNjcHRvcFc2NkdNYUo0ZnVYYnA2cjR0RTN1MHdxVEZT?=
 =?utf-8?B?RnQ5RVlacy92YW12cTF4NkR3SGljZmQ5dmh6Q00yN0JLa0NDM09KeUhJZERY?=
 =?utf-8?B?K21pcXRWWGc0eU1uL2xyS3NTQ2d1VS9XMnh6OGxjSGZjblFrL0lhc0wrZkRE?=
 =?utf-8?B?a1FPTEg3bW9GcnpPNFBsWEJXMVlsT3Fsc0pzZUhzUzBEVWY1MEVDcXh5RzVQ?=
 =?utf-8?B?ejl6VXRjLy8yTGVwZWMya1F6MlA2VDNiMFRIVHJhN3dwZVZoaWhEV3FJZllC?=
 =?utf-8?B?THJZSW4zcmxxM0JNdXJObmNuc1dxRFdZYVhHeUtlRzB5dVdsREdlNng0MXJM?=
 =?utf-8?B?SmcyWWM2S0s1aGE2VTQxRzZEei9aYzNLdTQyUm1uTFpHNnNncmxmUWg3Rkwv?=
 =?utf-8?B?UXIyNGI0Ky9HR000akRzQjhDUzZOdUszUG9wYS8vbnRaSDAvcG5UMnNyZWFF?=
 =?utf-8?B?SUVaUnJRK2w3UWNvQUYyVWJXdGRYeVBqOTdIN0RMQjE1bHNrdnE1WkFNbnZw?=
 =?utf-8?B?cS96SUZQZmdQMFN6dDBNSGZTOHVNM0lBWjRYenRLQ2d5R3NMV0Q2V2h3a0U4?=
 =?utf-8?B?cWZHVHhrNGo3L0F5d1V0OFpEMUFueG9hbVBtZVByVVhHcGNDa1RiR3JZenJz?=
 =?utf-8?B?Tmd5UStHUU5oZC9CYnBsTTR1S3cyallVSmhOOE96R0sxUVpES1piZWJZZkxm?=
 =?utf-8?B?NWNBMEpvREJaek0vSXhFN3ZCWVBCQ21WN2IzWWlnbHpVZ2dTZllZanZDYTR2?=
 =?utf-8?Q?ecjwoknGoiVXT/10zXkBSGDG0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb47a10f-bd20-4149-1a39-08dbbb5d3785
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8835.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:15:24.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDpu2VXZqjIzfxdDyfb25CT2ftiFd7D8BTUT5+hPMK+So7OlRObzWG4FNT4T60IWuK75KHSLy1/aGyXcuZPKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Since commit:
eb8500b8 "thermal/drivers/intel: Initialize RW trip to THERMAL_TEMP_INVALID"

writing 0 into thermal trip point temp sysfs files cannot be read back:
~ # echo 0  > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
~ # cat /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp 

-274000

Prior to this change, the value 0 could be "read". Afaict only because 0 
was always returned for uninitialized trip points, and not only when 0 
was actually written into the trip_point_*_temp by userspace.

A customer uses scripts to set the trip_point_*_temp value to 0, and 
then checks that the value is indeed 0. Their userspace test suite 
breaks because of this change.

Should userspace still be able to read the set value of 0 (meaning the 
thermal subsystem confirms no notifications will be sent)? I understand 
this is a corner case (maybe it's even non-sensical to check a value of 
0 is returned, after setting it), but I wanted to ask since the sysfs 
value read by userspace is now THERMAL_TEMP_INVALID.

Or should we instead update documentation to reflect the fact that 
uninitialized trip points and trip points set to 0 return an invalid 
value THERMAL_TEMP_INVALID? E.g.:


diff --git 
a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst 
b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
index 2ac42ccd236f6..2e6f2728b5b94 100644
--- a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
+++ b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
@@ -43,8 +43,10 @@ User can set any temperature between 0 to TJ-Max 
temperature. Temperature units
  are in milli-degree Celsius. Refer to 
"Documentation/driver-api/thermal/sysfs-api.rst" for
  thermal sys-fs details.

+An uninitialized trip_point_*_temp returns an invalid value 
(THERMAL_TEMP_INVALID).
  Any value other than 0 in these trip points, can trigger thermal 
notifications.
-Setting 0, stops sending thermal notifications.
+Setting 0, stops sending thermal notifications. Having set 0, the value 
returned by the
+trip point remains invalid (THERMAL_TEMP_INVALID).

  Thermal notifications:
  To get kobject-uevent notifications, set the thermal zone

