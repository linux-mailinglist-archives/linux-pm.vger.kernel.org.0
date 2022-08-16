Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4D59556F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Aug 2022 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiHPIjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Aug 2022 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiHPIiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2022 04:38:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A5E58B9
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 23:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5c631to05QxHINNBtu5WBEeC6n8uy8n1jZSJEjtiXS9LcPe86lX0TXzIxkhyEWhyYug1A1HiCfT4s3+5/2tqMP+Cm1FMzQnGdVlf5gZ6fOF1PD3np42Nli1vYS5uaVNr4/Q3dGdmIsxP6mO2pX0oSXQCzpoHOjk0NorySa0iHH/5UXLBMG03fYp1GMPB+BPhgtrBCyMiWIIa9b/sLZXGk5mJKPjvICkTS62it5te6983lUxsheoeXiTlZaYJw3D37jmMWl5MkbXJ27HH8mRCXLW+XeLNlWn968fe2mrPwR4JYFvu+r5MANV+IwkgE9AuGuM7396RvlTqjFrRtSp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnCDvwy/1BvT3n89HPrQX1L8jDdZmb+tMaRWrh1YkUE=;
 b=m9sOE3uEy/kKQdW0TnPnoDGXo2Ysd5whhz0YCHkja8JduJixWX1JJTASHlpEnN+nmG30sqIhNj+gBBk2QGJlCGFc/hZYgeamsROZxRLySnZOUBWql3YO0f0XGDdKSB1rtZgoCsQsODO2YV6PN7mwXytDoTpLvq3FI3s6kMrr6QhTDYK/hinsxSSGrDJhZGWROpNV1GjByMy1KGd8D0eXPfgXfvwa9FSDwVCAAZ4G5Rx6xOoGIA7NCsFmQHE5uS5lKmMUw9Syxi13q+BnC9TanxOAZdM9DEHYgbnru5LgS4Uswv7/gqzSns5XVGsj7JPiGs/y0qxdxz8GHnBhhARkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnCDvwy/1BvT3n89HPrQX1L8jDdZmb+tMaRWrh1YkUE=;
 b=a6D3gykcu/F8+mGMrTFOfGbMVy6XYWqU3sxdXlRAwT787vtP66mzz+isrKQyr6sOz2xsE1Q3S6+dlLKAloPX0CN4ywIu4Co4JVVDrjau0l6MA5m0JBcwdAv5g3dPr/8M0MV4w0djpddGOavM6dwTklZFx0YjRgGsHHmps7+BfVM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7405.eurprd04.prod.outlook.com (2603:10a6:800:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 06:43:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 06:43:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Alice Guo <alice.guo@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Subject: RE: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Topic: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Index: AdixOGZw9fNTqIJNRCevdBJlb4IAbAAAtHmw
Date:   Tue, 16 Aug 2022 06:43:22 +0000
Message-ID: <DU0PR04MB9417E391B514287D040E0EC7886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21825a8e-2eff-45e4-ea1b-08da7f529d41
x-ms-traffictypediagnostic: VE1PR04MB7405:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JlwaPs7604gc9xEIOW7zwGesSquwS3wCY0b9AeaBcucX5OJzk937gQxB3Vewk7LbTGVZvMOn0he85ry4ynfJ+zYYulGmt0YZb9SG2gU9G3OmBsb78CYjevNwI+8MgcRxrvJ9SIoA6GV1P1o3qPxyV3TYk0z1quOzDClzUozYwwvCE1q+JOo2WgwRqQNuOapkb59Rb8DK6rmIGoNyyXGMWC4RLjyPOXSd45e925h3PLtmV9SVPpJbhLeHAMf/vaUUFDQ+vkbITRQj31CsudUVHahYY3pugOIyBKxlwSD4ai6e8aA2PAqA267TEKFIx5KNSrRQ1VUmQXSaFqlrwleIK1ixwQMI9ydvY8/AqEDV5vBUoMzONfaFW+XnZN58E7XR3z0zPQABo/ckiRfSE+QO+7LQbNTjn80KBPhxqqKPFHudJJnhOnfgv3wkrdmC9nER16fviqA7Bbz5Y2M+XRsmTUtxe22NS8OWc1EPK0B4Xy2RKqQuTc2qJi2U4SU1Dhj5xFC5FrZ+pAdFCJ01S4BeSDOGko2kXsMUw40umn0F+7EZ7cv93cqGhJPjTPkMLjRWiP9eTHVJRVgmpBo1QlviLFFefycsQBi/EbV3FOtVKeRqz2RwnvF8Nez6girEgebA+U1tsEuxc2qSDD1OGtc9TVnZ7Q9egw8xlIEh9/poFYg/PQ/MxsIXSQYkLEX4vyK/OVYlltXkzJLVpodM3vn03BivtKX9swU4wWnsm5zKjWcjdo0GspTmC4DAlM5igDjmI9dpcDnwG7wesJjq3iyv5aS04Erh8d1xhpVfHlTvd1a/ASf0OkfqTFLlkwSckadoQsraQs72kOdBXXmq8bh8hkz9eQ7V6jaxnHbX0UnHBPEV2sVJlFuyw6ANfXL4FmV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(83380400001)(66446008)(54906003)(71200400001)(966005)(41300700001)(316002)(110136005)(478600001)(66476007)(52536014)(66946007)(4326008)(2906002)(5660300002)(64756008)(8936002)(44832011)(8676002)(66556008)(55016003)(76116006)(186003)(122000001)(86362001)(6506007)(2940100002)(38070700005)(26005)(9686003)(38100700002)(33656002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pgSRQkxM8eCUc2VbbSjGO7A09yVpN3NqpHt6maeMYQ/Cki9dXAD5sqejDQ9j?=
 =?us-ascii?Q?a7BclBGq+qbRB6X2Gri/SJNb0DX3GuRYQyfKuDotsaljgQk4V87+ybICilGO?=
 =?us-ascii?Q?oum6xnYIaqqCbg1VmEE0mWK8ZmEhX9mt6VLtFD5InoxIu2qzrpZWA11iEFuF?=
 =?us-ascii?Q?WCwfKD+pR+hiC0qvk6XKLNmK5KufPy55ZPXWYFkOWBLdjNL2McVJtGYCsx4R?=
 =?us-ascii?Q?VOgu6g8EjiHe2m4/WKF6ffkALmygdU5l1Rvn4prPP+7TYbSq7+rEHBKeT58y?=
 =?us-ascii?Q?+shfZTeFqC8j/Dhf3nZf/WMqmhXl6VUH2bPhAPJdGeGZeemPv0iReLq59DTA?=
 =?us-ascii?Q?i3wt4lp0LbCTkLIJWA/v8GfJWV54TgJHPBr7vr+pyfALMMyzXnoye2bPH/mu?=
 =?us-ascii?Q?BpbKtJPAzVMYGVMqYu9cVrjcpO/a5lNxSMfODjtYBXVZqmG8CxMgVdQyU78O?=
 =?us-ascii?Q?XblZF6FET3ZWh3RWqDB5z2yFmpzK2+VQY/eEomAFIiW0rGub+sXpVp3kQlrr?=
 =?us-ascii?Q?uJgLo7I4WaSNE0ZnWdO9Z/kJAJwLSZYhUPvtbpHP35EqJysCeeF656QEw++W?=
 =?us-ascii?Q?xzxXNwCMOKSMCAklz7ZpLbjP3WKa+vOpDQzg01f4hXkElnDRqvXk+S+KBXQM?=
 =?us-ascii?Q?Am3tHwzbmMoA2wEZ9oNzoJNWgSeD9OTvvbn7WH+J+45n/wzLwB6VSdfBKIZ0?=
 =?us-ascii?Q?2FThMdVT9G06IsdkZGGTn//53BoYZeuKEE3CUzw5NXizbZ+/hENlr9lTSlG5?=
 =?us-ascii?Q?aOS76E+dIZwVnaCbdhZ81RfOp7VbjvNuzOSIw2KKr1IUqh+CkZQDmKRRX0rR?=
 =?us-ascii?Q?xZVy9hMtOuFl3nMytFP3jvca9WUDSdLOC0a5u8lpXbOlMVGUKIWKLo74Pl7c?=
 =?us-ascii?Q?QpLVIvdLlV+ZmUD5bqb2W8KKl8SkhJTs1yWPFGrNoVAW96oKMCbPErWWKeR2?=
 =?us-ascii?Q?jDyWa8OEVeg/TWbIXsvqtbaSnXKv16JHFYXiORWp77WaxOOwRwzGE7M8OZQn?=
 =?us-ascii?Q?b4SaVtJAg46QfrOBqY1sy4WsG8ywChyg1VAp5zb2qKT/qI4Dc19MzF8dD8q8?=
 =?us-ascii?Q?5i+xBRoVU5dllBv4qMv1Je9Y/Kmb5FrS7XoZLBMtYelpuQqERQBHHCBzxHAl?=
 =?us-ascii?Q?tiDA4RApwmRn4brpMiFFBhnRZCl2eypmYSCQlj1eKdatYLNPBGTE312Fz4JW?=
 =?us-ascii?Q?wLfc+zKNBT0qS0cWtmQode6B1La+XTgph23KX2kQk9sI44XMfTPrK9X0fsSc?=
 =?us-ascii?Q?vrEftioGsF2KzWhJib2s1//xyIGK8u4oZRngAXnUyxrZylCAeMx+zxuysD/d?=
 =?us-ascii?Q?UpeR4jc615SvzDBy39oVkefYT2qiu/K5P3MPfXB0tWoBBeLgkp6Abr1v7cQK?=
 =?us-ascii?Q?xxQo0tdtMmpVp1JspzdC3niPI0KHVLqqtvngw2fJEwNh3B/9W+NToz2fBV9n?=
 =?us-ascii?Q?FGyGHDARiDX9gMNFG3GjsXAVZR1D8xxJKjghj2EliKekL4OLFwLpb8fTLjTa?=
 =?us-ascii?Q?BcxFcdlPNIZeOgS+2xCqu5kcFBL7+TM0oNnYR0Gj4JumedxC3EDd60snnAlU?=
 =?us-ascii?Q?/qTi99GnTZY05H4+yvU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21825a8e-2eff-45e4-ea1b-08da7f529d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:43:22.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/S2OOv5A3g1FGDpTWrV8vHqmt6LU2KRrJWLArRAE3XowTH7Ltxy1ULBFMw6XDu4u52GTWRvUgXfdtANISkM4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Regression: PM: domains: Delete usage of
> driver_deferred_probe_check_state

Just see your patchset :)
https://lore.kernel.org/all/20220727185012.3255200-1-saravanak@google.com/

Thanks,
Peng.
>=20
> Hi Saravana,
>=20
> The following two patches breaks NXP i.MX8ULP, but I think it may break
> others use SCMI.
>=20
> commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> Author: Saravana Kannan <mailto:saravanak@google.com>
> Date:   Wed Jun 1 00:06:57 2022 -0700
>=20
>     PM: domains: Delete usage of driver_deferred_probe_check_state()
>=20
>     Now that fw_devlink=3Don by default and fw_devlink supports
>     "power-domains" property, the execution will never get to the point
>     where driver_deferred_probe_check_state() is called before the suppli=
er
>     has probed successfully or before deferred probe timeout has expired.
>=20
>     So, delete the call and replace it with -ENODEV.
>=20
>     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
>     Reviewed-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
>     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
>     Link: https://lore.kernel.org/r/20220601070707.3946847-2-
> saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>
>=20
> commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b
> Author: Saravana Kannan <mailto:saravanak@google.com>
> Date:   Wed Jun 1 00:07:05 2022 -0700
>=20
>     driver core: Delete driver_deferred_probe_check_state()
>=20
>     The function is no longer used. So delete it.
>=20
>     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
>     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
>     Link: https://lore.kernel.org/r/20220601070707.3946847-10-
> saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>
>=20
> The i.MX8ULP mmc device node use
> "power-domains =3D <&scmi_devpd IMX8ULP_PD_USDHC0>;"
>=20
> The scmi firmware node as below:
>         firmware {
>                 scmi {
>                         compatible =3D "arm,scmi-smc";
>                         arm,smc-id =3D <0xc20000fe>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         shmem =3D <&scmi_buf>;
>=20
>                         scmi_devpd: protocol@11 {
>                                 reg =3D <0x11>;
>                                 #power-domain-cells =3D <1>;
>                         };
>=20
>                         scmi_sensor: protocol@15 {
>                                 reg =3D <0x15>;
>                                 #thermal-sensor-cells =3D <1>;
>                         };
>                 };
>         };
>=20
> When sdhc driver probe, the scmi power domain provider has not been
> registered. So __genpd_dev_pm_attach directly return -ENODEV.
>=20
> device_links_check_suppliers should already check suppliers, but scmi
> protocol device not have compatible, so of_link_to_phandle
>       |-> of_get_compat_node
> use the parent node of scmi protocol as supplier if I understand correct.
>=20
> I am not sure whether we need to revert the above two patches, or do you
> have other suggestions?
>=20
> Thanks,
> Peng.
