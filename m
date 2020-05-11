Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCC1CD7F0
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgEKLWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 07:22:43 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:62230 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgEKLWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 07:22:43 -0400
X-AuditID: c0a8fbf4-473ff70000004419-63-5eb935810752
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 1F.48.17433.18539BE5; Mon, 11 May 2020 13:22:41 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Mon, 11 May 2020 13:22:29 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] power: supply: Make bd9995x_chip_reset static
Thread-Topic: [PATCH -next] power: supply: Make bd9995x_chip_reset static
Thread-Index: AQHWJ4RI9k+/do5SNk+x8ujOfU5vjqiinGQA
Date:   Mon, 11 May 2020 11:22:26 +0000
Message-ID: <ff7faf0add4155a10e3df12fceea8bda17050021.camel@fi.rohmeurope.com>
References: <1589195577-8723-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1589195577-8723-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD505BECFCC1BA488BB47146A054A152@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsVyYMXvjbqNpjvjDH5vN7PobZrOZHF51xw2
        i8+9RxgtTu8usXj04QibA6tHy5G3rB6bVnWyecw7GejxeZNcAEsUt01SYklZcGZ6nr5dAnfG
        7BVaBT08FecWeDQwPuHuYuTkkBAwkTg+4RFTFyMXh5DANUaJn19bWSCcE4wSt77OZu5i5OBg
        E7CR6LrJDtIgIhAk8XDZPGYQm1ngKKPEi/UFILawgIfE9slfmSBqPCWmzV4NVW8k0bL6GFg9
        i4CqxI3bcxhBRvIK+En83acKEhYScJTYNuUIWAmngJNEV+t+FhCbUUBWorPhHRPEKnGJTc++
        s0LcLCCxZM95ZghbVOLl439QcUWJ7d/XsYCMZxbQlFi/Sx/CdJD4dTwHYoqixJTuh2CH8QoI
        Spyc+YRlAqPYLCQLZiE0z0JonoWkeRaS5gWMrKsYJXITM3PSE0tSDfWKUkv1ivIzcoFUcn7u
        JkZI9H3Zwfj/kOchRiYOxkOMkhxMSqK8p7R2xgnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4fW4
        tyNOiDclsbIqtSgfJiXNwaIkzqv+cGKskADIruzU1ILUIpisDAeHkgSvmgnQUMGi1PTUirTM
        nBKENBMHJ8hwLimR4tS8lNSixNKSjHhQyogvBiYNkBQP0N6ZIO28xQWJuUBRiNZTjIYcE17O
        XcTMcXLVEiB5ZO7SRcxCLHn5ealS4rw/QBoEQBoySvPg1r1iFOdgVBLmNQAmWSEeYEqGm/YK
        aBET0KKHz7eBLCpJREhJNTDq/1bWKLrzc5KuyvN853kG3Y+yNkdc/L79hfJO06VFyqa/9hWa
        zOnZeXjfGcUjHBHrL3+1nrz04I8dK687a3q/vHEgo7vzxNqZ2qFRJTIaK8/OmzI7x1P9jo7Z
        ySvVcprXrm9sYwqXXOBlbmUQum/ib22m7ZceKa46wM7JoHDpoUWL7s3i54LeSizFGYmGWsxF
        xYkATXh7yYYDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBNb24sIDIwMjAtMDUtMTEgYXQgMTk6MTIgKzA4MDAsIFNhbXVlbCBab3Ugd3JvdGU6DQo+
IEZpeCB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOg0KPiANCj4gZHJpdmVycy9wb3dlci9z
dXBwbHkvYmQ5OTk1NC1jaGFyZ2VyLmM6MTAyODo2OiB3YXJuaW5nOiBzeW1ib2wNCj4gJ2JkOTk5
NXhfY2hpcF9yZXNldCcgd2FzIG5vdCBkZWNsYXJlZC4NCj4gDQo+IFRoZSBiZDk5OTV4X2NoaXBf
cmVzZXQoKSBoYXMgb25seSBvbmUgY2FsbCBzaXRlIHdpdGhpbiBiZDk5OTU0LQ0KPiBjaGFyZ2Vy
LmMNCj4gSXQgc2hvdWxkIGJlIHN0YXRpYw0KPiANCj4gRml4ZXM6IDA5MDJmODM2NjQ5MSAoInBv
d2VyOiBzdXBwbHk6IFN1cHBvcnQgUk9ITSBiZDk5OTU0IGNoYXJnZXIiKQ0KPiBSZXBvcnRlZC1i
eTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNhbXVl
bCBab3UgPHpvdV93ZWlAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZhaXR0aW5l
biA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9wb3dlci9zdXBwbHkvYmQ5OTk1NC1jaGFyZ2VyLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Bvd2VyL3N1cHBseS9iZDk5OTU0LWNoYXJnZXIuYw0KPiBiL2RyaXZlcnMvcG93ZXIvc3Vw
cGx5L2JkOTk5NTQtY2hhcmdlci5jDQo+IGluZGV4IDNkYTM5YzcuLmZmZDhiZmEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2JkOTk5NTQtY2hhcmdlci5jDQo+ICsrKyBiL2Ry
aXZlcnMvcG93ZXIvc3VwcGx5L2JkOTk5NTQtY2hhcmdlci5jDQo+IEBAIC0xMDI1LDcgKzEwMjUs
NyBAQCBzdGF0aWMgaW50IGJkOTk5NXhfZndfcHJvYmUoc3RydWN0DQo+IGJkOTk5NXhfZGV2aWNl
ICpiZCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtdm9pZCBiZDk5OTV4X2NoaXBfcmVz
ZXQodm9pZCAqYmQpDQo+ICtzdGF0aWMgdm9pZCBiZDk5OTV4X2NoaXBfcmVzZXQodm9pZCAqYmQp
DQo+ICB7DQo+ICAJX19iZDk5OTV4X2NoaXBfcmVzZXQoYmQpOw0KPiAgfQ0KDQo=
