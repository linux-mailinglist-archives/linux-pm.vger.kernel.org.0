Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55D7BFE39
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjJJNo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjJJNoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:44:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC645E4
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCrsO8KihOdCoQu81MftNvkBQuJ2IyhO+6pvYDrHTUJX7VwY18h0GhwPapNa7KOMvpQD0WujCcG4bkRsMdneBvi1h1k/ANyPzInTWH01tJTqI250VZNSOxYlHJbkLv5CzudZM14uYf2RN3uuhqP6lDSD6kGOXQVeq8pqquSvKLinfn8R7Ihc9aeU7EEj0ug8FOZ+pxYMfxxZBIAl5JTxHWLTZsrGhfVvZoCWCQBZU2tB0kc1z501PCOVWz+PjeahD50dG20EljoL7BvxuYhwAAjmDArLPRQ91xMy8LMwEbhK3UaBS5hzNa+GYW6mayo2cL/7WtXeGPjfj4RnGDyh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1dF4oNEypKG50wnqobJ37ohBjl+KT4XVcTsFbreCWc=;
 b=BGRZ7zbqFAySj5diBfIVhu08LG3pvNvDvJa+ub3nSOdCGluuSQj3yFs1gMjzbkYv94LiDOCxWfj+uTFys0fGDOZJf56QunxGq/3pjWX2UvP64LzfEg2x4YTmrmw6qnPtnx9h8+qKfP8qgWYz6kpFCTomAUQNQKeIYTSs6/5JAcjHr1VK1ORt3Jr3wglX701dATXp6mzeV7yaRtDNVFmpHEkhJKtzZTOyYoFJLtGi0Oy1evbogvRMAIOSZJCzJtWmuoO76MzevSgmdxmCK4JRssT2baejMC3t7JFwQOGvF6MtHnTkK2K4TJ1icjdHfWkZ8ApQD8sk2G1nZuTT73Z7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1dF4oNEypKG50wnqobJ37ohBjl+KT4XVcTsFbreCWc=;
 b=g4GgHq3bHrCgnrFMIEC1NPR3VQV7wFCzqKQ2ntVErzLo9xPA3iAxR24J+GxahQ/T3V0zkTy8DNY3otetBw6qgYTYP24kwrD0KxC24/cDi5UQWSUV1jwGVdn3Zbxeau8MjIuStqxdLIYFctn2g7ngrXPG41fYth9PJdlO+8hhjxU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7969.eurprd04.prod.outlook.com (2603:10a6:20b:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 13:43:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 13:43:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rAAAKUSgAAAVlkA
Date:   Tue, 10 Oct 2023 13:43:32 +0000
Message-ID: <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
In-Reply-To: <20231010133059.57rs52qedrc5mxfr@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7969:EE_
x-ms-office365-filtering-correlation-id: 991c175b-3625-454a-8d8a-08dbc996e4b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sak/DqKGlw7zryYBufCu+DvSvRz1X9RdcPEIk0GF/HWLrP5PZp9k0DN4eQ+WTixZ0CxGiACmLKO+3adSrI5BBjLignop8JoIw5Y/qoXE7j/tdkdLiNKPYor5/bwvcnGnkyhe0eRgwrVFTzMg7odEW08zl3zlmaAAI5qDD9lRBBxuKz2DOebksGfT88ri88jlt+JBaCoNBSyLmXrVi+NDj38SZIlwPx06QmFcubJkZsphNP5KrNy9ylXjEb5EppdIaa5m/HtvyjXSmpUZwXsHbVPFag6yxldcwz63XAEQrJpM18HT3+x2aDGYsB67LW0Q+Sb4xJSvDlLWvyBy/cC5fmJFC+CIcWGVuIZIgiiTh1Q0v74/b0rKbPrTi8aNEGXVlSRoaR35XGLzenI9NQ6sPRMACUAl2lswEB9/POrgrTlPSHKJCChYu3UfcqWtJwJNAJh7Y9tzZpc9Pvspx1tyV/UH5giuHhcM+hRKJYojeN69zxiAv9/QmjjPHVDbWriiacMnzTglcqsBxR9kN1bN7Z+Rzz0CZCwtNBMqoWPP0QNJxqmQFUyv8eFcG8rr/ME1BoKDmlaqPEccTvDEbTaOKIdtvRtOcvvZAzzAlKvFeL81/1zA4DQsbsNPK+fzlT1T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(71200400001)(7696005)(6506007)(83380400001)(76116006)(9686003)(26005)(44832011)(41300700001)(4326008)(478600001)(8936002)(8676002)(5660300002)(2906002)(6916009)(54906003)(316002)(66556008)(66946007)(52536014)(66446008)(66476007)(64756008)(38070700005)(122000001)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4gV773xN7Hnkx3HRCeozis/cjiHF7lML6EaX4+wF6L6gIz3F7/FEv4S4pbnr?=
 =?us-ascii?Q?vb4G/3jyVhwtttuFZFZDTeTmnJSezLdwbrU85aHJi40hCcKy+aK+ebrX0Di1?=
 =?us-ascii?Q?lkVZlGJJvl2eRk4pGqUuX1Hqv2HbLv93ywhplFX5d5RK9jlKoHsSr3gBwOHI?=
 =?us-ascii?Q?cuyg71gQgWAmiGSzyxvl3uWtQDCMqQCZtT1S+iFKh4UzIx+1TYENHk8WM89e?=
 =?us-ascii?Q?eW2jtWaYYpn5bxLwmZvtVVepkvHCjzM7XVvtmUGnxvBvGjY19y+R2IXmt7qa?=
 =?us-ascii?Q?IQE34l6Ze1uRawyURKJCTB6Ll1kf505EGn0C4JyK5cCEPXLrRdDKKeBzGy8i?=
 =?us-ascii?Q?yzWCCPvnXd/DfQE37XVYr9itrw5W8mVWSbLs6SnHk8Te6GwHwJWCjJQfGYBE?=
 =?us-ascii?Q?sFcQfWAILhoxj0q+LwICtsQ9eMFkaoDELLU7FjrwOOa76qwPtdGSP8DJQ2FO?=
 =?us-ascii?Q?z+q7NifZvfhR+FhbegUrAd02jIwJL8ZDZFg+jB2mlLAMZIuHOjJ0GecfFcyl?=
 =?us-ascii?Q?5sx1yjTA1BVd+4A35v+sxdW4bqFEd/QsJgIybKdCTRoLQJ/hEf4Bl61nAjEA?=
 =?us-ascii?Q?lLV8rTj0M53Yi9Y+rVljjCe0f0EqSSG6QuSa7Euzg5F4f6/Wr0Z67pW0jRpB?=
 =?us-ascii?Q?4MvOvZZ0KwluGWkqN3N+srUHfBe+4z4Q8Omc2KtFU2nM2OoEmeYeYG7XASwL?=
 =?us-ascii?Q?e/e4eFQl7YB86dCrn5m0giUhp9QkQMjFpEI3mbTD2rXMXUaukWjwJi8JbC8+?=
 =?us-ascii?Q?GOHBVwHCB8jO4UUcEFQzZbCPfQAEGwjjhnXa7+j5w/Rv+IzeEJc6UogmfY7B?=
 =?us-ascii?Q?RP70oRbbHtSINttcC0Nkqt5QzpD6QaRLmzr5LooNVvaBuAgskCWmCaheCsTW?=
 =?us-ascii?Q?/O+1P8D6ixCghViC/oaABoJbjLju/KfTeHvvwtn7QIktR4q2xuLN951LjG5T?=
 =?us-ascii?Q?D9yJr6mKTdg/Hs6iwtUrxUIIMwz9XdFF4JMBxlk0hP08A7MO85Wc3EGy7Ux3?=
 =?us-ascii?Q?a73d9R8kAyAQZfD87IxwUUv74ESRXPOOq6WTtyGfkS2vXLCj79MJUNMJoDYd?=
 =?us-ascii?Q?mgoIwCDl6ME0EEun6t8QKBsQmfqgLuG+0wpZjdwkaUTuHMtvHaU5oxfczuWH?=
 =?us-ascii?Q?ull6TJXqqSXqopNg39Vxme1TFMr/dnj7siDoS3jIsz3XDK90q8vBL6E/bsIw?=
 =?us-ascii?Q?TcKNmZN7dSJ3Sp0bOO0b0q4eeN2ZWPSrmOo6ACjTQNeMAmLGCUkrBn4tWIqF?=
 =?us-ascii?Q?3s3loT10CVnxhpND85tLariucz9vrkeetLKkbO5unJmPGHeVsAlnI06DfpUL?=
 =?us-ascii?Q?GgfsByPnpGqn5PL7O5OSaFXR5ndX7PLlGBzxv9aEA5MxzIejRgaSwUXMkSEH?=
 =?us-ascii?Q?dB8uViOS3iCwPJJoHjX74gIP2l53cKqM36IJoCPW0IQJzUmqfshPB1qrJF1E?=
 =?us-ascii?Q?UB1vI4IlzxKTHNTQxnipn1Df6/1xzT8BA6PcV8XWov2MLyjX9N1Y9XltdGw5?=
 =?us-ascii?Q?TCknxMF+JA1NiDilj6e3nWrRd7P/FnLhNyNR5ihPyWsNIaniqzv7r5/Ny60U?=
 =?us-ascii?Q?lNnRZ3AH+F3gyA/rONI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991c175b-3625-454a-8d8a-08dbc996e4b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 13:43:32.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGzXX4jySwv96HV/5NXMd3pO6SAMfWW1NVh0UtOZafzopvqeB5kuTqPy1yzxMSUBnW3LeNruTPttSox7VpADrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7969
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
> On Tue, Oct 10, 2023 at 01:15:26PM +0000, Peng Fan wrote:
> >
> > Thanks for the detailed explanation, so power-domains property could
> > be used both for power domain or performance domain. But if one device
> > has both power domain and performance domain. Only power-domain
> > property is not enough. I may understand wrong, let me look into the co=
de.
> >
>=20
> I haven't tried this but something I could come up quick wit Juno DTS as
> reference:
>=20
> We can change something like this:
>=20
>       scmi_dvfs: protocol@13 {
>               reg =3D <0x13>;
> -             #clock-cells =3D <1>;
> +             #power-domain-cells =3D <1>;
>               mbox-names =3D "tx", "rx";
>               mboxes =3D <&mailbox 1 0 &mailbox 1 1>;
>               shmem =3D <&cpu_scp_hpri0 &cpu_scp_hpri1>;
>       };
>=20
> And then in the consumer node(taking GPU as it has both perf and power
> domains). The CPUs are simpler as don't have explicit power domains, some
> Qcom platforms do use that. Anyways I would change GPU node like this.
> Hope this clarifies things for you.
>=20
>  &gpu {
> -       clocks =3D <&scmi_dvfs 2>;
> -       power-domains =3D <&scmi_devpd 9>;
> +       power-domains =3D <&scmi_dvfs 2 &scmi_devpd 9>;
> +       power-domain-names =3D "perf", "power";

With one single power domain, the platform common code
will automatically power on the domain before probe, with
help from genpd_dev_pm_attach.

But with multiple entries, device driver should handle power
domains by themselves.

Maybe Ulf could comment whether the genpd could update
to support perf/power case just as one power domain
entry before.

Thanks
Peng.
>         status =3D "disabled";
>  };
>=20
> --
> Regards,
> Sudeep
