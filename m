Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA71933CB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 23:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYWfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 18:35:37 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:11726
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbgCYWfh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 18:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/qBksX7tF2mG72iLDusoivYVXllgGkb+rfaqs4V3Nktp1MixxItXYqTIbF4gAw0YVDOIJXMDi5mCxCj2NUHbxgl/lH4ahGlQpiaJtgxDB51Qsw428FRD0foaWJJihWqIvlzTtjQQhagji2YBcEOvIWsKoTm/q3uTTLdMGoNCp5yIUypNbc47vrRCOiyIjj5Yh9vXOob3V3U1QW02JEFu5W02ijqti2SwBlruj79/FdbAoNCBbEJXuKthd8hLk5GsBZkTDVv+r3dpR82hO2eFrUG5cgIvnULbvT/U9vYKN2cj0BkYC5sJ6AA0rWqSaSAfoqZc0S/N5jLc44rVKK1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXv46KmuTSQchMPtJIjU7rZsGJOkEjXcXjCjrO0qCTU=;
 b=gm6QWb/umoSrIAJWlJBed5tb3uIiatc5NXNbPVd0YkulCkuiBGtnKC+ffcIqxHRWrnJ9URiFg6btACemFDxY8EXz4uEmiwp8+i8/2eqJ/iGpJHbm2/j9FZkH8K8YTArPqwn5EnTd2i3ZPhkdcw+iOkJA9U5hhCoqr1krmfzPHJAaYC0SSJK2/eg4d9HCPgoFS95/ommk1irRC7+sg2M7RKiBFDK3f9mtGgiSLLyGBDUHIDJBHNcbQf8Ka8fl78++Lyu8U+1Co1fdJD1ZmJVW/7pl57OcdIHSBJjL4broUcF7867qVPI/I5v+1VqlDvRwL6sXfqFLisaIdA5FKuasOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXv46KmuTSQchMPtJIjU7rZsGJOkEjXcXjCjrO0qCTU=;
 b=XeX0SklV40hnPvQT6DM4HcMrqPOWvathh9W8Q+4uBqFQ7RO8lZ5zCI5wVwZYo9grGleXfeIBABJWaddQ+iezSxA1KKGgSl8loIWgpZkF7T8RgnrtNKzNLsY1GC3om8/VPvUObu1t4V3HMvw8shN8cUkBdgxpZaMjl+HGG2Ic30k=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB5598.eurprd04.prod.outlook.com (20.178.204.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 25 Mar 2020 22:35:32 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 22:35:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC] PM / devfreq: add busfreq governor
Thread-Topic: [RFC] PM / devfreq: add busfreq governor
Thread-Index: AQHWArlFUBHgTyrcLE+9J+iVDNgu5w==
Date:   Wed, 25 Mar 2020 22:35:32 +0000
Message-ID: <VI1PR04MB694176CC6B96EF2E612C552FEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <20200325152224.6613-1-martin.kepplinger@puri.sm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c9c0832-b79b-4940-a60f-08d7d10cd3f2
x-ms-traffictypediagnostic: VI1PR04MB5598:|VI1PR04MB5598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5598CFC41A234C4CE0C63A85EECE0@VI1PR04MB5598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(81166006)(33656002)(81156014)(8676002)(8936002)(5660300002)(52536014)(186003)(71200400001)(26005)(6506007)(53546011)(7696005)(110136005)(316002)(9686003)(64756008)(66446008)(66476007)(2906002)(54906003)(86362001)(66946007)(55016002)(966005)(76116006)(4326008)(44832011)(478600001)(91956017)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5598;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cK+g1ajkva+YPAgPMWR+4Uu+nxuOFmoyKWvGcLzxzq1px9F7E8YQ0uygCedBmztPcVJcF7gWXjV+65o1+Ifx0+zuaV0+wAE+WFyKGDuENNxDMx5NtWJuzlr89Vqkt65H/p8GdPkTCCRzK5aOgk8zww40Rk2RghDAUBhFxM8jWKqKo8BtWkmItYBjrNqPys5oh84fGgEvcT15bejRdXdd2sNnbVmJlQKzGT+YI2l0R+kV0NToxmMw9yabClTlgMVWLcKebmXL7ZQ2NQdK3N3ECFEgQ6cwgVdJnJmXRrOYkUsfFBXpXAm/7rVuvudqJdBbdxHUo6Qsomds1h23FJOmsOezgyuHKm3080Htnq+1LLQrlClIY72c/M0uFLnc4rU98mi9rCZ76UXIfe8aT860BImAHtW0YYAAgJ/2hMRnL5CLb00FRo5NL3oc155vfmhCkH6idUEi60cDTpOg1wgQwKdjWBGOC8s8UMQOK28ObJqnw3MPIGdc5DmRLpmy+wKC+Mogdp7M4OUntQOqtu7r0Q==
x-ms-exchange-antispam-messagedata: u2yrehfjpO0sYm1sQcV33wA8paMBfLIocUz4MKORhe3HKw+VrpH+LGVYPzJQmrUZnobsh8HmqDntgm5TpOXn1QvD1UPxUjSkMxkNkPE7g0rynb0WxrDx1cvsTt1m6bkoIL8GMXCgLXVSUVJYL1VdQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9c0832-b79b-4940-a60f-08d7d10cd3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 22:35:32.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlbmUATkQ0J83C8hMSRvzUT01Rz1l4dF4LtcY5vnIQ9f6HAHbYEWUfRp8X+cVMckVVLh8CYPa1/B3d79bMGwbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5598
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-25 5:23 PM, Martin Kepplinger wrote:=0A=
> A devfreq governor to be used by drivers to request ("get") a frequency=
=0A=
> setting they need. Currently only "HIGH" (performance) is available.=0A=
> =0A=
> ATTENTION: This is a first draft to serve merely as a basis for discussio=
ns!=0A=
> ONLY USE FOR TESTING!=0A=
> ---=0A=
> =0A=
> I wanted to get early feedback on an idea that AFAIK is not yet available=
=0A=
> in the kernel (but something similar via "busfreq" in NXP's tree):=0A=
=0A=
Kernel already provides soc-agnostic mechanism via pm_qos and =0A=
interconnect frameworks. The interconnect framework is more powerful =0A=
because devices express requests in kbps and provides can make better =0A=
decisions based on that.=0A=
=0A=
> Let drivers request high (dram) frequencies at runtime if they know they =
need=0A=
> them. In our case the display stack on imx8mq would be the first user,=0A=
> looking like so: #include <linux/devfreq.h> and:=0A=
> =0A=
> 	--- a/drivers/gpu/drm/bridge/nwl-dsi.c=0A=
> 	+++ b/drivers/gpu/drm/bridge/nwl-dsi.c=0A=
> 	@@ -1116,6 +1117,9 @@ static int imx8mq_dsi_poweron(struct nwl_dsi *dsi)=
=0A=
> 			ret =3D reset_control_deassert(dsi->rstc);=0A=
> 	=0A=
> 	+       devfreq_busfreq_request(DEVFREQ_BUSFREQ_HIGH);=0A=
> 	+=0A=
> 		return ret;=0A=
> 	@@ -1125,6 +1129,10 @@ static int imx8mq_dsi_poweroff(struct nwl_dsi *ds=
i)=0A=
> 		if (dsi->rstc)=0A=
> 			ret =3D reset_control_assert(dsi->rstc);=0A=
> 	+=0A=
> 	+       devfreq_busfreq_release(DEVFREQ_BUSFREQ_HIGH);=0A=
> 	+=0A=
> 		return ret;=0A=
> =0A=
> =0A=
> Could be called in pm_runtime() calls too.=0A=
> =0A=
> _If_ the idea of such or a similar governor is viable, there are at least=
=0A=
> some problems with this implemenation still:=0A=
There's an older RFC which I have to resend which adds support an =0A=
interconnect provider for imx which then makes PM_QOS_MIN_FREQ requests =0A=
to devfreq. It has several advantages:=0A=
=0A=
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D203215=
=0A=
=0A=
> * The governor saves its data as a global variable (which I don't yet lik=
e)=0A=
>    but the driver (user) API becomes minimal.=0A=
> =0A=
> * the name: In order to add to the devfreq/busfreq confusion, I named the=
=0A=
>    devfreq governor "busfreq" -.-=0A=
>    I just wanted to grab NXPs' attention because they do something simila=
r=0A=
>    in their tree.=0A=
=0A=
Interconnect API already exists and is not SOC-specific.=0A=
=0A=
> =0A=
> * ATM we switch between "performace" and "powersave, which is=0A=
>    not bad at all, but still limited in case a driver would really only=
=0A=
>    need a medium frequecy for a device to work. doable?=0A=
=0A=
Interconnect requests are made for *bandwdith* and the provider can =0A=
compute minimum frequency based on that. This means that if a video =0A=
device at low resolution requires bandwidth that can be satisfied by a =0A=
"medium" frequency it will work as expected.=0A=
=0A=
> =0A=
> * I doubt locking is done correctly and the code is overall of bad qualit=
y=0A=
>    still. Again, It's a first idea.=0A=
=0A=
