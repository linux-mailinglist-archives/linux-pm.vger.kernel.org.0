Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58F7A71B5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 06:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjITE7W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 00:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjITE7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 00:59:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95FE95;
        Tue, 19 Sep 2023 21:59:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38K4x9Ma008130;
        Tue, 19 Sep 2023 23:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695185949;
        bh=2kJofejqX+wEU3P71Kyp7udwgyl2XVx4ZyJcE8GYz0Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=vyN0FDN+jqwDo36LB1QWJPoHqjLa/YoAv4zBWOtPiWSTbw4ot7VjbTPR31MoAdftv
         pghbGUbTAGONibvI7dFn7Cy73y7XtNaQ1i8I3k0VOJ5jpsIgwY8ixsMFqtzK67/7ns
         PNfLj1oNr+evq7xKJ1NgJVVkuctboxkC1E8AEFuo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38K4x9bp026927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 23:59:09 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 23:59:09 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Tue, 19 Sep 2023 23:59:09 -0500
From:   "Kumar, Udit" <u-kumar1@ti.com>
To:     Thomas Richard <thomas.richard@bootlin.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "Gole, Dhruva" <d-gole@ti.com>
CC:     Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: RE: serial: 8250_omap: suspend issue with console_suspend disabled
Thread-Topic: serial: 8250_omap: suspend issue with console_suspend disabled
Thread-Index: AQHZ57r5ax0kW7Fl7kOc4/fWjO8F8LAjLSyg
Date:   Wed, 20 Sep 2023 04:59:09 +0000
Message-ID: <4b82483e0b024ce9a914e5e65f72ea5b@ti.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
In-Reply-To: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.141.75]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVGhvbWFzLCANCkFkZGluZyBEaHVydmEgaXMgbG9vcCwgDQpMb29raW5nIGF0IGNvbW1lbnRz
IGluIGZ1bmN0aW9uLCB3aGF0IHlvdSBhcmUgc2VlaW5nIGlzIGV4cGVjdGVkICwgDQoNCllvdXIg
d29yayBhcm91bmQgMSBzZWVtcyByZWFzb25hYmxlIHRvICBtZSwgYnV0IGluc3RlYWQgb2YgcmV0
dXJuaW5nIDAgYWx3YXlzDQpwdXQgYSBjaGVjayBhcm91bmQgbm9fY29uc29sZV9zdXNwZW5kIGFz
IHdlbGwuDQoNClJlZ2FyZHMNClVkaXQgDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PkZyb206IFRob21hcyBSaWNoYXJkIDw=
