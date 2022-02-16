Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D654B84AF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBPJpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 04:45:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiBPJpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 04:45:00 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB39FD3A
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 01:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htmVx3SSi5JbP6pe3QcLLhz5ihhNBtvZwxZSkgfj5D9a39bL+16M/M302g542ir6RSZUlx0J7wfYC+BJFaVJnSFQucy3bEjBKdPg3ry9IWhOh+p79lhA9uzcZ60ZCxe3YO3dBEEke8hypBAoXfvJ4VrMuA67oNr2UfLWMG5PIJfaqIDfZ7SI2G/gsKEWMdRa1QECsGHSUrqfyyq90Ed58sJq0QlQQbL3IGo6FSjcoCTovwfxjUoDcYHE0NUoZpomimWE5xwebdCQmLvosnP2FR+AKmOncVDMR/+NnE2Dsxi6/oC6HiTA6Qw7a5eC/m2vvonSh9ca3oa3dJT6EhBWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XAO7fk4cY8Oq6dPX7kzzPXUnMGyeM6LYGn7wHTlY2I=;
 b=X2pXE/UeY9SRmPfIWwkUphByDfSVNtxYQcDe4S/0ERr2EWElkJfOJOxG+MJpcGDakzgeVesbCc+CpNq6DO1AhwodPTJ4ToiKQ8/X/8oN5a6+oc8E2vQkoqfQb8Y81tXDaF8yLkS8pETaGGL1UtbmD/AUuPGfipOgfMq5M0nxCkRKKRvMY4ATIuSGCiVuxeN5BoNz720cdM/5c5f8zMf034KLkVxIj9ebzX68EZJ+vaZIXJya1B4zQNGt+l07RKDIWPbfZksij0cmZquzayNtczcVBaQ621ufC8yjEj5Kn6XRFu/NHKdx29WzL092QJi2QAykgWBxL+HYL38J9l0z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XAO7fk4cY8Oq6dPX7kzzPXUnMGyeM6LYGn7wHTlY2I=;
 b=QrQXBLSeXjJcoaiB8aPOjlFwZrerG6pKC4+XYo7XWb2aEpzz6UAepgJBPxELh+BLIJ5dOHsZcuN42OUMO+iAL1di4MUH58TPUc/8j1+2ThJ88+AYdLfssTitWhhpeQexEUNNKB7mQ9DCitZhE7+3c1ACgxQVpFjAtr+yj/Aufi4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 AM7PR03MB6450.eurprd03.prod.outlook.com (2603:10a6:20b:1b2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.19; Wed, 16 Feb 2022 09:44:43 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4%6]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 09:44:43 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/6 v2] power: supply: ab8500: Standardize alert mode
 charging
Thread-Topic: [PATCH 2/6 v2] power: supply: ab8500: Standardize alert mode
 charging
Thread-Index: AQHYIG4JClnFsUpeMEiJh5hFIZBMXKyV8sgA
Date:   Wed, 16 Feb 2022 09:44:43 +0000
Message-ID: <95d9352d-2cd6-c686-a79c-ced15f4babf9@fi.rohmeurope.com>
References: <20220213000703.772673-1-linus.walleij@linaro.org>
 <20220213000703.772673-3-linus.walleij@linaro.org>
In-Reply-To: <20220213000703.772673-3-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7359e93c-017e-4d1c-5bb4-08d9f130f5b1
x-ms-traffictypediagnostic: AM7PR03MB6450:EE_
x-microsoft-antispam-prvs: <AM7PR03MB645077B6F8A0F2F44D90925FAD359@AM7PR03MB6450.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqnZk3vAPS7WL7rV1/WHrLUgvG+xWzyTCZmBCQzTQ9rqLT3TTs04WI9EijrhcOiZ3R+yYPj1gK4RDVGQlXrtThVGLG7uOT01jlZG6TjX9SdsVKBay3i+hBXs5uhnVfPPUfknkxR7yJouBzVglHFJ/i7aCBQQTpwIdRD5YITFOTUG3VBeHXV3wbImyh96BWlzX5TuszIJBpqpsuvyxHAULqyQkRGInVbRpBakAj/b3gxa3tYdLaMbvDw43etaZQQoYkODJR/Xub58LbStVAj2hiu2ZTiNsBT/+bhpIj539qidEjnYOY0J1lBKpSaUoGMaf0d0TlAjgPdixPOeILxmlaCPaX07g0Xsr7UD2gyAhnEJO2SGJzwXx0lmYPXs4gtDi1j8GSBf13ND7rhOnEJhlh6DQp3cPbtOpmP+eb8OJNBtd0jLcLV6yg/sgGlq3W4f05Jm+rkNIJUwoFXplbYNMqeGc1a5JIRgSMX4FSBwq2U2EuiLgFkOfkLV+9yUBMxtji3KopE3JA8XnJ5dh8T/GK5ebByIfjKmUO4auwFENpIP/yXSegfGLqVIKgCdOlouPWW+KkYc/QO5NL6iiX9LVCFCC7xTNsFzzX5L6xU4XjPOFBdG/SmCwGGuJAy/uI1xkmjY1Wmdtbikz045Y34P87hcVOHiQNJ95vOMo2TBtbhS8baiGQZY6LvlO2xTuWYxQyOSKXBzlnvkp1ze99z4SIwrpOpN66S6BlKF4AKJCA5ZMBSXq6K6Y+4M5Le2LPuzBp1//YEqTx9pwIPpcfUWwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(26005)(31686004)(5660300002)(53546011)(4326008)(6512007)(76116006)(2616005)(6506007)(186003)(6486002)(8676002)(15650500001)(66446008)(110136005)(64756008)(66556008)(86362001)(66946007)(66476007)(71200400001)(31696002)(38070700005)(91956017)(498600001)(122000001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDQ3Z2IvMC9NalNFSmlQT0ZmQ3FmRm45bUhGcVUyamx6M2hsSTZRWFBwRzZU?=
 =?utf-8?B?bThPNnVJSlhyMk1jQWp1NVhyYzhJYmFtUWtsQVN6NVZMdTA1aTZVdEI3eTVu?=
 =?utf-8?B?ajVwSmplcWhQWVpmTTdnZ2YwazJBN3NhWFhCeUJnUmI4VXlGL0ZGRy85elFR?=
 =?utf-8?B?MVJBRFVheGtuUGFRL25GOGdJK2hRZ3ZqeE1FWjRKdGM3NXZjL0VsMlk3WFM3?=
 =?utf-8?B?a2RQYjBxWXNNa1dMYnlueEVVdVNaVDZBOGphWXA0Yzh6SE1MS1NRU0dYQndl?=
 =?utf-8?B?WjFCR2tjanhTa3lzMlNaWkk3ZlJNeUUwR1pldU5QS2d3NGM1WVhROVpOTU9E?=
 =?utf-8?B?clhjYkJpQlpRWWF2Nk1YVmZhM2MvS2JjNktYTzZDVlIwR2sxTHhzcDhPTW5E?=
 =?utf-8?B?akVTeDVCeU1EWkFWZFE5dHBFMGhMNGFNdVVncTFzOXlVcXVmQ0NRazRuZjVD?=
 =?utf-8?B?N2Evd1NmazdjRXdqejBYKzRKaVNJOTNCVFpkSzM5Q3dyU3dkV2M3RGlYdzdx?=
 =?utf-8?B?YjY1MVhjT0pYR2Y2cTVCalY1ZC9XUTJUWjdGUHNmd09QSGVUMFMya3l3OHY2?=
 =?utf-8?B?V0k5N0h4ZjBDV3A4T3lmN3dkMzdxcmg0YnN2d0I4c2ErQngxNG1USFY3dFFm?=
 =?utf-8?B?OXo5blNGSytGOE9OWUpRUURGWHZaWFNGK2hNMWZCS3JjTlNzaTkyY2lVQm5F?=
 =?utf-8?B?TzBCWmZZSlQ4T1pvSjMzc3dRblNRSWZlbHhrdTZpT3M1Y3MxdlNoTGxEUENC?=
 =?utf-8?B?N000ekdSamJmU0RHVGg4OFllT3Zla3hXdjNHKzZobm1nMFhiVDNlZlJMSUN4?=
 =?utf-8?B?ek9jdnc2MDFTOEp2bVBHSTNHblFhZUlMakVDQTZvSkJlY053cUJwenh5WW9G?=
 =?utf-8?B?My8yUjJhY3d2MnlGcTRYR2NWNXJwT1B2Q0NVdTdhOXRuUlBnYUNsWUFYelkv?=
 =?utf-8?B?NHB6SVhWNFlzTytiTGl5c3BoeE9Hc0dwejV4OVhzaElFZ2diajJnL1JTd0JX?=
 =?utf-8?B?Z25qTXp0NnJUcythNnVuc2Q3UUNpbENjcVBVdXJYanhQUXJEUFA2UnZvdlVS?=
 =?utf-8?B?Rk5ZRWdDaWdEOWtXWER2OXhoVTlHSmc5OVFFOEFzb081cXBnZGZUWGtUZ0tB?=
 =?utf-8?B?ZWd5ZFJkMEYwcnkydEJvTmExVnBVSW9QZWkzdWF1ZmN5RXhQb3RpalVJR1kv?=
 =?utf-8?B?WkpSdWhWUWhDcFhUdmRiTDFvdU1CeEx2MmNnVUdWMVJza25lWSthL3QyOStx?=
 =?utf-8?B?WkFQTFJRUHhGRWZmUWJwb3dyVnlyNHNyakdlOTFLRThRNWJUWVVvY0VqakZW?=
 =?utf-8?B?YTdWdzlJYVhJMEdRRFR3RysycVNCWWk1ajN5Z1hVTmo2NFk4QWJySVhqeEY4?=
 =?utf-8?B?U2U1VnNCcTVUSTJHeEdkazVjR2JYVVFJUCtBcndTRmdNOHFvL1NDakZ5R0Ru?=
 =?utf-8?B?QXEvVFFTQ01ZQ0s5eGQxZEMzeGVzbjY2MDNqU2tmbWhSMG12R0s2SGNyQTgx?=
 =?utf-8?B?RC9nWkppekN2TVpqeHoxUWV0dytLSWNkMFZsOTV4NXVjN0dMYTN5Sjg2Y0R0?=
 =?utf-8?B?Q2Y1Mkg3dnZ4SEIybWtCVks2WXU3L2Q3RkRsZ2lZY2owMHloVFZwZHhDRlV1?=
 =?utf-8?B?WEJwMkZwOSt3blZFZHgvTmxkalpTbW0wR3Nlb0t5V2syWkc4UHZmQkhaSnNv?=
 =?utf-8?B?UUZhWnpXSnAyMTZTLy9HWTBSejRpdDZMUURLekpUNExZclZVWktFOWFqM3Rp?=
 =?utf-8?B?SEpMVVlxUU83UEhzRlJWOUJVa2poRVZ1M0tqK3UvcGt6TzBwZ0hNSVgvSzNJ?=
 =?utf-8?B?UlNEM1hZa0dSaHZic1RFNGdaSzBwVEwwYkVLMDU3Vm1QY004dk1lWU1hamZQ?=
 =?utf-8?B?S2c2dHJZbXBwRDN2MURsaHVlUVU0NnpLL2RiendqN0p5OHZzRXdmeHg0ZXEr?=
 =?utf-8?B?UlhBenA1UkRkRW51alZ0TWdVSFBvUHlKY3IvWkxxM3VkSFg3Zkx6Y3R5TE1W?=
 =?utf-8?B?T2JrTURqY2w3bndMV3kvTkhaTDRRRGY4L3ErL2MvdFEyOUpZSDdnSG1CR05t?=
 =?utf-8?B?K3lkSEo1TkFmVWEyczdaZUJhQWFYNk1IR2FJWmpYbHBNMUlQdWJhSGxLVUky?=
 =?utf-8?B?aTVyaWNjWDg3VnMvOGNBNDBFM3J6ZlgyYncxa1Fka2NlVEtRNlBrMjNRTUU1?=
 =?utf-8?B?UHBOc2pCWk9TbnZWUHdBSWZXTkJPVXhPUW9CU0E2amVjTXF6SjlzYnNpR3I0?=
 =?utf-8?B?cFpXT2NqbS9PcVAxR2tEVjltYWFlb0hoS0tOTTJwYjNvUkdWRTBXSnBuN3do?=
 =?utf-8?Q?9bnIvOSWgV+v0vODMF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A41673917A604FB7C752E6731FDE68@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7359e93c-017e-4d1c-5bb4-08d9f130f5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:44:43.0995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85K9xfx6WdsOQ1CHM7tpHLKhyxK7Vi199XM0WqENa7qQWIygKZHWZEB6is43Ix50nObI7eLzzHxfyDLWPeXGgBEIdUhhm9cFb60XSoeJ6IZKiRLBLBCPprqb6UEp3Z5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6450
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SSBob3BlIHRoaXMgZG9lcyBub3QgY29tZSB0d2ljZSAtIG15IFRodW5kZXJiaXJkIGNyYXNoZWQg
d2hpbGUgc2VuZGluZyANCnRoaXMgb3V0IGZvciBmaXJzdCB0aW1lIDovDQoNCk9uIDIvMTMvMjIg
MDI6MDYsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IFRoZSBBQjg1MDAgY29kZSBpcyB1c2luZyBh
IHNwZWNpYWwgY3VycmVudCBhbmQgdm9sdGFnZSBzZXR0aW5nDQo+IHdoZW4gdGhlIGJhdHRlcnkg
aXMgaW4gImFsZXJ0IG1vZGUiLCBpLmUuIHdoZW4gaXQgaXMgc3RhcnRpbmcNCj4gdG8gZ28gb3V0
c2lkZSBub3JtYWwgb3BlcmF0aW5nIGNvbmRpdGlvbnMgc28gaXQgaXMgdG9vDQo+IGNvbGQgb3Ig
dG9vIGhvdC4gVGhpcyBtYWtlcyBzZW5zZSBhcyBhIHdheSBmb3IgdGhlIGNoYXJnaW5nDQo+IGFs
Z29yaXRobSB0byBkZWFsIHdpdGggaG9zdGlsZSBlbnZpcm9ubWVudHMuDQo+IA0KPiBBZGQgdGhl
IG5lZWRlZCBtZW1iZXJzIHRvIHRoZSBzdHJ1Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlfaW5mbywN
Cj4gYW5kIHN3aXRjaCB0aGUgQUI4NTAwIGNoYXJnaW5nIGNvZGUgb3ZlciB0byB1c2luZyB0aGlz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPg0KDQpTbmlwLg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9w
b3dlcl9zdXBwbHlfY29yZS5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X2Nv
cmUuYw0KPiBpbmRleCA2NTY4OTM5ZTQ1MTguLjVkN2QxNTg2MDUyOSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5jDQo+IEBAIC01OTEsNiArNTkxLDEwIEBA
IGludCBwb3dlcl9zdXBwbHlfZ2V0X2JhdHRlcnlfaW5mbyhzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpw
c3ksDQo+ICAgCWluZm8tPmNoYXJnZV9yZXN0YXJ0X3ZvbHRhZ2VfdXYgICAgICA9IC1FSU5WQUw7
DQo+ICAgCWluZm8tPm92ZXJ2b2x0YWdlX2xpbWl0X3V2ICAgICAgICAgICA9IC1FSU5WQUw7DQo+
ICAgCWluZm8tPm1haW50ZW5hbmNlX2NoYXJnZSAgICAgICAgICAgICA9IE5VTEw7DQo+ICsJaW5m
by0+YWxlcnRfbG93X3RlbXBfY2hhcmdlX2N1cnJlbnRfdWEgPSAtRUlOVkFMOw0KPiArCWluZm8t
PmFsZXJ0X2xvd190ZW1wX2NoYXJnZV92b2x0YWdlX3V2ID0gLUVJTlZBTDsNCj4gKwlpbmZvLT5h
bGVydF9oaWdoX3RlbXBfY2hhcmdlX2N1cnJlbnRfdWEgPSAtRUlOVkFMOw0KPiArCWluZm8tPmFs
ZXJ0X2hpZ2hfdGVtcF9jaGFyZ2Vfdm9sdGFnZV91diA9IC1FSU5WQUw7DQo+ICAgCWluZm8tPnRl
bXBfYW1iaWVudF9hbGVydF9taW4gICAgICAgICA9IElOVF9NSU47DQo+ICAgCWluZm8tPnRlbXBf
YW1iaWVudF9hbGVydF9tYXggICAgICAgICA9IElOVF9NQVg7DQo+ICAgCWluZm8tPnRlbXBfYWxl
cnRfbWluICAgICAgICAgICAgICAgICA9IElOVF9NSU47DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3Bvd2VyX3N1cHBseS5oIGIvaW5jbHVkZS9saW51eC9wb3dlcl9zdXBwbHkuaA0KPiBp
bmRleCBiOTk4ZmM0Yzg3YWUuLjQyYTQ3ZDdhYTNmZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9wb3dlcl9zdXBwbHkuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Bvd2VyX3N1cHBseS5o
DQo+IEBAIC00NDMsNiArNDQzLDE5IEBAIHN0cnVjdCBwb3dlcl9zdXBwbHlfbWFpbnRlbmFuY2Vf
Y2hhcmdlX3RhYmxlIHsNCj4gICAgKiAgIGFmdGVyIHRoZSBtYWluIENDL0NWIGNoYXJnaW5nIHBo
YXNlIGlzIGNvbXBsZXRlLg0KPiAgICAqIEBtYWludGVuYW5jZV9jaGFyZ2Vfc2l6ZTogdGhlIG51
bWJlciBvZiBtYWludGVuYW5jZSBjaGFyZ2luZyBzZXR0aW5ncyBpbg0KPiAgICAqICAgbWFpbnRl
bmFuY2VfY2hhcmdlLg0KPiArICogQGFsZXJ0X2xvd190ZW1wX2NoYXJnZV9jdXJyZW50X3VhOiBU
aGUgY2hhcmdpbmcgY3VycmVudCB0byB1c2UgaWYgdGhlIGJhdHRlcnkNCj4gKyAqICAgZW50ZXJz
IGxvdyBhbGVydCB0ZW1wZXJhdHVyZSwgaS5lLiBpZiB0aGUgaW50ZXJuYWwgdGVtcGVyYXR1cmUg
aXMgYmV0d2Vlbg0KPiArICogICB0ZW1wX2FsZXJ0X21pbiBhbmQgdGVtcF9taW4uIE5vIG1hdHRl
ciB0aGUgY2hhcmdpbmcgcGhhc2UsIHRoaXMNCj4gKyAqICAgYW5kIGFsZXJ0X2hpZ2hfdGVtcF9j
aGFyZ2Vfdm9sdGFnZV91diB3aWxsIGJlIGFwcGxpZWQuDQo+ICsgKiBAYWxlcnRfbG93X3RlbXBf
Y2hhcmdlX3ZvbHRhZ2VfdXY6IFNhbWUgYXMgYWxlcnRfbG93X3RlbXBfY2hhcmdlX2N1cnJlbnRf
dWEsDQo+ICsgKiAgIGJ1dCBmb3IgdGhlIGNoYXJnaW5nIHZvbHRhZ2UuDQo+ICsgKiBAYWxlcnRf
aGlnaF90ZW1wX2NoYXJnZV9jdXJyZW50X3VhOiBUaGUgY2hhcmdpbmcgY3VycmVudCB0byB1c2Ug
aWYgdGhlDQo+ICsgKiAgIGJhdHRlcnkgZW50ZXJzIGhpZ2ggYWxlcnQgdGVtcGVyYXR1cmUsIGku
ZS4gaWYgdGhlIGludGVybmFsIHRlbXBlcmF0dXJlIGlzDQo+ICsgKiAgIGJldHdlZW4gdGVtcF9h
bGVydF9tYXggYW5kIHRlbXBfbWF4LiBObyBtYXR0ZXIgdGhlIGNoYXJnaW5nIHBoYXNlLCB0aGlz
DQo+ICsgKiAgIGFuZCBhbGVydF9oaWdoX3RlbXBfY2hhcmdlX3ZvbHRhZ2VfdXYgd2lsbCBiZSBh
cHBsaWVkLCB1c3VhbGx5IGxvd2VyaW5nDQo+ICsgKiAgIHRoZSBjaGFyZ2luZyBjdXJyZW50IGFz
IGFuIGV2YXNpdmUgbWFub3V2ZXIuDQo+ICsgKiBAYWxlcnRfaGlnaF90ZW1wX2NoYXJnZV92b2x0
YWdlX3V2OiBTYW1lIGFzDQo+ICsgKiAgIGFsZXJ0X2hpZ2hfdGVtcF9jaGFyZ2VfY3VycmVudF91
YSwgYnV0IGZvciB0aGUgY2hhcmdpbmcgdm9sdGFnZS4NCj4gICAgKiBAZmFjdG9yeV9pbnRlcm5h
bF9yZXNpc3RhbmNlX3VvaG06IHRoZSBpbnRlcm5hbCByZXNpc3RhbmNlIG9mIHRoZSBiYXR0ZXJ5
DQo+ICAgICogICBhdCBmYWJyaWNhdGlvbiB0aW1lLCBleHByZXNzZWQgaW4gbWljcm9vaG1zLiBU
aGlzIHJlc2lzdGFuY2Ugd2lsbCB2YXJ5DQo+ICAgICogICBkZXBlbmRpbmcgb24gdGhlIGxpZmV0
aW1lIGFuZCBjaGFyZ2Ugb2YgdGhlIGJhdHRlcnksIHNvIHRoaXMgaXMganVzdCBhDQo+IEBAIC01
OTQsNiArNjA3LDEwIEBAIHN0cnVjdCBwb3dlcl9zdXBwbHlfYmF0dGVyeV9pbmZvIHsNCj4gICAJ
aW50IGNvbnN0YW50X2NoYXJnZV92b2x0YWdlX21heF91djsNCj4gICAJc3RydWN0IHBvd2VyX3N1
cHBseV9tYWludGVuYW5jZV9jaGFyZ2VfdGFibGUgKm1haW50ZW5hbmNlX2NoYXJnZTsNCj4gICAJ
aW50IG1haW50ZW5hbmNlX2NoYXJnZV9zaXplOw0KPiArCWludCBhbGVydF9sb3dfdGVtcF9jaGFy
Z2VfY3VycmVudF91YTsNCj4gKwlpbnQgYWxlcnRfbG93X3RlbXBfY2hhcmdlX3ZvbHRhZ2VfdXY7
DQo+ICsJaW50IGFsZXJ0X2hpZ2hfdGVtcF9jaGFyZ2VfY3VycmVudF91YTsNCj4gKwlpbnQgYWxl
cnRfaGlnaF90ZW1wX2NoYXJnZV92b2x0YWdlX3V2Ow0KPiAgIAlpbnQgZmFjdG9yeV9pbnRlcm5h
bF9yZXNpc3RhbmNlX3VvaG07DQo+ICAgCWludCBvY3ZfdGVtcFtQT1dFUl9TVVBQTFlfT0NWX1RF
TVBfTUFYXTsNCj4gICAJaW50IHRlbXBfYW1iaWVudF9hbGVydF9taW47DQoNCkZvciB0aGUgcG93
ZXJfc3VwcGx5X2NvcmUuYyBhbmQgcG93ZXJfc3VwcGx5LmgNClJldmlld2VkLWJ5OiBNYXR0aSBW
YWl0dGluZWVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCi0tIA0KVGhl
IExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGlu
ZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNX
REMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5
ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
