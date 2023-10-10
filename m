Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54407BFBD6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjJJMyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjJJMyD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 08:54:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A0B7
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 05:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7aUOmTU052wyKtYVOnbP64gaU0ESgtUb8XLBxHsfW3xf4Y6eMdxWZ637TOoENCLe32j4SKJrDGT6W1PMkonOiAJpyp2dUuMzw3po4U38i8r9n5d0ychQO48AyDLkP4OpPha1lwAIZ4g3lS5XKJbGcmF1DbPkkfflXL4XvartiJKjeBEcasw5nPpRNZfqEPctdmV3VHItoVfGs1tfao+jxuhCrfU6dO/UM2Dn4VYxHxuVlV7iRLpmPAAAQ+Zd883QIkdVaWTwXJ9u9sYDGbZw3VfMxw0f1kNMEOQiXpWra03sB39NPjosNNDlH3Koruwa5tguLyOqqdzUcCRgdycJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0eyDtn3YVfLYTUKdcM2p2d68Mx+xLGdhfIkPE/h4tA=;
 b=N0aQpsj867eK9vN5p1eBgOpuYllToSFMpsKjQ/sydSYhdCCc5K4QU1k4KLuI6WbbHJ5D/xLNSdEKYwmzFgv5yh81WApUvdDl0F/JB6UGqukzAUPyM6PWl9r65YQYRXzmCIsHcu/+wNF4/yzIZMJZmsRVSRm8FxreCcpp2vqeN8MtltQ5RKGHog2+omjdqkTgSKf0w+FDsX6rdtOMUolX+QV8zkRRR+AZFuSfCDF1DrlkC81h2rbz6SjIWZbPkV/YRl7RdsyT2yxxax89bUcuAv716D3Ppde+pl1g559nXfDLQcTMDydy6MqWe4G/iqcpOkb4UlD3Al/HvyxEhey6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0eyDtn3YVfLYTUKdcM2p2d68Mx+xLGdhfIkPE/h4tA=;
 b=jlCQ9btnKQNXauCzvPXVvdGE44v/pS0m2Ddw8IPQedkvr6I3sCv2NEAuPTCOelwy1Q2ED5dVXVoW5AcAeJhzjJPE5fK6QlZc6HHf/yAFT4HgPd7A0y/rRH8cnxzky++n9bYyzZK494znh7FirXKroK3zi457VulHHOXL323bhmg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 12:53:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 12:53:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAA7mHAAAAIAew
Date:   Tue, 10 Oct 2023 12:53:58 +0000
Message-ID: <DU0PR04MB9417BD408A9307A77A10A3F688CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <20231010124840.ztzsu5swqd2ez377@bogus>
In-Reply-To: <20231010124840.ztzsu5swqd2ez377@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7780:EE_
x-ms-office365-filtering-correlation-id: c1b8f0d3-23f5-4766-00f3-08dbc98ff876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOmQ1h+In+fQZEKlkbsndQi4OWWU2iR1M90Pw0k03BwEfPdLywUKkfbZGMfKswZarvxRcsnOzm6qFRhbTmHpT65+35d6buuya29kAbpvfqF9QJLPzzbAzUVv5b9tJw7Nq37trXtKjNfwtV7swz6+EbeR5b5K1UFsx1avoz/9Y4dtTjGI/dc1YqN569X2kWG87n1GhaBEef+mjOeM0QrSct09kTPZcnIcvBdEPfMgztWBp85x5BYEKYXGRaruJnyM9jkEIxLOachajQyEZXCOwyqHO9D8DVTr0kXucB5HN74SfUuiMQCGqZcoWr7yFYVE6TjQio2yzSeyYK3QRS4R/sGNkvWf2lJih+nDyDjiO/V4BAy97EgN55EWyZdpTGfZicrSYOzqGLmfLTTQDuyyv1qiu7ZwU98Bc8Yj4s6F6dWoWLoHKyLjXz2qp57vqVrl4fInwwdEk6ler6FD/ur3YgiU89eAxZTVd80/wK5zylTPUQHSg2EbNEB03bhY34Bzyhs4h2L0AhMjygwAZ8eEz1pyCEg+4vGpYBTUhQYJVSjwP74yenAZA/AO9HBTqZ/LpHDi0mddEWGJWwLYTOaL9cc8M7y47G1unfyEpwlB5fFrIp+jzUcZfNgSCXE2nuoD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(26005)(110136005)(66946007)(76116006)(66556008)(66476007)(54906003)(64756008)(66446008)(38070700005)(316002)(33656002)(41300700001)(5660300002)(38100700002)(4326008)(8676002)(8936002)(2906002)(122000001)(44832011)(52536014)(55016003)(71200400001)(9686003)(7696005)(86362001)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvSHTrIPPQANlVcvkHUPkK8ilOKu31VhFrfSkYIe8lB5hiVNjy4vtsdsm5UJ?=
 =?us-ascii?Q?GU7toMB06GRPAGJ5kdDlvHyA9gdje/xza1n+Ok5peJ4pvc0hTKOuHt9RHVk5?=
 =?us-ascii?Q?jzHzceB6vXqnzpwmnG5LEctQtpOpZmFYexiCzZmZYrbhns4oPwynQNWWPQnn?=
 =?us-ascii?Q?mat1K+T83lPkG4flYJIIqpPh0/fjd/ob5QvtkraFV2aMqCgSokJvRA+T/Wi1?=
 =?us-ascii?Q?SEJ8UYRKJdheoZkTN1JDYff078zUJnj3/2d1yY7AmsqcKUOzDj2dzb+Q7xiZ?=
 =?us-ascii?Q?ZbE1H5kWQajLTteesXOYYr4XqUyBgaWEqvvNI8AOToXa3du80cGIhkxvkMRD?=
 =?us-ascii?Q?UScoVCJ4Gv8oW2jYZhtakJa/O/9er0Zqoh4vTCj6JyusXcOVn0cHvR6qnHE4?=
 =?us-ascii?Q?Uypci0WyfcrCRv5rU9f6/OqqQgvlFNVDC08I0Z3OpKS4nXe0P9w/WKgDFyM2?=
 =?us-ascii?Q?NKRgO9ztp/O68xnbp7PFsggTKcVRiNzwLdGHNWXrM9aA96DMF2LAjlhAzPr6?=
 =?us-ascii?Q?6by6yRHacei0NBDre7SekK+oI3dy+DuOvnFu3O8w/AhuD5XUHdoJ7g8MwrwY?=
 =?us-ascii?Q?vF0U2B3WmE3vs6wjYIpqOAldQxrvZ3J6m9OuTc/9iupZohDOKh4L7iC3A3qk?=
 =?us-ascii?Q?abw+Arz6PL0TIx3Lrs507ATh0xl7g9E7mqj23wX43xH69Jsvq8ijRSx9u+Pz?=
 =?us-ascii?Q?XKh1Kl/eNwHz2Tpfuu8w3KK/jvRvPLR3w2YnhZ0FNAWgXT6MdyOQm3niklVp?=
 =?us-ascii?Q?dgZNXtWD7dh7VObpuCV+FM1ev0z7PsGeKpsmMNAzWxb19BCX1bAQ9Tqd3jrI?=
 =?us-ascii?Q?by2Dl2dvJq3ci7nNmIbtrQY18KNw7Eisd2A/DlVv3nWxAPj5Ss+z3qztGza8?=
 =?us-ascii?Q?FtB/F/rJVRsyHcr8SyN9uEZ5gB3WR1Vr4wU6T8TdNV3cXAEXnnIx39Ck6GWd?=
 =?us-ascii?Q?XI6h8uxY65YzIcMKEdwH1rvFuERFfX/mVWN4Ahx5u/o8PuiUp6Tj8r9TsDQN?=
 =?us-ascii?Q?WNXfUlrNomiL2WEcGfA/BzWV5isNVtdsEzwcVxXoJbLztoER8RpS0RiUedEn?=
 =?us-ascii?Q?tLElNpOlvP4gvHDJOZ832EVAtQSkBGe45lX0834mDgiZKjq47I429Y73bvpZ?=
 =?us-ascii?Q?sZZaQe8Vhh8W1cks8lBEHEi9MLmJXmq/GcnmAAq/Ne6vO0187HBbpj7BJQxf?=
 =?us-ascii?Q?SPcldLIFyZzgvpHHg6nXz8WxtXrjXyTVrhaCZCb0C/sG6+0C7MyodXF+1/YG?=
 =?us-ascii?Q?T7LiuvWCpfaynrDiUtQSt3ivhU/jlIhxSRrDpoh+TaAxIEXh7ywi5DMswIaS?=
 =?us-ascii?Q?+uod8LlRabcIAEec2U6g/xJOiAchsGJHDI6HhW/PjuVbwzw68ZWQCd4IXWvy?=
 =?us-ascii?Q?lEnFz1zJCKNN1xSRf/GBnBTndM+W+cnLaTQ42Gzj8V/V9jEaHyAJYIwqXVOF?=
 =?us-ascii?Q?CMi4MX/HI4p0vwfCqW2GehNbabSei2F/W6vHj0M2mhwCWz0SS7Xy9ounuOB8?=
 =?us-ascii?Q?4OJcsu9AzjMFyTJuyGD0p4P/t10zXGAoh5WKhRbxerYfHBIU71VUYxD+U+uq?=
 =?us-ascii?Q?Ol+weGEN9m9K36v0K+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b8f0d3-23f5-4766-00f3-08dbc98ff876
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 12:53:58.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7np+JGaEOnim5qDiYmXpwU1SazQNGezrGXTDrRS/fkmhX87ZLsc+Ciu8l8pjnzWPeeJWs6qHdorMRtHJLttK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sudeep

> Subject: Re: Question regarding scmi_perf_domain.c
>=20
> On Tue, Oct 10, 2023 at 01:02:01PM +0200, Ulf Hansson wrote:
> > On Tue, 10 Oct 2023 at 12:55, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> > > > Hi Ulf,
> > > >
> > > > I just see you wrote scmi_perf_domain.c, just wonder this driver
> > > > is only for devices, not support arm cores, right?
> > > >
> > > > For ARM cores, we still need scmi_cpufreq.c for performance
> > > > settings, right?
> > >
> > > Sorry if I wasn't clear. The reason I mentioned it in private is
> > > that we now support the power domain bindings in the scmi-cpufreq.c
> > > as you were little bit nervous to use the clock bindings(though they
> > > work just fine, I understand the possible confusion with the clock
> protocol).
> >
> > Right, good point!
> >
> > I think we discussed earlier whether we should deprecate the use of
> > the clock bindings. Maybe that's a good idea, to indicate that we
> > prefer the power-domain bindings when going forward?
>=20
> Yes we could do that. I prefer to have some example in the actual DTS fil=
es
> before we can think of deprecating it. I need to get around, test and pus=
h the
> change to switch from clock to power domain bindings on Juno for example.

Before that, I think we need think about whether it is possible to use
a property saying perf-domain, using power domains implies a restriction
that power domain is same as perf domain, but the spec not say that.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
