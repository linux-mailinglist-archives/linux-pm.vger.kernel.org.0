Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9052472B
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 09:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiELHmQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 12 May 2022 03:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiELHmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:42:15 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 00:42:14 PDT
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.109.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 192DA1957BD
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:42:13 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-40jpKO-MMu-chMy2HTa2Lg-2; Thu, 12 May 2022 09:36:03 +0200
X-MC-Unique: 40jpKO-MMu-chMy2HTa2Lg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0324.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 07:36:02 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 07:36:02 +0000
Date:   Thu, 12 May 2022 09:36:00 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
Message-ID: <20220512073600.GA36153@francesco-nb.int.toradex.com>
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
 <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
In-Reply-To: <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
X-ClientProxiedBy: MR2P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 679c45f3-3586-4c3d-3029-08da33ea1089
X-MS-TrafficTypeDiagnostic: GV0P278MB0324:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0324335B128774E7FDA005D3E2CB9@GV0P278MB0324.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: wK5+qcI6SzzYwmb3rDZVo0JmsTUPuEC3WJtM4ATOsZh3gDc+e/3Kfj97ifLh0/XqglKAxYq0pPn1R72sSYZaip755Zsq/ASVlXduVKOnlAcaa9iepb98Ohvu7Qhng6h/W44RqRJmA8X/8+Lp4E+kZyjqo3mbN6jVwfpiFpOPM054ob7MWUbSxGzUFI+Mp10mbyn27A96eEMZlhQOqPGf+QTjpR10rlCuyHVmzo2p25eJA8mKVlRdLQnkdMd0MNCkqtFhM4N+5dt91lt0+bfprvnBUdxXRDfAs5Qs8Mk9YbWlJh+cEL89wg6g56QPbb+gl5u7ts6Fgipdz+xWqv2cIMrs4eeU7EDD0HVBHV3UnfU20I4ROnNJAFMHERNg3j9fsB1H+FvDyub1XPBMjvb6l9y94IdS0LryYbHqJJosjDBU+9qvhuy2+ozDBLXltuoFvstf0i5lpDZuWOQl8G1wiodzZcbnn6i2jQUTWiAluQUoDTTPDOXSiKeWfDNU7UMztEIfq2HGE2HoveJYy9A0FNDtStpeHJrjpA9iw9sSKAjHSLf37/vjfiGETQe8JJYOB88qNvqp8x5p/abtyQgib2MggbJYNbKIVjr8K22tFMLUJ59iPh+8AL7O4NPmfJs7IvTK9/8umRHwdkJe6ZaR21ANabL7hbBxQ1FMLZ+wu3ZEuV4+rgreXrZDEC1n7GFhLINmFbC+vxdG0u/9SIOCUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(52116002)(66946007)(6486002)(53546011)(4326008)(508600001)(5660300002)(6506007)(8936002)(8676002)(86362001)(66556008)(38100700002)(38350700002)(33656002)(44832011)(2906002)(110136005)(66476007)(1076003)(316002)(6512007)(26005)(54906003)(186003)(83380400001)(7416002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQEQPQPU1CbwiragpgvbwmMVtZgeJLDlDx9RJhIU4yXYA98ZNTUwbOzAssop?=
 =?us-ascii?Q?LDjH7Xk/o6zJ2gRGDP9pC0GMAfB65Jkto0q4bJncsDaqFU+GwHTwswIi/FGY?=
 =?us-ascii?Q?pf0liUpS1TAiwF/LC/7UzdwngDrjHaqQCTRoeWfZYQmGK9m+SGZ0AMkkpfUc?=
 =?us-ascii?Q?EJJa/BiFmo7/J3HuuEzmR+XPe1x/iey/le7cB3ZhRMBb8xD6tjvnzrlxTHVZ?=
 =?us-ascii?Q?l1QHe73KRYVS3ZuSpx9QKTvNiRhb6fYF1rnSK7n+lkcUmpq34v5WXqKD6M02?=
 =?us-ascii?Q?5Lul85X8FW6W4pHO60ZL8m5r9eYVQN1UTcHtGS9aHkkUircWNfnC08YmV0ci?=
 =?us-ascii?Q?ux6F/+ycG9Zwg/c7VMEpaocg4vjSJyDKt3t2jHmpLbU7ftZcIw+o5IO49FJV?=
 =?us-ascii?Q?TzpyvK7qnz4vddL+8q56rVbeEqbHNX2CylRzzs5zS9/147F2SfY9wPYZXm/w?=
 =?us-ascii?Q?qKouJKmF4Yy0WDjnfOw6ST/BI6E49aZxUWK482Wh59DAUt5xmbmN4qweamLI?=
 =?us-ascii?Q?uGeNO9dcB5q8/GLc2P/aTTw0lPKV37ttip2xGUqsJTxcUvBMzUrgEqUz0ckr?=
 =?us-ascii?Q?M8QU+e8eRde2+drj2rUASzS2qKnnG1mfAvcXf0ttqelTjtl+5AzmPtcmoFDP?=
 =?us-ascii?Q?NUEH/x8NBZueDezGQSEZ+zAKHkFmRy7ONyUddMXbVf20jcLwXspB2NjQrpla?=
 =?us-ascii?Q?+vViZmrD8Qhe53rLr1SvuGlo9BxVeQGuGB9L8vRSvZ9LUdR7CHWh5LjZ6Jwd?=
 =?us-ascii?Q?mKIC7A4lMQeRzFa6w+WxFnrTJ1RKubkKsVLSvqXXijanUfhkSyqTfipccRa3?=
 =?us-ascii?Q?pmI9sUcdM7ryah4VrkiYpu1MOhuyABs9D9+AcdZ82Dnr80NIAy1pl+HaOzP4?=
 =?us-ascii?Q?5ApLuprIyEdyQ6V4sOjdM5Al0Sr1lVf3thnuLo8PssY9htLol38bj1vdg6ii?=
 =?us-ascii?Q?cBo5X6PCLKLDC8MQqfsg9L7RqCIEl0zP4NeOoz6N9iGt48AmRuydyi20JuOi?=
 =?us-ascii?Q?B5Hvrt468cEeb2sej+K54a9/kBWyhj9KHzZKKU7NiwBJTPTptsm47gX+/2YM?=
 =?us-ascii?Q?+e387Y3LtkVK7XaWHB4yrRra4HNs1YbJEU1mf+YE2iSDgX/C3fFd8fC6ctbc?=
 =?us-ascii?Q?sJUPCObxDv0+Inm5ON+ivp/jXtH9Tj5uiclPYNyck5bL3KTrAjMjmKEUpJlM?=
 =?us-ascii?Q?ibNctvFJLP2LdWgD/lCxpHItqvN/yBxBvCBD9uySsMbhJWDuzqjIzgATZyqE?=
 =?us-ascii?Q?+jR8T3UynbK92xc9GuBSXmPfghh6BC9A4r/eLciWGG/vE/GqpMf1OaT9HEy7?=
 =?us-ascii?Q?s9x8Qv04EsiFh95DlGNV8l6HG2bSawuiX+u2lHSqcWr7Fcl9l+axQKyBvQce?=
 =?us-ascii?Q?n6QdniHX78DRPqqx8BQ3Fz3+xJ4CsZZkMAqeEFA588WmvTRAlprjMxtTTPRi?=
 =?us-ascii?Q?HOUEcgeaZT/bTfT6OSb+NYnVP97vHqXGR4QT28NUAry7I9JRNZXT3/NXnG6B?=
 =?us-ascii?Q?GuoQjwXJcOus6t/PIvcdl8A9USvsur0NP8vFc+Lo9wIwQnSzWCpoR74tYecV?=
 =?us-ascii?Q?1IesBNDfcSgFPZQVUR/vNom7KNWY0ARQYnrBWOZ23clXqOdHHrZLUn+1eDc4?=
 =?us-ascii?Q?iMw5d/5d3FnQBNJvRouzizqRHsRKIV3mGWNM0ROzweQ2ATU4ph+l9hcnFGxM?=
 =?us-ascii?Q?Z95KVKxHTomORAqszx0rozoQSZRSwdi9JPWa6aGOHWpvR/Es+s9DSxBPkw3i?=
 =?us-ascii?Q?nXNVCngywNPBsHOkta+OcWhlGzaEa1I=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679c45f3-3586-4c3d-3029-08da33ea1089
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:36:01.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkAZ8eBC03x8XSlptpIO86zz3/vxbJitwReDEyM86uS06yhDMFEVO9ZxuIYvnJkMqd68BIbHljxDrQTb8YJL9bi7Y64mrdoXqIQvqo5eo4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0324
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Daniel, Sasha, Shawn and all

On Mon, May 09, 2022 at 11:55:20AM +0200, Daniel Lezcano wrote:
> On 20/04/2022 11:13, Francesco Dolcini wrote:
> > Increase the critical temperature threshold to the datasheet defined
> > value according to the temperature grade of the SoC, increasing the
> > actual critical temperature value of 5 degrees.
> > 
> > Without this change the emergency shutdown will trigger earlier then
> > required affecting applications that are expected to be working on this
> > close to the limit, but yet valid, temperature range.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > 
> > Not sure if there is an alternative to this patch, the critical threshold seems
> > to be read-only and it is not possible to just change it from user space that
> > would be my preferred solution.
> > 
> > According to the original discussion [1] the reasoning was the following:
> > 
> > On Tue, Jul 28, 2015 at 4:50 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> > > Yes - the purpose of lowering the critical threshold from the hardware
> > > default is to allow Linux to shutdown more cleanly.
> > 
> > But I do not understand it.
> 
> Shawn, Sascha ? any comment ?

Just one small addition, we (Toradex) are using this modified critical
threshold since quite some time, on multiple i.MX[67]* SOC, and we
regularly run stress tests on commercial/IT part on the whole
temperature working range (ambient temperature up to 85 degrees for IT
modules) in climate chambers and I'm not aware of any issue reported
because of that (indeed, it is the other way around, without this change
we had issues).

Francesco

