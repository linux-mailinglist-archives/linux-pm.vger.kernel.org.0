Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552E615BB8A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgBMJWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 04:22:02 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:28483
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729576AbgBMJWC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 04:22:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUrMtHTgJKnqS0l4njE321JRQpDicWxJ2pUId++HtooWKt9PUg77jXYIMe0SqteUrKMJPgGaSkwFTfvtq0UTd8FcNvc9oF6lx/U5wY3bRgJFdq8AiNXMPGlF3QR8uknZMeUy69KkHs8BCsgLb3ty2yZKpMsF+XhZE2aoB/+RDoDFgSgMiRHL/fRv6uMgpRl/02sX5AT9YRhKDqDsMZC8J+iOcTbi+ZgzrzFQjT/JAyVLO1Z8DTOBxZzhEX0Yh5VMTvJaQQn96OkM2YNjTHUtfEV9efLOuL541Wl9ncMU6fiuv4MWBO/T7Zoh/+MQCXbw09RQIOpVgYOSLVzQgtgt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFWobxtbuiBAB0Q2lpP7PJ7ovHS+w/iBhsRBBlSCFZ4=;
 b=kgMF7yQItAlodlZHj9wPnObeCQK3rhzZZrUZxb1yk94c0lE9K6YI2AC3tT8MDWFTo3upq513GyoG8Squekiio17QHYgWW8VdtmLHhGwG8jt400IFVmHR3pQU9oOagAkQAjgdJn/j2Ioo/j2Bvhq1/XaQ7fpcHagsbLG+V87kd0YHp2ODnuMxXEUYz+w61zPwNMdrxkFfuCY2LI5s/q3C4TMvFIDh6CWgaSOR1XIlPiJaW7dxtviyDNo2SdMQpEN5HsENwFjUNq3UfEyydOGPI02jiJuLefktEttlEusMIQnE/rDavs+2tA8LSn1nl/L0S1H05aWuUWYbIncOHJf5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFWobxtbuiBAB0Q2lpP7PJ7ovHS+w/iBhsRBBlSCFZ4=;
 b=ecPHwvidNAyBwC5+DWNRJ+y+PLLHX+ylN8oAdfM6jfolA0Es7GVqCCJoa+LDyqeQDNgSPeJV0qXwpo6n5aDmwOZsV9rxVrEYMiy7To4hA02R6AG48IXzq8RabxBPoc7GmaJiT9ctBKAM0N3x78rgbpa6Lh0gC3dCILVSZnhU3HE=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5741.eurprd04.prod.outlook.com (20.178.125.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 09:21:44 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57%5]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 09:21:44 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAADlKDXAABAwMAAAokcIQAANYbIAAAMUC8AAALu0AAAAZKvA=
Date:   Thu, 13 Feb 2020 09:21:44 +0000
Message-ID: <VI1PR04MB4333C0B4809EDE783CBF2025F31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213084819.jveurrsvtv72ssug@vireshk-i7>
 <VI1PR04MB4333FD2725CA091989CAC979F31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213091536.bwxyuwjzga4uogeb@vireshk-i7>
In-Reply-To: <20200213091536.bwxyuwjzga4uogeb@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7de9180-859d-4817-a757-08d7b0662478
x-ms-traffictypediagnostic: VI1PR04MB5741:
x-microsoft-antispam-prvs: <VI1PR04MB57410F4711DB8F512315EE1CF31A0@VI1PR04MB5741.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(2906002)(7696005)(44832011)(86362001)(71200400001)(26005)(186003)(45080400002)(316002)(33656002)(6916009)(966005)(55016002)(53546011)(6506007)(9686003)(54906003)(81156014)(81166006)(8676002)(5660300002)(8936002)(478600001)(76116006)(52536014)(4326008)(66946007)(66446008)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5741;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhiBmGT9SeVfpk5mbwiZB+0a7z+KnyZsPGKqlgBfjsBdYoXzHY2gyOnXF8ZX+icDyzRxNX50lF/xufABafpv9otFOK8TJDjrTdqL6VvNKHxyDqT9mImTKarNDLKZdbYmI4YdckmnKfTkYq5ZTP44yOM87YG7pOMEhXLaZ/4fOHGR1KoU4jkzHk2+mjSRdQltekD7SZ6FwbNlfW7l+fKAMsIs0Y/klTen2J7vktvsk/sB4qQ92WLvTilmMsvpuJ+bXnG9l03vZC8ZMBkgaPBN60DdEmfAuef+XIRuqsGKDq3VOjRuRa0nLLtI9A8PjAqG9z16HsQ537jVqgRSWhUYEMxsgxqSpCx1yFwYlMN0+FjWGwKglXeZOLnOXCOx/cdNhxcvaxgrXDMFoOLFqo1HD02y4t2hIOVo+EpK8ViN1T/ouiPJ7yxiUUNZs3lchYHYQvzxLseZqlYry+kCw8d3qaq3KhCDpJ+p6sWXzTfG3cq6JNKV7wsJNoeMlmunHYbs8pg7sMHWnMXQt0YLS8d7LtvXJoaUig91I+n2kSa3sXNiN8H91JSimlInKzdMpICPAf0zMVkQntykW8onN2DIGt0Yj6Roz9gjaNI/rrQjORB4RTsUlP0zN9s2df24mc0b
x-ms-exchange-antispam-messagedata: YsZP3qVwJPwt33UHTb6X8e6eWAHFGHqqAzrUWUeDZ23+oHpyOay1rDRRrf+3K0ZcbENcJkZeODQW5+r6hTxMMZNppDLHHfCTiMrXDpLRE9hQBmc63FRGssqIdmhbeyZUvkKC8luOAyzHdZJlnCmRxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7de9180-859d-4817-a757-08d7b0662478
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:21:44.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGt3n86YcuPvQ7kQ5k2mVtAko06y1Qi+k8/nypa+bx8JQvsbuEJ/rlAyZwt1OWXH8Tq4AMGDchcWsKMl4BOGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5741
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QXBwcmVjaWF0ZSB5b3VyIGhlbHAuDQoNClRoYW5rcywNCkFuZHkNCg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc+DQo+IFNlbnQ6IDIwMjDlubQy5pyIMTPml6UgMTc6MTYNCj4gVG86IEFuZHkgVGFuZyA8
YW5keS50YW5nQG54cC5jb20+DQo+IENjOiByandAcmp3eXNvY2tpLm5ldDsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogQXNrIGZvciBoZWxwIGFib3V0
IGNwdWZyZXEgaXNzdWUNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMTMtMDIt
MjAsIDA5OjEyLCBBbmR5IFRhbmcgd3JvdGU6DQo+ID4gSGkgVmlyZXNoLA0KPiA+DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVmlyZXNoIEt1bWFyIDx2aXJl
c2gua3VtYXJAbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjDlubQy5pyIMTPml6UgMTY6NDgN
Cj4gPiA+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IHJqd0By
and5c29ja2kubmV0OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJl
OiBbRVhUXSBSZTogQXNrIGZvciBoZWxwIGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gPiA+DQo+ID4g
PiBJIGFncmVlLiBXaGljaCBtZWFucyB0aGF0IHRoZXJlIGFyZSBzb21lIHNwaWtlcyBvZiB3b3Jr
IGdldHRpbmcNCj4gPiA+IHNjaGVkdWxlZCBvbiBDUFVzLiBUaGUgbG9hZCB3aWxsIGluY3JlYXNl
IHNsb3dseSBhbmQgd2lsbCBhbHNvDQo+ID4gPiBkZWNyZWFzZSBzbG93bHkNCj4gPiA+IChzdGVw
LWJ5LXN0ZXApIHdpdGggY29uc2VydmF0aXZlIGdvdmVybm9yLg0KPiA+ID4NCj4gPiA+ID4gU28g
SSBjYW4ndCB1bmRlcnN0YW5kIHdoeSBjcHUgZnJlcXVlbmN5IGluY3JlYXNlZD8NCj4gPiA+DQo+
ID4gPiBUcmFjaW5nIG9yIGRlYnVnZ2luZyBjc19kYnNfdXBkYXRlKCkgaW4gY29uc2VydmF0aXZl
IGdvdmVybm9yIGlzIHRoZQ0KPiA+ID4gb25seSB3YXkgb3V0IEkgd291bGQgc3VnZ2VzdC4NCj4g
PiBXaGF0J3MgdGhlICpUUkFDSU5HIiBoZXJlIHJlZmVycmluZyB0bz8gQ291bGQgeW91IHBsZWFz
ZSBleHBsYWluIG1vcmUNCj4gYWJvdXQgaXQ/DQo+ID4gSSBoYXZlIG5vIGlkZWEgd2hhdCBpdCBp
cy4NCj4gDQo+IFNvcnJ5IGFib3V0IHRoYXQsIEkgd2FzIHRhbGtpbmcgYWJvdXQgdGhlIGluLWtl
cm5lbCBmdW5jdGlvbiB0cmFjZXIgaGVyZS4NCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy4NCj4ga2VybmVs
Lm9yZyUyRmRvYyUyRkRvY3VtZW50YXRpb24lMkZ0cmFjZSUyRmZ0cmFjZS50eHQmYW1wO2RhdGE9
MDIlDQo+IDdDMDElN0NhbmR5LnRhbmclNDBueHAuY29tJTdDZTlkMjE3ZTFlNDkzNDI2ZmY4YTcw
OGQ3YjA2NTRjNzclDQo+IDdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzNzE3MTgyMTQyNzQxNDIyDQo+IDEmYW1wO3NkYXRhPUhYVEFTVkhMZXd3alpoWDNXOWRu
YTl3RDg3YXJFZ0s5NXNuUVA3VU5aZ2MlM0QNCj4gJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiAtLQ0K
PiB2aXJlc2gNCg==
