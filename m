Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8B125D7F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLSJVO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:21:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1438 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbfLSJVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:21:14 -0500
X-UUID: 2c07b6a116b84b53a04f91a9c9655af2-20191219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bVBH3anMpg7sIakLusrAPASLtbu9DJT61K8Oiyp5egE=;
        b=u4sdzU0bD+BoYr3azsQ67X21n3DbJEamceKEH9mJAW5zI9fb8zgsG4kwdu6B5GrSshxg5qrgcJlVyWji+24WldenlqtFWVeyWBCXKYtU6uRgaEmc5JC3xaCa56plWd2fW45nzebN65UIb6KXIVDluKeNwDdO6+SiYS1yjmirIuI=;
X-UUID: 2c07b6a116b84b53a04f91a9c9655af2-20191219
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 483592169; Thu, 19 Dec 2019 17:21:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Dec 2019 17:20:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Dec 2019 17:21:08 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND] thermal: mediatek: add suspend/resume callback
Date:   Thu, 19 Dec 2019 17:21:02 +0800
Message-ID: <20191219092103.8839-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TG91aXMgWXUgKDEpOg0KICB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3BlbmQvcmVzdW1lIGNh
bGxiYWNrDQoNCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDEzNCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KNDNjNjFhOGVjMWRjYzdmMmUyMDIgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxDQpGcm9tOiBNaWNoYWVsIEthbyA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0K
RGF0ZTogVGh1LCAxOSBEZWMgMjAxOSAxNzowODozMiArMDgwMA0KU3ViamVjdDogW1JFU0VORF0g
dGhlcm1hbDogbWVkaWF0ZWs6IGFkZCBzdXNwZW5kL3Jlc3VtZSBjYWxsYmFjaw0KDQpUaGUgcGF0
Y2ggYmFzZSBvbiBLZW5yZWwgNS41LXJjMS4NCkkgcmVzZW50IHdpdGhvdXQgbmV3IG1vZGlmaWNh
dGlvbiBqdXN0IGJlY2F1c2UgSSBtaXNzZWQgbGludXgtcG0gaW4gbXkgc2VuZGluZyBsaXN0Lg0K
DQpMb3VpcyBZdSAoMSk6DQogIHRoZXJtYWw6IG1lZGlhdGVrOiBhZGQgc3VzcGVuZC9yZXN1bWUg
Y2FsbGJhY2sNCg0KIGRyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jIHwgMTM0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTI1IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo0M2M2MWE4ZWMxZGNjN2YyZTIwMiBNb24gU2VwIDE3IDAw
OjAwOjAwIDIwMDENCkZyb206IE1pY2hhZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+
DQpEYXRlOiBUaHUsIDE5IERlYyAyMDE5IDE3OjA4OjMyICswODAwDQpTdWJqZWN0OiBbUkVTRU5E
XSB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrDQoNClRoZSBw
YXRjaCBiYXNlIG9uIEtlbnJlbCA1LjUtcmMxLg0KSSByZXNlbnQgd2l0aG91dCBuZXcgbW9kaWZp
Y2F0aW9uIGp1c3QgYmVjYXVzZSBJIG1pc3NlZCBsaW51eC1wbSBpbiBteSBzZW5kaW5nIGxpc3Qu
DQoNCkxvdWlzIFl1ICgxKToNCiAgdGhlcm1hbDogbWVkaWF0ZWs6IGFkZCBzdXNwZW5kL3Jlc3Vt
ZSBjYWxsYmFjaw0KDQogZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgfCAxMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMjUgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCjQzYzYxYThlYzFkY2M3ZjJlMjAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNv
bT4NCkRhdGU6IFRodSwgMTkgRGVjIDIwMTkgMTc6MDg6MzIgKzA4MDANClN1YmplY3Q6IFtSRVNF
TkRdIHRoZXJtYWw6IG1lZGlhdGVrOiBhZGQgc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2sNCg0KVGhl
IHBhdGNoIGJhc2Ugb24gS2VucmVsIDUuNS1yYzEuDQpJIHJlc2VudCB3aXRob3V0IG5ldyBtb2Rp
ZmljYXRpb24ganVzdCBiZWNhdXNlIEkgbWlzc2VkIGxpbnV4LXBtIGluIG15IHNlbmRpbmcgbGlz
dC4NCg0KTG91aXMgWXUgKDEpOg0KICB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3BlbmQvcmVz
dW1lIGNhbGxiYWNrDQoNCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDEzNCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KNDNjNjFhOGVjMWRjYzdmMmUyMDIgTW9uIFNlcCAx
NyAwMDowMDowMCAyMDAxDQpGcm9tOiBNaWNoYWVsIEthbyA8bWljaGFlbC5rYW9AbWVkaWF0ZWsu
Y29tPg0KRGF0ZTogVGh1LCAxOSBEZWMgMjAxOSAxNzowODozMiArMDgwMA0KU3ViamVjdDogW1JF
U0VORF0gdGhlcm1hbDogbWVkaWF0ZWs6IGFkZCBzdXNwZW5kL3Jlc3VtZSBjYWxsYmFjaw0KDQpU
aGUgcGF0Y2ggYmFzZSBvbiBLZW5yZWwgNS41LXJjMS4NCkkgcmVzZW50IHdpdGhvdXQgbmV3IG1v
ZGlmaWNhdGlvbiBqdXN0IGJlY2F1c2UgSSBtaXNzZWQgbGludXgtcG0gaW4gbXkgc2VuZGluZyBs
aXN0Lg0KDQpMb3VpcyBZdSAoMSk6DQogIHRoZXJtYWw6IG1lZGlhdGVrOiBhZGQgc3VzcGVuZC9y
ZXN1bWUgY2FsbGJhY2sNCg0KIGRyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jIHwgMTM0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTI1IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo0M2M2MWE4ZWMxZGNjN2YyZTIwMiBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IE1pY2hhZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRl
ay5jb20+DQpEYXRlOiBUaHUsIDE5IERlYyAyMDE5IDE3OjA4OjMyICswODAwDQpTdWJqZWN0OiBb
UkVTRU5EXSB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrDQoN
ClRoZSBwYXRjaCBiYXNlIG9uIEtlbnJlbCA1LjUtcmMxLg0KSSByZXNlbnQgd2l0aG91dCBuZXcg
bW9kaWZpY2F0aW9uIGp1c3QgYmVjYXVzZSBJIG1pc3NlZCBsaW51eC1wbSBpbiBteSBzZW5kaW5n
IGxpc3QuDQoNCkxvdWlzIFl1ICgxKToNCiAgdGhlcm1hbDogbWVkaWF0ZWs6IGFkZCBzdXNwZW5k
L3Jlc3VtZSBjYWxsYmFjaw0KDQogZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgfCAxMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMjUg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCjQzYzYxYThlYzFkY2M3ZjJlMjAyIE1vbiBT
ZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlh
dGVrLmNvbT4NCkRhdGU6IFRodSwgMTkgRGVjIDIwMTkgMTc6MDg6MzIgKzA4MDANClN1YmplY3Q6
IFtSRVNFTkRdIHRoZXJtYWw6IG1lZGlhdGVrOiBhZGQgc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2sN
Cg0KVGhlIHBhdGNoIGJhc2Ugb24gS2VucmVsIDUuNS1yYzEuDQpJIHJlc2VudCB3aXRob3V0IG5l
dyBtb2RpZmljYXRpb24ganVzdCBiZWNhdXNlIEkgbWlzc2VkIGxpbnV4LXBtIGluIG15IHNlbmRp
bmcgbGlzdC4NCg0KTG91aXMgWXUgKDEpOg0KICB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3Bl
bmQvcmVzdW1lIGNhbGxiYWNrDQoNCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDEz
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEy
NSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQo=

