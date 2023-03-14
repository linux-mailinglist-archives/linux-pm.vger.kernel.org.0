Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39246B9EB8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 19:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCNSho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCNShk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 14:37:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C27ECD
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 11:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2JZqQj0TeYJWbjI36MMwkm1WnkBImeKKlVMvp9lSJWnWfZ5MwcIaGZfvnLomsPZTVufK+PGk3fsigrKwGL6mFm5pNAUZe23/XVvYmXtHD2vQrLSFPRrHgVgfFRFCAhRnQNnsXFPhKoze2vBYsJia0KSyOc9va4t/FRGC0T36ifHAXfQfS0mBBKKL2BW3fez2LPZZ7Pb+pEbYTkLTOYWR/PsiUa3dpS4p1QIbSzdSNADa8ODB7rHOjIsyOW0rHUh1AmbpWNMyaWLDywcd0td0OeQRpXOztEoNCsZYPD96KSKI3hrxHM4hhEYYEsV0g4ifhhjfIjg04SDe0QT0qxZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfKHBSNr1O3GDhec2sNQalYKZdVjvDIyRuPF5id6euo=;
 b=BH77GgIE9vvg2lFR5UKxE9NW2LD9gmwGLS5MZZH4inGGf528gcZ46peBpZPmMZfYbR0K3UlYIpx9rj3CIhUAmcKiTAO2CNEy5BNbaph2CQuZfVJlMyYwc1YTtnjvEEIAUXxCQ52FWJ7vP95T/+pSjgBiQwSM+q/Ri3IK/rY0FdkFujIA/QlP7CL4INwhTCZJKQbmYIXWQeJriOYnJj6iZZed3NJvri4I/PA6e9UbXVAkdWqmPrTl4RoU7bLZ1ZoPXAU/0xBqeX4ofDPZM+v0ZkPh3PvqlzjeR3Owxp06yITySQvZEQFF4niLEqOMc+0oTVVH7wSP0mfadXrCcABhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfKHBSNr1O3GDhec2sNQalYKZdVjvDIyRuPF5id6euo=;
 b=qeSwmFSECIw4W/GpsD2biJ6EqbTXQJ8qjn/l7rIcfvxzoRG5DsPip0wO1h2lKgaDkK0j9Kp7S419te22JhnvMHUSzABbVKd4xcejMBTY3Bb2A16zYd8B14iUExlDK9oLIc4A4NwAuNvyqDyaPFO9JffraIK9lLIYTCQcLW3my2x6n2KYN3PWUOJ8DToUQPuc2+3/8gsixScmJAOEoKF2FK7bDnSvk163JWmBNIOogOXgq3OSpppsh3QD16pZxi5nbwuoQ83GTUBUueuEP72McjxFMq1XyLhbaEdErqovzecgIkN5pWt/cYM+CHypuSGbCKl4k0Oa/N5ZBtrkPBTiFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 18:35:53 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 18:35:52 +0000
Date:   Tue, 14 Mar 2023 20:35:45 +0200
From:   Ido Schimmel <idosch@nvidia.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, mlxsw@nvidia.com,
        vadimp@nvidia.com
Subject: Re: [PATCH] thermal: core: Restore behavior regarding invalid trip
 points
Message-ID: <ZBC+gUXyTsHHIX8O@shredder>
References: <20230314155010.3692869-1-idosch@nvidia.com>
 <CAJZ5v0gKR6xzZUgATEMCGnAgtq3dGo-QyM372yvWqJPMu3r=GQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gKR6xzZUgATEMCGnAgtq3dGo-QyM372yvWqJPMu3r=GQ@mail.gmail.com>
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: ceea5063-5d5c-4dce-f85f-08db24baf0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D0dzzPUAZXCnDB33cU3wH9+Hzk8H578OuNfFXX9fLb3yKkUpbPWQfMS2FZ99ZYoUZz4z3EjaVEuIRbOmNwAyaS0o/wj1ZqWgsDnL0RIIFK3AnQtCltr2q8ZMGtnpS53oATIkUyxSRxrpyCQIBS2c6MZ8Sq5X7gHVI1HoTSFKvV2TyW04d+zhz5gkefEaRiK8ntav8JBLuawHIAzwak8ayi+WLDbzdM1Y7MQ8VnzbPQmZW69DYTLBceJKf/6iVcBBMVNABh3UZJ98voGXf5lWWxZJJR8dTLN5tJ4nxmKAYJgej5DGkFqUbYg7whuB51d52uDeSamVWs591YkLoRHVs/7GaQ7RIuaQfibuQIjbYYEQr4j1UYAaVJ+9uRqbuLdWRnj/tq0R/pUfHs9j+lhm1MsjD6hAw5LyuFPmxHtnJy7u5fZ7Lu7yd1hXaIGS974jjXwkgsouViWAv8bEZ800zh95uOzbDU1vDZ9FrBqW1uLYQYOJGcNsrQmGKRUHBWn7fMMWDZNyln+1ld4Qr9snpgkI0zARewsJs4JmsGO9Xj6NnXmZTUP9yE9v4x+X76KbL3iKwuJFL1kQHdz6Qb5hTgf8I5V23b6Ca+GmH6YeW5LZiD2pBSJZlp/Wl81nWIM06AHUYqGHO3CX91eHYAdt5CtReC5Ad+/SQFmaRF+D8Ad5XjoUC8YJFav0VGnoPDyQ18BnglnOkndMWW4H3YarDeL/6vb9w8cqwGSBhukD/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(6486002)(966005)(2906002)(33716001)(6666004)(83380400001)(107886003)(26005)(9686003)(5660300002)(6916009)(41300700001)(6506007)(8936002)(186003)(8676002)(86362001)(6512007)(66946007)(4326008)(66476007)(66556008)(478600001)(38100700002)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vH9EoAxtL/72C4Ii4gYQokpp+uE+AIRZu2FgUCUGtFTxk5a8u5xYp/ZJeoG?=
 =?us-ascii?Q?Ep8K675qOttCzQQxB+cdrNYZjy3RM+2OzI1Rd6E1RRE4OZJ1uHPT5y53NIc0?=
 =?us-ascii?Q?k+dWDOkyO1sSobmw4PZIOeEqLj9BX1hsOTGlEbNtn09KqH/ukfT/GQ9ttklV?=
 =?us-ascii?Q?2Wcx8rVvq2NNDYGjdLhmdlfvolkcy/OPbUvKyAkwmKf0FP9tzDxgXJNCgyDg?=
 =?us-ascii?Q?WyavD8bTpk8A//r+HmFyZyCStSQPJARw3nVq5Y5apgE4YxRBiE5T0kC+McpH?=
 =?us-ascii?Q?ulYcrCwg41LNGgZZWygBm8Lxh+7PRz8w0iuMtdX+Q7Q7HmNhUGyZtbHOZj49?=
 =?us-ascii?Q?Csp27AKLpj92eD7ZI3hJgY98D451xDz06MCdf/TyrAeYGg1CLNfRnyqYnBOw?=
 =?us-ascii?Q?owEsHjM92B22If8fYR7iARhRzbPpWfeOIMSUr63YHCIKhpDgp3yAbPjBC0ID?=
 =?us-ascii?Q?VAqBrDGPsQ0x2gJnUbJWdKQ0HM9zKRrrvsHV+H7twIv7WG5Qn/FvErpedTTO?=
 =?us-ascii?Q?ApU91mfKHtY9IbiMzPazBLr1c4DAN7+3/m36FcM6+y94PnvIQ2/W2oszGaBf?=
 =?us-ascii?Q?v9hjQoClttT4x4kHEYV8ivafgTZKuCZR6WvM5eOUB5jPQ2C+Q73ZTEgWMTxW?=
 =?us-ascii?Q?FAXXhZddxt41qtjfJUDvogn1YIJQb51YoxZzDYd5mcr5fADm04xjKsiQbP7n?=
 =?us-ascii?Q?dh3sCDwa8oL3h3tSCs8/8uKGTs/9et3OekZ4qWF0CbIgoY6gMnJYUIObBM73?=
 =?us-ascii?Q?q4Kl7nHxp6sGyUdWae3rBU3rygFGsxr4HMGfPK4zKnXBdyUsi6B1hxzvvq1a?=
 =?us-ascii?Q?e5QG0CktF3E0EoxzDUMsEJoFirgyqWI032p1yrBhvetRULmRB/Snj7iok93t?=
 =?us-ascii?Q?eKHW6yJsiBhMLkCvt/Nvpl9S+eRL0ORXUk0JwV07OQKXcH1ZcJUXx7DBbC/q?=
 =?us-ascii?Q?PQREguezpn/oCmoid8603EW/Bv+hT7lQHVqC6Dvc6/kipuH5fgVJzubWIV1E?=
 =?us-ascii?Q?/qdnOV8Re6EMj6Qo/hL+WkPlFxoxdS0sWsG/Nv1BIpct3kzXkef48OOiyrQ+?=
 =?us-ascii?Q?B79MYOV+xoR65XMQS2uny8Io1gONBSRHmLVaq21GfQh6izYhli83wvyLnQe3?=
 =?us-ascii?Q?GiOe0ANFg6G4w1VEIPWNHkq74qCrsaz8kqCiKKMXnJ8xnDAqtpRqSBGu+jiG?=
 =?us-ascii?Q?9Die1hFpuRUw6Sr1LuAaCS3d2wGWXBrYQvjDhx6maY0lPX7L95/pBRibPrhZ?=
 =?us-ascii?Q?/fb8QpkWh/FVN5wfF7dryXvfGvUs9AOTc9sbQoPCyHzxmdoiEtASCG1Z7uOy?=
 =?us-ascii?Q?+zqTNQaLcD+0jaSkGclAoc7VNEBuS6kui+HKa7zcAbCpeKW6Y1V32FLtdoRB?=
 =?us-ascii?Q?w78S1ose9MPvujT7j/Rg3Km0QLu8uVI0hvbPbfxuuEEU+9GB2pWzXptkd8Bt?=
 =?us-ascii?Q?y0/4LW6GuDlCiRVIzgYD0EcfYmstFQ7uRCdsDWa2B2U2LVmourMaM2wN3frb?=
 =?us-ascii?Q?rQHbLeMq1lJLdvdeOzC9xMZkMe2JelrwMo7bbDmlVWbqNnApb0Y5yq+VLe40?=
 =?us-ascii?Q?IVKcJyobhmkpVMkEDdKsa0o6bwdpd2xV5RklldIz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceea5063-5d5c-4dce-f85f-08db24baf0bd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 18:35:52.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RNPEpHYY9ZoeGfdgFSL6i5FhxBN1mwFuXBkXY2SlLpeW6qUaIEuPxzBnL6h16R01GysePRKasMI3TrOK561ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Mar 14, 2023 at 07:03:07PM +0100, Rafael J. Wysocki wrote:
> What if the temperature is negative?  I think that you'd still want to
> disable the trip in that case, wouldn't you?

Personally, no. This patch merely restores the behavior that was
inadvertently removed by 7c3d5c20dc16. Specifically by this hunk:

```
@@ -1252,9 +1319,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		goto release_device;
 
 	for (count = 0; count < num_trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
-		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
-		    !trip_temp)
+		struct thermal_trip trip;
+
+		result = thermal_zone_get_trip(tz, count, &trip);
+		if (result)
 			set_bit(count, &tz->trips_disabled);
 	}
```

> Daniel, what's your take on this?

Discussed this with Daniel yesterday:
https://lore.kernel.org/linux-pm/ZA8TPDpEVanOpjEp@shredder/

We agreed to rework mlxsw to not rely on the fact that trip points with
a zero temperature are disabled, but it's not rc material, unlike this
patch.

Thanks
