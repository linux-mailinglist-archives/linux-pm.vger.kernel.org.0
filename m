Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA072EA9F0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 12:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbhAELch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 06:32:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25112 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAELch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 06:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609846355; x=1641382355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hrr1NqauJPRBfBx4LQKTdoDMWErMQphQ7YicWOD9bkE=;
  b=uj5h0ImgWBC4klHnh8oMDEi6yiociwAT2V67lSTfYDljamYoN6mOWu1T
   D/Ah6Ux5dJ3ZZDu2EADSITK65WQBqHpMNXBFS9vFvkkjkmeuxgAXNqP2r
   i0kuvz9ino5x5yAfTqPy4VFXNRbaPeWhGo4IMzFmY7mo5OBffq7K8Wm0l
   wp3o9uwYIgpvuB7g43lQuSTb09ed+64gpAzO8DKreDy+xyPIVigYorZHG
   Lhg27q19ym9Bf9oXc8NyXOJOy7WmJf/R7FFp/yfatjglVwXL+fXbRQ4Ck
   yvD+gnF8frmJWrF4eVlUYQ1FUe7uQjPKFbdF+YPziIyoNRQmsTRIYF2Vm
   g==;
IronPort-SDR: 9uG9eCsjMTJSyS+QAIjqPMkadPoOPxy91p0xmQwiH70CIakEHeeajLt4U//Z/Mp6dh165QKTvq
 fgA6NXhTCtZPefxObjcuVwYwvoks9eHvWxdFf2feVMaup8h1P2PrvqQ39i7QYcMwJKpHpOEcxk
 liZJs/AQ4uqsTXcQAP8imNPsaJoUBz+AFHnnltVfMXF0gvjPOPqOoP3/M/9I53n10jjfwc3bCr
 v0l8gN8CvGZjE0L6SGFWQ481IxllvrePuc/qUz5OJmmohAySzZG0VJOmPRCSJ9/QuJS5nMpZ0e
 6aY=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="99028898"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 04:31:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 04:31:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 5 Jan 2021 04:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0XxZwjAcHQuWIuXiAP44L/K/A/lx5jaeCUoPVT+wlolwI0JGYuwJSJTZVoIpBTpHhsA8sTnDaKRABwdLArVljvvCRdxnyQncp4XIHzXR03X2mA5GfZmcCFXpDDGUTgew3MNn+GV+SVFh8QV2VRTb2vjfnEaULbntn8p2hV5aWOMT9rYK5QUmiJZoXsPzmpsyicIOlkK8u5M91UL3adgVH4TUGy4g236E9CUWol6XU2DDvkSuDXKN5dGjTOsGNBAY3QY7JioNJGxmEVdIkVwECTkM+XDwbx7S8QahnNLagXhCG/zdGPYanDHDKX8+GDn73VjkHn69H9NCcb3TiehoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrr1NqauJPRBfBx4LQKTdoDMWErMQphQ7YicWOD9bkE=;
 b=UEKgdNb6CZJEDRxZklpE+B27/eU8nLaeXiN5DNnhRLtPB1uLHfncCOSVuD//ZOl1ZyJ/9u0dbttfRbyLTv7Pp5mGDQwucDjQ09PDhQyrlAnsHkEB1sC8tSRlnv2BJpGYB9jLZLRmJL21ZHDyYEvu2Z1pk9XSF5bxy9ubqz/Fc/bpiA0hh4mJfEAskzFxFz4dunKv2Gks9/wH43oyT0Wdb3b31cAJ9RlJ1KZ+lerKpjDNp682U4Xbb5CZDiXbU2EPiWeOxVP2BrBetAyKKGxYvI7pUwMZdTJkBpmPUnJGzIy6iaK5uYe0HUhrtlB5u1sUw6ATlcR5yw67SB6ACnf7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrr1NqauJPRBfBx4LQKTdoDMWErMQphQ7YicWOD9bkE=;
 b=F/5bG5YpE7FJH+EV6SMIGHQQLZMXoA+33CwfLTpLoN2jZd0mGtO9iZkW9/KVj+LnpQ8Pu2L7lb824DT9sRC+HJYa3yiViojdBQFe3cOVehhAGxbCpyaMb52d4qDie41DqzMM8IN+WLtd9KujcBj+wI1ys0j9xCFdQDaPggxH+pc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB2859.namprd11.prod.outlook.com (2603:10b6:5:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Tue, 5 Jan 2021 11:31:17 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::b96e:6776:6971:80f4]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::b96e:6776:6971:80f4%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 11:31:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <robh+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cpufreq: sama7g5: add cpufreq driver
Thread-Topic: [PATCH 2/3] cpufreq: sama7g5: add cpufreq driver
Thread-Index: AQHW41ZHKVrO5FbkkkODCg/ABlGhcA==
Date:   Tue, 5 Jan 2021 11:31:17 +0000
Message-ID: <92783e9d-d320-0af5-1282-6c850ebf787b@microchip.com>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
 <1609842147-8161-3-git-send-email-claudiu.beznea@microchip.com>
 <20210105104426.4tmgc2l3vyicwedd@vireshk-i7>
In-Reply-To: <20210105104426.4tmgc2l3vyicwedd@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091d54a3-a4ac-45c6-735f-08d8b16d6adb
x-ms-traffictypediagnostic: DM6PR11MB2859:
x-microsoft-antispam-prvs: <DM6PR11MB28591B31C922230BCF7EF49587D10@DM6PR11MB2859.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zVtmC7zjKsy5Tiw/zO0UIPSCGmWGJranaown+XGSsLSKVIjO2Fj3LjfPI4IgTrXyLy2ce7VgmzFwCLGJXZFUEzhggIEkT4W5dHkM1t17CcN9C5q4QvR2xRggBmxEOfJm2Z3SUAdCsRNb5KmqzOo4GGo93CwBDG9vhSdNdgJZ0m6l7MKF3WK2U8uvJwmB8iLAqmK6agFDNj00oN6SHcqRPTLQv1hz/9JBHOe/UYPWFgJW7qsDIiLuJ8UXFiyh9HhYTQUHV7phDR9w2uCt9hRKM9vNdKoRD+PbgvkqZ/6qjwdFkW8g2R+74hcVNNBbB+SGJMHnQM+lE+GkDRANOy1x+L5EK262nRcteT8oqlkTDffVcun7+cGKmD6subLaEVsOqmvLWRPWBnzwGKckh23gO+aVOvCGopyagzIZJb4zamdtMyjS17d7CXJMbBNrA5/CS4AUxutE+S/x3vjM8HGnaWGz5ktYRQnvDTQa6GiII4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39840400004)(66446008)(66556008)(86362001)(66946007)(66476007)(64756008)(31686004)(31696002)(91956017)(186003)(76116006)(6486002)(6512007)(5660300002)(6916009)(71200400001)(2616005)(8676002)(2906002)(8936002)(26005)(36756003)(53546011)(6506007)(478600001)(54906003)(83380400001)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SGdkRnY5TmNNSmorUk1CRGd0SkFITW5vSTFhOElPTDZuMVFEVXpERTJqaXBw?=
 =?utf-8?B?RzlpVStpVXdiZWt5UENQNkxxV2JUemhsNnhjbEdKbmo0dGdrS01mczhZbEFC?=
 =?utf-8?B?NGVENG9lMzZCK2xlSUd5UkdoK2lwQzFzUXRTbWxUb2trWTRDc00zbmNIRFBI?=
 =?utf-8?B?MUE5c3BqOTdFR2xob1VEeTNPeVd3UHRrY21YaStBWlkycEtlaEd3R016NG9H?=
 =?utf-8?B?OHNLaElWNlFQeElEUUFpeEJBcHIrUkVjQW1Tck1RRHJWVHE3VHY2b1huMUhm?=
 =?utf-8?B?UDF2QVNnWUMyVnlVN21naDRseVNsdW5ZYXQ0N3BESFN4aTVtM1J4SzhWUVJh?=
 =?utf-8?B?S2tLZGt5SXNMT2pFTEl3cHZ4ZEVZekkyMWVOUmRSMGRJa1l1aFV5RHF3Ym5a?=
 =?utf-8?B?U01GeU1aTkJiWmN5OWZuUkpnT1hWaUxRaXBDeHNZQldHSXdoVEVhQS9yUkN2?=
 =?utf-8?B?bXFiRS8vUjJxaXhiMStpdndTWkw2TnBVOG1uMEVyYWdER3pEc2V2VHRRMjMx?=
 =?utf-8?B?dkVYZ2Z2Ym9jMW9Yb2o0ODl0UC8wclpGN0QrWm1FMXZwWTdnNGxWZHhZbEJ5?=
 =?utf-8?B?V2RuSEtjbDFpM3FZWkc2T2FHTlArZmJ0OTZQUE9qbEhsZlhJQVRiKytXdnlF?=
 =?utf-8?B?bHUrUFRtRHFnZkNKbU5DRjhMNWNNeno0K0ZadlJIM3B0OWNPb05QSDd2NWx4?=
 =?utf-8?B?bCtqbnowRkZoUEpDWlR5N0srdDZpZ2JKM1pGcTE1ODlBMUdyQ1dhZTdUOWJq?=
 =?utf-8?B?Zm80dGZYTWNoMGJVMG1KaEw5T1Q2UGprM0ZER3V2Y09tMW5ESk5TajEvRXlR?=
 =?utf-8?B?ZHQrRE1QekxSU0d4M0ttQ1lObDVBcUsrenBtTGU1THJEVGFnRUN2MDd1U1dp?=
 =?utf-8?B?Z0J5WGJ1U2NCeW1tT2J5UXJkbUdSeDduZDhFTldjbVhmTXFVWjE2SUF6VXcv?=
 =?utf-8?B?VXFrTlYyYVIvZHAzQmxvYXQzc1Q5WHVCeFdmb3ZRQWxPME5ycFpwR211RnVG?=
 =?utf-8?B?V1pEcGxTM0xuUHEzVXY0ZWd1Q1NodENEZGRXZVVXS2RDQmNMMzgzNkRGRXJx?=
 =?utf-8?B?K2RHUzRtZ1h5ZGhiMGpzTFgyelAybFZwYnR3SGlOL1ZreGFlRmcxa1RkbnM2?=
 =?utf-8?B?czc2UkFxdnJnWloyME11STV2OUpDRFE2bFhMRnoyQ1drQnpid1AzR0JMSlBD?=
 =?utf-8?B?NUlxWW5FUk1wNE1pSm03ZENwZHpCd1lESVlWSkZYTXVUdVQzTSs2MlJ4TXVq?=
 =?utf-8?B?bFR4VEtsZEh3WUZYSi9SNVFTZVRnZDRWZUVFTkR0ZjRNUjRDYVMyTXRHQXRh?=
 =?utf-8?Q?OU7nJ/zF1t9rjvrZ+8t9ifmSzEbmp9eoXo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC5D6DBDD5046842AC0CF1DAA7DD8230@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d54a3-a4ac-45c6-735f-08d8b16d6adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 11:31:17.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbPMEViF/bRyxGrK7ztVDFeRhni6tr5ndrpPJ9L4XmY+O0+PChxBjj5fzgpSAnmmPQqhL1iju7IYOJKtn5a9DanWhPwoGMniI5jh0faUvog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2859
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDA1LjAxLjIwMjEgMTI6NDQsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNS0wMS0yMSwgMTI6MjIsIENsYXVk
aXUgQmV6bmVhIHdyb3RlOg0KPj4gTWljcm9jaGlwIFNBTUE3RzUgZGV2aWNlcyBzdXBwb3J0cyBy
dW50aW1lIGNoYW5nZXMgb2YgQ1BVIGZyZXF1ZW5jeS4NCj4+IFRoaXMgaXMgZG9hYmxlIGJ5IGNo
YW5naW5nIENQVVBMTCBmcmVxdWVuY3kgYWxvbmcgd2l0aCBNQ0swIGZyZXF1ZW5jeS4NCj4+IEFs
b25nIHdpdGggdGhpcyBDUFUncyByZWd1bGF0b3IgbXVzdCBiZSBjaGFuZ2VkIHRvIGFjY29tbW9k
YXRlIG5ldw0KPj4gZnJlcXVlbmNpZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICAgICAgfCAgIDkgKw0KPj4gIGRyaXZlcnMvY3B1ZnJl
cS9NYWtlZmlsZSAgICAgICAgICAgICB8ICAgMSArDQo+PiAgZHJpdmVycy9jcHVmcmVxL2NwdWZy
ZXEtZHQtcGxhdGRldi5jIHwgICAyICsNCj4+ICBkcml2ZXJzL2NwdWZyZXEvc2FtYTdnNS1jcHVm
cmVxLmMgICAgfCAzNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICA0
IGZpbGVzIGNoYW5nZWQsIDM4MyBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvY3B1ZnJlcS9zYW1hN2c1LWNwdWZyZXEuYw0KPiANCj4gRGlkIHlvdSB0cnkgdG8g
cmV1c2UgY3B1ZnJlcS1kdCBkcml2ZXI/IEl0IGFscmVhZHkgaGFuZGxlcyBtb3N0IG9mDQo+IHRo
aXMgc3R1ZmYsIHRoZSBvbmx5IHRoaW5nIHlvdSBuZWVkIHRvIGRvIGlzIHRvIG1ha2Ugc3VyZQ0K
PiBjbGtfc2V0X3JhdGUoKSBmb3IgYSBDUFUgbmVlZHMgdG8gaGFuZGxlIGFsbCB0aGUgY2xrIHN0
dWZmIGJlaGluZCB0aGUNCj4gc2NlbmUuDQoNCk5vLCBJIGhhdmVuJ3QgdHJpZWQgaXQgZHVlIHRv
IHRoZSBmYWN0IHRoYXQgdGhlcmUgYXJlIDIgY2xvY2tzIHRoYXQgbmVlZHMNCnRvIGJlIGhhbmRs
ZWQgYW5kIHRob3VnaCBpc24ndCB0aGUgcHJvcGVyIHdheSB0byBkbyB0aGlzIGJlaGluZCB0aGUg
c2NlbmUNCmluIGNsb2NrIGRyaXZlcnMuDQoNCj4gDQo+IFdlIGhhdmVuJ3QgYmVlbiBhY2NlcHRp
bmcgbmV3IGltcGxlbWVudGF0aW9ucyBvZiB0aGUgZHJpdmVycyB3aGljaCBjYW4NCj4gd29yayBq
dXN0IGZpbmUgd2l0aCBjcHVmcmVxLWR0LCBwbGVhc2UgdHJ5IHRvIGFkYXB0IHRvIGl0Lg0KDQpJ
J2xsIHRyeSBpdC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQo+IA0KPiBUaGFua3MuDQo+IA0K
PiAtLQ0KPiB2aXJlc2gNCj4g
