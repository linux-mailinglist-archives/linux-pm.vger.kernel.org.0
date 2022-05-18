Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B713C52B722
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiERJt2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 18 May 2022 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiERJt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 05:49:26 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 888B5205FF
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 02:49:22 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-FKi84VVSMZKG175RNmbOoQ-2; Wed, 18 May 2022 11:49:19 +0200
X-MC-Unique: FKi84VVSMZKG175RNmbOoQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0188.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:32::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 09:49:17 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 09:49:17 +0000
Date:   Wed, 18 May 2022 11:49:16 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        l.stach@pengutronix.de, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Message-ID: <20220518094916.GA27037@francesco-nb.int.toradex.com>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
In-Reply-To: <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
X-ClientProxiedBy: MRXP264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::26) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0e4f53e-e265-46fe-2676-08da38b3ac96
X-MS-TrafficTypeDiagnostic: ZR0P278MB0188:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0188E940587A35D428D2529AE2D19@ZR0P278MB0188.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: KHER2MJ9b4WWhAQyulNAAuiOPXgAM9/py6DOIRI9N0afwc328OaBoo+HViWB+fuDHoQCqXgYC7lPnAUnFMfnxtve5Z+M9YfnCi9Cvd8vsyti4iuCKNXQjXQt7warAAG06v3jLgV2G9bZ8L6kA3Iu9vXhiR7jmKq8Jiw18SBaieB6rcGzOU4nGjW8U138PnRhsVidYqvu7wdwMiR4Mopeu9VinmZOec/b2z/4uMJvu1rbCddH5+27yAxCHHJ8HOABK75h9bifETvQFrzYZ8BzGJ4O+JYwfU9r9zFpoS72O+kW8AcoUM43X8JT5euOxrPMY4ltMV55ma2+7IhZBK62JRTQrA963ys9lZf25R3Jxlj/4fV4uGV3vfH5S2OVBynW8Gdh0lIV43RvvY0744s+i/8I0XSFifWFQAe9WJSBUADU09AVJrVBrjx636AALKjcR4W0UAxIg2u2zpBsxQw+1iX6ccbiOcUNHCFOCJTu3SvKb+3BAWBODFjbL6RJWzTvBW3qa0sWX38WcIrYMrWbZtK9y9tG5EVBGFX61UbPHlWbRAWKMXMoSLgbGmKg6Xv8cqLL2KEW/XVgsuuaa0dErQcd0ikRRn0SG6jf2HFCGxTI9IRFiMhIykXFAdYAH0uR7w99ViM95LSdSoHJ+npEfoMb/diJukJnIi3YSQVAIZ70Va3clCh5KEgm8p5NKkIIPmQ6qKW+a5HKDqkMhOtOyvYJaxnWOIQyVId5Idyu+p+erPMx+eMgbYiS7hDTj9QoGPGBsFGv4mK+cxHQfuOOGZid7IPZf+f3gs/7hBSBZfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(366004)(376002)(136003)(396003)(346002)(38100700002)(38350700002)(966005)(66946007)(44832011)(7416002)(8936002)(4326008)(5660300002)(2906002)(508600001)(186003)(6512007)(26005)(6506007)(66556008)(66476007)(41300700001)(86362001)(52116002)(33656002)(83380400001)(316002)(8676002)(54906003)(6486002)(1076003)(6916009);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uGrIl0/bJNiaL8y1+vlrET0iUQeefepDI7jC9CUnoOxJz7raWNnP1waTYPbB?=
 =?us-ascii?Q?HJdmg80i8yns9wmqmDlM7PsNivA2R91wio1LwOs95xlbeIYQgpETyEr2qQxq?=
 =?us-ascii?Q?/vf+XU/ELeRk31agd6fOvCoW8Sbik0nZwbzW1C9MSJD4nUEyku1CZj6fEAts?=
 =?us-ascii?Q?j0/0I6HwtHy8OtDx15POeatYvV1Tjf2zzgL+zgatJvyS8g7exvPS0ON+EIQT?=
 =?us-ascii?Q?OGfRHigckRZGWcD605GoupmhMf2muKk3I8vhTqc3MQ+E7+TX3g/brVOgGUlG?=
 =?us-ascii?Q?kTWcffhnMjwBTdVOPTi/Nh2pteuwfVnoDqLd4CsFitHH+hMhz70jOLqQaYc/?=
 =?us-ascii?Q?lsu1OeXyX8Gq3KdYogzp6RhUJhsLz/6OKNCeZd0hIiH1o0pVfn0Znw3SJ+GX?=
 =?us-ascii?Q?8hVYFHB/zB/bZp+7lIal80BwohENkeMOzjGe/LO7db+A0PueYOrRj5X1MzSa?=
 =?us-ascii?Q?5PHLy4MZPVN8OSdl7ujWUouZPlZOqtc15SA523gEAoyr3jPadK1cRlDbTIxq?=
 =?us-ascii?Q?D2HAR52GoIGebmkRk7g3GbsnsPDY0ipIcql9Ngj/mIOszRkl4xZfGFGnQfKa?=
 =?us-ascii?Q?1FaMiZKa5vVjzXwT2IDs1PeQ18pC8PVq6p0S5SHJVvC4W0vkjoWjRmuMEXop?=
 =?us-ascii?Q?ko8RFsTd+ZXUcgYGsQCnqSVqLuhvEhs6fj4i5JmHS09I6sp8b8DYCLUVSgf4?=
 =?us-ascii?Q?3/azH/R75wzQv9iR8C98CE8VeT7/ZH/dWymuVM767dU12fMOoXIMMT8EybB4?=
 =?us-ascii?Q?ONh87BXO5FnXSlFAw5qwCIC9YUy95Uw+dgVGz/FuWdkRzVT76MCecqXI0k39?=
 =?us-ascii?Q?TNcxgzkNbQ1wj+GiwSRtPyTXEh1al1JSCl3LUglf4QrZz6Ycp2dJO4SLdT2O?=
 =?us-ascii?Q?+57wZvPxAooBXiQcRtNo+xIyQsV5gqiGmMmSjK1kteRLUmfnCGO1c9rPfMF6?=
 =?us-ascii?Q?c431K1gEecY6zNbcqGaVBB65xnlL+clPQr0eNJsgN9evgiaqyzfe0f1E8sbI?=
 =?us-ascii?Q?acuwDwtt8I/mk0O4WiHIHJtkZc6WjJ7qikbTTmoQeeBxY8ew05bw1BACaasz?=
 =?us-ascii?Q?6PLXWxHjEeQKPVXNijejsZxF03UasCg1OppV1iFGpzGXCi/A0r6TDFvb+0yx?=
 =?us-ascii?Q?xpy1qKWOwIxmlOw51HTdccD+dCTP04/kb7PTITYr610D/q3tnLuDn5xCIaif?=
 =?us-ascii?Q?4SWz1YXEfU7INiszxjNiq5vX1y4ElLVrQORQOcnviJomsGg/KYjnsKRJXFBA?=
 =?us-ascii?Q?GNy4R35ll1kUgT1JOiF2/griEnjkMuJNxaqhZ8nO5lNZYaRZEKYhIdVfcZrw?=
 =?us-ascii?Q?9wbubLJqXaLgQcERlSvH7upEmM+NpBWdd5F+xV19TQj3YBeGg02uEQQf1H+M?=
 =?us-ascii?Q?a/qUEmglf1aPNm/+R0YznjcbJ1Qtz4+jj1oz9jblk4LsX9qxCGPwVF001n4X?=
 =?us-ascii?Q?GOJs8zmzh51eqDtWnsa8YzcsyiG2yP2WXL0zE9obKep03beOqpC8z2BYWyuN?=
 =?us-ascii?Q?Wyqcs4qsrcB3F++oCpLK0jrz62v29n6P3+DTwAmMmR9y0RVLai23VZupo7bU?=
 =?us-ascii?Q?Knpwnn0z6yaTaYAOhdbFMdF5RrZKWUen3PTBrXx/8/fQKZ7uWXW0qWHlSyxN?=
 =?us-ascii?Q?9HtTz59oO0+67Eqi1k5hkc1FXr5us+Ju94UingFkjOgrUJvyFXBZQOWiGx0X?=
 =?us-ascii?Q?V1U8k5VSndAOFMTTS1Ar2243p+51isa4BT/a0PZdgwPiDCvaisjDNeLTxsuZ?=
 =?us-ascii?Q?0/wTTDDYbehMy13hMT/CZadDBMdzmNI=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4f53e-e265-46fe-2676-08da38b3ac96
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 09:49:17.3262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4tkuR7fJKkBRfGK6xK9Y99gAJcUE1x+U/KBe7Y0dJnK3g+rfXuaWhG2FkF5zHqKphY58Vym+bflNwyTMSTvwBcvkFE9JKMe8k60py5FQxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0188
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

Hello Marco,

On Wed, May 18, 2022 at 10:55:22AM +0200, Marco Felsch wrote:
> On 22-05-16, Francesco Dolcini wrote:
> > Currently the imx thermal driver has a hardcoded critical temperature
> > value offset of 5 Celsius degrees from the actual SoC maximum
> > temperature.
> > 
> > This affects applications and systems designed to be working on this close
> > to the limit, but yet valid, temperature range.
> > 
> > Given that there is no single value that will fit all the use cases make
> > the critical trip point offset from the max temperature configurable
> > using a newly added trip_offset module parameter, passive trip point is
> > set to 5 Celsius degrees less than the critical. By default the
> > system behaves exactly as before.
> 
> I thought the conclusion of the discussion was to use a dt-property?
> Since it is device and/or environment specific.

Daniel proposed to use a module parameter [0], but if you prefer a
dt-property I can change this. I would keep the same semantic (offset
from max temperature to compute the critical trip point).

[0] https://lore.kernel.org/all/7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org/

Francesco

