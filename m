Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A804CEE36
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfJGVLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 17:11:34 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:12448
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbfJGVLe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Oct 2019 17:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnIniyHVIwBAAk2H2+oAJBsYiNGR98SUnT4worJZzvXOZIDmQ0/WKKj0joHWKp9FOYn56e9zJ/TcpTasf8iJOHMVOOA3sOGrdjwvXh19aADE9teumDItRNI+ZJlcuvquCLfnyfP/QbPNIUPjbst/TW9CGQnE79YinGGSQJck8Ntmjwu2SeHka/dDjw3GR9pKSM6nBOJnOaYBIrxSTkJR6fNQl0/kRIBqbJLkhM6zgGNfXOcpR4cFJALNv4KcLq3HYYc19KrnrB5UdhsYBNIZ4EP4qyqNSIk1l4IgKdUiSQX3+zxtY811S5NIP/Gcrm5uTxbOq+qsam83VTZU8/EI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXqfz8DKHV7IbkR9wsO091rTdHBmSp+3F3+G71x2Jjs=;
 b=RjK2f+FjrqZVBvcXD/vF6SDrhDw+GJiL3HIU5/29MqnYSKalPSb9IG2BhSdNaUxGVsAG3oLF82/Ql6g6rBTO209sUgQ0LW+5ui/Vl7LV5F89djxh3yVuKXDe03yjhDZ7QFfOtyD5jQUCYp+IR0CM/r1jAR+xcm0GhxA5rG/VJOyUJm7zZ8jYV0RMDSbBqSR20o4Wpl0zt4rsoGaP9g0UeBPW2tJeHp9/pXlNK/iyClwugbLeL8PTAul5BgaP1uBhv4T6u3ky7zJELYMlA/o1sVeudW1fouyYz9fBfbeLEW2WPo7gABwoceeHFjgkDXSEzZLG1qr3fI3rkPwLzIsGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXqfz8DKHV7IbkR9wsO091rTdHBmSp+3F3+G71x2Jjs=;
 b=x2TQWFRY7AvdBwcWBH2WpCXVLnWWEZ5pABKkVABDCtGdklKGd1YaVZoCqM5T1Q3vI3AQKVnDwZO0sdqatukF4/+KDH1esK79dq6gW8eyFTs8CqvBHqtaPjIeqLgE0xbuOOn0er/S+85rueWrerNZI1QW/IYQkkILyPic4kSFErg=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 21:11:31 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 21:11:30 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     Thomas Renninger <trenn@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Renninger <trenn@suse.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq36c/ayGAgACy6gCAB2VngIAElFSAgAOzTQA=
Date:   Mon, 7 Oct 2019 21:11:30 +0000
Message-ID: <f2dc183f-68a5-d98d-7758-bad224578737@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
 <4340017.MFpoU6RDpq@c100> <64022abd-a798-c679-1c1d-eec9b18c4fb2@amd.com>
 <1798336.DyNOivuPDK@c100>
In-Reply-To: <1798336.DyNOivuPDK@c100>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:803:2b::25) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00cf5c08-09ae-4a12-4bed-08d74b6aecb6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2784:|SN6PR12MB2784:
x-microsoft-antispam-prvs: <SN6PR12MB278489B657326C34A40A3806E79B0@SN6PR12MB2784.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(25786009)(26005)(186003)(2906002)(6116002)(3846002)(52116002)(86362001)(7736002)(99286004)(305945005)(66066001)(256004)(66476007)(66946007)(229853002)(64756008)(66446008)(66556008)(14444005)(11346002)(6436002)(6486002)(486006)(446003)(476003)(2616005)(316002)(81166006)(54906003)(4326008)(76176011)(7416002)(53546011)(14454004)(31696002)(102836004)(6512007)(386003)(5660300002)(6506007)(6246003)(31686004)(6916009)(71190400001)(8676002)(81156014)(36756003)(8936002)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGosMbM/SJ+2XjKCYZM4EEAB7saDYG9ZtnJSjy6/Qh5puk0do08AtvptScC4Rd5lXA7npstiZTki77JsxWk0WzbZVepvZH7hjBipOTteygF+NVWqi8+CWUbrBC0DJccdNktKc+1Te4PaXHu6XSykTiwHKrlTvXURCMfU7ChzNd3CpFzmAefE0cyfOsuNNA5hsRbKbIrXQmooHzW8J5YcLKVJAI7zsBCG5oBbGfNhST7suhWHyAcha15R8g9H7joyM8w02me9UVpD86wNH5EFJaUIEc4f3MTjHl40r5y8XDuzAn6k07d4OWfBB+kHuzw9rJNtsCg1yMEYs2v5QIc6mR1Vav6akll56DumpKO3OwDhKVjp+b1A5Aln+BhyKFVP167UX1hL2YPhmr6lUaAy1de+OnID1hw8kEYgsk572LQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBBF6A5A3EF6D94A8DD7A6B2DABDF3F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cf5c08-09ae-4a12-4bed-08d74b6aecb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 21:11:30.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ItynOx3RFmdi8hRcOmpsaAb2HRP8+6ZA2I478itar79fafNvIJD7+KCzS51LNZamN+ipa7uqigTA2mAJkjb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTAvNS8yMDE5IDc6NDAgQU0sIFRob21hcyBSZW5uaW5nZXIgd3JvdGU6DQo+IEhpLA0KPg0K
PiBPbiBXZWRuZXNkYXksIE9jdG9iZXIgMiwgMjAxOSA0OjQ1OjAzIFBNIENFU1QgTmF0YXJhamFu
LCBKYW5ha2FyYWphbiB3cm90ZToNCj4+IE9uIDkvMjcvMTkgNDo0OCBQTSwgVGhvbWFzIFJlbm5p
bmdlciB3cm90ZToNCj4+DQo+Pj4gT24gRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMTkgNjowNzo1
NiBQTSBDRVNUICBOYXRhcmFqYW4sIEphbmFrYXJhamFuDQo+Pj4gd3JvdGU6DQo+Pj4+IE9uIDkv
MTgvMjAxOSAxMTozNCBBTSwgTmF0YXJhamFuLCBKYW5ha2FyYWphbiB3cm90ZToNCj4gICANCj4+
IE9uIGEgMjU2IGxvZ2ljYWwtY3B1IFJvbWUgc3lzdGVtIHdlIHNlZSBDMCB2YWx1ZSBmcm9tIGNw
dXBvd2VyIG91dHB1dCBnbw0KPj4gZnJvbSAwLjAxIHRvIH4oMC4xIHRvIDEuMDApDQo+Pg0KPj4g
Zm9yIGFsbCBjcHVzIHdpdGggdGhlIDFzdCBwYXRjaC4NCj4+DQo+PiBIb3dldmVyLCB0aGlzIGdv
ZXMgZG93biB0byB+MC4wMSB3aGVuIHdlIHVzZSB0aGUgUkRQUlUgaW5zdHJ1Y3Rpb24NCj4+ICh3
aGljaCBjYW4gYmUgdXNlZCB0byBnZXQNCj4+DQo+PiBBUEVSRi9NUEVSRiBmcm9tIENQTCA+IDAp
IGFuZCBhdm9pZCB1c2luZyB0aGUgbXNyIG1vZHVsZSAocGF0Y2ggMikuDQo+IEFuZCB0aGlzIG9u
ZSBvbmx5IGV4aXN0cyBvbiBsYXRlc3QgQU1EIGNwdXMsIHJpZ2h0Pw0KDQoNClllcy4gVGhlIFJE
UFJVIGluc3RydWN0aW9uIGV4aXN0cyBvbmx5IG9uIEFNRCBjcHVzLg0KDQoNCj4NCj4+IEhvd2V2
ZXIsIGZvciBzeXN0ZW1zIHRoYXQgcHJvdmlkZSBhbiBpbnN0cnVjdGlvbiAgdG8gZ2V0IHJlZ2lz
dGVyIHZhbHVlcw0KPj4gZnJvbSB1c2Vyc3BhY2UsIHdvdWxkIGEgY29tbWFuZC1saW5lIHBhcmFt
ZXRlciBiZSBhY2NlcHRhYmxlPw0KPiBQYXJhbWV0ZXIgc291bmRzIGxpa2UgYSBnb29kIGlkZWEu
IEluIGZhY3QsIHRoZXJlIGFscmVhZHkgaXMgc3VjaCBhIHBhcmFtdGVyLg0KPiBjcHVwb3dlciBt
b25pdG9yIC0taGVscA0KPiAgICAgICAgIC1jDQo+ICAgICAgICAgICAgIFNjaGVkdWxlICB0aGUg
IHByb2Nlc3MgIG9uIGV2ZXJ5IGNvcmUgYmVmb3JlIHN0YXJ0aW5nIGFuZCBlbmRpbmcNCj4gbWVh
c3VyaW5nLiAgVGhpcyBjb3VsZCBiZSBuZWVkZWQgZm9yIHRoZSBJZGxlX1N0YXRzIG1vbml0b3Ig
d2hlbiBubyBvdGhlciBNU1INCj4gYmFzZWQgbW9uaXRvciAoaGFzIHRvIGJlIHJ1biBvbiB0aGUg
Y29yZSB0aGF0IGlzIG1lYXN1cmVkKSBpcyBydW4gaW4gcGFyYWxsZWwuDQo+IFRoaXMgaXMgdG8g
d2FrZSB1cCB0aGUgcHJvY2Vzc29ycyBmcm9tIGRlZXBlciBzbGVlcCBzdGF0ZXMgYW5kIGxldCB0
aGUga2VybmVsDQo+IHJlYWNjb3VudCBpdHMgY3B1aWRsZSAoQy1zdGF0ZSkgaW5mb3JtYXRpb24g
YmVmb3JlIHJlYWRpbmcgdGhlIGNwdWlkbGUgdGltaW5ncw0KPiBmcm9tIHN5c2ZzLg0KPg0KPiBC
ZXN0IGlzIHlvdSBleGNoYW5nZSB0aGUgb3JkZXIgb2YgeW91ciBwYXRjaGVzLiBUaGUgMm5kIGxv
b2tzIHJhdGhlciBzdHJhaWdodA0KPiBmb3J3YXJkIGFuZCB5b3UgY2FuIGFkZCBteSByZXZpZXdl
ZC1ieS4NCg0KDQpUaGUgUkRQUlUgaW5zdHJ1Y3Rpb24gcmVhZHMgdGhlIEFQRVJGL01QRVJGIG9m
IHRoZSBjcHUgb24gd2hpY2ggaXQgaXMgDQpydW5uaW5nLiBJZiB3ZSBkbw0KDQpub3Qgc2NoZWR1
bGUgaXQgb24gZWFjaCBjcHUgc3BlY2lmaWNhbGx5LCBpdCB3aWxsIHJlYWQgdGhlIEFQRVJGL01Q
RVJGIA0Kb2YgdGhlIGNwdSBpbiB3aGljaCBpdCBydW5zL21pZ2h0DQoNCmhhcHBlbiB0byBydW4g
b24sIHdoaWNoIHdpbGwgbm90IGJlIHRoZSBjb3JyZWN0IGJlaGF2aW9yLg0KDQoNCj4NCj4gSWYg
eW91IHN0aWxsIG5lZWQgYWRqdXN0aW5ncyB3aXRoIC1jIHBhcmFtLCB0aGV5IGNhbiBiZSBkaXNj
dXNzZWQgc2VwYXJhdGVseS4NCg0KDQpUaGUgLWMgcGFyYW1ldGVyIGNhdXNlcyBjcHVwb3dlciB0
byBzY2hlZHVsZSBpdHNlbGYgb24gZWFjaCBvZiB0aGUgY3B1cyANCm9mIHRoZSBzeXN0ZW0gaW4g
YSBsb29wLg0KDQpBZnRlciB0aGUgbG9vcCB0aGUgY3B1cG93ZXIgc3RhcnRzIHRoZSBtZWFzdXJl
bWVudCBvZiBBUEVSRi9NUEVSRiBvZiANCmVhY2ggY3B1Lg0KDQpUaGlzIGRvZXNuJ3Qgb2ZmZXIg
dGhlIGJlaGF2aW9yIG5lZWRlZCB0byB1c2UgUkRQUlUsIHdoaWNoIHJlcXVpcmVzIA0KY3B1cG93
ZXIgdG8gZXhlY3V0ZSBvbiB0aGUgY3B1DQoNCndob3NlIEFQRVJGL01QRVJGIHZhbHVlcyB3ZSBh
cmUgaW50ZXJlc3RlZCBpbi4NCg0KDQpUaGFua3MsDQoNCkphbmFrDQoNCg0KPiBJdCB3b3VsZCBh
bHNvIGJlIG5pY2UgdG8gbWVudGlvbiBpbiB3aGljaCBjYXNlIGl0IG1ha2VzIHNlbnNlIHRvIHVz
ZSBpdCBpbiB0aGUNCj4gbWFucGFnZSBvciBhZHZhbnRhZ2VzL2RyYXdiYWNrcyBpZiB5b3UgZG9u
J3QuDQo+DQo+IFRoYW5rcyENCj4NCj4gICAgICBUaG9tYXMNCj4NCj4NCj4NCg==
