Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44C528D97
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiEPTAK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 May 2022 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiEPTAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 15:00:10 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C3553EB9D
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 12:00:08 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-H2utoj4aMT6YV9Y7gFwn4w-2; Mon, 16 May 2022 21:00:05 +0200
X-MC-Unique: H2utoj4aMT6YV9Y7gFwn4w-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0548.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:27::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 19:00:03 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 19:00:03 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Jon Nettleton <jon@solid-run.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v1] thermal: imx: Make trip point offset configurable
Date:   Mon, 16 May 2022 21:00:01 +0200
Message-ID: <20220516190001.147919-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR1P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdb830fc-4951-4295-be2c-08da376e48ed
X-MS-TrafficTypeDiagnostic: ZRAP278MB0548:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0548C8886D1BFA066A59B3DAE2CF9@ZRAP278MB0548.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3L8a7sxO+GJQnQLmvZBoEpa4RsUT1eBsxHpVPscs2IxANzgl8CumQLjYc9ObOOtcfbXQhc4GKd6031H51vORxJE7tFSLSAkluPxGUCj6iH+BVOxTVnFezklxzO1TGfUPtl2obcYW1Wyc7MKz5JeU5HKe3iNeaiP+C1jGxKG4gX1nf4uj3yZeOkb5Hah/n6y1B1kgD4+vEABzRXfnfBkckVViep7ApQjmfk4VbT9EwjXbgTpjSZNeZyfPYQUVuOZH0oAGzcj7JkDPFVkz6QuqDuDbwp4UGTx/zIz50yXuBm6vQ34Z0u7Oz3kX6jEuovS2paxsNwFpIxueKCngA040tabq4cUnz+8TvRaDS7gcWuZtiQW+5vV2bQLHCaY5Hjfk48ssOazP22BBhGs7V+wmjZSdUVaDCo2xINhhy6IghMbHNLNd7yiSuYgzQiai7i+far873BbXYPZvitNMYpJMOMNlvSz1JELFWQunBooOW8bB4iWOISZZ1drHRt5QNqUsJtFmANd/33z274lGNabgbMjcvsGbwR5xi6jqkcvtA0spkDR9PONoNA48mFTiM7NWuy5gLRI1KN/RK/N+GdWqXpt6TP7sIMSS7+DDlRAbJtt73kSENZVrZhuD/HVfxfzXkHB9GdIiOb2ulqup3BUuHphtdjUOE61e8EA4uUKWDhC6ce2ilT4LeBE5WIJKF+ZOYtWjIEuBBp7aTsb2YmD9yNcabYXWuYr7w25L6Ap1FoNRn4EW4JCbCOnMyc8+cNq2BOcUaNi3Od96a5UYvB5FHemA0vY1UYxRlAeBS9QqBhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(4326008)(44832011)(86362001)(83380400001)(66476007)(38100700002)(508600001)(66556008)(966005)(66946007)(52116002)(5660300002)(2906002)(36756003)(1076003)(8676002)(41300700001)(38350700002)(8936002)(54906003)(186003)(2616005)(316002)(6506007)(6486002)(7416002)(6512007)(26005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s22sw+ImBaROWhuFS/gPuCjfEG1GkO3YK3rpiSz0QVqMErQQHvEo8BRpiqJt?=
 =?us-ascii?Q?0ThgA7Qhem+n4eSgwabs9oJmGDDelr4RpEVHvgdeRW6e3PnNTTE2/gzg4KvE?=
 =?us-ascii?Q?25NzGQCNIDjZuxWFlVznF0UeXTwUZaj1LyI9Hj5w2DrUw0N2pSczYksFvI/q?=
 =?us-ascii?Q?KVuMCvk/tb8LjJBVDzVXgoHLo9sE0LOI7bNsm2jCfOoNygnTql5wggQ2RYn6?=
 =?us-ascii?Q?4tdjq/ASYtalVMbDG4QLj8Hi+ki+/TbK6Gmsacv+rJE8/JjBznS9lekV/3gy?=
 =?us-ascii?Q?98lSri7ukg9UrlWTpQ6trqhLw2QOUXGrvxMsVZaACdKS0qq9K81qgxO4pw95?=
 =?us-ascii?Q?jLy8/TtywyCiYzyqFCnZXtVCUcxo5CKppLQ+zmvZLrtHgDbOS/LGHlkS+RuC?=
 =?us-ascii?Q?9/vlXmxMyioXRKJmR/oh0OczdPMrDfra3XZGgbOsbtWNNJknzA+VKS9yHMH6?=
 =?us-ascii?Q?quzrhTsbm2sVSouAWg4vByGbmkZzb3iFB90IvSroR9SBlCgkNPbX3V1K6Nd4?=
 =?us-ascii?Q?VGJpnq6X/cgp8KhzPHmfiawZAtxH6hUBZfgwmZZ1L8xf4ySoS99HyH6C6N8L?=
 =?us-ascii?Q?snQkcRJFg9eLhzgHxHKpZv4imVAHD/Y7ojbUXaxnama/oQ1mU3PTxTKAQG6H?=
 =?us-ascii?Q?OBTX+RcD2eIlRKFBPynrB8fknSgDTVqagS9gCkJdFFQVya/FK+fCqMEcAtoB?=
 =?us-ascii?Q?yFLYPwFtbBdA/tGxUF4Uqu6qTWN8Rk4kIxcLjvYjL7hZ8wzMVeDB/M5IiCjO?=
 =?us-ascii?Q?Q4Lh2jcptPc984/R3NTCXdl/9zC9qXGIED67f86r1so+qTM9IgqXARKLs3zj?=
 =?us-ascii?Q?OoP1IOVBmZiHZSktMw3hqeVWhb6MSIfClKpJCOOcpmb66dep4wvDXDDgFWTr?=
 =?us-ascii?Q?aahZo0NK5Mm9znwQ+4zcETAbExTr0WuS3DCId+l9FsNbCx8pMMNWQXyiVECO?=
 =?us-ascii?Q?Hqo8d0PHJd47Vwaw83ucrA4lHKqFkK9tM/OKv7Q5FGmwd4W14wYkjFABO9rJ?=
 =?us-ascii?Q?ncYJRhD0VQc8GUkgG9YY74yYUEGe3T1YK/q9yM9Ct/4MBflWoZcxssuyliau?=
 =?us-ascii?Q?adIZ0qzrL5ZaWW+A2WhjaEhRkO/Mx5RE4EimWCPw4MXjLPlGruEf8/jZLwaa?=
 =?us-ascii?Q?G4WNRLEPv5N3N2GvELLx+cZdgb5Ntq8gEjPBaOtAMRN6wcCf6BifCev4/W3a?=
 =?us-ascii?Q?Y8R9CrMUw86r0unUOLtANv2QkQOgzfIJ4yNPthFTjaEhmC7EVXgXjRJEfRgz?=
 =?us-ascii?Q?nPJvfxiHg+MFus5+wIAkvsW8TlqHUiMWN6OV2gF7msPk+EBA21oUjqb3LhfD?=
 =?us-ascii?Q?Rk6jm4lKHUpY6d29tpyjkmO3/3mgpsPE9e96H4w9M77akRDuak4qjp8zj3Q1?=
 =?us-ascii?Q?UUqLv91mxWhhqIa6+KgVBGQuACxPCKRDnljtOHqCgQaIhJ+N7lL6WzfxjBb4?=
 =?us-ascii?Q?jBab2CO5nCMEZGD10Ggr7Z1LGJx5AWjZJRAqP/FYMo9WlnbCisU09jb3G6k5?=
 =?us-ascii?Q?NQHR1CV52NCqE0gbUZ5zcRFbPRbs+k2vC4DlxLzitquefxmw3pVnBdn/egmx?=
 =?us-ascii?Q?9S+N7C8eLoipYSbXzpjsIjYkCracr0mbh0Dzzt0HrXvt0BecsLZUGuyX3MsR?=
 =?us-ascii?Q?mmeYaWqlTmjX67J0O2eLeWxOBu7qieJDwW5iW4GFufg61I/MvDMouPnZNLDX?=
 =?us-ascii?Q?celyiKdnExblbDNwzhtoRQ6PoKOum+R/+LHB5oyaxmqRiQKOmQ0v7woLZ7jk?=
 =?us-ascii?Q?21qxwCP9q5gXiQjL0sALChkK0JtTRDc=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb830fc-4951-4295-be2c-08da376e48ed
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 19:00:03.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve9BB0eBvapQl3b3xsNAOnjS5Hbs93EJA4dwg4GxrcP+DiEtUM5whD2JjNzu9l7GQ+6jqw49X/GISszc5MmO/MBRrmRp6D41tpQ2a+6tML0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0548
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the imx thermal driver has a hardcoded critical temperature
value offset of 5 Celsius degrees from the actual SoC maximum
temperature.

This affects applications and systems designed to be working on this close
to the limit, but yet valid, temperature range.

Given that there is no single value that will fit all the use cases make
the critical trip point offset from the max temperature configurable
using a newly added trip_offset module parameter, passive trip point is
set to 5 Celsius degrees less than the critical. By default the
system behaves exactly as before.

Link: https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/thermal/imx_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..42d1f8a3eccb 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -86,6 +86,10 @@ enum imx_thermal_trip {
 #define TEMPMON_IMX6SX			2
 #define TEMPMON_IMX7D			3
 
+static int trip_offset = 5;
+module_param(trip_offset, int, 0444);
+MODULE_PARM_DESC(trip_offset, "Critical trip point offset from CPU max temp in Celsius degrees (default 5)");
+
 struct thermal_soc_data {
 	u32 version;
 
@@ -504,11 +508,11 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 	}
 
 	/*
-	 * Set the critical trip point at 5 °C under max
-	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
+	 * Set the critical trip point at 5 °C under max (changeable via module param)
+	 * Set the passive trip point at 5 °C under critical (changeable via sysfs)
 	 */
-	data->temp_critical = data->temp_max - (1000 * 5);
-	data->temp_passive = data->temp_max - (1000 * 10);
+	data->temp_critical = data->temp_max - (1000 * trip_offset);
+	data->temp_passive = data->temp_critical - (1000 * 5);
 }
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
-- 
2.25.1

