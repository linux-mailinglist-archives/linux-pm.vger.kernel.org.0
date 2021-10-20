Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AE4349E2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhJTLQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 07:16:12 -0400
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:27963
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229864AbhJTLQM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Oct 2021 07:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMRjXGA4mQraRhWHIzHCqEiO9T3cxU7Qe6VE3M6FIhLHrWbnWTtym6d4iGilNzhsf+bqXSRIOOm0hf4FNY8NmoTOxf+Pta/6gMhJHvtwb9zhiSp+lqBsGSYfkbtjowNX5N/M6rztr9TAavN3TDT6SYJ2P5inJkC3N4crA7Xgia+M7GNK9xOALkOzwQf+n2welG92seln+zJXa3qazTLWtDfhGqn147pxE1OjQQxM9tnqThnxJSMWI3ZCBg8/JStgZc0A+7ejmKMfwmVvzDhT/E7VBzxtQQxRAGkzX2pJKc7okuo9mbS4tWPOivFNbpMC33ResxqU+9Uc4YVTcTznLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLrPxcSJ4lNer4YDgQK2euFsGfC+RUT6mtgnPgCFZto=;
 b=VQBq/A9aSfg7+CvyLVbRcGOWdS92d5Jn2/VuAE9vT43LIhL0SlUHZpFq1EkvQMcArXXXcWkH+Dw9Tkjvh4rlIyyoLVzXGAF+7ofdluDHTeXr99oi6kHNVOfeBf8qohwX5ZRdunv5xTFHNYSlq7alYkdGLSEJjG31wWZE0mJTENbzPTVU6dCZS+68ticwORo7zn3//pz07jlIr4Uuhs96WImWHs/UTE6cRyiRGcbT2lz9DW/CrOp0v2KTUk0JNqAiAndwRYXGsrXx87tBLf+K1qEytuThAxOh+yClnvI6r/QRdPmr7jaH4ndMluN1DXoTCn3ivvB6rSbYgHCoBBDLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLrPxcSJ4lNer4YDgQK2euFsGfC+RUT6mtgnPgCFZto=;
 b=y61mKtXo/3uZQm8s4uIugxN9wY1aVoViVxfkkn7hbEKUTHErkr271oG0/q5roeVhQe9ELHNsiijpCW1XgDRctmWuefBYpY72zxtmWZNR3lzAet1NRJ74usRvRflNunTbGcFmNbzmO+0l7tEXmXd0n0ooc+mSHlOknR3m+SQnJZc=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1160.namprd12.prod.outlook.com
 (2603:10b6:903:38::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 11:13:53 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 11:13:53 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Topic: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Index: AQHXsrXQs9OizRhBckanMP3pgJaGBKvasAqAgAERZ+A=
Date:   Wed, 20 Oct 2021 11:13:50 +0000
Message-ID: <CY4PR1201MB0246A7ECA4E8143CC6E4933DECBE9@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-5-ray.huang@amd.com>
 <CAJZ5v0g58vrHNcOEoWUCKmTxraSTuCzVLffzEAgz7TPa8+TNyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g58vrHNcOEoWUCKmTxraSTuCzVLffzEAgz7TPa8+TNyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-20T11:13:48Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7062b398-c67d-4ffe-89aa-e3eca2c067a3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72fb6a1f-ebfe-4756-c792-08d993bab381
x-ms-traffictypediagnostic: CY4PR12MB1160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB116003D244010CCCF4B90093ECBE9@CY4PR12MB1160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2SibSEOI0IK8oxFLufL/5N7eGICTuFI24wniZxyujjqxUgtsLegHdiFoW/G0AjxjH0h1VTIKWjAc+VjMu3VW8LdcoSYLYcVrbn0fgm77wog68OBUn2LV9vg69kAmGB+A1HDcp3p4onm5v13KmuKjpXkJ5rFEdMJDcfljTBQPb+bp77aqslExQS3oSkLuRHRgbbRqTKJvPrS5YX/pINMQuxbrM1Wll+8bgB9cocKy7YusTfP+2ruvwAmDK9P3at5fi3dp2qTzQ4Fc1ZqiouG57I19GRcYOG2bQYS0OKYnEGssAVzxlC7yke2eC7OKIyoWDtmLRKP/37gPGGHQTDPfr1Et+OU4p2DcHyrQztzA9SpDC8LVi9wA6UPTtbkF+mIvtwwtUFP8TvkHQAWmpAHeIcVC4VECA2wykg98V8By2M41xH4mNhQ7cUlSccIf5SSPMTx5VUZUuKWGFMotkobi//dnyRS7nJgbylHsklRxXz8YFhLrVKsCeoD7xkfkpEDVQMmBFC9VmYC3R5CwBgX37aIK/vpNowIeu/g42EOtkX/kvmu8cHx5z7fAJwJjLLxlleJI0jUK8S5nq2hS+0q1sZZoaibcVB2M/6WY8c8axB+ZRaYxhXOeMA/ZbEP4OE7rsLwPSlkFUfHIrdWjaIKQ7wSsDO4uZayJIJKBSDpMgjWuBrKsYmRTbPiDKUMEnkneWrxc7T4fVg9c1yCWDUsGlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6916009)(6506007)(8936002)(76116006)(33656002)(4326008)(52536014)(7416002)(7696005)(508600001)(8676002)(122000001)(38070700005)(53546011)(66946007)(64756008)(66556008)(5660300002)(186003)(71200400001)(66476007)(9686003)(2906002)(38100700002)(26005)(316002)(54906003)(55016002)(66446008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2ozZUNaajlkS2JkQWZVeFNkcEJzU3ZTN21EMTJ4Q1BaV0laYnVMbko0V1RU?=
 =?utf-8?B?cEtETEZ1ME9uMDFqVHRmOVFLYVR6cjByNmIwNUtQVXFsbTNRRVhGSmd6SFNN?=
 =?utf-8?B?MndoL3diV24wUWFhWXI3bWxoVUhjOFdYOXV0cCtsL3ZXQW0wY2lDYTd5NEY1?=
 =?utf-8?B?dzhQdTJJRFZYK2lISWR4RVUrZXE1dHFvdFRpVzlEekJWZ00vQlhCRXlMTnli?=
 =?utf-8?B?WWJYM2drRVZZams3anpkQ3ZQY0RNMWhyVGdjUlo4RGVibHhRMEpFL0pOWTY1?=
 =?utf-8?B?bDhSclZ0OUltSEp6NE9BTVIyeHo5M21jMGVNRlovZ2FJOWkveU1qZmZmVSt2?=
 =?utf-8?B?RWdOakN2cXpUNkI1bnlpOGJKQS9uRWpkbm0xUjNKTUQ2NVBPZDFSaGdjeVFh?=
 =?utf-8?B?bUw1MWl6Z2xNdUs0RlR5S0s2NS9UNm13L3BSTi9GelM1SUJNNlV0ME5RNzFS?=
 =?utf-8?B?MkRQb20xOEkvUFJ1MjJPUm9CTjBrMmp3OTBheGgwQUZZVXByNTRKK0tMVVZM?=
 =?utf-8?B?Q2g1ZGVNNDR3d0lJR0RiT25hWG8xMjBrNVdQMEo0cG1PQnRSVElYWGxTbElU?=
 =?utf-8?B?elVxRFVHdTQ2VmZhbVI3a0xwUjRZamg4SzMzZXhhQURUbVJqa3VhWDRQVUNn?=
 =?utf-8?B?b2RyNDF3MlQyeGRBVFhvaU1EaVlheFN3Q3VtYlJsRjYzM2hxOU9ZZWpQbjhH?=
 =?utf-8?B?eGV3QUFiTnJiQUxDM0IwUldidFg0dTIzdHYwTnZCeUZjSzRveHptSjg4aUlM?=
 =?utf-8?B?Z0RmdGVFb081MytTb1dndlVKTVp0alZLWFcrUHpMNVI1M0RTWEhJbVZlREdS?=
 =?utf-8?B?VXFDcjlhSll3Wnlub090VDRBdmxEYk90TTVrTVZVWVVkeStHWE5jQXIzR2xr?=
 =?utf-8?B?VUFjaW5QT05qQ0lHeERreGRxOC9NZWxwV3lHRXFRdGpvN0g4dHhuU2dyOHhT?=
 =?utf-8?B?eCszYnAwcXE5cVhDaTJIWlRScXhoeFlXRzY4VGRINkZVbUxvYjJQclJHTkFx?=
 =?utf-8?B?OVhuRnRzNExSNFRBWlJPZ0FnYnBLd0ZXTkI1cWZzRjVZL3lnSGpvaUNIdEIy?=
 =?utf-8?B?eDdUWUY2VVV4SUJ3ekRKTWRkZGF4aEVDc3pEOHdXcE44YS96b2NsRitENk1l?=
 =?utf-8?B?eTJRTTZjRkVpd0ZnZG9YRlg4SytVc3N0RDVKOTNubktURHF6WjlSMjJuN2M4?=
 =?utf-8?B?REpsVDAwc0dZc1M2eEtubExmVXVIeGxLRWlEbk9ZRGhURzF3QU5kbWVtbDFN?=
 =?utf-8?B?elhzbHRGNzEvQ0hxbyttVU1nWWVNT080bW1IL0I3SWNmaGxMRVBSNTRZNStC?=
 =?utf-8?B?Z2FKUXc0MGV1TFgxcGJLN2dLOGFxZVRGOEdhU3FHSHlVVXNLWldRNXBhNThi?=
 =?utf-8?B?Y29pWDNQaXVIQ0NJUitrTXZsdWkxUmpjV0hpOU9VRHNNWEEwZnh6QkYycndE?=
 =?utf-8?B?Ky81b2htMjZXV1NXRlEzTDRrQlE5MjJDRDVGRkxYQmZnczNiMG9nS0wzRFYy?=
 =?utf-8?B?TG82czhiakZLYnhQcVpOV3JnUVZKMGNmN3ZaVHhoMG0yUm5yZVRyYnNSZ3Fm?=
 =?utf-8?B?T3FKbzhYUGV1Y2poejJjbmdmRVUrRVdJWWNZdWRCRGlZMDkwL3o0dHVsVUV0?=
 =?utf-8?B?QUNDVmFrbDN3TytoNG9yMEFSVFNzck4zZnB2VTNabDJRRVl0aFhtaWNsdWJL?=
 =?utf-8?B?MHNDQUVydVJNaDZFaGhCNzBwbGZUZVBuUnpuaHRGc0I0UDhGckdCSlZDKzBX?=
 =?utf-8?Q?ptdS7+5+nstB2COjx5BU4nONEXTOA7QbqF36a87?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fb6a1f-ebfe-4756-c792-08d993bab381
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 11:13:51.0153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unXdx0NvXpI7zXC48A7BXUymxYnrW1hfLmm8fZmoqZTFBgo8unfG4HwmZMDud+XT6QXTa7cuxWfhWryIUJF69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1160
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgT2N0b2JlciAyMCwgMjAyMSAxOjAwIEFNDQo+IFRvOiBIdWFuZywgUmF5IDxSYXku
SHVhbmdAYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb20+OyBWaXJlc2ggS3VtYXINCj4gPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPjsg
U2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47DQo+IEJvcmlzbGF2IFBldGtv
diA8YnBAc3VzZS5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IElu
Z28NCj4gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPjsgTGludXggUE0gPGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZz47DQo+IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNp
ZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0
aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2UpIDxKaW56
aG91LlN1QGFtZC5jb20+Ow0KPiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBM
aW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zz47IHRoZSBhcmNoL3g4NiBtYWludGFpbmVycyA8eDg2QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMDQvMjFdIEFDUEk6IENQUEM6IGFkZCBjcHBjIGVuYWJsZSByZWdpc3Rl
ciBmdW5jdGlvbg0KPiANCj4gT24gU3VuLCBTZXAgMjYsIDIwMjEgYXQgMTE6MDYgQU0gSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBKaW56aG91IFN1
IDxKaW56aG91LlN1QGFtZC5jb20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgZnVuY3Rpb24gdG8gZW5h
YmxlIENQUEMgZmVhdHVyZS4gVGhpcyBmdW5jdGlvbiB3aWxsIHdyaXRlDQo+ID4gQ29udGludW91
cyBQZXJmb3JtYW5jZSBDb250cm9sIHBhY2thZ2UgRW5hYmxlUmVnaXN0ZXIgZmllbGQgb24gdGhl
DQo+ID4gcHJvY2Vzc29yLg0KPiANCj4gQW5kIHdoYXQgaXMgZ29pbmcgdG8gdGFrZSBwbGFjZSBh
ZnRlciB0aGlzIHdyaXRlPw0KPiANCj4gQWxzbywgaXQgd291bGQgYmUgZ29vZCB0byBtZW50aW9u
IHRoYXQgdGhlIHVzZXIgb2YgdGhpcyBmdW5jdGlvbiB3aWxsIGJlIGFkZGVkDQo+IHN1YnNlcXVl
bnRseS4NCg0KQWZ0ZXIgdGhlIGVuYWJsZSBmbGFnIGlzIHNldCwgdGhlIHByb2Nlc3NvciBoYXJk
d2FyZSBjYW4gYWNjZXB0IHRoZSBwZXJmb3JtYW5jZSBnb2FscyBzdWNoIGFzIGRlc2lyZWQgcGVy
ZiB0aGF0IHByb2dyYW1lZCBieSBrZXJuZWwgYW5kIGNvbnRyb2wgdGhlIHByb2Nlc3NvciBmcmVx
dWVuY3kgYWNjb3JkaW5nIHRvIHRoZSBwZXJmb3JtYW5jZSB2YWx1ZS4NCkkgd2lsbCBtZW50aW9u
IHRoaXMgaW4gdGhlIGNvbW1lbnQgaW4gVjMuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlu
emhvdSBTdSA8SmluemhvdS5TdUBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9jcHBjX2Fj
cGkuYyB8IDQ4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBpbmNsdWRlL2FjcGkvY3BwY19hY3BpLmggfCAgNSArKysrKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDUzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Fj
cGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgaW5kZXgNCj4gPiAyZWZl
MmJhOTdkOTYuLmIyODU5NjBjMzVlNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvY3Bw
Y19hY3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBAQCAtMTIy
MCw2ICsxMjIwLDU0IEBAIGludCBjcHBjX2dldF9wZXJmX2N0cnMoaW50IGNwdW51bSwgc3RydWN0
DQo+ID4gY3BwY19wZXJmX2ZiX2N0cnMgKnBlcmZfZmJfY3RycykgIH0NCj4gPiBFWFBPUlRfU1lN
Qk9MX0dQTChjcHBjX2dldF9wZXJmX2N0cnMpOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBjcHBj
X3NldF9lbmFibGUgLSBTZXQgdG8gZW5hYmxlIENQUEMgb24gdGhlIHByb2Nlc3NvciBieSB3cml0
aW5nDQo+ID4gK3RoZQ0KPiA+ICsgKiBDb250aW51b3VzIFBlcmZvcm1hbmNlIENvbnRyb2wgcGFj
a2FnZSBFbmFibGVSZWdpc3RlciBmZWlsZC4NCj4gPiArICogQGNwdTogQ1BVIGZvciB3aGljaCB0
byBlbmFibGUgQ1BQQyByZWdpc3Rlci4NCj4gPiArICogQGVuYWJsZTogMCAtIGRpc2FibGUsIDEg
LSBlbmFibGUgQ1BQQyBmZWF0dXJlIG9uIHRoZSBwcm9jZXNzb3IuDQo+ID4gKyAqDQo+ID4gKyAq
IFJldHVybjogMCBmb3Igc3VjY2VzcywgLUVSUk5PIG9yIC1FSU8gb3RoZXJ3aXNlLg0KPiA+ICsg
Ki8NCj4gPiAraW50IGNwcGNfc2V0X2VuYWJsZShpbnQgY3B1LCB1MzIgZW5hYmxlKSB7DQo+ID4g
KyAgICAgICBpbnQgcGNjX3NzX2lkID0gcGVyX2NwdShjcHVfcGNjX3N1YnNwYWNlX2lkeCwgY3B1
KTsNCj4gPiArICAgICAgIHN0cnVjdCBjcGNfcmVnaXN0ZXJfcmVzb3VyY2UgKmVuYWJsZV9yZWc7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgY3BjX2Rlc2MgKmNwY19kZXNjID0gcGVyX2NwdShjcGNfZGVz
Y19wdHIsIGNwdSk7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY3BwY19wY2NfZGF0YSAqcGNjX3NzX2Rh
dGEgPSBOVUxMOw0KPiA+ICsgICAgICAgaW50IHJldCA9IC0xOw0KPiA+ICsNCj4gPiArICAgICAg
IC8qIGNoZWNrIHRoZSBpbnB1dCB2YWx1ZSovDQo+ID4gKyAgICAgICBpZiAoY3B1IDwgMCB8fCBj
cHUgPiBudW1fcG9zc2libGVfY3B1cygpIC0gMSB8fCBlbmFibGUgPiAxKQ0KPiANCj4gV2h5IG5v
dCB1c2UgY3B1X3Bvc3NpYmxlKCk/ICBBbmQgd2h5IGVuYWJsZSA+IDEgaXMgYSBwcm9ibGVtPw0K
PiANCg0KWWVzLCB5b3UncmUgcmlnaHQsIGNwdV9wb3NzaWJsZSgpIGlzIGJldHRlciBoZXJlLg0K
V2lsbCByZW1vdmUgImVuYWJsZSA+IDEiLCBhbmQgeWVzLCB3ZSBzaG91bGQgc3VwcG9ydCAiZGlz
YWJsZSIgYXMgd2VsbC4NCg0KDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0K
PiANCj4gLUVJTlZBTA0KPiANCg0KVXBkYXRlZC4NCg0KPiA+ICsNCj4gPiArICAgICAgIGlmICgh
Y3BjX2Rlc2MpIHsNCj4gDQo+IGlmIHRoaXMgaXMgY2hlY2tlZCwgdGhlIGNwdV9wb3NzaWJsZSgp
IGNoZWNrIGFib3ZlIGlzIHJlZHVuZGFudC4NCg0KSG1tLCBpZiBhY3BpX2NwcGNfcHJvY2Vzc29y
X3Byb2JlIGdvdCBmYWlsZWQsIHNvbWUgb25lIG91dHNpZGUgYWNwaSBkcml2ZXIgd291bGQgbGlr
ZSB0byBjYWxsIHRoaXMgaGVscGVyLg0KSXMgdGhhdCBwb3NzaWJsZSB3ZSBnZXQgYSBudWxsIGNw
YyBkZXNjcmlwdG9yIGhlcmU/IE9yIGFueXRoaW5nIEkgbWlzc2VkLg0KDQo+IA0KPiA+ICsgICAg
ICAgICAgICAgICBwcl9kZWJ1ZygiTm8gQ1BDIGRlc2NyaXB0b3IgZm9yIENQVTolZFxuIiwgY3B1
KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKyAgICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgICAgZW5hYmxlX3JlZyA9ICZjcGNfZGVzYy0+Y3BjX3JlZ3NbRU5BQkxF
XTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoQ1BDX0lOX1BDQyhlbmFibGVfcmVnKSkgew0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHBjY19zc19pZCA8IDApDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBy
ZXQgPSBjcGNfd3JpdGUoY3B1LCBlbmFibGVfcmVnLCBlbmFibGUpOw0KPiA+ICsgICAgICAgICAg
ICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBwY2Nfc3NfZGF0YSA9IHBjY19kYXRhW3BjY19zc19p
ZF07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBkb3duX3dyaXRlKCZwY2Nfc3NfZGF0YS0+
cGNjX2xvY2spOw0KPiA+ICsgICAgICAgICAgICAgICAvKiBhZnRlciB3cml0aW5nIENQQywgdHJh
bnNmZXIgdGhlIG93bmVyc2hpcCBvZiBQQ0MgdG8gcGxhdGZyb20gKi8NCj4gPiArICAgICAgICAg
ICAgICAgcmV0ID0gc2VuZF9wY2NfY21kKHBjY19zc19pZCwgQ01EX1dSSVRFKTsNCj4gPiArICAg
ICAgICAgICAgICAgdXBfd3JpdGUoJnBjY19zc19kYXRhLT5wY2NfbG9jayk7DQo+ID4gKyAgICAg
ICB9DQo+IA0KPiBEb2VzIGl0IHJlYWxseSBuZWVkIHRvIGRvIG5vdGhpbmcgaWYgdGhlIHJlZ2lz
dGVyIGlzIG5vdCBpbiBQQ0M/ICBJZiBzbywgdGhlbiB3aHk/DQo+IA0KDQpIbW0sIGRvIHlvdSBt
ZWFuIHdlIHNob3VsZCB0YWtlIGNhcmUgdGhlIGNhc2VzIGZvciBlbmFibGluZyBiZWhhdmlvciBp
ZiByZWdpc3RlciBpbiBvdGhlciBzcGFjZXMgc3VjaCBhcyBTWVNURU1fTUVNT1JZIG9yIEZJWEVE
X0hBUkRXQVJFIG9uIGRpZmZlcmVudCBraW5kcyBvZiBTQklPUyBpbXBsZW1lbnRhdGlvbj8NCg0K
VGhhbmtzLA0KUmF5DQo=
