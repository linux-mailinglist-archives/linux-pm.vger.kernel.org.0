Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C07CC5FB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbjJQOf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjJQOf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 10:35:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82CFF
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 07:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2DkP6boV2yKLTfzhUMlNh4CiQIV54OsaObg3r7E58JlPwoV25+DcHbNQJMHfdER8BGloRc8ZoTWE2+G4UpoWztFZioDwzLiiy52Dqh9e6zw6gxr4Z2PT0S2Zn+ll0+bkuYfzybS6HcpZBnmjnPEG6tc4eAre6dur/r6r2Jtx+Fn1UK2Q3cdpq9u/n1vNI/cKkh/BH1bCyBLf5VGztOCDubxC1rI4RoeI6CBl6Jwa8PUDQy/k4/bgCCGrw7DR1IWnSMk5pzkOs+qANaCCxw1DCoWSLfKx8jQoKUewgaWvR5jZ5DvUwB5+jnvNxc+vYg1+kKNbu1rHhFgIDyrNitBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRqocSF0UGJfrw8+Ds+PFNx1D6ndGmrkcOTyo0PxLDQ=;
 b=Qpodim8HX8GBZSG4OC+dj97xXgtXtl6xeE2MvNoLs5hcTFC/oG/j+mnnTcxXTO1zBA4y51VcGZOQykKWKH5KWTmH4bHRlNo6gejVARRCm803rRkKhmgJzRy9YpUo2cyGdLifMurZz5fz9f8iWY1BcXEQE/wzbAaCVGOHt/8ynkqx2T8QLXVWYQoR2EpjSFG7aOTSYg8H4GAxr+d7wsGeFuZ8bl6uvLEgnAhgho3fxU4W8TtuWg6V8TZ3wKBDE7jI4X6aXURqr+tXEdJOzQqtohFrtXIWBqeFZ/m2rdVvyU3FCSS7syZ5ZJOlUirxwfnPGsj9xIW4OZmw0jl93pKsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRqocSF0UGJfrw8+Ds+PFNx1D6ndGmrkcOTyo0PxLDQ=;
 b=OWwE5z6kjiYpzWC527087A+2N4l7nqWkez1Xla6g4FtSELlGQ6ch6c6q85OjDd2VkKwBIVKUOV8m3DAp5UzjohuQAhnYtZqnmiwrU2ElUBMgKRV1s8SDyXKa8CnnKdoq7FCIdo+1uhTTZPURgSelMpWPXArMrDln1vFjhbSe3w8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:35:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7a96:ccb1:6dbf:c381]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7a96:ccb1:6dbf:c381%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:35:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rAAAKUSgAAAVlkAAAJ6koAAEqiu0AAUSrsAAAoXaoAALVG/gADP+DUAAC4lOtAAAZpZgAAADowg
Date:   Tue, 17 Oct 2023 14:35:49 +0000
Message-ID: <DU0PR04MB9417FE7E2D1861FF0B4E809F88D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus>
 <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
 <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
 <DU0PR04MB9417BDFD8570B5406A62901788D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZS6SUXQEknsHWJxz@bogus>
In-Reply-To: <ZS6SUXQEknsHWJxz@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8185:EE_
x-ms-office365-filtering-correlation-id: e57fb535-b031-4c68-b02e-08dbcf1e5bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YE19WVQSPZL7Ky6KOqzfaCldYUOiDVBH6mozebDkG7VLkq/dqMFvQAmFbpmDjYRDMQeAsYIXwo6e55iO2D65OsjGUz5Zsfk1vRE3j3QBM2OOePExNNl+4Uoiq4kFAImljkHsQjX19TLOQ2KwBbzVjgzN/78wjVLZ0dAGEAg7PzroFpvzrcM1Ade1N+g0IsLTui7GuRVy96tro0ClnFXSvhizWYeBBjKldVBHliKjiY9JxMhYIIDiascDUnqREtAH8hMopQq62ryKjyPjuPzOxVOtz9UmrBDM52CLxwiT7MwzGEJ8wk09mjxaNHpw44NhSS+kDbBmhyUDEIceUxQS5zuLK4bK2sFQ8SIoIgsVuSKUJq5nR+GITyXqBxNcjYGiVLDx7Qwg2v6Qy07rOrSSUayYWFO+ZSr93u/hc8Cz7qk5uURisRzA8y9/sQUo/cFqOpsrgp6h0hKFmUe8UU/7sGeH1RW4XEeZ1P+MGxct7eWRpN2AW+RdQ9mg9y48vTUaAz59hGnD0XlcU6RdEJ6m0rYOi7vImYduk90dJlMTws8Bja3KTOjXd9Orx4EHhGQ0Xgep+e/u79tkPCZ695KpGAN3UiB3qnmWQtMczILt1kcXtTgzKcxlDeOXbcZ44pTa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(26005)(7696005)(71200400001)(8936002)(6506007)(83380400001)(41300700001)(44832011)(4326008)(52536014)(5660300002)(8676002)(2906002)(478600001)(76116006)(54906003)(66556008)(66946007)(6916009)(64756008)(66446008)(66476007)(38070700005)(122000001)(316002)(38100700002)(86362001)(33656002)(9686003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWZ3E7ZFlo4S9zhcpbdfWMqvu92GDVIWbRoEIqXNg3tNEMuDO8cAsV1DM0w7?=
 =?us-ascii?Q?VqWzieSGBUrGCZbyFAqomz40QT6EA6z7Dm0VJ2+HDh+uFLc3tMag6WGjiRgp?=
 =?us-ascii?Q?Zk8Xxr8Qf77ZYKPu/kR8pT5xSCadE5Jv7qpU5Uc+jGNDL5P8mhJbXFRrCHeZ?=
 =?us-ascii?Q?VP1iCKmzzimE3Y8a2xmwIb3Htjn1DWxEpFYy+nX6gG/9DawLGEBaGYJPGF20?=
 =?us-ascii?Q?hMiCdZJ11uHvzBzjjP+UEqRHd9bqy9Dt4HiQMyFs3/958blatFy5wtVAHac8?=
 =?us-ascii?Q?cZRbJ1zzOeJjUKuekEusY6QPI6LPefbzBKv081hdJp2ewfNKRY14G2hCYsio?=
 =?us-ascii?Q?Dmc54g7hqp5pwaV33Y6L73KKUfotCGd79FoQTnFdeSy/3fk0QhzNduMAfN6o?=
 =?us-ascii?Q?Bz6djCNdzw2Uzi9xTbawOMOmuDC89rjHNauIl9dm3kjEg9hfJCzrQGoAIh1z?=
 =?us-ascii?Q?tcEVv9LMjl7JaSbcDsIeREnEwYDEnG/0mt46ngnOkc4Fr/kuUA1C2nRdsRUZ?=
 =?us-ascii?Q?KCkW/AG23u9juxNfk75p5drlEHmmChTg++357C9DDP0CRTzV1ZQjQzXaYr50?=
 =?us-ascii?Q?4bEuW8ewcijWpeOQDU9i9zm+QPOa66P/EGTdJWQrjEhZq3I5a+qQXgJ4Lgu/?=
 =?us-ascii?Q?1B8MDLoJqXw9JqKvtrPe8Wtld8mX40rqJy0aDEcG7TsWTwQsaj2Oe82/bx25?=
 =?us-ascii?Q?Io3jXDF8KwtddTediXrWXVrTCi8Yb/jdPqKHcg5i/sRPNeIHRMLBlNXJSh1N?=
 =?us-ascii?Q?i/tuDqmPeZE7SOCLdckeQwv2b4SuOkZhn7vpARNaEVn9FZivKRt1GV4APfjC?=
 =?us-ascii?Q?lO6vCb2S22yfS+hNDZtv5pYgGltzYZb2Hy4F0Bb5ksEbUsMBafMl0vUlGwk/?=
 =?us-ascii?Q?VRpcMrianKg4TqE6JsxPaL/+bm85DMGagwzuQcxIMMQs+BZM8HzEX+gCUNb1?=
 =?us-ascii?Q?T+yGRsqu83FxC+b1Jaj6wjK00DNqe+XPvyzG0/D2X10Cd8kGlsHYfDoSVuqF?=
 =?us-ascii?Q?y+5VfTKNJpSJI7iXOP2zafg47LXzg3mIf5lXWpNtQvZAuC30p8egoF1l0MOk?=
 =?us-ascii?Q?FC6yul/rQ7c7Oo/rf7X5gprk5/Jpm9nY2m+I7jIs6XE6WPGBE5VzgAd60+Ij?=
 =?us-ascii?Q?LbJCYqgn0ApdpJAxSPsMGRMwlQn8USGEFqv4tgvrh2LQGfI+58/TxGyJaGw0?=
 =?us-ascii?Q?TIuGOsuhtslANF0bke2dZEXnV+2B8s5zVaauJGiPifVQcjKAe+7haL5+2H1n?=
 =?us-ascii?Q?i86mWApRajZuRWdP9vZuBWxVIjPNJarogsn09LMC0RYW+FHaYG2bVPaVemk1?=
 =?us-ascii?Q?SSIYJUWtQiy5bbkUKX9y42+XAf5o+NC2hMEk5V7uUlrA7xQnrMEYsnU8EWgv?=
 =?us-ascii?Q?QijF7X5lUbC0hKrbqzzApo6QZ4GPWwYZ84IHH8xcJGRoslHdZOCgS9XWNHue?=
 =?us-ascii?Q?F74DEbxXO0AHq7bWCE+1w8B9jJ0rIa3C8ZibrCimM/V48UA+HFEo8IWWPPN7?=
 =?us-ascii?Q?ToiKSUqjDh1/WIXGPa5H3Hg4wzSopE/Ax7bIAlEzzYuLe6VgF4XKnL05SdPw?=
 =?us-ascii?Q?yhKdDtb97Pw1BxjzQX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57fb535-b031-4c68-b02e-08dbcf1e5bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:35:49.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eYL+lY1ZP6Xhy/CLubhHFSa1WUyP7cNlfs2iGyTX5Dnh9FdGxqRf1/lxaAd2HqHQ51BElh90HQx9b9IWquTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: Question regarding scmi_perf_domain.c
>=20
> On Tue, Oct 17, 2023 at 01:18:38PM +0000, Peng Fan wrote:
> > > Subject: Re: Question regarding scmi_perf_domain.c
> > >
> > > On Thu, 12 Oct 2023 at 13:53, Ulf Hansson <ulf.hansson@linaro.org>
> wrote:
> > > >
> > > > On Wed, 11 Oct 2023 at 16:17, Sudeep Holla <sudeep.holla@arm.com>
> > > wrote:
> > > > >
> > > > > On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:
> > > > >
> > > > > [..]
> > > > >
> > > > > > Not sure exactly what you are referring to when saying that
> > > > > > "automatic power domain on is broken". Genpd power-on the PM
> > > > > > domain for a device that gets attached to it, if the device
> > > > > > has only a
> > > single PM domain.
> > > > > > This is the legacy behaviour.
> > > > > >
> > > > > > When we added support for multiple PM domains per device, we
> > > > > > decided to *not* power-on the PM domain, if the device that
> > > > > > gets attached has multiple PM domains. This behaviour was
> > > > > > chosen deliberately, to allow consumer drivers to decide
> > > > > > themselves instead. Is there a problem with this you think?
> > > > > >
> > > > >
> > > > > Just my understanding. Since the second PM domain added now is
> > > > > for perf and is not strictly power domain, Peng's concern is
> > > > > switching to this binding will make the platform loose this
> > > > > automatic genpd power-on feature.
> > > >
> > > > Yes, correct, as they way things are today.
> > > >
> > > > It all boils down to that attaching a device to multiple PM
> > > > domains can't really be done in a generic way, as it becomes
> > > > device/platform specific. Since this needs to be managed by the
> > > > drivers/buses anyway, they might as well get control of what PM
> > > > domain they need to power-on to probe their devices.
> > >
> > > Due to the above, it might be a good idea to power-on the SCMI
> > > *power-domains* during boot and leave them on to allow drivers to
> > > continue to probe their devices?
> >
> > For debug, this is ok. But release the code for production, keep them
> > enabled during boot is not good.
>=20
> What is the point in adding it ? You can always hack and test if you need=
.

I might misunderstand, I thought this was a formal solution.
>=20
> > >
> > > Maybe a module parameter or Kconfig debug option could be used to
> > > control this?
> >
> > Greg might not be happy for introducing module parameter, I guess.
> >
>=20
> True. But I don't see point in adding a Kconfig as it needs to be enabled=
 with
> single (distro) Image.
>=20
> > >
> > > In this way an updated DTS with that adds a performance domain to a
> > > consumer device node (which already has a power-domain), should
> > > allow the consumer driver to continue to probe successfully.
> > >
> > > Peng, would this resolve your concern?
> >
> > Actually I am not sure. multiple PD is not a technical issue, it is
> > just adding more changes to various device drivers, we have
> > VPU/GPU/DISPLAY/NPU/ HSIO/CAMERA and etc.. so all the drivers need
> > update, which is not welcomed by driver developers :)
>=20
> Why ? Have you posted the patches ? Any discussions you can point to ?

I mean NXP internal.

>=20
> > I am still trying to enable multiple PD for saying MMC, and see how it
> > works after adding performance domain and how device dvfs works in
> > such case.
> >
>=20
> Interesting. So MMC domain is presented as perf domain rather than the
> clock
> + regulator ? Nice to see that abstraction being used.

MMC IP is inside a block(named mix) which contains several other IPs.
Current scmi sever perf design only exports MIX level perf,  no regulator
for now.

Regards,
Peng.

>=20
> --
> Regards,
> Sudeep
