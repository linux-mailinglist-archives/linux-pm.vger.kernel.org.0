Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21151D0D0
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 07:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389249AbiEFFmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 01:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381839AbiEFFmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 01:42:18 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2091.outbound.protection.outlook.com [40.107.135.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF265409
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 22:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isg7TX4fR+yyBLZcUVx9dFAsauE2R/0yvvH1oDuUTTF6bTkXrCuXS0RlB35EEPtCtUznf2N4Ob9pYyj/rQglBrXQWyCiGw02YuIh12SKOGWGba4KUmlO50vh1s2xOKZXwl3qGWao4yGqE7ZZ8tt+XNWR4VkR5i+UZgzdGb4OvMd0+guYy1HToMLXs1LZsP2GdMrSOutB/dxVvlYi3TI0stme3IcLkK44fnxW2igBTqEvTqQxTA4HB/dwjGh16qs01uYIQzdm1MKghWIlO0YjiZ438+jW2VblMn5lloDbqGcY2MUR9g9z2sYiZPvn+gLlmIv+dgJhP0j8hwM9SEODZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yiu/CGtTG9J0dWhDzUusZ5Niw5/NkJcrMzZTPQLtWQs=;
 b=AciR2LozE5lMcpgCCCFCUNkGijo0aHyST2Pjo61bSgbq4oQcezR+JlS9/pylETxpKrG7lmkdo84uzaVPCs2sifsh+2Ie3xSqxQjS4Dq/h+W93VgbHa+9KygHjr5UgxB50jG9Ksnn526kQQUM74TIAHk2hEIocp7n3VRAUNBTj6DBJJ3sTxKCIbpbk1BccuoAWg1xTRUL3livU84Lip1bk+4i47iGhaW2FWnV4AWM3vLrfU5VkAWFJZwqz9O7BZneTa6z/w2Hdl3Arrd4nB3IfpSwr6ZPG7tkJw5D1wKQlBRbGgWURpgCi4Psuup1U1kJzS9swkuZe/fL30aJm7Sg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yiu/CGtTG9J0dWhDzUusZ5Niw5/NkJcrMzZTPQLtWQs=;
 b=kwsEXMjsWcbB0BxJhsiEklFp6P3fyhKyEdcWPwwFFOAH5SEqefALHnZVpxyHuDf+h3nQh9S9YVekauy4IprrCdVtgsOAKefN3VkG8bOsJEYVYwjteLVp3BpXxo7pZt5LyOxma7uX13bxMgb0qyu2Nf22fz3c6z2gCRXNtrqM/EI=
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:54::13)
 by BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.19; Fri, 6 May
 2022 05:38:30 +0000
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::75e6:c45a:af7:b789]) by FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::75e6:c45a:af7:b789%7]) with mapi id 15.20.5227.016; Fri, 6 May 2022
 05:38:30 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Topic: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Index: AQHYUQjSMGx+kNOuikmK8OrupSCxJKz28xsAgBnlBYCAAJzVgA==
Date:   Fri, 6 May 2022 05:38:30 +0000
Message-ID: <0442f454-9fba-8901-ca97-90538df439cb@fi.rohmeurope.com>
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com>
 <CACRpkdYCWYgUAUJVVKy0jU4yF=d95e0Ead=coeMaA=uD3WV35Q@mail.gmail.com>
In-Reply-To: <CACRpkdYCWYgUAUJVVKy0jU4yF=d95e0Ead=coeMaA=uD3WV35Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76e0e4c1-becb-4e7b-0418-08da2f22a6e3
x-ms-traffictypediagnostic: BE0P281MB0211:EE_
x-microsoft-antispam-prvs: <BE0P281MB02119DDEBAC477624EC67FC7ADC59@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4gLyIM9hKQIEvXHj6nuo4EbFn9OLPVEWsj2ROYecGYKTBYooQT2erRARr171HiWsUITDy7pd/3uj9jcJ8m4O2ARS3t2gKr1FpXungAyCN/jKZ4fBq4CNlYISpI5DkwatY6oS+60g9nQBVTW4OQ0MB3Nh8R25Bp4cLkhA50NkQNpNEEQJCidhyi3AsI7tAsisicQIl/1oVENHdrH4yXlc672Ne7yHbtINmPbi9Le+jzwR1K1+rCAM1o/VPKCqrk9X98dhLg2xzOxDeXNKNF3BLfKmuZR7Gfe2+zb0ueZP58IDXzTVqAei7NnupLW/oJIDRvq6qWgzTjtb1NvBYClvzgnL5Vt9OzBF2rVBwammTd3WW5iHBaoHOSkRsfliV77sEz0DCi3iQtGRmkuS8n2lCeHl/9gHZENJA3MgktvMbbNiVQ7o04/L7lhLOVF6lY295vUbzc+QhhT5S1Tp9gd9Zu9VV8x0kZkSTGW0DuMb+IFiTOxGE7LEAHyYHRWxQ/O3Mgw1fmIRW4yQd84u4uDrTv9ILY/ttbiMLCqHTL/M5AmRFf3TZEcewF6tZJoMP4NyiHyJyIbJ5R6h7gXAvmZHwacuRGNqFdR/WhDf6TpfGOyKNR1Z1+cLxT4EVpV6ynw6I+aIVK6oOR2f9l0msAIvUZLQMbMlT7XyO930smlgYd0mop5j0Bk4HmEQe1yEnT+7KgzgkLZs7Qm5T4shh8rCg54L3B/VM0Icy+zIlb0FY8iG7dH5HhioJXAzqyAZfht3AuE58+fkeNq+4gj9+kW1SDDUWB734mSWA9yFNENhbniDY+Nw5k25DZiFDce1uAsL2abvvG+a/SRW3wSEN2V5lDK93uC2UKalSN0u5svDrU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(31696002)(53546011)(86362001)(91956017)(6506007)(4326008)(66476007)(66446008)(8676002)(66556008)(66946007)(64756008)(5660300002)(76116006)(966005)(8936002)(6486002)(508600001)(2906002)(2616005)(83380400001)(186003)(122000001)(38100700002)(38070700005)(316002)(26005)(6916009)(31686004)(6512007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1VVYjRLUkIvYlpiR0pwT3NGZ3puUmRnbjhXQUYzQnBIKzBKMGdEUFBNQ1ZT?=
 =?utf-8?B?K3VIckRienJnb3VzelR5bmNKQjVudXV2SmsyalJhRnVlbDFDbHZ1TEhlempw?=
 =?utf-8?B?OWRoMzBNMDV0ellDNmgxZTJHUjlhdXFySWt1QnFRcTRBQ05XRHRPenlrVkt2?=
 =?utf-8?B?WkhLQ2FZRnpxNGI2Vll3Z1hvNlhETkcrRCt4dzYxUjZkWms2cGMrODE2U0NL?=
 =?utf-8?B?dWovaTRBOVkvSFVMaE51aC84N0xDRE40c3lNdGVJQ0d3cEUyVXUxZFVuQlhI?=
 =?utf-8?B?cDdQSTRZT0FXSjRzclRoZ0JKa1c3UmY5ckpFMnpna3lQRE1GTU1WU3VEZ25C?=
 =?utf-8?B?VitjVjlYQ2JqQWtZdWU0YXFtUkFIQXptUWllNHRtNU1jbzlqYWlpOG4zVkVO?=
 =?utf-8?B?MkcxY1FNRlRFMVAyRDNBSGo2R0VOdHJ4aEJPd25FVzFjd3VjM05hd0I2Rm9K?=
 =?utf-8?B?ZjN0NVJKSElzMTEwaHJWa2xMZWZnME5HbncyeTlUc0loM0lRSWZwcVlESnBw?=
 =?utf-8?B?bmNRTjJrUDhRU0ZPTXgrampwdnhuWWhIV0hJdUI0Z0dBeDlkdDhPN3pqQndX?=
 =?utf-8?B?THo0WmlpaGpNZ0l5TkVpVmk2Z2hXN3NKWUtDWEN3TWkyejJtRGg3QlMvNFpL?=
 =?utf-8?B?dHlvYWNlaWtXQThKeVhFL2VXTjhSNFVxWnhQL3FwU0EreldiSlBuNVZER21t?=
 =?utf-8?B?b2RqRmhxMHN3cVh4V2swb0tSeGRwRktFcmpZcUhxNnlUTXdxWk1weEt1bC8x?=
 =?utf-8?B?TXBXT2NEU3pjRWhsS3Z3anF4bTRBeEZxeUVRMFF4dDNSYXcvVGpDVlRTTEg1?=
 =?utf-8?B?WjZDN3RuS3lBZEkvOEdGZFRHdUJYZFNnNFE4SUhFRm1iTlJ3S2JyUGxHSlFL?=
 =?utf-8?B?UkVuOW4yRG1RczJhWVdDK1F3WEEzOVZQVXVSK1cxZjg0dDZEN0tiSkRMY1RO?=
 =?utf-8?B?SHQ5NFkvZEVhMlozOGlBKzBvN2FSckZuWU5ycEt3clc3WU14RGhjNDg3ZzBH?=
 =?utf-8?B?UmtWSXFRYnNDdld0UFk2Y0ttNHZXclFiSjM3VHF2ZXJ4Snltc05iSGJlOWdR?=
 =?utf-8?B?NmtpTmlXeExpckdML0pBNkszSG5xYWNvVitrRnBLdGhGNFlkQmVyTFBZRGdV?=
 =?utf-8?B?T0xqZmhTc01QamdxeUJ0cDY0ZzIyUk1qWHhscXV6K21aVGliWEd4MFJkWFNr?=
 =?utf-8?B?OFYyRjFYdktTMENSNTNZUXBsMG83bXB1MnN4MnNUNCt0Q0U1LzBiRmFrNlJl?=
 =?utf-8?B?TG1uTXlJbFhSaWcyUEtkWExKRGh2TklpZEF5T1oxUXpSMXVnc1hhUzE5aGFE?=
 =?utf-8?B?amhDV1VOQmpvdlh3c3p5NFNhWUp6SEwrb2hVVGV2TU1zMkQxallzT0NxZ0Zn?=
 =?utf-8?B?MDZSLzMrWUM4L3dRbG5xNWJZZERhZDVnVHZZRkdza2dtSzNSRnFFT2lmTkls?=
 =?utf-8?B?WXQzalBZSS9mUnd5MUxkR0xjeXc1d0RoVjNDMnkyRjVjN3NSWDNjc3hQUnJI?=
 =?utf-8?B?U2xnTnJqR1ZwOExZNmthV0MyR0cwRGFlMGVyTlFJd1c3R21RaXhwYmNUUWFp?=
 =?utf-8?B?K0FhK2tjdXZ1bVhmSjRva3A0enEyUjNoTldFbkpsUzZzZjJjdWJKWHd1d2JQ?=
 =?utf-8?B?RVU0emIySHdtdVpXVTNIdmN2akpReThvRmtMMWxnMTJRUmd6SVNEcDdEYkRG?=
 =?utf-8?B?WkxPd2xsRXp1eFlDdW9uR1BWT3graWVsYUVLWDVRVFNnOTd3aThhcnMvcCt2?=
 =?utf-8?B?TzBQdzcxVVA3dFowOC9BTWZWYXVvcG8xekl3aWhmV2VYSWVCNW44WER2VmFC?=
 =?utf-8?B?UHM3Yy9KLzV3TWt6c0JLc2EyMjFpeTNaQjZFQmFJaGVTSTNpNzd1cXVkTUp1?=
 =?utf-8?B?Rno2VEtNVGUyMnhsU1BaRWlpNkJOT01QR3RKd1ZaOGNlSDhGK1AxTEhhdGFr?=
 =?utf-8?B?aDBwenNkTVB1UEFESnJCOVQ1TWMwSUlNeHNRVy9RQWF0ZGZmUkQzbGFXOWNR?=
 =?utf-8?B?aVNZOHJxU3hrQ1N4RXVxcTZkcGVBNzB3N1NwZE1uWndIbWdrUHliSGk1Y1N5?=
 =?utf-8?B?YmNiaEEvTzIyb1ZmOG5paS9QMTFvNzROUW5jZDFVcElvOERucysxU2dCNXdK?=
 =?utf-8?B?Ty9NT1B6UW5wd0VDa3JpY1NmNzhWekE0T0NVdFhQZ21BeFlTSkJVdjZhaTFm?=
 =?utf-8?B?alNhTXJCQk9vKzdvb0N5b1g3Mno3Q1dZSFZLY010am1hZnJJUUNib3cwSCtR?=
 =?utf-8?B?N0xXRjZqY1IyeTdMdkNneW5XeEllSkFiUzlYdWFqSk5aTEp0Z1RYb3YxMWtG?=
 =?utf-8?B?aUVFbnhjSTFUT3A4clR0RXBWUms3UldBZUgxUVAvV3NaTzMxZ0pEdXFFTjdC?=
 =?utf-8?Q?4TLNJqWh7gnAiSqs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF1D411E4B17AE48A853B90441744AB9@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e0e4c1-becb-4e7b-0418-08da2f22a6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 05:38:30.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2Sgh99rAnpgD+LI3v7sQAiI+7CXlymhvehkhx0Pjno8VjUpMw/gkVlCyFESSgrBlF9T3gFSBPQsNaY+2kGDxpxjn33k8sPYox3ftA5Uf5Fc8rUviaiDHCK3Tc0YaO0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0211
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gNS81LzIyIDIzOjE3LCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBIaSBNYXR0aSwNCj4gDQo+
IHNvcnJ5IGZvciBzbG93IHJlcGxpZXMhDQoNCk5vIHN3ZWF0LiBJIGRpZG4ndCBob2xkIG15IGJy
ZWF0aCA6KQ0KDQo+IEJ1dCBpdCBhbHNvIGhhcyBhIHByZXR0eSBlbGFib3JhdGUgc3RhdGUNCj4g
bWFjaGluZS4NCg0KSW5kZWVkLi4uIFRoaXMgaXMgYWxzbyB3aGF0IEkgb3Zlcmxvb2tlZC4NCg0K
Pj4gSGVuY2UgSSBhbSBqdXN0IGFza2luZyBpZiB0aGlzIGlzIG5vdCBjYXVzaW5nIG15IHBob25l
IHRvIGtlZXAgY2hhcmdpbmcNCj4+IGV2ZW4gd2hlbiB0aGUgYmF0dGVyeSBpcyBmdWxsLiBJIG1l
YW4sIHdoZW4gSSBhbSBhdCBuZXh0IGF1dHVtbiBzcGVuZGluZw0KPj4gdGhlIG5pZ2h0IGluIGEg
dGVudCBhdCBFbm9udGVracO2IEZpbmxhbmQgLSBhbmQgZm9yZ2V0IHRvIGRpc2Nvbm5lY3QgbXkN
Cj4+IHBob25lIGZyb20gY2hhcmdlciBiZWZvcmUgdGhlIGNhbXBmaXJlIGZhZGVzIGF3YXk/IDpd
DQo+IA0KPiBUaGUgYmF0dGVyeSBpbiBteSBleGFtcGxlIEVCNDI1MTYxTEEgaXMgZGVmaW5lZCBp
bg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9zYW1zdW5nLXNkaS1iYXR0
ZXJ5LmMNCj4gbGluZXMgNjc3LTcxOSwgdGhlcmUgeW91IGZpbmQgLnRlbXBfYWxlcnRfbWluID0g
MCwgYW5kIGlmIHlvdSBsb29rIGluDQo+IHRoZSBjaGFyZ2luZyBhbGdvcml0aG06DQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMF9jaGFyZ2FsZy5jDQo+IGJlbG93
IHRoYXQgdGVtcGVyYXR1cmUgdGhlIGNoYXJnaW5nIGFsZ29yaXRobSB3aWxsIHN3aXRjaCB0byBh
IGxvd2VyIHJlY2hhcmdpbmcNCj4gY3VycmVudCBieSBnb2luZyBpbnRvIHRoZSBzdGF0ZSBURU1Q
X1VOREVST1ZFUiB3aGVyZSB0aGlzDQo+IHJlY2hhcmdpbmcgdm9sdGFnZSBkb2VzIG5vdCBhcHBs
eSwgaW5zdGVhZCBhIG11Y2ggbG93ZXIgdm9sdGFnZQ0KPiBhbGVydF9sb3dfdGVtcF9jaGFyZ2Vf
dm9sdGFnZV91diA9IDQwMDAwMDAgd2lsbCBhcHBseSwgNC4wVg0KPiBpbnN0ZWFkIG9mIDQuM1Yu
DQo+IA0KPiBGdXJ0aGVyIHlvdSBzZWUgdGhhdCB0ZW1wX21pbiA9IC0zMCwgc28gaWYgdGhlIHRl
bXBlcmF0dXJlIGdvZXMNCj4gYmVsb3cgLTMwIGRlZ3JlZXMsIHRoZSBhbGdvcml0aG0gd2lsbCBz
aHV0IGRvd24gY2hhcmdpbmcgYWx0b2dldGhlci4NCg0KVGhhbmtzIGZvciB0aGUgdGhvcm91Z2gg
d2Fsa3Rocm91Z2guIEFuZCBzb3JyeSAtIEkgc2hvdWxkIGhhdmUgbm90aWNlZCANCnRoZSBhYjg1
MDBfY2hhcmdhbGdfdGltZV90b19yZXN0YXJ0KCkgaXMgb25seSBlbnRlcmVkIGZyb20gdGhlIHN0
YXRlIA0KJ1NUQVRFX1dBSVRfRk9SX1JFQ0hBUkdFJyAtIHdoaWNoIGlzIG5vdCB0aGUgc3RhdGUg
d2UgYXJlIHNpdHRpbmcgaW4gDQp3aGVuIHRlbXAgZ29lcyBkb3duLiBTbyBteSBtaXN0YWtlIC0g
SSBhbSBwZXJmZWN0bHkgaGFwcHkgd2l0aCB0aGUgcGF0Y2ggDQp0aGVuLiBBbHNvLCByZWFsbHkg
aGFwcHkgZm9yIHJlY2VpdmluZyB0aGUgZXhwbGFuYXRpb24uIFRoYW5rcyE6XQ0KDQpCZXN0IFJl
Z2FyZHMNCgktLSBNYXR0aQ0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2Vt
aWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9I
TSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIy
MCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVy
ZSB3cml0ZXJzIGJsb2NrIH5+DQo=
