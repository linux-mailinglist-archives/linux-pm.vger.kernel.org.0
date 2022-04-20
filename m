Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A085084A1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Apr 2022 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiDTJQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Apr 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiDTJQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2022 05:16:04 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2135.outbound.protection.outlook.com [40.107.23.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C824D31903
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2022 02:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXRZ+FShXoGqnchv2yssdTq9un1Hfz4oH/5WQcbjCgFsWCWN3zC1bGAS+H+vGhVAJ06dmHGUizqvt698J1T89kHP5x81sh70PmAImPQPDX94B1ESUzRbV1qAhYNN+ebpd+qlPcmCEDfOhGeRtjV8pKiqcOTKGcsMvWk2otPiXLzxip62auo8uvlpYJCsyXlyF5hqcuy5FB9hOJA9K4HD8JlsvXsbWfbH1nEE7FJGtDVZMxFQdygWwc5UPFBOfe4LELbiW0+AjT6hlrguvAgV2KV0JfPyZR8LkE5iO8llNXrIhxiwdnqP+7FgwYBshmwA4hOZEVPpYfzZoNpoTvNfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+nW9Qm4WizYILbeEBNES29lJ7MB3FxfULtTkTF2Uyg=;
 b=Enxej6u9iOoz/i9LpcpemJlqM2t3+kE+w738JFqShVBH724i/mGwvgwfEUAl76wVfsXdc4bNWWUJQF5hshc/5e4B/FcE1abXQTv4E0QO1/+RcNovVSrE5Ye53znlc9RUygRh9l/9zSMPCqJTtGcyMt3Nak2bdr77U8QKPok/W3kps1xT/RDE7/dIgte9Mt4G8bsSEhm4ZkHXdz0BnnaQrtH5bqRudS9G/ivbWzwIACgIUynewXe66WqqqGdTkvZG3HxYTNYDpGFsvk1Nvn1yXdDhJ68n2yX+aITGXvWyPGlQfprec0QV8VTcidKKtTa8fV5Ky3ghRZpWoJTQhQfmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+nW9Qm4WizYILbeEBNES29lJ7MB3FxfULtTkTF2Uyg=;
 b=iOzcgo5AFEAZ+jckb0Zgx/MjjFSsgqwHXrBegwpjoeJvi43Sr1lbf/GHq2mRgnQaLYBOlfpZ0BzYqp6hf04VD8LagRRT7OUzHhA0hnL0s8vIwxYJetOYYbihIPirYrkmMSwjGp1qrOv90o2nVYAT7gn2Sx7oEfBzFuOXx6yv8OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0204.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:37::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 20 Apr 2022 09:13:16 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 09:13:16 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: [PATCH v1] thermal: imx: Update critical temp threshold
Date:   Wed, 20 Apr 2022 11:13:00 +0200
Message-Id: <20220420091300.179753-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR2P264CA0112.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c885add-3d1e-4f47-23eb-08da22ae00f2
X-MS-TrafficTypeDiagnostic: ZR0P278MB0204:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0204CB45538235694C8846A3E2F59@ZR0P278MB0204.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu98rZUa4j4Gt95LXwCQUN/YshJsi4SmnUG+qy4tFYrTNKfCMhOew/Oz1LGkmovFFAzDQvTjNe/DfanBSsSXXVWd+SZ3pi1SDQkalVaOfgllXTQVKYQY4L+fk8r+3kMRnC8edxAnCjMhNQk8LwYJwcKnw9UEGhBSkhCajtacGT7AgpfCy+EOeNVixVYJr3Eec7T2kdj5T/7yMLST0KF5+eDbiH1Kq6VD9HW5EcvDUoNk4s16VbQlESnhjTqkvTfvNstKuyZ0cjXmWFTiO4y0pfnJRX2mn6z3TWfaDCVH9mFZjDtD5gH13h23KmrJLq62KFdojk6oiVkC6nMXWR1EZM0CFuosspyM8ptRrOF0ixnFT8Ai/qEjBB9eZxlCMJZ01NDRcWWI+MBCSG0V1OfXsODDfE9enID3q6pT9vm4/9AEuqCs1FTTtB9UaUf8N7Q0kbkRpJI5S9HKIgcA5037tcgZFM97A4L/2dLEz7O3qzt1UCQycWhTE2uMPNODQXSrhilgJ/LP+IfoCjyMjO3mhYUeFCnOA6gzwmOcEIZUAihC3huoohLnMgRWlMLSL4MKsAkoFCUCjpcV+ExfxOjbRdTW98Fndpyiw58Ad4QLocwvukvF8kSNpwum0omMzHbvrJCPHhC3hamRZ4PYUxy39JQIWOLShOi6DVPMOMffhjI1On0FjU1HXujbwKPOfGFr6mwpI5lb+9PHzNarCX6SlUAHfukPAZn8q2fDV54WkhLbZyfFy7hGbCDX83MlPTTXSs9mmcc09r9NMwI2BjgXdbeKF+Tc1pn4YZLojlFNcMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(366004)(396003)(136003)(346002)(39840400004)(66556008)(4326008)(508600001)(66476007)(54906003)(7416002)(8676002)(44832011)(36756003)(2906002)(110136005)(5660300002)(1076003)(2616005)(53546011)(6512007)(8936002)(6506007)(52116002)(66946007)(6486002)(316002)(966005)(6666004)(38350700002)(38100700002)(83380400001)(86362001)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWF1T2RmaFJlcDR4NHZKWEpjWlVsMENhWGV2dys1aDNuNE1XUDltdGV5OFNk?=
 =?utf-8?B?OXFkd0JJU1QvN2YzR1VFQkh0TE41VmxtSWswUzRNU2VhWDZOdW5IRFpOTTRN?=
 =?utf-8?B?bTUzNnJFMnFQZjQ5YU04SWhRZjBtZkQ1bkIwSGt6WCtsdC82RmxHbVZycHV4?=
 =?utf-8?B?UURvYWFPb3gvSmRvNUIvLzN4QUNUVVBwTElLQ1F1N3ZWS2d4d3Uwc0Rrams0?=
 =?utf-8?B?S05uWFQ4TzE0Y3FYUGd5UmhmVkRVRlZid3lGNFJLL0pyMFZKNXRxN2g5NW0z?=
 =?utf-8?B?a2MrQTNwVnN2QlkzOVVQZTF3MmkvNW1mZFdGaWc1WXNrSFdFUUlpNkZ3TzRv?=
 =?utf-8?B?QWVOYWNqaW9nc0pYNEtuaFA4eFM5UDVwNTRTWmFxUE9qZDhZVDFLYVRERTY3?=
 =?utf-8?B?TXVnUnVnQ2ZwWU85djlKZWxTRWJkOWlpS0pkb3BSdTFQSDZZT3BWWnBQNUI0?=
 =?utf-8?B?cVJPbTh4VkZaWExaNGQxdThNLzVqVW42bmdmL0pUcVM0eUN3V05mamczcnM2?=
 =?utf-8?B?TWIzbDYwTFRnZmtTU0t4Z3Y1T2FTaXZtdGhCT2RuZE5BcGptZHVHSjkwRys4?=
 =?utf-8?B?eUdyOUhnOG5rSFlUL0ZudGgxem8wNmQ0eVREeGpzUXJRNUo5WDJPOWJnck41?=
 =?utf-8?B?eGlzUnM0RHpwdndWdDlncVl0RzgxVzl3a3RpU0NFSnBYU051WlBOT2Q5aXlF?=
 =?utf-8?B?V2M5b2ZvWEtmb2hZcGIyeHhaWmd6Tzh2TmN5by9ueG5WSGdMVVdwM1lCQ1dp?=
 =?utf-8?B?c01rRnBZS1dDb3dCOGFxMTRRWlRtNWlvaUl4eGhjM2pwSWtKTHFUdDVhamVa?=
 =?utf-8?B?ZitXWjB3M0hjUXFCdGhCZ2pPVmhFemNwU3owaHNZTU9DR2RsbVg2emlITi9X?=
 =?utf-8?B?bXJkazJ2RmdIempEcjhhdDRaRG9ZbDBVS281aWUvcjJpNzlMZkcvK1R6TjBU?=
 =?utf-8?B?UVdtS2RhQlFSeDVKS0lua2VhVVM4WnkxQ2s4VUI0Z0V2SE9PYisraE5HTjEz?=
 =?utf-8?B?dE1ING5ueVhTWXRBWWxYdzh3SEVDVzI4RDNISHAwUHFiNXl6M1JFU1IvMm80?=
 =?utf-8?B?SW5RYm9DK29uQVQrcVNKaHNoOHVZUlVQejB5ZnRwbkhYTHRqMnpUeW0rOVFk?=
 =?utf-8?B?dlV1WERiNGhqelAvSUhyY3FKdlJCaXMwblVob0dHRC95R005YXlLeThSdFZh?=
 =?utf-8?B?ZGFtVlU4VzNxYkE4WklkUUkvQ2JwU0xmSHBQWUMwU05YR09ZQXZHeTJ6NndN?=
 =?utf-8?B?Ym44cVFXam5WSEU0V2ViS0tNQ2VLUlVKRlU2ejlzNitZdlhGU1R5dzVyYk01?=
 =?utf-8?B?Sm92MklxR2NaT0ZRZ0xsYVpaV3Z5amNyVk5JVjFHd2w0SHJJMnhlZDAxbWJQ?=
 =?utf-8?B?NmJMM25ISURKNHZsSU8xWExyaGZWU2ZEeWFZaWpHdzQxY0duZVVFbHVIR2pw?=
 =?utf-8?B?MXRUVGlXYlowUm15TUZjU1dnL2FoNlpuMUFzSFN6WURlTUVPM3lZeXFPMWxI?=
 =?utf-8?B?MWsyK1BGV2pvZktTaEowU2tqWWhzdktwYXovT1J4OElXSnF4N1pzRmorcTJm?=
 =?utf-8?B?NEoxZnYxaHhtYjlrTWZWanlrRm5hQ01OUk9KK2xRUnFKNHozK29tekErZzh0?=
 =?utf-8?B?cVBQRCttK2t3VG1HSklJc3B1dmx5WjVycUs3SlBJcWhPaFQvNjU1RWJ2QmFF?=
 =?utf-8?B?ell6blZqNkVFQkpNVTR6QnNjaWwyMlRyYzN2VkluRkd5UXRPY1pFemwwNDJm?=
 =?utf-8?B?MVg3U0Z0WS9xZDNHbHliVytRcUlvMFVDa05nNWg2ZDhFL3l2Qk12WU5DbzFK?=
 =?utf-8?B?bWVLWTNIVnBpQk10M1RGUHNTMU8xam93YWw3U29HaEJqSG1ZbVNQcWlqLzdu?=
 =?utf-8?B?Uy9KT3Zna0JjMERHR0RLbVZZL1ZBeGxNVk45cEhkYVpmcmJnUjczNjB1Zmx2?=
 =?utf-8?B?eWcrMkE0UnV6ekNnVmtGUTA2ZTJZbTY0dEV2MHNjNTdaKy8zekpCa01QLzJt?=
 =?utf-8?B?OXgzTFZCMDJCWDVUK3FPSEpRSVE4L2tzRmk4dWI2eWQrL2Y0QzZTVTRIZG02?=
 =?utf-8?B?Rk4wOHkzYzhVeWE2NFJEcDZKZWRtSm5yNHJMKzM4RVExNDNKSTBWRkI2UDJP?=
 =?utf-8?B?ZVdKcy82bXVCdStwYjlFNXFRZXVkZUFNQ0ZjRXdVQXNzcWppdkp4ckZxaFJz?=
 =?utf-8?B?dDJqZzUwWHZlemZXdy9MWE9lVFBDaHRIUDc4c2o1aEFlUVU5Ky85eFRRSXRn?=
 =?utf-8?B?bmU0cWp6MVBYN21mbmU1NHpCQW13ZHkvK2JnR2l0aVRuZDFuZXYrNFZjdXli?=
 =?utf-8?B?YWY2UDZtWmt1YXhzUmJZZGt0WmUwdWJMUmJxVEtiU2RsczAydzFMOExhS1Vo?=
 =?utf-8?Q?3naH39l38JgbjYLY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c885add-3d1e-4f47-23eb-08da22ae00f2
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 09:13:16.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrIItyLMeumiUpBN1ZoXPxxNndR4wNGNogi1EcInwdlhv7RUwA4MCPna/IQvjiilU7gyev287PaH1uE/+W01iVICG78fdMRxovopj/qocJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase the critical temperature threshold to the datasheet defined
value according to the temperature grade of the SoC, increasing the
actual critical temperature value of 5 degrees.

Without this change the emergency shutdown will trigger earlier then
required affecting applications that are expected to be working on this
close to the limit, but yet valid, temperature range.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

Not sure if there is an alternative to this patch, the critical threshold seems
to be read-only and it is not possible to just change it from user space that
would be my preferred solution.

According to the original discussion [1] the reasoning was the following:

On Tue, Jul 28, 2015 at 4:50 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Yes - the purpose of lowering the critical threshold from the hardware
> default is to allow Linux to shutdown more cleanly.

But I do not understand it.

[1] https://lore.kernel.org/all/CAJ+vNU1PQZa9KoCU9o_ws6jAAjhGVJby-1P583SVejT5TrAFTQ@mail.gmail.com/

---
 drivers/thermal/imx_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..75a631a23e61 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -504,10 +504,10 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 	}
 
 	/*
-	 * Set the critical trip point at 5 °C under max
+	 * Set the critical trip point at max
 	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
 	 */
-	data->temp_critical = data->temp_max - (1000 * 5);
+	data->temp_critical = data->temp_max;
 	data->temp_passive = data->temp_max - (1000 * 10);
 }
 
-- 
2.25.1

