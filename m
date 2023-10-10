Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6B7BFD14
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjJJNPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjJJNPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:15:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90944BA
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab0bd0pXOPPUOhF2XDQ8sxHRiWfWFndiEcHKeNSgr8fNfLKuUKyAhjPzi5+Yt3g6x/V+cCbQ6Mk59xIjTe54jmCts6Pw+XW/HYqkm9mmzTvPAUg7JltClu7WylQTXuuBAjH1IEXtAbrIx0mlLwjTSR0DmBPoPtZyEBE4qyS1ZkVBwDKdU5nikBW9AHLS58nnllBdeXnlYth2MiMi+SGxtaS4NQNEGS64roU4Tnt4KSGmZ9sN1O5A1HMwKAaLngsGh+4xQLvQ+5iqFN52dOXZBJrGVM5J8Zo9mQkL2C6tOy5p0rf3iMw5qXTVyvSA2bcDiCeOivTGCUIBbkUGbvFXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ7iSiOFuzDlgifoWrU0cJDvavguwqXU/9rj1T76+0A=;
 b=OYMItHnUpdlxc3sXsxRBnoqUy6miewJUYxgqcNlj/dYvyQjbiN5e3SUtEII5e/Q2uvNweBsPYrA3lxXAr3SO8NHFQef0QIH/auRTQO8wK4I/AnmJ36nDEhpVh3V2DRI5DETaWdGhY4bHhToO6h8Y2rYTJg0qdpxb10shcN1uU6yS92xqsVTOhN+Nk9Tpx5JsFXYFLJcCbA4xyS1/nk5wS+aoUT8WA7DpuLqL3cRaJIYf55wRX2fzOvYcUTN0LSdYoqXwGr7J0RuM3QXrAcaWyYbAX+D1TmcGIXBql1aesWjd8U2JCo95suwNtmMqZMImutFZlQNP56ctoEofHYfmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ7iSiOFuzDlgifoWrU0cJDvavguwqXU/9rj1T76+0A=;
 b=cLvMaZfICd1Rgerh9yeMkx9dLn8WU2dtjVZ9IUme3sXkKZSFWkx54NALXeuB4EK6SO3jQzgLfieYITbGW1+ug/RCwDCvvs8IDWvANFCFirpWom+ZJ9M2uKNxP17HiXyiNI5eF6ufIl6DGxXIOl835R0C08nRM3WicuxCsqsPBps=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9503.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 13:15:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 13:15:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rA=
Date:   Tue, 10 Oct 2023 13:15:26 +0000
Message-ID: <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
In-Reply-To: <20231010130054.ieylxocuapugajif@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9503:EE_
x-ms-office365-filtering-correlation-id: 559e95a2-1127-4083-518d-08dbc992f808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWdc+F4/X0bj9WFQOgCUcfzy/0Fxu6iUFcnC90qCn/OxMH3cuFgbG2dhpNazRYvCLWkS0zcYIpANAfAi7vat0RScL5CemYc3JdryfvkVZWUjvU9NG5OFy9WJid0CJUXV4CO8mMTUDeL/MRPt2df8a8+t4fRLXNqf4n5bBIU+QyXR1GPSBiNq33rAXdmEW5NXxf/GHSKpqyZspdhfHPqFYe1K/e6+0d4+H9oOMpk+2ST6jkGEg/5oJyMSTdDFoyfll9QoWSRzaiVNSq92u2NujfF4c1OIazKSJVx9TH942Ypye3fz6VwgcTfai7EBZHL/5cu0bm7WN1KVtrPJ9bkFKhCHV+wbDhX9vJYIJ8M14qZtHvXUgPim1t9RvR8uOdnfWG5oSpEFVIX1/h+txkx1ocgr/6Zm4tyoDeHgYepBgQyUTKqyptL8K/MVdI6Bg4627JWJsyGWFYminYHiTxxJLamJwD8EQNgpVzfFtcJZfUwyLpYi/Rlndzt5WjrA4Jh56e5IoMhKoS780qUKOLYVy0FVbEgkF2oNUZAwoHqu5aBfyrL4ovRSOCGXaWc9HEV+BpKsEGCm9LY9gOsgFCglvG1/KppqE5pi/5TqZ/cQweF5zU8yOVRq7Yh2DO+BF/+R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(9686003)(7696005)(6506007)(478600001)(316002)(41300700001)(71200400001)(83380400001)(2906002)(66476007)(76116006)(66556008)(66446008)(5660300002)(52536014)(54906003)(6916009)(64756008)(8936002)(66946007)(8676002)(4326008)(26005)(38100700002)(44832011)(38070700005)(122000001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/y3ZMgqhlKXFV/osoxO8RtFJbglPsii1ag0P1W0fdTMFEfcHKBAnN1Q8tCW?=
 =?us-ascii?Q?bfKPt/WrpdfDAbWC4nZr0Rrn2meZSs9GCX9Xf7OW22PpQZS9RV1Xf8E/4ylo?=
 =?us-ascii?Q?S7ZoqpqlHi1+F5avvpJOog6zwycVcOf0Xkxri8tl4mV5X8MpbndKpO6GJFwz?=
 =?us-ascii?Q?Al1cYStv91ZFw2wo2aqYVYHsaqzEVho1jkCsxk97tj3axuJeRFOw2Mtjn+zj?=
 =?us-ascii?Q?Jktp9ZKdqMx5o5lCXVIPt/kzk1pLA1UPE/Ors+ihSXfx5pg6qpGRN+XSlh1N?=
 =?us-ascii?Q?M1gg6MeHu7FVwVw310croZE2NJAD88MshLXVQGHyz27/wmq0iZ/LSqVBDcLI?=
 =?us-ascii?Q?mwN0pUke9EpAbXz4E5cHAJKB9Ok+3q3fVKSNTRklCPf2MQ9KsxAu5D7InBlJ?=
 =?us-ascii?Q?lX1wRR0/HG/z9sB98SJmZWwotXk6X9w1zTikRiFmgnd92CJaW7XXWTa3xkSY?=
 =?us-ascii?Q?K7NklVE+cEcF+NlRPG7drfEbc8K2+OPROsgYxzp29/wTPE5iJA6cpM6cTyhs?=
 =?us-ascii?Q?C2h9qCwY+eouzRTQRnpGWoPX917qL6e+W62gKR7H/8s6pKpS8mjmdXGx43x7?=
 =?us-ascii?Q?XE6CVfdwcE2zELN493tW+8A3QbbqoPmkh9fy1b9hLtSxUhPaGRvn2W3TiUFh?=
 =?us-ascii?Q?veW64L/vXbSYgsitxP8zo6cuEHa5twOZmmG3VBx8BcvdQnGPBCted1BF6QNY?=
 =?us-ascii?Q?+4l7IlylQG5sYuf+qxqk94rHbhjkNdD62p4hZauWw2rbBwhkbDPAoa46P0uv?=
 =?us-ascii?Q?qnCgNKo3y53MSaEjRUXi0dPv8d5zZaVHXLCUElCvL7+34ICIDPt8ryAHcjbG?=
 =?us-ascii?Q?agIPqcOsTf+wqZhYPB5W7SR475LDrhlJ1iMdcrK+KOPFqyHPrtSQwzivNil9?=
 =?us-ascii?Q?n7TbnpFszipWjV0luZFmzYt5c/YxBdu7DVwuctyTbbseAIhFtEw0Ro0QuC9f?=
 =?us-ascii?Q?XBOu9um6nyHZV9kEwflxgNzvtAUjqqF0r5eFRfNezXCaCy9Kr9UZ1KOaOBXn?=
 =?us-ascii?Q?mtLmt5p/331djv0gRtcwrp7CKexu7cEAzGjHee8yJdIZivVaPN1J1plVJYcM?=
 =?us-ascii?Q?U/4dC+m5CcfF1EMybu4yip6CdeOWu9JUSau7aHeUFYWSP6WvG26lILo0f73+?=
 =?us-ascii?Q?67YS8cDDumu/pSngMedzPhr23ukOLMLoVj8s+5bJ4sn7a/5eV+oUdszkWMli?=
 =?us-ascii?Q?um8Fai2ZkIXUwOeVINGq/50NBzRNS7WMtf/capx7zEksDq6Yrs1JCdKtxVSU?=
 =?us-ascii?Q?6if/60bZqEEfVGMIeAU09tZpC0+3+zopjyQXdyJr8Iu3UJ/gtt9UaLNAgK3Z?=
 =?us-ascii?Q?W8aAV+y73Uv5uPkBgIWQO5T+oY5KySZ2stde5qa8ZcNKP/Y08wDe7A0Ac4GA?=
 =?us-ascii?Q?W1u/MNNu6q9I8wzyuvcl+rIXqRwttFQ590WaAD3cUTDuEd9F5URODODoYCp4?=
 =?us-ascii?Q?N597O2kTasvJElDZ8ypz+MMT954vjKIxnPsYQ/QOBgwtLIvhjjMtHssVuIcM?=
 =?us-ascii?Q?xohi+26krbBYOLAdDvUrey2iTipr8QjB1Z+TmB5b3r8TrxkibuCRDeKUESmj?=
 =?us-ascii?Q?F39Jx9B1ycOiHEI7n+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e95a2-1127-4083-518d-08dbc992f808
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 13:15:26.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X088pZI+T+rlsXg8LdtyHzb8f9F132Thpg7nlccQNz0nmX2uY+ahR9Zir0RMjHNzDFkuN7u3HlbbyiHpAGTcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: Question regarding scmi_perf_domain.c
>=20
> On Tue, Oct 10, 2023 at 12:01:57PM +0000, Peng Fan wrote:
> > Hi Sudeep, Ulf
> > > Subject: Re: Question regarding scmi_perf_domain.c
> > >
> > > On Tue, 10 Oct 2023 at 12:55, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > > >
> > > > On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> > > > > Hi Ulf,
> > > > >
> > > > > I just see you wrote scmi_perf_domain.c, just wonder this driver
> > > > > is only for devices, not support arm cores, right?
> > > > >
> > > > > For ARM cores, we still need scmi_cpufreq.c for performance
> > > > > settings, right?
> > > >
> > > > Sorry if I wasn't clear. The reason I mentioned it in private is
> > > > that we now support the power domain bindings in the
> > > > scmi-cpufreq.c as you were little bit nervous to use the clock
> > > > bindings(though they work just fine, I understand the possible conf=
usion
> with the clock protocol).
> > >
> > > Right, good point!
> > >
> > > I think we discussed earlier whether we should deprecate the use of
> > > the clock bindings. Maybe that's a good idea, to indicate that we
> > > prefer the power- domain bindings when going forward?
> >
> > But why use power-domains? Power domains may not same as perf
> domains
> > per my understanding and SCMI spec not has such restriction.
> >
>=20
> Good question as it can be as confusing as using clocks bindings. I under=
stand,
> but Linux genpd domains were extended to support performance domains
> and Ulf has worked on to support the same for SCMI.
>=20
> One key point you have to note and understand is that on SCMI based
> platforms, you will end up with one set of SCMI genpd domains that provid=
e
> only power domain capability using the SCMI power protocol and another se=
t
> of genpd domains providing just the performance capability using the SCMI
> perf protocol.
>=20
> The set of power and perf domains may not overlap at all based on how it =
is
> presented by the firmware. To be clear(to answer to your main confusion a=
nd
> avoid any further), each will have the set of its own domain IDs
> (0 - (N - 1)) and (0 - (M - 1)) where M and N represents the number of pe=
rf and
> power domains supported by the firmware.
>=20
> > Currently our SCMI server power domain ids and perf domain ids are
> > different.  If linux has the restriction that perf domain id should be
> > same as power domain id, we need redesign our scmi firmware on this par=
t.
> >
>=20
> No, there is no such restriction. It is just the exact/similar confusion =
you had
> with clock IDs being used with performance protocol. It is just your
> misunderstanding, not the reality.

Thanks for the detailed explanation, so power-domains property could be
used both for power domain or performance domain. But if one
device has both power domain and performance domain. Only power-domain
property is not enough. I may understand wrong, let me look into the code.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep
