Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988A57AE7F8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjIZI02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZI01 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 04:26:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2237.outbound.protection.outlook.com [52.100.158.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CB97
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 01:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSCpc8NtEg4mozbQk3JqEdpd2AQEOSE78433t3j0DmB9RyysSxhtx9JN0DkoUjV1rIFscGDmWJI11g38RVzQdtbLTtAhdGT14Gmby05CjRP1BflFy8G2+THj3jOaf3YPCAVM3DbpHViGNNN/lEbaMZv/4DgK1QRHxjcX8PcwpjL9TfGu/HWI0K6+P6+4e7W9/LDW7LOdb3BDgJJmVrwE1AiCs4UIDqZWghhwfbx/2Rx3HTbdRHNhduH5Kelp48CuxbX9e+OLsUV17vxySbFtf/JGccTbdnJL0+tz21R5nWuPoKCnhRjsLAiuTqbqN7PYiPRq38RcAxcFcQj7lH0lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsFHH7YYdWXG1Msl+/FCexAK+oxSf8zRsSqYE6ON36Q=;
 b=hH1ruxjQkLWOuvPVMX/ArytgB6Kgd7btJSv7tfUIdizoTKzA97DE8t39lyFtPLJdXuO/IG4o74eKh2Hqr5ejhBxQNZ8UGxfy4EiqKQleBEDKPJUVkKjU9YyOPuk7EvhYWJpr8fTVoD/dh9NWXwXuF2pewXEtvipilzwtKvs6H7CG9ZqDxKOgK9134MsaHwQVHJ8JNujubMiEEofgRoYVayB6T+ACqBblveGqCuMJIhtmjUEfZimn8JPXj+4LTtnQdSbmvuXvsmJZe9W/uThOkP6IMBFcAMY+rHTGPgVJQZTHK9CAlERxoSKEXwR9dxrVvXO97zBLwVg5L0ZTko2IjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 201.217.50.26) smtp.rcpttodomain=visitsmokies.org smtp.mailfrom=ips.gov.py;
 dmarc=bestguesspass action=none header.from=ips.gov.py; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipspy.onmicrosoft.com;
 s=selector2-ipspy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsFHH7YYdWXG1Msl+/FCexAK+oxSf8zRsSqYE6ON36Q=;
 b=KzCqHTSlGkk55KqpJ+Y0QPgT+udl65+cVBklU1Zj5J/9Qr1Zboxst9X8xIcvbB1ZkWsHfpF8TF87sjBUzHbMP59DRS6prkLfH512odhXw0ThWThBbw/17mOSBachbfj/VYjlYbBfPhViUmj2vyx5d3m1jgmlyrCkxkyGh+Vfkzw=
Received: from CY5PR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:1c::34)
 by SCYP152MB7503.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 08:26:06 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::ca) by CY5PR10CA0015.outlook.office365.com
 (2603:10b6:930:1c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 08:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 201.217.50.26)
 smtp.mailfrom=ips.gov.py; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=ips.gov.py;
Received-SPF: Pass (protection.outlook.com: domain of ips.gov.py designates
 201.217.50.26 as permitted sender) receiver=protection.outlook.com;
 client-ip=201.217.50.26; helo=mail.ips.gov.py; pr=C
Received: from mail.ips.gov.py (201.217.50.26) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6838.19 via Frontend Transport; Tue, 26 Sep 2023 08:26:04 +0000
Received: from VS-W12-EXCH-01.ips.intranet.local (10.20.11.161) by
 vs-w12-exch-02.ips.intranet.local (10.20.11.162) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 26 Sep 2023 04:26:02 -0400
Received: from VS-W12-EXCH-01.ips.intranet.local ([::1]) by
 vs-w12-exch-01.ips.intranet.local ([fe80::2125:f531:e7fd:b415%14]) with mapi
 id 15.00.1497.048; Tue, 26 Sep 2023 04:26:02 -0400
From:   =?iso-8859-1?Q?Milagros_Maria_Belen_Ferreira_Mi=F1o?= 
        <mmbferre@ips.gov.py>
Subject: Hello
Thread-Topic: Hello
Thread-Index: AQHZ8FKx8jJAxfJrH0efveQ1cw+50w==
Date:   Tue, 26 Sep 2023 08:26:02 +0000
Message-ID: <1695716742712.90760@ips.gov.py>
Accept-Language: es-PY, en-US
Content-Language: es-PY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [64.62.219.57]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SCYP152MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f413184-659e-4217-1df2-08dbbe6a3a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uTjjkyW9WExYS7QeU/7Rxc84l0bOyg7R/ILShKppIbdijbMaMeTAErzSjF?=
 =?iso-8859-1?Q?8+Zigp6BIqTtkpKQHe77GbMHyYPExyAWFqk5CvNi+N3EP6HPYrTGCQLKq+?=
 =?iso-8859-1?Q?HZdHKNXP7Ji+pxwkLJWvpg38Ff0GDqmrAn9j4REy6K4JambpaRNlepZNOy?=
 =?iso-8859-1?Q?JgvtPK1G9Kp3+pHdTcRgazROfG4lLWK9zkXJeDLj3UMS0V1fhHmneoUw6d?=
 =?iso-8859-1?Q?1qSgBAXjOAlghdOMUdxZ8Ux3muhsgL56FE1/8fYrPEQg2vq8QK1UhaOW05?=
 =?iso-8859-1?Q?GdjYD9JdgbaEv1BS9NY9o6eXIdSwtFOVURCKv7HsrCe0RQj6JC/R/FnssA?=
 =?iso-8859-1?Q?3ClAKDZx6B33kSfq5FFjaqYiPgR9iWVOxtgb6V8LMYBchbBHOrGO57IxUO?=
 =?iso-8859-1?Q?xj5Bph2hZlWK95ZaY+nZee3KRxZTO2mK0A/zOiX9z3wXXCInCGYcfFKkK1?=
 =?iso-8859-1?Q?nNDG4RbNd0FL1G/sGAZYULpwrSyuOCbv98G8HDheMXHIMJRYXXWg+IPV1X?=
 =?iso-8859-1?Q?yH448hqVN1x7zBy6JfavVZe1piVOhgf7fRviCilrbvJs6rTrB0WEspOu7v?=
 =?iso-8859-1?Q?qKETI3f0ukJ33KemVuKwUKcSdiy7n70VRU/+0+NsqaBT3i+4kiS4ircahO?=
 =?iso-8859-1?Q?hIoRXj6LnF+UEhjch6NlA7xq2D8b1bwivgj1o1y7X3KSAIpNW3OkN9LUHN?=
 =?iso-8859-1?Q?HCgPG0UrIjDjQpEeUGpkiLw2LoE8R4Ft6qiArB4DmZO94CcHuM+hqoLPFm?=
 =?iso-8859-1?Q?Jxx9nEklOX0FSLztZGOJB+zCepCxj7ewHUDsniLVAyKL0d5DmF/IcGb9tX?=
 =?iso-8859-1?Q?BQ/TrgfHYKQRlqXBUtbE+Yd/4L/C/PhI6T5VYrGVyzDk5CnTQCrvhQCF44?=
 =?iso-8859-1?Q?L503JvgGGmoMeSPc1Vuj12cNcBjcJULViNeBEPICw5CIMpEydjoyCE7Rmf?=
 =?iso-8859-1?Q?P3uxyxlTPQaKrdb+1AUKOqH2znWaS46ZrwyLVVw3R4/slTqR6ywOAkWX00?=
 =?iso-8859-1?Q?ELMb+wLWzlfvvBFYVy4pwE6cCGjiE0IeEpbOWeYGmM3qWjpKS0F4M2YdTl?=
 =?iso-8859-1?Q?+4kRW695bsn8ppC+tiUcmElDHzho4cWCERWM3S571lWZrgJKsPGqCfYGX+?=
 =?iso-8859-1?Q?G3OBjh2JM4k1f8TuC2g0mEgiGNM0QD77IJzLxNXs3A4OaLJgoNqRnS7Rle?=
 =?iso-8859-1?Q?R7zaGOm5bcP5GQetJ1qDeyrp6YoBGCjDHU4=3D?=
X-Forefront-Antispam-Report: CIP:201.217.50.26;CTRY:PY;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:mail.ips.gov.py;PTR:mail.ips.gov.py;CAT:OSPM;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(109986022)(40470700004)(36840700001)(46966006)(40460700003)(336012)(5660300002)(7276002)(4744005)(7366002)(7406005)(7416002)(356005)(2906002)(8676002)(316002)(40480700001)(41300700001)(8936002)(36756003)(7116003)(70206006)(7336002)(2616005)(7596003)(86362001)(82740400003)(70586007)(26005)(478600001)(47076005)(36860700001)(3480700007)(2750700028);DIR:OUT;SFP:1501;
X-OriginatorOrg: ips.gov.py
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 08:26:04.9020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f413184-659e-4217-1df2-08dbbe6a3a16
X-MS-Exchange-CrossTenant-Id: 601d630b-0433-4b64-9f43-f0b9b1dcab7f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=601d630b-0433-4b64-9f43-f0b9b1dcab7f;Ip=[201.217.50.26];Helo=[mail.ips.gov.py]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYP152MB7503
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

I am interested in investing in your business as a silent investor. I belie=
ve that our businesses could be mutually beneficial - I could provide the c=
apital you need to grow, and in return, you could provide me with a stable =
investment.

If you are interested in exploring this further, I would be happy to arrang=
e a meeting to discuss the details further...(li139155@gmail.com)

I await your response.
Personal Email: li139155@gmail.com?
Thank you for your time,???

?

?

?

