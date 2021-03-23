Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF8345F63
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCWNRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:17:32 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:47494
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231466AbhCWNQH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 09:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPrrR/1ggTfBh9zv5/bE/r7cQU6cU6lTIWCCSfoF0YW4nQ/uf1Irbg4xKqFLPHwfPd6UprrjDTgPPfzdb9E6CkoznXnNthEecVi1Y94OimvYZS98Bcz3aI5XE+IiK2qjeigic+IY0i+SF5Yfw3Yvf71i14ArAkOIjXASupxkTNp/g4CNO2lYN3KrqEJXayGQdE0TYFbzPzfzniWME7OHYvUzgoADXpBGDj7Aoxvu6PhVbSR/KpmEHtusPBdpMbeSg8q41A2UuY6J9pn0ByrnhTLUH4pZLc5WAjCyhO8clFLbjfMT2aifEKSL8IXbAeHv/k4UgR/w2HUnLftEIbUUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0liIKY5kdjfR/YQPtHnyONRG6l84fJdBlWZw7t7/iQ=;
 b=HazN5Wh1gzrRMITR6GvVHRHz6JC8XSay69iNMn2gINqEb8/52cpOgv7QNYbl4Af/Fku6Wr1f3lsMT3Pv2hEUUNIj26vmXrOjSwQFsHob76b6sjilzxjQRHVB1QwCk//FAeeZL7XE4EMMaTqY3U5EmHArae6toelmQOnQ4pbJ407ZuR+Y/bdGiN6K3kh7LaoR0isIBzgoOn/6vj57jT7C48S64I6bBXVkl2C7mqEdR5N2qxd8nIZ3L/BhNVLf2h0Q6Rjg35EggKStE+gYyGKTVxwlB8Ftxc0CvFpuH5Ye5zMTu+2NDSKq1OqHrhOj6ft3huBAeIC/jCWEFsLzXG790g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0liIKY5kdjfR/YQPtHnyONRG6l84fJdBlWZw7t7/iQ=;
 b=ioGDLtvoiu9E/S1NaA2rm91xyeypqjDgt5RkMoA9b6oPUgfTvrcLrwYyLDT9GXTBg0Oxx1n6xtNmvcZjwGFAYxiZAm0sAANyJld/Raj7I+5Hf/wzIueRovhX33vRAyvBV+AtwbHX1eRAvrGPR7BpW7fqUcELzgOFdo34SrsaRO0=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2985.eurprd03.prod.outlook.com (2603:10a6:7:59::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Tue, 23 Mar 2021 13:16:02 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 13:16:01 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
Subject: Re: [RFC RESEND PATCH v2 0/8] Add managed version of delayed work
 init
Thread-Topic: [RFC RESEND PATCH v2 0/8] Add managed version of delayed work
 init
Thread-Index: AQHXHu4M36CuhYsXxkS/QAtgWtLqIKqRhkgAgAAJIwA=
Date:   Tue, 23 Mar 2021 13:16:01 +0000
Message-ID: <9a667ed3167738b3b436d00144154bcb4a64314d.camel@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
         <YFniWnUwQ7CY7wEM@kroah.com>
In-Reply-To: <YFniWnUwQ7CY7wEM@kroah.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26d67767-63f5-42a8-8d8f-08d8edfdce4f
x-ms-traffictypediagnostic: HE1PR03MB2985:
x-microsoft-antispam-prvs: <HE1PR03MB29858D8F7BB48EBC834A5C15AD649@HE1PR03MB2985.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dlHHD8kmhF0RK4t+uXLHadP5vCCb47rwxgK+9pVy9YnfU/Z//jnBhCOKrObj4/d7TiB5+pkYD+k5WABq/bh0oRuAyObhVVmvXRzbUnQe1LakH3sVzaeYgFgmvYRNAJmCOMm5rR5dQL7kMIWuTNQPyog25lqfzHdNJx3GI+nxgsiLJmaQ/2f85DtRHsLOsMLpfmTvuGU+ASvv0TYvKIq8yZTxCf7DUzhDNK9YQZsA5ypXmi3BF2FJvJ1mJ5FmYjPENEMvLb/q5YNqIg/RcU1VeIYRMOV4FE4YbyWFSf9uyIPvfEudTgD7RijJjzVxv34qb6RIPyViiyOfUaHrupx9aVCWxvFjIbctCeOXrJMRuHzion+us6E++TiZ7l2Ye3azhcVxR4nmp8PwfxLIG93FjFKmnWTVMzTTF8Gws8ft/2Ne9zVy2N427NhqUM/S1HgEufntCf1jj3hMQgFQjI1oGDjopmaRB1+vGHgDcRArwsqbB0dTmn5eASZ7JGOdn/LgpgrtgCyYGnW1/bFePPpQO+H+fqkhlv+vxobClcrXFPUgQthSAl8DEPyK08DfvxjmFQByMTVDgasKooxJ5UGOxIYODu+qr1SKG9hE19aMjwKtWN7/GnrBnXXBadgPwISwOi6JPRllFQ9Q4EnCVDBfudXJFnMW3wVSyv04Cinkl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(498600001)(38100700001)(6512007)(6506007)(4744005)(2616005)(71200400001)(6486002)(3450700001)(76116006)(86362001)(66446008)(64756008)(8936002)(5660300002)(7416002)(2906002)(66556008)(186003)(8676002)(6916009)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tm9YSnJ4RExXUmdJVEdFbDhsTDBOTWVneWRrS05VUTdxQ0ZDQ2tnS1BVNTgw?=
 =?utf-8?B?SS9LNmpjOFR3SFZOOGxDTVRIS3JPVWQ2RVBYZDhlYm1sUzkxanRuWEpoS0Qr?=
 =?utf-8?B?R0RGdExvUkV5YjFDR0VhSzlHMUlYendzVmtmS1QwdUhYUG9OTEhYSGdXMnk0?=
 =?utf-8?B?bHpMaVQ0NldWUFRhSWs0RHJ3K0F5Q1habTNuMFh2a0czUDRReEptMGd6TDd5?=
 =?utf-8?B?eCtKS2RVVTlDZ2ZveUxHeHU0WDN0YS96UDM5NExMRTNvOGk2VTVHMVc3REMv?=
 =?utf-8?B?V3ZicEgrNUNpRFBHK3dqbXpEMUFqRW83RXFEdlpSWkdYQ0F0Nmx1WVd6WXNt?=
 =?utf-8?B?UzNZYVJaZ1JEb1hoUGhHeDNMZ3RpV0gyVDV0elBuYXMvVjVrYTNFNTBiQ0JR?=
 =?utf-8?B?TkR3NTd1SVNnL2N6enF1UVpIaFd5ak1KSU01Q3RGVFRJUlAzdmUyWUU2UDBJ?=
 =?utf-8?B?K1gxOVlSS1JPVmxHcjVkTElyNWtNMGJiSXp3YjZNMnNFTTIzNmJPcFd2dEFk?=
 =?utf-8?B?VE1WWlg3N0xYTjlrWGE2MWJaTGRwRXIxNlhtYjV0cWdhMGw3YUNDQ0d4RS9p?=
 =?utf-8?B?RmV2ZlR0VEZhS3FKUHpSMERjOXdlU25CSkJjc202WTNBOE5SZW5RcmtlNHZz?=
 =?utf-8?B?b21tWTl0R2VKMmhlYVJHUXZPVzhNNHJNOFY2cXdweFZqWE55c1RHc0taU1Nh?=
 =?utf-8?B?c1JkM01jSTNiNUVvV1VuT3ZYak9TUXNkcjQ3Y0VMWEw1eStscTVzdlcrUmg3?=
 =?utf-8?B?V2NUNFc3enNLblJ4YnF6YzQvYUM1WVA4Mnk3VjBiV3Rva0Y4dldCUnhlYTVr?=
 =?utf-8?B?ZSs1VEFPbnZUYStTSFFaUGtqL2NZZmVHN3hHSjNuVW1RZmQrRUhYNDBxSldr?=
 =?utf-8?B?YmZuVDRvejZLRVd1dzdwR0JPL3h1bHhZVFU1WnF4a3VyUVVGYnNOSGJLeWRK?=
 =?utf-8?B?bm03WElZeDNjZmxqVE90UkVjc0grb0tlNjVwYVBGc29MRnlQVzNQK3FsVjBP?=
 =?utf-8?B?SnlMWlpEOHBSSXpCVzNMVElsZ3BwaWRaazA1YnRRS1R2d3R4akVxa2U3Rk8x?=
 =?utf-8?B?Q3ZocFN3VzRycU1IenErZ2lQdUtoV0NWK0cydXhNcHI2NGdvZU1NR1NOY2xT?=
 =?utf-8?B?YTloeUVmMXM0WTlBWGJ3YkFYbmFTMVk4QmJyMkc3NHVCODNKaUIxR3BOWGYz?=
 =?utf-8?B?TmpkTkRLdHI1TXp2SGY2OVZNV1BOdngycGMvdU10L01JRGpQZlIzNVdZNVk2?=
 =?utf-8?B?MGR5Z2pxcGRyc3FIS1plejkyRU9sNnBCUXhpZXE3WnhXZWZhQ3ZLQkY1OTVO?=
 =?utf-8?B?YWwrellSbStORXEyVUVKY2NmZm1GZkF4UXhiTnVTV3dvVG9oSzBGcVVyLzkx?=
 =?utf-8?B?cXZza2ZtSFVuSGttY2NmVmYrNTlPa2FRdjdoNG1xN1MyVXhKdkZ0R1BML2Uy?=
 =?utf-8?B?dTIrUUx3T1pUZ09uT2thSjlvMXFYYmJoU0lDNjEwd09HWW9UZlhKNkExdklD?=
 =?utf-8?B?emVkTW52aWdIYUNKa01vMzFGUEVXbTNYV3pmQy9QbG5iMlVmdFdiTGRuU01x?=
 =?utf-8?B?ZmlYdWZ3eDVldUV2eU8vZ2Z3amRPOFNZLyswczl1cHZjUEJSWW9zc2x2SjRO?=
 =?utf-8?B?bFQ5UDBaWHRiMlgzWjBNVkRJYVRSTHE0QTJaZTBxemdTMGlLaVJyM1d5MWRx?=
 =?utf-8?B?YWdITlZ6RlBIY1Z5dWZsVmdwRnNjUDFHRnJIeDFPY3BLQ3JkRjFNY3FKR1l3?=
 =?utf-8?B?a3hiTWZnZ3ZNVW92eEVFczY0ODRmVG1XQmEyRXZCcnYyT093UmJQaXorTENR?=
 =?utf-8?Q?5lPbaFVr0gzRWnzBLGqv/a/dc73wqmrVriBo8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABA65A598D13014C9F2D54331E2611C0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d67767-63f5-42a8-8d8f-08d8edfdce4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 13:16:01.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkBvixQZOLUIVhg1/5znCYxgfvZ4dmlp/x2nJWG1+Qs+Cvu7zJbXYgB/nW7nXFTAmD2irHg/gK+N/svHkiYCw+IWX3PNbINpbTB9kedgHr3ZnCCq/FAr84GiKiUnp6M1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2985
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR3JlZywNCg0KT24gVHVlLCAyMDIxLTAzLTIzIGF0IDEzOjQzICswMTAwLCBHcmVnIEtIIHdy
b3RlOg0KPiBPbiBNb24sIE1hciAyMiwgMjAyMSBhdCAwOTo0MToxM0FNICswMjAwLCBNYXR0aSBW
YWl0dGluZW4gd3JvdGU6DQo+ID4gSXQncyBub3QgcmFyZSB0aGF0IGRldmljZSBkcml2ZXJzIG5l
ZWQgZGVsYXllZCB3b3JrLg0KPiA+IEl0J3Mgbm90IHJhcmUgdGhhdCB0aGlzIHdvcmsgbmVlZHMg
ZHJpdmVyJ3MgZGF0YS4NCj4gDQo+IEkgZG9uJ3Qgbm9ybWFsbHkgY29tbWVudCBvbiAiUkZDIiBw
YXRjaCBzZXJpZXMgYXMgSSBjYW4ndCB0YWtlIHRoZW0NCj4gYW5kDQo+IHRoZSBzdWJtaXR0ZXIg
ZG9lc24ndCBmZWVsIHJpZ2h0IHdpdGggdGhlbSBiZWluZyBtZXJnZWQgYXQgdGhpcyBwb2ludA0K
PiBpbg0KPiB0aW1lLg0KPiANCj4gU28gaWYgeW91IHRoaW5rIHRoaXMgaXMgYWxsIGNvcnJlY3Qg
bm93LCBwbGVhc2UgcmVzdWJtaXQgd2l0aG91dCB0aGF0DQo+IHNvDQo+IHdlIGNhbiByZXZpZXcg
aXQgcHJvcGVybHkgOikNCg0KVGhhbmtzIGZvciB0aGUgZ3VpZGFuY2UgOikNCkknbGwgZHJvcCB0
aGUgUkZDIGFuZCByZXN1Ym1pdC4NCg0KT3RoZXJzIC0gc29ycnkgZm9yIHRoZSBub2lzZS4NCg0K
QmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQoNCg==
