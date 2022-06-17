Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3BB54F21A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380196AbiFQHme convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Jun 2022 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380672AbiFQHma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:42:30 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0CA0674F3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 00:42:26 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-g4kewGHkPeWT8yuGp0Q8qw-2; Fri, 17 Jun 2022 09:42:24 +0200
X-MC-Unique: g4kewGHkPeWT8yuGp0Q8qw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0528.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Fri, 17 Jun 2022 07:42:21 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:42:21 +0000
Date:   Fri, 17 Jun 2022 09:42:20 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Message-ID: <20220617074220.GA187629@francesco-nb.int.toradex.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
X-ClientProxiedBy: MRXP264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::13) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 125c48ef-8308-48d8-3682-08da5034e9c0
X-MS-TrafficTypeDiagnostic: ZRAP278MB0528:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0528D67B15A2DA9B81D7FB68E2AF9@ZRAP278MB0528.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 5SPVsncOr9sZAjDV19z6B0Vs1MaW3t3RpgRGkuD1EEoLUOj/tViDiWKCevJ+8eFHePblauSnSufBWvqFkYlpb6OtNKLBovH02WaiAIhsgQC2QV3PQ1dnU+Uxcs6xr4sxgFkh3ekAvbqVacpZkh2so5o1U5Pux+1xNuAAcmPZxx6+VJ9amC1MmAggisok2VVGawa4ZpAcdFw7+wV7O9BE5O0q6vN++NBl68E9SmB+07ALEpirj5p82CAbInsSUa69NIDVwtgTd14+j79MQBvNnICbu/IsZDFgGdPsUpr/uPEAXejXyg3aYzZV4/fjYMSgq9MscybLsBrguAp1k47Y2nUCg6GJEu3Ij3lhcSl+SQ2kYwBFCPb1lB1ErAdKW2fH09yWr+6mZe2ujarmABPsBIAQ24BCdC3jShBqVkzlAGVREfDiVkL64gYW/BZXi7288WEREUoZyoA3vwqLkNYXDiuImbguDtS93r29UBIFDYuQUGHdQS+9fi5EA7dd4J4A15CQj+LzQB8Gsz1VCjr62Z5kylnLzOAf6q0SS0Y5tGUljGCg79s/Sv0VqaOvg8vC0Q343dxJgjyYXIvIyYdf+t/9M/Op2zrdiaShpssm2n4ffD8N7SDqxy70Zjb3FbI4cHqGNHqKngn9uu2ojmjAjV4hd0siMTwMbvDIK+EnInneKW5oKdGYpa4eORqkiYzqqWbhEyEtvXcc3k9pFoLknwUY1c7X0Fep2zi7wS21jK+GR1XDbM+S0I1e9BGop+LrgOPVTD+81/ETFhBQbtXMhr49x0oz8k48SYQ1/cwLifc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39850400004)(366004)(41300700001)(26005)(1076003)(54906003)(6506007)(52116002)(6512007)(66476007)(86362001)(66556008)(66946007)(7416002)(186003)(6916009)(966005)(6486002)(38100700002)(38350700002)(5660300002)(8936002)(316002)(508600001)(2906002)(33656002)(4326008)(8676002)(44832011);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MoNTHdt+kHlw3txQTTEjIlhBTBuwwj44waGBwYMqw+o/ji1mJBs612uEX+zR?=
 =?us-ascii?Q?yZzIkM1dF1Dlv1wtDaX7JOatlcygKr4S6jtg0yJBNQrJvKO/BfCrhXc0HkFB?=
 =?us-ascii?Q?6L95EzLE322vXHzSBe4Ztdfi7+WYmLx/WquewxlSupF+uMrHYAAIZfVlSjRM?=
 =?us-ascii?Q?XybTodpMLuI/3a+d2GyMMPPyD4gEUfHWZdVdVbZbPm6nrP+4JeSRazGo+Jl3?=
 =?us-ascii?Q?n74xvos0c+scVEyeuYl7yJom91e3yes0VRGjMQH5w6LBfrcRzyJUQOcIru4z?=
 =?us-ascii?Q?8tuwvOCTaOACfxvLyso0tQdlcYYGCs4l9bEBxHkFgWvyWA8irGb8vSbJACsG?=
 =?us-ascii?Q?aQeJhLgHdlOqz4e5mKQun0cE9oLjR88bK2QpnjVeTk52P4idBpSfss8gst96?=
 =?us-ascii?Q?WmblC/1jg0nUahg38Zo3YrEC4xFnCZyv7IWu/QSEQa4TLBkmdwGXD91L46wu?=
 =?us-ascii?Q?5seVYpcCGeg8UTjSRhXcuAqNS4pJUPj8yy2IpGv0VR5nYRVsH8BKmZHYqoZr?=
 =?us-ascii?Q?9KYSdOsmvAzAosojko6nBdNNqNis7iua64XCQBU4TOE3k43755Azo8lywX7R?=
 =?us-ascii?Q?V8mGgHOfSIJPC2OcsGtpmSYyuA1CO4oJxMyUFxW/Apc7YBIBETAX/gJAP6sf?=
 =?us-ascii?Q?mFev//87B/ml1RmA1klUK3fHQm0lOewGcyTtITMjFiYNR+heHVLMpFrL7yJp?=
 =?us-ascii?Q?NU9lD7+CdmTpnWGrPo8FMVryAtybkADCqDaGIWMqRPCVcSkkNqdQ/BtUNNyd?=
 =?us-ascii?Q?8/mpLI5V4iLdi+OToyTqtF6h5HXphSnkkNK0UJaJhi09mnjefB4Wj4GNs7/c?=
 =?us-ascii?Q?1rWz1+CgWyyzqbIYuA/RVpEgYm2wL3oyd2kN60a+JhPp72SufgiiHoJlXf+y?=
 =?us-ascii?Q?RY8SHR//lYvg10yJZVd+aNfe1nat12Xb3GXBExI+l2muDs1/WR7ReFCVEwxz?=
 =?us-ascii?Q?4ZR519GMlKG1ydg7hXA3A7R6s51tL8+Nl/VcY4Uqf+3Yh/yuXb1JRUau8ajx?=
 =?us-ascii?Q?2gjHH9XV20wmT/p4DH6droSol3nr4lSNALEeRfY0ZUOby7LlOFs5dLWZIJoa?=
 =?us-ascii?Q?0HnSji99NgAjTKGNLgoSXTI0GAYwLHcRKfs1qyObYCO8DAFZ7XcnWJ+VHQ79?=
 =?us-ascii?Q?jBbGtmyvxUMwVr1A0wfJsxcGTMBS7aAKVlZSHq4YrdkaWX43ywcqGFQ+VfeJ?=
 =?us-ascii?Q?1KtOwvbZXGV3fqvH+2LGZdpa2DDazsNOzBFydVYXoYhmkJERw3o5AZ/+wNmB?=
 =?us-ascii?Q?lTn1/xvZMJA7DNMhzb0bXHDgM6btUCMqyOa8C35mdsmz6kZDY85pA/Eot5TW?=
 =?us-ascii?Q?7O7MKZZQ3C0xOmyTeL7iLU2hoTmI9P+xyV3RjPhQTsrwsb1PGBLpu7uAziqp?=
 =?us-ascii?Q?4s5Q8N3/YmvzxhxKD/kmrsEvYszIx242xsthkBVN8URfa9tNbM6CZjep6AP+?=
 =?us-ascii?Q?XgJQ9z8G0LKBd6FMBVA/8Tid0AwpKCt95684Sh6xmXvoEIzcby/K6EfDqsls?=
 =?us-ascii?Q?z1tNmgP+RZpKL5lmqk1OP1kwt9RzYywe4ZXIL0ANywhKKdg0qqee+ttNECGO?=
 =?us-ascii?Q?c0WuA8+0Z9CAsiiDJDu+E8sJN9McsgR08BayzRObVHtoKN21cOy4Xq/ZG1P8?=
 =?us-ascii?Q?U8eyAzTs47CMxUF+kALKG0amF0XLyoVXd0xponQ31xEYTM5/7oobrepCwIgs?=
 =?us-ascii?Q?IlDsIFnTjR5EoByhm6rDD8OLakglyt1SXZy3LHN2hm+s80FYR2U18qq7unKC?=
 =?us-ascii?Q?r8WbTpwDJRN474DdbbYTwALk6JqanyI=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125c48ef-8308-48d8-3682-08da5034e9c0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 07:42:21.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI4l14FG61vF5Y1eBeOhPcPvBRoyPRw+S4dNkzUA+PTR/QRmTqynePj3TDmpdxK5rGSofQhRNxMmpwNPJdqUqT47uXdEtaJok8KeonF43nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0528
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

Hello Jacky,

On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
> > Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point configuration
> > from DT
> > 
> > This series allows to specify the imx thermal drivers trip point from the device
> > tree, without this change the threshold are hard-coded and this might not be
> > correct given the thermal design of the final system.
> > 
> 
> The threshold is set dynamically based on the part market temp grade.
> I am little confused why need to specify it in DT?  I saw in 'PATCH
> 5/9', you provide a threshold table based temp grade, why not use the
> threshold from ' imx_init_temp_grade'?

The problem with the existing temperature thresholds is that they are
hard-coded into the driver, there is no way to change those to match the
actual final system thermal design.

After various discussions [1][2] with Marco, Daniel and Lucas it was agreed
that the actual trip is indeed a system property and therefore should be
described in the device tree. This series make it possible in a
backward compatible way, this new possibility is than used to override the
threshold in some system-specific dts (see patches 6,7,8 and 9).

Francesco

[1] https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
[2] https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/

