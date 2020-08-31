Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8492575FB
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHaJIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 05:08:01 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:40220
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgHaJH5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 05:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USRJ6OViOexlaGfjG8fgFfr+w3/HNAFyFop8XzhvVIBK8jrzTFMZYFzdase6Sfito8O9isezoMWKpAQxi/dekYTVCB6fnQTj66okhfzWbOMpJkU8uvdeMo6vLn6SKeRSy3dywLSd9d1nIpCUGWTch3emxt4a6rL/lnqo2PaHGPWJiDuT3bYxv2kl9/HOLEv3BhEynj3r47PdEU68fKqX3vR4upjSyfj8Vau41VdF4Jv8wB6UsOFmQRFpXTpxqfJBgabQnRgau60Yg/kTxkNj+vixKisWWWjqwi9cipdKrQtzEloQEuAQY2QmSN1cei182ugd4bECZfX9Zgfj1tAc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/CWNFQ98p20i+FbHHV4C5MepiBoqftIuGPLV44/lO0=;
 b=HiH1BZBIViTfX2RicDriFuWy4DYsBtBykIZpa8PvTjP6+JkrXUOcgEwF9L699USKjzk7Rb6fi4Vf5/gxGWzL3kUgPa+zVQFHie4dwO6OgVzs3iy+jaFHWXIzA5rjOEF/RFZxQYvaWO1XTbNRa9Sd8jdhyelJCSN06OMwy/opJsL2MVhwkiPWYtxXQU0zZyjTmPwumR2bCUNKF2I8T29Ljf39OcOatbzLUjwYJwq/NSgJhOLa3p6drzOZMcIxnZol7WKkX9+d17R1equw9Z3NdahBPhNy5w2OiYKbpx8NDkWAuse7H6CgZdhgP66b93TMPcg0Xsl5hcv4aA2B1f2a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/CWNFQ98p20i+FbHHV4C5MepiBoqftIuGPLV44/lO0=;
 b=WleO7IUHG0IosDyUxWtUxNQrWFbKZHUL5KbFLAHYs7ZR8Bs94MXSoqqZPUb3byqXyt5BAXS0mPyQhJSBRsqidjwr59VnS6I6lPRgs6gmVgbyfXMN7U6OyFuKMcrJlvVlUlfkwBscbQT2qN0UG+S4eZTkmj53oEmxS+gTbL1yzww=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5657.eurprd04.prod.outlook.com (2603:10a6:10:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 09:07:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3326.025; Mon, 31 Aug
 2020 09:07:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] cpufreq: dt: delay the clk/regulator check
Thread-Topic: [PATCH] cpufreq: dt: delay the clk/regulator check
Thread-Index: AQHWf3AAZbBH4ndxZkqgPA9p6ygXkalR5w+AgAAGS9A=
Date:   Mon, 31 Aug 2020 09:07:53 +0000
Message-ID: <DB6PR0402MB27605875A6F85CE06790BD0E88510@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200831084858.2398-1-peng.fan@nxp.com>
 <20200831084441.uvw4jx4cbfh5y3e6@vireshk-i7>
In-Reply-To: <20200831084441.uvw4jx4cbfh5y3e6@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f5de8ca-9c79-45c1-44eb-08d84d8d5835
x-ms-traffictypediagnostic: DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56572CE3B36C37A4B894110788510@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+N03jClKF8j7XBVDGijG5H0QDInCJaDoNNPZknexqjXVusUT/wXWrxPu9KJBLMSL5fbPz1CK81n+vz9xbnnY/1SFelujokvsuJ5HnckGwjvhNPwbxlUmRf2dw+YQf3tKHQcmp5pYtw8E+mwi9hNw0jfh3pK0BcveRuAnI946ShPTFF0EdyNIq74rc+Iwqq9gMq5yw+69B+14HgVH4f71CFaUa16NaZfbQ5FsIBuma1QYhbKilbaIUBfR+uBaHSs8418C7ETJQ0VQvoOi525lrnrYZxbPO9/5y41cSR2IDCA+v/j6U3Rsi5Qm+/Uw8v/RO7K1ZKNhIlau0OQgayfBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(64756008)(186003)(86362001)(66446008)(9686003)(66556008)(44832011)(66476007)(76116006)(71200400001)(52536014)(26005)(66946007)(478600001)(33656002)(8676002)(8936002)(316002)(5660300002)(55016002)(54906003)(6916009)(53546011)(7696005)(4744005)(4326008)(2906002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1MZe72Mc1uEOo2fipudR+k0cMOz3cIqQQ3BNon8ICFutuc+Sqs7yKSazVzfTEeX0cOrPCmGXXXCqs1eVhSQ/scqMcGRmk7fr0dD6ccfac0PnzxwvvokEJqaERwthP7v3OtR8tsOvH71UuDcyC/ML+zu+xi5ev2wQjHuTdgXs369Kyi+wknK7Bbm5fFFzSS0Gdax7Nohldx/lpscp/vuG/SCSgtCl1fDMdgvB7A7L6RX/x/3BJRc6JViY0pGEqflU5a3ASTa5TtsZpZaB9qFmsbvgnVJW7mBRaqyaR7d7oGQAbnQ/5orqAZC3hhTsbOsk2Fu2ho9trfG5//zJ6SzkavRYbWRijhRL4AskHFKHQQoqKLyRVPvUtIX9iYRP+oIrZtOsa+/5pmNuF+v2BP426kpwoIbK1Qor7w2r352EV+21evzgk7msw5nvjyHKVpLPMkGdxMGBS0FmfLMcKs3S6hknoNUa/vzwz9RCPn6G7/kPzEauwJcNVhqlQ9ZUfnof/BKgCALWLW6OaRHqDD2vZEYisOtDaR8zIjSptXiYh8lrxqHYiOE9yajYRkdnzM5aoIDhtR3NkXj8en0BaSHq8g6sKtfXCAfeF+SsmhAOjvK9GMKudwUfoadsZRRfXT7lPGAWK9NfY7wnnWVwOtINLQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5de8ca-9c79-45c1-44eb-08d84d8d5835
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 09:07:53.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksiV9upZzxxlhhju/BkaUjDst6u/qE0muf9WNn/XWFAeHh+f9NzIkJRGn4NTNICd0t7IBFUlwYi36dZ60sNovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: [PATCH] cpufreq: dt: delay the clk/regulator check
>=20
> On 31-08-20, 16:48, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > cpufreq_init could be used to do check clk/regulator check, there is
> > no need to duplicate the work in resources_available.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Hi can you please see if this happens on linux-next as well ? The routine
> resources_available() isn't there anymore.

Not happen in Linux-next after I rebase.

Thanks,
Peng.

>=20
> --
> viresh
