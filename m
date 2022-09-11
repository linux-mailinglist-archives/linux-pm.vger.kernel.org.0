Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB5B4B31
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 03:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIKBbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 21:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIKBbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 21:31:22 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC133122E
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 18:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzWk2tqgjvNUpQmiwOY5JSqeGRy6dJVhcfdJP+GJ7qvXZGUW5pbsN/nUJ5Uvp62qWCyp9gADaHFjpnNqM7b6DZMqNK7grkpHydO7z0uWPo8P/3ZMkzPNYq5V9D2oWh0xjMuDxFOVc9n/PPzrQop69aaFNRR3tHQ5dNdJghUB2LSlvfJJ1g0vLaGbmoqOUeh+rBg9Kr5f+zpkaKHT5JSOWw0m8IpMjF461HENBXasIuM85A0uq8tBFKF/jENjBgguRhw+eiKvFKUKLTlcNtNXEZ2xX4fc0hW/74lDIYgr7DRiXRz+qSrBbUx6f0v2butXIXQ4H9pOxF2CwQuTfKrvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6XaDVd0SYYjlGbQHwoNkq8Y2EfTCahZ7gL5EdW1xso=;
 b=OaKKqloh4tGDyJs97RVk9Ie8peX9V/Z4ybZGUbRxRFQI6rtrLSg51EhA1FumF1NIWWcggfzi08HiNAwKDKeEQmfaxTd844g5ODUdPh+HdsNuYJAj63VAN17Nf8iNJrCBZ4m8KiZm5i9naYeTdxCscbs5bAFRtX/0RpNP3z8Om7KWXFnlqbkU4q22oHDDYbclhWbpYC1e1eM9MXtx6IamdJMOEtf97MPc4ve2zpkXyGhTR60i3qwHOoFE5genlEQ/a+KV9eh+BbOCZfT9s6uNCEodzRLnDXsrzbFeaTc5XFE6WaYfwjbTP/OLs27urjmDhCkA2mdVNoL7/yLyIbDa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6XaDVd0SYYjlGbQHwoNkq8Y2EfTCahZ7gL5EdW1xso=;
 b=d2sRPeIRqF9WV6HdbE7q432J/9aGV4cKcqjzM0pspJDdY4MJh5iVoE1seiGckWi1kr4lyqRnJB593BPISx/U9otcyY0Rk3yGeu8B+hk6h1829an+fGV5v5NsAnJaQVBANI7xU4Iy7VOQ3fbvQTtXZONA0pAf4hK55WNMkBne0RI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Sun, 11 Sep
 2022 01:31:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 01:31:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: Question: why call clk_prepare in pm_clk_acquire
Thread-Topic: Question: why call clk_prepare in pm_clk_acquire
Thread-Index: AdjDVBjUt0pijoGuQyGRoo5K0OYp9gAPGMmAAAZWSgAAdO4eYA==
Date:   Sun, 11 Sep 2022 01:31:15 +0000
Message-ID: <DU0PR04MB9417294DCE3DD29CD76F911388459@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
In-Reply-To: <20220908173840.rqy335cdeg5a2ww5@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9321:EE_
x-ms-office365-filtering-correlation-id: 27c94c10-d1bd-49cc-1a46-08da939551e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reQ4ajL2R+6Gk1fQnMsgBR9ZztLltWniiPzKZus6VFUC1vtfjgEe5QPsPvmKMqQoriMCDjNbi4v3pyQCBsXhAYWyiT/5koMYPWHZ2Kj9wwW8N28nRLR1Z5fLMvJCNWxq2b43M8IDj1jgGkcY/QTILoLy0WbuuT8sNU/fqaOyKN8FMJ6iWEWmYAiypHD+uKM4q/Oiu80PPRbTLOaf6RQOiXL0CpMiE2X2GRx3v4expYwD+26i7EdUaEt7geYcSG15OQ6bKbn2SJ/wkgCo79pJi/87vOIvx65rulPklnPvZU88YmTbAQP33TH0eAt/+x80ScMerylCCR06EzDsXnUpb6t7cQMlCyABnfDCIdPD11pXV/WuSt0eNAJx6doHBshWwoc7y8F8rmOwJAeh+vQiABbmxxuvbs6e5xfR5jo+gK84dEB9XGHGtcgOt0AOe3Ht2ZxEBCEwZoDB0fs8YuSZ6iV4lMsp4aHss3gEoGWjyYb//1mVzbLNrHd12rtYpDDnDWrjAC0DblPVa1CBxmuTgKakvl6TboOYqx9PUQmutjbFdxUagD+i5RKUR8+6kkM36ypXETDcraeC6Rv5ZUNsrpi/45lsjpbLiG/5qpveUFFHCDbUx6E8o4ISrNkvk5C6ZzAKqpSFSti6sTbdBE+1OVlPPcKdMHLdmLIidCgoXt7MbkzxOLJLjHq3/Hl35gC7K1MO61Fj+jpNlLx818S5sBwJcB8ruUOUNGnR6G/Mqqt/lMOB4TBHdF0m4zoPvCqGlg3tKT8WJGHJhxfKEkd8zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(76116006)(9686003)(26005)(7696005)(33656002)(6506007)(8676002)(71200400001)(110136005)(316002)(54906003)(4326008)(66946007)(66446008)(66556008)(186003)(64756008)(66476007)(83380400001)(55016003)(8936002)(5660300002)(44832011)(2906002)(38070700005)(52536014)(86362001)(41300700001)(38100700002)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pjwIN+bQ+rAI2Vw3PErwtZ3yv/u4JyZWEidReYsK2Mnq/q0bQSdy2f4TqVr5?=
 =?us-ascii?Q?fLHpK21UTb3PmsdRVop3sIayQo9Vq4u3Cfw/0EgiS9L+3aNbC8cYrN9jUBMB?=
 =?us-ascii?Q?N5UoWc/xmsWwKipjiwLOyVl3olgd9NUE99gFB7N5H8QKqI7y4wFTm0q7dMII?=
 =?us-ascii?Q?+TYhliOo++sMzmuGhmCn/x6pXNNKCvoC9ZbbZDUheIbmC703OmctRbEAWK5K?=
 =?us-ascii?Q?LyaF7vgNHiGNaIcKrJGmMvzCtOM2iSuzQpfB75Td6XFAupwnrECRTgVXHhTF?=
 =?us-ascii?Q?gYnbXO4rbmw28MWcyQz5/RSG9E1VQn/3kgA6WoOZu9ON4OFT43O8uZdHl5oP?=
 =?us-ascii?Q?2qjp72qx2ZwfEFZMx5MaAxD1tg1YaSZC9qnaSY2Q/P0lBdGaTqz9ij7VWwj8?=
 =?us-ascii?Q?JtI0YojDOIdgzb25RK5jV1Cm27oUgwPGv58vIFomReBUuxciiolovI7kQVaU?=
 =?us-ascii?Q?KC/vZzcViAV46payJGEFBgAuZvPPd9mTjD36oV7uTWWoePrV2eQ5WxRW7xDY?=
 =?us-ascii?Q?pPthwI+yd7Gv1Xl82DGOuVH9usPczdg5o2WF2rVPeDGSHlIBk6pCOmuLueqO?=
 =?us-ascii?Q?yX/s+/VQ2nfCDPUZqQF0xjI36qLaO4gsDPSCj3WDhEVirrGRkL1umZtOomUq?=
 =?us-ascii?Q?K9dZNZqM7x1gT+da5ms380VqydY7+jD8o89P5gG5HuXIdEoV58UBjiiu1YP9?=
 =?us-ascii?Q?JlSTBKStg0Qr7i3g4hXEuK6+Urpa1dL2dgl4wEpy72PjUSP4v+EAasPOPzlI?=
 =?us-ascii?Q?ql4ZU4s4vxvPAtZt+g0h7MEBwDG2CdnRQZdtbzh8u9nQduzUEmRDLmbNmYqb?=
 =?us-ascii?Q?bmBSy4d59ZExCn93fvoKIG4bVXzztxn67AufvBct8/epT5R4ib67YioJVZft?=
 =?us-ascii?Q?ZIpWNLsDKqGc9hMeJF7FiklUibWpwVOHdbj73L7kqC8Kui9qKnjWcjL2rRqx?=
 =?us-ascii?Q?8HW3L7EDsbsq1EKvriw4EM6/lz5jbDa6ezX9H7zlNiXKBYMWOeZAOxSfrofa?=
 =?us-ascii?Q?WTKjjT9OgSuogn9RL3z6jCCD4Dui4UrtJZYh/sFHlJ06otd6t9gQzZxr29bM?=
 =?us-ascii?Q?RXe/6OQ3epuD7gSWNBHI07R7Q63BX0c9AqJKneT7I6VslKTNGAYnndg3zyUK?=
 =?us-ascii?Q?FqRSr6+ryvTrHJWl9GvC+AGdCa+ezh8v2UH9jh9R6dBJZ47hG84Lt23I+T6v?=
 =?us-ascii?Q?sNUoWLOSkXQZgRrgEiiUo4VDHOEgCoaQiB+VzdsalkxPRld//0p68NR2ybPl?=
 =?us-ascii?Q?BWG4hzWnDYcgWXB34fO9ohxYOHMKDJ7z/FLs9UxdVamCaQKGAeiRhdJAxm+t?=
 =?us-ascii?Q?6+601ffzwjNpsD1DoAH+0JaKZX51KhhhXmSqUymeOem5km5I55lRmUCXop6h?=
 =?us-ascii?Q?8ufpSuFAwVEob2N5LslO9z6X3XSbq/9w6a6TnxGiftQxGwVVWnib/3v+4prw?=
 =?us-ascii?Q?3lSuqgZ437+oJ+PVozwbGds3z2mHHprAc6uvRuczuz581wzPwku9XBCDJ39D?=
 =?us-ascii?Q?/YmkC3/3eaqsGqyFkeYPT7XmzMcteRL+wjo0hFxOu89uPkERijsJlVp/Ps4U?=
 =?us-ascii?Q?a9P04EnYKzeseuBPtg4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c94c10-d1bd-49cc-1a46-08da939551e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 01:31:15.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5KuWYIHnOKs+nK1Oo3xARxxoL+9AgoRzVtIcEXBUK+3Zk3zR8O40hlnRScAqX4KUAOKWm9M7o8zWPMq2hWG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: Question: why call clk_prepare in pm_clk_acquire
>=20
> On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > Hi All,
> > >
> > > We are facing an issue clk_set_rate fail with commit a3b884cef873
> ("firmware:
> > > arm_scmi: Add clock management to the SCMI power domain") ,
> >
> > Hmm, I wonder about the main reason behind that commit. Can we revert
> > it or is there some platform/driver that is really relying on it?
> >
>=20
> IIUC, at the time of the commit, it was needed on some Renesas platform.
> Not sure if it is still used or not.
>=20
> > >
> > > we use scmi power domain, but not use scmi clk, but with upper
> > > commit, the clk is prepared when pm_clk_acquire.
> > >
>=20
> Is this based on latest SCMI clocks that support atomic or older one whic=
h
> doesn't. If latter, I see pm_clk_acquire doesn't actually call prepare as=
 if
> clk_is_enabled_when_prepared(clk) =3D true. Do you see have issue ?

We are using 5.15 kernel, and clk_is_enabled_when_prepared(clk) is false.

>=20
> > > However the clk has flag CLK_SET_RATE_GATE, clk_set_rate will fail
> > > in driver, because clk is prepared in pm_clk_acquire.
> > >
>=20
> Where is CLK_SET_RATE_GATE set exactly ?

The is flag in clk driver, drivers/clk/imx/clk-imx8ulp.c,
imx8ulp_clk_hw_composite will use CLK_SET_RATE_GATE.

>=20
> > > Looking into drivers/base/power/clock_ops.c, I see
> > > pm_clk_suspend/pm_clk_resume will handle clk prepare/unprepared,
> so why pm_clk_acquire will also prepare the clk?
> >
>=20
> As asked above do you see the actual clk_prepare getting called as I see =
it
> isn't if lk_is_enabled_when_prepared(clk) =3D true.

Yes, clk_is_enabled_when_prepared(clk) is not always true in my case,
This function is just checking ops:
clk && !(clk->core->ops->enable && clk->core->ops->disable)

Regards,
Peng.

>=20
> > I agree, the behaviour is certainly questionable to me too. However,
> > it may be tricky to change by now, due to the deployment that has
> > happened over the years.
> >
>=20
> Agreed.
>=20
> > In principle we would need to make the part where pm_clk_acquire
> > prepares the clock to become optional, in some clever way.
> >
>=20
> I see it is already, let us see what is Peng's observation.
>=20
> --
> Regards,
> Sudeep
