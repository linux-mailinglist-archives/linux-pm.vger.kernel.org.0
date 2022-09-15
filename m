Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9C5B91F8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Sep 2022 02:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIOA7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Sep 2022 20:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIOA7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2022 20:59:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD6E94;
        Wed, 14 Sep 2022 17:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ItXFpin0qwy6UdadUI/NfHNQjpb8LHkwMrKn0UY5syvDJlFQblrZ8lHiWNSRWxQln+2tVq7tGOIsnyraEIY4WfSHTt8QvYJ7NgtjGHbOUOcq/SCXfdbuV1WXwca857P0Fco87HXtuMWQd8qXaLXdYbokchSlQFPVBNEaZkNtnif6GtvPODhKfp+dh/vcPbYBjzfuPxbv2y5m+xUBfsiDjYOLKih/crXpv8fbJThviV9TtLMgeg0hccwI1W5L6SaPn0h6p2rkHeIQJk4ZplS/KY88BtaSonnTSck3Y2Z5k9a8F3M9d+/4kv9zb0fdK/nKkkXWpZMgoNwKRQG3ZhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUWtO7FTAxTGDDiT/kFYSl9rhrMAuuMig9LTzGo4zVo=;
 b=SpKoL6eLMpr/eH7ITq8MuMkcj2I7PDGdgcMFy9glhlVTgFpAbKvK/1dpqeorTZXz9g7A+gXqD2nbJemBZ5CiNBpc+xkJtQLzGtSwHMq78zDXeZCUDYZzaeTGm608C9mcPUJIOjrMGfusXfb0OVKRCI9Zr8P7U/teo7MM3gvrS9KYzuzkjwAJDFuF/PSSm4unV7+ScvpVNsGEmEDNk/TT5DCmmxEB0J+FKAycxSNAunqIOxO4ekXDpGnuBM9iUNREV5SZvLiz0nXXM2nOsgrK7YQp/lzvjHzGQJ/3BIZEIzoKzbTpR5KIXcmyQIH7SCBtaJtI6sFsnRc1WtGyweHbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUWtO7FTAxTGDDiT/kFYSl9rhrMAuuMig9LTzGo4zVo=;
 b=TaV0FJylNZT3xtcLEBGw53h74CY38fYo3KTsoqCuHgK7P9+oXs5plLDOKfDAK6PoczMd+GBIXWxlPVGqlRsEPRQMSp3N0dFwAkgeseNvj1HanoBcD/ctxRwUpY7fh6Hz7LJRSC0ezyP0As9P5eYmGuVawGU8YvxPqvg95KpFqmY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7247.eurprd04.prod.outlook.com (2603:10a6:800:1a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 00:59:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 00:59:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: RE: Question: why call clk_prepare in pm_clk_acquire
Thread-Topic: Question: why call clk_prepare in pm_clk_acquire
Thread-Index: AdjDVBjUt0pijoGuQyGRoo5K0OYp9gAPGMmAAAZWSgAAJMn7gAAJdZYAAJtOFgAAAFDqgABfaFgAABO20sA=
Date:   Thu, 15 Sep 2022 00:59:32 +0000
Message-ID: <DU0PR04MB94178803DCB15BBA18E32B1F88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus>
 <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
 <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
 <20220914153038.inbch35g7ldsyzhx@bogus>
In-Reply-To: <20220914153038.inbch35g7ldsyzhx@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7247:EE_
x-ms-office365-filtering-correlation-id: 7fd0038a-11c8-4e33-0132-08da96b58ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjW2MH8aXyJzhjWnATDDdr5BX1oBnROo30n4Rru/AMziu4zmWX4IZ2LjHIsBK0+a7fQMlJExv2bcoNDlP1CfYPqx1nuEXgAjFxCgYlMOfY/IIO4L4t9nPsZuZfq80Qjzexgjj7NOE56/dahhbqhePiQWZ+rW2ukKTH1u3RF+7FJZC7UW2xF2tIp0y3yZSXpxdhI0qj6wPF7ID0NU8UogVrVdPoG5FHqnMm1FXsSSRE7O91VxN1hL2iEgk0WaxmvuoiZtpmHaG+dLl6564a1lr2yI4ASu4CrcMkewDW330wIwYftIDfSJb5Q/33tXrNhsEwrTFzaNN5+vzwWCjWfwWmJqgkebSIdTbG2oL+92dlHX5srTzxRuM32sWdjxTuzlrmYmrTvj//0pynS5SyhDxuQQHffcd0xNN0fyVzGsbQQ1dXFZSX+ibVgQNesqH54yudkMNE2prkSutPh9yaqHbsPShjk5h/ENgdhmBVx3BHT/ImCIZSW7Bo9/IFtK8jSSmQsACbYj/3M8NuMLrBwB10gj0yfuKYYhvHrtZ2oz4lvbJKzXfR+xRhoYcgKbIvpnpw6IRVl95NAHON61F2PlX1UvcEn4jp53KahigTmaTGzTQgA548mTOgnYGAGuClExwNUefCTCUMy+28J6LJ9q6wIoWi72sheZczYwVoFF8H2aArAJPA1pwB9gDEOWnKERlo2TYN5XkC4woP1HDxC8XR6/Xf7gbSb9CK5Twvba/O64zoDr8ZZNaayq/EOgHJVuXob3CIB3Iu5OLfWhRYyJvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(110136005)(54906003)(86362001)(76116006)(33656002)(38070700005)(122000001)(186003)(83380400001)(38100700002)(71200400001)(478600001)(66446008)(64756008)(7696005)(6506007)(66556008)(66946007)(66476007)(316002)(9686003)(26005)(41300700001)(53546011)(4326008)(7416002)(52536014)(8676002)(8936002)(2906002)(5660300002)(44832011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7P/ML6K7mDqSw0AiZxfKHNibxvu2y8/gjKhtpyFeOfRtLuBnUlj+i0m+xj93?=
 =?us-ascii?Q?B86xONG6ZP8+/f+MQiZdIPupm4Uu7jteqDuKXJWMX3d3VfTJvknVJMWY+Syi?=
 =?us-ascii?Q?NY6IwggVn1IjQVvhJPujZ4/4BQJnIeWv0CZJ9UdwrItayYSdxp2pwpfv2HGy?=
 =?us-ascii?Q?z2007ZybdBS88uc9lpGHW0eHGfre/YahD46/j3iEPXBjTJ6ZiT8Ibtp5EgLH?=
 =?us-ascii?Q?yChC+Cxlgbf9zuxC6aC4BrJYRSmOBVFQxasn8Iopnm0Obw11Aan3WwCw3ILR?=
 =?us-ascii?Q?89q6Xv5VpqDJqWuih9qp+o8RsAsnpWr/B5tAOrV/BYM9pnpWVAZ00dztsAJt?=
 =?us-ascii?Q?Kba2Lf6EyGQz6jTR91FmPN8dW8Bj21xlCf4fhAAf3OAfq0iuBGS9S8fIJ/k8?=
 =?us-ascii?Q?z898dGVb1gZQV+/kNG2PXVdFgx0bI0L2mgYq7fkcdjIuv+0fP5lLqkTO0+uD?=
 =?us-ascii?Q?ETD7T1S9PZVhYNruyP8D0ApTHhltpI3b9ZV75D5dfETee7Z+ZOPjUIjx7f/4?=
 =?us-ascii?Q?4U/IlxqTbglERRC2Vp4PzH44oDgYjod7vxHzI2MAzz8tg/51oSRXcV+mR/GM?=
 =?us-ascii?Q?re/OHEylFwSCPBMVb/EIOeGBepuG8TuSO52bJmScUNQpxSTeXX6NyoFKRJbw?=
 =?us-ascii?Q?dBnsOfqlylNjU5qCZaJVDSguKpncNON9fZonZGAtdLByBHMPhzw1ZFjq4gSC?=
 =?us-ascii?Q?fAhKYPk2bNsn31Gkf83L9+rXI/2M+BAD/bn2B/JhIPiav+4f1hpDAlSBJOGN?=
 =?us-ascii?Q?lyvUmxohDoHUUB9gEUXoOZ3T3/aaRICmkVvPN9Ua6SagCr2rfoG2JrUtT2qm?=
 =?us-ascii?Q?k67LP91iqKCNJjqkW381miNdpCdBST2yQl+Kj7DjCWIlY69m5kuM2TqTCM8q?=
 =?us-ascii?Q?eZO7ed8FW+bNh4A2p23SlzFCXrVLzkdaCl1kHiK8iOz+AOY7a8eBBT42NQA/?=
 =?us-ascii?Q?tkZwsGAhxHI4v3SCI5ZNwwIYFuW+v69vXhI/qlExYNnwB+AOHOy5dvY0Qy9w?=
 =?us-ascii?Q?9I1wIdNZ3zyd9ksWouan+tv4T7AzF3FcoawsVQNBQX+Wb1WS9ebzqfGc3Muw?=
 =?us-ascii?Q?sSg9gCTqQ1hCZTpVq3k2E4brOMSpNv4GgMwHRbwU2R2L4JC8EgNckCqXZPxx?=
 =?us-ascii?Q?yVSWwBtnU4MRb5+AIOA56W1H/gQEhet5JJ1x3xQUow+7h1n81oj/Y0gLN/fU?=
 =?us-ascii?Q?G/OmjlluF7/yYrdTGzH+hi6tG5D8nKYOmCbbapaHEZ2HWcnwlMduikVAVsvB?=
 =?us-ascii?Q?UEBdnKiDS0N3+lz/Q4OOBpDUfa3lHzC3MkY/CbSP0lqQJSCNAfovacdMgm1t?=
 =?us-ascii?Q?bAb39dNjz7tn3kgpzzHJAbD9ACrDgNFfvZNvNFY2fYhXi5RdGBnYEnRZ++6U?=
 =?us-ascii?Q?xjTJwy0zFQrayYUyJJn+ES22eX8X2sfbB6KJIjOWwDnBF5pT0TtyDTCC9BwI?=
 =?us-ascii?Q?VI/x2/UpUKFiocPI4Tfe1jbJ3uXJe/gE7XH+FgTXllJx3t0lpFWKpiU9sDgy?=
 =?us-ascii?Q?2LYXaYERTJBksVUz1ksiNM5x2vZOewxZf9JjhbxI70BBkfA1NhIIh5DhNZPe?=
 =?us-ascii?Q?yraEr6CE9VLta8Ayg/0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd0038a-11c8-4e33-0132-08da96b58ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 00:59:32.2902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNuIlLNsdA0aXb3HEONMRJlnprcItDhwoF3jwRsWKCy8tMAFVMitv7BqThBwC6yXO9LOJ/XPK1CPBqnvbJ0z0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7247
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
> On Mon, Sep 12, 2022 at 06:58:49PM +0100, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> >
> > CC Dien Pham
> >
> > On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-
> m68k.org> wrote:
> > > On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > > > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > > > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com>
> wrote:
> > > > > > > > We are facing an issue clk_set_rate fail with commit
> a3b884cef873 ("firmware:
> > > > > > > > arm_scmi: Add clock management to the SCMI power domain")
> > > > > > > > ,
> > > > > > >
> > > > > > > Hmm, I wonder about the main reason behind that commit. Can
> > > > > > > we revert it or is there some platform/driver that is really =
relying
> on it?
> > > > > > >
> > > > > >
> > > > > > IIUC, at the time of the commit, it was needed on some Renesas
> platform.
> > > > > > Not sure if it is still used or not.
> > > > >
> > > > > Okay! Maybe Nico remembers more, as he authored the patch...
> > > > >
> > > >
> > > > May be, or even check with Renesas team who tested his patch.
> > >
> > > I'm not aware of Renesas platforms using SCMI...
> >
> > Upon closer look, Diep Pham did report a build issue in the SCMI code,
> > so perhaps Diep knows more...
> >
>=20
> Yes indeed, Diep Pham tested the original patch IIRC and also has reporte=
d
> few bugs in SCMI clock code which are fixed. Hence I know it is used by
> Renesas.
>=20
> Hi Peng,
>=20
> Absence of DTS changes indicate nothing. I am aware of couple of vendors
> who use SCMI on several platforms and do report issues regularly and help
> in review of the code. So DTS is not a good indicator of SCMI usage
> unfortunately. On reason could be that since it is a firmware, bootloader=
s
> can detect and update DTS, just my thought and may differ from the realit=
y.

Could we make the GENPD_FLAG_PM_CLK as a optional flag as Ulf suggested?
Such as non scmi clk platforms not require this flag, or any other suggesti=
on?

Regards,
Peng.

>=20
> --
> Regards,
> Sudeep
