Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A381271B
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfECFaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 01:30:02 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:58930 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECFaC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 01:30:02 -0400
X-AuditID: c0a8fbf4-501ff700000014c1-38-5ccbd1d6c247
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 00.CF.05313.6D1DBCC5; Fri,  3 May 2019 07:29:58 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Fri, 3 May 2019 07:29:54 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 7/8] power: supply: Initial support for ROHM BD70528
 PMIC charger block
Thread-Topic: [PATCH v14 7/8] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Thread-Index: AQHVAMfZHKgWTJ2VgUSUAlV6mCtylaZYHZeAgAChyIA=
Date:   Fri, 3 May 2019 05:29:53 +0000
Message-ID: <322fa765ddd72972aba931c706657661ca685afa.camel@fi.rohmeurope.com>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
         <eece016c86483d55befab1a06fb299c9d6d17134.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
         <20190502195049.brysexbyyq7khtr4@earth.universe>
In-Reply-To: <20190502195049.brysexbyyq7khtr4@earth.universe>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EECE8E2DA13B254A9D94FC7DADE8ADED@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUwURxjO7MftHrDNcJ7eFHuNXk0bTUFNjE5a25p+2KVNTWNb0jbEYykr
        S+Q+snugtH+IH7FHa6QWUznhtAbU2ivGM02BaMNdqSgQlJSiKCclXDGgQC9QkEjO7rhV+DPz
        zPvM8zzvJO/wtGUvl8EXuX2y6paKHaYUpuX0g3Bmb3dH7pqje1fiuu4/Obx//CSHp2rbGXx4
        MG7Cx1q7WDzw7+8AT/d8SeGquVMUTnx9m8Xnj80B/EdzjQlPHmgF+NKPPSZ8o+FXDse/76Rw
        /fVuCtfUX2Zwd/tbeN/FVg4ne88xOHZ3Cx4aSdKbloihYAiIEzf2cWIw9IXYGKsDYlMgxonh
        M36T2N97wST+EAqxYtNMOSd+F5ylxMnws++nfpq6MV/ylX5QVOhe/WpeqnL/1k+MN7lsV0fX
        N1Q5qFxWAcw8guvQpf09oAKk8BbYC1Db2d2UcWgDqK9zVD/wvAluRBV9HIFW+DaqrhLJFRr+
        bUaRgw9ZYrQISujoWBAQbIX56K+2ZsbAL6Gb/lM0wQxcgfZEJh7dEeAWdO/+bdrIug5Q6B//
        IyMzfAX5+/dwBANoR/7ycYpgGtpQeHiGNbqGqO7CVdrAi9HIUPL/ugNdnB1kSKM0XInONq82
        pJvQt/2jrIGXo6qvBjmjh3R0pTrOVIIlgQUJgXl1YIE6sEAdWKA+DtgzALmkouJCySevzVLl
        kizVo7j07TOPKwyM2ZlqBA+j2VEAeeBIE6avdORaWKlUK3NFwdM85VgsBFv00lP5noIyRdIU
        p1pSLGtRgHjaYRW2JdpzLUKBVPa5rHoeU0t5xmETHjRHci2QJO+QZa+sPmaf4XkHEt69ppum
        q3KhvGt7UbFvnqZ4MzFPybBqsrtAVqUSn+Ik0+LU9HEhVJqe20DkguaVXHrVkLaDDXzLicFa
        mo/MkPXIwLC+jkXu1NIWxu1xyxk2IXZVl0EiU0rcT0JHgU1/+yIhStg0/Ws98RzV4yg97s4h
        8kzNJ81TGeXg/MEEzsr0rnntk4k8i/+NxvHp+pz0ypwx+0f5xzf/fDf7N5BuX7Vz247nl77Y
        8MuhF9YvX8fW2GvfUxo+vndY6Tkyt2Jr11xwQ5Kunr25e+CdDw9kTpvj4bwTwzbrc/amKW+2
        7Jw0Nzm7fHTpwLnXc+KJ2LVEJ35zZGbny6c3e7W+IQejKdLaVbSqSf8BrLZD8xcEAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gU2ViYXN0aWFuLA0KDQpPbiBUaHUsIDIwMTktMDUtMDIgYXQgMjE6NTAgKzAyMDAsIFNl
YmFzdGlhbiBSZWljaGVsIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIFRodSwgTWF5IDAyLCAyMDE5
IGF0IDEyOjE3OjEyUE0gKzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBST0hNIEJE
NzA1MjggUE1JQyBpbmNsdWRlcyBiYXR0ZXJ5IGNoYXJnZXIgYmxvY2suIFN1cHBvcnQgY2hhcmdl
cg0KPiA+IHN0YXVzIHF1ZXJpZXMgYW5kIGRvaW5nIGZldyBiYXNpYyBzZXR0aW5ncyBsaWtlIGlu
cHV0IGN1cnJlbnQgbGltaXQNCj4gPiBhbmQgY2hhcmdpbmcgY3VycmVudC4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVy
b3BlLmNvbT4NCj4gPiBBY2tlZC1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5yZWlj
aGVsQGNvbGxhYm9yYS5jb20+DQo+IA0KPiBQbGVhc2Ugb25seSBhZGQgQWNrZWQtYnkgd2hlbiB5
b3UgcmVjZWl2ZSBvbmUsIGVzcGVjaWFsbHkgd2hlbiB5b3UNCj4gZG8gbm90IGltcGxlbWVudCBh
bGwgcmVxdWVzdGVkIGNoYW5nZXMgOikNCg0KU29ycnkuIFRoaXMgaXMgbXkgYmFkLiBJIHRyYW5z
bGF0ZWQgeW91cjogIk90aGVyd2lzZSBsb29rcyBvayB0byBtZS4iDQotIHRvIGFuIGFjay4gQW5k
IEkgd2FzIHByZXR0eSBzdXJlIHlvdSBkaWRuJ3Qgd2FudCB0byBzdGF0aWNpemUgdGhlDQpsb2Nh
bCBhcnJheS4gSSBzaG91bGQndmUga25vd24gYmV0dGVyLiBJIHNob3VsZCBoYXZlIHdhaXRlZCBm
b3IgeW91ciBPaw0KdG8gbGVhdmluZyB0aGUgc3RhdGljIG91dCBiZWZvcmUgYWRkaW5nIGFuIGFj
ay4NCg0KPiANCj4gPiArc3RhdGljIGludCBiZDcwNTI4X2dldF9pcnFzKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYsDQo+ID4gKwkJCSAgICBzdHJ1Y3QgYmQ3MDUyOF9wc3kgKmJkcHN5KQ0K
PiA+ICt7DQo+ID4gKwlpbnQgaXJxLCBpLCByZXQ7DQo+ID4gKwl1bnNpZ25lZCBpbnQgbWFzazsN
Cj4gPiArCWNvbnN0IHN0cnVjdCBpcnFfbmFtZV9wYWlyIGJkNzA1MjhfY2hnX2lycXNbXSA9IHsN
Cj4gPiArCQl7IC5uID0gImJkNzA1MjgtYmF0LW92LXJlcyIsIC5oID0NCj4gPiBCRF9JUlFfSE5E
KEJBVF9PVl9SRVMpIH0sDQo+ID4gKwkJeyAubiA9ICJiZDcwNTI4LWJhdC1vdi1kZXQiLCAuaCA9
DQo+ID4gQkRfSVJRX0hORChCQVRfT1ZfREVUKSB9LA0KPiA+ICsJCXsgLm4gPSAiYmQ3MDUyOC1i
YXQtZGVhZCIsIC5oID0gQkRfSVJRX0hORChEQkFUX0RFVCkgfSwNCj4gPiArCQl7IC5uID0gImJk
NzA1MjgtYmF0LXdhcm1lZCIsIC5oID0gQkRfSVJRX0hORChDT0xEX1JFUykNCj4gPiB9LA0KPiA+
ICsJCXsgLm4gPSAiYmQ3MDUyOC1iYXQtY29sZCIsIC5oID0gQkRfSVJRX0hORChDT0xEX0RFVCkg
fSwNCj4gPiArCQl7IC5uID0gImJkNzA1MjgtYmF0LWNvb2xlZCIsIC5oID0gQkRfSVJRX0hORChI
T1RfUkVTKQ0KPiA+IH0sDQo+ID4gKwkJeyAubiA9ICJiZDcwNTI4LWJhdC1ob3QiLCAuaCA9IEJE
X0lSUV9ITkQoSE9UX0RFVCkgfSwNCj4gPiArCQl7IC5uID0gImJkNzA1MjgtY2hnLXRzaGQiLCAu
aCA9IEJEX0lSUV9ITkQoQ0hHX1RTRCkgfSwNCj4gPiArCQl7IC5uID0gImJkNzA1MjgtYmF0LXJl
bW92ZWQiLCAuaCA9IEJEX0lSUV9ITkQoQkFUX1JNVikNCj4gPiB9LA0KPiA+ICsJCXsgLm4gPSAi
YmQ3MDUyOC1iYXQtZGV0ZWN0ZWQiLCAuaCA9IEJEX0lSUV9ITkQoQkFUX0RFVCkNCj4gPiB9LA0K
PiA+ICsJCXsgLm4gPSAiYmQ3MDUyOC1kY2luMi1vdi1yZXMiLCAuaCA9DQo+ID4gQkRfSVJRX0hO
RChEQ0lOMl9PVl9SRVMpIH0sDQo+ID4gKwkJeyAubiA9ICJiZDcwNTI4LWRjaW4yLW92LWRldCIs
IC5oID0NCj4gPiBCRF9JUlFfSE5EKERDSU4yX09WX0RFVCkgfSwNCj4gPiArCQl7IC5uID0gImJk
NzA1MjgtZGNpbjItcmVtb3ZlZCIsIC5oID0NCj4gPiBCRF9JUlFfSE5EKERDSU4yX1JNVikgfSwN
Cj4gPiArCQl7IC5uID0gImJkNzA1MjgtZGNpbjItZGV0ZWN0ZWQiLCAuaCA9DQo+ID4gQkRfSVJR
X0hORChEQ0lOMl9ERVQpIH0sDQo+ID4gKwkJeyAubiA9ICJiZDcwNTI4LWRjaW4xLXJlbW92ZWQi
LCAuaCA9DQo+ID4gQkRfSVJRX0hORChEQ0lOMV9STVYpIH0sDQo+ID4gKwkJeyAubiA9ICJiZDcw
NTI4LWRjaW4xLWRldGVjdGVkIiwgLmggPQ0KPiA+IEJEX0lSUV9ITkQoRENJTjFfREVUKSB9LA0K
PiA+ICsJfTsNCj4gDQo+IFBsZWFzZSBhbHNvIG1ha2UgaXQgc3RhdGljLiBUaGF0IHdpbGwgbW92
ZSB0aGUgd2hvbGUgdGhpbmcgdG8NCj4gcmVhZC1vbmx5IChiZWNhdXNlIG9mIGNvbnN0KSBkYXRh
IHNlY3Rpb24uIFRoaXMgaW1wcm92ZXMgdGhlDQo+IHNlY3VyaXR5IGFuZCB0aGUgcmVxdWlyZWQg
Y3B1IHRpbWUgYXQgdGhlIHNhbWUgdGltZSAobm8gbmVlZA0KPiB0byBjb3B5IHZhbHVlcyB0byB0
aGUgc3RhY2spLg0KDQpPay4gSSBzZWUgeW91ciBwb2ludCBhbmQgaXQgc291bmRzIHJlYXNvbmFi
bGUuDQoNCj4gQnV0IHRoaXMgY2FuIGJlIGNoYW5nZWQgbGF0ZXIsIHNvIG5vIG5lZWQgdG8gYmxv
Y2sgdGhlIHdob2xlDQo+IHBhdGNoc2V0IGp1c3QgYmVjYXVzZSBvZiB0aGlzLiBJZiBMZWUgd2Fu
dHMgdG8gbWVyZ2UgdGhpcyBmb3INCj4gNS4yLCB0aGF0IHdvdWxkIGJlIGZpbmUgd2l0aCBtZS4g
QnV0IHBsZWFzZSBhZGQgaXQgZGlyZWN0bHkgaW4NCj4gYSBuZXcgcGF0Y2ggcmV2aXNpb24gaWYg
dGhlIHBhdGNoIGRvZXMgbm90IG1ha2UgaXQgaW50byA1LjIuDQoNCkl0IHdvdWxkIGJlIGdyZWF0
IHRvIGdldCB0aGlzIGluLCBpdCBoYXMgYmVlbiByZXNwaW5uZWQgcXVpdGUgYSBmZXcNCnRpbWVz
IGFscmVhZHkuLi4gSSBob3BlIExlZSB0YWtlcyB0aGUgc2VyaWVzIGluIHdoZW4gaGUncyBiYWNr
IGZyb20gaGlzDQpsZWF2ZSAtIGJ1dCBpdCBpcyBub3QgYSBwcm9ibGVtIGZvciBtZSB0byBjaGFu
Z2UgdGhpcyB3aXRoIGxhdGVyIHBhdGNoDQoob3IgY2hhbmdlIHRoaXMgaW4gdGhlIHNlcmllcyBp
ZiBpdCBzdGlsbCBuZWVkcyB0byBiZSByZXdvcmtlZCkuDQoNCg0KQnIsDQoJTWF0dGkgVmFpdHRp
bmVuDQo=
