Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40179E82C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfH0Mlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 08:41:45 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:50176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfH0Mlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Aug 2019 08:41:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDFsjIBrUNHlzf6NuuZRTQB1bj/CT87OlS5IgIizDxHEm5/1T/x9NkaYiH92tqAuqGuuoUisB7HzJ7iLsI6POYqQuFi6+JsjRkvilVewZg555wVfyCnXyKbqHXV+IhbAiGMxoRmkwY+OS///3CzjktHrpMAGstqXgeLEjRSZ7pu01aSpw7mjB1w5ceG6d52xh3gReeptBPMbkn2nGEcQBs9OXSJRnQa4cAIDODnxu+tlxKbGoJ94sddXTAV4y8UF/OC3zqVlZeUluFLCp7sBpTYUzNF3bogt/fuRy10LlPGvxNlHDDYN96euydr54JUoE5hOgNOl5/H2n3XJMrpltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSz/Tpwfw18gjEkSOqjIvQfoRgdVctIbj69AOyc46NA=;
 b=h16IXhThw6EwW7iXvmgkpm/gRH+n3FDed4yA8Yg7SrTlY5xwssRUaK9WHQ/zSWDMpOEPfdlt3O0+J51IZedgmR8itnMk/drR6i2GM49y8i8v1RykNZCZ+PEUsDVtNj+DHaAGSqbDEF13fc+l+MvjkaWECc5bQp9ho0UXZJ9b4xGTZt/1/UKyW51063tjaAMxLw3tWeMIi2qoMgBJT1obCz4ZwSjMa70MqFrcW8AbDo4Z7hRkYJ6B819Pvm6HYTlcC8D6moIG5as7F+fByfGAWgUQh5vr+ZlKHJp1JekPecK0CWxNSM/B8bJ8Sne+w3+KuCnkdHahlDgJOJimXv5dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSz/Tpwfw18gjEkSOqjIvQfoRgdVctIbj69AOyc46NA=;
 b=m9V++w57bO3GEarilJHkfMTFceocrxEBDAuKp3sRmi65BngrP7+TBKJgWU7HDxsNeHQgGryiIVQVj7Mr0iC7m3l691WtLSkTMQzHz0+znR4enot9xOY41P0p/MaKv29eM8AVyTbHf5a+JxbHG8ugytvW9g9IVRm0wUaFOORCEO4=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5503.eurprd04.prod.outlook.com (20.178.122.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 12:41:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:41:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7UNdyaJx5tOE6OrvzyFWKCoA==
Date:   Tue, 27 Aug 2019 12:41:37 +0000
Message-ID: <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9903ad54-50d9-4a3b-6ea9-08d72aebe736
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5503;
x-ms-traffictypediagnostic: VI1PR04MB5503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB55035EFF4FC38C77CEA54C17EEA00@VI1PR04MB5503.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(199004)(189003)(26005)(71200400001)(54906003)(71190400001)(8936002)(55016002)(66946007)(66446008)(64756008)(66556008)(66476007)(110136005)(9686003)(52536014)(76116006)(91956017)(66066001)(53936002)(305945005)(316002)(7696005)(8676002)(81156014)(81166006)(33656002)(446003)(44832011)(25786009)(256004)(76176011)(486006)(102836004)(14454004)(229853002)(86362001)(7736002)(74316002)(6436002)(5660300002)(4326008)(6246003)(3846002)(7416002)(6116002)(478600001)(476003)(186003)(2906002)(6506007)(53546011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5503;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j8BVFtuAJrZGlfWHLrhEsH+uRYEHE+nPNAVwOMa9n5jg4mOE+rIuMdNVf6RY0XPLLkX/KfaCIXxXAqT+FgXXSXTWvmtkMxpltq4L1XQp0bq//5iPNrc+oyDnTL9cCH61urOlWmIp8fZm0eruaqSSooTY64WGgtxxTmZktZ4KfWf9IseJG1lZGo487yuPhhhcuBMn/zr3lzzdf0DiDOuTZSj+pPVgl/mtIYELlPgZljMA733FZHz4t2G6zYbaPQ7VO4LYxEQqnqG8grHXvOtc71ZxhTOKWIKq3gSSg7Q2eVlojhVdEpHPFI4NHj6kSbUai2e2vQuyYCQL+L4RwAdqhjZXaniRB6lcD4/5RkSyeWJVzmikHsK2OmCOCHod0V1jz/y3+xT3PKl3dtoy4cQXWzQqzTkOMVRlMPpGGA4VMqo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9903ad54-50d9-4a3b-6ea9-08d72aebe736
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:41:37.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjXHPjEjTfuSdxeRcKMcNM6fx3tU0mJtuTvvi3HqmhGxYo9liVI6I/smMDzedMSQgVO4mAEa9v68CWe+wh7mCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5503
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27.08.2019 04:51, Anson Huang wrote:=0A=
>> In an earlier series the CLK_IS_CRITICAL flags was removed from the TMU=
=0A=
>> clock so if the thermal driver doesn't explicitly enable it the system w=
ill hang=0A=
>> on probe. This is what happens in linux-next right now!=0A=
> =0A=
> The thermal driver should be built with module, so default kernel should =
can boot=0A=
> up, do you modify the thermal driver as built-in?=0A=
> =0A=
>> Unless this patches is merged soon we'll end up with a 5.4-rc1 that does=
n't=0A=
>> boot on imx8mq. An easy fix would be to drop/revert commit=0A=
>> 951c1aef9691 ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for=0A=
>> IMX8MQ_CLK_TMU_ROOT") until the thermal patches are accepted.=0A=
> =0A=
> If the thermal driver is built as module, I think no need to revert the c=
ommit, but=0A=
> if by default thermal driver is built-in or mod probed, then yes, it shou=
ld NOT break=0A=
> kernel boot up.=0A=
=0A=
The qoriq_thermal driver is built as a module in defconfig and when =0A=
modules are properly installed in rootfs they will be automatically be =0A=
probed on boot and cause a hang.=0A=
=0A=
I usually run nfsroot with modules:=0A=
=0A=
     make modules_install INSTALL_MOD_PATH=3D/srv/nfs/imx8-root=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
