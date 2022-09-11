Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E75B4B44
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 03:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIKBwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 21:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKBwX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 21:52:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A843ECC9
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 18:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoJh+OByp/fkCsEA1N8L/QMKAPBfRidG3KTFY7Vd0kOykvgS4kQwinPb/jAjGtHc6JUaP/YgSd/lNPxHPxMicy1P9QoRzTyMd5nVwaTA+c9/S/DD8DSe5uPaVdhPxuYzWRadVKcKvghbjb17OQVyNM0AxMNAYfn/xxiA8UY820BbOE+9zQRZeCfPEl3+I3AHqeVBJn3c+LYYUU0oF/h+XTNHaTrTqqnEkWj+29r7jJDS2PeSgdIajBTHrmlhEKvTOnJwcTwnfnDHn65YkY3M0lttJKFOIBFRzg4jq09ZE7FgRFYT0ZoA3hKkkQ0qjHGI9yML+9fDMgASaqCoINO38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlRp80C16zZbtbk9VtFhUdq7Q4SJk1zAYjKcOkW4szI=;
 b=RB5IeSxqTG7YN6w+0BUF7R/D9rFdURYBUthQf0h7A8SmCJ/+vMdMdjKwhF1B6MqDf4yge6afyyVi2JedAha2pI1oPXZ6YQkr5o9rLJA804oR1DM/PkabpzVN54UZiWiNp0F+uLyZQzcLeq4iGL9syGi8F9XRhASMij8jWM0HEgMGUDAZtXh4ejkWqM9pJoZZ9HU3oKrvu/dT77kEztRiNOyc1VSngWIid7s02a0LN3WzdMRN06yLKoFAISk9TRpzrEaO4Q/9rehur2Q/44R6bD2TH7ymhYt+bG+PiECL3NNtdtRr+yqg5+LA7ZksWU4sd/NaqhuX32U/2dKZxbjj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlRp80C16zZbtbk9VtFhUdq7Q4SJk1zAYjKcOkW4szI=;
 b=H/wRuH3cy971LVxsOWvw/A1Dn9DAo1SyaB9DR0YJZiLLvnqJZd5dj57I8zbFKmYTXsw0GNV8vR6mR1DEfOKba/o9v5FcUM6QLWDscRlvPOZKSg6M/v+1iktjvJcLYnMpycjhasQdjvaa1dH44e5E/QKZed+q5ZReGmwoW+0l3UU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sun, 11 Sep
 2022 01:52:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 01:52:19 +0000
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
Thread-Index: AdjDVBjUt0pijoGuQyGRoo5K0OYp9gAPGMmAAAZWSgAAJMn7gAAJdZYAAEd2pdA=
Date:   Sun, 11 Sep 2022 01:52:19 +0000
Message-ID: <DU0PR04MB94173197487D92AA75D40CCF88459@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus>
In-Reply-To: <20220909154254.xy4jvj6ybpuynghc@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8322:EE_
x-ms-office365-filtering-correlation-id: 7313db72-245a-4ef9-5847-08da93984331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Vo6UgNLHBxbwuqk+xdLn9ROLjbt1BLK7qLi5NMNfrdpwCRGy/So0+gGasOrNvfFfC7nd92fsWjH3iWt4xGDtUI4muxQQVnRgAcx4IrXigOfvbHEoeJyglZ6ZkeIDr1uPeGj1sJQvyu97LQ7FfxXvdDN4Sclx+wmLDTsWDg/yin/jEcJ2snMm1A7KVxSt0mE+vOWdUVfN7SQ/EGy0C87UNoCHJ6wha7jpnIW/FeXM+RXulyS/iXH+hPFwRwRjwXQSg54sVO6di6937L4X9ZPzui2kIbVNQLsDC780MoPbtulXeNAsCJLRrzAeSsmQTvj6o2h2bZvyg07liLhKStnqxqsTObHybDLmIT+kmJ2SP1VeGo31eFWfueKd4tiODHhr8zEQJjiG4bkZwNAy0/Th1b6dUHCY9aTno5Wkuj5e2TxYrgOiqa7njV036KVFmmMYRArWUBfDzuZiVptzJiqS7qRDBy7Z4gAx6vzYR9w5+p0bS67lU0ceNChFnUqcFfMmnae6LVEBUeiqYJCxwMV6XJGcAw/NxnIYiUCJWFKjuWHAHG6XHSjXXgnNiMuk/gqqZukXi7l/TmaFXGfFGsuPsArlZAlE4+Z6RaOeSz+BE4w4DCt5tpj/qroZms3QcH03+r7+BZdChPxaPn1S91gXq4wTrxWoMugPIvy9HTwTRhWx44wnBR8zo4YLpf29BVX7FiSH+gex0dYGrt8Sok0roCXpNWfyCnPcCgi3NyUP8EsoaspKw87AMxhsgV4mQHfJ8jyDHIMkt8u9pgzJH22sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(110136005)(7696005)(6506007)(26005)(38070700005)(9686003)(86362001)(71200400001)(478600001)(122000001)(41300700001)(55016003)(186003)(83380400001)(8936002)(5660300002)(66556008)(66476007)(66446008)(64756008)(66946007)(2906002)(4326008)(54906003)(76116006)(8676002)(52536014)(44832011)(38100700002)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZWvx5CidnACjAc+fqSmyvnHbFK4wRNVk8NDrGSS13nZX5/NVzvtH1o4Tt78z?=
 =?us-ascii?Q?iW85pyrnEG34fIAKfDjsBtQ/EoyNeqIuyrrAMjzmiTG6q4khpy5RB8FwtM4b?=
 =?us-ascii?Q?2DzM6goOz8sLrXPp4/ZuVVpiZgea/Bl0DVeVkd7/HJVeeh4bI0GSOkOSNIcb?=
 =?us-ascii?Q?3kl200XNIbgkmg/5ssXu+S5bpNRGgfrcjtFv86DXCJBZSpGxSj8ybj3Bs9OV?=
 =?us-ascii?Q?5efqsQtxkhNYSr/W2PV00QPbG+tZJVF6iMmIB9vPqtTjJi8P3k5P9XR5TNSZ?=
 =?us-ascii?Q?rm4t1wTEpDpH16y4mUho8gTZDW73yyr+0xVAx8paEl3rc3oVF8FdP3F/MXTO?=
 =?us-ascii?Q?gfr7VEzHTjUEy8+1puQBUHTFYgn7Ns+WcO0KvLGgl2Zklh647bLX0B7m1O2t?=
 =?us-ascii?Q?GhKejbYTthGEtr7z7VwHkdPcOrx1pYyDoQAu3WCPI5fJzfgalWiQJwF48iCA?=
 =?us-ascii?Q?BHX/FGKRddjT5eaJy6BQfvEXHqQHLNlhz+EGNvFujG7kK68S0W57XjGJtoMp?=
 =?us-ascii?Q?1mK619OaKJCI7o2o6fBDpzEExVthykfODkYWgdYp0e+DhU6WQ6GnhNAPZd4V?=
 =?us-ascii?Q?uC/AkdeYZiX7NUNJRSFXWgTArTuIFAWp7dTyu2qOYHTLXpYTwqySZbznZFDX?=
 =?us-ascii?Q?OSLHba8yZZDV8YaF7ZL2rILnq6am/SUmIPL9RPCSaJPwX08zbQzRoev44CB+?=
 =?us-ascii?Q?YdWQSz3XRipLN1/s4GZgulIdTthP3o6lQ6Oaugew1+V1CqkYOoGIyDhQOrxO?=
 =?us-ascii?Q?xTBUZdHyK5E6F85EEVio5P1jhsMC/QlcneBF3FNeLT2LiC83ek9PoQk3GFBm?=
 =?us-ascii?Q?CMu5mXZPvBt6Ybu2n56vMW685lq/kyWS6xtIB6t9cHUYqWK4iVR0pl2yKxcT?=
 =?us-ascii?Q?WIxj02uE8WKIZfFImvXKR++DUx+vgk8qSq7IU4A7HDIEZFoCKfrfEI8uFod1?=
 =?us-ascii?Q?BwWyqdTXnZ7WjegjaRRcT3j6yeXVLJX3IT2/ek3DqLns3tje2lK9c8TfsCII?=
 =?us-ascii?Q?99pQmONUmF3Jo4Qmk+UmALQMsF5n7UN0WYGxna6E2ewX5nTAHMAmZy53hGev?=
 =?us-ascii?Q?ONhGSvPCn7DA80ORcsWV2dI3mvZFC/w85Otd/Nu2H+44BebOfTyvfafP7/kn?=
 =?us-ascii?Q?VnE474hZ0sPcQaFcmiA4t3c28htxIqj8hgP+97TTgRNEFKbHL5T5avNrEufl?=
 =?us-ascii?Q?6LAnSJYnECSdDsEg4K2f3iXAXJEzvhn0O+SdUqhM+W/4G2pIaQLxrmXswdHk?=
 =?us-ascii?Q?KK9fOAlDU/xxI7tN64cNrn1yQ/QEYACvFOXaV9e0T+YoZmELcl6/1+J1aSd/?=
 =?us-ascii?Q?fpatYdxD0oiR5laeE+Wam+Vg4mu5tHI6f8epsb6jh9clIKgr+bbCnd1KxXOF?=
 =?us-ascii?Q?qjjyF03C950RLX3RIU0vuJoeyv3toKO210mH//ij35G6zZnolWAtXA7JSe0/?=
 =?us-ascii?Q?TrY4EtdQgIa2yqlFjMztSUI8zWH+p4oqttOgnFxe5BjzCyZrhPHQ/tZ8I56p?=
 =?us-ascii?Q?EVyDF4seNUVbT1EOAq0r+gzWlrrvTPvOFoKT2OXEfmGlvzmAoJlQjJD54q2a?=
 =?us-ascii?Q?DL4MVPN+cTmkeTjZYbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313db72-245a-4ef9-5847-08da93984331
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 01:52:19.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXgtD0hPBy2XxVAdYuk+iq0FBFW2NjZhozP1gNju+geQbs9WwNTgm2S+dOx7vZzYpI70R6EdMfRTEt//2/EsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
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
> On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > >
> > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873
> ("firmware:
> > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > >
> > > > Hmm, I wonder about the main reason behind that commit. Can we
> > > > revert it or is there some platform/driver that is really relying o=
n it?
> > > >
> > >
> > > IIUC, at the time of the commit, it was needed on some Renesas
> platform.
> > > Not sure if it is still used or not.
> >
> > Okay! Maybe Nico remembers more, as he authored the patch...
> >
>=20
> May be, or even check with Renesas team who tested his patch.
>=20
> > Normally it's best decided on a platform basis, whether it really
> > makes sense to use the GENPD_FLAG_PM_CLK. As the scmi power domain
> is
> > a cross platform power domain, it worries me that we lose some needed
> > flexibility, which is likely to make it more difficult to use it for
> > some platforms. Also note, the main point behind GENPD_FLAG_PM_CLK,
> > was just to consolidate code.
> >
>=20
> I agree and share similar concern.
>=20
> > That said, I decided to do some research, by looking at the DTS files
> > in the kernel. So far, there is only Juno and the imx8 based
> > platform(s) that are using the scmi power domain.
> >
>=20
> Yes but there are few without any DTS upstream that I know.
>=20
> > >
> > > > >
> > > > > we use scmi power domain, but not use scmi clk, but with upper
> > > > > commit, the clk is prepared when pm_clk_acquire.
> > > > >
> > >
> > > Is this based on latest SCMI clocks that support atomic or older one
> > > which doesn't. If latter, I see pm_clk_acquire doesn't actually call
> > > prepare as if clk_is_enabled_when_prepared(clk) =3D true. Do you see
> > > have issue ?
> >
> > It doesn't really matter if we would be using an atomic clock or not.
> >
>=20
> No what I meant is pm_clk_acquire doesn't call prepare as
> clk_is_enabled_when_prepared is true for scmi clocks(non atomic).
>=20
> > The problem is that when using GENPD_FLAG_PM_CLK, during runtime
> > resume (genpd_runtime_resume) we end up calling pm_clk_resume(), but
> > prior invoking the consumer driver's ->runtime_resume() callback. In
> > other words, the clock(s) will already be prepared and enabled when
> > the driver's ->runtime_resume() callback gets invoked. That certainly
> > isn't going to work for all cases.
> >
>=20
> Any specific reasons ? Sorry I am missing to understand why that would be
> an issue ?

Just my understanding:

        ret =3D genpd_start_dev(genpd, dev);  --> will invoke pm_clk_resume=
 [1]
        if (ret)
                goto err_poweroff;

        ret =3D __genpd_runtime_resume(dev);  --> invoke drivres runtime_re=
sume[2]
        if (ret)
                goto err_stop;

[1] will prepare the clks in my case
[2] will not able to set parent, set rate for the clks because the clks are=
 registered
with CLK_SET_RATE_GATE, CLK_SET_RATE_PARENT.

BTW: i.MX8ULP only use SCMI POWER DOMAIN, we NOT use SCMI CLK, the clk
ip still handled by linux itself.

Regards,
Peng.

>=20
>=20
> [...]
>=20
> > In my opinion we should really try to move away from using
> > GENPD_FLAG_PM_CLK for the scmi power domain. I can prepare a patch,
> if
> > you think it makes sense?
> >
>=20
> As along as Renesas is fine with that, it should be OK, but doesn't remov=
ing
> that flag means we can drop {attach,detach}_dev callbacks too as they are
> just adding clocks and without the flag it is useless. Sounds like we mus=
t
> revert the patch completely IIUC.
>=20
> --
> Regards,
> Sudeep
