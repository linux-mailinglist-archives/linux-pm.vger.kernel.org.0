Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF5268B93
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgINM6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 08:58:37 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:38931 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgINM6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 08:58:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08253667|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.012044-0.00337727-0.984579;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=liush@allwinnertech.com;NM=1;PH=DW;RN=14;RT=14;SR=0;TI=W4_5948689_DEFAULT_0A93261A_1600088218642_o7001c1057e;
Received: from WS-web (liush@allwinnertech.com[W4_5948689_DEFAULT_0A93261A_1600088218642_o7001c1057e]) by ay29a011140100189.et135 at Mon, 14 Sep 2020 20:58:02 +0800
Date:   Mon, 14 Sep 2020 20:58:02 +0800
From:   "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
To:     "paul.walmsley" <paul.walmsley@sifive.com>,
        "palmer" <palmer@dabbelt.com>, "aou" <aou@eecs.berkeley.edu>,
        "rjw" <rjw@rjwysocki.net>, "anup.patel" <anup.patel@wdc.com>,
        "atish.patra" <atish.patra@wdc.com>,
        "damien.lemoal" <damien.lemoal@wdc.com>,
        "wangkefeng.wang" <wangkefeng.wang@huawei.com>,
        "kernel" <kernel@esmil.dk>, "zong.li" <zong.li@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc:     "linux-riscv" <linux-riscv@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-pm" <linux-pm@vger.kernel.org>
Reply-To: "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
Message-ID: <58abe153-689d-460c-a119-91270cd110cf.liush@allwinnertech.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSBjcHVpZGxlOiBhZGQgcmlzY3YgY3B1aWRsZSBkcml2ZXI=?=
X-Mailer: [Alimail-Mailagent][W4_5948689][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>,<80bc85f5-fba3-5f08-4d73-372b5f495833@linaro.org>
In-Reply-To: <80bc85f5-fba3-5f08-4d73-372b5f495833@linaro.org>
x-aliyun-mail-creator: W4_5948689_DEFAULT_MzYTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODUuMC40MTgzLjEwMiBTYWZhcmkvNTM3LjM2zc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRGFuaWVsLAo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgY3B1aWRsZSBkcml2ZXIgZm9yIHN5c3Rl
bXMgYmFzZWQgUklTQ1YgYXJjaGl0ZWN0dXJlLgo+ID4gVGhpcyBwYXRjaCBzdXBwb3J0cyBzdGF0
ZSBXRkkuIE90aGVyIHN0YXRlcyB3aWxsIGJlIHN1cHBvcnRlZCBpbiB0aGUKPiA+IGZ1dHVyZS4K
PiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogbGl1c2ggPGxpdXNoQGFsbHdpbm5lcnRlY2guY29tPgo+
ID4gLS0tCj4gCj4gWyAuLi4gXQo+IAo+ID4gIAo+ID4gIG9iai0kKENPTkZJR19SSVNDVl9NX01P
REUpICs9IHRyYXBzX21pc2FsaWduZWQubwo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2Vy
bmVsL2NwdWlkbGUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWlkbGUuYwo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwLi5hMzI4OWU3Cj4gPiAtLS0gL2Rldi9udWxs
Cj4gPiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcHVpZGxlLmMKPiA+IEBAIC0wLDAgKzEsOCBA
QAo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gPiArI2luY2x1ZGUg
PGFzbS9jcHVpZGxlLmg+Cj4gPiArCj4gPiArdm9pZCBjcHVfZG9faWRsZSh2b2lkKQo+ID4gK3sK
PiA+ICsgX19hc21fXyBfX3ZvbGF0aWxlX18gKCJ3ZmkiKTsKPiA+ICsKPiAKPiBleHRyYSBsaW5l
Cj4gCj4gPiArfQoKPiBBcyBmb3IgdGhlIG5leHQgZGVlcGVyIHN0YXRlcyBzaG91bGQgZW5kIHVw
IHdpdGggdGhlIGNwdV9kb19pZGxlCj4gZnVuY3Rpb24sIGlzbid0IHRoZXJlIGFuIGV4dHJhIG9w
ZXJhdGlvbiB3aXRoIHRoZSB3ZmkoKSBsaWtlIGZsdXNoaW5nCj4gdGhlIGwxIGNhY2hlPwoKRGF0
YSBjYWNoZSBjb25zaXN0ZW5jeSBpcyBtYWlubHkgZW5zdXJlZCBieSBoYXJkd2FyZSBpbiByaXNj
diwgYW5kIHRoZXJlIGlzIG5vIAppbXBsZW1lbnRhdGlvbiBvZiBmbHVzaGluZyBkYXRhIGNhY2hl
IGluIGtlcm5lbC4gQmVmb3JlIHdmaSgpLGFkZCBhbiBtZW1vcnkgCmJhcnJpZXIgb3BlcmF0aW9u
IC0gbWIoKS4gSXMgdGhpcyBmZWFzaWJsZT8gCgogIC8vYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9i
YXJyaWVyLmgKCiAgMTcgI2RlZmluZSBSSVNDVl9GRU5DRShwLCBzKSBcCiAgMTggICAgICAgICBf
X2FzbV9fIF9fdm9sYXRpbGVfXyAoImZlbmNlICIgI3AgIiwiICNzIDogOiA6ICJtZW1vcnkiKQog
IDE5IAogIDIwIC8qIFRoZXNlIGJhcnJpZXJzIG5lZWQgdG8gZW5mb3JjZSBvcmRlcmluZyBvbiBi
b3RoIGRldmljZXMgb3IgbWVtb3J5LiAqLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogIDIxICNkZWZpbmUgbWIoKSAgICAgICAgICAgIFJJU0NWX0ZF
TkNFKGlvcncsaW9ydykgCgoKQWZ0ZXIgbW9kaWZpY2F0aW9uLCB0aGUgY29kZXMgaXMgYXMgZm9s
bG93cy4KCjgxIEBAIC0wLDAgKzEsOCBAQAo4MiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAKODMgKyNpbmNsdWRlIDxhc20vY3B1aWRsZS5oPgo4NCArCjg1ICt2b2lkIGNwdV9k
b19pZGxlKHZvaWQpCjg2ICt7Cjg3ICsgICAgICAgbWIoKTsKODggKyAgICAgICBfX2FzbV9fIF9f
dm9sYXRpbGVfXyAoIndmaSIpOwo4OSArCjkwICt9Cgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1aWRsZS9LY29uZmlnIGIvZHJpdmVycy9jcHVpZGxlL0tjb25maWcKPiA+IGluZGV4IGMwYWVl
ZGQuLmY2YmUwZmQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2NwdWlkbGUvS2NvbmZpZwo+ID4g
KysrIGIvZHJpdmVycy9jcHVpZGxlL0tjb25maWcKPiA+IEBAIC02Miw2ICs2MiwxMSBAQCBkZXBl
bmRzIG9uIFBQQwo+ID4gIHNvdXJjZSAiZHJpdmVycy9jcHVpZGxlL0tjb25maWcucG93ZXJwYyIK
PiA+ICBlbmRtZW51Cj4gPiAgCj4gPiArbWVudSAiUklTQ1YgQ1BVIElkbGUgRHJpdmVycyIKPiA+
ICtkZXBlbmRzIG9uIFJJU0NWCj4gPiArc291cmNlICJkcml2ZXJzL2NwdWlkbGUvS2NvbmZpZy5y
aXNjdiIKPiA+ICtlbmRtZW51Cj4gPiArCj4gPiAgY29uZmlnIEhBTFRQT0xMX0NQVUlETEUKPiA+
ICAgdHJpc3RhdGUgIkhhbHQgcG9sbCBjcHVpZGxlIGRyaXZlciIKPiA+ICAgZGVwZW5kcyBvbiBY
ODYgJiYgS1ZNX0dVRVNUCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVpZGxlL0tjb25maWcu
cmlzY3YgYi9kcml2ZXJzL2NwdWlkbGUvS2NvbmZpZy5yaXNjdgo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwLi5lODZkMzZiCj4gPiAtLS0gL2Rldi9udWxsCj4gPiAr
KysgYi9kcml2ZXJzL2NwdWlkbGUvS2NvbmZpZy5yaXNjdgo+ID4gQEAgLTAsMCArMSwxMSBAQAo+
ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ID4gKyMKPiA+ICsj
IFJJU0NWIENQVSBJZGxlIGRyaXZlcnMKPiA+ICsjCj4gPiArY29uZmlnIFJJU0NWX0NQVUlETEUK
PiA+ICsgICAgICAgIGJvb2wgIkdlbmVyaWMgUklTQ1YgQ1BVIGlkbGUgRHJpdmVyIgo+ID4gKyAg
ICAgICAgc2VsZWN0IERUX0lETEVfU1RBVEVTCj4gPiArIHNlbGVjdCBDUFVfSURMRV9NVUxUSVBM
RV9EUklWRVJTCj4gPiArICAgICAgICBoZWxwCj4gPiArICAgICAgICAgIFNlbGVjdCB0aGlzIG9w
dGlvbiB0byBlbmFibGUgZ2VuZXJpYyBjcHVpZGxlIGRyaXZlciBmb3IgUklTQ1YuCj4gPiArICAg
Tm93IG9ubHkgc3VwcG9ydCBDMCBTdGF0ZS4KPiAKPiBJZGVudGF0aW9uCgpJJ2xsIGZpeCBpdC4g
VGhhbmsgeW91IQ==
