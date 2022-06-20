Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38115523BF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiFTSTy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 20 Jun 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiFTSTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 14:19:53 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36EBB1DA67
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 11:19:51 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-JEro624tP7e9hNgQmSR-ow-2; Mon, 20 Jun 2022 20:19:49 +0200
X-MC-Unique: JEro624tP7e9hNgQmSR-ow-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0331.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 18:19:47 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 18:19:47 +0000
Date:   Mon, 20 Jun 2022 20:19:44 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        l.stach@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Message-ID: <20220620181944.GA34760@francesco-nb.int.toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
 <20220620154810.GB23829@francesco-nb.int.toradex.com>
 <66ba39e3-5462-59c7-3831-20ba3ceed43b@linaro.org>
 <20220620174323.GC23829@francesco-nb.int.toradex.com>
 <54971435-aa26-acbf-7539-8484ee7e6b99@linaro.org>
In-Reply-To: <54971435-aa26-acbf-7539-8484ee7e6b99@linaro.org>
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c50e51-a8fa-4092-d823-08da52e9750f
X-MS-TrafficTypeDiagnostic: ZR0P278MB0331:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0331F64A5C28B14FB8AB9657E2B09@ZR0P278MB0331.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: VhuzH/Gy7RpYdIlNSXq7vE+8jSbx2CjQMhjwheEiKQ8CG+E5AaOMf8UmANTLmwp27Y0ado5rN8y2sX9pV6cfrvyv08Y8OglHKAr6CJLGbZfvCod9G/RUDEmoRT2zdreGbEK8CzSoFrnc7EDic75AnwJroyOpQASn0roVfg2wzCUAQtdJdiNxnrp4LeukCk06LTDw1mnZvnSTgSffYALZQOmtiD0fGePskTVK3DKonXkXXAHlUw7AGDfpv3Pr9k9QF0qSCcODUUVg6k6jjPAJp91upaBljrFuDAC/Su0lNPte9N1Y+NmleJJxbBeId5buw7JJHdVx4o9BImG8n5vgi8hK6bHCeafVukGbctp+t2hT4/it1LFpSG2sJpisi6VQW3qv7dfGf0Kbv2X0pWvrNAnPepAakBQp9InTfbzr70u3c+GN3Ny63aQYl7c98Npz9DeLrHndYKB/HkTg/oXdSf8ffYY6X0Q+NC//y7KwC46umeubnpWVCxDwcgq5tu4Cn71zomec/2ODEwnfldHpgwISMwbYtncg+2VBGbXhC0wClSoE4PCjkfObwDJshVSOiOkJqGewLzxEmAQeMvk2ERP/nr2AS9FV+JfyzcPlAXbU6iv21dm+lZwMpZj29i4NyCJqTWO1SGSUb/+0XYLyPdh+Kp057h6/K6tb0RUCIKdgW+T+mS3U4zi0/aWdNth57i/skm3zBwH4qX5vBeQGSezSMtGefckk1RqbYqkJ34cRd4wfLpMN2xULrqWRjaoCOe7WUFkKgeOxb8AzaulxF3eBLaJxvJ1wgrSu40quFvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(396003)(346002)(136003)(376002)(366004)(1076003)(53546011)(186003)(33656002)(6506007)(38350700002)(52116002)(26005)(6666004)(6512007)(41300700001)(38100700002)(86362001)(8676002)(966005)(8936002)(54906003)(6486002)(478600001)(44832011)(7416002)(316002)(66946007)(2906002)(66476007)(66556008)(5660300002)(6916009)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0NGf4IChnO9DKsdvJN39BIX7yV11XvmXgQU7xq1UFNmjEX8AWWOtXMjADJCk?=
 =?us-ascii?Q?Bpg4UsD4Hj/dfuki4nG0XgqOZSIkzq+EmEO/vjynHci4T1y8jn57Fb8/Ntnp?=
 =?us-ascii?Q?94E8vIRXaQh978q/n8BJHbAxvfPw2ZFpLoz2FYwA+jiCGMkzJOUFv632EhOv?=
 =?us-ascii?Q?okS76PWEfdZMHIMtmL8MEDl8XwQSbk+tYwhxAUMtmazVPFB7klGBmFY/yxqg?=
 =?us-ascii?Q?brGcFSlcB95YJdxWzq0HyStNOQ8IUhPxlQvT5myvPwselHqxSitt/Qtkmytt?=
 =?us-ascii?Q?7+oxDItygE8pdGQr8gprt4ZBPchUAdVEjYNxratvzvgBYeAVpT8Iuf87moc3?=
 =?us-ascii?Q?TjMC+ETDNibva2wT/3+PJWWpDWQFrpcnBkfLHhK3qZTHhU7BZRXOPC2Wc3OZ?=
 =?us-ascii?Q?uM0FEh1xjEve8E/pOKd5O2d6Q6VLMH5GXI9HiWk96h6t+l7SuJLvkbR5vxWq?=
 =?us-ascii?Q?gBd9uIrAqSR/LSDyzvoPhvJctGrm6kODVK8tAscYb6RUHdakb1RzkKKZghe5?=
 =?us-ascii?Q?3eKWKHl3FivvXRajTJT6uuxCzmTeaA50jaes3DbWzPr5ojV614o30Nefic3e?=
 =?us-ascii?Q?USBOkPtfzlOf11sD2J2B0vLipdG404Yp+kCpIBuLAA04vVk07KF9mrNewQRb?=
 =?us-ascii?Q?XVHNp6dllZoyj21Xt9G8AaBKG0P4cT1tsmTba+ZZqSK90ZW2vQQnaw8kLm5R?=
 =?us-ascii?Q?DTW0aV7nFC9gbOMmfcDDxXoTpf2Qg7e3KMMww8VCQEwQ1k5fOtNZ+EiSUlFI?=
 =?us-ascii?Q?5ZGk3cUjZ6rm+eZMfqqc4nCapdkfaB9X/99pvxp4WL9yY5shOPP1MXeOCEGR?=
 =?us-ascii?Q?T6DFRRAt93NZBhggpXaHXQxhSYvG5Pubc+A/5/WWMqF9n+ccB0Q8jgSC545V?=
 =?us-ascii?Q?+1qZLEVevVRLarhCsWAx3p98xIkmCKDgL96/p7oLK7VH5G5Vim6YvK8A0SpX?=
 =?us-ascii?Q?tdmywnCiz2sMstiyq4uYuVnz1pvyU0rcuUPV2cVpKVCNGnVik4hMRMJcSTVg?=
 =?us-ascii?Q?wBV7ob1IcyBmEjXF73Ehfkd07DkdMmlgeGQUmZpkSsdDMrMUe1fhqS91bxHe?=
 =?us-ascii?Q?TxE8eQfztgJNVh8C1t6luUTCpdtSeoX6nCvvEqW8x5BUqcbUcZSZHyLCO4xl?=
 =?us-ascii?Q?epG6zxpRp1iGttx+JevqeK5q/k7guY1ZEcaqU98qDRsHkoOdqfWdwpkX6bKG?=
 =?us-ascii?Q?KNDNEee9sgYVV9AwxQv1STrgYqqN3ra8r1NumcIGmgJERCaWUnfHEHsDkFiK?=
 =?us-ascii?Q?eTQvW99MuzYK1yDAiJYDG2d64e9CwhCkYK9Ydq90ccQ9TuK9SsbevwysZERf?=
 =?us-ascii?Q?RAxRM0bN+CsvEEOOWAYVTd/XToBBESjoeGhvRudDQkm7vDHdfEx7FDb/6nI0?=
 =?us-ascii?Q?7tpG/HEl/y0Zama0is7CYu4Mc30Z0aES9mnXPNchmWQ6+0ZBMqciLOK4Brpt?=
 =?us-ascii?Q?ERnJIbZz0fL9Apzv5jhbjcFynkZWPxLDgpvLFl0i6lhhYW0r2vpkdGMpbi5t?=
 =?us-ascii?Q?QrBjGnG74oAuC3V1PVBPfh9rVGiW726RtHozbaPAbHM2faVGXzRj6CVZuz3Y?=
 =?us-ascii?Q?v96vuhvPmjrHqZqZw8lZgcD5w+lrU5+hkHdnM5LKZN2Kl10q1+2QYYJheeHz?=
 =?us-ascii?Q?pBg+8duUx+FbtuikGu0ubZ4RuJk8A5a5vnWFTwBFOuGgkGHltTRv4xkMGtaF?=
 =?us-ascii?Q?9+qtOPOitodwqG4qkcSFnVzT+uJCOWryuIxuao/CzcaNBepH8JJGCnwsKxI0?=
 =?us-ascii?Q?trgSHVLS+1YkSThwwp03Geb3oFQURG7xZedxSRY0eXhf9tzI6s+8?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c50e51-a8fa-4092-d823-08da52e9750f
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 18:19:47.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmPUgayWVCozJ0qTD2sdQwxEszDrVK7Qp6av2jPI7fBfV+z7br2C8nd4/zCc27j2Vxij4SLaCBJA++TooQfYis1dDSBPRUd5oDPFs2i5Ma4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0331
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Krzysztof,
thanks for the discussion and the review.

On Mon, Jun 20, 2022 at 08:05:48PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 19:43, Francesco Dolcini wrote:
> > On Mon, Jun 20, 2022 at 06:44:23PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/06/2022 17:48, Francesco Dolcini wrote:
> >>> Ideally one could just implement the imx6/7 thermal sensor reading and
> >>> just make use of the thermal_of driver, however that would break
> >>> compatibility with a lot of existing system ... to me this is just a
> >>> no-go.
> >>
> >> This I did not understand...  What is not implemented in thermal sensor
> >> which would solve the issue? And why it cannot be implemented in
> >> backwards compatible way?
> > 
> > Currently the imx_thermal driver defines its own trip points. How would
> > you change the code to work with old device tree binaries using the
> > generic thermal_of driver? imx_thermal would need to be changed to be a
> > thermal sensor device, all the thermal trip point code removed.
> > The driver is using thermal_zone_device_register().
> > 
> > Maybe I am missing an obvious solution, just correct me if I am wrong.
> 
> Probably you would need to support both solutions in the same driver,
> based on presence of thermal-sensor-cells property. It won't be
> particularly easy code, but maybe it is worth anyway... I am quite
> surprised to see that IMX thermal driver does not use generic framework
> and does not support generic bindings.

#thermal-sensor-cells is already present in all dtsi using the
imx_thermal driver without reason (see my previous comment on the
topic [0]).

From my point of view the situation is somehow a mess, not sure how to
proceed to be honest.

Francesco

[0] https://lore.kernel.org/all/acbf8ed3-0b8c-a0b2-88ef-7b13ad0908d5@linaro.org/

