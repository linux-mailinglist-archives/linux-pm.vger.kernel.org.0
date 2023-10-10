Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84C7BF8A9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjJJKaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJJKaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 06:30:23 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433439F
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 03:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7tI2V6F9yV+j04eL1bjF6HlCe435w+No48Z116dgl+Dhggr2Q3ceh66UxmEZmhl6C85Sfwq/eiw17mOc1YuMAON2X991Z5SFAMFG6qLaXDT40VWSFxmLNzL/hzjIGEufzuIwx58PEaHDsw+aj2EkYTG+pNAg6UUc0WsoUMjOgvbGifVg1k8iGRE3y8BVD+GJecr+jAzN6v861DaR5wFe/MvJUd1G0wdXadJVxpqa8mIzVRbdRwcQkqiwwlhmveI8vokES0acd6X+uddVzHiA5i90jfK0kS93z2Ku3dSQHoWpGW6cx1Lvd+KlQVOdJO7UxUHG3IVg125OP/5pl4aFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnyIsVV588rFSs1JhRfhhhY/b7YR+dnSGWqdkjVy9sY=;
 b=F5Ve9T2ns4MOzYPTESxvDv3bsnSZAS9A8VaK98w6m1rLM//2zf68aziMHimRMTXfsFctg5eCuY/LmsqulGG5vWNrw5uaZBWzCIVeIjPWHzfF6yfahzVD13nMiPA3mJ1/IgfT196ls4yJBrj58k97WAL8ynPBTKMf7UF+ONLvVVOgZ0sOPtniTfDYMQFIIyoL7pZUo9tdUVPyXwmzeIWbVurvexMm98Fm7ScQSUbF4YlnUT/Hk3OOJrn3wB+e9hmAU7esQT0ZVGFOrCJLNn/jafL1S78iDTy2vH/80j0NeNppHJH4LhxjzNULeLdSzhj0dyaSp499Ng5jkA+hAveQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnyIsVV588rFSs1JhRfhhhY/b7YR+dnSGWqdkjVy9sY=;
 b=VmaJvX+I4bvlR8YVOg8i3QcwCv08dWOCQzhjbhdE9pvHW1D0xPvtXOVm5fs6Osesbg4bxyYM9uuKCH2lnmiTjsLfyfGorr+W1VDtQ/9q8B1wVnlivVPfRP3mUQ8TInuGhlFLxWN0x68FLjsYq55DMNf59jo7yM2G6RLGROqfI1w=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6888.eurprd04.prod.outlook.com (2603:10a6:20b:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:30:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 10:30:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnA==
Date:   Tue, 10 Oct 2023 10:30:17 +0000
Message-ID: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB6888:EE_
x-ms-office365-filtering-correlation-id: d28d3e62-2efe-4260-18e8-08dbc97be5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjhhKMIjDYsdDjCFIlGLHF19MipcHJVShx5Zz5QbMxqgf4NU8P8ZPcCR3LIZPqOYJtRmj+rlfmCm7TYU0aStEoXK5OZYn1lLtYWHLbpfC4F89LfScTe5MhbVt98vSLwuPuI8py01ttWaTP55SKhIjwWG2OzOrF2dV93xUZ01NDCtE1dqkNQGwOBqzGWY7nI7vCN7oFEVA78lhJCDBmJBMnEF3gN4hMpUOb0/R9VR39CnnrOffpwDKtycPnBm9YRWVMXeLBrQqcb18gaJbgzNDDkkyj1O07ByAHB9qh7zSNC1t9VIRollwzJEdeOvntHYe1MpvX1OiB4WkjssFnn6Cy91Wmlxqg1AM21Lanq+yJPb7/VYYNyaDWVdOYLjOxJg6W4NNXnqkzmMsMU84ybkpxuyaubMnYyJ4J2xNT9CpTXDfP48Invcr5oQ1ZTIHEWDnOZ52tMRFSgxEqkEbcjc+Hjofud3nCMqBpkDSrCzY7y0Oc4J/S806EyjqbsSGG8fwSIpuHwhCLhgSrvs1SM5r1f8dwj/E3Hhz/rW4Aj2gqecNtSArdX1x5YRM6QZQvE8eorrLLNKTyU8bj8x/tp4nAZdxtuQWL2xF2RrUjcOsBBUPYbsHhc8IRR+PNP5N1Jy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(558084003)(33656002)(86362001)(122000001)(55016003)(38100700002)(38070700005)(26005)(8936002)(8676002)(4326008)(71200400001)(9686003)(6506007)(7696005)(41300700001)(66556008)(66446008)(66476007)(6916009)(64756008)(54906003)(316002)(76116006)(5660300002)(66946007)(44832011)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?68AZ7ySlLu+ORpMyNvOfdm0MP9oOCWwtApJeqMMLIMzGSNwXkhwnJ54Qn+xn?=
 =?us-ascii?Q?n5HpMnygwdRTwhYeKjGKDf9NoL7qIgDz/8WBEdZ0qZguVFjYiaOQBrEu8nb2?=
 =?us-ascii?Q?oU1JOuMqlNDN4G864QRJXYXIaraI78l3kDcDJxaeOoqVuKaGviESPn0uYve6?=
 =?us-ascii?Q?MhC+shg0yEYWqwAjV3PB1PUN1dw6Z+XVwN+UZBQ5VEii+YlpEVp1fFYXbLPs?=
 =?us-ascii?Q?Wq/tc/QDuPJhuLrWug6OF6+SuAONeSA2zSIOYzkAN/9yiQnFT/40s9rKbdlu?=
 =?us-ascii?Q?9PnDAbXhMg6QtqbSxBn+lJJPM1BN3+IWIdD/51+O2ruEE8uEkzAmvpqPl+g3?=
 =?us-ascii?Q?QkR5Uw+LCPwnttQxG+3FFFyN9cRCW9NX7tmn0XtSRJTNM0unJDAGBu4t5Hwo?=
 =?us-ascii?Q?ZW39mvf1ANASDuqE4ROXDb8nEL40EWFv+0CFHa7eWQniYuNq/S6KFVhY0qxU?=
 =?us-ascii?Q?ygbabVZTGL0c7SC4nd5qCMxIWKTmEYOYQXeSljVZwwzEevtNfgHkoIgzUSS0?=
 =?us-ascii?Q?52RJ6Ou5FAIUz24nE+Ew2yBgw99G4ebITMmJ856zLEYwdqPFUICHKT7AMN3Y?=
 =?us-ascii?Q?+7Io5dRW/LHVprFAGquHps2NoWRb8Z+cm/5eI6DE1bHt2cl2/Ftd+y+iiajE?=
 =?us-ascii?Q?hpOBH3UmWkXDQPAAwg6KJsGCgHAYbyyMnQfqsGsjm90NKxmVF01QBIG6M92g?=
 =?us-ascii?Q?Fi0Q8ChUZdJXdDulYcLSfRHMIjhz8DJl9hk5vWqFpDONLEMzV4xf9WQ2yhIN?=
 =?us-ascii?Q?jQ9QWU4WsomfG8jLm49OGA3AFenofjMC8ykx18uKpN+c4RgcZcHyrdMI974V?=
 =?us-ascii?Q?ow0oA0iizCPbUKUw4vsA0jwrqNCkj/CHcM3IPhmonZA6X1Lj7enDtAPO5ydg?=
 =?us-ascii?Q?caP4b/s5l1APPQJhSGLzcu2tA4bCbr9aj5lH81luSdPvI+F9t+/Hm3PJIz0A?=
 =?us-ascii?Q?I/UsHkH6yhZfawm9KtNwvHz19EzWCDzGUR7tIT9ea3I4qRBjVI0dKS3/3RuW?=
 =?us-ascii?Q?Uq4lMAN3PjZ6wtnpKYSrIjkof2iJpYPdE+k407OZDpuJj3g3ClTHgkDdsAkF?=
 =?us-ascii?Q?qp+aCCpc/T9vL+AelqXn1M+Suck9m1Lf9bRwyYlCO8F9Fjs9hkrJuwvAMtD5?=
 =?us-ascii?Q?Z9hkpLjEr+7VOmXntDp81fZ5ojaYHHz+IKol4o0Y6/1Mn0K1241w/smkdpyX?=
 =?us-ascii?Q?srMTYjJpDFtpEhZcmhA8GhZHflFK7uwTHAPRGk9/c9VavLAajYF4/fv8PZNx?=
 =?us-ascii?Q?4cviIUGHYNEx1F7kYOn3ALWfN1n/j8bJKaPutBPB2vu51i7b3Z+1VkcyJ5Vd?=
 =?us-ascii?Q?p/TEv+b3aZWkK5grKkIGjSj7lErhwK7vJ4aUKugnEDWKQAo7ELOubi+6v85i?=
 =?us-ascii?Q?05e5LFBUgwcWtYaUsGogRrKxE4DslE8r24eyheSdnVcy8fMqyAE0uPMvUMJk?=
 =?us-ascii?Q?0o1StllhJOelYB3FTkG3dsFwYFzazWdJjjrYJ2f/ekhwLbWzJOmm9GFu0jrK?=
 =?us-ascii?Q?AsUZhy70B72EX8aWPD2ZrYAb8dm4mzdVvrUEtKqTMIkoCYS5BYoRgikrgOW5?=
 =?us-ascii?Q?Dq0zh04Ueu5pbyNhqo4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28d3e62-2efe-4260-18e8-08dbc97be5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 10:30:17.6124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bpWGoDs98mP+Nq5sePTI2UsiAHCRtm+h2ZV12+6VTeHjXgL5KPdpmrP6qWokTLxa/mp21Lep4/F+iWXiHONKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

I just see you wrote scmi_perf_domain.c, just wonder this driver is only
for devices, not support arm cores, right?

For ARM cores, we still need scmi_cpufreq.c for performance settings,
right?

Thanks,
Peng.
