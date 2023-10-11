Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AE7C46B0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjJKAas (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbjJKAaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 20:30:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C2120
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 17:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwQVGhcbRnmeQ6iI9gj/kFN1P0dpq+EX2jTAYZ86GREkcWwjt8KpXxxBmyUQex18XbFcvlTqJpgqGYI8uV8x6RsDWkyw7du92CivTD6aNBEj6HCPoqYL7wTlcW9XLkkleOowb0T8MHKW7PtDs0w6/0tS1kO6mt2VdHfxfDWWtWVGkxgfZyt7z/gaewE/uCORDJ+WMn3X7QcnC6U4oUmxp9I37NezIYXntAx+FF/vy/+nPwh3nDsyJphF1p0Ez5ef/sbQTsZPhxbSRBfDv/qIWr/gP4m3VmNl1gkXxC0UGkrnl+WXBz8oLw9ul5Rhbh5+WQNVE0Lt50xXcOxgE2ibnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHLBnI/AGSmhywEebEQY3Ip5lh6zQ33/bTXtKxNAF3E=;
 b=BBdD233doWqGQw5Ns4qD8Z5sNUKs/DxkeIoQgmYmCMBu3uReCij+gI9pSEmknefSaNU1msXkLHGEXHyUQTENp4LKSd/t6j3rnXZ1U1wr/AzBi1Z3U/bLOMMcIcUw7G+CrSr5UIzyMjnhIXs+FIa9SgEFGf/fzap3vy7O6c8MDd1Ntsx9Qfy8zob1u890vfRzBjjAfhqmJsxxhV5uM3Diaxelr9imiflY5nP61M2TjzJOdo1aDjUF/jwHmse+UtLWGdqwtj/rA545v23wDnSVAjxjH9v+CeLGhQTn0t6JdwDF1jUHAR4hFOmAq4Ol4z44lA84xYJEM9uFXWuX2IvBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHLBnI/AGSmhywEebEQY3Ip5lh6zQ33/bTXtKxNAF3E=;
 b=K1GANDdU6GcyPgXbI40gGDOwKZpcgG46diop5FdA3U+decFd8JXFThYcZ6lOf33FcdWmFufzThkLeX/4zLEHlGV7SgvuPRpU1eJrfdmfYTSJeZ0DpsBouiuX69Sd0/nbw4YD/u82aKL/g0nM2MPBBeYuQEq5bxI7L2hhJFPmNyw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 00:30:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 00:30:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rAAAKUSgAAAVlkAAAJ6koAAEqiu0A==
Date:   Wed, 11 Oct 2023 00:30:35 +0000
Message-ID: <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
In-Reply-To: <20231010145137.fyxjlsj5qq3elq7l@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8906:EE_
x-ms-office365-filtering-correlation-id: b7cf7b20-5d10-46d7-94e8-08dbc9f1493d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySnuapDXvsD3I0b56CSGZ1kasJzbD66Q0cU75z+wvEJ0F+O0oME54jqsxYLV5vZlyYKFGbwbM3q6QTac+udx3PjP9Jk6HYQur3NnOJA8jMeUHUzBzYChEBw4Cb1pSXniiMpUKzIJhSDzuBiOrNWJut/WY0J+qnNff1bpEiY3pv9hEXJ/z94zVKdLBfu3x+jbCWVqaU3LtWre6HBPaL90sUeMw1lrQ1lVKfaizqIHYbXqYTjw9OmFUxmIsAyVqNuKlpSvQl8yqbg4UtPJLuRt//Et1bwVInKA5l8v3lXoMDKU2+x8rEo6cXKKxtgVDbokVxOWlL+AFcPzBJtLQwdNtXsnwjctz9X6joiJo7JUJ4iVzv+kyEWr+LFyvIjydRyuYO5u4N+0DqNxOgdRJw7hxSNoDdI1De207IYwVkyVvIfd5ynTKrhdZJKewB0HC/J21Gjzj0hAQ4pDVR+dQ3JTFDloDEYTARJKvwvI2J9BlFE4Iq/frtIoz0+o68duR6UIWbZi5PzuOkqSP4C2WnZwZqoDKFsYAPclYhBbkmHtFZgY3uaehmiYDu90fK5+Arm75YwB7og/1fOgVLNRm5x9F90iuteQb9cWSS/4VZj04oXG1y91JEetoWTbHqlIpucT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(86362001)(2906002)(55016003)(4326008)(8936002)(8676002)(66476007)(76116006)(66946007)(64756008)(54906003)(66446008)(66556008)(41300700001)(316002)(6916009)(5660300002)(52536014)(44832011)(33656002)(83380400001)(122000001)(478600001)(6506007)(7696005)(9686003)(38070700005)(38100700002)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5vcltzpXjgZWkzOkVB2G+WSOyA3N5yP5jfIGKy+YGOWqkKhOX5M6rBq2CWH0?=
 =?us-ascii?Q?Lj2OkUVcw/dcl9YT8LjCqC2WYgb94i9RT+P0xpFjtOSncyC4f7AR0nowvzT+?=
 =?us-ascii?Q?T7uVwK1ZOHmdZtyDIf6lnDEauWXfmbqQRvqsdF1DPwQRXhc5+SJ/YVYVuAG3?=
 =?us-ascii?Q?NnxW1a/kgY7DJRCo8uaDGotaGqsQmMzGG/IRls66s1HoWfI4vcl//lyAI5xj?=
 =?us-ascii?Q?9woHyPMBaEXt+9jQniGM5paMF9TS4BY1DGZQLrU3YO9MwlYhRTJh1XA6KLdQ?=
 =?us-ascii?Q?LuXZa3s2lHlHlYU7fmE6vSthVr/U0I/LsuHdNJF0xhG3voAwO2nUf4pMCOSr?=
 =?us-ascii?Q?8xN9loyy1we9iuzlIYIW7MXQb+86nfsq/wAdtP/vDanyL7h48aG23fDFJcWp?=
 =?us-ascii?Q?DVZb2Pmfjws32AmW9Vh7fX4V42RSfEw0Vfj6ChUXDWxosvpl7iPyJ6UUDwO4?=
 =?us-ascii?Q?TU/sL4pYJn4zK/sYwTju2wBDg/Oi7F+vEYJ0t3FkipyQ1Ev0BMoD3WPYqT92?=
 =?us-ascii?Q?BLX7E2XZ5THE+M9gjP1gBXVRu/2by1v0hfK4cy9qUVxW92Euop0jBCat/sJa?=
 =?us-ascii?Q?hPFL1NNTmTij8jUauO7qU3oS+5+gN1GUnB72/L1MUiW/smGxr1iXCPCPXln4?=
 =?us-ascii?Q?+ITQQu9Vrw16aJeNn3a+ugDgbh/A4yLwGcPimGlWoPrsgFg2WfWLmrttgT6J?=
 =?us-ascii?Q?4uDdpXiIPLfkx41JF+ONv1kT2wgXlIncT5hvFjDiK4qyb0b3mSJEBXXvYQxY?=
 =?us-ascii?Q?KlrVJWDww8orQ/Ffm6F6lJLw/cspn02zPAakHDsdOtkwIHQQGSvZNq1eY2QB?=
 =?us-ascii?Q?izsOOXA0p6YGHTDcP5XBHng+pH4sm3/d2qBjcrWrch2foWAoT/6Vl59cgvMe?=
 =?us-ascii?Q?Pz1XCpr0FY9f4QrOPtffzx2XrDos0ysafrgklNo0mmZaFQTQlun7UkrWeHgU?=
 =?us-ascii?Q?hWPEH7J+l/y0GzRGcjzqa6CNapyRIiR5ieWjRolTXoVs9O7mMmPCydVd9/D+?=
 =?us-ascii?Q?NuAWj8SfxT1j3LkxTO6P8xjpXxD4lOemTi90t8b7w2OacVu80/JqrOiaZ3zb?=
 =?us-ascii?Q?e6jf6tmr/bavFlOqpgjdY89o7I6ckA3od1bC4Jr+KDZK8pJynUcPxX2C5bp/?=
 =?us-ascii?Q?zbMakpOOuOU1azcFw4gdxcIBJfu9RIOfbQAqWnvlGmw5HRa3AnBLtqbfDXSR?=
 =?us-ascii?Q?Ce+wXjRLyX1P2XVkL5HwnrHkQv8tq91v2+r++vAzf9I5GXwzG1uFofcHp5zG?=
 =?us-ascii?Q?T1N7Z1ziyfRmWG8el1eyzngPFntzFV7xH/ERqTycm/aGH2xQuk+8rUzXlbnN?=
 =?us-ascii?Q?bGkXlhuFReRRTA0CtauvtwI49IDuvmVYb9YrhIIv6JyeQfRSRtQcaCpCD+Be?=
 =?us-ascii?Q?hhya35T6pjWdq3M3HEd+8C/I//U3a1JzIiHy+8fzHNS3lJ0jWbWaRPXwu7bJ?=
 =?us-ascii?Q?zzPhzFzPmSziR4MfR3I6ZFCV0fdTNDDOvKgXSWoJbKavxeS5GyTdFeas3TBz?=
 =?us-ascii?Q?Y7ejuMn50b0sbtljUqd4w+yV0BUjRkBjA71lWqjen7F26bB9R1FKv/2/mGxc?=
 =?us-ascii?Q?QV3fNPwv1r+pnRRuIjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cf7b20-5d10-46d7-94e8-08dbc9f1493d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:30:35.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpPg/syB0zLhkd2BwaMgxpqcV2MGnStBnn2+K6dpyyJJBDydANxRRgFWig/VDt3Rnbs8UUY8SoUmqMM6m4xSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: Question regarding scmi_perf_domain.c
>=20
> On Tue, Oct 10, 2023 at 01:43:32PM +0000, Peng Fan wrote:
> > > Subject: Re: Question regarding scmi_perf_domain.c
> > >
> > > On Tue, Oct 10, 2023 at 01:15:26PM +0000, Peng Fan wrote:
> > > >
> > > > Thanks for the detailed explanation, so power-domains property
> > > > could be used both for power domain or performance domain. But if
> > > > one device has both power domain and performance domain. Only
> > > > power-domain property is not enough. I may understand wrong, let me
> look into the code.
> > > >
> > >
> > > I haven't tried this but something I could come up quick wit Juno
> > > DTS as
> > > reference:
> > >
> > > We can change something like this:
> > >
> > >       scmi_dvfs: protocol@13 {
> > >               reg =3D <0x13>;
> > > -             #clock-cells =3D <1>;
> > > +             #power-domain-cells =3D <1>;
> > >               mbox-names =3D "tx", "rx";
> > >               mboxes =3D <&mailbox 1 0 &mailbox 1 1>;
> > >               shmem =3D <&cpu_scp_hpri0 &cpu_scp_hpri1>;
> > >       };
> > >
> > > And then in the consumer node(taking GPU as it has both perf and
> > > power domains). The CPUs are simpler as don't have explicit power
> > > domains, some Qcom platforms do use that. Anyways I would change
> GPU node like this.
> > > Hope this clarifies things for you.
> > >
> > >  &gpu {
> > > -       clocks =3D <&scmi_dvfs 2>;
> > > -       power-domains =3D <&scmi_devpd 9>;
> > > +       power-domains =3D <&scmi_dvfs 2 &scmi_devpd 9>;
> > > +       power-domain-names =3D "perf", "power";
> >
> > With one single power domain, the platform common code will
> > automatically power on the domain before probe, with help from
> > genpd_dev_pm_attach.
> >
> > But with multiple entries, device driver should handle power domains
> > by themselves.
> >
> > Maybe Ulf could comment whether the genpd could update to support
> > perf/power case just as one power domain entry before.
> >
>=20
> Hmm, I would rather check if the genpd can still handle automatic
> power on of the domain before probe with one power and one perf domain.
> IWO, one power domains and other domains in the mix. The reason why we
> can't have single domain to support both power and perf using SCMI is
> we don't know if the domains are 1:1 as presented by the SCMI platform
> firmware.
>=20
> AFAIU it was the main issue/confusion you raised initially. I am
> surprised as how we had all these discussions and now you are circling
> back and requesting to combine the support in single domain which
> contradicts your initial confusion. I am seriously lost as what you are
> looking for now ?

No, I am not requesting to combine in single domain. I still wanna perf
domain and power domain has their own IDs. But I was not aware
perf domain is using power-domains property, so one device has
power domains and perf domains both, the automatic power domain
on is broken. I was thinking we introduce a new property saying
perf-domains property.

Regards,
Peng.

>=20
> --
> Regards,
> Sudeep
