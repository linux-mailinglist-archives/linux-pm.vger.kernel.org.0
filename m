Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D95522E6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbiFTRqb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 20 Jun 2022 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiFTRq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 13:46:28 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E56891AD8C
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 10:46:26 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-ZfGwhLwONdKYA_NPEjONlA-2; Mon, 20 Jun 2022 19:46:24 +0200
X-MC-Unique: ZfGwhLwONdKYA_NPEjONlA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0340.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:32::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Mon, 20 Jun 2022 17:46:22 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 17:46:22 +0000
Date:   Mon, 20 Jun 2022 19:46:21 +0200
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
Message-ID: <20220620174621.GD23829@francesco-nb.int.toradex.com>
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
 <20220620154810.GB23829@francesco-nb.int.toradex.com>
 <9307a12a-4ccc-8349-9c8a-79b4bf66a190@linaro.org>
In-Reply-To: <9307a12a-4ccc-8349-9c8a-79b4bf66a190@linaro.org>
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06f3323b-4d86-476f-5360-08da52e4c9e8
X-MS-TrafficTypeDiagnostic: GV0P278MB0340:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0340B658CDFF7AB52F0FD29DE2B09@GV0P278MB0340.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: w4Y+ej0wFfSEyXwMQm+GuCG9pPSZxeMI464RzW/J8RvLGDogWdyJgOOFavsk15dsmYjsCX+MNDojOmnlB21/tCtq594nspV9CPayvYCVxoZqTKCq5WMXNlWQJh1lphpyh9kvRmP7d75JJO7qISje7icglRcRWYK15e9IzxwkMovQrkyg0ZiAqymVIcTS5Upz2jq4ncUsso2jJbpxy3VyC3Mz5tLbaseO4/7KthLMC2uNRm5FwKXiXqqfaWyTDg8tFyAQN2j9WzZn4rfUIe7BRMMSAP7lFgzotuRtfkvOMS53wsYxjtkodXhKb8Oj8L0QOuhvMaib0GOCaU30jW6lycLDpIURmYZhPL2iUODUvqu/enhZ0BU2YsYyti939tzR0esuX+RzAV4NkWUtZK4/r2hCmyoxKWXagefYWEXkhZGAC2B0cI8VoCMrWXdpU9uXn7gKYwyZ87jMFM1up+blVJzmU0UDzwj9wjaexl0iZvCmlhSv2rGOCliDiYvyiEB1YyKDGZXiogDssr7Cg3FsWyxG5Q5XWtiA7oKffb5GlijGzxOwL/ZUoH8MNmyb9FGLLAXLP/HOlqD0IkQheRSaEZ8uDhruqjdgo0SVmHqM6CrxtK4wl91Ss652EDhwa0bBz3CnIYM7eVFcCvH1SF3DXRHFdr2Nup+8ZGhbvmq7Ma0/IMVfBMOoLChcDYT0mJGvgap6VxZ86qeIEAH3ma8DqR8BAcGaLsDK24O7bnDNaYM5W8A5zbOw6cWeL4BU4nNcWnUJGhpuGe+LcjJSintTTyOT4ZcL1u2iLmtNgFp/nTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(86362001)(6512007)(26005)(38100700002)(66476007)(6486002)(38350700002)(6506007)(52116002)(41300700001)(186003)(1076003)(53546011)(8676002)(966005)(66946007)(66556008)(33656002)(8936002)(4744005)(5660300002)(44832011)(4326008)(2906002)(478600001)(54906003)(7416002)(6916009)(316002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwQtXbqatFe/PVKqMH+P6x15/DISufdSU134sj9jSv+sP6RedVU+BEYNdkSD?=
 =?us-ascii?Q?8Juxd/iWOOk6ZOZ4zDVJFx8SqtfpZVAPEvSBPrqIMZHk+4UEzinWe03n0Qoo?=
 =?us-ascii?Q?ryDg2In8UcC20ld4ZkLkcH8eXtRet0hGpUyXITWas/nDJaqY7ThSnN4PCQBW?=
 =?us-ascii?Q?aChMjNgJYLTDmzoABdSbx5fF/+IGQqzXMO9xuzlQRDVB0fM602O0loxbYvkT?=
 =?us-ascii?Q?44dAf0OLg5ORM+efiUHi7l57e5I2pagqN2HNi0BKZrE5NP+XS0tXWiksxlRC?=
 =?us-ascii?Q?48pHUVObLfoBpabpgaJDMmEtT7he6SZr3Yhr56C5TBaWzDQ1AxJDU+Rb37i9?=
 =?us-ascii?Q?z/jS9R9dymnNXFi/vZpm9yh1lqx0sIvhHaY/6+jLGWbG7OMOwMjmQrT+pOV8?=
 =?us-ascii?Q?zlB5onTcNIhjm0/7re2JeAG/BkuuPHscGYRdZzIAXMQbGtz8CV3EU12oCwSv?=
 =?us-ascii?Q?vxE4gcmmMQNudoMbS8xkTkoSR4bLGtnA5e2y66aimoHLcXx72zj+3dhf104X?=
 =?us-ascii?Q?CgGBwSoo4q31jsx5no3cDNTVL4MS3hVrTWebTeBt0YSqsTC74ERB3k94e3nU?=
 =?us-ascii?Q?abMNJPVVgIM3DRNpU9AtplEpRe5mjDIm0ZznjFLaVJ+wFAlURggy6txpJHrj?=
 =?us-ascii?Q?sCCQu2xClF5fh25g6JSayTCA8VE35D1PGlCoZ0OQvlG0/g88n3ruvs3MclGC?=
 =?us-ascii?Q?WUHwJN7o1iHAOA7XnYzEQowLsSYU80T6nPJJ+m6QL9Jq5i70Iuru00NzHxk3?=
 =?us-ascii?Q?B0JHlmZCCpjTHzzKk/Eq7IsoHcdlqSNedUJHHYAvEowsXnhWNmWs//2DXaCo?=
 =?us-ascii?Q?rpolJRQCmbFJRO0cnHeXa2uTIoXOV+iMShxdttJd+iJzKFLLKaWcmXJTltaN?=
 =?us-ascii?Q?1XWKFxmOTdIMJMkZgeuSqnrTug4/1bPih+ajNNXk3Q0Gtqe39mxA0lD+eu8B?=
 =?us-ascii?Q?uVvbKg2KwRRiMjnvWoWoXTJKzb6aGWCWPYEqcwFKDhP63PhruJ6tFuiC5jkm?=
 =?us-ascii?Q?ENktaEiFoUMWZ4VkDdkcH5Ca6OiHUjy4RKHCh0a3E86p8v9vGwPWw3aQVzId?=
 =?us-ascii?Q?0snHDGWbqiGOoaRCbAIFDZ2y3Cq1u/1/3m9YfhXqZs95dKHEqAFyLldWTJOT?=
 =?us-ascii?Q?lYJYibIvtbciD8FpGWw3vVDr84BEf3v8jBSV9b9Kfesa484WwYveHM5436Qm?=
 =?us-ascii?Q?eQu6/xc90sWwV7N6ERmlQNdZt2tKu74pqHv79ZsNmkhSGOCL8QWMpQopyCQT?=
 =?us-ascii?Q?YQXTllPKcyyHAL3vt7+n96qk9B5PkReLKEyF1hITa6v1MGXToNPzR/gyHv84?=
 =?us-ascii?Q?L+a9qZYv8lqAqIgrQ8HT3PjsQ/2SYnE4LQBLtqHp046CIe3na3MF8zo2KjkU?=
 =?us-ascii?Q?j4FW7ySnG6uEalCEVyismtqdzICL7xz5S1ZwbCMyJ3l6trJ/Y6hx7i5iwZND?=
 =?us-ascii?Q?WLA/f85VVSi0yJ2SRvHyCJ7oimEoFez9Ibpnnz+T+9aOyvpzmm/MDj0h0vSC?=
 =?us-ascii?Q?N93HBWuwFARMf3tLlkPoX/E0XfgtJHckaHb+OELqF9HYNzddlq1MDWlmEuDy?=
 =?us-ascii?Q?5CEWWwzbnsbB6FoLW+sRBXjEXzgNDBdxMlN6//HPHzOwdoDmv3oV7sSfgWdb?=
 =?us-ascii?Q?44QuiSEyXZX+fGiigj9MUuQTuqzLpCU9QOraiEgt8Az2A9nk0xegof7yfJI4?=
 =?us-ascii?Q?aHAH+o4SW95hi0LcbIzk0jrCQ+DdS77uMCB69Ij531Dp7nr9Rm7xsdYTu7cd?=
 =?us-ascii?Q?qFjx4XQUOLyrony2xKpP5zEM9dn1OW8KaLvjHrevCp11Gw+I80KF?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f3323b-4d86-476f-5360-08da52e4c9e8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 17:46:22.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnQi72Zd/mHf2ByPCzzd3ptVuSANuL1iOAyWZrXKY06UuFmyW/jdp2bXIXQ9WgHHBe7Ro+3a5X3tM7oWBWMWF1PxBXKk14uAooH5pn3b+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0340
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

On Mon, Jun 20, 2022 at 06:45:41PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 17:48, Francesco Dolcini wrote:
> > Lucas, are you really that against the simple working solution I
> > proposed initially [1]? I feel like I am running in circles ...
> 
> BTW, the link [1] was missing in your email, so I understood that you
> meant this patchset. If [1] refers to something else, then we need to
> discuss that something else.

We misunderstood each other, this is what I meant:

> 1- just increase the threshold to the actual max value allowed according
>    to the SoC thermal grade.
>
>    As easy as
>
> -     data->temp_critical = data->temp_max - (1000 * 5);
> +     data->temp_critical = data->temp_max;
>
>    in drivers/thermal/imx_thermal.c
>
>    https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
>
>    It was not considered good enough by Lucas since this is a overall
>    system design question, therefore should be configurable.

Francesco

