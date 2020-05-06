Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0121C7372
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEFO5W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 10:57:22 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:38788
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbgEFO5W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 10:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq8ewNNbXSisigeUJxAxG1wM+FjNAgBXj++2UOugabs=;
 b=uyNvGYEvrce044M9YYFkSFBpbMG70vxkrURs+gKnwHxTTKApu5fo2oGdkwBgQSeaV6jvtKgAdNZl3vV06YaTLIyDgAKbceAgQoXQag+3aiEpCm9G9qctTOtgzJhZXFzsAblsswj53pn5SX95JY+1YXXhS6tTKABiIZmVEl8ZQ14=
Received: from MRXP264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::31)
 by VI1PR08MB2893.eurprd08.prod.outlook.com (2603:10a6:802:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Wed, 6 May
 2020 14:57:16 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::6) by MRXP264CA0043.outlook.office365.com
 (2603:10a6:500:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 14:57:16 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 14:57:15 +0000
Received: ("Tessian outbound ff098c684b24:v54"); Wed, 06 May 2020 14:57:15 +0000
X-CR-MTA-TID: 64aa7808
Received: from 43d2ff9d35ff.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DF8C8674-A9C7-4CC3-8A03-A597A4B214D2.1;
        Wed, 06 May 2020 14:57:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 43d2ff9d35ff.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 06 May 2020 14:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxa1jHlc/tLiFSy/fAA77yZzTms4Yvi85V00hcVaBgqmfcMyE+rHm6m/V9xAg162/WhrUE693LSp4jEMzBhWOPIiOljY3Hn7VNPxXC0BwixQ6tyxEcWG/Sw5Vg43EdjSqnwNFlKGfzf/F8a2+gn9IPAFLcZE1gA+kh3RZu7ucxbMHAbt2baoBH1XSzqbgqcSZwGgoiLXsGqkJ9NjTKZd3NsoYJkVJe++x1lLU6aSosZKrX1WXMtw3mATPsdRhiEHjOcjouMjpAAkeHdYCxNhZ24OOXBZRVzli1Cx0y3uqQM8zvbTeg3b4TGmet35EVErDO7RtPmAfPlI4Hi5vya2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq8ewNNbXSisigeUJxAxG1wM+FjNAgBXj++2UOugabs=;
 b=Aqs6YzVpDDJ4R3MYaOCA4vXLB/Ytbr6QlC3G7H3pZV/lKaCJN8xx4ctqyRYla99b/oodRetSgOXptYLKi5/1IFpR7d/P7ZYNIAMga+S77DLsH5jbcptpOcupLbm2Df6SVYrsebSaFQtaw6ykJTGBMe/ylGIZJNM/G0yTPyVMIyEo5NVtVj7s0eU13eshvehCbJKW4ZwjNh4wRjgcVnHBZhONMuC5neA5opq6o1JUjVrcGBKe1bEJB+5j9tye/qAhHFy/THU3jVMbyi6YndwZdrv49AzyaIKeXxe80SjcuPMhlx9vVxZO5ClCBhP7YdrwpVqRSbF6tB/WIYdig9+BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq8ewNNbXSisigeUJxAxG1wM+FjNAgBXj++2UOugabs=;
 b=uyNvGYEvrce044M9YYFkSFBpbMG70vxkrURs+gKnwHxTTKApu5fo2oGdkwBgQSeaV6jvtKgAdNZl3vV06YaTLIyDgAKbceAgQoXQag+3aiEpCm9G9qctTOtgzJhZXFzsAblsswj53pn5SX95JY+1YXXhS6tTKABiIZmVEl8ZQ14=
Received: from DBBPR08MB4790.eurprd08.prod.outlook.com (2603:10a6:10:f4::13)
 by DBBPR08MB4281.eurprd08.prod.outlook.com (2603:10a6:10:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 14:57:07 +0000
Received: from DBBPR08MB4790.eurprd08.prod.outlook.com
 ([fe80::d0f9:e0b9:cd3c:cc64]) by DBBPR08MB4790.eurprd08.prod.outlook.com
 ([fe80::d0f9:e0b9:cd3c:cc64%5]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 14:57:07 +0000
From:   Souvik Chakravarty <Souvik.Chakravarty@arm.com>
To:     Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Thread-Topic: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Thread-Index: AQHWI6TVdXethDjvWkGpx2AU1gBtwqibBMEAgAAYiQA=
Date:   Wed, 6 May 2020 14:57:07 +0000
Message-ID: <DBBPR08MB4790CF20D2CA65BC314C937882A40@DBBPR08MB4790.eurprd08.prod.outlook.com>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
 <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
 <20200506124932.GA20426@bogus> <028166CD-55C8-4FC6-AEBB-C190D20290D5@arm.com>
In-Reply-To: <028166CD-55C8-4FC6-AEBB-C190D20290D5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3b1988af-12de-4e49-bf8b-5112c2c70c1f.1
x-checkrecipientchecked: true
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2a02:c7f:1e66:2200:68c9:b740:f348:7ca6]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4860ac87-a8c0-4328-65f6-08d7f1cdc411
x-ms-traffictypediagnostic: DBBPR08MB4281:|DBBPR08MB4281:|VI1PR08MB2893:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2893DEF82B03D9C302FAC36D82A40@VI1PR08MB2893.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KmydVf8K1OMcNUvM2eDQr1pwp8qxtTvVz5Xc+b/07iRdNZakvvLAV8QVZjxdSH/QgcDQviK8DU9QvJZV3Q2ar5ItRvf/N71Wd1Pd4dkGHp2m/XfBVmrACtDpu0EERECNZdF1hPvUzs6rwbI4KQUHlVVp9XhuaZtPq+xDGUCGJLDG0t/HpIQX9k+SYisuHRE5EMQlKdBUy/emHoRNf7N59sclC2eQxkALTxTcF+Ob9/s/cox13QkY6TwxzHLB2q35+QTvLIOrS58Mu+ZCKqhQ+vtdPOMIyFjwNau5kEm0l7nX4OzEy8Ga9MMB9ea5JONmmRZIVPlCd/oMAOpJZh60JJ2CZyU+RdDLUdsOefG/xI5D2SNTRgI8k9E2dY23u1gjfglPL4faNRLhpB0dCCMajD3GT4PW/XcKd1GOzRFrTXL3W2WSZgt90EGX0pLqcN66yiHr0XIqvfbhDUoqZnuIF9uuhnbghdnzu8zGEI/UjaaGFoRzw2/LXkRALU23CyNz/6wCmNx/JXtwsJRpiFF3aw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4790.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(33430700001)(478600001)(2906002)(6506007)(53546011)(33656002)(64756008)(52536014)(66446008)(7696005)(5660300002)(71200400001)(9686003)(55016002)(66476007)(66556008)(66946007)(316002)(76116006)(4326008)(110136005)(33440700001)(54906003)(86362001)(8676002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Nw2ZGiJAVWXMaYcbSxNKGeUEc45mNOozx/vemF2wO06Z4XtI84KK+tr973kFWCaT7FXce7xr6SivHq3Z5/Gn4a5j9FvDJW3dyBTIoLnt3QppvDvqkVMbxmmCoTfZBFDMpYetUAyT0v6uYtW2izdHjdzoiVNl5M7Lz4GWiULNw81id+cQcm9uQwztSMqeyb02tPiYp5xk52UwddbdoB3FBKg72lHP6pZZZHqip2yEJarZbAuwGYhg/TD3NkpeatBZTOuwllV4PreuqyjySe3lSDhJMDuA3GgnhrUdLpt0jfxMLD7iObOLAR0VAdeGb6zqGjyl5dweFFBzzKyccSHtm8Kw7FJPZHwvj1nCuAvKLZVEoJI63V+9JfznWBexN3PsQxi4kLyYjUTYsb7TOfruf9vaEEQt3lW3x3reIyggmOm7ljYNTeSfP80OevfXlhPwAPxAsuBcOqQPQNtnP3/31RyKX9uPprBvysKUK4dQ3T2ht2v/I6brHnbLS8/xTuPfcSJR9UhpVnisJRBRcNG206ooweHsCT0YZovACIfK8ADE8MoQq/y9Ezx+ebCiyLyjZrxzV2Anp8jqLplR3mfVK1EvbER65O3O2uqWHDcY/TgW4nj8rr4H0fkeJDRu1KFT7P79FxCF/tdoBBbjHE57JczBtxWvMt3cIVRcn+dGECstbVR0I102j9nwZPHyAsunobeEN9YsYk68ELnlybHl2mMwvKH5a8gd1xO2Fo2BtmsmxyLL4Z5wa2GgvX4qVxHtXPE2skwvvTH4az/ZvosZL1tpWHnYQuMdAtHE206k+Li7t7KFbqo8OOP5rKJv85Hu9cL8uTiYMrkN1Fz+Ho9isQW0B9K+PxMti9Ns8thDv/0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4281
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(33430700001)(8936002)(82740400003)(47076004)(186003)(52536014)(33440700001)(6506007)(53546011)(33656002)(356005)(82310400002)(7696005)(26005)(81166007)(86362001)(450100002)(55016002)(4326008)(107886003)(70206006)(70586007)(54906003)(110136005)(9686003)(5660300002)(336012)(2906002)(36906005)(478600001)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7076f44d-d088-49b9-26a3-08d7f1cdbf03
X-Forefront-PRVS: 03950F25EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpCD6CA3Zarc3tL2sCgVjarizt2yuSIDB8LWmj2LFOhwgJSSz6JzJbT2yckP5Y5fCWzG27J5vZIE3V6HxGGz6e/+5Rpx/v8Bq+pCRgcNm4yy4EYH8UPz51mCWHfiocIklczcc2yQy8BbKj8TQfPXkT7JUa6jRUZ73s7DxWOvgVVxJG2xfDZgpD0AvABB0pBb8hApMKh41v/5MYeTchrU2VC/o1RixvjtBLeqOsJ1rALH7qgXxHbc60j2dF2hLBN8kwFWuOja6IGliPgErpJLru/tESZp5uUV4dN1XJBZgS55M/y4a6ZHpFcMpYInPMSUIpZps1fE9tsAeVnLga+Lt6CHCYJuLh0W8gKXBx+XtK9uqmOHlRSwj6oB5MeKbNLEtytPXh4Y5l+QZnFR6Av+umXkXk1wDnrv5x6d70dfd/OIyv+bRy/aKVY/RajTSzbDcWmf3N5lY1IjRV4nATa2Adt55/Ic1wHYkF8jfN3dJxrOhDn7CcS3q84O/uBltZQcJk8sKzV72uqkGflqF2nFfQfcgB8UKF7tlPG8mu5mYn482JIdb+QVfL6Mz56hALF2FmT0kyKtkT/YLHaG0UTpVA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 14:57:15.4899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4860ac87-a8c0-4328-65f6-08d7f1cdc411
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2893
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCj4gRnJvbTogVGhhbnUgUmFuZ2FyYWphbiA8VGhhbnUuUmFuZ2FyYWphbkBhcm0uY29t
Pg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA2LCAyMDIwIDE6NTggUE0NCj4NCj4gSGksDQo+IEFD
UEkgQ1BQQyBhbHJlYWR5IHN1cHBvcnRzIHRoZSBub3Rpb24gb2YgYm9vc3QuIE5vdCBzdXJlIHdl
IG5lZWQgYW55DQo+IGVuaGFuY2VtZW50cyB0aGVyZS4NCj4NCj4gUmVnYXJkcywNCj4gVGhhbnUN
Cj4NCj4g77u/T24gMDYvMDUvMjAyMCwgMTg6MTksICJTdWRlZXAgSG9sbGEiIDxzdWRlZXAuaG9s
bGFAYXJtLmNvbT4gd3JvdGU6DQo+DQo+ICAgICArIFRoYW51LCBTb3V2aWsgd2hvIHdvcmsgd2l0
aCBBU1dHDQo+DQo+ICAgICBPbiBXZWQsIE1heSAwNiwgMjAyMCBhdCAwNTozNjo1MVBNICswODAw
LCBIYW5qdW4gR3VvIHdyb3RlOg0KPiAgICAgPiBIaSBTdWRlZXAsDQo+ICAgICA+DQo+ICAgICA+
IE9uIDIwMjAvNC8zMCAxNzo1NSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiAgICAgPiA+IE9uIFRo
dSwgQXByIDMwLCAyMDIwIGF0IDAyOjE5OjU5UE0gKzA4MDAsIFhpb25nZmVuZyBXYW5nIHdyb3Rl
Og0KPiAgICAgPiA+ID4gSGlTaWxpY29uIFNvQyBoYXMgYSBzZXBhcmF0ZSBTeXN0ZW0gQ29udHJv
bCBQcm9jZXNzb3IoU0NQKQ0KPiBkZWRpY2F0ZWQgZm9yDQo+ICAgICA+ID4gPiBjbG9jayBmcmVx
dWVuY3kgYWRqdXN0bWVudCBhbmQgaGFzIGJlZW4gdXNpbmcgdGhlIGNwdWZyZXEgZHJpdmVyDQo+
ICAgICA+ID4gPiAnY3BwYy1jcHVmcmVxJy4gTmV3IEhpU2lsaWNvbiBTb0MgSElQMDkgYWRkIHN1
cHBvcnQgZm9yIENQVSBCb29zdCwNCj4gYnV0DQo+ICAgICA+ID4gPiBBQ1BJIENQUEMgZG9lc24n
dCBzdXBwb3J0IHRoaXMuIEluIEhpU2lsaWNvbiBTb0MgSElQMDksIGVhY2ggY29yZSBoYXMNCj4g
ICAgID4gPiA+IGl0cyBvd24gY2xvY2sgZG9tYWluLiBJdCBpcyBiZXR0ZXIgZm9yIHRoZSBjb3Jl
IGl0c2VsZiB0byBhZGp1c3QgaXRzDQo+ICAgICA+ID4gPiBmcmVxdWVuY3kgd2hlbiB3ZSByZXF1
aXJlIGZhc3QgcmVzcG9uc2UuIEluIHRoaXMgcGF0Y2gsIHdlIGFkZCBhDQo+ICAgICA+ID4gPiBz
ZXBhcmF0ZSBjcHVmcmVxIGRyaXZlciBmb3IgSGlTaWxpY29uIFNvQyBISVAwOS4NCj4gICAgID4g
PiA+DQo+ICAgICA+ID4NCj4gICAgID4gPiBJIGRpc2FncmVlIHdpdGggdGhpcyBhcHByb2FjaCB1
bmxlc3MgeW91IGhhdmUgdHJpZWQgdG8gZXh0ZW5kIHRoZSBDUFBDDQo+ICAgICA+ID4gaW4gQUNQ
SSB0byBhY2NvbW1vZGF0ZSB0aGlzIGJvb3N0IGZlYXR1cmUgeW91IG5lZWQuIFVudGlsIHlvdSBz
aG93DQo+IHRob3NlDQo+ICAgICA+ID4gZWZmb3J0cyBhbmQgZGlzYWdyZWVtZW50IHRvIGRvIHRo
YXQgZnJvbSBBU1dHLCBJIGFtIE5BQ0tpbmcgdGhpcw0KPiBhcHByb2FjaC4NCj4gICAgID4NCj4g
ICAgID4gVW5mb3J0dW5hdGVseSB3ZSBhcmUgbm90IGluIEFTV0cgYXQgbm93LCBjb3VsZCB5b3Ug
cGxlYXNlIGdpdmUgc29tZQ0KPiAgICAgPiBoZWxwIGFib3V0IGV4dGVuZGluZyBDUFBDIGluIEFD
UEkgdG8gc3VwcG9ydCBib29zdCBmZWF0dXJlPw0KPiAgICAgPg0KPg0KPiAgICAgWW91IG1heSBo
YXZlIHRvIHByb3ZpZGUgbW9yZSBkZXRhaWxzIHRoYW4gdGhlIGNvbW1pdCBsb2cgZm9yIHN1cmUg
YXMgSQ0KPiAgICAgaGF2ZW4ndCB1bmRlcnN0b29kIHRoZSBib29zdCBmZWF0dXJlIGFuZCB3aGF0
IGlzIG1pc3NpbmcgaW4gQUNQSSBDUFBDLg0KDQpJIHdvdWxkIGFncmVlIHdpdGggVGhhbnUgaGVy
ZSByZWdhcmRpbmcgdGhlIEFDUEkgc3BlYyBwYXJ0IC0gZXZlcnl0aGluZyBpcyBhbHJlYWR5IHRo
ZXJlLg0KDQpJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSAuc2V0X2Jvb3N0IGlzIHRvZGF5IG5vdCBo
YW5kbGVkIGluIGNwcGNfY3B1ZnJlcS5jLiBJbiBmYWN0IGlmIGEgcGxhdGZvcm0gcHJvdmlkZXMg
YSB2YWx1ZSBmb3IgSGlnaGVzdCBQZXJmb3JtYW5jZSB3aGljaCBpcyBkaWZmZXJlbnQgdGhhbiBO
b21pbmFsIFBlcmZvcm1hbmNlLCB0aGVuIHRoZSBlbnRpcmUgcmFuZ2Ugb2YgcGVyZm9ybWFuY2Ug
aXMgYWx3YXlzIHJlcXVlc3RlZCwgd2hpY2ggd29ya3Mgd2VsbCBmb3IgcGxhdGZvcm1zIHdoaWNo
IGRvIGJvb3N0IGVuYWJsZS9kaXNhYmxlIHNlbGVjdGlvbiBhdCBoYXJkd2FyZS9maXJtd2FyZSBs
ZXZlbC4NCg0KLmJvb3N0IGhvb2sgY291bGQgcG90ZW50aWFsbHkgYmUgdXNlZnVsIGluIGNwcGNf
Y3B1ZnJlcS5jIGZvciBwbGF0Zm9ybXMgd2hpY2ggd291bGQgbWFuYWdlIHRoZSBib29zdCBzZWxl
Y3Rpb24gaW4gc29mdHdhcmUuIEJ1dCBpdCB3b3VsZCBiZSBnb29kIHRvIGtlZXAgYSBjb21tb24g
aW1wbGVtZW50YXRpb24gd2hpY2ggY2FuIGNob29zZSBiZXR3ZWVuICJzb2Z0d2FyZS10cmlnZ2Vy
ZWQgb3IgYXV0by1ib29zdCIgc2VsZWN0aW9uIGZvciBkaWZmZXJlbnQgcGxhdGZvcm1zLg0KDQpS
ZWdhcmRzLA0KU291dmlrDQoNCj4NCj4gICAgIC0tDQo+ICAgICBSZWdhcmRzLA0KPiAgICAgU3Vk
ZWVwDQo+DQo+DQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWls
IGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJp
dmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRl
bnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3Jl
IG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
