Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019511C7127
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEFM6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:58:37 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:37667
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbgEFM6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 08:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUNRWNx+pgDe1W65UpTWjJ7vrKMzb3Pdy/5R4AB3Vd0=;
 b=hvRaDuCh+kwYpLqlDwv3iA9kZ1WQtvzZFQAWxyFnGL2ZoBdj6uPsKAUiu0xPR3L49DxyPj8tikHzuDpCcB3grByVQIepUR9u8dN/y/ASQ6DBy4ebYBcpY1zOubXgcWAl4fMyxAXp4iQIale3ZAy+e8USG0kJk4Q9X8zqS39D//M=
Received: from DBBPR09CA0006.eurprd09.prod.outlook.com (2603:10a6:10:c0::18)
 by VI1PR08MB4286.eurprd08.prod.outlook.com (2603:10a6:803:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 12:58:30 +0000
Received: from DB5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::b5) by DBBPR09CA0006.outlook.office365.com
 (2603:10a6:10:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 12:58:29 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT032.mail.protection.outlook.com (10.152.20.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 12:58:29 +0000
Received: ("Tessian outbound 4cdf5642225a:v54"); Wed, 06 May 2020 12:58:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4f9a9e17a0f3979a
X-CR-MTA-TID: 64aa7808
Received: from 029815e716be.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A0DA2ACD-C699-4167-80A8-AA75EDE36732.1;
        Wed, 06 May 2020 12:58:24 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 029815e716be.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 06 May 2020 12:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGdL2J0ytjNhsUuvN12KJFAUrQCFL3XeXTwF7KQBZYmDD6qJrF+R9WVKXGRuudYAEnKEwj84QC7IdvX9cvxHJlpUevbpFEpPszQwKCzkknM4kA+AxAuMW65I1XBIDEsXF843RT0ZszEDLTE5INxqiigTfJ0X2qA+RsXDnjRNdXSlcpYjsvagurz5H4R27u6YufOLJ4PMQkZg1koOIKveqStZUCr/GN0ReYz998+QAspb8F1sOK3oATIvJYjDrZ85EX2XN5xXLrLmxi9NLSi5TZvxO5hjo5h2Q2/p7dc8UMjLBaiEJm4V4JS1gtOQ+flMKPHTj9VNSO/dYSmGChJiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUNRWNx+pgDe1W65UpTWjJ7vrKMzb3Pdy/5R4AB3Vd0=;
 b=EZ5QLWhI3oc47cSPiTqvt/i2XpW19mKCaGI6HiHmcFim3dbBrOjRarRq0VO3YmF24REwBF+USp+/JPJ5KFCTe2pZQWkOdz5X16pUFKqxicDC5nyNpFZzw3yeu/gjF8sbjMCsAz4Rdzx0rmB5tfAo9lZOhmNwFVTGrtKtQ8xN9r2VffnX6aAeseGdrC7vOf+gKbch7pFg1vQi95SiHrN1TvGtqGBAUA5s2QpjyiH4JVkGjNFKkDe9tEMvQLYyjiUHCrEpFayZQUaOMCSMITjwCnwXD2A6aylfYvAmOtXQ8yExkhlKPYfPCZfx+PNopJMfGvjlgQRdjbq06y8kmzJvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUNRWNx+pgDe1W65UpTWjJ7vrKMzb3Pdy/5R4AB3Vd0=;
 b=hvRaDuCh+kwYpLqlDwv3iA9kZ1WQtvzZFQAWxyFnGL2ZoBdj6uPsKAUiu0xPR3L49DxyPj8tikHzuDpCcB3grByVQIepUR9u8dN/y/ASQ6DBy4ebYBcpY1zOubXgcWAl4fMyxAXp4iQIale3ZAy+e8USG0kJk4Q9X8zqS39D//M=
Received: from DB8PR08MB5465.eurprd08.prod.outlook.com (2603:10a6:10:118::15)
 by DB8PR08MB5193.eurprd08.prod.outlook.com (2603:10a6:10:e6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Wed, 6 May
 2020 12:58:23 +0000
Received: from DB8PR08MB5465.eurprd08.prod.outlook.com
 ([fe80::8c5b:a1f0:4345:4a0a]) by DB8PR08MB5465.eurprd08.prod.outlook.com
 ([fe80::8c5b:a1f0:4345:4a0a%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 12:58:22 +0000
From:   Thanu Rangarajan <Thanu.Rangarajan@arm.com>
To:     Sudeep Holla <Sudeep.Holla@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Thread-Topic: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Thread-Index: AQHWI6TVTlHnu8dzE0yKki1PAf+luaibYPOA
Date:   Wed, 6 May 2020 12:58:22 +0000
Message-ID: <028166CD-55C8-4FC6-AEBB-C190D20290D5@arm.com>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
 <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
 <20200506124932.GA20426@bogus>
In-Reply-To: <20200506124932.GA20426@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.15.200413
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [217.140.105.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 990e547c-54dd-4985-895a-08d7f1bd2cc8
x-ms-traffictypediagnostic: DB8PR08MB5193:|DB8PR08MB5193:|VI1PR08MB4286:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4286F89609F2C8AB5282A3A38EA40@VI1PR08MB4286.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4X/Bv3kvbSLk017yJRa5tn1UlTnS7ua9CglUjHaFltFb5PxgNHhQegOupoIYUd+kCq51KkPdp1IQpg0wSOLhTZa4Px6kKa5y12m5p/ocE02bdHuFcLq+txsk1Z83Z4ROlDl9xSicigbA+HroPbOIBGRC3jelx9TYqdU57uw7CbaDjeI39IQhAOL2Kw+8WZiDXd5/tA6lQO7/1CaivbqMJrvyWNkG3sQLDhd6UgwtFw91aHAxPOQXi+bG+AVfwiuEI9iEEl3R038ajz1PMsb+bGJv3OhTD1MfUNII8AaLfvFZ1c92fbb3fD5fKdDurtyMhG1OZzbWAX2y4UTIQP7GtvXdptcLlU/uyT/3an7a2j66Ro9NVjeqgZoKgDgX28Kea+o28t0T6TijvGr8fdbiPAlI//fjP0U3KDZtAMKj784lrYLNCRgaLVAFxQRC/z0vfQw6Nd7k5SWnLCkxd65v0nSu6whEC5xq6kkBN+6OKukagxOQXRQARum/eN6jY1mY4mHGdWPfqKGTgcet3eqMgA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5465.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(33430700001)(33656002)(316002)(54906003)(110136005)(71200400001)(4326008)(53546011)(66476007)(64756008)(6506007)(66446008)(66556008)(66946007)(8676002)(5660300002)(6486002)(186003)(36756003)(8936002)(2906002)(86362001)(26005)(33440700001)(6512007)(478600001)(2616005)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VbICfuZNWvoWEY7tK1bdD5PEnlEMYHWLoO8zoHHJI9CPLg9pXBf44BGuJJqftw3yX44GwK8/SmtjsBaVYFJInEtNLM4YOt3mJ11o6yx+gQFLAJ5jdKgQxrWradm+wciqEWpljntZVPtabRrsZA9VVYUTqqYZTTGNRxAIrj7kzylkuv1SjvMW6j+0doOPtkfZmqYuICUvC5RD1/TOrbBg7uE5v4Mg4pG7STdkHMFaUvsmCyM9bN4scv+VWjoOVotU0RVSroGMXPWKcWhDb4fYSCCRkAUYb2+nFo5z30ZznXymE0xhdB4pck0QqUxVel53705UOTFbysSMstXev/bYqa+SmCRocF1diDDhzvWDyaSn74ux0KZtmaYcU3Y0f3bMqLqhqGaBFesGSctVuonYMUsesrosgGWUNLO04+MzREPDIqu3umRL97m4lpzbN9Onxrqetr222NHJIW+p7cwjgochvpVuMmst55/J7he9hgniYcDZ82DmpNfriItdH4ur2lNIbrUCBCWegYABY9RFwEu1SYlCEi6x6ZieEP7eRJH/0nJxZa9VmX4do6d8L9Vlvo77rpRY3LYf7byTwWTo3P4ToJDWPhnHvwJIoWkYxpfep2iGI2a6+X+5cEWXuxH5sTmC4gRJD14A2/GXHJ6cgzxEyVGRXB2/Z9BJ3PeMnnEc8toPtG1s4ERJeXSAGd0O5bYsi28K5x9GckyAwI09XfholD+jXSATm9bjQZl1QIbae+GuP7SQ3mp8kCLsuoVG7V84QQk7tsIkNGtpW6dLZsHKB1uGdiIx4n3pNH6pifw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211C0670309D0B48A028DCA71350062F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5193
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(33430700001)(81166007)(2906002)(33440700001)(5660300002)(316002)(8676002)(336012)(82740400003)(478600001)(2616005)(8936002)(36756003)(356005)(82310400002)(6486002)(70586007)(70206006)(53546011)(186003)(6506007)(26005)(86362001)(33656002)(110136005)(54906003)(450100002)(47076004)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb075f2e-2fb4-45dd-95ca-08d7f1bd2833
X-Forefront-PRVS: 03950F25EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYsnOf6b2mjxIHwIlQcOzdolLTP5rwqohtgScXZHo3P/9SuGCwsNjgHsLIKks64SNQst68geOnNOzdi4UKSJDdQWyx2E3Mtiyixo0LNUXEZ94ervbMewh0KdLtDxZN05Xg+4c19LN2r97iZCqHYlJeBrDNpvWH9/GPJSGZmFSfjut4zRLjEDFof/R37ofAcoEn58L0rqIn7Vnm+3JnkoX45yzpf7cSK7/TaNbBqpuXXFd56hMBnEJMpJnSCt005AWGqF+goUXKFZJtzqjpcnMGnLiNbFw/wjEz+2CKLuRrYvZaGrkJD+1srFGf8YgKh9dxSp5wDQtUOndkMJ+0+Mndfi4MO9pbnHX9cnxi1wLK/M6guxSHuWGgq5r9LcoYEzIfB5u/mZ9uD2Xt4zHSIMdbYSjCSiccn98vAXvJcea65VeXernWsP20JbaoTfPu8HURiwqzY8xGsDY4C9srBQkVucetz611qV7rMGAiw5rtOprvLI5fX9s/sOV6G9fPZ0bs+H6fyTzcWU+9cFkjXLkGHrN2Z07DZL0fK1NeTbcK601fF2n+ZtaZO86ogarpSZAFL/kpINZUCRJTZ34mlDWg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 12:58:29.8517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990e547c-54dd-4985-895a-08d7f1bd2cc8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4286
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQpBQ1BJIENQUEMgYWxyZWFkeSBzdXBwb3J0cyB0aGUgbm90aW9uIG9mIGJvb3N0LiBOb3Qg
c3VyZSB3ZSBuZWVkIGFueSBlbmhhbmNlbWVudHMgdGhlcmUuDQoNClJlZ2FyZHMsDQpUaGFudQ0K
DQrvu79PbiAwNi8wNS8yMDIwLCAxODoxOSwgIlN1ZGVlcCBIb2xsYSIgPHN1ZGVlcC5ob2xsYUBh
cm0uY29tPiB3cm90ZToNCg0KICAgICsgVGhhbnUsIFNvdXZpayB3aG8gd29yayB3aXRoIEFTV0cN
Cg0KICAgIE9uIFdlZCwgTWF5IDA2LCAyMDIwIGF0IDA1OjM2OjUxUE0gKzA4MDAsIEhhbmp1biBH
dW8gd3JvdGU6DQogICAgPiBIaSBTdWRlZXAsDQogICAgPg0KICAgID4gT24gMjAyMC80LzMwIDE3
OjU1LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQogICAgPiA+IE9uIFRodSwgQXByIDMwLCAyMDIwIGF0
IDAyOjE5OjU5UE0gKzA4MDAsIFhpb25nZmVuZyBXYW5nIHdyb3RlOg0KICAgID4gPiA+IEhpU2ls
aWNvbiBTb0MgaGFzIGEgc2VwYXJhdGUgU3lzdGVtIENvbnRyb2wgUHJvY2Vzc29yKFNDUCkgZGVk
aWNhdGVkIGZvcg0KICAgID4gPiA+IGNsb2NrIGZyZXF1ZW5jeSBhZGp1c3RtZW50IGFuZCBoYXMg
YmVlbiB1c2luZyB0aGUgY3B1ZnJlcSBkcml2ZXINCiAgICA+ID4gPiAnY3BwYy1jcHVmcmVxJy4g
TmV3IEhpU2lsaWNvbiBTb0MgSElQMDkgYWRkIHN1cHBvcnQgZm9yIENQVSBCb29zdCwgYnV0DQog
ICAgPiA+ID4gQUNQSSBDUFBDIGRvZXNuJ3Qgc3VwcG9ydCB0aGlzLiBJbiBIaVNpbGljb24gU29D
IEhJUDA5LCBlYWNoIGNvcmUgaGFzDQogICAgPiA+ID4gaXRzIG93biBjbG9jayBkb21haW4uIEl0
IGlzIGJldHRlciBmb3IgdGhlIGNvcmUgaXRzZWxmIHRvIGFkanVzdCBpdHMNCiAgICA+ID4gPiBm
cmVxdWVuY3kgd2hlbiB3ZSByZXF1aXJlIGZhc3QgcmVzcG9uc2UuIEluIHRoaXMgcGF0Y2gsIHdl
IGFkZCBhDQogICAgPiA+ID4gc2VwYXJhdGUgY3B1ZnJlcSBkcml2ZXIgZm9yIEhpU2lsaWNvbiBT
b0MgSElQMDkuDQogICAgPiA+ID4NCiAgICA+ID4NCiAgICA+ID4gSSBkaXNhZ3JlZSB3aXRoIHRo
aXMgYXBwcm9hY2ggdW5sZXNzIHlvdSBoYXZlIHRyaWVkIHRvIGV4dGVuZCB0aGUgQ1BQQw0KICAg
ID4gPiBpbiBBQ1BJIHRvIGFjY29tbW9kYXRlIHRoaXMgYm9vc3QgZmVhdHVyZSB5b3UgbmVlZC4g
VW50aWwgeW91IHNob3cgdGhvc2UNCiAgICA+ID4gZWZmb3J0cyBhbmQgZGlzYWdyZWVtZW50IHRv
IGRvIHRoYXQgZnJvbSBBU1dHLCBJIGFtIE5BQ0tpbmcgdGhpcyBhcHByb2FjaC4NCiAgICA+DQog
ICAgPiBVbmZvcnR1bmF0ZWx5IHdlIGFyZSBub3QgaW4gQVNXRyBhdCBub3csIGNvdWxkIHlvdSBw
bGVhc2UgZ2l2ZSBzb21lDQogICAgPiBoZWxwIGFib3V0IGV4dGVuZGluZyBDUFBDIGluIEFDUEkg
dG8gc3VwcG9ydCBib29zdCBmZWF0dXJlPw0KICAgID4NCg0KICAgIFlvdSBtYXkgaGF2ZSB0byBw
cm92aWRlIG1vcmUgZGV0YWlscyB0aGFuIHRoZSBjb21taXQgbG9nIGZvciBzdXJlIGFzIEkNCiAg
ICBoYXZlbid0IHVuZGVyc3Rvb2QgdGhlIGJvb3N0IGZlYXR1cmUgYW5kIHdoYXQgaXMgbWlzc2lu
ZyBpbiBBQ1BJIENQUEMuDQoNCiAgICAtLQ0KICAgIFJlZ2FyZHMsDQogICAgU3VkZWVwDQoNCg0K
SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90
aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUg
aW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
