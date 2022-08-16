Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8735954C7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Aug 2022 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiHPIPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Aug 2022 04:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiHPIOj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2022 04:14:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA3CD50C
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 23:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzg9mva6N8AUkNXiSAxf+bzrUeIxag1wf1jG25U0Bcan8ZfocRrqZwPZI9PfQjVmt+5vSKA5Q+Qm06lDpp/R2SFDDzKORa6xKz/CMQ36X+qXBhYrppqnojsI8+5XNooGUcJLQn5qjSnEhBUQbzC+pi1E7gtQPjByf314I4NnObbYbWf5l8sLMQivxIp/CUuROVx/LEZjXDoSiKnCfPbJsp9bpt1xETzrPf2Ytu/ZEQgAf07UWeEBzTw6IWiKt3+4v6/Plxf5RzooH6jH7zPV2NeOP+1WIg33LrrHWQgAhiTgEe/9HRUEwGpKrc2ILsv5JxmLLt9xORA6f7cK1lIsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihsJFf7NidNngSlVcaRvmTgPn3WpmqWo1VhrMDnHoj8=;
 b=BxyWZLDXT0AVzySE3sgiSRkHXe1/2qEMFZ2nmnHK600yQrV+4jPW4OXcMR+av0Bk0XLE4K/hS92T8TcQtzGay/XSwYiHelLsdvT+AC8Ck+3Wndjh1SpNQ3L5/tBeR1iW7IN+wHAoC5eyKCp5W4pIiV3tpOM+OjOtqNb3LNCYI8UyswMfdDIQl6dsskJgr3ESV1RBAYFN0kPSwE6hgKYxB04ZfnWV2sZJOqGKWdhEdL7eKA2A+170SCy6dZ+DX48kNbIatKK2sTFNeGq5TNJEc5ohlgXfPKcbsFPsylVq3dYCbcuI3BiNQnlsZWcEmY/UMGAxkmTD19NjwupZFUG4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihsJFf7NidNngSlVcaRvmTgPn3WpmqWo1VhrMDnHoj8=;
 b=AqHEdriQ6rTdqNUrTJeuZsy8oLO0F6w1nxR2goWZXhuTW7yIGU9g3ZCSfOnMUhImYNBaJo0Kya2S5ub/3KExPUyybLYyKzC22xZzkk8L7rGdrbA9aiSWPThVUCWgBInhGc8Y/pTqTSg0ptT1iMSNlssAEgGT/0C7+TJumEousRo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8035.eurprd04.prod.outlook.com (2603:10a6:20b:248::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 06:21:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 06:21:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Alice Guo <alice.guo@nxp.com>
Subject: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Topic: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Index: AdixOGZw9fNTqIJNRCevdBJlb4IAbA==
Date:   Tue, 16 Aug 2022 06:21:40 +0000
Message-ID: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd3f7fec-a0e6-47eb-347d-08da7f4f951a
x-ms-traffictypediagnostic: AM8PR04MB8035:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6+bu+ZNbz8SCMKL9mA07iMlZxz6MErs2Yq8QWziMcdB3Gs/5Wm9OWsC4s40/kxYDuY1sLNrxvD8OtEsfv0pyOhjPKLzu2aCvwBvl9NJLu6iiXhJ55PtaHXR89sOk9jTxrtiJpldquIy+8XB9M3nt95fe/YJ7kfr1BamaKC1IIPPdrdrcDISb2BOIy1HyBrA2Cx6Ui1dQBn+IbfPsmjEaairFwiQZFFj9vCQO07OC7UwVy1TnuyZjEWy7NOkIpGpa6J3EYqXSus0XXP+h1+2ch19Mj/jlPwqHAYn5MtIF85J5UWGQx7RzVSKtnlsCrubsc1vmJBqi5veQJ4WmJtDUXIn3Rw7DqRdqWO5up3l85xLUdgP/wKOkLSAkf7HtjbdC8hF1XdnGB7u1ZE0gRQbhZBO5NrcrjiBV/fcSwXTbf2u58cLeIAsm2KZs+mdylK3ZSwW1ZtCSEDKgbEv0y5sCN0Ggl/+yd6gbeYv/pitZc6ZuRxZ4YBMcty+Y19F0LPLHseKyZ+qWeoJlb710J+fHak1+JsydPyR5hUXN7HC9bWpmGZwOzqRUl2TljS80SnmCXc4ny+Nw8v60Hx6Nf15bDH2pM9Q1+nrkmSXghufSPYlcnYljNRxRT+CrQvvDuad22i2/ijBSfofnAcHngLWHf3Rf9k6B6Z7QRD58kryAGWNG5LLCHCkopPuvVht3WgMBqofTAHU3SEHBeV2Fd67sQBNNNTS84vAgbvA7K4PEI4CiP3rL7xeGVqcqx/amVevwlbhUjN88iuqUfxJIZM1CmPFtCEL+w9OWfE9ekwPgoQ6bf/0/s+bXmrFi2SM8x2/GKJjkL8cng17K7Rad48ijlogJsFyuVh5ZwE0kFnptcfTI8xYk58PBOnkZOtECOa7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(122000001)(38070700005)(38100700002)(110136005)(71200400001)(55016003)(316002)(41300700001)(33656002)(2906002)(6506007)(7696005)(5660300002)(44832011)(9686003)(8936002)(8676002)(76116006)(52536014)(26005)(66556008)(66446008)(64756008)(66476007)(66946007)(4326008)(966005)(186003)(478600001)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hr+eKGqt5a2XCv0t8qNchD9jEj1HNnNNn3CBpnh7vW6vIoVdoaw0SH3SAGVW?=
 =?us-ascii?Q?y2X/cn0Io+LTagjX6Acn0CnHeCJrWhmqNksusweQm74FRH4ORm0nkv3xxI1b?=
 =?us-ascii?Q?HHv0/ZqPmzfZ5td13H9C9j81D909ejH/4i8fO4LUW6Jc61VvsXTgf+mMSSQv?=
 =?us-ascii?Q?gAV/+Ba4a6+2unny3ovgZp6CCbZck04M6txaybO9eh8DVISnLyl+QNjrF0vt?=
 =?us-ascii?Q?0HUHMptbHYDWKpw3KEahLZ/rPiMF9OG0HBMAqKSY3y/LQegNZtaNJDIpziey?=
 =?us-ascii?Q?cO1BjPrgFbVDYVI+bRv9qYoJj1wExEU5ROrFD/ehSk88hjzKqhiAvyJv+hm4?=
 =?us-ascii?Q?9YayH2Nmjs71Na4EPxOSst5Y3jYJrgRICR9dONYLaRWmkY+uZJOIpDy36fJj?=
 =?us-ascii?Q?7wKe+n+w53L/Rd5sEXIs0qpcixpiVGda5sXHN6FL2jz2pCb/Tnh6QwtfzPwO?=
 =?us-ascii?Q?R76RAjiFlJnUJa850ibaspDYArw/Pwd3PnkUsmv3kqOzMdKYCZnQe3C/phvi?=
 =?us-ascii?Q?xix8gfuDk9wHeektACMyTkKBPIA26O+gNFTvu1zIUo28GaAM4oq5gdUn9q36?=
 =?us-ascii?Q?uli2yIq0XV5Nr4ruoNfNsNvQpgjBecmN3prgvA4dprAvfynCOMwW7mozOVO8?=
 =?us-ascii?Q?IvgCvHgJN9ldb6ig37aTI1Fh5DJR21m7er4LKFbaGPdvdnHDXNTgzxBB5ee3?=
 =?us-ascii?Q?iLeJtUMv3JgcvM0jRHdPMC8sswjorSAGbnCjo3nWPc+iMgVJdagP4wnFyRuO?=
 =?us-ascii?Q?imylEdDWtJypjtvGp2hEEpZnOdmB2s5FUuKDo2U/9ilNyDWjPTLWfOM6RxqI?=
 =?us-ascii?Q?A592ovrA+saGHEsaQDCZbq5yTDoVLFdb9f6P+C5PYfE30iifHBQRRDiR2fJZ?=
 =?us-ascii?Q?o5QOKoXtGRkgWzL00/rCoAabzGDpZMVGqpUpYSOMCoQ86xABQxB/RS3YhsvK?=
 =?us-ascii?Q?4SQj2ypnAePeqE56jsRP++9LhzYyNOQcaXh945MFX+8AedRR909EStXCIx13?=
 =?us-ascii?Q?oh7Ca5/KwmuBvzdE4sttVOI6f4h3pRHC1osITxtUyVTOzkXv9ykvOBD2mLAP?=
 =?us-ascii?Q?6Tyv/2SHy5PPXm0PRXm2pXGtpBgbiPRrc3/kLYI6a87g9SSQqHQWcKuzbXST?=
 =?us-ascii?Q?zvC+5Th/wKkskfXta8HdkfKS42+8wbPARDBvcw8a4jMilHeUZpsqzTTMWbOe?=
 =?us-ascii?Q?3yTPiHcMgDYv7oMSyjiAT0ZulMI08s0nAKj4uKb7vfs72c3N3bNSD5afSGuO?=
 =?us-ascii?Q?cwHHK2m95UHrcRmftU/J1HFNugAMlwov8ErREJSCI+ECRdJHjV/d85gCdR1f?=
 =?us-ascii?Q?3ettyFhOO0ABilBtyJ0DtrqsBe9PP13a9Q1bzrvKrkuwdu17UxLs63JOyYrf?=
 =?us-ascii?Q?tRLX0t4fLprYuWlRZf+yyKW8zFEZu/0bp4eFRwrdaFUa7pZQ3WfpszgL3GOd?=
 =?us-ascii?Q?ZRjnvU/jSIaIE/q8W9xKwe6gYDLtFrC5XSuzyPgPYp4IHrSsUgLi5znOSFXa?=
 =?us-ascii?Q?SGyrWlfQ7qkEo1ItV4imfkHgeSSjTp0h0mv1gclZiM9Pt13p8Abnr1/ax9hj?=
 =?us-ascii?Q?pTPsiyuYBNouMg35Pfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f7fec-a0e6-47eb-347d-08da7f4f951a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:21:40.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNWC/dkp3+//xVkNF3I2fpeVmeJQRX0+lZTB5PLyHtG+6OYUtIrGQrAu1+8163uF+N1fnS9ivIfSvX2E+n9Cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

The following two patches breaks NXP i.MX8ULP, but I think
it may break others use SCMI.

commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
Author: Saravana Kannan <mailto:saravanak@google.com>
Date:   Wed Jun 1 00:06:57 2022 -0700

    PM: domains: Delete usage of driver_deferred_probe_check_state()

    Now that fw_devlink=3Don by default and fw_devlink supports
    "power-domains" property, the execution will never get to the point
    where driver_deferred_probe_check_state() is called before the supplier
    has probed successfully or before deferred probe timeout has expired.

    So, delete the call and replace it with -ENODEV.

    Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
    Reviewed-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
    Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
    Link: https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@goog=
le.com
    Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>

commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b
Author: Saravana Kannan <mailto:saravanak@google.com>
Date:   Wed Jun 1 00:07:05 2022 -0700

    driver core: Delete driver_deferred_probe_check_state()

    The function is no longer used. So delete it.

    Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
    Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
    Link: https://lore.kernel.org/r/20220601070707.3946847-10-saravanak@goo=
gle.com
    Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>

The i.MX8ULP mmc device node use
"power-domains =3D <&scmi_devpd IMX8ULP_PD_USDHC0>;"

The scmi firmware node as below:
        firmware {
                scmi {
                        compatible =3D "arm,scmi-smc";
                        arm,smc-id =3D <0xc20000fe>;
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        shmem =3D <&scmi_buf>;

                        scmi_devpd: protocol@11 {
                                reg =3D <0x11>;
                                #power-domain-cells =3D <1>;
                        };

                        scmi_sensor: protocol@15 {
                                reg =3D <0x15>;
                                #thermal-sensor-cells =3D <1>;
                        };
                };
        };

When sdhc driver probe, the scmi power domain provider has not
been registered. So __genpd_dev_pm_attach directly return
-ENODEV.

device_links_check_suppliers should already check suppliers,
but scmi protocol device not have compatible, so=20
of_link_to_phandle
      |-> of_get_compat_node
use the parent node of scmi protocol as supplier if I understand
correct.

I am not sure whether we need to revert the above two patches,
or do you have other suggestions?

Thanks,
Peng.
