Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3167D6B9A5C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCNPv2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCNPv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 11:51:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A050F98
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 08:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBhLXpGyHFlQsqxTzn5IxiM3+pvO78NPcUw3mE0BdZZsEpmMbYWwMTogTExghtZxlbS8hS5uznhiRrGNrhYajdfZCaCDxXmSKTgwcJuqC4Nzq4wS4FGmoKc+s8xqS3hRTqoPOuahHtf8x9Y1CZJTKJu4ryRYtpXQ3F84f9FlboPq0Gfh0YMqHLCHRsk/zQRA9hAyJ5clQAnO/8Ck2cBWkKCkYo490LEnLqNR0QN9kq2BenLZSJbVKEueeSESlf/KKseJI00tqutjYWpIZkYfqF8v3njoKzpFzOhmAHPMth7n/o5YSs+zTDfRvflrS8vg1P/sKXYQ/JiPZEhvWf7txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7e+nXEkPBgyKMy+0gHC2snE5nCwa+xbkN99eWC/Mew=;
 b=GQiJ73AS+uJnCLLiyn92K9P79Rle6YvSDF7Y3GO70BPletum0WAMvTQr5zPUbDtOXRQhyuwczB60Gtpv8yoosrafJ7Vp3oMabY6eYYYuat71UJWSeY7pZ4/xRe5yB2ClyS6oIWnkpzf5yhkFmiuOhzXk9WC8OGtIqD4stdNj3hEP3LJrMZ4bvUi3bmTk1Q45bQ48bG8wP1NfiRtllpTO7Skb9zxXVGRM9Xt+UiHPtKqJ7B4eWtnHMD01uKJU9JTfuYOuClQxUr7z8TfY1CoZH4wmIoJwWt/Nsw8sEDcSO70B1XQA/f21vOyU0UZtlSBydmSdA9RZRWrEsCCL4fcEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7e+nXEkPBgyKMy+0gHC2snE5nCwa+xbkN99eWC/Mew=;
 b=VdrOvBi4PbSapXag+6RwgxLjKPcdhR7/gjLjXFh+rS5jrIgV+Dwq5Di9183phnkE6yNyuOa68elmIvID2v8ley5FEQqLsEKYriauNbICKzpfgkSH82ZVa4u/w7uNJxJ8Zc2wyYHh1U4Gi+PsIOXR2sU+ke4onA7M9KhUUD7nbinmw52qi7dMD3vvBmQt0F2HqLs1KhntmM67O27K/OxgNu/gK48MDoXRbCsThhXSsomMGXN1CiVoeHjoNzwjJeFH9B57TmzFTk03hTfbKi3ptT00gE/pfbYWXwx19PpTYKDohe5RBsNidTVsKO2M/ajG//2/xmqpf0UyLquLW0sqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 15:50:43 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 15:50:43 +0000
From:   Ido Schimmel <idosch@nvidia.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mlxsw@nvidia.com, vadimp@nvidia.com,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH] thermal: core: Restore behavior regarding invalid trip points
Date:   Tue, 14 Mar 2023 17:50:10 +0200
Message-Id: <20230314155010.3692869-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::37) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 04608930-719f-4187-e5ae-08db24a3de86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB2xRY2i+sBi+Tsgo+9fSzR/2L7q0kqDkKANazNONiw+eCb4fr5HYx348YKIxTC1eiNNbpryACcta8x9HEFJyBTNOkWDwSbD7ksZY5pISYFJ0h8lG70dNKy+cJzYHwuBxRBlDqaogHaHXwa+O/Ixc19Seo4QwnQM5XsuYeaYALkf+y2BrRHTgv3GK/1tCzE5yDF/+c0mq71v1qTLzeS0si7y5HHmlnvtLbYwJffJ5FeKW7tfqstZmANF/QNpPy2L/qsTdt7KXtLGVKlsipcLmrusRLcJyWghDiQMEBKiNQ27OISkp2BDj0vG56Ca1NEKCk40le1m+9XLExAoqZ5nqlIyYnkVlKeX+KpE3m7Fv4HNjl0RkiVuwmVZipn4mLlcBiqBiGVRI6LC1ColKuM93mI1k0q8H28FOgqZLqsyKpgv9ZgfRe0q8x/qmGl7Bk+TelXLXuJr90YZqHH42wX51i9SbxroMY1DUqt1Kxa9EzJvARHcJ2/CJT5AxikDUZ9iZ3vyF4enfJPYjBUTZrFpmoZXxgA3/E7b6UG0ZXIg09TcvKY64gHARtyNkRIWLr6Umsl+V7r7/CCwB/E9BgEiUIDqztqRZNNPodk6DgZ3LuGsCpPdTDJNmPSuyw8T6zT4Vvd4EyTE9uBnZQbmp6WI6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(6666004)(38100700002)(316002)(36756003)(86362001)(83380400001)(186003)(1076003)(6512007)(6506007)(26005)(2616005)(5660300002)(6486002)(478600001)(41300700001)(107886003)(8936002)(2906002)(66556008)(8676002)(6916009)(4326008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35qr1IKy41K/YIG/xiBIaw6N9gumGn6A9bPLWaZ+r8KW8zXoYGuFFciYvBSi?=
 =?us-ascii?Q?Wsm9rjNJH4q0/XTJn1g9D9hJ9NiuNiGsfo3wlZVmJcpmdjFE8qDYyqIHl9IR?=
 =?us-ascii?Q?9oDL4YJTlBFDYAbc9bPZe0EGXlRF/jAQl4Jyx54PeOrvWqJPl6XIxbtVpWMq?=
 =?us-ascii?Q?ty0K/4jjTRJhmFprCnyEMN2wisDDWQ54TcyhAx8CdW3qdzGbyj/G52Rq8nqk?=
 =?us-ascii?Q?3x0ZySVr6ckjEioh2V4fo1BHzxrymuEMchVZQ4/n+OuFT15chbp7W2A7yplQ?=
 =?us-ascii?Q?6bViFshsqKzxsbwsQsuYuONAIgty19dntledzy5yQLKcilzdWmQ0hJeYsm0I?=
 =?us-ascii?Q?WL53tDr3LwI89UG3c2YE44gZWeYT3iTW8NDh12iBEtSOHnj9gE5PIOQqA8az?=
 =?us-ascii?Q?Vew/KWQdm6nwWKgzj7x9r/gHp9WMLrmJjAohYY8ci98Fj5+Ian2gW12b2Rb6?=
 =?us-ascii?Q?dft+fVbBtDOsgxXPeXoLPA+srxVPyJwYE5UbPqsN8Zp9DiP8++yLhDEgFkBz?=
 =?us-ascii?Q?qe7BSMyiFae0l0ooGfTiV0XxnrnnAmkBhg0fk50dmmETmCDbJY6vT5pOw93t?=
 =?us-ascii?Q?qx1Dq+nmhR+k1Os5H0B44mnav7CD3brj1Rf1UVSKsE/7hK2vZn9moVs2t6Hx?=
 =?us-ascii?Q?GySO3SxaEZX2ESy6kwvC1Z7deguKRrK9u5qgT1rHJufn2kdIb4X2wUPCwhkF?=
 =?us-ascii?Q?cWaHV/x7OP0X0mzTFQyAzYka2GbhniybSufUN61If21ZeSTaD1MLfndgiBs5?=
 =?us-ascii?Q?/gTehboaSFLzoTLWXZFtevskhQYjMboYARYJcpqG6NIGGUMMsQ6mHze6o7XL?=
 =?us-ascii?Q?BXs5HCfB6Upf0lFhpRL4qLmkpwlv8mzq9xfbD5Gbc6teQqH2ecxphc9xDMG4?=
 =?us-ascii?Q?lf8/YVo1VHUMqCUN9r51Ut00tNW0ePTMJROKtw2XlIYoVDBV8kvYrHnsjig1?=
 =?us-ascii?Q?F4DnEs6bAMJrGpYHg1QWl2xPhl+p/BcbDxgNAJ7T5yi1KDbs+LC3BUWk0thY?=
 =?us-ascii?Q?vg+syocHeVKG1phWFhJzVMxvf6Hp/y6iLSMWIqh0mAJyU/TKYqSaGOUTBk4D?=
 =?us-ascii?Q?IPDOw5Fni/RqnJRx1a2yzmJ2pT5JybuYdDJ8wSV8B1vZ9OL8k2Jqjbs9qbKh?=
 =?us-ascii?Q?TFFDyefcxtx3PeT8n/oFDy3SaGayaLBipl6A/U3wo3T2XFE4+dfDvATP3XI8?=
 =?us-ascii?Q?Fs+rxB/EAZZvy9u5yPQHgn7KvaPH0Fnmn91UIESoBt0p8Km2S9k6+cUgnlY1?=
 =?us-ascii?Q?mRldXTgMSNzmTXL1lWAatAQ2hm9+UGE/HniXS61rSlxku3AvyNXN1OMitEle?=
 =?us-ascii?Q?cLbu5y8QemTvPQJF4t3n069nXexfcHJJzmblPtxKUmaWDm+YyEKIbzDNEY9t?=
 =?us-ascii?Q?wSNAampsJjJe6fDlP5KlETknF24v5UGPqaPlfAcSxgF4RSQN1+x7T2+e7Ltg?=
 =?us-ascii?Q?CNNxSgFZ/9r2OgM1VFTDo4PeK4tc1qQtS2pV43EK3TO9iud4v2yWCqrN9qWu?=
 =?us-ascii?Q?Hts2SzPxYe0EukA7s/ggHKWD7LujUgxcUuqpeHMcUrEq9ZxIBvw2gevccOye?=
 =?us-ascii?Q?ORnz/lS32cEMpl4kZitRl0QMUAtxSvQx/IEHSGt/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04608930-719f-4187-e5ae-08db24a3de86
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 15:50:43.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOfp4beBPgVq4sVNaSTkcSq+SUKUOVkmlohVdlWvqXD05q8f0bnG4Tm267wx3cJMMdVrKdmUWZWycA7tr9OhfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cited commit stopped marking trip points with a zero temperature as
disabled, behavior that was originally introduced in commit 81ad4276b505
("Thermal: Ignore invalid trip points").

When using the mlxsw driver we see that when such trip points are not
disabled, the thermal subsystem repeatedly tries to set the state of the
associated cooling devices to the maximum state.

Fix this by restoring the original behavior and mark trip points with a
zero temperature as disabled.

Fixes: 7c3d5c20dc16 ("thermal/core: Add a generic thermal_zone_get_trip() function")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5ae72f314683..63583df4498d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1309,7 +1309,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		struct thermal_trip trip;
 
 		result = thermal_zone_get_trip(tz, count, &trip);
-		if (result)
+		if (result || !trip.temperature)
 			set_bit(count, &tz->trips_disabled);
 	}
 
-- 
2.37.3

