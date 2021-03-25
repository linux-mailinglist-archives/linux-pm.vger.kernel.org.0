Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CF349A15
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYTSf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 15:18:35 -0400
Received: from mail-eopbgr660044.outbound.protection.outlook.com ([40.107.66.44]:25088
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229616AbhCYTSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 15:18:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYfwPeXGVinmafEi1JHYLCTaHD7oS0iG7zrR0sUY5yIzWnKwR4vsNZd8yOTfTNY6UZajNRwEhZzPB7BS6RwbIF8lMec/szMHk6B/1Qdre7foYH6j+jzfjLfPJgce1znTqJBzDKfdy7nVpYnyv7+iJvTxTS9sCD/5BGizTjgSWi0ClYfl2TzMU9eBZdOqu3owvAsyAqHWUIbWEWEebMfnJnj0N6MVDi4W1VkpRyS0fUt9ecQ6MjfEd+YppcTqgcUfRm6w8HPffryZz1Oplfp+2zqfCuTaZ50elrmiLTFQDjqIyO/tDKFFLo9sxQNpbuiu4ORVT9w/hyMI8uc9a+N11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WnQY+C4K7wXeI0eGzY9xji9DLDfCSVIeJmB0GiX9Ps=;
 b=XefCzoTv1r1og8dGrTae+PcbDzRKWbDfFoPUgRW/yWwLu0essGjPHYWfnuG//CkZ55/9KW63/nhlNMUvFOQisOrp3VfDRuT4MIlaYYZkZdpFThe4CnRoOr4O1xHe7NLnXW78oVu4hRXtiyXck3PnDLyjQyu7lVOwkL+PK1G4ikEPHJpM7pA9P0Pi8rX9hcuuyM0fjEpkHy+1nBb69WfW0J+RX6D8klS1RRK+TG+gaWVyQV1jxhmwwYmuRdW45uE0jrh7YVoHQO6ZZNvRodFBe3LuMkOK+vysBbfZRXMIeMkL4pUK+Xkz55LuzXACyCmLPQ18YFhVGk3ZoJ/Lxugkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WnQY+C4K7wXeI0eGzY9xji9DLDfCSVIeJmB0GiX9Ps=;
 b=OOkNTldvLgOtXn7zfTaFwG3mR7ob3rkS3Sl5EwMxsZ6VTUNbo9824e+bmUVuqmo/m+FreP2ePdDn2D92unY9WNft61+mqNINbf7vIxwmqgpkaDzIR76fW9168GhtpZQ6ig4QVlz5q93UUN81Cusnpg3bKQ50cqFcd12a0kyVuSE=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YT1PR01MB3626.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Thu, 25 Mar
 2021 19:18:08 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 19:18:08 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: =?big5?B?UmU6IKZezmA6IFtQQVRDSCAwMS8xMF0gdGljay9ub2h6OiBQcmV2ZW50IHRpY2tf?=
 =?big5?B?bm9oel9nZXRfc2xlZXBfbGVuZ3RoKCkgZnJvbSByZXR1cm5pbmcgbmVnYXRpdmUg?=
 =?big5?Q?value?=
Thread-Topic: =?big5?B?pl7OYDogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ub2h6?=
 =?big5?B?X2dldF9zbGVlcF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2ZSB2YWx1?=
 =?big5?Q?e?=
Thread-Index: AQHXFnNGiA2JtEhS2EiDRBkCbpwkF6qGkOKAgAAVHICAABBdgIAABRoAgAAI/QCAAAjRv4AAAXDTgA311gCAAF+bgIAABILr
Date:   Thu, 25 Mar 2021 19:18:08 +0000
Message-ID: <YTBPR01MB326253A7B094A2F603488EA8C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <20210311123708.23501-1-frederic@kernel.org>
 <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <20210325131400.GA938586@lothringen>,<5712356.lOV4Wx5bFT@kreacher>
In-Reply-To: <5712356.lOV4Wx5bFT@kreacher>
Accept-Language: en-CA, zh-CN, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae74793d-074f-4b28-6a6c-08d8efc2b990
x-ms-traffictypediagnostic: YT1PR01MB3626:
x-microsoft-antispam-prvs: <YT1PR01MB3626602071C7B39A51E6CC43C4629@YT1PR01MB3626.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGuS5za0144qLRwR/TzD0TuF69XV/1jXQblnkBh68HL5jge5jvk1QSS1NS+A8F2KUhxokGr1gM2IGvKL1edNe5IAs7uc03GQ64gTMsyS1nETjfT0q6VYg1IMKc5HqJ1ttqPl4lmd61X6WWP6vO85zBDgbExB2t7UyQFf7CMB4Qn42ObhG1q0eaiMlMwJipzgXIy+UCPAJdBApVFftaBzfP3AdxLrtP04/9iKR3ORjZHqHt/SM4J5dCgjfKZot8Os4Zir3Oq/FDYvfDJfSEDw/fdIIu+YOlYDnPEnLOTZRdMbj2/qZ8203aJmrKis1pJwJ68S7uwtZmVaqmaIOwA6dg2EwY7Uoyi3ulWnsjtDgM6iTZ6hljLi6rPkV5rPyrBBNfZMl3dmDT+6fRp8sO4QxTJpWi5gNcrJ/Hv/aNpzTC0HqPdWWcHBktcOwW2IydS91bL/eJTKj5H4g7+Jula3MGREfAYn6rP+OJ2oNh44hibLLDEGqag0nVUeHidW08XIYdppP1Epg2Ng6wviaHOSetUkF/ayWVIBW3zTVWh3wWy1xwONEwEfR3yIcfw4VOjiNMJuN0TjYadzTViH/5UoMLqCSclXM3SAuXAVy2WBMOY0zJUT/uJbCiOx41N9XYWVP6GSOC26eEcRlng3s2ZBMKspDNf9Wdm2Hk3lOE+MWwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39850400004)(136003)(9686003)(110136005)(53546011)(83380400001)(6506007)(54906003)(4326008)(52536014)(786003)(478600001)(38100700001)(316002)(55016002)(26005)(224303003)(186003)(66946007)(5660300002)(76116006)(7696005)(7416002)(2906002)(66476007)(64756008)(66556008)(8936002)(66446008)(86362001)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?big5?B?T1Rsa3ExajBCb0U2ekdpaGxhR2xSVmtoblRkMGhzeHA4VmRRcTMyajIvRUhsR2pI?=
 =?big5?B?TFBJN0lyTUdMQzlLUTRqYlFPbGg3dlR6ZVROY3hkaE5CN0VPMzNQajZWZU1mcE5X?=
 =?big5?B?algxUENWY1hlaUlERk5wSndNZlkxVjVybXFPVS94ZUhQK1JLVTJXdXRSaW9IZFpw?=
 =?big5?B?UWFhTzltZ3FpVURjTWhoT1Y2d0QvM2QzNm5TTjZLRHNycDJHQzNNVEN3M3E3cEov?=
 =?big5?B?b2N3YWpRT0pORXdaeXlhR3VnN2ZGOHVyVzd5K0hFeW1lTjY3bFY4VllMVmhpZGhq?=
 =?big5?B?cWpBNFJLQjIyTDVWZm9lbGVvMEhUMzY0UlRYemdPUGtWL3dMZStGWEl5eXVtT0JG?=
 =?big5?B?U1hKOWZQUnN3N0Z0QUhrUU5nYU4vQldUeDFYMHJlSTIvTFFnN3gvcUpYcTMxdzNH?=
 =?big5?B?TVpLRWRYcElSdnBvb0pFSVBzYis0c3ZGQjBTcHhqMkFPQk8vMHBuVlFpS29rY3pM?=
 =?big5?B?K2RDYmNsVDNVbUV2cHZDZ05TMWRSbjRNdG8ybG42ekt5TkVlZXVaakZOOGU4Z3FG?=
 =?big5?B?Kzg1M3hLU1pJVTlzUU5tK3E5NDlTcWt0WEg2ak41WUJIdUt5dlgrbHIyaDNoWi9X?=
 =?big5?B?ZjhmYVRjaUhwZmhnRUhWNmVVcnJneGErVUtRMXRrQUY1TUlkYVI5Rjk4UE1CQ1hi?=
 =?big5?B?cjNqa0tiRkx6N2JodjIvbEFXQ0U3SDdZZHllU2licjZHOFhxQkQ3RWlyTFFORW9E?=
 =?big5?B?amF5ZWNKQ0kyck50TzlFeG5FL2lub2NOYUN6dWgveit4S25EdlJoLzJ1TmIvVUZ2?=
 =?big5?B?VHYrYlU3SWxBNVVBMnhUT0U2NGFubkVRSU9NWnVFVW5NTjVUTGtRSm1ZazdOaEZi?=
 =?big5?B?UWtMbXBuUkdNV01kZ0lraEh0V0RONnlVZDVqV09VSG0ydkQ1QXBQcmMyZlJxRUZ0?=
 =?big5?B?MWtWMHJ4RFlFeHlmQk9ReU9xU0M1anB3bTdkVFdTZXBha045T2I3bFhROE5QMWxw?=
 =?big5?B?Tm5nZEJFU09lMlZYR0tkQVpEbXhmVGExNW8zb2EyL2pzMnpINkVueFRJTnFLSlFN?=
 =?big5?B?MnVrb1NONjgvc24wU2lNK0haakh5VE82bVJJdEtoUkNPZUxwMlh1MExINDhTa2ha?=
 =?big5?B?OW8zd0pIeUJlVXBjS0ZZQWZKa2RVYkFFbEdtMDZiQkxnV3ZWYy9ZQjMyQzFORVNx?=
 =?big5?B?Z296bnVjUmVzMThZZkdqUURmMWdCbXZGb2ZzOXNLMHB3a3Z3SnlmTEd4c1NsYnRK?=
 =?big5?B?OVRkeCt5ZXlwTXQ1aW1iR2Z2R3U4ejRzM01NVkw2QWtuSGRYdUZPcnViMnFSaXZs?=
 =?big5?B?K2lvQkhOSkFoNkVGTE9HZERnajIzMTIvdkNMS1M5eWV4NloybktwYTJmUXpweTBk?=
 =?big5?B?Nm9lcHhieVhYeUVzTkRlZUMzZUVnQ1RqN251L1dIYzhnY2ZLdWE1aHl6cFVselZM?=
 =?big5?B?ZldBYjQzaGZ6V2d2M3EvRUJNV2xPWVkvNGFoMXJkL2NybEowOFFhcnpndmNCQjNK?=
 =?big5?B?dUhYZ2hpMlk1RXRMcW54cnZaRzhuUTU3REpRbzhHdllOdzNYYVNWZjBGd2V0UVdm?=
 =?big5?B?VkdLcnlqRlJEczVzOXgzN3RHd2NUWDdsSDVYRVVNYmlJU2VUMGdPZVVEdnNMcldB?=
 =?big5?B?S3hwWFp0N3JWdG9KOXJieHNnYmdoSFRza3ZCc2FEV2Q4UE1seTk3UnNMNG14akRL?=
 =?big5?Q?y1WHmwdfc1qhIvMD/qXPokzSiew=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae74793d-074f-4b28-6a6c-08d8efc2b990
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 19:18:08.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZvyZGpqrpU1HiBzmayORx9QxymEE+q4iWLJs8riKkVZz9/MVk7KlXCXZ9NQ2LEdtXlxfvPX8rudfOQJmxcHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB3626
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTWFyY2ggMjUsIDIwMjEgMTQ6NTYsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOgo+IE9uIFRo
dXJzZGF5LCBNYXJjaCAyNSwgMjAyMSAyOjE0OjAwIFBNIENFVCBGcmVkZXJpYyBXZWlzYmVja2Vy
IHdyb3RlOgo+ID4gT24gVHVlLCBNYXIgMTYsIDIwMjEgYXQgMDQ6MDg6MDhQTSArMDAwMCwgWmhv
dSBUaSAoeDIwMTljd20pIHdyb3RlOgo+ID4gPiBCdXQgSSBkb24ndCB0aGluayBpdCdzIGEgZ29v
ZCBpZGVhIHRvIGhhbmRsZSB0aGlzIGluIGNhbGxlcnMsIGJlY2F1c2UgbG9naWNhbGx5IHRoZSBm
dW5jdGlvbiBzaG91bGRuJ3QgcmV0dXJuIG5lZ2F0aXZlIHZhbHVlcy4gUmV0dXJuaW5nIDAgZGly
ZWN0bHkgd291bGQgYWxsb3cgaWRsZSBnb3Zlcm5vcnMgdG8gZ2V0IGFub3RoZXIgY2hhbmNlIHRv
IHNlbGVjdCBhZ2Fpbi4KPiA+Cj4gPiBIbW0sIEknbSBnb2luZyB0byBsZWF2ZSB0aGUgbGFzdCB3
b3JkIHRvIFJhZmFlbCBzaW5jZSBjcHVpZGxlIGFyZSB0aGUgb25seQo+ID4gY2FsbGVycyBvZiB0
aGlzLiBJbiBhbnkgY2FzZSB3ZSBuZWVkIHRvIGZpeCBpdC4KPiAKPiBZZXMsIHdlIGRvLgo+IAo+
IFNvIEkgc2FpZCB0aGF0IEkgcHJlZmVycmVkIHRvIGFkZHJlc3MgdGhpcyBpbiB0aGUgY2FsbGVy
cyBhbmQgdGhlIHJlYXNvbiB3aHkKPiBpcyBiZWNhdXNlLCBmb3IgZXhhbXBsZSwgZm9yIHRoZSB0
ZW8gZ292ZXJub3IgaXQgd291bGQgYmUgYSBtYXR0ZXIgb2YgdXNpbmcKPiBhIGRpZmZlcmVudCBk
YXRhIHR5cGUgdG8gc3RvcmUgdGhlIHRpY2tfbm9oel9nZXRfc2xlZXBfbGVuZ3RoKCkgcmV0dXJu
IHZhbHVlLAo+IGxpa2UgaW4gdGhlICh1bnRlc3RlZCkgcGF0Y2ggYmVsb3cuCj4gCj4gU28gYXQg
bGVhc3QgaW4gdGhpcyBjYXNlIHRoZXJlIGlzIG5vIG5lZWQgdG8gYWRkIGFueSBuZXcgYnJhbmNo
ZXMgYW55d2hlcmUuCj4gCj4gSSdtIHN0aWxsIG5vdCBzdXJlIGFib3V0IG1lbnUsIGJlY2F1c2Ug
aXQgaXMgbW9yZSBjb21wbGljYXRlZCwgYnV0IGV2ZW4gaWYKPiB0aGF0IG9uZSBuZWVkcyBhbiBl
eHRyYSBicmFuY2gsIHRoYXQgaXMgYSB3aW4gYWxyZWFkeS4KCkkgd291bGQgbGlrZSB0byBwb2lu
dCBvdXQgdGhlIHBvdGVudGlhbCB0cm91YmxlIHRoYXQgZml4aW5nIHRoaXMgaXNzdWUgaW4gdGhl
IApjYWxsZXJzIGNvdWxkIGNhdXNlLgoKMS4gVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgbXVsdGlw
bGUgdGltZXMgaW4gbWVudSBnb3Zlcm5vciBhbmQgVEVPIApnb3Zlcm5vci4gSSdtIG5vdCBzdXJl
IHRoYXQgcmVjZWl2aW5nIHJlc3VsdHMgdXNpbmcgc2lnbmVkIGludGVnZXJzIGlzIGVub3VnaCAK
dG8gc29sdmUgYWxsIHRoZSBwcm9ibGVtcywgaW4gdGhlIHdvcnN0IGNhc2UgaXQgbWF5IHJlcXVp
cmUgaW5jcmVhc2luZyAKdGhlIGxvZ2ljYWwgY29tcGxleGl0eSBvZiB0aGUgY29kZS4KCjIuIFRo
aXMgZnVuY3Rpb24gaXMgaW1wb3J0YW50IGZvciBkZXZlbG9waW5nIGlkbGUgZ292ZXJub3IuIApJ
ZiB0aGUgcHJvYmxlbSBpcyBub3QgZml4ZWQgaW4gdGhlIGZ1bmN0aW9uIGl0c2VsZiwgdGhlbiB0
aGlzIHBvdGVudGlhbCAKcGl0ZmFsbCBzaG91bGQgYmUgZXhwbGljaXRseSBzdGF0ZWQgaW4gdGhl
IGRvY3VtZW50YXRpb24uIFRoaXMgaXMgYmVjYXVzZSAKaXQgaXMgZGlmZmljdWx0IHRvIHByZWRp
Y3QgZnJvbSB0aGUgZGVmaW5pdGlvbiBhbmQgbmFtaW5nIG9mIHRoZSBmdW5jdGlvbiAKdGhhdCBp
dCBtaWdodCByZXR1cm4gYSBuZWdhdGl2ZSBudW1iZXIuIEkgYWN0dWFsbHkgZGlzY292ZXJlZCB0
aGlzIGFub21hbHkgCndoZW4gSSB3YXMgZG9pbmcgZGF0YSBhbmFseXNpcyBvbiBteSBvd24gaWRs
ZSBnb3Zlcm5vci4gRm9yIHNvbWUgaWRsZSBjb250cm9sIAphbGdvcml0aG1zLCB0aGlzIGV4Y2Vw
dGlvbiByZXR1cm4gY291bGQgbGVhZCB0byBzZXJpb3VzIGNvbnNlcXVlbmNlcywgCmJlY2F1c2Ug
bmVnYXRpdmUgcmV0dXJuIGxvZ2ljYWxseSB3b24ndCBoYXBwZW4uCgo+IAo+IC0tLQo+ICBkcml2
ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jIHwgICAgOCArKysrLS0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IEluZGV4OiBsaW51eC1w
bS9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jCj4gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IC0tLSBsaW51
eC1wbS5vcmlnL2RyaXZlcnMvY3B1aWRsZS9nb3Zlcm5vcnMvdGVvLmMKPiArKysgbGludXgtcG0v
ZHJpdmVycy9jcHVpZGxlL2dvdmVybm9ycy90ZW8uYwo+IEBAIC0xMDAsOCArMTAwLDggQEAgc3Ry
dWN0IHRlb19pZGxlX3N0YXRlIHsKPiAgICogQGludGVydmFsczogU2F2ZWQgaWRsZSBkdXJhdGlv
biB2YWx1ZXMuCj4gICAqLwo+ICBzdHJ1Y3QgdGVvX2NwdSB7Cj4gLSAgICAgICB1NjQgdGltZV9z
cGFuX25zOwo+IC0gICAgICAgdTY0IHNsZWVwX2xlbmd0aF9uczsKPiArICAgICAgIHM2NCB0aW1l
X3NwYW5fbnM7Cj4gKyAgICAgICBzNjQgc2xlZXBfbGVuZ3RoX25zOwo+ICAgICAgICAgc3RydWN0
IHRlb19pZGxlX3N0YXRlIHN0YXRlc1tDUFVJRExFX1NUQVRFX01BWF07Cj4gICAgICAgICBpbnQg
aW50ZXJ2YWxfaWR4Owo+ICAgICAgICAgdTY0IGludGVydmFsc1tJTlRFUlZBTFNdOwo+IEBAIC0y
MTYsNyArMjE2LDcgQEAgc3RhdGljIGJvb2wgdGVvX3RpbWVfb2sodTY0IGludGVydmFsX25zKQo+
ICAgKi8KPiAgc3RhdGljIGludCB0ZW9fZmluZF9zaGFsbG93ZXJfc3RhdGUoc3RydWN0IGNwdWlk
bGVfZHJpdmVyICpkcnYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsIGludCBzdGF0ZV9pZHgsCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTY0IGR1cmF0aW9uX25zKQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHM2NCBkdXJhdGlvbl9ucykKPiAgewo+ICAgICAgICAgaW50IGk7
Cj4gCj4gQEAgLTI0Miw3ICsyNDIsNyBAQCBzdGF0aWMgaW50IHRlb19zZWxlY3Qoc3RydWN0IGNw
dWlkbGVfZHJpCj4gIHsKPiAgICAgICAgIHN0cnVjdCB0ZW9fY3B1ICpjcHVfZGF0YSA9IHBlcl9j
cHVfcHRyKCZ0ZW9fY3B1cywgZGV2LT5jcHUpOwo+ICAgICAgICAgczY0IGxhdGVuY3lfcmVxID0g
Y3B1aWRsZV9nb3Zlcm5vcl9sYXRlbmN5X3JlcShkZXYtPmNwdSk7Cj4gLSAgICAgICB1NjQgZHVy
YXRpb25fbnM7Cj4gKyAgICAgICBzNjQgZHVyYXRpb25fbnM7Cj4gICAgICAgICB1bnNpZ25lZCBp
bnQgaGl0cywgbWlzc2VzLCBlYXJseV9oaXRzOwo+ICAgICAgICAgaW50IG1heF9lYXJseV9pZHgs
IHByZXZfbWF4X2Vhcmx5X2lkeCwgY29uc3RyYWludF9pZHgsIGlkeCwgaTsKPiAgICAgICAgIGt0
aW1lX3QgZGVsdGFfdGljazsKCg==
