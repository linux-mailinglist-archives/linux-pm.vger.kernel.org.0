Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0A7140F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfGWIgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 04:36:07 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:47847
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfGWIgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 04:36:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG7d02dhlsgcRu/FCpKGu8mVJrQTnCGOKi2ezvPw08fJ7GO0k3bTltKDLp49XnR+CvCR3uQp4bTCnk9p/Zo5KG9RGh6FMvpkW/2OqSrssk0G+TzpLuDGDYW+t1DUtCEbglE9NzOiSJqCkoQX750c+8H2UYw0rlecWkHcoi28KtBcFIiV5SREU5ncPKOQELyVAp7c1TTs/XAsXiR3TzhrOvN9EKf3k+xGYexXhEGVMZojXXa4uzajnuaT02Qs00LdfRC1FmLX/GrBEw1c1u3rkpTprnvJZN2gvLrWlDSTevK5ccbFHEj7ATLa7UPkrXrw1eMiNkCMFZYaXK2459DtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+DMNvR/r0LZQSKAN9D80xWojyJEfpmuFE/8+uUnpc8=;
 b=MWHxNhevwLrTqg+ZVsVncC4oBbwrEJIKdG4BIMbbBgApT+UBcc6uO4N5DvLgf8IVyM8HscqVL4/TfG5xB5zDFQbruHOgWp5Gw1w4l+7L/5KHsyJMeUy5WiUZBeQUMjExyLI/Rh3zYPVK5cmXk5EWCYSkLrXEROiBvfdAyWithsSjPfdgV44xUBxhoTtZiGb8Vo5qTuuKPC4fuaob58hkMlJ5F/XoqumNytsvR5VOjgZl+Bs6ZZP6hTG8JCmCwBsHOgZ28xX8TTeob99eOL9iwNsrENxlo1/bUz5WFjvJcXCZzJdJtWORi9tTi1Cj9vOvMRxmNtiBVYvgiq349wZ7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+DMNvR/r0LZQSKAN9D80xWojyJEfpmuFE/8+uUnpc8=;
 b=DUtTfFsxqZ6vOGDiWoBTEXjEv+9E6frhqjDSE5Y3CnG0lMWX+fJWQyrm/LrVo1pXcNhL1mlq/lq/V3DO2H86CGFJcFs8EbUr4z4K+HP/TTsnGk7pHtFajOchCruw51wgTTSXv6GjaB4g9tP2bRxX512/EUvJkcnhSyuqndQYsK4=
Received: from DB7PR05MB5338.eurprd05.prod.outlook.com (20.178.41.21) by
 DB7PR05MB4506.eurprd05.prod.outlook.com (52.135.131.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Tue, 23 Jul 2019 08:36:02 +0000
Received: from DB7PR05MB5338.eurprd05.prod.outlook.com
 ([fe80::bceb:bd6:4a4a:a604]) by DB7PR05MB5338.eurprd05.prod.outlook.com
 ([fe80::bceb:bd6:4a4a:a604%2]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 08:36:02 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        mlxsw <mlxsw@mellanox.com>,
        "idosch@idosch.org" <idosch@idosch.org>
Subject: Re: [PATCH] thermal: Fix use-after-free when unregistering thermal
 zone device
Thread-Topic: [PATCH] thermal: Fix use-after-free when unregistering thermal
 zone device
Thread-Index: AQHVNwkSlqT2tAfrEU2yZ3KmbaFNk6bX9T0A
Date:   Tue, 23 Jul 2019 08:36:02 +0000
Message-ID: <20190723083600.GA31076@splinter>
References: <20190710101452.32748-1-idosch@idosch.org>
In-Reply-To: <20190710101452.32748-1-idosch@idosch.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM7PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::23) To DB7PR05MB5338.eurprd05.prod.outlook.com
 (2603:10a6:10:64::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fb1b5c4-c12e-44cd-a828-08d70f48cb9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB4506;
x-ms-traffictypediagnostic: DB7PR05MB4506:
x-microsoft-antispam-prvs: <DB7PR05MB4506FAD65AFF3526A57FF78BBFC70@DB7PR05MB4506.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(102836004)(110136005)(7736002)(305945005)(386003)(1076003)(54906003)(6506007)(66066001)(52116002)(99286004)(446003)(26005)(4744005)(25786009)(53936002)(11346002)(68736007)(6512007)(9686003)(186003)(6246003)(486006)(33656002)(8936002)(66946007)(476003)(4326008)(81166006)(81156014)(2906002)(66476007)(66556008)(66446008)(33716001)(8676002)(64756008)(2201001)(3846002)(6116002)(76176011)(256004)(71200400001)(71190400001)(2501003)(86362001)(478600001)(6436002)(6486002)(5660300002)(229853002)(14454004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4506;H:DB7PR05MB5338.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1fbpJpdFxX9ZCSUy3iMacseCRaXbQtxsbRaO810aC1Kh2cEX3sXAdcz/KFZohFfSQj7o+zoIvlNJPjTCYco0RqQR5gs6dQXyJKHZA7IBfl//oBpP2ipzHDLkd80eNp5eb+qAlw4U2TzIpjEI2KFiOxJOKqa3itibtlzAc+gWvU3F/OTUoCeT7Ld8mKmVuYm428yjpvz4oybGMSxudkxHHOzZc/qtmPEY2lj6ebsfBoKx9XfKPy/uTDwRvFNukyLiR60oS7NSfaPyK/UoCBMtx2i3EXaAW4Tswj4GH05DaCU7yi38LRQIlVlqhg7NRTLbvkjmIhKYAj2s2q0hLUBeTCzq+9LsUU0YCDG3CKcEO4VnZqagWwv+yM+poon7ftXOA/Mk2Ggn+1K5uW6ub3tlYHKvDXBqItgF2K/FJBlyCyw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE77FE7CD91C9748B5E554C26B595F2A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb1b5c4-c12e-44cd-a828-08d70f48cb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 08:36:02.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idosch@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4506
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 10, 2019 at 01:14:52PM +0300, Ido Schimmel wrote:
> From: Ido Schimmel <idosch@mellanox.com>
>=20
> thermal_zone_device_unregister() cancels the delayed work that polls the
> thermal zone, but it does not wait for it to finish. This is racy with
> respect to the freeing of the thermal zone device, which can result in a
> use-after-free [1].
>=20
> Fix this by waiting for the delayed work to finish before freeing the
> thermal zone device. Note that thermal_zone_device_set_polling() is
> never invoked from an atomic context, so it is safe to call
> cancel_delayed_work_sync() that can block.

Ping?
