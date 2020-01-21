Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E697143A41
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAUKDf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:35 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14542 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAUKDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:34 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: sAgMJ+qS2Wva6we+NCcDFMepw7yDl+KoR9089mufQTc0BPAP2gU0b0Ij9XURmpAnv4wP5Tlg6z
 VzAHeGpGQVxiL9KUBy7TN34Zqy2etXZXvNTs9GmeeVqvEIQXWvWqoQYWehaoSmnNR8pG8hsKyi
 ttrKHlsJsX5jrSh0o7sdNDSMtf8nIwmgC1f3eBAkkHySl2/cYA+483Q0+UEQ2ZrD30X7ZXBapk
 NnvheMYgx/2pT3xPPAStMsmNEf4vFJtUjHydFJvh+Wh700OSM96JkEeUu+cskUURKZp/tr0r21
 xrg=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61481930"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX7YeN1LGTN9MWw5Yf2P2andwnNoJA9fcSfMFNNv7nE4ZLHyb1OISThGCQYMM832TlTteNuFYOwS/0Pmc6YV8ZQuhS9EMYlBNMlXnSLLsj4w/p3zJUSVrfRuAhVvqy0NyCVQ333y/CdJJe38yd7IQyOy+1kKWHu7zlifRa3dbTYwEmFKWhk3Q4iQD5OvxvgQ/o1ZuB7ydp5YizljZlNxC7QlCjatkPps1bNnJF0H16QRGCoekBa46FpdY+4dLAGnFQlXW3uqT1kq33dB37gjKLREijq4pM8Rz1dtP83GXHwIaUxcrMSGvNGhjLKZ9y35te6KL4brDeXiUtM7Ss0ncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/gm0vMPRCCQYjrErM2K3x3pv/CYsatkgSqFR+foS4U=;
 b=O0lwt3qUOtxS/1lYvPiP8Inp9ZUAVcNsx559TsbxeG1pAz9Di967/0mBnp+wWpGHA/pDc9cr6d+qSf/cYCSbUuqzbp7rZSGXkqXh+YZsooVrMr/kZSpaNZ0mP0CyDdJcW2cry1Kmp28u3NSnIu+eWy00+WOdaPVERybtpj72vMMCmZbI3SijsZPQxClkfx+2LNKm+HJle9qjP1ByICRChB9rhfURKXTxH3ER1sDrqRd+R0pPTvBrspPq/SIgmpkbYeDmoJpVuOZawL16bx9xlWpQNaFyv7+4geVPEoywZd1lklUcSgqpP6cca0HpL0+KcX5XcMexA8bLzIFQsBW/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/gm0vMPRCCQYjrErM2K3x3pv/CYsatkgSqFR+foS4U=;
 b=KDa70kaXPeatTGGn+TWvTNo38X6Ulf02vNmLhlJVVWJDelwH8YAnqJXm1q8N6uDurTEz0BszyC88xN/0ODraSMvoHMZuXEzu+lS++sBs0LCTwEAeXrEBAdhs+nPe4P7W/FSwBfGgai3kS5h562prjUfUWkn/wX2AQff+cgYAnsg=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:29 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 00/15] rework at91-reset driver
Thread-Topic: [PATCH 00/15] rework at91-reset driver
Thread-Index: AQHV0EIHtIcFpF8lzUOUJpmaavR/Iw==
Date:   Tue, 21 Jan 2020 10:03:29 +0000
Message-ID: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 009ab9ff-9653-4ee5-add1-08d79e592a2f
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195536EAC4610F7DE4EF110870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdcVNa6gSKQiSSfz63OKcjAEQMgMh7ygop8WZVZHCq3RuJhtgfDOxXg77YuF42CGtlDOPFUR6s8yVvkRUaLcf3z7LFDhcG5zKPIM4v/u2lZzOc1WhrUUzBsf9ArXf9MkwglrM4yPUN24ffbBwJbxnQqgJm+hZQ+gqlZwq1voMVPQe3L7kTN1bOan6hq6+2bCvIhFFruobf5x2X5wC6RG4ZYUAAopEV1BMsrU2EHq4Mp71GNoNxBJeCWhC0oxqUzg3yv71SM6lCy/v5yCwzLtGR9pr2TqgJJJoPD6/96Wu+GuO7utYHnKG2kz0C1ts3Ju/p/yN+Tt6HLj43+gpcIlGaYsmf4SJE5eqg4eupZtRO2V20/p76FVFqEvg8FjiZwcj7hF5+G3WEFUmN1p+iU0KsLGfrwDnZbuOqnCZ7Ckmlw0dpy1S9XUtbg3opskRtxs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 009ab9ff-9653-4ee5-add1-08d79e592a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:29.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd93GEecR96a6/jKPOyDrmF/bX/zWtsv2RwhNPUNi5SAeseBTeHUosLLvoHvAjyXcDuW16idQ4GCbIUyWQ85/32j/Vf3u1bUPnq+QAp9rKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The following patches rework the at91-reset driver and solves
the SAM9X60 VDDCORE fast drop in the first 100us after power down.

Thank you,
Claudiu Beznea

Claudiu Beznea (15):
  power: reset: at91-reset: introduce struct at91_reset
  power: reset: at91-reset: add ramc_base[] to struct at91_reset
  power: reset: at91-reset: add sclk to struct at91_reset
  power: reset: at91-reset: add notifier block to struct at91_reset
  power: reset: at91-reset: convert reset in pointer to struct
    at91_reset
  power: reset: at91-reset: pass rstc base address to
    at91_reset_status()
  power: reset: at91-reset: devm_kzalloc() for at91_reset data structure
  power: reset: at91-reset: introduce struct at91_reset_data
  power: reset: at91-reset: introduce args member in at91_reset_data
  power: reset: at91-reset: use r4 as tmp argument
  power: reset: at91-reset: introduce ramc_lpr to struct at91_reset
  power: reset: at91-reset: make at91sam9g45_restart() generic
  power: reset: at91-reset: keep only one reset function
  power: reset: at91-reset: get rid of at91_reset_data
  power: reset: at91-reset: handle nrst async for sam9x60

 drivers/power/reset/at91-reset.c | 190 +++++++++++++++++++----------------=
----
 1 file changed, 94 insertions(+), 96 deletions(-)

--=20
2.7.4
