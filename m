Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00D132029
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 08:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgAGHCX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 02:02:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59067 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgAGHCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 02:02:21 -0500
X-UUID: ec656c754bc74df4a1004d53a349acb6-20200107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RvU/Kf9/Q/5yNWiwRa+kdVfxoeAOhMP7au0EssfZUn8=;
        b=d7EBZApsUd8bRPNaXuK/3QblvdUscYwQyufhd5DJjfDlqH15N+p0RJlL3rDpR5HBNBO6bRmAS85YxJaW9BjHA19M6UcHXJtZJ4MhRgPRJcrHWY9m56NR0hkeKGkH19LhbN+r9vasBbm6zPUNEwY0prWboGENvXaq3Kbj0aZjqfc=;
X-UUID: ec656c754bc74df4a1004d53a349acb6-20200107
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 967155660; Tue, 07 Jan 2020 15:02:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 Jan 2020 15:01:41 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 Jan 2020 15:01:09 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: PM / AVS: SVS: Introduce SVS engine
Date:   Tue, 7 Jan 2020 15:01:51 +0800
Message-ID: <20200107070154.1574-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MS4gU1ZTIGRyaXZlciB1c2UgT1BQIGFkanVzdCBldmVudCBpbiBbMV0gdG8gdXBkYXRlIE9QUCB0
YWJsZSB2b2x0YWdlIHBhcnQuDQoyLiBTVlMgZHRzIG5vZGUgcmVmZXJzIHRvIENQVSBvcHAgdGFi
bGUgWzJdIGFuZCBHUFUgb3BwIHRhYmxlIFszXS4NCjMuIFNWUyBhbmQgdGhlcm1hbCBkdHMgdXNl
IHRoZSBzYW1lIHRoZXJtYWwgZWZ1c2UgWzRdLg0KNC4gU1ZTIGR0cyBuZWVkcyBQTUlDIHJlZ3Vs
YXRvciBbNV0uDQogDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTE5
MzUxMy8NClsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMzA0OTM1Lw0K
WzNdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExMzIzODEvDQpbNF0gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTMxNjQ5NS8NCls1XSBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMjg0NjE3Lw0KDQpjaGFuZ2VzIHNpbmNlIHY1Og0K
LSBBZGQgQ09ORklHX05WTUVNIGRlcGVuZGVuY3kgaW4gU1ZTIEtjb25maWcuDQotIEFwcGx5IHRo
ZSBsYXRlc3QgZGV2X3BtX29wcF9hZGp1c3Rfdm9sdGFnZSgpIGZyb20gWzFdIGluIFNWUyBkcml2
ZXIuDQotIEFkZCBkZXZfcG1fb3BwX3B1dChvcHApIGFmdGVyIGNhbGxpbmcgZGV2X3BtX29wcF9n
ZXRfdm9sdGFnZShvcHApLg0KLSBGaXggbXVsdGktbGluZSBjb21tZW50IHN0eWxlLg0KLSBBZGQg
I2RlZmluZSB3L2JpdCBmb3IgbWFnaWMgY29uc3RhbnRzLg0KLSBSZXBsYWNlICJpbnQgc3ZzX2lz
X3N1cHBvcnRlZCgpIiB3aXRoICJib29sIHN2c19pc19zdXBwb3J0ZWQoKSIuDQotIFVzZSBkZWZh
dWx0L21heCBzaXplIGZvciBhbGxvY2F0aW5nIG1lbW9yaWVzIHRvDQpvcHBfdm9sdHMvaW5pdDAy
X3ZvbHRzL3ZvbHRzL29wcF9mcmVxcy9mcmVxc19wY3QgaW4gc3RydWN0IHN2c19iYW5rLg0KLSBO
YW1lICJtYWluIiBpbnN0ZWFkIG9mICJtYWluX2NsayIgaW4gU1ZTIG5vZGVzIGZvciBnZXR0aW5n
IFNWUyBjbGsuDQotIEluIFNWUyBiaW5kaW5nIGRvY3VtZW50LCByZW1vdmUgZm91cnRoIHBhcmFt
ZXRlciBvZiBHSUMgaW50ZXJydXB0cy4NCi0gVXNlICctJyBpbiBub2RlIG5hbWVzLg0KDQpSb2dl
ciBMdSAoMyk6DQogIGR0LWJpbmRpbmdzOiBzb2M6IGFkZCBtdGsgc3ZzIGR0LWJpbmRpbmdzDQog
IGFybTY0OiBkdHM6IG10ODE4MzogYWRkIHN2cyBkZXZpY2UgaW5mb3JtYXRpb24NCiAgUE0gLyBB
VlM6IFNWUzogSW50cm9kdWNlIFNWUyBlbmdpbmUNCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Bvd2VyL210ay1zdnMudHh0ICAgICB8ICAgNzYgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTgzLWV2Yi5kdHMgICB8ICAgMTYgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTgzLmR0c2kgICAgICB8ICAgNDEgKw0KIGRyaXZlcnMvcG93ZXIvYXZzL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICB8ICAgMTAgKw0KIGRyaXZlcnMvcG93ZXIvYXZzL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcG93ZXIvYXZzL210a19z
dnMuYyAgICAgICAgICAgICAgICAgICB8IDIwNzUgKysrKysrKysrKysrKysrKysNCiBpbmNsdWRl
L2xpbnV4L3Bvd2VyL210a19zdnMuaCAgICAgICAgICAgICAgICAgfCAgIDIzICsNCiA3IGZpbGVz
IGNoYW5nZWQsIDIyNDIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbXRrLXN2cy50eHQNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wb3dlci9hdnMvbXRrX3N2cy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvbGludXgvcG93ZXIvbXRrX3N2cy5oDQoNCg==

