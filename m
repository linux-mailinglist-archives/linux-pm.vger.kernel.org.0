Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C35B15BC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 09:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIHHdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 03:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIHHdy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 03:33:54 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50073.outbound.protection.outlook.com [40.107.5.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA1A223D
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 00:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us70gqj/PSeNHb3JLrguTvN3yxPdf9vFxC/JNAaPl7l8UNJ9vg4qtbbcHwPvE0tT7lV76NnpOwObYjmgc/Lbe/9HBjdGYcdhq4JY6PbC45fo8c/Ojd87Seq7JGrakLsDndx2YwzO6xGgKx4QkanZrMSkWLm1rGJAQOKfn5ibwN+a1uCh7/ksO8H6SyJPZISn/G2+ycg/msnAqPUvhXLvl+aIX+QUeddOVxai9z4ApbTSZOV4xnrUZzHAR0E9WQaYUu0VuzIN3BqYW4nUliTFUQx6yr/FH+vXsmtGyPo3EFNkd8qg7JeZNIN7eUGQ8axsaiHgK9ngadav9jJhno9qiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBbpf8qEszPkfmNpzIltYqUDnijsg+QP6KZ7TnJwxRc=;
 b=io5UmrPDqJdlMV7YYnohTpyPUh4a3+EUOtoJU9aUbW0i1Da2mTTi6kEsAByDGRLMOrxJThRN9Gcd73emvkxAN9O28Au4vtofPNzji79t4UFZOS4FwfZ6CMNavXVhlk7EXU20oNAO+kL1UIu6A3qY1uB+5NmzfxGRMaqryUokxYNMK3MR/sDAksR0zynBPC6QLEZMAqDZEwGg1vXNfho9OChfDIzniLXrhTIUxA4T98UCqCLfFWGPLkrr8p6gmoZm4ynqNJZFW/77EasXifCLmqJpQGHwsFd3AEASWc6qjax4nRPLSSDpej4tNxSGKoGi54ExzAx6LaJ6ShSoRh06Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBbpf8qEszPkfmNpzIltYqUDnijsg+QP6KZ7TnJwxRc=;
 b=MgE/v9Zm0JEL39ZRfThowdWSiQ+5/uPoUNnKo+X/ViytXD1lCCGBgJTCODZqzGaCiQwyDtNunkWZEYjrPWY2UdlUZ47AuPNdE8/n46lVydE460lxTgY50aq9Nz78SJAwEFBcazsSV3kpqmqDqxVVPe/34zyFykAg+X721puNQNk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9140.eurprd04.prod.outlook.com (2603:10a6:102:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 07:33:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 07:33:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Question: why call clk_prepare in pm_clk_acquire
Thread-Topic: Question: why call clk_prepare in pm_clk_acquire
Thread-Index: AdjDVBjUt0pijoGuQyGRoo5K0OYp9g==
Date:   Thu, 8 Sep 2022 07:33:49 +0000
Message-ID: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 419794f0-ccaa-4c7a-dbfd-08da916c7903
x-ms-traffictypediagnostic: PAXPR04MB9140:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSibmZpJCkvp9srDorXBF7dPt5/wukH0hhN3BCBK/l/ecgyY3PScon/PPvHB7lFQpvAoO8OHKacd5ZvUAxTJrVXZK3CBkSTcAOCQhYFXZc/F8w1DfETQw70Z39hLJGwsLgHeMuYVUuA2zdHIwnsN/dC7IFBtQz00xBC9yZAIZbdAvWIisIxaXBphVmb6zdUmaIr9qLixzs3+MaEpd1VfiWBQYSi/k3MFeMmNnX1GOvuXyXbV1uNk4f9IF7HNuyeEBf+/bxDGpTN6PVXCZ45fjBnfgvti7OAeFE9L9SfNTXJAI8G7Dq/h1g6m3eGsbKgBKSG5bUy2tAHv08haFDYt+kJ1+MKuovyUl5YjNQ3d8CmeNLXxaMOj0EF/ZRxHQZomARI4dqfjA9VVVq5c5TX51Bh/zMJSBoPnoN87w1gINspEFBSJMQMpacW6S1JXLsZubYXDzwi5C9IFJxJusyYswVbH+KMInn20nj5Vv3WGx3JXxboyFyK8XpzKP3fUeObPXJMtVnRO+YWIhQrmuVFd6iW8tvsBPHoBQypSWApR0VObf6Yzs/yt2ZEzZwDvFYQsOQVxJ6nnkbqyL4lohId8eFocQArzzdGn5JHimQwGIP/PQEBr4WkviX/TohFRQ/2qlIxcgMa/CZA3fQUuXJUUDMEoyKQHcTZpc4a5RCS6R0PmDUho4SqlFFuItnKjZ3z0319wDRlNmvdxhYbmkeAA/yAnseVeYd6d4o4RuZVU/X6fjny9fcNMPn8jZifA+diFOtDj6A4OU8McO28JmtDWRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(316002)(38070700005)(86362001)(66446008)(8676002)(33656002)(64756008)(66946007)(66556008)(66476007)(38100700002)(4326008)(5660300002)(122000001)(4744005)(8936002)(52536014)(2906002)(44832011)(54906003)(76116006)(9686003)(478600001)(6506007)(26005)(7696005)(110136005)(55016003)(83380400001)(186003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6buxFfx1ywwdoY6OjD6Cuwlz8T5T9PzZUxNxmSFZt2U5brXQRXHB9316CjM6?=
 =?us-ascii?Q?tYUzbIsySwYdb+B6ocjHG1KXg2HTs8e8UFwLIixgiN+vFp82+nvSyXwK8YJc?=
 =?us-ascii?Q?nE7zH6cdctUldGi33CPPvG7aWxSiK9nILq8Nh8nSggACaVOuWXlliNYJ3JR7?=
 =?us-ascii?Q?ROIRGCNFihblZibuWAySW85zzHJDGwl98wZXLL2Gw1AoT3mARu0daO/WR1yj?=
 =?us-ascii?Q?VkvlCPzRYl26PRxKGoBGQzk5BzWizj/PC425iRtv44QWcR/GcU4fQ6WQG2ai?=
 =?us-ascii?Q?rHeSYzgZK/FA+SceUgoGAApkC31q7cfRGcfTYv1qiTuAh2/0/1UU7FulVCOB?=
 =?us-ascii?Q?/vglrsVqLcbS+f8hgBLsOSbH4IQE7wse8R+f0r8dpFWEqkZvBJITiyr9CTER?=
 =?us-ascii?Q?vA6DCHGD8fiPiYy8fTzgS7zw1Dvp0jhXYUkOmd/oI5IHy/TwK9GKMLm4EFXi?=
 =?us-ascii?Q?zkjhORFNRvqGCJCc1cz0bBwORh+O2YKNTAF9+IVPJQxSKT4cqBK/B91Jweyg?=
 =?us-ascii?Q?g8j4NhdFRKLNaYnNOKxCultuwgjKK1mxOXl5mJcqGkaSD9m3wpykpwtVtyOU?=
 =?us-ascii?Q?/UxJQHFbItoqgmbh8oMrX5rqs0tSR2wO2i2bu480TkKAvSUAvg/3KdGUP0B0?=
 =?us-ascii?Q?g9Ea0R6oT+SYWa4kjJZZpcz569vy+8Hp8X3IK+AzrTLZ60c0/S6L9ZptIwUD?=
 =?us-ascii?Q?jtte6FSAp6ivg3J8VsKRUCWFC1+WBUSgiTSkNbCsYoZ+gvfgye/aZi5YswPv?=
 =?us-ascii?Q?B/7ZyEqOM1lbxiOyo+tTwZVKTX2lUN48FvnZK5EfaAQHsnwzt0wmGoeGQQ+S?=
 =?us-ascii?Q?oxVv9szcSZep4+FmN8czgVC1IOd8iXgVaFFz6LR5mo0qQBftiBuSvLkGrFTo?=
 =?us-ascii?Q?CCxe65SXRj4QBshn19jVgmSVpXFvnMrXmgVgK5XUadAtwrQKKHdomGB8DbuB?=
 =?us-ascii?Q?9v08aqMAjbSW78jdYGmC8vQIFkR3xgc2LmLLg4dMLfb0ersp5mCRyRS3mEw+?=
 =?us-ascii?Q?K9Ynku2/RMS5Bd0GI6xbfetQ2wlFthoehZulEk8lYm+QG3+fPOpGR31E5BKu?=
 =?us-ascii?Q?a3hCn6qnL2Qm8dS1gqp6wOj3Ot6cfiRZWyZfQznvh/dIzrXsa0xLkLsR+uJ0?=
 =?us-ascii?Q?z1QSGbC7lVbSG9/3izKFzQfUoh3WuGl9fLDW+SZV7uDxgdNBybf/g+Dmd+s1?=
 =?us-ascii?Q?UsvNYrIUnkOdt/il3s0NK76TYgw6ewPlOSBwB3eIc8KETsSPKmejuK8DmEDR?=
 =?us-ascii?Q?Unf5FJFEgtZzg8z7XBUwWLgl2sQdBhzygQ7pFOFDWYX0eP+EaYMwbO3NcFbP?=
 =?us-ascii?Q?o900s3RRzkBvg8v/X87cKteJs/6aoYTqk6LNDRJgLQFKVX+oNaM0BNgIs6lG?=
 =?us-ascii?Q?rLSziCQcDw/b6E6brZYG54v0a3nKGuXmpkLyVJYIh/4nMPMY/EisG0ua0IJR?=
 =?us-ascii?Q?DJDWiYmS2nVbstdL5aMvKv/TtvqHmvmy/0nsMVPotkDRiAE6j+ArAQEajWFQ?=
 =?us-ascii?Q?BRRApG1gweu4cAj2+RtczYBwlQICTiA069vI3tku8h1QbQET06vZWkGbusE8?=
 =?us-ascii?Q?2nuHGMyw9y8HNSCoRJE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419794f0-ccaa-4c7a-dbfd-08da916c7903
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 07:33:49.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04we47Z4XPuwInTdwET24PPSRvnv4a1rr+FIE6OQCQor24syRJJJqReqSDljR49d6uV2uuGT1dk6f7AGb08nVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmwar=
e:=20
arm_scmi: Add clock management to the SCMI power domain") ,

we use scmi power domain, but not use scmi clk, but with upper commit, the =
clk is prepared=20
when pm_clk_acquire.

However the clk has flag CLK_SET_RATE_GATE, clk_set_rate will fail in drive=
r, because
clk is prepared in pm_clk_acquire.

Looking into drivers/base/power/clock_ops.c, I see pm_clk_suspend/pm_clk_re=
sume
will handle clk prepare/unprepared, so why pm_clk_acquire will also prepare=
 the clk?


Thanks,
Peng.
