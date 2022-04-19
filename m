Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E008506730
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbiDSIxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbiDSIxq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 04:53:46 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2106.outbound.protection.outlook.com [40.107.135.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29817AB5
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 01:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgsUrwJ5QKa9E/bNqFZUeqwdGutvXHSl7BQI9AV9k2r8+pa63PrImrcHuiUhYQAqTjj+2jKgaqFLUxowRKCOFxqfrj5XURfFsJqBzbaCsesPR8kwiH6ngh2vwcQ5rp5Kdef3vA/ePB+BfHOPpR2w4pmP8Q9wpIjk5cQngBAIgb5q481nKY9NBobpwhRQIxOy+3SUP28ap8tsqcUcRKOgGUzStm95G/7sn/r9IBp3cmKd6JSTHsKgqIJWiZYGfg/txsfyhw8AjkkhPPoAZfIGhaQCZf9Pb00CttVKboLVsZBc0NjrHAge+W1azHbt7gtF4zUIkkpf4rICb8Z4lknF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQmX1HJVovJs2HTV06jc5L9rhvaa4NTMTwJ5WTLJPC0=;
 b=hRJD/epU5BB3f2A52jemzh5XADfvChQrfaSH8303PmqUZjUy8R8faUuapqg/Ol+dH1Lj2OEKwf/zmSSWOYqGp++fJRgOsuA+bGrqd+/ExJikmUcl05Gx2GPXdciYxJpGJW/v5xYo2tiYtNQnZl/SvoJlG8Wevc1FaRLVm/0/+IXXKi/RiJdICx1//P3435mov3LKYmv6acApVQ2e0Tsl49EUmPOrzNbvRNcdtI4sYhV+h18uFrk438km8gRrUp5XGBhXr8zx9INPyS/L/Kx9uvKfSAmf/jtEXnfVHa2b6JiB+bOWfrkdeimbVw6Fc4Vrj8vDe3zwwCuFHNxU/bZfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQmX1HJVovJs2HTV06jc5L9rhvaa4NTMTwJ5WTLJPC0=;
 b=0XCa5tqoxvQPuPT9I3FhT9z5x9HqU9NoHgYuHi4NcasQTS/Lj4HyIAdZTv/DOEa73yDk6+2AJWKmEmoShLizGfkCH7KiaOPEbKCC1HhycMHn9c2SaSOb9nK0gWbagHlIx+1SShtiahGlIXbRcnyI7O4mpC3ZasvLcK5CAFdEitE=
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:54::13)
 by FR2P281MB0300.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 08:50:59 +0000
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::21d9:e262:d072:f060]) by FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::21d9:e262:d072:f060%9]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 08:50:59 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Topic: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Index: AQHYUQjSMGx+kNOuikmK8OrupSCxJKz28xsA
Date:   Tue, 19 Apr 2022 08:50:59 +0000
Message-ID: <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com>
References: <20220415203638.361074-1-linus.walleij@linaro.org>
In-Reply-To: <20220415203638.361074-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08c25ee-7d06-4aee-eef1-08da21e1b9b9
x-ms-traffictypediagnostic: FR2P281MB0300:EE_
x-microsoft-antispam-prvs: <FR2P281MB030078E9D1296DF78CEAB4B4ADF29@FR2P281MB0300.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvKkbHQMAsne7PLYxaO9WCq5TOKa+Vw/6fuRIZrXFWuGx5UHYDT9WU91Q4MafulaMkcyenF+mmt5xc35w088MNoZRAP9//5oBH/28cgg8oTT3qbQ9PC03vsu1u6jSPmLYc8zGtlDdP4iq50q6rSYOflIUJh3zDmVyh3ApJ6AArWanPLKN+V90l9rq8NtkwD5T2OG0P0jiK0vT2zt7uCQMEfvv2FfrEdmEbkiod8ly7MrxFVHv1LrydSwUpUms7WKXfGUAiFvYnlUL6OkFpKRVEbMp09NZRmy5T/QLOzmdxS0Tp7QcmmeZyMekpeN9KxPHgMvAhJZGRvE64vYHyebLx5O6gE7LJl0xh6fiYoDdxmOtpzWtTZG1xRDhoWseqzg24VEIl3TXgah5cjNINX6stuWIy0+1RbgHAPsWUo5UrrUZEvIcGFXfVQt3VsiJ/sLnJDtY27HYjN++Zm3W+t80VaB/fNKas0teesmB14z2awsFE50QjyV85hi5F+f6Wo0UKzb4erDXecyYe6FttaGBSwPLvfzQLq1Y/E4808FcegYvJJ6/eadxeWDyhDeO6jZVgRyHRBvA3BtQfEfKD4zffI/MrXwp5UJjXxSJw9VzKycuvq131Ti8tZ009h8v4I53fzESdG+XRkS/QMlyQqvBl5IBCD98Pjxv6DM+EQwzfU6Ehf0zRqpcr0DL5dxlkpWw98YMzR6qUO78oaQ3R5zwxzwwn6dgA2I2Swc8Exi5W5naTYrF7l0w/bF1ACxk/DZpTzzmlj+4MJnt13iXJ+BVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(71200400001)(316002)(186003)(110136005)(8936002)(31696002)(86362001)(2616005)(53546011)(6512007)(83380400001)(508600001)(6506007)(31686004)(2906002)(38070700005)(38100700002)(122000001)(6486002)(66946007)(66556008)(66476007)(91956017)(64756008)(8676002)(4326008)(66446008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhHSnpYTTk1UGNuVVhWZ0I1KzR2K1B2Zk0yVU5oaWRIK2Z2a2xlOGZDdng5?=
 =?utf-8?B?Y2REa2RUVWhzdkttVUFwazkwTmphc21xMXNmWUI2enNYQXR5Nm4vNE9hUzJl?=
 =?utf-8?B?RHZTQUdZSGZnUDNFZFUvQU9FZHRBSm1KYk5LRG9VZlJmbTdQMmZGeXYzNEhC?=
 =?utf-8?B?MHgyRmwwQkY1UGhJVEVpaE5kczBjUDBnQ1ZUNkJ3cXNjRTFJUktRV1Qvanll?=
 =?utf-8?B?MEkyNTY3MmhxVXJWcG9OdFh0QWdXNStNK0tocVJnVkFBTEtIOG9RNVYwaHJE?=
 =?utf-8?B?NWlZMXFENXRtbjlJakZndHBrS3lqRElSMlNHVTBGU2t3R0VaYnlsK0YxWTJX?=
 =?utf-8?B?TUNPYWJwVkJyOTBkZXcvUjdPaTVmcVFpMVpDVHhWN25lNFU1NGNBbmxhNWdM?=
 =?utf-8?B?d3YwNW0ralVQNUQxOXRpb0ZaaGpzNGtmM0YzWnJOLzVzNmFwaHBiMXFubExK?=
 =?utf-8?B?bFlTVkFUSUdzWG5iVGt4cVBXYjFDZTNZNnJXR253V01BcnJJblRKdE9JMXI1?=
 =?utf-8?B?N0hPWVkxUnNuNUljMVowMkd5SGs3WUpYUXRvQU05eWR0eXdSNTg5TTB5M3VW?=
 =?utf-8?B?Zjk4MjhTSEhDQk13ZEZqL1NDNnNEYU5peXRDRlkxbmYvSmxObWlxQWZ4THY1?=
 =?utf-8?B?c09pSDlmeHl0cm9OTjNRV1Nvd0RhcmVBWlUwN0pzbGcrUlpnNFNacE9MVzRM?=
 =?utf-8?B?ZHdCUGhURUFIeW1mbFNBcE9xWUI1VEhmVmVzbTllWFdpajZNMno3RThVdkdC?=
 =?utf-8?B?KzVCUDhJOUhYODBWUHdONi9Nd3NEN1NweVBiTUkwTGpSaXdiUGZKd3ozVWs1?=
 =?utf-8?B?eFNpVkVUanVMNENGYlE2K0pSdVloOERzNVRqMTNpeUVYM3pjUi9WWkZLUmd5?=
 =?utf-8?B?UlZMN2w1VElDaWt2UmFFUGJkM3F4OW1yaktFSXFRZmR0eXVSQTMyVTZZamRX?=
 =?utf-8?B?aDVHNE4rbDJiNlNHSTdjWUtYaFdWb0ZpOXpHNHVKMFJXdGg3dHhqSk05UC85?=
 =?utf-8?B?L2ZPR1AzdGpMRnZkK25JRzNmVVJoTDV3VTJ0ZnlydGRRaGFnWGVPSWV6YktR?=
 =?utf-8?B?OXMyZWNEc1A3SmRydXlaVUVIY0t6cEtGZGVqVVZzOVJYcC9MQWNjUXVGbnJE?=
 =?utf-8?B?MndVbGdvVmIrNnk1TDVUMUpHd1dDTzNjZ0tJWlhZRUEwNlMyRHFRSTNvbDdE?=
 =?utf-8?B?SU16Mi9OeEJocmxjbXpKZ3ZDZWdKWTVORlBiSmJUUzkvT0RSK0VIUm5mckp0?=
 =?utf-8?B?R0UzWEFKcDNsZnlDSFlVSXpGaGlCaUNsOThTekVJS2tQOS8rcm1wTEgzdjBC?=
 =?utf-8?B?NmpTV0NOWC85ejJHQVo4WElQc3NXODBhcmQ2M2ZnVXFUdEJTSnpMMzlhYjdi?=
 =?utf-8?B?TEhEVHIxaGZwNitFa2ZEbFJTZGpBSXNSSEtiek9UMUtuR0QycmdXR1k0REJv?=
 =?utf-8?B?T0lteHJjaUZhdFlManNWcDc5SFEwVzdjZzNOZkpuUU11KzRRYm5TVis2eG1p?=
 =?utf-8?B?cENaUFBJNFJaYmVaL1A4ejlRZ0tYVmRNcDlocnBYcE1PWng4UnRoeG9SN1o2?=
 =?utf-8?B?MnErbHB6YUdIenlRaU12dnZFZVZOWkNZd1RzQ1RBTHhRQkhkbFNUYVhzSDJM?=
 =?utf-8?B?ZEUrc2YvVW9xZmx6VkM0cXRMc1pFRHFFd0xWZ0ZSR2lRR1ljUWt0R1JDRk9S?=
 =?utf-8?B?VFB3VXQ1N0NnNTRiM3VkRG1UM3Juc200OEtDT3FOV01pTExQY0lyc3pZVTd6?=
 =?utf-8?B?c2NlcWZZdHJMWHNYeVhpNFc3MWVkZ0d2bENYUGRJaGloY0IvWmxpeTlwMlFy?=
 =?utf-8?B?c2ZJM1laSHV0VERFOXdXcXkzUzVwTW1pMGt2THBtb0R1aldEMjFIQlhsbi9o?=
 =?utf-8?B?WGd4N1o4L0xOcWlyZThhRTNBMm1wVnNZbWZzUkhoRVR2dWlGdHFrUUtRU2NK?=
 =?utf-8?B?WEJRTFVpdlgyQVhXM3YyczFHdlVYSFV3Q2w2dzY0aEF1ZTdZR0p6T2xCNklw?=
 =?utf-8?B?dk1HNW9VemNvbms0ejlrZFpLNnVEL0F2R1lONTdUd0NlUjZTNDMrUVhVTkVC?=
 =?utf-8?B?MU9QWnFaWmRWR0JKcWZ3cXVZcU01ZURBRFBZYUp5NG5aaEZWUmhoNWlrQTJG?=
 =?utf-8?B?dVlEOWJVTUs1VzhNaW1UZHkwNUZCazNTUXJwVWZ1bzRMdFRGOVdXSExEemRU?=
 =?utf-8?B?cHJ3UkduRS9Fb2ZnMmNCMUU4VXpIVHRwc0FVa1ExcTlYY2tEZnBZSDlHUXpp?=
 =?utf-8?B?Vng1REtJWWVualNMUW83OGtreUFSVkluVTRMWUh5cFROZTk3aG56ZHlpWndL?=
 =?utf-8?B?NjZtai9HcjNaNnp5cmN3RVMweWlZV2hDMnNJMG5oV25UMjc0R0twbkZCRGtL?=
 =?utf-8?Q?/JpOhnG4GuOawzlwDDm43Pebn1iAib8aTaoQD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD4175B0D1FC5D4584BC3E6B7C909D72@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f08c25ee-7d06-4aee-eef1-08da21e1b9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:50:59.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZIVPWi2Kdf6siNhf785w27vLCFs84x7cWyYJfRVmdCrB2M/oc74qZNRm+eDU9UeXEJAZR4HgO94YlsmIid4MWtJZTaTiHFU1wJGwKq8EXkdFUMEMv2excZXqDfQlNKw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0300
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgYWdhaW4gTGludXMsDQoNCkZvciBzb21lIHJlYXNvbiBJIGFtIGFsd2F5cyBzbGlnaHRseSB0
ZXJyaWZpZWQgd2hlbiBjaGFyZ2luZyBpcyANCmNvbnRyb2xsZWQgYnkgdGhlIHNvZnR3YXJlIDsp
DQoNCk9uIDQvMTUvMjIgMjM6MzYsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IFRoZSBiYXR0ZXJ5
IGluZm8gY29udGFpbnMgYSB2b2x0YWdlIGluZGljYXRpbmcgd2hlbiB0aGUgdm9sdGFnZQ0KPiBp
cyBzbyBsb3cgdGhhdCBpdCBpcyB0aW1lIHRvIHJlc3RhcnQgdGhlIENDL0NWIGNoYXJnaW5nLg0K
PiBNYWtlIHRoZSBBQjg1MDAgcmVzcGVjdCBhbmQgcHJpb3JpdGl6ZSB0aGlzIHNldHRpbmcgb3Zl
ciB0aGUNCj4gaGFyZGNvZGVkIDk1JSB0aHJlc2hvbGQuDQo+IA0KPiBCcmVhayBvdXQgdGhlIGNo
ZWNrIGludG8gaXRzIG93biBmdW5jdGlvbiBhbmQgYWRkIHNvbWUgc2FmZWd1YXJkcw0KPiBzbyB3
ZSBkbyBub3QgcnVuIGludG8gdW5wcmVkaWN0YWJsZSBzaWRlIGVmZmVjdHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMF9jaGFyZ2FsZy5jIHwgMzAgKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5
L2FiODUwMF9jaGFyZ2FsZy5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4NTAwX2NoYXJnYWxn
LmMNCj4gaW5kZXggOTRjMjJmZGZlOTYzLi5iOTYyMmViOWZjNzIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMF9jaGFyZ2FsZy5jDQo+ICsrKyBiL2RyaXZlcnMvcG93
ZXIvc3VwcGx5L2FiODUwMF9jaGFyZ2FsZy5jDQo+IEBAIC0xMjE2LDYgKzEyMTYsMzQgQEAgc3Rh
dGljIHZvaWQgYWI4NTAwX2NoYXJnYWxnX2V4dGVybmFsX3Bvd2VyX2NoYW5nZWQoc3RydWN0IHBv
d2VyX3N1cHBseSAqcHN5KQ0KPiAgIAkJcXVldWVfd29yayhkaS0+Y2hhcmdhbGdfd3EsICZkaS0+
Y2hhcmdhbGdfd29yayk7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBhYjg1MDBfY2hhcmdh
bGdfdGltZV90b19yZXN0YXJ0KCkgLSB0aW1lIHRvIHJlc3RhcnQgQ0MvQ1YgY2hhcmdpbmc/DQo+
ICsgKiBAZGk6IGNoYXJnaW5nIGFsZ29yaXRobSBzdGF0ZQ0KPiArICoNCj4gKyAqIFRoaXMgY2hl
Y2tzIGlmIHRoZSB2b2x0YWdlIG9yIGNhcGFjaXR5IG9mIHRoZSBiYXR0ZXJ5IGhhcyBmYWxsZW4g
c28NCj4gKyAqIGxvdyB0aGF0IHdlIG5lZWQgdG8gcmVzdGFydCB0aGUgQ0MvQ1YgY2hhcmdlIGN5
Y2xlLg0KPiArICovDQo+ICtzdGF0aWMgYm9vbCBhYjg1MDBfY2hhcmdhbGdfdGltZV90b19yZXN0
YXJ0KHN0cnVjdCBhYjg1MDBfY2hhcmdhbGcgKmRpKQ0KPiArew0KPiArCXN0cnVjdCBwb3dlcl9z
dXBwbHlfYmF0dGVyeV9pbmZvICpiaSA9IGRpLT5ibS0+Ymk7DQo+ICsNCj4gKwkvKiBTYW5pdHkg
Y2hlY2sgLSB0aGVzZSBuZWVkIHRvIGhhdmUgc29tZSByZWFzb25hYmxlIHZhbHVlcyAqLw0KPiAr
CWlmICghZGktPmJhdHRfZGF0YS52b2x0X3V2IHx8ICFkaS0+YmF0dF9kYXRhLnBlcmNlbnQpDQo+
ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCS8qIFNvbWUgYmF0dGVyaWVzIHRlbGwgdXMgYXQg
d2hpY2ggdm9sdGFnZSB3ZSBzaG91bGQgcmVzdGFydCBjaGFyZ2luZyAqLw0KDQpJcyB1dGlsaXpp
bmcgdGhpcyBsaW1pdCBzb21ldGhpbmcgdGhhdCBoYXMgYWxyZWFkeSBleGlzdGVkIGZvciB0aGVz
ZSANCmJhdHRlcmllcz8gSSBhbSBqdXN0IHNsaWdodGx5IHdvcnJ5aW5nIGlmIHRoaXMgY2FuIGNh
dXNlIHByb2JsZW1zIGF0IGxvdyANCnRlbXBlcmF0dXJlcz8gSSBhbSBieSBubyBtZWFucyBhbiBl
eHBlcnQgb24gdGhpcyBhcmVhIChhcyBJJ3ZlIHRvbGQgDQplYXJsaWVyIDpdKSBzbyBJIG1heSBi
ZSBjb21wbGV0ZWx5IG9mZiBoZXJlLiBBbnl3YXlzLCBJIHRoaW5rIEkndmUgc2VlbiANCnZvbHRh
Z2UgY3VydmVzIGZvciBiYXR0ZXJpZXMgYXQgZGlmZmVyZW50IHRlbXBhcmV0dXJlcyAtIGFuZCBB
RkFJUiwgdGhlIA0Kdm9sdGFnZSBvZiBhIGJhdHRlcnkgd2l0aCBuZWFyIDEwMCUgU09DIGF0IC0y
MCAgQ2NhbiBiZSBjbG9zZSB0byB0aGUgDQp2b2x0YWdlIG9mIGEgbmVhcmx5IGRlcGxldGVkIGJh
dHRlcnkgYXQgKzQwIEMuDQoNCkhlbmNlIEkgYW0ganVzdCBhc2tpbmcgaWYgdGhpcyBpcyBub3Qg
Y2F1c2luZyBteSBwaG9uZSB0byBrZWVwIGNoYXJnaW5nIA0KZXZlbiB3aGVuIHRoZSBiYXR0ZXJ5
IGlzIGZ1bGwuIEkgbWVhbiwgd2hlbiBJIGFtIGF0IG5leHQgYXV0dW1uIHNwZW5kaW5nIA0KdGhl
IG5pZ2h0IGluIGEgdGVudCBhdCBFbm9udGVracO2IEZpbmxhbmQgLSBhbmQgZm9yZ2V0IHRvIGRp
c2Nvbm5lY3QgbXkgDQpwaG9uZSBmcm9tIGNoYXJnZXIgYmVmb3JlIHRoZSBjYW1wZmlyZSBmYWRl
cyBhd2F5PyA6XSAoT2theSwgSSB1c3VhbGx5IA0KdGFrZSBteSBwaG9uZSBpbiBhIHNsZWVwaW5n
IGJhZyBmb3IgbmlnaHQgLSBidXQgYW55d2F5cywgY2FuIHRoaXMgY2F1c2UgDQpwcm9ibGVtcyBp
biBjb2xkIGNvbmRpdGlvbnM/IFNob3VsZCB3ZSBoYXZlIHNvbWUgdGVtcGVyYXR1cmUgY2hlY2sg
LSBvciANCmFyZSB0aGUgYmF0dGVyaWVzIHdpdGggdGhlIGNoYXJnZV9yZXN0YXJ0X3ZvbHRhZ2Vf
dXYgc2V0IGp1c3Qgc21hcnQgDQplbm91Z2g/KS4gUGxlYXNlLCBqdXN0IGlnbm9yZSBteSBxdWVz
dGlvbnMgaWYgdGhpcyB3YXMgZXhpc3RpbmcgDQpmdW5jdGlvbmFsaXR5Lg0KDQo+ICsJaWYgKGJp
LT5jaGFyZ2VfcmVzdGFydF92b2x0YWdlX3V2ID4gMCkgew0KPiArCQlpZiAoZGktPmJhdHRfZGF0
YS52b2x0X3V2IDw9IGJpLT5jaGFyZ2VfcmVzdGFydF92b2x0YWdlX3V2KQ0KPiArCQkJcmV0dXJu
IHRydWU7DQo+ICsJCS8qIEVsc2Ugd2UgcmVzdGFydCBhcyB3ZSByZWFjaCBhIGNlcnRhaW4gY2Fw
YWNpdHkgKi8NCj4gKwl9IGVsc2Ugew0KPiArCQlpZiAoZGktPmJhdHRfZGF0YS5wZXJjZW50IDw9
IEFCODUwMF9SRUNIQVJHRV9DQVApDQo+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gICAvKioNCj4gICAgKiBhYjg1MDBfY2hhcmdh
bGdfYWxnb3JpdGhtKCkgLSBNYWluIGZ1bmN0aW9uIGZvciB0aGUgYWxnb3JpdGhtDQo+ICAgICog
QGRpOgkJcG9pbnRlciB0byB0aGUgYWI4NTAwX2NoYXJnYWxnIHN0cnVjdHVyZQ0KPiBAQCAtMTQ1
OSw3ICsxNDg3LDcgQEAgc3RhdGljIHZvaWQgYWI4NTAwX2NoYXJnYWxnX2FsZ29yaXRobShzdHJ1
Y3QgYWI4NTAwX2NoYXJnYWxnICpkaSkNCj4gICAJCWZhbGx0aHJvdWdoOw0KPiAgIA0KPiAgIAlj
YXNlIFNUQVRFX1dBSVRfRk9SX1JFQ0hBUkdFOg0KPiAtCQlpZiAoZGktPmJhdHRfZGF0YS5wZXJj
ZW50IDw9IEFCODUwMF9SRUNIQVJHRV9DQVApDQo+ICsJCWlmIChhYjg1MDBfY2hhcmdhbGdfdGlt
ZV90b19yZXN0YXJ0KGRpKSkNCj4gICAJCQlhYjg1MDBfY2hhcmdhbGdfc3RhdGVfdG8oZGksIFNU
QVRFX05PUk1BTF9JTklUKTsNCj4gICAJCWJyZWFrOw0KPiAgIA0KDQpCZXN0IFJlZ2FyZHMNCgkt
LSBNYXR0aQ0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3Rv
cnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29u
ZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpG
SU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJz
IGJsb2NrIH5+DQo=
