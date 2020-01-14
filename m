Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847C413A76C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgANKe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 05:34:59 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51678 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgANKe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 05:34:58 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: DDSGWrywoZTokcwV4dW9DBihRMl0GXwzfrFLTrLo9bCy3Sto4hFg7dZQUK/OqtAjRgE7isRgKw
 OBZiiREYUJpzLVZbn4PfeVLsghT1cFKzhuTKfCZGWmb1F1FvrzrUBfVbu5G0fMVrZUABcOSY85
 wSFzGuVZQxbVFDElYRqKgsdC6q8vUQDpwWrnNp6YOuweqVQCBTN3cZ1jXarilgzzUGqqut7yrr
 lmvMs1dCLBzX+LteyuMsFuj7D8Vtf6tUOva3izSgKmuM9eZ8k3k7itr8a/D8mK0FzZASptBiC6
 QnU=
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="61850594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2020 03:34:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 03:34:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 03:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiKAYpCEshGIRPDttJWriYbvtnE4kwS0CosVFVnXhMemILuo/6xqbRnENp/J1aB/jPqYrvot7y43zwrpX4zzmXpNWZH4s0xT6khkVazXNG9j6fXMxyEXQAaPIEgBg1y7yivBwCu+EMONozn36QnJoi15lQMBTJXSgsrBap9LaoEqKx/s0c795wEHh61uI4TnNB5ljcI9UufvIPs3FmApLjGWR1sOS/QTTpdTR4o871YBccEItpm1i1+mRs6dIlTiSbKd1gDl+Z1OEQZlhw1AzTg8VeLMlNkL0K/EoiGHS+LujOfu/GDvUpUURNNUvnEYsh5X1C+Kj1qdNiy5yT4pNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLnPu96GbS6z+HSg7BcsDx2fhpQ5INKuxNSjU9p3gQ=;
 b=nu5SPSPPIehUbqQJ1G1/XQuO0RuQ5tHwH1h1lvNCQkg9FZHX6DGEq25vGaBXaXXPPoh7INuz0of7F+P9hBb0qo+1Uh588jkzLibRgZo/1/xyDbZrkoUrE37zqkYBUXHKf3V2JoqgSBZQAiLy48im94QjPexighC5+mBW3K6lhPsCIttjW0YT+FhajTYZB3PagRO37ny3nysuno5htKfmXQVTLPWXmdYZZ1a0QyijazOEir0zNgUfohfddK9WSdOrOvQgiFv28xw9sakxUDK68fW8Vya4/0EvwWhIt9NnEg8mlE9Anj5nkC1YeoCSZ1x2TDiw6Ae9BE9e1kBYsdHvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLnPu96GbS6z+HSg7BcsDx2fhpQ5INKuxNSjU9p3gQ=;
 b=BCxGd/BhB6vKySe2M19L+7N2dFXSSJ4LMTHSp+tWsFl5WozSRl/bx6GySrJkAzFwkMG4hn00w9vn3cQvZIOZJ5d+ecrAf8LqQDh+oZuV5PRUDWKqPPT9ukCDG0jmER6A9hM1pKkLfoeUT7WO4ELfL6wTHVyom0Y9Icgejw2RwsY=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4092.namprd11.prod.outlook.com (20.176.124.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 10:34:55 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 10:34:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] at91-sama5d2_shdwc shutdown controller
Thread-Topic: [PATCH v2 0/2] at91-sama5d2_shdwc shutdown controller
Thread-Index: AQHVysZDZbGFbsffUkC4vg24P85XXQ==
Date:   Tue, 14 Jan 2020 10:34:55 +0000
Message-ID: <3d0c5a04-25fb-5ae6-fd3a-4049e293eab1@microchip.com>
References: <1576855878-13213-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1576855878-13213-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b365253c-6d12-4ad0-682f-08d798dd65a6
x-ms-traffictypediagnostic: DM6PR11MB4092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4092657FF99AC8BB6835C88287340@DM6PR11MB4092.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(91956017)(76116006)(64756008)(66446008)(86362001)(110136005)(81156014)(26005)(6506007)(66556008)(81166006)(66476007)(8676002)(316002)(66946007)(31696002)(8936002)(31686004)(186003)(4326008)(54906003)(6512007)(36756003)(71200400001)(2616005)(6486002)(2906002)(53546011)(5660300002)(4744005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4092;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuNh8Ia/sGDQHyQ5TZylAckrz9m1e5JlFN9zbAu2ax0MzxdSyqGJ2CmCvXhVGbrV74XdsqRsNuGs9782UUt+ajlWiuq1NW2in6MmMdTcavGz+G6HF/9A8yDdFzZ3f6UVzcmbiu4eRRzM+IjsFWcZIgDwf/O8BbqAjMGE03PXLh5KlTDT29/yOcEiiu2wvd8u/FHH+N2XQ880JJZci8QLM1HF2mRoANQdTXT8KubTup7wXPLlTaLb7ZU/gC0aEi7ouGZJlwpXoAEXkK3qWMyIL4Rge05g9quHk2FBzcl60ZFhvd9DZGC+oXziC0jXECkhubjNC5w1wtxOzh4Nac75A6yb2sanmsYd4tmzBzc38v88Y95L2matwg0NcDQuzxIaJeDHwHZaHgSRnTR6UxgF5g9cHsn5t692poIrKqrUwX8C39SJZsjjHs93Ei2YUe1y
Content-Type: text/plain; charset="utf-8"
Content-ID: <070D50FB6C034041BF1B2B8EF00DC9E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b365253c-6d12-4ad0-682f-08d798dd65a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 10:34:55.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ji/wBafUwkCOKtLnPfePJsm8fehsjPBazOKL1eQb7npMNoC0rHFyqHp1RKIh0JzNbws/MbuiVa3OXnfUuTQ55N8SBj39YomVxr0/5wStZcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4092
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgU2ViYXN0aWVuLA0KDQpJIGtub3cgeW91IG1heSBidXN5LCBJIGp1c3Qgd2FudCB0byBiZSBz
dXJlIHRoYXQgeW91IGRpZG4ndCBmb3Jnb3QgdGhpcyBzZXJpZXMuDQoNClRoYW5rIHlvdSwNCkNs
YXVkaXUgQmV6bmVhDQoNCk9uIDIwLjEyLjIwMTkgMTc6MzEsIENsYXVkaXUgQmV6bmVhIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFBNQyBtYXN0ZXIg
Y2xvY2sgcmVnaXN0ZXIgb2Zmc2V0IGlzIGRpZmZlcmVudCBiL3cgc2FtOXg2MCBhbmQNCj4gb3Ro
ZXIgU29Dcy4gU2luY2UgdGhlcmUgaXMgYSBuZWVkIG9mIHRoaXMgcmVnaXN0ZXIgb2Zmc2V0IGlu
DQo+IHNodXRkb3duIHByb2NlZHVyZSB3ZSBuZWVkIHRvIGhhdmUgaXQgcGVyIFNvQy4gVGhpcyBp
cyB3aGF0DQo+IHRoaXMgc2VyaWVzIGRvZXMuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGRv
IG5vdCB1c2UgcjUgYXMgaW50ZXJtZWRpYXJ5IHJlZ2lzdGVycyBpbiBhdDkxX3Bvd2Vyb2ZmDQo+
IA0KPiBDbGF1ZGl1IEJlem5lYSAoMik6DQo+ICAgcG93ZXI6IHJlc2V0OiBhdDkxLXBvd2Vyb2Zm
OiBpbnRyb2R1Y2Ugc3RydWN0IHNoZHdjX3JlZ19jb25maWcNCj4gICBwb3dlcjogcmVzZXQ6IGF0
OTEtcG93ZXJvZmY6IHVzZSBwcm9wZXIgbWFzdGVyIGNsb2NrIHJlZ2lzdGVyIG9mZnNldA0KPiAN
Cj4gIGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgfCA3MiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlv
bnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi43LjQNCj4gDQo+IA==
