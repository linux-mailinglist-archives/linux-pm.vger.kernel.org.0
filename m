Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7167B094
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjAYLGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 06:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjAYLGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 06:06:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29641B77;
        Wed, 25 Jan 2023 03:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqfYBNSWqxguWLHYYP7UzUHsOgKOtWVKV8YgoGUQtuta8podva5RgPGTm2hZRVlY8ZizhFecW3EXxWILWcDd81Al6bipdOf270YEkQfJ8d4ggNmgch8OsOLywSlsPSIcC2NWT6h+B+tys0okfjrrXvzV72Xl8st6wPgRLOHKP3QGmRIkqZelu5SE4nsbjFHFbCsj8DQO2sQ6WbpcBHaUHTsULCv9Y2mA8dqgaTjkZTHCR1n5+GZJdGzJXVH8hoVEt7GiIw6I2IRoxu4l7VjtNMcaKqu9AmbJ56Gqkz5NjpbW8kunA/9IZlNmG/ZsATD18Ot3oaJRm4dmwnK8dPGngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luvcAiAp+GTlYoLUpU13FlQPXuIYkA7UB+ypNzTWFag=;
 b=M0L6JXnVV1EjX7UFBuvYCSaV807lrsJ+pFBPAuPkbbpLxiJ8gNdMsvYgRsGKYjx2ocv0TZopC0vQbmQZFjSSjXjzXbYdvxI32wvQybICeFHMDd53B5EPOFHhuYEOcvTqAmeNfHH2FX4aJi2AyOWmfqtMUDSskUDpquOYb2IXHB7ZcUWqdl0413njm7QfZCraQeQthOqQVB5QQl1ELRH2xy0tVOHG7AH+DXEweICrjiszVO6wW+/iPGsWZEa/fd+G/vlCRCzSwJX1or5QxM5v9agEnprOLOiS87ex1ZpH78EA6FZFMCQ8bY4F9+nNAKmZqe7M3nwA8sjGZHbjJMPLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luvcAiAp+GTlYoLUpU13FlQPXuIYkA7UB+ypNzTWFag=;
 b=IupB9i7WUjMfdplTzynP1Yuyb/a4DggB1afLjsIkSGjYBC63ohZtUNyYXfS+armP2CFebV8fAp+PDerG12SYawPGk8Gg+hXS5Ol+CIkax9UaxfB/c/mclqzpIHuxSLChz+LdhFJGiV0OTal+Pmo/h16DbaeCOIEYWF1mDzYdNeHTFY9FQnjZo0mOElcJ1ChDcjMPvH5KtynFPW6fQnmp+coCQq9vHM7TzkSJulu1eEZCj08mscv7a+nB9E47e6nTUD9URidSZZQfRNq8LE4hYVfjxErWXb4AsXN5zmA0i2IOCqUy/l2Bwm0VEM7EU1MdgabpfReJESORmFuym0k0SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 11:05:57 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%4]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 11:05:57 +0000
Message-ID: <5e473fcc-0b7f-db19-5a34-f83f77f50a17@nvidia.com>
Date:   Wed, 25 Jan 2023 11:05:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: tegra: Add thermal support for Tegra234
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
References: <20230124115119.21451-1-jonathanh@nvidia.com>
 <20230124115119.21451-2-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230124115119.21451-2-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 507852c4-9161-4cc5-96a3-08dafec42254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTHD+EfjfjsbYgmaeDqQRTq/cDCuvPlaLf/pQ5D01yFEoiW4k+8dWDgPMwRE7G6RtMDE/b6Ueytsgl4Mujh8am38V1Bgf1VUVUqQoOFXiM9k42bC0cuaThF3l2hr25hc+jz3i9oVdPj76JCI1rxlTEgTNTaVoYk+l5/2fC5dCN1mQFRlViOEgGUGU6rNST6SsGGoHCIOvLDtQcwu6tCBHxunNj3QMXVRrxgGqRoaQaP91BYzaeDaij9rFlPIdWXt3VkcmCtT4KKrd+5fJyNspRaYdrf/1gF+XITuIY8cHT92RrBx1vayd3mSv9JbHkes4ntO5SkyCON2e4O2qNupxCeghjk18IWwSdm0SOoYJDk60dEjwWYZdL5UZ1mv4+rDrImRO4nwVBHd6+uP3zDR4qy3AxYyou6POMY8meSFswfh5bX3aYDtPBTVbCIxd6Joyxxn5CqvIGVYN85RP+LFTus8zo14VLgVSyZAC+SzOd6DWLFPDMvJr19Z92rXBiITYpzFMqacuPAYIL5RoOUOoHDXfdJx6iNUUqlPtHEo7UKptO4YBeODzcd1bixoKTFcOVfcj+MIkcGnxNEYMfvm91HLE2VWNbRfk0Y7nyJ/sSQUeIW6XaRAf3RHOzOVjzEz3+A7cyqAWSLO9wBDGXQgQkxDcSgxen+tJa8zCa8xxs/oCLf8hddMhDZGytZ55Gg+8mDUNwNEsRTLsRa3AbpDiFlHPhodaIF64dhRFTjYHdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(38100700002)(83380400001)(66556008)(2616005)(478600001)(8676002)(186003)(107886003)(66476007)(53546011)(31686004)(6486002)(36756003)(31696002)(110136005)(66946007)(2906002)(86362001)(41300700001)(5660300002)(316002)(6506007)(6666004)(6512007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVpRFB6Qnd3QjcrRm5VRHUvZ1MwS2kvQ3Jmc1BHdVlsVlUybHN1NERNRkln?=
 =?utf-8?B?T1JzOTY0UXJFbDFGcFhIVEpDcTg4RWlkR3ZaSHlja1Y4SVNhdWVMMHFReWVx?=
 =?utf-8?B?RFdIc2gxTlgwc2xjb1UrUTErR3NhSGM1ZXJrVGpUNWpuZlBQNFBveko4SDdG?=
 =?utf-8?B?N2ZUc05vOVk4RU4xdzB5WEV6VEFuWjZyM2t2K3dpYXVwNXJrVUdLejFGYmsv?=
 =?utf-8?B?TGcySlNNd01WT0RXN2hXYUxhMlNvUXk5YTVIRmRPUFNvRlQzVlhmVG5KN0FW?=
 =?utf-8?B?SEZYdEFFV2l3RzRuamR2WEdvVjNGUmdPUE9PNzkrL05Ga1AwZnFvbTVCN3U3?=
 =?utf-8?B?bzJCU0FqaFBVYUhYOFVqSE5XVXZJMi91SGNkSEg1WnZjRzQrT2I3VWkyNW9P?=
 =?utf-8?B?ejYzQ2Z4a08rMkZTeU5hZERWUDh2b0xlTUhmWGdaOFNxYURrb0N4SFRHYnZa?=
 =?utf-8?B?dXpwQURSTGdBa0tkMFhRTE1HVU9KWTRuZGpXUXRLdVhjNnhYTTJjam83NGp1?=
 =?utf-8?B?NUtlcDgxcGt5RUsrNWszT1ZlSk9EQUhkRzZLTXB6V1czU2s1ajlDbVVWc1BP?=
 =?utf-8?B?bENJbjhBNmZOV0xVVkRXVlN5MzIrVlBqcVZrOHFjRDlJZ1FydzBtWDlVWHJG?=
 =?utf-8?B?UzNYNkhDbHhXLzdtVUI5UjVoeWdvUjk4N0NBUEZDcEpwa0ZIMkI3cDdTdkly?=
 =?utf-8?B?MG1mQWdsSkZYNmJ6WldpNldCQ0dKT0ljWldDbGdkT043NkN3ZUpZNWUwczhN?=
 =?utf-8?B?YnpIa2hNekJHNUpLWVlCdWM3ZkhLb3laNVVXU3JaZEt3aUxwV3RZVzhsUEUy?=
 =?utf-8?B?dzRvcEw5LzduZUhML1BQdHlvYmVnT3NEeXV3dDBUbFMzQlZiWHBoNFIvSHpL?=
 =?utf-8?B?Yk9HNm9ENEg1TThPWDdSdFVvOVdyVmExSnlwSElqcDFHR3JySjJ5SytQNGZQ?=
 =?utf-8?B?cm9uRmpIN2dJcUpCQkVQM3lWRHpVeEQxQThvcUE4TmY3MmJ5WHF4bTB4bG8z?=
 =?utf-8?B?bDRFZlJWc3dwRWRyRDNNdDN5ZUkvZ0JpZWFrZll4S0RLdUZSUDhubmM5QWRF?=
 =?utf-8?B?c2QxeEFNcUFOeUh0ZGxKeVdwWG16Y1lYMkx1aUlwZEFQbmxQSmx2Yi9UT2JI?=
 =?utf-8?B?VHI3L0pEYWpGZVlVNTVDMzY3UEg1V1V5K2VVOHZ5My9kSTE4MmwyUU9rZ1di?=
 =?utf-8?B?bEpZVzFwUnNRbzBrRVhTcVFpaFhKdnU5cWZubnhHZlR1NGJUK2wzUnkxQ1NJ?=
 =?utf-8?B?bmpYc0tsbHRDdEp6SE53dFNFanZQUmYwb01xblpUK1IyVEN3YUJNcm1kZ1li?=
 =?utf-8?B?NXJOd3FJWEpNSUUwSC8xYUx4ai95N2NnYzFSUk0zRThwMEZNUlg0a3pwVHdU?=
 =?utf-8?B?OVFGYytZWE45SCt1TDBBV2NNeVJzdmlLeUdZVFBsa0hlamM0SXlQZjhCWU9M?=
 =?utf-8?B?TE9KbUFVbHczK0loa1h4djRlOUo5T0lwbDhGZ2hDRjFRUHlZSjJ5NWtuOC8z?=
 =?utf-8?B?N1ZyQ0p2MGt2ODE1S0I5MDQ0dnlyRmcreXdLTnprNDM3aEh3T3QrbmhKWks2?=
 =?utf-8?B?UDBJTms1UWlLdmlPcVlhNDlQZnNXeFArNEhRVlAvZ21Dd3NNajBTNDAwV04w?=
 =?utf-8?B?UDFqblZ0dk5vNmxNLytVd0d3Z3E3cFpXelVrd2dNOUFadnFBQmtFWEF6NWpC?=
 =?utf-8?B?NkZkZ1kxY1h6dFVJclRDdjliKzVGakFQS2trSUp3OG9MU2pnelRJNldJcE1Z?=
 =?utf-8?B?R3hrYWJldmU3S3dCcEx4RFptOGlrTkl0cFNZbVE3cWhoTnkzWHRLS2NzYitx?=
 =?utf-8?B?aS9RM0hSU0hEcmd2VTBsM3ZxeFBLdkFtMWVhd1ZQRWoyUGpuY09OTVBlVUNM?=
 =?utf-8?B?dGtlU1BUOXlKeEIvY09PSURNNVE5dUxYbGFmdzN1TUx1Uy8wdWRBcjY3dGZN?=
 =?utf-8?B?VE9hMDBYdUdvRlBidnRTS0FaT053VE9PV2Z3SlpuU0c3MkZuclhBT2pkdVpw?=
 =?utf-8?B?MEt4Z05UdWtsSGJsdk9ESTBwMmNVUDNacHh1TDZrUDJTbnQ1RFlYRTFKMzFB?=
 =?utf-8?B?UjZGN3ZyblJ1QksrOTNUNmUzYnNkU2h3cDJBU0FVVG5HdmJXVW9lbHFOVlRv?=
 =?utf-8?B?OHZDV2FNUDEwS3dUTnR4OFZITlJ2Y0Z5MmpLYndCWG1wL296ZTdHak5xVWx5?=
 =?utf-8?B?TTR4OGVuSjcrNHM0TkZmcUt6Rlp3TkxGNXhJTGNTMGRRTjRSVEFtV0xsajNF?=
 =?utf-8?B?bkxwTTRwWEE4YXZpTzN0bU5neHFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507852c4-9161-4cc5-96a3-08dafec42254
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 11:05:57.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjCuipeg/dgXcr5YJQ5pS9GPpHI2xMqg9MZMS5irdOWIOtby29cd52YzQ56/25wZeEcm04t7N1oGS7rYdcDfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 24/01/2023 11:51, Jon Hunter wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
> 
> Add the BPMP thermal device node and thermal-zones for Tegra234 and
> enable thermal support for the Tegra234 Jetson AGX Orin board.
> 
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 276 ++++++++++++++++++
>   .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  32 ++
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  59 ++++
>   3 files changed, 367 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> index 2378da324273..7f798742df43 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> @@ -80,6 +80,22 @@ pmc@c360000 {
>   		};
>   	};
>   
> +	bpmp {
> +		i2c {
> +			tegra_tmp451: thermal-sensor@4c {
> +				compatible = "ti,tmp451";
> +				reg = <0x4c>;
> +				vcc-supply = <&vdd_1v8_ao>;
> +				#thermal-sensor-cells = <1>;
> +				status = "okay";
> +			};
> +		};
> +
> +		thermal {
> +			status = "okay";
> +		};
> +	};
> +
>   	vdd_5v0_sys: regulator-vdd-5v0-sys {
>   		compatible = "regulator-fixed";
>   		regulator-name = "VIN_SYS_5V0";
> @@ -139,4 +155,264 @@ vdd_12v_pcie: regulator-vdd-12v-pcie {
>   		gpio = <&gpio TEGRA234_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
>   		regulator-boot-on;
>   	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <1000>;
> +			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CPU>;
> +			status = "okay";
> +
> +			trips {
> +				cpu_sw_shutdown: cpu-sw-shutdown {
> +					temperature = <104500>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +
> +				cpu_sw_throttle: cpu-sw-throttle {
> +					temperature = <99000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_sw_throttle>;
> +					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <1000>;
> +			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_GPU>;
> +			status = "okay";
> +			status = "disabled";

Looks like I messed this up. I will send a V2 to fix.

Jon

-- 
nvpublic
