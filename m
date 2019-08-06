Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A276832FB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFNlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 09:41:36 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:10211
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfHFNlg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 09:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeFRc8pbb6wrxESlytG2MIthVZNF9tb/KB/CjwFQI9bm1ObsmesQpJSVGcAlHP+SXHSbZjebgvqtdEae8xTVhgtxDZIJ4WdWwzW0F4OSK6V4wOPlou7ZjbVVNeh05ExIPdPmdbI/xxr3Fkh0AkVYKX2YkmI76H5srI3R0OBzySN09B5csEVROZhKKqqctr/PduBQ3XoC70meMapVHlgTH2HRYB77JkdWVyPEyGdR9UZrd3CBNJ1lXY9qqB1yLnxmNfiRbF0Dn18V8lbnTL8c+jUKiPPN9wzFWOBvGaJM2TlU3NLlydnmTglm3Ux5ZQgNl67Tolh5QcyxHGOlMqNhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf90RamkDUOldTROmtPkbhDEjn+D2DFBKQ7JHdsKDoc=;
 b=NEz4ZsfQmwt5j3DEwPLe9KX9xi7cXm6VZ0hJrps+OGgEzs3GKFtJtzhII0JZrw+uAmj1wciaHxBGG0RlC/7vNwsVogveusrjHVvZNrom7BBF5dxSk6GOakMSCl7L6/N/kQyu1p7NME+sScBGlpNTaJyYqy+1+k9c1Z6sNXae8lcdlVJfOH/2glW6pPNs2g+2qf4qmeNI2nqjq7PpjvhFqt/kugPQ2EEkHoAJmlsvhWwt2uSZuGf7SyJFjaawAyfa9U1P6fq4nU5axHTPsVqWiZ2F4pAGL3SUBqGhj50cv0d7sd4Y0lDsgEp9fXd5rfmYErnNX4FROUhLSBj5vglNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf90RamkDUOldTROmtPkbhDEjn+D2DFBKQ7JHdsKDoc=;
 b=cD5Y7RpddeY8FYRdXmSooheWcRE5SIBIuPAnnoWpYQDykAIGle9Rt/AfZrgtLIFZ3l3m2A3MyKsee7FnRvCHxvrwD10XKBGsPp6oyGw8Y2O+Geoz71X0YRZsvj3xXuSVebAZm11IUcocstm/arYkSc+vT0+EZiJ9du5s9rZrfEc=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5630.eurprd04.prod.outlook.com (20.178.125.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 13:41:32 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::41:43ca:bf4c:7b99]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::41:43ca:bf4c:7b99%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 13:41:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "inki.dae@samsung.com" <inki.dae@samsung.com>,
        "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
Thread-Topic: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
Thread-Index: AQHVQVEYOnL6Nj5GnEmKqTrzyDUrnA==
Date:   Tue, 6 Aug 2019 13:41:31 +0000
Message-ID: <VI1PR04MB5055BED59960B4F4147479AEEED50@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
 <20190723122016.30279-10-a.swigon@partner.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 490e8f33-3627-4316-34e6-08d71a73cab3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5630;
x-ms-traffictypediagnostic: VI1PR04MB5630:
x-microsoft-antispam-prvs: <VI1PR04MB563066A91E2B0B54C1995EBCEED50@VI1PR04MB5630.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(53546011)(9686003)(55016002)(6246003)(99286004)(76176011)(7736002)(229853002)(446003)(478600001)(102836004)(7416002)(5660300002)(256004)(14444005)(53936002)(2906002)(54906003)(4326008)(86362001)(71190400001)(476003)(6506007)(68736007)(8936002)(26005)(66556008)(66476007)(66446008)(74316002)(52536014)(81156014)(81166006)(91956017)(6436002)(8676002)(66946007)(486006)(44832011)(64756008)(110136005)(25786009)(71200400001)(14454004)(305945005)(66574012)(316002)(186003)(66066001)(76116006)(33656002)(3846002)(6116002)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5630;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h9q5IIVjAVOY3hzHPZmt9AdcmIRHfFQCRzPOdR4w65PBZI7g0rOAon5Jkdk7+NtEF1AE/tfgE7S+HynoZg2/bB2u42u2OYYUne4Htqhr9QVmkLixOt7XO/fVqb9ZYDSDnXh4j+m0gCd7pJPtosUnp4ABb4ImspLc6HeJ2MWRoPHJhCveIkBNPsF/Ukei1ZyFlqOzGHDaRp2uGKbyHY84JAoNr+KZbBOPkkuehV9gS3JIXgQu+xtc/QITEC3PZd61llFdRYIVOZwERhEMucH2Zle2Owk02Y52rR1r+oj4SLXv+rpvplMlSYrAPE76mcgexDUdyT1nSOQaIQd/hGTQJv6hnNI91kVx6ukdvXDW9Px2FLdgKRjKTTgztWoXR/LlcpvkJcVCJJqN4P/8Fj5nIXGFzt7Zb0f4e+plVfRt+KU=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490e8f33-3627-4316-34e6-08d71a73cab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 13:41:31.9578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5630
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.07.2019 15:21, Artur =A6wigo=F1 wrote:=0A=
=0A=
> +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 avg_bw,=
=0A=
> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)=0A=
> +{=0A=
> +	*agg_peak =3D *agg_avg =3D peak_bw;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
=0A=
The only current provider aggregates "avg" with "sum" and "peak" with =0A=
"max", any particular reason to do something different? This function =0A=
doesn't even really do aggregation, if there is a second request for "0" =
=0A=
then the first request is lost.=0A=
=0A=
I didn't find any docs but my interpretation of avg/peak is that "avg" =0A=
is for constant traffic like a display or VPU pushing pixels and "peak" =0A=
is for variable traffic like networking. I assume devices which make =0A=
"peak" requests are aggregated with max because they're not expected to =0A=
all max-out together.=0A=
=0A=
In PATCH 11 you're making a bandwidth request based on resolution, that =0A=
traffic is constant and guaranteed to happend while the display is on so =
=0A=
it would make sense to request it as an "avg" and aggregate it with "sum".=
=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
