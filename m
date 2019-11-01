Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E18ECC03
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKAXnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 19:43:06 -0400
Received: from mail-eopbgr730100.outbound.protection.outlook.com ([40.107.73.100]:22144
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKAXnG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 19:43:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMn6w7hNDuU2T9IgzGUKP7rtIepLRnMmwFSLQPUE92UInDkI1Y40FucbZScu4dDyhPTkBYO6X58eIRYHYNuseC8jeDbpq5o4IHmKR+Xgf7ESVFUKohQ2BC/Ba2PYlu6FgCQnVTDCe4+1xizbv24KP6R3aIp/k8UQ1j2DIz3K5isTVUd6KLHO3nEM68HGftms2GSADwqGLUvqdBZn4AlCk/6ZTtQjuAdMyP29K1ny2L0p+rXX6QApMecJ7/1nSra5gqI3MDY7WmlsBl4JBcyyyG5eq7Cp4FC0Z2KA0fO6VgKzsMUqyW0zXhubVW24RShrt28dE85K7MFAfHBvkNxi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqvwqunPlCUpVg9n6TPM/fGrmefgNAa1PeHQg7NZB6E=;
 b=chRTZ+6ZqgFI3h4i1duprXeaZMD44JyCtoMGO+MS5Xcbij9Anxyd83SEqpR+9dYFd7yYCUwGoO1gxp7nCZWrYsf56qoDTHzxBNT3o4NGCkyoGL/qZK6g6nq0CT7CIk4h4Lsjg8Sz2ELKi3X5XzBnRc8NUjeKsYcxSMC5SEfkQaQ688XAI4OfD6q9pTbKlkW23qYaS5AcxV3nTpXneUJbD6gmJtuOXT6U9o2YEUgY43vUM4HUKIRNt7dCbnB5FZ0R0l9Uv5XuUa3V2A1l09PyxCZHpWgZnI0xHCv2CbG5LCnKAnGiVILVEx/E4gVRG4AN3+BQ7tP0tkBq7v8yUl2W/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=versa-networks.com; dmarc=pass action=none
 header.from=versa-networks.com; dkim=pass header.d=versa-networks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=versanetworks.onmicrosoft.com; s=selector2-versanetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqvwqunPlCUpVg9n6TPM/fGrmefgNAa1PeHQg7NZB6E=;
 b=ZgzJo8E1IcEVYjPi+e0Y/q+4FW1ZmSG9q9+nmA3zoSAZgbXQWeyL2aqXhnsBua9Bj8ObQbDv7LuxT9D0E3NLn0AJXozQI9jcxnwlBnZ1mGbv4VCdBcUZDoS4TW8MQcSCs76P2BZYClP0zSccq/B222ch/yYLqA//JmIIytJPbGc=
Received: from CY4PR11MB0054.namprd11.prod.outlook.com (10.171.254.155) by
 CY4PR11MB1542.namprd11.prod.outlook.com (10.172.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 23:43:04 +0000
Received: from CY4PR11MB0054.namprd11.prod.outlook.com
 ([fe80::10a5:1e89:39eb:5394]) by CY4PR11MB0054.namprd11.prod.outlook.com
 ([fe80::10a5:1e89:39eb:5394%6]) with mapi id 15.20.2408.018; Fri, 1 Nov 2019
 23:43:04 +0000
From:   Ananda Sathyanarayana <ananda@versa-networks.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Thread goes into deep-deep-state and not woken-up
Thread-Topic: Thread goes into deep-deep-state and not woken-up
Thread-Index: AdWRDhPbB0rM42YwQ9qZtFiuKab/jw==
Date:   Fri, 1 Nov 2019 23:43:03 +0000
Message-ID: <CY4PR11MB00549A282772E109724B9404E3620@CY4PR11MB0054.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ananda@versa-networks.com; 
x-originating-ip: [162.249.37.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3adf80f-937d-424a-703b-08d75f253d47
x-ms-traffictypediagnostic: CY4PR11MB1542:
x-microsoft-antispam-prvs: <CY4PR11MB1542C21E18945A3DC871C242E3620@CY4PR11MB1542.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39840400004)(376002)(366004)(346002)(199004)(53754006)(189003)(25786009)(71200400001)(81156014)(52536014)(478600001)(5660300002)(7736002)(486006)(14444005)(256004)(71190400001)(74316002)(5640700003)(3846002)(305945005)(8676002)(81166006)(2906002)(476003)(6116002)(6916009)(66446008)(102836004)(76116006)(66066001)(86362001)(6436002)(8936002)(2501003)(66476007)(66556008)(6506007)(7696005)(99286004)(66946007)(186003)(55016002)(26005)(14454004)(9686003)(2351001)(64756008)(316002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1542;H:CY4PR11MB0054.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: versa-networks.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cMyrsErZjsI9yFoG1VgXyku5gu0wOCiWjVwnrRLPnkH05/BCEiOCnCmtJUquRXdBtq0L9XCmPowKvBIxN+yJJ1FGvOSeqnsf8Tr0y/pHHpY3MT4l06Z1uOkrGLMKP5cQ8PbXfQMH4t8ZcPbl8nwXwD4n+uf/OvrSEdYAmHt4mAZGugn7C7Hl79PeJFWcVkQ1HRJJWnaIKvn7aMyMiKwXGzNKQx2E7OGT/VXzkWp2s5Zz2vlwzTOW3mtLpHQoR26ByygBrU/lJTk38SSFGiNaGItoJeKsEh/SP21wqHJSezpULXzqGiNR2zO8S4RiYDdeclPrQ6wYUDMRiaaykjlIE9P658x6Uhi3ePCuF4RgMp1Roq4nR1RUyRsGcok+5Oyi8zSb5lYdxq6pyc8V/Ae5GtLdfOkNiNWbvng+0Maktvw6RRCt92ub/jEAb6QRTe4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: versa-networks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3adf80f-937d-424a-703b-08d75f253d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 23:43:03.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d39a23bd-897c-45f1-a3f5-c5213b673627
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iS61n/V+0ysfqf9DHOX1ytGArOPZ7mkdgcU9ifDeDi3ipgnDTKuhIT7qxjUtwLo0/vOPCXTBM1+nsFBVbHhbP4Jw5xMoZ+4m7ftyh0F3+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1542
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

We have a customer critical issue, where one of the application thread  is =
not getting woken up by the OS after calling usleep. This is causing the ap=
pliance and in turn the services to go  down. When the customer connects a =
console cable, the application thread is woken up and the services are rest=
ored.

Appliance : 8 core Atom Rangeley based Intel(R) Atom(TM) CPU  C2758  @ 2.40=
GHz
Linux OS :  Linux versa-flexvnf 4.4.0-142-generic, x86_64 x86_64 x86_64 GNU=
/Linux
Isolcpu is enabled. Core 1-7 are isolated.=20
Application : User space application

Cores 1 to 7 poll for x (in micro sec) time and if no work sleep for y amou=
nt of time (in micro sec). What we are observing is 1 out 7 cores goes into=
 this "non-responsive" state. This issue is not seen not very often (it is =
very hard to recreate). Once we connect the console and press few key strok=
es, the CPU in non-responsive state become active.

Even though c-state is disabled in the BIOS, we do see c-state transitions =
under ./sys/bus/cpu/drivers/processor/cpux/cpuidle directory

We also observed the local timer interrupts were stopped for that core when=
 the issue happened.

Could you please help us understand=20
-	Possible reasons for the kernel not to schedule one of the threads at all=
 (not waking from the deep sleep state)
-	If there is a theory, how to recreate this issue on a consistent basis

Your help is very much appreciated.

Thanks
Ananda
