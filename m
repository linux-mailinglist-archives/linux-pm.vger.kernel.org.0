Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DB57448E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 07:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGNFhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 01:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiGNFhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 01:37:11 -0400
X-Greylist: delayed 286 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 22:37:08 PDT
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8CC222B3E;
        Wed, 13 Jul 2022 22:37:08 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(2569:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Thu, 14 Jul 2022 13:32:08 +0800 (CST)
Received: from sphcmbx01.sunplus.com.tw (172.17.9.202) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 13:32:07 +0800
Received: from sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1]) by
 sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1%14]) with mapi id
 15.00.1497.033; Thu, 14 Jul 2022 13:32:07 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Thread-Topic: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Thread-Index: AQHYlo2OQSnqDllFTEGHHVYnRdkiea19By6g
Date:   Thu, 14 Jul 2022 05:32:06 +0000
Message-ID: <a510b35f89034f60a05d6dbe7245e789@sphcmbx01.sunplus.com.tw>
References: <cover.1654660009.git.lhjeff911@gmail.com>
 <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
 <be752ee1-3732-bcbd-4d31-6d6fe0bd251f@linaro.org>
In-Reply-To: <be752ee1-3732-bcbd-4d31-6d6fe0bd251f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHN1bnBsdXNfdGhlcm1hbF9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0IHNwX3RoZXJtYWxfZGF0
YSAqc3BfZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsNCj4gPiArCXRo
ZXJtYWxfem9uZV9vZl9zZW5zb3JfdW5yZWdpc3RlcigmcGRldi0+ZGV2LCBzcF9kYXRhLT5wY2Jf
dHopOw0KPiANCj4gWW91IHVzZWQgZGV2bSB0byByZWdpc3Rlciwgc28gdGhpcyBsb29rcyB3cm9u
ZyBhbmQgd2lsbCBsZWFkIHRvIGRvdWJsZSBmcmVlLg0KPiANCj4NCg0KWW91IG1lYW4gdGhlIHJl
bW92ZSBmdW5jdGlvbiBpcyBub3QgbmVlZGVkLiAgPz8NCg0KDQoNCg==
