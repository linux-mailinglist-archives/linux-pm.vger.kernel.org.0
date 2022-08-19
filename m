Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72127599835
	for <lists+linux-pm@lfdr.de>; Fri, 19 Aug 2022 11:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347241AbiHSJAW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347939AbiHSJAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 05:00:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA853F14EC
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 02:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4iYQkssH2FLHfH+woX8PbxcbtaglSP1QEshK4GmdLhDBnKpElT9gW2HpROVZGeypx2BoZzglwKFePDFOQwCX+4n8LVvlSnhpZ0ax+udpF58uyxaRn+L0hKEGc6cJD8yFMAqO27rqtYiP7ZvYhbsgpqvD3H/Zl7wAyy9RQp1lClhK8kivspIZror6PaJRoPf3jm1DxgBQp22ntWDwdkp9oOzJ1T7gpi8HG4GmptpXWehb83XIksdWVsapsvmLtjNif3xKYrey0XGgIhy7qqTpvVEarsgF4n5BHvhWjAKuDM5hr1pubHpnDQ70x+G7XtCo5SPrNsX3rA2J+U0yCAz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6CY73seeug3swZ0hnJ8xfUdtjjzTHYETnWzHytfNfA=;
 b=INRO/tW297JiBQyLRrFd8Gtj+/1/cylBdGt9RfTc7ImPeWJPZx84JyGLBVCF3AcyJg4LuJ52SLiY3xdm18S/HlG0CPKyOpBrKrsoAOCRBGR/8XM3kX0urU+DjdWaCEkU0HWo1pNG7IwJ4w49OAqYsdVykNRUGNISsCfGukAp88+q9hnygUBn2Hg+FXGKQ7vJLpYxXkqu6kRwMTXVgwyixAKVR42zr6vrFDqy+sEtb6Sj8kmTh1bxs4UaVS9rfF2iGJSqwsI+aU41xJQwqjlwl2/FHlUBYJQWuWp1bhckZsi3I1gsXDLGYFJZDZjgY34i7j75NlOg2ucw9AoozcHRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6CY73seeug3swZ0hnJ8xfUdtjjzTHYETnWzHytfNfA=;
 b=Ybh2zphA0b0ZYTbUnTJeEMefb0PZIvySLnV2SicO2wXf6RUC0chEUVEEohymuerPYJvihoynikvixZLHaDOgKSxqduGvaVrENqDKfjc1/F0Q8rxQliT7CiMOJl92AY5hAIGqmmvUlTZ/UYbhyvNc9BVGqjvnfbVZttd6AkzJNsE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3325.eurprd04.prod.outlook.com (2603:10a6:803:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Fri, 19 Aug
 2022 09:00:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 09:00:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Subject: RE: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Topic: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Index: AdixOGZw9fNTqIJNRCevdBJlb4IAbAAAtHmwAHyTHIAAHwIVwA==
Date:   Fri, 19 Aug 2022 09:00:14 +0000
Message-ID: <DU0PR04MB94178BA93F5198EA34D9897B886C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417E391B514287D040E0EC7886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAGETcx8xXM18Se-ykf7=fFJ_4bvSgQm8LG6Bq=3wd0skSR46EA@mail.gmail.com>
In-Reply-To: <CAGETcx8xXM18Se-ykf7=fFJ_4bvSgQm8LG6Bq=3wd0skSR46EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459664ae-691f-4157-fd1a-08da81c13afb
x-ms-traffictypediagnostic: VI1PR0402MB3325:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZdSRcmkIE238O3r65zAfM4byVSstUagzrlRHOOlgmn63uhCxhYlZe/tqX33iVQbZzrO6r2AmtBymzw/KuSeXqfxIGyC8lOQvgCoxOX/GutButXq2cUzvlbHLlBpuaC9mEz7SJxwnThB/RSv7RwEyQ1cbyJWomDm4rX9q+dxB8JvzYkpE68pNh2GlKxQarAts57nSqdZx44+r+Rh9Ra5X8XybdRc1MgSOvRjprP+BB0VNxnjyDqh93oqvGsh2XTfoYu9No2A3BHCqHRD8e1rA8J3KWy1+1JsyuTZTU5RYijiNUVs9G5gr5sYniBNbpNbUh7I3+UGhvC+xf2tvu71vL7DOJH4oD/vmBQt6rit1FWAvo37G8XCGPGTpcyyMY+p9cwHFVajlGen9rwCNjc/lfZTOghtt1mswKh5Yb8FS+VgavsM/ZPdsArpUbkzpFCg31nKowhPI/tQMJ4MWoY3rVq7tJ/Q8C/S/YTqWTRmr+9Iq8LXHCV3mDBldIMnF0euGp+mIpdUEc0z6VtF8h2VNFasc45voC+ISAGtFTm/NS2G/ZAr5qVRUmdytMGQbDaijNbQDhHQyyOgRyoXEiK8wCflDTbjONGkzM4E0vXr6DabkkKzkFoPpTrNRzV3hC/XVMcDm3xD7AqJxqheg8qgVD4uvlqRQWRnNy/rH7F/hi28ZIoxZnboj/3k0BbYKIAzcWLixa2qI2+tP/AWCZefPaVmTr3jRkq/LvYP+IM3rVg/D0Zw8I1oTuMkbSLCPOXuAp9uFHQ1zTGGCotze40rLCiLBbAcXKZM2pbZr6w/wYORSb2wNoXaA2DsQq2Igcwo2lwZTm5vNF8YD8Oaogc97g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(38070700005)(52536014)(966005)(2906002)(38100700002)(44832011)(5660300002)(478600001)(71200400001)(8936002)(86362001)(122000001)(8676002)(45080400002)(186003)(55016003)(83380400001)(53546011)(6506007)(66556008)(4326008)(316002)(7696005)(66446008)(9686003)(64756008)(66476007)(66946007)(6916009)(76116006)(26005)(41300700001)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y2CUKmuNQY4tqnhjKxiNxedWtqWe8EeNdQ3H2iYmWz+K7VYhgoFjMCLrjQ9F?=
 =?us-ascii?Q?3qI1uCUWwo1ETdx9dsAeR3+/05NeafqvpzY0/i1DN89ccVaK+Kd2ZhsJAs5F?=
 =?us-ascii?Q?Kp40SpQQx1AlqPa4HCFyUGEU5XSzGe1PIqQa/Wey7JOGuFJfcmfwJtAsPTvc?=
 =?us-ascii?Q?+f1k5KGFB4ovijFxdVS5bG4U5AJOAZU1GoxZlp4HDPvjl8Xbp1XWRWYc1kpn?=
 =?us-ascii?Q?qwzwQnUOeIRiq1HEroUuMJQSLhRKGh+jaQ2T5gPCM2vQ30nMJ4llqn+7V+aT?=
 =?us-ascii?Q?lhZ3NxAdxsZ9NySv4Yq1Lw4aEYbnstXHC3Li7qKnjGDzMXwpt/AsPqT9fE/u?=
 =?us-ascii?Q?Rr33ksOjgfJnmSgj6pjEF8Z1PfT1vWH1XUXQrWWPD60/O0MJxHeptZrjV2kI?=
 =?us-ascii?Q?MFlyBjRBDUCWqHW87nT6/pmANBt2g1Q8FrQRKolYV2Ym9JGMYc5PNLsGEY9i?=
 =?us-ascii?Q?Wudie1F82je2VluozeJcu2r08ifrkfMkNNmo/IRIvj0mb7pATESAVYRwuRua?=
 =?us-ascii?Q?QceHx/9jccExdbclLEuXQeQXpVMgm77wz85IL0cEt38ArHenlnil9sLJBkWz?=
 =?us-ascii?Q?l0SrjXKmogkAqxHB77g0y099sTcGTLLGP8JlGawGFsRCz6xS790INz8JW5T/?=
 =?us-ascii?Q?IxBmr3vcCHp8NAvVDf4R1DtiNxHHRogBktVFg4iV1YGw+8ZoRcTcbxUrdSrn?=
 =?us-ascii?Q?JAs/3ygZE8pxrdzURdAXe8ApP2LOWMpSlO7iYp4GwnZMIQx3NtYB/wZHyi91?=
 =?us-ascii?Q?ECBEVmis07AE81JdfJjNB6n+aH7eAeRHvksK4T6pvF0tE1Q8DRF/laBMBciI?=
 =?us-ascii?Q?6mnq6VDVL7dVGRLQKZI/mBZleoyWDcoiSO/1Hu+X3KOgK6zNWAwsOwKeNSUb?=
 =?us-ascii?Q?4U1spgI9mrBiZcdc7EAOCgcgBb7tkQrP1hGztNqFPwziemjxaTQDImvms1eL?=
 =?us-ascii?Q?LKlQFek4XLrdajsqlHo/lPFtG2H8217vjbgLXNy5B/0gDqUBdtZsack3bib6?=
 =?us-ascii?Q?UyA6WvGtuOpi7k3HILTEgRP42N6lDJy/FXy+9TeaJQHmbQ+d38ST/sq6cRYp?=
 =?us-ascii?Q?/TJleORlUQKlZKKXBwiNy9S4r2a62DQcfBmQsbhfcXo7GC7ninW/2hV9dBKR?=
 =?us-ascii?Q?BGYmentsUla7J8gSdHq9WsB8ty53QKTRMl1IViKN2cZmCsPcKcxWM7RMDgi3?=
 =?us-ascii?Q?sG0clVbUSbwRP9SWgbbblNQuR8/Io8T8SF8ZIvtuBi15ve9em+PkxZYmJZw3?=
 =?us-ascii?Q?bdO39UWN0iEkQ1I++4hB4190TU9Bcz83QScb5FZclwrovY5qpv71dKsudKNX?=
 =?us-ascii?Q?m4VMTMUwvW0o1+l7v/ea9Bsm8KmGTeCKQWPSMGcbIf+8Hsl3z5ghGyz8miu1?=
 =?us-ascii?Q?IWRA1CZASxPId4DrT+auxE/2tnOoFK8BO7FI1ttPY53KbQ8ZQM7YNXfv/sO9?=
 =?us-ascii?Q?G4PqyytQYWoV1VgPNUm4lXOUe2ykXC44xjGZ7799bsKf5enK2xEPyqsHfuAR?=
 =?us-ascii?Q?cNzoaalmN/ff1qetoC7coTtSCTQ6uqfODVSv73oe/1hPsz2erNUFfAGTWnaQ?=
 =?us-ascii?Q?rkteV00ZQsiBdh881wY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459664ae-691f-4157-fd1a-08da81c13afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 09:00:14.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8uXDJbh5mk6o/mDqRKMeVDVoRRrmy9l4A8DV0y5QFIqor60KSG69nVLiAQkcKROPma51D85FpoCgZKucGfRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> driver_deferred_probe_check_state
>=20
> On Mon, Aug 15, 2022 at 11:43 PM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Regression: PM: domains: Delete usage of
> > > driver_deferred_probe_check_state
> >
> > Just see your patchset :)
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Fall%2F20220727185012.3255200-1-
> saravanak%40google.com%2F
> >
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C4bab1e117c1e46b8cba9
> 08da8144b
> >
> e22%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379644294901
> 88104%7C
> >
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1h
> >
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZHriJc2t88Dyjt79
> DomOMvDN5
> > 2JJAcgJUK6wfOVtS6I%3D&amp;reserved=3D0
> >
> > Thanks,
> > Peng.
> > >
> > > Hi Saravana,
> > >
> > > The following two patches breaks NXP i.MX8ULP, but I think it may
> > > break others use SCMI.
> > >
> > > commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > > Author: Saravana Kannan <mailto:saravanak@google.com>
> > > Date:   Wed Jun 1 00:06:57 2022 -0700
> > >
> > >     PM: domains: Delete usage of driver_deferred_probe_check_state()
> > >
> > >     Now that fw_devlink=3Don by default and fw_devlink supports
> > >     "power-domains" property, the execution will never get to the poi=
nt
> > >     where driver_deferred_probe_check_state() is called before the
> supplier
> > >     has probed successfully or before deferred probe timeout has expi=
red.
> > >
> > >     So, delete the call and replace it with -ENODEV.
> > >
> > >     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
> > >     Reviewed-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
> > >     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
> > >     Link:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re.kernel.org%2Fr%2F20220601070707.3946847-2-
> &amp;data=3D05%7C01%7Cpen
> > >
> g.fan%40nxp.com%7C4bab1e117c1e46b8cba908da8144be22%7C686ea1d3b
> c2b4c6
> > >
> fa92cd99c5c301635%7C0%7C0%7C637964429490188104%7CUnknown%7CT
> WFpbGZsb
> > >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3
> > >
> D%7C3000%7C%7C%7C&amp;sdata=3Dk98c9AaiMDTpYkx1353btm%2BB2DA4y
> Q8PPjV0zI
> > > RPMsE%3D&amp;reserved=3D0
> > > saravanak@google.com
> > >     Signed-off-by: Greg Kroah-Hartman
> > > <mailto:gregkh@linuxfoundation.org>
> > >
> > > commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b
> > > Author: Saravana Kannan <mailto:saravanak@google.com>
> > > Date:   Wed Jun 1 00:07:05 2022 -0700
> > >
> > >     driver core: Delete driver_deferred_probe_check_state()
> > >
> > >     The function is no longer used. So delete it.
> > >
> > >     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
> > >     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
> > >     Link:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re.kernel.org%2Fr%2F20220601070707.3946847-10-
> &amp;data=3D05%7C01%7Cpe
> > >
> ng.fan%40nxp.com%7C4bab1e117c1e46b8cba908da8144be22%7C686ea1d3
> bc2b4c
> > >
> 6fa92cd99c5c301635%7C0%7C0%7C637964429490188104%7CUnknown%7C
> TWFpbGZs
> > >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%
> > >
> 3D%7C3000%7C%7C%7C&amp;sdata=3DpG64f9hJO9pAhCQ4v8txcD5LA3VXQu
> 8IsVYr4Sb
> > > 5Id8%3D&amp;reserved=3D0
> > > saravanak@google.com
> > >     Signed-off-by: Greg Kroah-Hartman
> > > <mailto:gregkh@linuxfoundation.org>
> > >
> > > The i.MX8ULP mmc device node use
> > > "power-domains =3D <&scmi_devpd IMX8ULP_PD_USDHC0>;"
> > >
> > > The scmi firmware node as below:
> > >         firmware {
> > >                 scmi {
> > >                         compatible =3D "arm,scmi-smc";
> > >                         arm,smc-id =3D <0xc20000fe>;
> > >                         #address-cells =3D <1>;
> > >                         #size-cells =3D <0>;
> > >                         shmem =3D <&scmi_buf>;
> > >
> > >                         scmi_devpd: protocol@11 {
> > >                                 reg =3D <0x11>;
> > >                                 #power-domain-cells =3D <1>;
> > >                         };
> > >
> > >                         scmi_sensor: protocol@15 {
> > >                                 reg =3D <0x15>;
> > >                                 #thermal-sensor-cells =3D <1>;
> > >                         };
> > >                 };
> > >         };
> > >
> > > When sdhc driver probe, the scmi power domain provider has not been
> > > registered. So __genpd_dev_pm_attach directly return -ENODEV.
> > >
> > > device_links_check_suppliers should already check suppliers, but
> > > scmi protocol device not have compatible, so of_link_to_phandle
> > >       |-> of_get_compat_node
> > > use the parent node of scmi protocol as supplier if I understand corr=
ect.
> > >
> > > I am not sure whether we need to revert the above two patches, or do
> > > you have other suggestions?
>=20
> Hi Peng,
>=20
> Thanks for the report. If you try this series with the following diff, I =
expect it
> to fix the issue for you. Can you please test it out and let me know? The=
 v1
> of the series removes the dependency on "compatible" strings. The first d=
iff
> below is something I'm going to roll into v2 of the series and the 2nd di=
ff
> below is fixing up the scmi bus to set the fwnode for devices it creates.
>=20
> Thanks,
> Saravana
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flkml%2F20220810060040.321697-1-
> saravanak%40google.com%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.co
> m%7C4bab1e117c1e46b8cba908da8144be22%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C637964429490344320%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZIJqjOJb80tBKhEvCa8ZilQQY0OF
> LZBuon6H5A7%2FeRU%3D&amp;reserved=3D0
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c index
> 2f012e826986..866755d8ad95 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct
> device *con,
>                 device_links_write_unlock();
>         }
>=20
> -       sup_dev =3D get_dev_from_fwnode(sup_handle);
> +       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> +               sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> +       else
> +               sup_dev =3D get_dev_from_fwnode(sup_handle);
> +
>         if (sup_dev) {
>                 /*
>                  * If it's one of those drivers that don't actually bind =
to
>=20
>=20
> diff --git a/drivers/firmware/arm_scmi/bus.c
> b/drivers/firmware/arm_scmi/bus.c index d4e23101448a..0802bdd0ebfc
> 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -192,6 +192,7 @@ scmi_device_create(struct device_node *np, struct
> device *parent, int protocol,
>         scmi_dev->protocol_id =3D protocol;
>         scmi_dev->dev.parent =3D parent;
>         scmi_dev->dev.of_node =3D np;
> +       scmi_dev->dev.fwnode=3D of_fwnode_handle(np);
>         scmi_dev->dev.bus =3D &scmi_bus_type;
>         scmi_dev->dev.release =3D scmi_device_release;
>         dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);

The issue is=20
really_probe->device_links_check_suppliers
Because we use scmi protocol node as supplier, the supplier
is changed to firmware:scmi. So the supplier check pass.

However the protocol device is created later, before the protocol device
ready, the mmc device is probed and dev_pm_domain_attach
return error.

BTW, your patchset  plus your new diff still not work.

[    1.583526] arm-scmi firmware:scmi: Enabled polling mode TX channel - pr=
ot_id:16
[    1.590775] device: 'firmware:scmi': device_add
[    1.595256] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.601805] arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz=
:4  (loop_num_ret:2)
[    1.610098] arm-scmi firmware:scmi: SCMI Protocol v2.0 'NXP:' Firmware v=
ersion 0x0
[    1.617731] mmc@298d0000 Linked as a fwnode consumer to scmi
[    1.623279] mmc@298d0000 Dropping the fwnode link to protocol@11
[    1.629270] fw_devlink_create_devlink 298d0000.mmc firmware:scmi
[    1.635257] device: 'platform:firmware:scmi--platform:298d0000.mmc': dev=
ice_add
[    1.642590] devices_kset: Moving 298d0000.mmc to end of list
[    1.648166] platform 298d0000.mmc: Linked as a consumer to firmware:scmi
[    1.654840] mmc@298d0000 Dropping the fwnode link to scmi

Per log, mmc not take the protocol@11 as supplier in the end.

Regards,
Peng.
