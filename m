Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAF4B80B2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 07:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiBPG3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 01:29:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBPG33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 01:29:29 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50073.outbound.protection.outlook.com [40.107.5.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B811A275E
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 22:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej+LPLT8f+kTno4vuveO3Jd5Xmk092+gtEw0W9LHsWbszZWAz2dfSLcvV3PC6M4T7TO2My2AcdoNR1WkKD/zL1gv4LN0pwlZkYFkHA1oQJ798ld2q8Yi2Ro0aOvSFbLkq1NDLpaX3EGkzMMA0AS/XX1cWAd7Y0BhVDGw7alih8DBWqnRpYle82TG60NxIZPZguKBEvSEW2tA/pCzThIzw4qqVT9mhIeat1Z52QPIZcaYtGm4n/QYvlx6+6eDLSarmd9Le7ouZVxp6Pjn5iccG2bftNR7hSuMMdOfb1iJN/bPS3zXFcCsm+2KO8OjdeCdi7TYNfpnmf5RfOEHRIVJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb465T3a74yhqNyw2e4/n+A4kVR4lByfqYn+i0R6VVw=;
 b=a6JeiESq3i9vbmvoM0AdQXoQOczTYRL2G3DXwsjNYGW6Ubi9J/Rwvot2/KQS+MCP/Fp7a5u1NLMOhT/I8Q/WnmQnOVnJac1UhYhpHNjh4+0zDacwjUJTLTmdlBWsAT6mL0TCxJ1E0/FVRIHJ4DnktXSRgdYCfvlNkmEqf234+cmtQmxrh1yoLuXoFq8YUVruID0ym63q9NFiMo4CWyTM/YCH90sfPv0y+sDzfRmEr41Sw022znQPaJhu9hLrI78YeaHbK42fSvqseOjXr1l8KochTB0dV+dCuh1l3lsgwRhaVq12JdSjOkg4lXQmvCVS6yViBi++72oKvW557+gLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb465T3a74yhqNyw2e4/n+A4kVR4lByfqYn+i0R6VVw=;
 b=s5fck85YuHwLAqZnOL80SRa1wSvOG17oFo8t+GY/iMlenU5UHqqFZGQsGAfE9uInzWN1KUqu42xN0Dk6Lep8mk8lcNcn7NNjmIx74bJbZPM24o5eOQ/oKlVhrSwojm81w/X3+zZWtzrlIP3HWcgywTE9ZKOWKdVNTJY8kX8y7Mg=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 VE1PR03MB5566.eurprd03.prod.outlook.com (2603:10a6:803:122::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 06:28:38 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4%6]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 06:28:38 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH 1/6] power: supply: ab8500: Standardize maintenance
 charging
Thread-Topic: [PATCH 1/6] power: supply: ab8500: Standardize maintenance
 charging
Thread-Index: AQHYGSMdqDb0RF6TEEeT47NHTIy2z6yH9aUAgAimqgCABS46gA==
Date:   Wed, 16 Feb 2022 06:28:38 +0000
Message-ID: <4167f7a7-d806-e48b-b46f-63e802080de1@fi.rohmeurope.com>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
 <20220203171633.183828-2-linus.walleij@linaro.org>
 <d49e08be-d24a-6cc7-21e5-c568015b9076@fi.rohmeurope.com>
 <CACRpkdbZ4GSWVr+o1+76-FpiQiC4Ru9OEWrG3Y=tCjV_MVYJBw@mail.gmail.com>
In-Reply-To: <CACRpkdbZ4GSWVr+o1+76-FpiQiC4Ru9OEWrG3Y=tCjV_MVYJBw@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa1de8f-8853-413c-968c-08d9f1159171
x-ms-traffictypediagnostic: VE1PR03MB5566:EE_
x-microsoft-antispam-prvs: <VE1PR03MB556605572BC83B41971508CFAD359@VE1PR03MB5566.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXK1DlnbLLMCFz1y+AU3PSr8qCFSn5SwF/TDiffv1Uvn2hqTcvbxPxD/ZXlyE1v0ad7nebRXZCOp5FGfxQSQBOS1OneStKVXjQMlfSHT0iKkcHE1DgDyBRhV72vvft/+Xll2ogbqgM1BdHZuh5xvLQ+Ryi2ZvSoSZK9KgMW5vc8C5OluudzZbkWQk/S+I5c1nphV86TIqwt0Y+qdaZEQ6VPNtISWMQqa29l9mAmY4+VY2gH7wcIAf+ylxgIGFxZUmHI6YINI+Q7hHmKuCjAzoF/LkkNb2HuWqAdPXW7VL5ssvqDr29Vbwimi2iOB4JRYgcxXrb1Ou4ZqiDKPowkJzi8gyIE8uHslb9n+9konJWs6T7APpQjOjfE8Sp8u0g1RRgYKHmgTDiTGgx2RWbXB2WIptZwqSjjT0eF2cqcIlGvPzdr8PcTAA2HXsntl/4NtKyrcbbwHroK1VEqVCvHRk3aFExg0m+/JhoWFRC9evi5/BOEReawetMQxlP/bZoKdtEfBjXCUrVEoIqH6LMx5opFPhSDAoFNnIJiFbw66kxaFCT9BxLt/h/qOgLI29f8GNmsV2KASbxVCfUr9LSZkwY32p2JQVPMM/7cDo+I3Z/i7f9SqC+WJ47J60DHmXvEQL08eEBEQVW/PvZM4XU9OB0ytKebO922hVGiDaT/osvWYF6YcJqWHqAE4v2JLJdcEOqIxqZebRkryxBcpCMnYrz9Ct2iyibhHLTlSEvTE6Y10zDMYZ5IM+/CGsbh3CsYzYr2wRRbJKa0PynOIptWqGUsURpkrBVOAUJTCIbslffGtfOIvxbqOsLt12sAbO/xj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(8936002)(316002)(53546011)(66476007)(6506007)(66556008)(6512007)(86362001)(76116006)(54906003)(64756008)(4326008)(66946007)(8676002)(31696002)(83380400001)(5660300002)(71200400001)(6916009)(6486002)(508600001)(38070700005)(2616005)(31686004)(2906002)(186003)(122000001)(38100700002)(448074003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnpqSXpkSlJSek1ycnVSZGVRR21IMmtiVDN4RG5hSE5aN2x2Q0ZzSGFFa09G?=
 =?utf-8?B?RFk2N01ZeERRRWRhMnptWE16S1VUSlVhQStkWWMrQ1FIaDcrSHdaNmQ2cHg5?=
 =?utf-8?B?OCtONm5waFdkc09ybTNiMlNoUktkM3duUXZoNHFIbmxpOXRMZTVKS2xsRDF0?=
 =?utf-8?B?RGNtSW50aGpIOThIRGswbWwraWM1SkJxRWxiVTJLV2dCOUl4Q3RwYkd2cE1u?=
 =?utf-8?B?Wm5OK0FrMWo3U09FdkRtT0dHNzVuOEdXRGJnN1hiOUI3MHJ4Z2JLSi9sY1hD?=
 =?utf-8?B?UEFxKzd1dHlQaWlyUitQYU0yTDcwQmVPMGtwMnZjRUFidXVwUXloQmlwNFhM?=
 =?utf-8?B?WSt5MUlJb3VZeEZjY0ZRMWNuRGR5Zi9Pd1EzOFlWN1VRMkZScUpKWnNabEsv?=
 =?utf-8?B?LzdiQktUNWZ0Y3NjUVpHa0MzeENOS0pqazFUVlR4S1JXWk1RY0tEc3l4VXFl?=
 =?utf-8?B?WndZdkVnTnI1enFaWGg1c3ZETEF5d3V3YjhLamFicDg2b1FpblV4RnhPSExX?=
 =?utf-8?B?ZjNxTjdVa3FleWhpenpPeUxhSTE0TjV6ZkRDTkFqS3JSd3hmTU5VeEljQkFy?=
 =?utf-8?B?bDkwdW9MMUVTS3RibElPcmtRT25QRS9nVGRnU0VTcjVPSGJycGs0eTNKVkxY?=
 =?utf-8?B?RXZ1QXgxOG9MQitRbC9rTnNhOUxXOW9JV0M2RTdjT2VIeUZhdEVaeDBXcEdZ?=
 =?utf-8?B?NFJLMEZ3K2RNclptYXhFQzIzb1hkNkhORS9CaUZYWHJBZ3VKK1pXOElaSGlv?=
 =?utf-8?B?RFdhMCtOVmcyRFVUemNQdTNnaW9nMTFZMVpvMGZFU214TmZ1UnZYUm95aWM2?=
 =?utf-8?B?ZWh2U2JyQnpCZXVRZHlnNXdYekNDSmw3OFo2WDBKNzh1b2xFS1pDQXBFNzBG?=
 =?utf-8?B?VE92K3VOYW1nNExUajlTRHZ5a0NHV1FnUlAvdFVQQVNvYUJNcExDNlc2RU9E?=
 =?utf-8?B?UWExcER0NWhtSWk3Z0xmL2NISHNnSk9zbUdSaEJiVXBsZVdja3BNejk1OGVS?=
 =?utf-8?B?d1JNU0h3Z3VUemEzd2JQTUxpZXFleStLdU9vVkxQVS9OaWhIYVFDdGdPN25M?=
 =?utf-8?B?SHVNTHpNWlpKa0hYT1pOSGJ1bHZnZjM1QUVLekJuVHUyUUU4UFBNOEhTTTFo?=
 =?utf-8?B?anJweStDeWpLY0lUSmVJaW9HTy9WSEwrc0ppMGZWUlBYRTM1dld5OHlyMWw1?=
 =?utf-8?B?TGlaekttK0ttS1pKbkFGMTE5bDllMy9wQXZmMkx2OGFYd2NqYndONFNRNlgv?=
 =?utf-8?B?UXFGVVU4SWxXdWFkcmoyZm5od2RCVTVsUGxLRldKTHZhMjlUNFNMOUhTTmlG?=
 =?utf-8?B?WFJ3Vmp3S29NUVFnZjRybFczTmovOFNqVUkvS2hOQzIzN0dRSXlxMkcrbDBR?=
 =?utf-8?B?RjVpL1ZvRlJJN1BCamcrOExWVHkyOHRJcXZaRXBUKzdaOU5NeVlyRUJPY3lC?=
 =?utf-8?B?TEExZXNTRkdQQlV3K2ZzOXpYY2tVZ0tOVlFMMnZsMENtam1YcW9PVWMrbWkz?=
 =?utf-8?B?eTFZSHczSEhoL0pjZ1U5cG9sajAzK1pOSzRGUUdmNW5SeER3cXFKczBsLy8x?=
 =?utf-8?B?L0R6bk9CcWJxY3E0UUdhUTB3TjNtRTJrQjBsL1YvNUFZS2ZnZWlCU3orR0tn?=
 =?utf-8?B?d1lwcUhUd0t6aW9lQ0c2NjAzZFM4alhRNFVldUpaRm83RUFMbnJQdk55OStV?=
 =?utf-8?B?RlNoc2szbVBjdjNoU2pEMWVaVitSTnpmY0xBMzFibjR3czUrZ1ByeENoS3hC?=
 =?utf-8?B?T3BTWlJjMjdEaEpQR1VmWXhtZXV0WTBpRDZFbU5KMUJkcWtOdW5PaC9pYU1Z?=
 =?utf-8?B?YTNTYjFxNDRiaTN3ZzR2RkV6VnQrZ2VvU3M3eTFYWkZmVmdtbU9wMWMwdDli?=
 =?utf-8?B?blpqc3NrRUZxY3pHaFBtd1Zmd254YzhtSVk1ME9jTXlLWU5tbVNiOWU2MW1L?=
 =?utf-8?B?UW9aMDVnL1l6T054NGl3MDdwZ0Z6TEtNdS93UlRMb2pmS3krS2hyemovTmo0?=
 =?utf-8?B?S0lRZ1RNeDlxQXErdE9HNUtaS2VSMURUWEFEWkMzV0oxeHFTNmpIZFJsTnFB?=
 =?utf-8?B?SzdhcWpPaDRkTEtVZWt1amxudVEzT1Q3aVBnUklxSnhXeFQ5bUQzUjZISHhr?=
 =?utf-8?B?bmxvZTh3YkZGNnl1S1FwK0w3cUN2UWJOL1BIVUVNcHN4dWlqQmplYjlXM0tt?=
 =?utf-8?B?cjVHUXpoci9nZzNkVWpVUnlEMHBxaUNSRDhNUFFKQmdUaHNMeDVIdkx5aWZh?=
 =?utf-8?B?d0VWOTZCOG51VTdtOVRHSlNJdUZsWXlPQ0FFSDd4YXYzNkxHNHVJQitoM0ZG?=
 =?utf-8?B?Z014bFNFekpDYk5LRWg2MUpKbWxLcWd5WXVxcWVxQkpXRmtucTJqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F7C5701E7F528469DDC067310447483@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa1de8f-8853-413c-968c-08d9f1159171
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 06:28:38.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtbIUrNBkd50LcGZLniafuA5YX5xbwrP4keG/5P9PHXNsyntUZhvOmUwrO6bF8F+jPmwoidxdTZ8QL+/eQTqF4ICDyehI+HD9MRdqfH4q5admsCyuNqntkurNbVYSAYg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5566
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMi8xMy8yMiAwMToyMSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gTW9uLCBGZWIgNywg
MjAyMiBhdCAxMjoxNSBQTSBWYWl0dGluZW4sIE1hdHRpDQo+IDxNYXR0aS5WYWl0dGluZW5AZmku
cm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+PiBAQCAtMTI0LDcgKzEzMyw2IEBAIHN0cnVj
dCBhYjg1MDBfYm1fZGF0YSBhYjg1MDBfYm1fZGF0YSA9IHsNCj4+DQo+PiBzdGF0aWMgPw0KPiAN
Cj4gQ291bGQgYmUsIGJ1dCBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoLCBhbmQgZ2V0cyBkZWxl
dGVkIGluIHRoaXMgc2VyaWVzIDopDQoNCk9oLiBTb3JyeSBmb3IgdGhlIG5vaXNlLiBJIG1pc3Jl
YWQgdGhlIHBhdGNoIDopDQoNCj4gDQo+IEZpeGVkIHRoZSBvdGhlciBzdGF0aWMuDQo+IA0KPj4g
Rm9sbG93aW5nIGlzIG5vdCBleHBlY3RlZCB0byBiZSBkb25lIGZvciB0aGlzIHBhdGNoIHNlcmll
cyAtIGJ1dCBJIHRoaW5rDQo+PiB3ZSBzaG91bGQgdHJ5IHRvIGVuaGFuY2UgdGhlIHBvd2VyLXN1
cHBseSBjb3JlIHRvIHByb3ZpZGUgc29tZSBtb3JlDQo+PiBmcmFtZXdvcmsgc3VwcG9ydC4gRm9y
IGV4YW1wbGUgdGhpcyBtYWludGVuYW5jZSBjaGFyZ2luZyBjb3VsZCBiZSB0YWtlbg0KPj4gY2Fy
ZSBvZiBieSB0aGUgY29yZSg/KSBFZywgZHJpdmVycyB3b3VsZCBvbmx5IHJlZ2lzdGVyIHRoZSBj
YWxsYmFja3MgZm9yDQo+PiBzZXR0aW5nIGNoYXJnaW5nIGN1cnJlbnRzL3ZvbHRhZ2VzIC0gYW5k
IHBvdGVudGlhbGx5IGV2ZW50IG9mIHJlcXVlc3RpbmcNCj4+IHRoZSBtYWludGVuYW5jZSBjaGFy
Z2luZyAodW5sZXNzIGNvcmUgY291bGQgZGV0ZWN0IHRoaXMgZm9yIHRoZSBkcml2ZXJzKS4NCj4+
DQo+PiBJIHRoaW5rIGJ1bmNoIG9mIGRyaXZlcnMgZG8gcG9sbGluZyBvciB0aW1lcnMgb3IgYXQg
bGVhc3QgSVJRIGJvdHRvbQ0KPj4gaGFsdmVzIGZvciBmdWVsLWdhdWdpbmcgZXRjLiBGb3IgZXhh
bXBsZSB0aGUgbGFzdCBzZXJpZXMgZnJvbSBIYW5zIHNlZW1zDQo+PiB0byBuZWVkIHBlcmlvZGlj
IGNvdWxvbWIgY291bnRlciBwb2xsaW5nIGZvciBmdWVsLWdhdWdpbmcuIFBlcmhhcHMgd2UNCj4+
IGNvdWxkIHRyeSBtb3ZpbmcgdG8gZGlyZWN0aW9uIG9mIGFkZGluZyBzb21lIGNvbW1vbiAibG9v
cA0KPj4gaW1wbGVtZW50YXRpb24iIHRvIHRoZSBjb3JlIC0gYW5kIGFsbG93IGRyaXZlcnMganVz
dCByZWdpc3RlciByZXF1aXJlZA0KPj4gY2FsbGJhY2tzPyBJIGJlbGlldmUgd2UgY291bGQgc2lt
cGxpZnkgbWFueSBvZiB0aGUgZHJpdmVycy4NCj4gDQo+IFdlIGhhdmUgdGhpcyBsb29wIGluIGFi
ODUwMF9jaGFyZ2FsZy5jLCBpdCdzIHJhdGhlciBhIHN0YXRlIG1hY2hpbmUsDQo+IGFiODUwMF9j
aGFyZ2FsZ19hbGdvcml0aG0oKSBpcyBjYWxsZWQgcGVyaW9kaWNhbGx5IGZyb20NCj4gYWI4NTAw
X2NoYXJnYWxnX3BlcmlvZGljX3dvcmsoKSB3aGljaCBqdXN0IGNvbnN0YW50bHkNCj4gcXVldWVz
IGl0c2VsZi4gU28gaXQgaXMgYSBIWi1iYXNlZCBsb29wLg0KDQpZZXAuIEkgaGF2ZSBhIGZlZWxp
bmcgdGhlcmUgYXJlIGEgZmV3IGRyaXZlcnMgd2hpY2ggZG8gaGF2ZSBhIA0KJ3N0YXRlLW1hY2hp
bmUnIGxvb3AgZm9yIHBvbGxpbmcgc29tZXRoaW5nIGFuZCB0aGVuIGtpY2tpbmcgYWN0aW9ucyAN
CmJhc2VkIG9uIHRoaXMuIEl0J2QgYmUgZ3JlYXQgaWYgd2UgY291bGQgZmluZCBzb21lIGNvbW1v
biBzZXQgb2Ygc3RhdGVzLg0KDQpJIHRoaW5rIHRoaXMgc2FtZSBsb29wIGNvdWxkIGJlIHVzZWQg
Zm9yIGZ1ZWwtZ2F1Z2UgKGNvdWxvbWIgY291bnRlcikgDQpwb2xsaW5nLiBJdCBzZWVtcyB0byBt
ZSB0aGF0IGlzIGFsc28gbmVlZGVkIGJ5IHNvbWUgY2hhcmdlcnMuIFRoaXMgaXMgDQphbHNvIHdo
eSBJIG9yaWdpbmFsbHkgc2VudCBvdXQgdGhlIFJGQyBmb3Igc2ltcGxlLWdhdWdlLg0KDQpJIHdv
bmRlciBpZiB3ZSBjb3VsZCBoYXZlIGEgdGhyZWFkIGluIGNvcmUgd2hpY2ggd291bGQgcnVuIGF0
IGdpdmVuIA0KaW50ZXJ2YWwgKG9yIHVwb24gYSByZXF1ZXN0KSAtIGFuZCBjaGVjayB0aGUgc3Rh
dGUgKyBjYWxsIHN0YXRlIHNwZWNpZmljIA0KZHJpdmVyIGNhbGxiYWNrcyBpZiBzdWNoIGFyZSBy
ZWdpc3RlcmVkICYmIHRyaWdnZXIgdGhlIGNoYW5nZSANCm5vdGlmaWNhdGlvbnMgaWYgc3RhdGUg
Y2hhbmdlIHdhcnJhbnRzIHN1Y2guDQoNCkkgZ3Vlc3MgdGhpcyBpcyBzb21ld2hhdCBhbWJpdGlv
dXMgLSBidXQgbWF5YmUgaXQgd291bGQgYmUgdGhlIGRpcmVjdGlvbiANCnRvIGtlZXAgaW4gbWlu
ZC4gVG8gbXkgdW5lZHVjYXRlZCBleWVzIGl0IHNlZW1zIHRoZSBjaGFyZ2VyL2Z1ZWwtZ2F1Z2Ug
DQpkcml2ZXJzIGFyZSBsYXJnaXNoIC0gYW5kIG1hbnkgb2YgdGhlbSBhcmUgaW1wbGVtZW50aW5n
IHNvbWUgc29ydCBvZiANCidzdGF0ZS1tYWNoaW5lJyB3aXRoIHNvbWV3aGF0IHNpbWlsYXIgbG9n
aWMuDQoNCkkgdGhpbmsgd2UgbWlnaHQgYmUgYWJsZSB0byBhbGxvdyByZWdpc3RlciBhIGNhbGxi
YWNrIGZvciAnY2hlY2tpbmcgdGhlIA0KY3VycmVudCBzdGF0ZScgKGZvciBzdGF0ZSBwb2xsaW5n
IC0gdGhpcyBjb3VsZCBiZSB1c2VkIGJ5IGNvcmUpIC0gYW5kIGEgDQpmdW5jdGlvbiB3aGljaCBj
b3VsZCBiZSBjYWxsZWQgdG8gdHJpZ2dlciBydW5uaW5nIHRoZSBsb29wICdwcmVtYXR1cmVseScg
DQpmb3IgZXhhbXBsZSBmcm9tIElSUS4NCg0KQWZ0ZXIgdGhhdCB3ZSB3b3VsZCBuZWVkIHRoZSB3
ZWxsIGRlZmluZWQgc2V0IG9mIHN0YXRlcyArIGNhbGxiYWNrcyAtIA0Kd2hpY2ggSSB0aGluayBp
cyB0aGUgaGFyZCBwYXJ0LiBJIGd1ZXNzIHRoZSB3YXkgdG8gZ28gY291bGQgYmUgc3RhcnRpbmcg
DQpmcm9tIHNvbWUgc2ltcGxlIElDIC0gYW5kIGFkZGluZyBtb3JlIHN0YXRlcy9jYWxsYmFja3Mg
d2hlbiBtb3JlIA0KY29tcGxpY2F0ZWQgc3RhdGUgbWFjaGluZXMgZ2V0cyB0byBiZSBzdXBwb3J0
ZWQ/DQoNCj4gDQo+IHdoaWNoIEkgdGhpbmsgaXMgYSBnb29kIG1vZGVsIGJlY2F1c2UgbWFueSBj
aGFyZ2luZyBjaGlwcyBhcmUNCj4gZXNzZW50aWFsbHkgc3RhdGUgbWFjaGluZXMgd3JpdHRlbiBp
biB2aGRsLCBzbyB3ZSBjYW4gbWltaWMgdGhlc2UNCj4gd2l0aCBjb2RlLg0KPiANCj4gVGhpcyBj
aGFyZ2VyIGhhcyB0aGVzZSBzdGF0ZXM6DQo+IA0KPiBlbnVtIGFiODUwMF9jaGFyZ2FsZ19zdGF0
ZXMgew0KPiAgICAgICAgICBTVEFURV9IQU5ESEVMRF9JTklULA0KPiAgICAgICAgICBTVEFURV9I
QU5ESEVMRCwNCj4gICAgICAgICAgU1RBVEVfQ0hHX05PVF9PS19JTklULA0KPiAgICAgICAgICBT
VEFURV9DSEdfTk9UX09LLA0KPiAgICAgICAgICBTVEFURV9IV19URU1QX1BST1RFQ1RfSU5JVCwN
Cj4gICAgICAgICAgU1RBVEVfSFdfVEVNUF9QUk9URUNULA0KPiAgICAgICAgICBTVEFURV9OT1JN
QUxfSU5JVCwNCj4gICAgICAgICAgU1RBVEVfTk9STUFMLA0KPiAgICAgICAgICBTVEFURV9XQUlU
X0ZPUl9SRUNIQVJHRV9JTklULA0KPiAgICAgICAgICBTVEFURV9XQUlUX0ZPUl9SRUNIQVJHRSwN
Cj4gICAgICAgICAgU1RBVEVfTUFJTlRFTkFOQ0VfQV9JTklULA0KPiAgICAgICAgICBTVEFURV9N
QUlOVEVOQU5DRV9BLA0KPiAgICAgICAgICBTVEFURV9NQUlOVEVOQU5DRV9CX0lOSVQsDQo+ICAg
ICAgICAgIFNUQVRFX01BSU5URU5BTkNFX0IsDQo+ICAgICAgICAgIFNUQVRFX1RFTVBfVU5ERVJP
VkVSX0lOSVQsDQo+ICAgICAgICAgIFNUQVRFX1RFTVBfVU5ERVJPVkVSLA0KPiAgICAgICAgICBT
VEFURV9URU1QX0xPV0hJR0hfSU5JVCwNCj4gICAgICAgICAgU1RBVEVfVEVNUF9MT1dISUdILA0K
PiAgICAgICAgICBTVEFURV9PVlZfUFJPVEVDVF9JTklULA0KPiAgICAgICAgICBTVEFURV9PVlZf
UFJPVEVDVCwNCj4gICAgICAgICAgU1RBVEVfU0FGRVRZX1RJTUVSX0VYUElSRURfSU5JVCwNCj4g
ICAgICAgICAgU1RBVEVfU0FGRVRZX1RJTUVSX0VYUElSRUQsDQo+ICAgICAgICAgIFNUQVRFX0JB
VFRfUkVNT1ZFRF9JTklULA0KPiAgICAgICAgICBTVEFURV9CQVRUX1JFTU9WRUQsDQo+ICAgICAg
ICAgIFNUQVRFX1dEX0VYUElSRURfSU5JVCwNCj4gICAgICAgICAgU1RBVEVfV0RfRVhQSVJFRCwN
Cj4gfTsNCj4gDQo+IFRoZSBfSU5JVCBzdGF0ZXMgYXJlIGp1c3QgYSBuYW1lIGZvciB0aGUgZmly
c3QgZW50cnkgb2YgYSBuZXcgc3RhdGUuDQo+IA0KPiBGb3IgZWFjaCBzdGF0ZSB0aGVyZSBpcyBv
bmUgb3IgdHdvIGNhbGxiYWNrcyB0byBjb2RlIGhhbmRsaW5nIHRoZQ0KPiBoYXJkd2FyZS4NCj4g
DQo+IFRoaXMgSSB0aGluayBjb3VsZCBiZSBjZW50cmFsaXplZCwgYnV0IEkgZG9uJ3QgaGF2ZSB0
aGUgcGljdHVyZSBvZiB3aGF0DQo+IGFsbCBzb2Z0d2FyZSBjb250cm9sbGVkIGNoYXJnZXJzIGNv
dWxkIG5lZWQ/DQoNCk5vciBkbyBJLiBBbmQgSSBkb3VidCBhbnlvbmUgY2FuIGRlZmluZSBwZXJm
ZWN0IGdlbmVyaWMgc2V0IG9mIHN0YXRlcy4gSSANCmd1ZXNzIHRoYXQgaWYgd2UgZGlkIHN0YXJ0
IGZyb20gc29tZSBzZXQgb2Ygc3RhdGVzIC0gdGhlbiB3ZSB3b3VsZCBoYXZlIA0Kc29tZSBzZXQg
dG8gcmVmaW5lIHdpdGggbmV3IGNoYXJnZXJzIDopIEkndmUgYWx3YXlzIGxpa2VkIHRoZSBhcHBy
b2FjaCANCndoZXJlIG9uZSBzdGFydHMgYnkgZG9pbmcgc29tZXRoaW5nIHRoYXQgc2VydmVzIGEg
cHVycG9zZSAtIGFuZCB0aGVuIA0KcmV3cml0ZXMgaXQgYXMgbmVlZGVkIDspDQoNCiAgKEFsc28g
c2hvcnQgb24gdGltZSByaWdodA0KPiBub3cgYnV0IHRoYXQgd2lsbCBjaGFuZ2UgSSBzdXBwb3Nl
LikNCg0KVWguIEkga25vdyB0aGUgZmVlbGluZy4gVGhhdCBpcyBhbHNvIHdoeSB0aGUgc2ltcGxl
LWdhdWdlIFJGQyBnZXRzIG5ldyANCnZlcnNpb25zIG9ubHkgZXZlcnkgbm93IGFuZCB0aGVuLi4u
IEFmdGVyIHRoZSBsYXRlc3QgY29tbWVudHMgZnJvbSB5b3UgSSANCnRyaWVkIHRvIHNlZSBpZiBJ
IGNvdWxkIGZpbmQgc29tZSBzcGxpbmUgaW1wbGVtZW50YXRpb24gdGhhdCBjb3VsZCBiZSANCnVz
ZWQgaW4ta2VybmVsIC0gYW5kIHRoZW4gSSB3YXMgYWdhaW4geWFua2VkIHRvIG90aGVyIHRhc2tz
IGJlZm9yZSBJIHdhcyANCmFibGUgdG8gYWNjb21wbGlzaCBhbnl0aGluZy4gU28gbm8gd29ycmll
cyAtIEkgZG9uJ3QgZXhwZWN0IHRoaXMgY29tbW9uIA0Kc3RhdGUtbWFjaGluZSB0byBiZSBkb25l
IGZvciB0aGlzIHBhdGNoIHNlcmllcyAtIEkganVzdCB3YW50ZWQgdG8gaGVhciANCnlvdXIgdGhv
dWdodHMuDQoNCkJlc3QgUmVnYXJkcw0KCS0tTWF0dGkNCg0KLS0gDQpUaGUgTGludXggS2VybmVs
IGd1eSBhdCBST0hNIFNlbWljb25kdWN0b3JzDQoNCk1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2
aWNlIGRyaXZlcnMNClJPSE0gU2VtaWNvbmR1Y3RvcnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhhcmp1
bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fiB0aGlzIHllYXIgaXMgdGhlIHll
YXIgb2YgYSBzaWduYXR1cmUgd3JpdGVycyBibG9jayB+fg0K
