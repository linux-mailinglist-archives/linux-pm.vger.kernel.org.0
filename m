Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3B126DBC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLSTLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 14:11:52 -0500
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:59238
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728211AbfLSTLw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 14:11:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwusQuC31a/9HmfpEV+ivW2IkMrjl5YmoeSofZP0ZE0Nh0tkKMZZKOum1by4l8700eCb1TOeV0FlvxarOZVZ8KRbJWsaUzzOYAWOiwWYY//8fyZQp85qwuy8FpXcuPfPGlRdtfdnckAXBaeZBL1VdwFrCzncHq6lrj9DYnxc13e1fEbfybUFEb1Us1y7KPcOjIw+NtzIz+rt7PmckHKpDLiQahEfdNtDvwxlaE/93H355OFjIHOWe1X43tDa0zqGH+wuDH8rFBxh1G6Ivb+Cczr0ZaMMPs8Ya2KHKmOLaRo6LAtLkDE+0EH8XBMWAnpnOcaD4bUg4W1oKcu1F3LhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YLb7TG0POc/NSB9dSF/pA/pQH8JFA6PTP1/pOKUg0Y=;
 b=a36/ZTtyN1lL/yRRQMOkRf+kNyjAerkYEwSbIj384VFKGGUicq9Vi6Xu8W2BufDl+yiSwDx4IiH6XeU/QjR61/6G6MQmrhreY5ZGTLaqEaxKaKXno2ISSLObZ6J6gaSLL4poZa7Rb50OrfHHYQVKRaodUXe+1BMHJKDnH3V49ZM+IL/nfK//PcpcEVrBlvVrkRbJy6fQT/j9fZsWZlxXkoh8KlwlxZ4mz/vnMVCzvIsLKFDGbdOB0gaQGmVeqjpwHRoZ8ToDhubfg/YZKGpVaNW+xscdA6cNYUf2Z3dbcU1qy/EtU1FPkd0mwmGfWcVKGpwJzXn2wf659VDz9imLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YLb7TG0POc/NSB9dSF/pA/pQH8JFA6PTP1/pOKUg0Y=;
 b=MGGJIuj8dZVsDVHr7fKJ7rmiRSscVI09hmMU1LEDQOKAfzg5xHmwpktYZc6PN8D4smVbaB3V/ODpoCKQxTgS8G4q2zlkp5Z8v57eJELWPAZflUOLF0lgzJPSfInr6yCZzbn6s1vIjG8PUtpuuT6m3O99McCVYTa8pXMEGxU3BhM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4927.eurprd04.prod.outlook.com (20.177.50.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 19:11:45 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 19:11:45 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <chanwoo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Topic: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Index: AQHVmyeXQvJfRqjmjUWtYoVDBCNHfg==
Date:   Thu, 19 Dec 2019 19:11:45 +0000
Message-ID: <VI1PR04MB7023B70F8F16EF50AB90A0A1EE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
 <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
 <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com>
 <afd618d6-d78c-a989-2d1e-60c368ec267f@samsung.com>
 <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <b8fc116f-d99f-37c6-ce07-aa0f844ac604@samsung.com>
 <VI1PR04MB7023423D8D5D633074978430EE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGTfZH3epdWS_4kezHbvqmZPuUUbRs_7YGeofhB7yAL2tkh59g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c45e79ff-62b7-40b2-6bd3-08d784b74a0d
x-ms-traffictypediagnostic: VI1PR04MB4927:|VI1PR04MB4927:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4927F292DEC54F0459743E0BEE520@VI1PR04MB4927.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(51444003)(316002)(2906002)(52536014)(45080400002)(55016002)(33656002)(9686003)(81156014)(8676002)(966005)(71200400001)(4326008)(81166006)(478600001)(54906003)(30864003)(7696005)(186003)(5660300002)(7416002)(26005)(44832011)(110136005)(76116006)(66946007)(91956017)(6506007)(53546011)(86362001)(64756008)(66446008)(66556008)(8936002)(66476007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4927;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20v6X47cu+cxjOvfmgDEi017Ie+h8h2CoAR1bBEPA/g52cG0k4cdR82L4TEe8KPzknd6cEOgELobGQIVvkMYG23a1oxdtokoSAvAUZpGJY43GPDdV1ZZG7EtWOL4nfuu1eVkG2mVBT3ZDf0nI2HvV2yE4K5rNe8iGQ4Cn+P2Vmxuo5jf+sZ7WTVZIE2QoJzhjOHNBgp0lwS7qC55A8tVSwoqeTBuGRqP8Dfl0CfJ9++WJ9dcuZSIMUNcMX0RPzv/gH9StJJF0kknHm6BR2S05zB15PYjRUN1oxh0QEgiZbv+FbCpzYzk9YsuGIL9mqrEHPl80k/rg1G1VwYpQvTuyXPBclslTiVS4l/GJ7MJzfA0zlEhzNtCQCKBTjJoalXCki0kSWCoXdXwtw3lweuXV8b4sLl52qjLLnXxr3OXLmYLH/JwafhMDJvLScVuZostC710B8QALYicgq1d+OULhWsGXdi0SvH5zNLgifu25wnuI1Dk+YdGxLau/Nrvvbld0yvPDXg7Xw465EebYPiqpMeTjvC25FYTY6k3Lb0QLfLuzRc7SBGoqV4OhoTydiE9
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45e79ff-62b7-40b2-6bd3-08d784b74a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 19:11:45.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRVHYmPYeI7cgu10ut4nlgSLBPqIXwxIy0TGZkhQfahzQ4PhPKtYdZOHM44Cph+IxMu11/cFL7d6xVXWs0yiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4927
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTkuMTIuMjAxOSAxNzo1NiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IDIwMTmz4iAxMr/5IDE5
wM8gKLjxKSC/wMjEIDExOjMzLCBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPrTUwMwgwNu8ujoKPj4KPj4gT24gMTcuMTIuMjAxOSAwMjowOCwgQ2hhbndvbyBDaG9pIHdy
b3RlOgo+Pj4gT24gMTIvMTcvMTkgMTI6MDkgQU0sIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4+
PiBPbiAxNi4xMi4yMDE5IDA1OjE4LCBDaGFud29vIENob2kgd3JvdGU6Cj4+Pj4+IEhpLAo+Pj4+
Pgo+Pj4+PiBPbiAxMi8xNi8xOSAxMDoxMiBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+Pj4+Pj4g
T24gMTEvMTUvMTkgNTowOSBBTSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+Pj4+IEFkZCBp
bml0aWFsIGR0IGJpbmRpbmdzIGZvciB0aGUgaW50ZXJjb25uZWN0cyBpbnNpZGUgaS5NWCBjaGlw
cy4KPj4+Pj4+PiBNdWx0aXBsZSBleHRlcm5hbCBJUHMgYXJlIGludm9sdmVkIGJ1dCBTT0MgaW50
ZWdyYXRpb24gbWVhbnMgdGhlCj4+Pj4+Pj4gc29mdHdhcmUgY29udHJvbGxhYmxlIGludGVyZmFj
ZXMgYXJlIHZlcnkgc2ltaWxhci4KPj4+Pj4+Pgo+Pj4+Pj4+IE1haW4gTk9DIG5vZGUgYWN0cyBh
cyBpbnRlcmNvbm5lY3QgcHJvdmlkZXIgaWYgI2ludGVyY29ubmVjdC1jZWxscyBpcwo+Pj4+Pj4+
IHByZXNlbnQuCj4+Pj4+Pj4KPj4+Pj4+PiBNdWx0aXBsZSBpbnRlcmNvbm5lY3RzIGNhbiBiZSBw
cmVzZW50LCBlYWNoIHdpdGggdGhlaXIgb3duIE9QUCB0YWJsZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+
Pj4+Pj4gLS0tCj4+Pj4+Pj4gICAgIC4uLi9iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDht
LW5vYy55YW1sICB8IDEwNCArKysrKysrKysrKysrKysrKysKPj4+Pj4+PiAgICAgMSBmaWxlIGNo
YW5nZWQsIDEwNCBpbnNlcnRpb25zKCspCj4+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bS1u
b2MueWFtbAo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDhtLW5vYy55YW1sIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVyY29ubmVjdC9mc2wsaW14OG0tbm9jLnlhbWwK
Pj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
NWNkOTQxODVmZWMzCj4+Pj4+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4+Pj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDhtLW5vYy55YW1s
Cj4+Pj4+Pj4gQEAgLTAsMCArMSwxMDQgQEAKPj4+Pj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMAo+Pj4+Pj4+ICslWUFNTCAxLjIKPj4+Pj4+PiArLS0tCj4+Pj4+Pj4gKyRp
ZDogaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGcHJvdGVjdDIuZmlyZWV5ZS5jb20lMkZ1cmwlM0ZrJTNEODU3MGViNWEtZDhh
NDU3MzItODU3MTYwMTUtMGNjNDdhMzM1NmIyLTkyYTViOTJjYzUxNGQwN2UlMjZ1JTNEaHR0cHMl
M0ElMkYlMkZldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbSUyRiUzRnVybCUz
RGh0dHBzJTI1M0ElMjUyRiUyNTJGcHJvdGVjdDIuZmlyZWV5ZS5jb20lMjUyRnVybCUyNTNGayUy
NTNEMGMxM2YzZTAtNTFkZjNmNDUtMGMxMjc4YWYtMGNjNDdhMzBkNDQ2LTc3ZTgwOTU0M2I2NzNm
ZmQlMjUyNnUlMjUzRGh0dHAlMjUzQSUyNTJGJTI1MkZkZXZpY2V0cmVlLm9yZyUyNTJGc2NoZW1h
cyUyNTJGaW50ZXJjb25uZWN0JTI1MkZmc2wlMjUyQ2lteDhtLW5vYy55YW1sJTI1MjMlMjZhbXAl
M0JkYXRhJTNEMDIlMjU3QzAxJTI1N0NsZW9uYXJkLmNyZXN0ZXolMjU0MG54cC5jb20lMjU3QzJk
MWYxODY4YWZhMTQwNzAyYTZiMDhkNzgxZDZhYjY4JTI1N0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSUyNTdDMCUyNTdDMCUyNTdDNjM3MTIwNjMxMzA3NDE4NTQ0JTI2YW1wJTNCc2Rh
dGElM0RIMnE1blFsS1l5TElpdmtCWVVUYVJEMU51M1djbnBoUEpueTNrJTI1MkJLJTI1MkJHRkUl
MjUzRCUyNmFtcCUzQnJlc2VydmVkJTNEMCZhbXA7ZGF0YT0wMiU3QzAxJTdDbGVvbmFyZC5jcmVz
dGV6JTQwbnhwLmNvbSU3QzQwNDA2YmZkMGYxMzRlZWRkYjMyMDhkNzg0OWMwOTY4JTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzEyMzY3ODAyMjUxMjYyMyZh
bXA7c2RhdGE9SVlTWWxOdEEwZllLTGtUcjRPanlIa0thNkZBaTJtOFVGcjRuWFo5cHI3cyUzRCZh
bXA7cmVzZXJ2ZWQ9MAo+Pj4+Pj4+ICskc2NoZW1hOiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwcm90ZWN0Mi5maXJlZXll
LmNvbSUyRnVybCUzRmslM0RmN2NlYzQ4My1hYTFhNzhlYi1mN2NmNGZjYy0wY2M0N2EzMzU2YjIt
NDE1NGEzYzQzODg2ZjVlZCUyNnUlM0RodHRwcyUzQSUyRiUyRmV1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tJTJGJTNGdXJsJTNEaHR0cHMlMjUzQSUyNTJGJTI1MkZwcm90ZWN0
Mi5maXJlZXllLmNvbSUyNTJGdXJsJTI1M0ZrJTI1M0Q4N2M2NzJkYy1kYTBhYmU3OS04N2M3Zjk5
My0wY2M0N2EzMGQ0NDYtNDE0ZDNiNGQwMTI3NDE5YSUyNTI2dSUyNTNEaHR0cCUyNTNBJTI1MkYl
MjUyRmRldmljZXRyZWUub3JnJTI1MkZtZXRhLXNjaGVtYXMlMjUyRmNvcmUueWFtbCUyNTIzJTI2
YW1wJTNCZGF0YSUzRDAyJTI1N0MwMSUyNTdDbGVvbmFyZC5jcmVzdGV6JTI1NDBueHAuY29tJTI1
N0MyZDFmMTg2OGFmYTE0MDcwMmE2YjA4ZDc4MWQ2YWI2OCUyNTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlMjU3QzAlMjU3QzAlMjU3QzYzNzEyMDYzMTMwNzQxODU0NCUyNmFtcCUz
QnNkYXRhJTNEVDZQZ1ExRFdJNE9MT3gzZ2lmUlJ0JTI1MkZOSW1kVnJnRFVvc3daJTI1MkZOS3cz
b1I4JTI1M0QlMjZhbXAlM0JyZXNlcnZlZCUzRDAmYW1wO2RhdGE9MDIlN0MwMSU3Q2xlb25hcmQu
Y3Jlc3RleiU0MG54cC5jb20lN0M0MDQwNmJmZDBmMTM0ZWVkZGIzMjA4ZDc4NDljMDk2OCU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxMjM2NzgwMjI1MTI2
MjMmYW1wO3NkYXRhPW5yYlBHcGdCY2k1RERtNnFSUk9lRmE3OGhBUlI5VUNYZVA1OVRuUHRDdUkl
M0QmYW1wO3Jlc2VydmVkPTAKPj4+Pj4+PiArCj4+Pj4+Pj4gK3RpdGxlOiBHZW5lcmljIGkuTVgg
YnVzIGZyZXF1ZW5jeSBkZXZpY2UKPj4+Pj4+PiArCj4+Pj4+Pj4gK21haW50YWluZXJzOgo+Pj4+
Pj4+ICsgIC0gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPj4+Pj4+
PiArCj4+Pj4+Pj4gK2Rlc2NyaXB0aW9uOiB8Cj4+Pj4+Pj4gKyAgVGhlIGkuTVggU29DIGZhbWls
eSBoYXMgbXVsdGlwbGUgYnVzZXMgZm9yIHdoaWNoIGNsb2NrIGZyZXF1ZW5jeSAoYW5kCj4+Pj4+
Pj4gKyAgc29tZXRpbWVzIHZvbHRhZ2UpIGNhbiBiZSBhZGp1c3RlZC4KPj4+Pj4+PiArCj4+Pj4+
Pj4gKyAgU29tZSBvZiB0aG9zZSBidXNlcyBleHBvc2UgcmVnaXN0ZXIgYXJlYXMgbWVudGlvbmVk
IGluIHRoZSBtZW1vcnkgbWFwcyBhcyBHUFYKPj4+Pj4+PiArICAoIkdsb2JhbCBQcm9ncmFtbWVy
cyBWaWV3IikgYnV0IG5vdCBhbGwuIEFjY2VzcyB0byB0aGlzIGFyZWEgbWlnaHQgYmUgZGVuaWVk
Cj4+Pj4+Pj4gKyAgZm9yIG5vcm1hbCAobm9uLXNlY3VyZSkgd29ybGQuCj4+Pj4+Pj4gKwo+Pj4+
Pj4+ICsgIFRoZSBidXNlcyBhcmUgYmFzZWQgb24gZXh0ZXJuYWxseSBsaWNlbnNlZCBJUHMgc3Vj
aCBhcyBBUk0gTklDLTMwMSBhbmQKPj4+Pj4+PiArICBBcnRlcmlzIEZsZXhOT0MgYnV0IERUIGJp
bmRpbmdzIGFyZSBzcGVjaWZpYyB0byB0aGUgaW50ZWdyYXRpb24gb2YgdGhlc2UgYnVzCj4+Pj4+
Pj4gKyAgaW50ZXJjb25uZWN0IElQcyBpbnRvIGlteCBTT0NzLgo+Pj4+Pj4+ICsKPj4+Pj4+PiAr
cHJvcGVydGllczoKPj4+Pj4+PiArICBjb21wYXRpYmxlOgo+Pj4+Pj4+ICsgICAgb25lT2Y6Cj4+
Pj4+Pj4gKyAgICAgIC0gaXRlbXM6Cj4+Pj4+Pj4gKyAgICAgICAgLSBlbnVtOgo+Pj4+Pj4+ICsg
ICAgICAgICAgLSBmc2wsaW14OG1uLW5pYwo+Pj4+Pj4+ICsgICAgICAgICAgLSBmc2wsaW14OG1t
LW5pYwo+Pj4+Pj4+ICsgICAgICAgICAgLSBmc2wsaW14OG1xLW5pYwo+Pj4+Pj4+ICsgICAgICAg
IC0gY29uc3Q6IGZzbCxpbXg4bS1uaWMKPj4+Pj4+PiArICAgICAgLSBpdGVtczoKPj4+Pj4+PiAr
ICAgICAgICAtIGVudW06Cj4+Pj4+Pj4gKyAgICAgICAgICAtIGZzbCxpbXg4bW4tbm9jCj4+Pj4+
Pj4gKyAgICAgICAgICAtIGZzbCxpbXg4bW0tbm9jCj4+Pj4+Pj4gKyAgICAgICAgICAtIGZzbCxp
bXg4bXEtbm9jCj4+Pj4+Pj4gKyAgICAgICAgLSBjb25zdDogZnNsLGlteDhtLW5vYwo+Pj4+Pj4+
ICsKPj4+Pj4+PiArICByZWc6Cj4+Pj4+Pj4gKyAgICBtYXhJdGVtczogMQo+Pj4+Pj4+ICsKPj4+
Pj4+PiArICBjbG9ja3M6Cj4+Pj4+Pj4gKyAgICBtYXhJdGVtczogMQo+Pj4+Pj4+ICsKPj4+Pj4+
PiArICBvcGVyYXRpbmctcG9pbnRzLXYyOiB0cnVlCj4+Pj4+Pj4gKyAgb3BwLXRhYmxlOiB0cnVl
Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsgIGRldmZyZXE6Cj4+Pj4+Pj4gKyAgICAkcmVmOiAiL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSIKPj4+Pj4+PiArICAgIGRlc2NyaXB0
aW9uOgo+Pj4+Pj4+ICsgICAgICBQaGFuZGxlIHRvIGFub3RoZXIgZGV2ZnJlcSBkZXZpY2UgdG8g
bWF0Y2ggT1BQcyB3aXRoIGJ5IHVzaW5nIHRoZQo+Pj4+Pj4KPj4+Pj4+IEJldHRlciB0byB1c2Ug
J3BhcmVudCcgaW5zdGVhZCBvZiAnYW5vdGhlcicgd29yZCBmb3IgaW1wcm92aW5nIHRoZSB1bmRl
cnN0YW5kaW5nLgo+Pj4+Pgo+Pj4+PiBJIHRoaW5rIHRoYXQgJ2RldmZyZXEnIGlzIG5vdCBwcm9w
ZXIgd2F5IHRvIGdldCB0aGUgcGFyZW50IG5vZGUKPj4+Pj4gaW4gZGV2aWNldHJlZS4gQmVjYXVz
ZSAnZGV2ZnJlcScgbmFtZSBpcyBsaW51eGl1bS4gVGhlIHByb3BlcnR5IG5hbWUKPj4+Pj4gZGlk
bid0IGluZGljYXRlIHRoZSBhbnkgaC93IGRldmljZS4gU28sIEknbGwgbWFrZSAnZGV2ZnJlcScg
cHJvcGVydHkgZGVwcmVjYXRlZC4KPj4+Pj4KPj4+Pj4gU28sIHlvdSBiZXR0ZXIgdG8gbWFrZSB0
aGUgc3BlY2lmaWMgcHJvcGVydHkgZm9yIHRoaXMgZGV2aWNlIGRyaXZlcgo+Pj4+PiBsaWtlIGFz
IGZvbGxvd2luZzogYW5kIHVzZSBkZXZmcmVxX2dldF9kZXZmcmVxX2J5X25vZGUoKSBmdW5jdGlv
bgo+Pj4+PiB3aGljaCBpcyBkZXZlbG9wZWQgYnkgeW91IGluIG9yZGVyIHRvIGdldCB0aGUgZGV2
ZnJlcSBpbnN0YW5jZSBub2RlLgo+Pj4+Pgo+Pj4+PiAgICAgIGZzbCxwYXJlbnQtZGV2aWNlID0g
PCZwYXJlbnQgZGV2ZnJlcSBkZXZpY2U+Owo+Pj4+Cj4+Pj4gVGhpcyBpcyBvbmx5IGEgInBhcmVu
dCIgaW4gdGhlIHNlbnNlIHRoYXQgaXQncyBhc3NpZ25lZCB0bwo+Pj4+IGRldmZyZXFfcGFzc2l2
ZS5kYXRhLnBhcmVudC4gVGhlICJkZXZmcmVxIiBuYW1lIGlzIGluZGVlZCB0b28gZ2VuZXJpYy4K
Pj4+Cj4+PiBJIHRob3VnaHQgdGhhdCAnZGV2ZnJlcScgcHJvcGVydHkgbmFtZSBpcyBnZW5lcmlj
Lgo+Pj4gQnV0LCBpdCdzIG5vdCBwcm9wZXIgZm9yIERUIGJpbmRpbmcgYmVjYXVzZSBEVCBmaWxl
IHNob3cKPj4+IHRoZSBoL3cgYW5kIHRoZSByZWxhdGlvbiBvZiBoL3cuICdkZXZmcmVxJyBwcm9w
ZXJ0eSBuYW1lCj4+PiBoYXMgbm90IG1lYW50IGgvdy4KPj4+Cj4+PiBTbyB0aGF0IGRldmZyZXEg
Y29yZSBkb2Vzbid0IGZvcmNlIHRvIHVzZSB0aGUgc3BlY2lmaWMgcHJvcGVydHkKPj4+IG5hbWUg
dG8gZ2V0IHRoZSBkZXZmcmVxIHBhcmVudCBpbnN0YW5jZSBvbiBEVC4gSnVzdCwgZGV2ZnJlcSBj
b3JlCj4+PiB3aWxsIHByb3ZpZGUgZGV2ZnJlcV9nZXRfZGV2ZnJlcV9ieV9ub2RlKCkgZnVuY3Rp
b24uCj4+Pgo+Pj4gSSBkZXZlbG9wZWQgaXQgb24gZGV2ZnJlLXRlc3RpbmcgYnJhbmNoWzJdLiBC
ZWZvcmUgSSdtIHNlbmRpbmcKPj4+IHRoZSB0aGVzZSBwYXRjaGVzLCB5b3UgY2FuIGNoZWNrIHRo
ZW0uCj4+Pgo+Pj4gWzFdIGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJGbGlu
dXglMkZrZXJuZWwlMkZnaXQlMkZjaGFud29vJTJGbGludXguZ2l0JTJGY29tbWl0JTJGJTNGaCUz
RGRldmZyZXEtdGVzdGluZyUyNmlkJTNEZjM2NzhiNGU2Yjc1ZGNjZmU4YmI4N2QwMDVkYTJkNjhj
NzBmZGVhYiZhbXA7ZGF0YT0wMiU3QzAxJTdDbGVvbmFyZC5jcmVzdGV6JTQwbnhwLmNvbSU3QzQw
NDA2YmZkMGYxMzRlZWRkYjMyMDhkNzg0OWMwOTY4JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzEyMzY3ODAyMjUxMjYyMyZhbXA7c2RhdGE9QWhNTXg4TVpC
N0hJdllhQ2hXRmRTdTlKTUZHUEh5eiUyQjhXJTJGazdwZXZvZlklM0QmYW1wO3Jlc2VydmVkPTAK
Pj4+IFsyXSBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZnaXQua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2Vy
bmVsJTJGZ2l0JTJGY2hhbndvbyUyRmxpbnV4LmdpdCUyRmxvZyUyRiUzRmglM0RkZXZmcmVxLXRl
c3RpbmcmYW1wO2RhdGE9MDIlN0MwMSU3Q2xlb25hcmQuY3Jlc3RleiU0MG54cC5jb20lN0M0MDQw
NmJmZDBmMTM0ZWVkZGIzMjA4ZDc4NDljMDk2OCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVj
MzAxNjM1JTdDMCU3QzAlN0M2MzcxMjM2NzgwMjI1MjI2MTUmYW1wO3NkYXRhPTI5RlAxSGU3UFQl
MkIyTmRZZXlCSWpBazJyZXFDZU9tTTVhSmduWG90RlF6SSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Pj4K
Pj4+Pgo+Pj4+IFRoZSBERFJDIGNhbiBtZWFzdXJlIGJhbmR3aXRoIHVzYWdlIGFuZCBJIHdhbnQg
dG8gdXNlIHRoZSBwYXNzaXZlCj4+Pj4gZ292ZXJub3IgdG8gbWFrZSB0aGUgbWFpbiBOT0MgbWF0
Y2ggT1BQcy4KPj4+Cj4+PiB3aGljaCBvbmUgdXNlIHRoZSBwYXNzaXZlIGdvdmVybm9yPyBBbmQg
d2hpY2ggb25lIGlzIHRoZSBwYXJlbnQKPj4+IGRldmZyZXEgZGV2aWNlIGZvciBkZXZmcmVxIGRl
dmljZSB1c2luZyBwYXNzaXZlIGdvdmVybm9yPwo+Pj4KPj4+IEluIG15IGNhc2UsIGl0IGlzIGRp
ZmZpY3VsdCB0byBjYXRjaCB0aGUgcmVsYXRpb25zaGlwCj4+PiBiZXR3ZWVuIGRldmljZXMuIEkn
ZCBsaWtlIHlvdSB0byBleHBsYWluIHRoZSBkZXRhaWxlZCByZWxhdGlvbnNoaXAKPj4+IG9uIGJp
bmRpbmcgZG9jdW1lbnQgZm9yIHVzZXIuCj4+Pgo+Pj4+IEJ1dCBhdCB0aGUgYnVzIGxldmVsIERE
UkMgb25seSBoYXMgQVhJIGFuZCBBUEIgc2xhdmUgcG9ydHMuCj4+Pgo+Pj4gJ0REUkMnIGluZGlj
YXRlcyB0aGUgJ2RyaXZlcnMvZGV2ZnJlcS9pbXg4bS1kZHJjLmM/Cj4+Pgo+Pj4+Cj4+Pj4gQnVz
ZXMgb24gaW14IGRvbid0IGhhdmUgYSBwYXJlbnQvY2hpbGQgcmVsYXRpb25zaGlwOyBpbiBmYWN0
IHRoZXJlIGFyZQo+Pj4+IGV2ZW4gYSBmZXcgY3ljbGVzLgo+Pj4KPj4+IFlvdSBtZW50aW9uZWQg
dGhhdCAnaW14IGRvbid0IGhhdmUgYSBwYXJlbnQvY2hpbGQgcmVsYXRpb25zaGlwJywKPj4+IFdo
eSBkbyB5b3UgdXNlICdwYXNzaXZlJyBnb3Zlcm5vcj8gSXQgaXMgZGlmZmljdWx0IHRvIHVuZGVy
c3RhbmQKPj4+IHRoZSBoaWVyYXJjaHkgb2YgaW14Lgo+Pgo+PiBUaGUgaW14OG0gaGFzIGEgbWFp
biBOT0MgaW4gdGhlIGNlbnRlciBiZXR3ZWVuIHRoZSBDUFUgYW5kIHRoZSBERFJDCj4+IChkcmFt
IGNvbnRyb2xsZXIpIHdpdGggbWFueSBvdGhlciBwZXJpcGhlcmFsIGJ1c2VzIGFyb3VuZCB0aGUg
Tk9DLgo+IAo+IEFjdHVhbGx5LCBpZiB0aGlzIGR0IGJpbmRpbmcgZG9jdW1lbnQgY29udGFpbnMg
dGhlIHJlbGF0aW9uc2hpcAo+IGJldHdlZW4gZGRyYyhpbXg4bS1kZHJjLmMpCj4gLCBpbXgtYnVz
LmMoYnVzKSBhbmQgaW50ZXJjb25uZWN0IG5vZGUsIGl0IGlzIG1vcmUgZWFzeSB0byB1bmRlcnN0
YW5kCj4gdGhlIGhpZXJhcmNoeQo+IG9mIGJ1cy9kZHJjLiBJbiBteSBjYXNlLCBpdCBpcyBkaWZm
aWN1bHQgYmVjYXVzZSB0aGUgYmluZGluZyBkb2N1bWVudCBkb2Vzbid0Cj4gaW5jbHVkZSB0aGUg
ZW5vdWdoIGV4YW1wbGUuIEJ1dCwgSSdsbCBleHBlY3QgdGhlbSBhcyB5b3UgbWVudGlvbmVkIG9u
Cj4geW91ciByZXBseS4KPiAKPj4KPj4gSGVyZSdzIC9zeXMva2VybmVsL2RlYnVnL2ludGVyY29u
bmVjdC9pbnRlcmNvbm5lY3RfZ3JhcGggb24gaW14OG1tOgo+PiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXN0LmdpdGh1
Yi5jb20lMkZjZGxlb25hcmQlMkY4NGQxMDNkYWZjOTEzMWZjYjhjYTlhNDk0ODIyYTEzMSUyM2Zp
bGUtaW14OG1tLXN2ZyZhbXA7ZGF0YT0wMiU3QzAxJTdDbGVvbmFyZC5jcmVzdGV6JTQwbnhwLmNv
bSU3QzQwNDA2YmZkMGYxMzRlZWRkYjMyMDhkNzg0OWMwOTY4JTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzEyMzY3ODAyMjUyMjYxNSZhbXA7c2RhdGE9YW5B
UEs3Q3BqZFJ0RTdTJTJGUlBvMFRZMDhPZ0MyRVdtdUhrNThuQmZaMW9nJTNEJmFtcDtyZXNlcnZl
ZD0wCj4gCj4gSXQgaXMgdGhlIGludGVyY29ubmVjdCBub2RlIGdyYXBoLiBJIGhvcGUgdG8ga25v
dyB0aGUgcmVsYXRpb25zaGlwCj4gd2hlbiBidXMoaW14LWJ1cy5jKQo+IHVzZXMgdGhlICdwYXNz
aXZlIGdvdmVybm9yJyBhbmQgd2hpY2ggaXMgdGhlCj4gCj4+Cj4+IEEgbG90IG9mIHN0dWZmIGlz
IG9taXR0ZWQsIGl0IG1vc3RseSBqdXN0IGluY2x1ZGVzIGhpZ2gtcGVyZm9ybWFuY2UgYnVzCj4+
IG1hc3RlcnMuCj4+Cj4+IEREUkMgaGFzIGEgcGVyZm9ybWFuY2UgbW9uaXRvciBhdHRhY2hlZCB3
aGljaCBjYW4gbWVhc3VyZSBjdXJyZW50Cj4+IGJhbmR3aXRoIGFuZCBmZWVkIGl0IHRvIGFuIG9u
ZGVtYW5kIGdvdmVybm9yLiBJIHdhbnQgdG8gdXNlIHBhc3NpdmUKPj4gZ292ZXJub3Igb24gdGhl
IE5PQyBzbyB0aGF0IGl0IG1hdGNoZXMgZnJlcXVlbmNpZXMgd2l0aCBERFJDIGFuZCBzY2FsZXMK
PiAKPiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMuIElmIHlvdSBleHBsYWluIHRoZSBt
b3JlIGRldGFpbGVkIGRlc2NyaXRwaW9uCj4gYW5kIGFkZCBtdWx0aXBsZSBkdCBiaWRuaW5nIGV4
YW1wbGUsIEknbGwgZXhwZWN0IHRoYXQgSSBjYW4gdW5kZXJzdGFuZAo+IHRoZSBmb2xsb3dpbmcg
bXkgcXVlc3Rpb25zLgo+IC0gV2hpY2ggb25lIHdpbGwgdXNlIHRoZSAncGFzc2l2ZSBnb3Zlcm5v
cic/Cj4gLSBERFJDIGlzIHBhcmVudCBkZXZmcmVxIGRldmljZSBmb3IgaW14IGJ1cyhpbXgtYnVz
LmMpIHVzaW5nIHBhc3NpdmUgZ292ZXJub3I/Cj4gLSBXaHkgaW14IGJ1cyhpbXgtYnVzLmMpIHVz
ZSB0aGUgdXNlcnNwYWNlIGdvdmVybm9yPwo+IC0gV2hpY2ggdGhlIHJlbGF0aW9uc2hpcCBiZXR3
ZWVuIGlteCBidXMoaW14LWJ1cy5jKSB1c2luZyB1c2Vyc3BhY2UKPiBnb3Zlcm5vciBhbmQgaW14
IGJ1cyhpbXgtYnVzLmMpIHVzaW5nIHBhc3NpdmUgZ292ZXJub3I/CgpOT0Mgd291bGQgdXNlIHRo
ZSBwYXNzaXZlIGdvdmVybm9yIHdpdGggZGV2ZnJlcV9wYXNzaXZlX2RhdGEucGFyZW50IHNlbnQg
CnRvIEREUkMgc28gdGhhdCBpdCBtYXRjaGVzIHJhdGVzIHdoZW4gRERSQyB1c2VzIG9uZGVtYW5k
IGdvdmVybm9yLiBUaGlzIAppcyBhIG1pbm9yIGZlYXR1cmUgbWVhbnQgdG8gbWFrZSBvbmRlbWFu
ZCBzY2FsaW5nIGJlaGF2ZSBtb3JlIHVzZWZ1bGx5LCAKb3RoZXJ3aXNlIE5PQyBtaWdodCBiZSBh
IGJvdHRsZW5lY2sgZm9yIHdoZW4gQ1BVIHVzZXMgbG90cyBvZiByYW0gCmJhbmR3aWR0aC4gSXQg
d291bGQgbWFrZSBzZW5zZSB0byBzcGxpdCBpdCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guCgpUaGUg
c2FtZSBpbXgtYnVzIGRyaXZlciBjYW4gYWxzbyBiZSB1c2VkIGZvciBwZXJpcGhlcmFsIGJ1c2Vz
IChmb3IgCmV4YW1wbGUgUEwzMDFfTUlQSSB1c2luZyBpbXg4bS1uaWMgY29tcGF0aWJsZSkgYW5k
IGluIHRoYXQgY2FzZSBpdCB3aWxsIApqdXN0IHVzZSB0aGUgdXNlcnNwYWNlIGdvdmVybm9yIGJ5
IGRlZmF1bHQuCgpVc2VmdWwgc2NhbGluZyBmb3IgdGhlIG1pcGkgYnVzIHdvdWxkIGJlIHBlcmZv
cm1lZCB2aWEgaW50ZXJjb25lbmN0OiB0aGUgCmRpc3BsYXkgY29udHJvbGxlciAoTENESUYpIGNv
dWxkIHJlcXVlc3QgYmFuZHdpZHRoIGFsb25nIGFuIGljY19wYXRoIAp0aGF0IGdvZXM6IExDRElG
LT5QTDMwMV9NSVBJLT5OT0MtPkREUkMgYW5kIHRoZW4gdGhlIGludGVyY29ubmVjdCAKcHJvdmlk
ZXIgd291bGQgYWdncmVnYXRlIHJlcXVlc3RzIGFuZCB0cmFuc2xhdGUgdGhlbSBpbnRvIHNlcGFy
YXRlIAptaW5pbXVtIGZyZXF1ZW5jaWVzIGZvciBQTDMwMV9NSVBJLCBOT0MgYW5kIEREUkMuCgpD
YW1lcmEgZGV2aWNlcyB3b3VsZCBzaGFyZSB0aGlzIHBhdGggd2hpbGUgR1BVIGFuZCBWUFVzIHdv
dWxkIG9ubHkgc2hhcmUgCk5PQyBhbmQgRERSQy4gVGhpcyBkZXRhaWwgaXMgc3BlY2lmaWMgdG8g
OG1tLCBpbnRlcmNvbm5lY3QgZ3JhcGggaXMgCmRpZmZlcmVudCBvbiA4bXEgYW5kIDhtbi4KClRo
ZSAiaW50ZXJjb25uZWN0IiBkcml2ZXIgaXMgdmVyeSBsb29zZWx5IGNvdXBsZWQgdG8gImRldmZy
ZXEiIGRyaXZlcnM6IAppdCBqdXN0IG1ha2VzIFFPU19NSU5fRlJFUVVFTkNZIHJlcXVlc3RzLiBU
aGVyZSBpcyBhbHJlYWR5IGEgZGlzdGluY3QgCmRyaXZlciBmb3IgaW14OG0tZGRyYyBhbmQgaW4g
dGhlb3J5IGZzbCxpbXg4bS1ub2MgYW5kIGZzbCxpbXg4bS1uaWMgCmNvdWxkIGhhdmUgZGlzdGlu
Y3QgZHJpdmVycyBhcyB3ZWxsLiBJdCB3b3VsZCBiZSBwb2ludGxlc3MgYmVjYXVzZSBhbGwgCnRo
ZXkgY3VycmVudGx5IGRvIGlzIHNldCBhIHNpbmdsZSBjbG9jayByYXRlIHNvIHRoZXkncmUgYWxs
IGhhbmRsZWQgYnkgYSAKc2luZ2xlIGlteC1idXMgZHJpdmVyLCBzaW1pbGFyIHRvIGV4eW5vcy1i
dXMuCgpUaGUgaW50ZXJjb25uZWN0IGRyaXZlciBzaGFyZXMgdGhlIGlteDhtLW5vYyBiaW5kaW5n
IHdpdGggaW14LWJ1cyAKYmVjYXVzZSAidmlydHVhbCBub2RlcyIgYXJlIHN0cm9uZ2x5IGRpc2Nv
dXJhZ2VkIGFzIHRoZXkgZG9uJ3QgImRlc2NyaWJlIApoYXJkd2FyZSIuIEVhcmxpZXIgdmVyc2lv
bnMgb2YgdGhlIHNlcmllcyBoYWQgYSB2aXJ0dWFsIG5vZGUuCgo+PiBwcm9wb3J0aW9uYWxseSwg
b3RoZXJ3aXNlIGlmIE5PQyBpcyBhdCBsb3cgZnJlcXVlbmN5IHRoZW4gZHluYW1pY2FsbHkKPj4g
c2NhbGluZyB1cCB0aGUgRERSQyBtaWdodCBiZSBpbmVmZmVjdGl2ZS4KPj4KPj4gUGVyaGFwcyB5
b3UgY291bGQgZXhwbGFpbiBob3cgcGFyZW50L2NoaWxkIHJlbGF0aW9uc2hpcHMgd29yayBvbiBl
eHlub3M/Cj4gCj4gUmlnaHQuIFNvLCBJIHdyb3RlWzFdIHdoeSBleHlub3MtYnVzLmMgaGF2ZSB0
byB1c2UgdGhlIHBhc3NpdmUgZ292ZXJub3IKPiBhbmQgaG93IHRvIG1ha2UgdGhlIGhpZXJhcmNo
eS9yZWxhdGlvbnNoaXAgYmV0d2VlbiBleHlub3MtYnVzKHBhcmVudAo+IGRldmZyZXEgZGV2aWNl
Cj4gdXNpbmcgZGV2ZnJlcSBnb3Zlcm5vciBleGNlcHQgZm9yIHBhc3NpdmUgZ292ZXJub3IpCj4g
YW5kIGV4eW5vcy1idXMgKGNoaWxkIGRldmZyZXEgZGV2aWNlIHVzaW5nIG9ubHkgcGFzc2l2ZSBn
b3Zlcm5vcikuCj4gCj4gWzFdIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kZXZm
cmVxL2V4eW5vcy1idXMudHh0Cj4gCj4+Cj4+Pj4+IFsxXSBbUEFUQ0ggUkZDIHY1IDA0LzEwXSBQ
TSAvIGRldmZyZXE6IEFkZCBkZXZmcmVxX2dldF9kZXZmcmVxX2J5X25vZGUKPj4+Pj4KPj4+Pj4+
Cj4+Pj4+Pj4gKyAgICAgIHBhc3NpdmUgZ292ZXJub3IuCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsgICcj
aW50ZXJjb25uZWN0LWNlbGxzJzoKPj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOgo+Pj4+Pj4+ICsg
ICAgICBJZiBzcGVjaWZpZWQgdGhlbiBhbHNvIGFjdCBhcyBhbiBpbnRlcmNvbm5lY3QgcHJvdmlk
ZXIuIFNob3VsZCBvbmx5IGJlCj4+Pj4+Pj4gKyAgICAgIHNldCBvbmNlIHBlciBzb2Mgb24gbWFp
biBub2MuCj4+Pj4+Pj4gKyAgICBjb25zdDogMQo+Pj4+Pj4+ICsKPj4+Pj4+PiArICBmc2wsc2Nh
bGFibGUtbm9kZS1pZHM6Cj4+Pj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzItYXJyYXkKPj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOgo+Pj4+Pj4+
ICsgICAgICBBcnJheSBvZiBub2RlIGlkcyBmb3Igc2NhbGFibGUgbm9kZXMuIFVzZXMgc2FtZSBu
dW1lcmljIGlkZW50aWZpZXIKPj4+Pj4+PiArICAgICAgbmFtZXNwYWNlIGFzIHRoZSBjb25zdW1l
ciAiaW50ZXJjb25uZWN0cyIgYmluZGluZy4KPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgZnNsLHNjYWxh
YmxlLW5vZGVzOgo+Pj4+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvcGhhbmRsZS1hcnJheQo+Pj4+Pj4+ICsgICAgZGVzY3JpcHRpb246Cj4+Pj4+Pj4gKyAg
ICAgIEFycmF5IG9mIHBoYW5kbGVzIHRvIHNjYWxhYmxlIG5vZGVzLiBNdXN0IGJlIG9mIHNhbWUg
bGVuZ3RoIGFzCj4+Pj4+Pj4gKyAgICAgIGZzbCxzY2FsYWJsZS1ub2RlLWlkcy4KPj4+Pj4+PiAr
Cj4+Pj4+Pj4gK3JlcXVpcmVkOgo+Pj4+Pj4+ICsgIC0gY29tcGF0aWJsZQo+Pj4+Pj4+ICsgIC0g
Y2xvY2tzCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UKPj4+
Pj4+PiArCj4+Pj4+Pj4gK2V4YW1wbGVzOgo+Pj4+Pj4+ICsgIC0gfAo+Pj4+Pj4KPj4+Pj4+IElz
IGl0IGVub3VnaCBleGFtcGxlIHRvIHVuZGVyc3RhbmQgdGhlIHJlbGF0aW9uIGJldHdlZW4KPj4+
Pj4+IGlteDhtLWRkcmMuYywgaW14LWRldmZyZXEuYyBhbmQgaW14IGludGVyY29ubmVjdCBkcml2
ZXI/Cj4+Pj4+Pgo+Pj4+Pj4gSW4gbXkgY2FzZSwgaWYgcG9zc2libGUsIGhvcGUgdG8gc2hvdyB0
aGUgbW9yZSBkZXRhaWxlZAo+Pj4+Pj4gZXhhbXBsZS4gVGhpcyBleGFtcGxlIHNlZW1zIHRoYXQg
ZG9uJ3QgY29udGFpbiB0aGUgZGRyYwo+Pj4+Pj4gZHQgbm9kZSAoaW14OG0tZGRyYy5jKS4KPj4+
Pgo+Pj4+IE9LLCBJJ2xsIGVsYWJvcmF0ZSBleHBsYW5hdGlvbiBvbiBub2MgYmluZGluZy4KPj4+
Cj4+PiBUaGFua3MuIElmIHBvc3NpYmxlLCB5b3UgYmV0dGVyIHRvIGFkZCBhbG1vc3QgZXhhbXBs
ZSBjYXNlcy4KCkhlcmUncyBhIG1vcmUgZWxhYm9yYXRlIGV4YW1wbGU6CgojaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svaW14OG1tLWNsb2NrLmg+CiNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cmNvbm5lY3QvaW14OG1tLmg+CiNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9hcm0tZ2ljLmg+Cgpub2M6IGludGVyY29ubmVjdEAzMjcwMDAwMCB7CiAgICAgICAgIGNv
bXBhdGlibGUgPSAiZnNsLGlteDhtbS1ub2MiLCAiZnNsLGlteDhtLW5vYyI7CiAgICAgICAgIHJl
ZyA9IDwweDMyNzAwMDAwIDB4MTAwMDAwPjsKICAgICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1N
X0NMS19OT0M+OwogICAgICAgICAjaW50ZXJjb25uZWN0LWNlbGxzID0gPDE+OwoKICAgICAgICAg
LyogVXNlZCB0byBtYWtlIHJlcXVlc3RzIGZvciBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1k6ICov
CiAgICAgICAgIGZzbCxzY2FsYWJsZS1ub2RlLWlkcyA9IDxJTVg4TU1fSUNOX05PQz4sCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxJTVg4TU1fSUNOX01JUEk+LAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8SU1YOE1NX0lDU19EUkFNPjsKICAgICAgICAgZnNsLHNj
YWxhYmxlLW5vZGVzID0gPCZub2M+LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnBs
MzAxX21pcGk+LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmRkcmM+OwoKICAgICAg
ICAgLyogRm9yIHBhc3NpdmUgZ292ZXJub3I6ICovCiAgICAgICAgIGRldmZyZXEgPSA8JmRkcmM+
OwoKICAgICAgICAgb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmbm9jX29wcF90YWJsZT47CiAgICAg
ICAgIG5vY19vcHBfdGFibGU6IG9wcC10YWJsZSB7CiAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJvcGVyYXRpbmctcG9pbnRzLXYyIjsKCiAgICAgICAgICAgICAgICAgb3BwLTEzM00gewog
ICAgICAgICAgICAgICAgICAgICAgICAgb3BwLWh6ID0gL2JpdHMvIDY0IDwxMzMzMzMzMzM+Owog
ICAgICAgICAgICAgICAgIH07CiAgICAgICAgICAgICAgICAgb3BwLTgwME0gewogICAgICAgICAg
ICAgICAgICAgICAgICAgb3BwLWh6ID0gL2JpdHMvIDY0IDw4MDAwMDAwMDA+OwogICAgICAgICAg
ICAgICAgIH07CiAgICAgICAgIH07Cn07CgpwbDMwMV9taXBpOiBpbnRlcmNvbm5lY3RAMzI1MDAw
MDAgewogICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4bS1uaWMiOwogICAgICAgICByZWcg
PSA8MHgzMjUwMDAwMCAweDEwMDAwMD47CiAgICAgICAgIGNsb2NrcyA9IDwmY2xrIElNWDhNTV9D
TEtfRElTUF9BWEk+OwogICAgICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZwbDMwMV9taXBp
X29wcF90YWJsZT47CgogICAgICAgICBwbDMwMV9taXBpX29wcF90YWJsZTogb3BwLXRhYmxlIHsK
ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjIiOwoKICAg
ICAgICAgICAgICAgICBvcHAtMjAwTSB7CiAgICAgICAgICAgICAgICAgICAgICAgICBvcHAtaHog
PSAvYml0cy8gNjQgPDIwMDAwMDAwMD47CiAgICAgICAgICAgICAgICAgfTsKICAgICAgICAgICAg
ICAgICBvcHAtNTAwTSB7CiAgICAgICAgICAgICAgICAgICAgICAgICBvcHAtaHogPSAvYml0cy8g
NjQgPDUwMDAwMDAwMD47CiAgICAgICAgICAgICAgICAgfTsKICAgICAgICAgfTsKfTsKCmRkcmM6
IG1lbW9yeS1jb250cm9sbGVyQDNkNDAwMDAwIHsKICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2ws
aW14OG1tLWRkcmMiLCAiZnNsLGlteDhtLWRkcmMiOwogICAgICAgICByZWcgPSA8MHgzZDQwMDAw
MCAweDQwMDAwMD47CiAgICAgICAgIGdsb2NrLW5hbWVzID0gImNvcmUiLCAicGxsIiwgImFsdCIs
ICJhcGIiOwogICAgICAgICBjbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX0RSQU1fQ09SRT4sCiAg
ICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTV9EUkFNX1BMTD4sCiAgICAgICAgICAgICAgICAg
IDwmY2xrIElNWDhNTV9DTEtfRFJBTV9BTFQ+LAogICAgICAgICAgICAgICAgICA8JmNsayBJTVg4
TU1fQ0xLX0RSQU1fQVBCPjsKICAgICAgICAgLyogRm9yIG9uZGVtYW5kIGdvdmVybm9yOiAqLwog
ICAgICAgICBkZXZmcmVxLWV2ZW50cyA9IDwmZGRyX3BtdT47Cn07CgpkZHJfcG11OiBkZHItcG11
QDNkODAwMDAwIHsKICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLWRkci1wbXUiLCAi
ZnNsLGlteDhtLWRkci1wbXUiOwogICAgICAgICByZWcgPSA8MHgzZDgwMDAwMCAweDQwMDAwMD47
CiAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47CiAgICAgICAgIGludGVycnVwdHMg
PSA8R0lDX1NQSSA5OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKfTsK
