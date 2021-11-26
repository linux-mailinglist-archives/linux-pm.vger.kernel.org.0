Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806AA45ED3F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbhKZMB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 07:01:57 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:17570
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229721AbhKZL74 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 06:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g++RZD9dNqgjySWN5lD6UZSNylzORr5Eq8wVEM/Jr1/146dk8Ex6uoeosD69Hln4K4NdwCti+6wey4cMKz2t7FKgYpTaNta6XL4zM7m4YNAWBT9NqxDlRUW6IYGJ1V+5ONlL1kvW/e1JLNuCI011C10t+6gpMTS8jgv24MUgUqIanTRZNeUdft4qCdfg4FLX5BXzxYjQ3xizwr9ZwBAioQlM4HCL3WhQdd1HOYAECzl70oFGps1PdatDKIWNhKPSGD/H3TPB461xCCtzmuE3QSmufC0wIrgGpKUEpKQgnO6KnaXE1ULiCAwYnayHia+mCcxhYleSnOxcxKXJpThGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bukb4gESXDdvKMRqJJ7qf4jAqHuL2I7R5Ay9pMrPUU=;
 b=Lefuf4c71VsxCR1sx/BpCPYisNddNkdljwhVaOH+Iy+4jnhHudq1kHdzN2RbO5fSU+kYN7a3h6hTn+DwYyhIDTbZZNR4Kq0/SOd4N54dJJw3Vr2uf5TMTgSMmUUU4xZY9aE69oO/pYFzSugRM0gktkf9B9/IzYMMwNZtXcsSNM5MuZ2JWv2J6ah1or60XIGS53AteJ9NzKZLjx62aFtnmKwuOB1fRmYTUy/DIXmayPvHoR/hmTKwtM/KKOqFshvrCN2AEGejw0KAtM559PaGueHmkw7L0q+8wh6PvFCRobGBdvWDJCpDyYBw2FBv3xB2NDVVcuWISAfDLTIONTlg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bukb4gESXDdvKMRqJJ7qf4jAqHuL2I7R5Ay9pMrPUU=;
 b=qga/drtMtozPOVnnknJelSOlssmnkpTD78JHoDziWFSUjMXfGx1NpeUs8eZm5IM1a3f7KV2kz6Duc2Jg6k3V1JXjZ9lZMJCxu7mdDJBarAeQuMS//pXusgvVJ6v3I4QA8yWQoIBbovpFtQ4p8kM2aiPw0AJq8FS3hTC7KtGWAK4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2731.eurprd03.prod.outlook.com (2603:10a6:3:eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 26 Nov 2021 11:56:37 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 11:56:37 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Topic: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Index: AQHX2uUgAyZ64u/b2EuYwDXlo7neoqwIjSeAgABDOACADPMrgA==
Date:   Fri, 26 Nov 2021 11:56:37 +0000
Message-ID: <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
In-Reply-To: <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d840ea43-6fce-4e8e-4764-08d9b0d3cd29
x-ms-traffictypediagnostic: HE1PR0302MB2731:
x-microsoft-antispam-prvs: <HE1PR0302MB2731DF256B6A3E4C4C9572E7AD639@HE1PR0302MB2731.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+U/XhqlVTndAr26sLxk4MFEoJa2YNzcbZQVOPxJDGcVQW6GWscMwpltImtkHvhweQFXfRjEpdveYt0p3/1Ee06c/MEmJHaKbabv5HDReHssql1DXfHWC/jUJSHaDfzKkoZb5DgrwJZr4W6ndq4ZTfzwLqRb8xE/3MoLnf2Xe+chZiITSZHCybi/UstDNkORFeS8Lm0w7zZHmXYcECC8CWcJwLfpzlSacz3tO76wI+XuvRCWFf9gN21YSrp3NiFlTnkFacuTbuBPr7gHO6J7kbdoP/m9QXcXA0EBlGBwG21nxL2KbV/njr0BWgUB1iU4acB8yVna9a5NLHEzQLLaCKw4ls3cbn7jREcPHl8426JyWGCnsbnLp4KRD6Ycej8CttRUkYgxHlTCffDemyMLeFhv5GHzLMrpAGFq2x+QqNoP87Zf9xzZNcpqkexJMXHEO+VvIn+Pjs/l3e27nch/yO3ZAiO8O7xenUZzo7yxqOaN4uSMbcaGtOF3jrC4Rylhx7RYxfzSRGyzzmvdWW5T/lAg78Hnh2hqITREgMXAL+DuVBLKzqZNQoToOT9jdg6sWk4vDSjFIJM7NngADaE/dteaedD0i4KXy90P5N0AX8J2cAlWgerXxWUL3XJIvc4gUisLzRnu6HkwRkBmcDCyLxt3MjGg4GvvuLY7kfphZywFNRFLSHTxLSIP2TN10HTLXXVy+A4lcFn0h+suScbo30RhM9X7RrLJ8RcHygMJxBXbkON/3GJh4GIfgkWhVOK+8xAKM2a+dj+Ixo8lBzzhcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(86362001)(64756008)(76116006)(7416002)(66946007)(4326008)(66556008)(107886003)(66446008)(508600001)(5660300002)(6512007)(6486002)(6506007)(53546011)(31686004)(83380400001)(54906003)(316002)(2906002)(71200400001)(38100700002)(186003)(2616005)(38070700005)(31696002)(8936002)(8676002)(6916009)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWIrNStLRllVaUNZWWdmZ1BCSzd2dnI5d1dIYmZpSm9HeW9JcXFOOEVlazMx?=
 =?utf-8?B?c0ZDL09oOGRVVThxWGdzYmFJVGhGTW9xVVc2cHRLTWg1eko5Z1dsVEJNMzBP?=
 =?utf-8?B?TEZSbWRSNW9wcENkbThudzEwODI0cURNVUNVcnh2NEpKYU9MSGx6RlNpVjFB?=
 =?utf-8?B?RFJNTFBnbGY0cERERXg0Y3g4M3RwS1BIS29GWnZKWGM5VW1tbnNhRXJRYVVz?=
 =?utf-8?B?RHBRSWp6cS9jdVhhRWlvMmdaZzFDVTVZRS96WjltLzNneHNhOGdoekdKWUVs?=
 =?utf-8?B?QlErWWFRSjdrYlZzUjRPSFBwcnR1N3RMa09GOHNDSUhDOTN4LzV1WExNenpn?=
 =?utf-8?B?L0FranNlbHM2MjN1bzNJc0pEY0lER2wreS9xNmN6aDdnLzcyWG1sWm05ZS9E?=
 =?utf-8?B?K25tZ05UeUFLMDBOR2pMUmYzMlUramo3K0pXWDJiVUYySDRuNjlpRHcvUVRi?=
 =?utf-8?B?aWRVcFRIM0M3UmkrMlNvY21jUWdWMzU1eXFlQUJieVhMdFg5aWVlYXNRZzl0?=
 =?utf-8?B?eWRTOXVaZmEweitWcFdtTXZsM1lHWHRMMDVHNS9raUhNSDRweXBqTUlRNWow?=
 =?utf-8?B?aHhIOGZKaVJNN2R3STM5a29GRzROT25GZjZSaHk5cDhQV2o0R3czdFlIOWV5?=
 =?utf-8?B?cnRISUt2dGlnd0syOVRMbVRMcDBJUEdjYm9uY1AycVhNaFlkZ1huSlJiZkRW?=
 =?utf-8?B?SnphRGhKRHNMaWdQUEVkZWhlQXFndVhSM01SSllSbWhWZm4wMG1IdG1SM0pW?=
 =?utf-8?B?bHlMbWUxamp5VVNKRlptVk1FMEZVRjFTNGE1bW94ZVFtVi84UlFSaE1pMGZ2?=
 =?utf-8?B?NmFsYmovNjBDeWoya2xmYmNvV3VTeUdqNlVxWlRuOGp1cDIzOGgzY2sxaUZw?=
 =?utf-8?B?MDliSkIwMEVnTUFHT01KdWhVQTI3MExYTTVPbDRqazJDTlQrSzQ1WnVoc2Rq?=
 =?utf-8?B?eGJYQjUwc1NNdHRXNmNZdys4d29Cc3hJZFVRZlY5YUlBd0N3N2N5dWlkRWRa?=
 =?utf-8?B?Z3FUazVrSzE5OGVHQzhRNThJYmdJb1pzMGR0aWRxdllEZHFRSnBpN1U3bUlq?=
 =?utf-8?B?MHczZGd1YUJ3Q2JDdjdqMmtHMmhwTnM2ODR5elFHaFlKbjUyY0V4M3g2Y0Rs?=
 =?utf-8?B?VXNRSEtIamI0YVMycTNPMUN1bE5DMW8wYTlidEUxQWZDWlhIVDZxVDdiQ2oz?=
 =?utf-8?B?enFjL1lDSUdMUTJFWFQrczBWYTZCSG5qYjFJa0NTTWtyend5amdJVStTSE9r?=
 =?utf-8?B?dDJDcEJnREZHMEIxNnlVNWlNQ3VGaEhBd24reEtxdzFOL0UyVXdMcEllZmJU?=
 =?utf-8?B?VlRzdjFjUlFKUDA3YXJUWTdnNkFQTU03eS81UTN2dWE2RE5mRlpBY2FHdEZT?=
 =?utf-8?B?VHVJUmRRZmNtdXNXdnd1eWtwQlcvRTFNNTd2bmkzRm5YR3ZTQ3d6OVE1RmNP?=
 =?utf-8?B?M1RWb1IrSEhqYVZuVG1sUFFHQW5zOHAwSzhqdnlWMW1IbGZCNXEybTFRM2or?=
 =?utf-8?B?ZVdzdnYyWnNlT1ZmVDdWSGdFR1RyaWY3ejgwdUtHWnc2bksyQzRLTXJDZUQr?=
 =?utf-8?B?eVNQeWRhU01QUWlpSEMydnAzaHBkQlhTQWFuRnNIbUlyS2lyT3o5ek16bVY2?=
 =?utf-8?B?Z3IyQVA0QTd4ODEveU1Lam5DYTdDWTg3N3lUTlZjU1FHNHdxbTlaVkowVWRz?=
 =?utf-8?B?UERqbnpXdjg0L3ZWdFc3Z0ltKzJPQzVqSVNOVXRBNWhqdy9aNnlTK0NETlB3?=
 =?utf-8?B?Tk85clNXcW0rUGFvZjd2ODF5N1pNZ1NKT3hRTEw4by9IU2Q0VDVKTGdsNXV2?=
 =?utf-8?B?RldDVXFDR1htV2h1N3J5aThxeVlrNlZ3eXFIcVhKSVVYYUVqRXNSRU5ZWFc2?=
 =?utf-8?B?ZGcrRmllZHhnTHJ0a2Nzdm1QVCt2WVQvMEZKM0hXSVV2MGkyU0hEaWpsMi85?=
 =?utf-8?B?dXhiYmxTVmFTaElFSWNrQmFqc1JkckVqU1pxYjNOemFWL0tibEdvTUxhU3NM?=
 =?utf-8?B?N0p6MDB4SVBGS2dFdXhSMGZ6dHg4MjJKTUVzWmI4ejhRcUp0NXFEOXJ6ZDNj?=
 =?utf-8?B?UzV1bE00dlBSS0hwbllEWFd0d3Z4NjJucVlvV0JmMm9zakhESmdxWjhqSVhU?=
 =?utf-8?B?YlZQSmhsNU9BeENNR0Rad2RFUFhxRVEySlNSeVhObW9LY2NVaUFNZmdyalcz?=
 =?utf-8?B?M2t6L05oT09Da3hXL3NlcldaZVJOQXNMZVZhRXZ2ZkZTS0J0Q1Z0eHB0Nk44?=
 =?utf-8?B?YW9SVkZhQmZ0a0RaaGZwWmtmM1NhWkFIZ2JUZDZ0STRXbW9mZzJzNUNYOVIz?=
 =?utf-8?B?YlRNVTMrWSsxR0RVWDR5WU9jRGs2S2Z5VkxCeWhtTGR4Nmc2NUJ6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FDD712ADCA05C46851A508539BC16DA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d840ea43-6fce-4e8e-4764-08d9b0d3cd29
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 11:56:37.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/1trdFfUudsmURKbvtocsTe8WnOe7lPH33MtXk1BbM8vSNdizQldmUYI8puCheMuGhT08SOPblIEMPyFkZPwo08Nvr0he983NLHThIRe2TNxESVh9xVXPa59foEZw3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2731
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlIEhvIGFnYWluLA0KDQpPbiAxMS8xOC8yMSAwODoxMSwgTWF0dGkgVmFpdHRpbmVuIHdy
b3RlOg0KPiBIaSBMaW51cywNCj4gDQo+IE9uIDExLzE4LzIxIDA0OjEwLCBMaW51cyBXYWxsZWlq
IHdyb3RlOg0KPj4gT24gVHVlLCBOb3YgMTYsIDIwMjEgYXQgMToyNiBQTSBNYXR0aSBWYWl0dGlu
ZW4NCj4+IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPj4NCj4+
PiBTdXBwb3J0IG9idGFpbmluZyB0aGUgImNhcGFjaXR5IGRlZ3JhZGF0aW9uIGJ5IHRlbXBlcmF0
dXJlIiAtIHRhYmxlcw0KPj4+IGZyb20gZGV2aWNlLXRyZWUgdG8gYmF0aW5mby4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1l
dXJvcGUuY29tPg0KPj4NCj4+IFNhbWUgcXVlc3Rpb25zIGFzIG9uIHRoZSBiaW5kaW5nIHBhdGNo
Lg0KPj4NCj4+IElmIHdlIGFscmVhZHkgc3VwcG9ydCBkaWZmZXJlbnQgZGVncmFkYXRpb24gYnkg
dGVtcGVyYXR1cmUgdGFibGVzLA0KPj4gd2h5IGRvIHdlIG5lZWQgYSBzZWNvbmQgbWVjaGFuaXNt
IGZvciB0aGUgc2FtZSB0aGluZz8NCj4gDQo+IFRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcyB1cC4g
QXMgSSBzYWlkLCBJIGRpZG4ndCBub3RpY2UgdGhhdCB3ZSBjb3VsZCANCj4gaW5kZWVkIHVzZSB0
aGUgQ0FQLU9DViB0YWJsZXMgZm9yIGRpZmZlcmVudCB0ZW1wZXJhdHVyZXMgdG8gYnJpbmcgaW4g
DQo+IHRoaXMgaW5mb3JtYXRpb24gOikgSSBzZWUgY2VydGFpbiBiZW5lZml0IGZyb20gdGhlIHBv
c3NpYmlsaXR5IG9mIG5vdCANCj4gcmVxdWlyaW5nIHRvIG1lYXN1cmUgdGhlIE9DViBhdCBkaWZm
ZXJlbnQgdGVtcGVyYXR1cmVzIC0gYnV0IGl0IG1heSBub3QgDQo+IGJlIG1lYW5pbmdmdWwuIEFz
IEkgcmVwbGllZCB0byB5b3VyIHBhdGNoIDEvOSByZXZpZXcgLSBJIG5lZWQgdG8gKHRyeSANCj4g
dG8pIGRvIHNvbWUgbW9yZSByZXNlYXJjaC4uLg0KDQpJIHRyaWVkIGRvaW5nIHNvbWUgcG9uZGVy
aW5nIGhlcmUgdG9kYXkuIFVuZm9ydHVuYXRlbHksIHRoZSBGcmlkYXkgDQphZnRlcm5vb24gaXMg
cHJvYmFibHkgdGhlIHdvcnN0IHRpbWUgdG8gdHJ5IHRoaXMgLSBteSBicmFpbnMgY2Vhc2UgDQpv
cGVyYXRpbmcgYXQgdGhlIGFmdGVybm9vbiAtIGFuZCBkb3VibGUgc28gYXQgdGhlIEZyaWRheS4g
RnJpZGF5IA0KYWZ0ZXJub29ucyBhcmUgZ29vZCBmb3IgYmFiYmxpbmcgdmlhIGVtYWlsIHRob3Vn
aCA7KQ0KDQpJIGRvbid0IHNlZSBwcm92aWRpbmcgT0NWIHRhYmxlcyBhdCBkaWZmZXJlbnQgdGVt
cGVyYXR1cmUgZ2l2ZXMgdGhlIA0KZGVncmFkYXRpb24gb2YgYmF0dGVyeSBjYXBhY2l0eS4gV2hv
YWguIEEgYmlnIHRob3VnaHQgZm9yIEZyaWRheS4NCg0KV2UgZ2V0IHRoZSBPQ1YgPT4gU09DIGNv
cnJlc3BvbmRhbmNlIGF0IGRpZmZlcmVudCB0ZW1wZXJhdHVyZXMuIEkgDQpob3dldmVyIGRvbid0
IHNlZSBob3cgdGhpcyBnaXZlcyB0aGUgT0NWID0+IGVuZXJneSByZWxhdGlvbi4gQXMgZmFyIGFz
IEkgDQprbm93IGJvdGggdGhlIE9DViBhbmQgdGhlICdhbW91bnQgb2YgdUFocyBiYXR0ZXJ5IGlz
IGFibGUgdG8gc3RvcmUnIGFyZSANCmltcGFjdGVkIGJ5IHRlbXBlcmF0dXJlIGNoYW5nZS4gVGhp
cyBtZWFucywgc2VlaW5nIHRoZSBPQ1YgPT4gU09DIGF0IA0KZGlmZmVyZW50IHRlbXBlcmF0dXJl
cyBkb2VzIG5vdCB0ZWxsIHVzIHdoYXQgaXMgdGhlIGltcGFjdCBvZiANCnRlbXBlcmF0dXJlIHRv
IHRoZSBPQ1YsIGFuZCB3aGF0IGlzIHRoZSBpbXBhY3QgdG8gU09DLg0KDQpGb3IgY2FzZXMgbGlr
ZSB0aGUgUk9ITSBDaGFyZ2Vycywgd2UgYXJlIGludGVyZXN0ZWQgb24gaG93IG11Y2ggaGFzIHRo
ZSANCidhYmlsaXR5IHRvIHN0b3JlIHVBaHMnIGNoYW5nZWQgZHVlIHRvIHRoZSB0ZW1wZXJhdHVy
ZS4gV2hlbiB3ZSBrbm93IHRoZSANCmFtb3VudCBvZiB1QWhzIHdlIGNhbiBzdG9yZSwgd2UgY2Fu
IHVzZSB0aGUgY291bG9tYiBjb3VudGVyIHZhbHVlIHRvIA0KZXN0aW1hdGUgd2hhdCB3ZSBzdGls
bCBoYXZlIGxlZnQgaW4gdGhlIGJhdHRlcnkuDQoNCkluIGFkZGl0aW9uIHRvIHRoaXMgd2UgZG8g
dXNlIHRoZSBPQ1YgaW5mb3JtYXRpb24gZm9yIHRoZSAibmVhcmx5IA0KZGVwbGV0ZWQgYmF0dGVy
eSIgLSB0byBpbXByb3ZlIHRoZSBlc3RpbWF0aW9uIGJ5IHplcm8tY29ycmVjdGlvbiANCmFsZ29y
aXRobS4gSSBtdXN0IGFkbWl0IEZyaWRheSBhZnRlcm5vb24gaXMgbm90IHRoZSB0aW1lIEkgY2Fu
IHF1aXRlIA0KcmVjYXAgdGhpcyBwYXJ0LiBJIHRoaW5rIGl0IHdhcyBzb21ldGhpbmcgbGlrZToN
Cg0KMS4gTWVhc3VyZSBWQmF0IHdpdGggc3lzdGVtIGxvYWQgKFZCQVQpDQoyLiBGaW5kIE9DViBj
b3JyZXNwb25kaW5nIHRoZSBjdXJyZW50IFNPQyBlc3RpbWF0ZSAoU09DIGJhc2VkIG9uIGNvdWxv
bWIgDQpjb3VudGVyIHZhbHVlKSAtIE9DVl9OT1cNCjMuIENvbXB1dGUgVkRST1AgY2F1c2VkIGJ5
IHRoZSBsb2FkIChPQ1ZfTk9XIC0gVkJBVCkNCjQuIEFzc3VtZSBWRFJPUCBzdGF5cyBjb25zdGFu
dCAob3IgdXNlIFJPSE0gVkRSIHBhcmFtZXRlcnMgaWYgcHJvdmlkZWQpDQo1LiBVc2luZyBWRFJP
UCBjb21wdXRlIHRoZSBPQ1ZfTUlOIHdoaWNoIG1hdGNoZXMgdGhlIG1pbmltdW0gYmF0dGVyeSAN
CnZvbHRhZ2Ugd2hlcmUgc3lzdGVtIGlzIHN0aWxsIG9wZXJhdGlvbmFsDQo2LiBVc2UgdGhlIE9D
Vl9NSU4gYW5kICJPQ1YgYXQgU09DMCBmcm9tIGNhbGlicmF0aW9uIGRhdGEiIGRpZmZlcmVuY2Ug
dG8gDQphZGp1c3QgdGhlIGJhdHRlcnkgY2FwYWNpdHkuDQoNCihFeHBsYW5hdGlvbiBkb25lIGF0
IEZyaWRheSBhZnRlcm5vb24gYWNjdXJhY3kgaGVyZSkuDQoNCj4+IEknZCBqdXN0IGNhbGN1bGF0
ZSBhIGZldyB0YWJsZXMgcGVyIHRlbXBlcmF0dXJlIGFuZCBiZSBkb25lIHdpdGgNCj4+IGl0Lg0K
Pj4NCj4+IEF0IGxlYXN0IGRvY3VtZW50YXRpb24gbmVlZHMgdG8gYmUgdXBkYXRlZCB0byByZWZs
ZWN0IHRoYXQgdGhlIHR3byANCj4+IG1ldGhvZHMNCj4+IGFyZSBleGNsdXNpdmUgYW5kIHlvdSBj
YW4gb25seSB1c2Ugb25lIG9mIHRoZW0uDQoNCkkgZG9uJ3Qgc2VlIHRoZXNlIGV4Y2x1c2l2ZSAo
YXQgRnJpZGF5IGFmdGVybm9vbiBhdCBsZWFzdCkuIEkgdGhpbmsgdGhleSANCmNhbiBjb21wbGVt
ZW50IGVhY2gtb3RoZXJzLiBUaGUgdGVtcF9kZWdyYWRhdGlvbiB0YWJsZSBnaXZlcyB1cyB0aGUg
DQp0ZW1wZXJhdHVyZSBpbXBhY3Qgb24gPGVuZXJneSBzdG9yaW5nIGFiaWxpdHk+LCBlZywgaG93
IG11Y2ggdGhlIGJhdHRlcnkgDQpjYXBhY2l0eSBoYXMgY2hhbmdlZCBmcm9tIGRlc2lnbmVkIG9u
ZSBkdWUgdG8gdGhlIHRlbXBlcmF0dXJlLg0KDQpPQ1YtU09DIHRhYmxlcyBhdCB2YXJpb3VzIHRl
bXBlcmF0dXJlcyB0ZWxsIHVzIGhvdyBPQ1YgbG9va3MgbGlrZSB3aGVuIA0Kd2UgaGF2ZSBYJSBv
ZiBiYXR0ZXJ5IGxlZnQgYXQgZGlmZmVyZW50IHRlbXBlcmF0dXJlcy4gRXN0aW1hdGlvbiBvZiBo
b3cgDQptdWNoIHRoZSBYJSBpcyBpbiBhYnNvbHV0ZSB1QWhzIGNhbiBiZSBkb25lIGJ5IHRha2lu
ZyBpbnRvIGFjY291bnQgdGhlIA0KZGVzaWduZWRfY2FwLCBhZ2luZyBkZWdyYWRhdGlvbiBhbmQg
dGhlIHRlbXBlcmF0dXJlIGRlZ3JhZGF0aW9uIChhbmQgdGhlIA0KcG9zaXRpb24gb2YgbW9vbiwg
YW1vdW50IG9mIG11b25zIGNyZWF0ZWQgYnkgY29zbWljIHJheXMgaGl0dGluZyANCmF0aG1vc3Bo
ZXJlIGF0IGtuZWUgZW5lcmd5IHJlZ2lvbiBhbmQgc28gb24uLi4pDQoNCk9yIGFtIEkganVzdCBn
ZXR0aW5nIHNvbWV0aGluZyB0ZXJyaWJseSB3cm9uZyAoYWdhaW4pPyA6KQ0KKEkgc3RpbGwgZm9y
IGV4YW1wbGUgbGlrZSBpbnRlcm5hbCBmdW5jdGlvbnMgbmFtZWQgYXMgX19mb28oKSApDQoNCllv
dXJzDQotLU1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29u
ZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNl
bWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9V
TFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdy
aXRlcnMgYmxvY2sgfn4NCg==
