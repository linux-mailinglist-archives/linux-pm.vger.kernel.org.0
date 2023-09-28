Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5427B24C2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjI1SGF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1SGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 14:06:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6666DD
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 11:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBwh06pPIFvW2d+a4hIHO2NHHSc5yfpdYxYDnRKB+w3FDATIrUjmZfHnxFxLeIEynMaMc71RFvZzxDvHfkS2TfPusfMntl2FxBwDZ3I0B3wuppk7yZxSQz6ZZwHTXtg6Pp0uuR/9MyVYtiF1isR6KaF4tlREFNBrccHsCK57ZILoOuxgjlZbZc+/czXTDR3hXQELw0uP5pavrnMMFW8uAt68Ur2a/rx1h+mfzDtYOgTBpBl006oHqgffY6D90FHAj5WpNhPjBPM3PhjWgySJIkk2+c+DmXgqXs8m0RYUcDermV+1efWaQMtdf0JCombxSG2JFRuqYV3j/bjXvzlFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdQDDkq13ZJbN9F6WiPyLxr4HwwdwsiPSrGpF9AYIu8=;
 b=N5Qs7DEh+RqDtdgo8WHPAp/vlWZ9rVeYXMFY/OnBdM+x4ybXLA93cOrIQigD9Nw0BrZwtB5o84KCxYuv+egUD1SO2r2xAsARLly5oHmfglHWx9qrt+/pNOd48AuDV6BzwOdf6YhkZlmxV1w/4adqYtxtGd+0al+fq7EO6JOjhhmqESX9UCOMgJoB7hkfRr46NiIMuHeWCME0JI5KI4bxwEed/kBcpDLJONEE51FGAoB8Grn4QjoVfTxU77Z5NK4QgHyC78ToKm5do5MZUP2KWjaDfAe5V29jrxt7nMgScUTl1Nu8k8OwzgqQSWuA6sw261m6e42isc41px7ltIogEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdQDDkq13ZJbN9F6WiPyLxr4HwwdwsiPSrGpF9AYIu8=;
 b=h0j8CtB9rdVeKztenIDCPjXbPAOLgalOVviAiBWXeLsSHnsi3NYiY9c2CxETCpuTCelG5Y0JPtkbvykwHbh3gLok3gJCJjqYWzfeVRwSxc+8fRKyVsK1IXZTaTCZPdmEqFotvzHgU/uqSJV90XWsafBG1koPZpTr/XXYIYf/uvgo/Shd3kerXpuOv5I7zlVwFoA+HSDnnQ+0L3x5CxruCZLcK61mkmI4Yu2HVy1Eo1hNnIB2LJTQNL/e8xeAPrcee62Txtw+nHuO4Mm/jTzDB99svZlP5N+jnP+mPfhygI8T4PvQ/4GtnoqEEdt8fcdMarmIHsDpTyK4R+jpQRUNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 18:05:56 +0000
Received: from AS8PR04MB8835.eurprd04.prod.outlook.com
 ([fe80::9563:3568:1037:d6f1]) by AS8PR04MB8835.eurprd04.prod.outlook.com
 ([fe80::9563:3568:1037:d6f1%6]) with mapi id 15.20.6813.034; Thu, 28 Sep 2023
 18:05:56 +0000
Message-ID: <d9b13ed7-e173-43f7-73c0-840014a6c4d4@suse.com>
Date:   Thu, 28 Sep 2023 20:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC] docs: thermal/drivers/intel: Reading trip point previously
 set to 0
Content-Language: en-US
From:   Vasilis LIaskovitis <vliaskovitis@suse.com>
To:     linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
References: <eaf4ab5f-2ce1-4e87-a31c-f2b5ebd15c19@suse.com>
In-Reply-To: <eaf4ab5f-2ce1-4e87-a31c-f2b5ebd15c19@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::13) To AS8PR04MB8835.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8835:EE_|PAXPR04MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: f14bba75-771d-4197-f1a0-08dbc04d8fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3eg2imjySxYmNPtiONcWMpX2SQFXNIaAaHqYZybjmXxQFZdaNMLUSctWVb3sy0I3uWC+3EnlHRT3PeGUG/ewPcdogpLqz9bTGG+wLs66tpgxu3gg0L3TxlNJ+lyLqxKuv2Sjo5Rx0sztS4DeTSyI28thO+t5EaQTSnmnRefhi/OVWZ4qYIdsw6pf9lgfl5Zw7qOfdv8/uTJu1AgrSevSpvPPZpB3zAd6vtsfJ4gXxczNTsXcdQzsVS42lYCWq19Nm+1vKkJu1XVBmdqGNLHEEvw+ed5cX834BhDtqt7DqWe0hirP/E0uCwUFr9rtD4K94V3uhIR0gniNCLjlU4eNbuS6JU0WSfKgpLRs0SPa4bf+eC7kEC0uDO0VwD1kAQT5HwiKA52iDfeY682da4D7KFFVdB8orErETNQyr5gpNpVLtriDMKiymdA9VmXAkwU7LkAdO2T6NHfAfV7vzng/vKI1YLMhIcZMWtwfZeTCp9zdjJmKQjIKU1e3aEC+kROb5yQwGQXNz8IVPPT6gE3ABAPyWnsDkMbosE2fmpA1avsJIKfxjcSc5P4ai0D3RgeA2515foHwzg9gnDxVeXhIcqVGGefDr7Ahcz98qEFn9i1az2NcD5rJTqxWPU0j/a9IHLFL2yN0CnTGQ+HQLqpbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(66476007)(2906002)(316002)(5660300002)(83380400001)(66556008)(41300700001)(6506007)(36756003)(8676002)(8936002)(66946007)(2616005)(6486002)(86362001)(31696002)(6512007)(26005)(38100700002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pFT3N4dkN2MW1XbDQ4bmRsMkdvUDB0V3k1bDJ2KzJyWWZGYVpGcXQ4TC96?=
 =?utf-8?B?TS9MNUN2MGw0VEFMTTVRek9WNVZQZHFlL3ZxdkhmeGk5MlZHZGhFN2FMZGpm?=
 =?utf-8?B?SkxyZ3V4WDl4SjFMSmJ4TEtQd1lrcjNUeFZJSVZTdFNsRllLbFNabkZBcCsw?=
 =?utf-8?B?SnlRWFZHL21TVk9ETGFqQUhJTXRlS012QzZkR2ZGNm9uZFRpN1B0MnFVMk1U?=
 =?utf-8?B?YlAzU1NTMjl1ZGpPZUEvSFNkMUEyd1I5dmJsbzF3bXN4N2g3aExNVmxFS1g1?=
 =?utf-8?B?eU1aRm53bllmdGN3VkRFY09IeHlKMmVXekg4ZXdQZ1Q0TnpKL2VjbnB4YXVy?=
 =?utf-8?B?RGdxNUYyNXAyTmZmUmRlTzM2UFVFRmVZcjVzMVJvZzdCL2ZmdUxlVG90eTE0?=
 =?utf-8?B?UVRzK3o4anhHZ0V3U25uY0VNbEJUOUh0MFBsUXBEUFF3eHhxOWhNR3hHSHpD?=
 =?utf-8?B?ZFlQM25OWnlYbzdBTlltcFJJVjRnMTA2UFF3THo3RFQrM0ZDY3lrcy9nMUVJ?=
 =?utf-8?B?TW43WHFiSE13VFFiQnloVklQSkMxdU94VEdJazJKR2xBNS9lKzBhMzUxTlhL?=
 =?utf-8?B?SENxbC9qWTFVY2pDL3hPZDdyS0V2WnFIdUxaeDFZWExnSWpVMVhMQ1FEY1J4?=
 =?utf-8?B?eUgycVFDOUdFQVArQnEyUHc3MUxDbFU4UVBaNWhaY09EaW1ZMVk4Znh5QlF2?=
 =?utf-8?B?cGpBamg3eU11eGxNMFlWQVByS1AxYVAydXdTTzhyL2ZCQ3FjQUlLSmdMRVlx?=
 =?utf-8?B?eXJSVm56ZmdCRXd6TWNGQnVNdFlSUHJ6UmV0SE13MzVRbzFZb0NRcExYY29j?=
 =?utf-8?B?WStsOVUrZWp4b0hnMlBhWnAxUDFOaml6cHNKcjFSRE5vRVhySGloVzErK2tH?=
 =?utf-8?B?Z3dHeTN5R0E0OWFCVC95OXBUYkdaeTVPNDdCaTh5OUFYcmxTbG5hU0pldDYw?=
 =?utf-8?B?b2NPNmJrVkt0SEF6TEVxVVJiK2RhZ2FXcXlvOXJOd0x2WEJWVUsvSzUzR1NQ?=
 =?utf-8?B?MWk5a2FJNnlyT2c3bDZrckN0U25hME5GdFhSK0FRRzRnL2FvUWFKeXZQZU9z?=
 =?utf-8?B?UDloMy9udzdpLzJmV1pmZjFZNnBvSEpBL0pOamR6dkVwMWhOVWgxZFgzZWVY?=
 =?utf-8?B?YnVKMGEzOGFFOUNkK2dDcUovOXF6dE1HV1FwcW4yb1Nna2FVV1IrK3dpdk00?=
 =?utf-8?B?bGU2UFVjUnUvQytWT0Jmb0lObDVGQTM4TVhMd3JSQVkxY0hFL2xKM2dBR1ND?=
 =?utf-8?B?L2t2N3ZYYW1QcU1nSmNLczArYzJnYVpDWWs1clRYcTRYbUhPTG9HU3VQQUY0?=
 =?utf-8?B?dEFXcGpUb2xuam0rcUtkNEV3alB3SVdSN0ZmVnFxZ2hFYS9sblRTTzNNZFVT?=
 =?utf-8?B?NjNQYzM3UzlVZzRQSHcxMEEyOUpZWW1XQkFMaG53OVpSOXM3ekl3RjMvczlK?=
 =?utf-8?B?VWFLeElGR0hNM3Q3QnhtbXI4Tk5oRzhTTkFJcFIwVlliUDNxdnNSSkNrNTl1?=
 =?utf-8?B?NjBLeWlFbkNSNDdTK0lzV3FJTER5NzhVaXNnZXJyOFUvOUxjZllWdVg4S0Rl?=
 =?utf-8?B?RFFYckdDY1BzRGFqbXkwcGZwc3E4QkhtKzg1Z0tGUHRwTTV1WjBzTWdpVm9S?=
 =?utf-8?B?aEZ0eGQzZm10SzZHQVU2U2NZZUVsWC8vN2FwWkl1YU1xdTJEekpId2huOTY3?=
 =?utf-8?B?NGNrMTNNRnUvanJjSnNFczlXT2ppeTlXMVVpOEcvb2k0U3g4UEh6WHdoNWNM?=
 =?utf-8?B?ajZtT1VESHFHTU81dGR1OFViWUdCUmFMT0NtckNUYnBxbjY5UzA4N0RFWXFu?=
 =?utf-8?B?dlJMMWs0ZWZPelgxcWFLbGd1OExaNU1EeGV0RWE0a2JURGh2VEhnVU9Tb2FQ?=
 =?utf-8?B?TnpFdTlqaFNsWWhIUWIydEtRWkFld3NRTjlFVmxDYjRSaGw4a0Z1ZW1IQ2dT?=
 =?utf-8?B?QnNpUTNjK2hSMjJMNTcyNFVHY3JPc01FU25WY09xRmE0OFJscXRJQTFWUjR1?=
 =?utf-8?B?alU1c2ZnbTQ4MEkzU0h3UHVOWlE2MVpHY1FibFhYTjdKZTFhMDk4alRubE1C?=
 =?utf-8?B?a3N3Z2dmaHZWTHh2NkRMODQ4Q3NNUzZnY3I0Q2R2aTBrNHNSc1o4eU1pemMz?=
 =?utf-8?Q?dF5zhQFb4C2B4H2pyk5VpU87U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14bba75-771d-4197-f1a0-08dbc04d8fa2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8835.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:05:55.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80SRylNwBRQJDwVRCPnGbJMUhkAz0X0gKpcjUYpJ/3ng6UsiZw8LZud49VbXoQZwAMPbHsHi+yUeeYHf0HuXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

ping, any thoughts on this?

> Since commit:
> eb8500b8 "thermal/drivers/intel: Initialize RW trip to 
> THERMAL_TEMP_INVALID"
>
> writing 0 into thermal trip point temp sysfs files cannot be read back:
> ~ # echo 0  > 
> /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
> ~ # cat /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
> -274000
>
> Prior to this change, the value 0 could be "read". Afaict only because 
> 0 was always returned for uninitialized trip points, and not only when 
> 0 was actually written into the trip_point_*_temp by userspace.
>
> A customer uses scripts to set the trip_point_*_temp value to 0, and 
> then checks that the value is indeed 0. Their userspace test suite 
> breaks because of this change.
>
> Should userspace still be able to read the set value of 0 (meaning the 
> thermal subsystem confirms no notifications will be sent)? I 
> understand this is a corner case (maybe it's even non-sensical to 
> check a value of 0 is returned, after setting it), but I wanted to ask 
> since the sysfs value read by userspace is now THERMAL_TEMP_INVALID.
>
> Or should we instead update documentation to reflect the fact that 
> uninitialized trip points and trip points set to 0 return an invalid 
> value THERMAL_TEMP_INVALID? E.g.:
>
>
> diff --git 
> a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst 
> b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
> index 2ac42ccd236f6..2e6f2728b5b94 100644
> --- a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
> +++ b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
> @@ -43,8 +43,10 @@ User can set any temperature between 0 to TJ-Max 
> temperature. Temperature units
>  are in milli-degree Celsius. Refer to 
> "Documentation/driver-api/thermal/sysfs-api.rst" for
>  thermal sys-fs details.
>
> +An uninitialized trip_point_*_temp returns an invalid value 
> (THERMAL_TEMP_INVALID).
>  Any value other than 0 in these trip points, can trigger thermal 
> notifications.
> -Setting 0, stops sending thermal notifications.
> +Setting 0, stops sending thermal notifications. Having set 0, the 
> value returned by the
> +trip point remains invalid (THERMAL_TEMP_INVALID).
>
>  Thermal notifications:
>  To get kobject-uevent notifications, set the thermal zone
>
