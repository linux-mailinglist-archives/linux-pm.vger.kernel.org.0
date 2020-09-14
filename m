Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2462682F5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgINDFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726077AbgINDE5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:04:57 -0400
X-UUID: dc56d82dbdf7408182f56039e4498751-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=f0kzjVmwqblGm6hAm3dDzi082TxqtdMiNNxITJJd1ZQ=;
        b=m/1dDOD3AwBXaytMOlacNS2ZPv2uvSh9fYnMQcbWvO0xyRqQNPZIUGsksP9y/A1n2A5GZnZyzzKxcq3B38Ms/LFnR6+4I7nfzLE1Up4Nplbd/vK2ItO2V6B3GF1GLbarnxdXLcA3iKc339pj17TgTffa1fTxshASIksNiPUgI8A=;
X-UUID: dc56d82dbdf7408182f56039e4498751-20200914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1445396928; Mon, 14 Sep 2020 11:04:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:47 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:46 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH V5 00/17] Add driver for dvfsrc, support for active state of scpsys
Date:   Mon, 14 Sep 2020 11:04:27 +0800
Message-ID: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOS1yYzEgYW5kIGhhdmUgZGVwZW5kZW5jeSBwYXRj
aGVzIGFzIGZvbGxvd2luZywNClt2MTcsMDAvMTJdIE1lZGlhdGVrIE1UODE4MyBzY3BzeXMgc3Vw
cG9ydA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTcwMzI1My8NClswLzNd
IE1lZGlhdGVrIE1UODE5MiBzY3BzeXMgc3VwcG9ydA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9jb3Zlci8xMTc1NTg5Ny8NCg0KVGhlIHBhdGNoc2V0cyBhZGQgc3VwcG9ydCBmb3IgTWVk
aWFUZWsgaGFyZHdhcmUgbW9kdWxlIG5hbWVkIERWRlNSQw0KKGR5bmFtaWMgdm9sdGFnZSBhbmQg
ZnJlcXVlbmN5IHNjYWxpbmcgcmVzb3VyY2UgY29sbGVjdG9yKS4gVGhlIERWRlNSQyBpcw0KYSBI
VyBtb2R1bGUgd2hpY2ggaXMgdXNlZCB0byBjb2xsZWN0IGFsbCB0aGUgcmVxdWVzdHMgZnJvbSBi
b3RoIHNvZnR3YXJlDQphbmQgaGFyZHdhcmUgYW5kIHR1cm4gaW50byB0aGUgZGVjaXNpb24gb2Yg
bWluaW11bSBvcGVyYXRpbmcgdm9sdGFnZSBhbmQNCm1pbmltdW0gRFJBTSBmcmVxdWVuY3kgdG8g
ZnVsZmlsbCB0aG9zZSByZXF1ZXN0cy4NCg0KU28sIFRoaXMgc2VyaWVzIGlzIHRvIGltcGxlbWVu
dCB0aGUgZHZmc3JjIGRyaXZlciB0byBjb2xsZWN0IGFsbCB0aGUNCnJlcXVlc3RzIG9mIG9wZXJh
dGluZyB2b2x0YWdlIG9yIERSQU0gYmFuZHdpZHRoIGZyb20gb3RoZXIgZGV2aWNlIGRyaXZlcnMN
Cmxpa2VzIEdQVS9DYW1lcmEgdGhyb3VnaCAzIGZyYW1ld29ya3MgYmFzaWNhbGx5Og0KDQoxLiBp
bnRlcmNvbm5lY3QgZnJhbWV3b3JrOiB0byBhZ2dyZWdhdGUgdGhlIGJhbmR3aWR0aA0KICAgcmVx
dWlyZW1lbnRzIGZyb20gZGlmZmVyZW50IGNsaWVudHMNCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvY292ZXIvMTA3NjYzMjkvDQoNClRoZXJlIGhhcyBhIGh3IG1vZHVsZSAiRFJB
TSBzY2hlZHVsZXIiLCB3aGljaCB1c2VkIHRvIGNvbnRyb2wgdGhlIHRocm91Z2hwdXQuDQpUaGUg
RFZGU1JDIHdpbGwgY29sbGVjdCBmb3JlY2FzdCBkYXRhIG9mIGRyYW0gYmFuZHdpZHRoIGZyb20N
ClNXIGNvbnN1bWVycyhjYW1lcmEvZ3B1Li4uKSwgYW5kIGFjY29yZGluZyB0aGUgZm9yZWNhc3Qg
dG8gY2hhbmdlIHRoZSBEUkFNDQpmcmVxdWVuY3kNCg0KMi4gQWN0aXZlIHN0YXRlIG1hbmFnZW1l
bnQgb2YgcG93ZXIgZG9tYWluc1sxXTogdG8gaGFuZGxlIHRoZSBvcGVyYXRpbmcNCiAgIHZvbHRh
Z2UvZHJhbSBvcHAgcmVxdWlyZW1lbnQgZnJvbSBkaWZmZXJlbnQgcG93ZXIgZG9tYWlucw0KDQpb
Ml0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzc0NDA0Ny8NCg0KMy4gUmVndWFsdG9yIGZyYW1l
d29yazogdG8gaGFuZGxlIHRoZSBvcGVyYXRpbmcgdm9sdGFnZSByZXF1aXJlbWVudCBmcm9tIHVz
ZXIgb3INCiAgIGNvc3VtZXIgd2hpY2ggbm90IGJlbG9uZyBhbnkgcG93ZXIgZG9tYWluDQoNCkNo
YW5nZXMgaW4gVjU6DQoqIFN1cHBvcnQgbW9yZSBwbGF0Zm9ybSBtdDY4NzMvbXQ4MTkyDQoqIERy
b3AgdGhlIGNvbXBhdGlibGUgYW5kIGludGVyY29ubmVjdCBwcm92aWRlciBub2RlIGFuZCBtYWtl
IHRoZSBwYXJlbnQgbm9kZSBhbg0KaW50ZXJjb25uZWN0IHByb3ZpZGVyLiAoUm9iL0dlb3JnaSkN
CiogTWFrZSBtb2RpZmljYXRpb24gb2YgaW50ZXJjb25uZWN0IGRyaXZlciBmcm9tIGNvZGluZyBz
dWdnZXN0aW9uLiAoR2VvcmdpKQ0KKiBNb3ZlIGludGVyY29ubmVjdCBkaWFncmFtIGludG8gdGhl
IGNvbW1pdCB0ZXh0IG9mIHBhdGNoLiAoR2VvcmdpKQ0KKiBSZWdpc3RlciB0aGUgaW50ZXJjb25u
ZWN0IHByb3ZpZGVyIGFzIGEgcGxhdGZvcm0gc3ViLWRldmljZS4gKEdlb3JnaSkNCg0KQ2hhbmdl
cyBpbiBWNDoNCiogQWRkIGFja2VkIFRBRyBvbiBkdC1iaW5kaW5ncyBwYXRjaGVzLiAoUm9iKQ0K
KiBEZWNsYXJhdGlvbiBvZiBlbWlfaWNjX2FnZ3JlZ2F0ZSBzaW5jZSB0aGUgcHJvdG90eXBlIG9m
IGFnZ3JlZ2F0ZSBmdW5jdGlvbg0KaGFzIGNoYW5nZWQgbWVhbndoaWxlLiAoR2VvcmdpKQ0KKiBV
c2VkIGVtaV9pY2NfcmVtb3ZlIGluc3RlYWQgb2YgaWNjX3Byb3ZpZGVyX2RlbCBvbiBwcm9iZS4g
KEdlb3JnaSkNCiogQWRkIGR2ZnNyYyByZWd1bGF0b3IgZHJpdmVyIGludG8gc2VyaWVzLg0KKiBC
dWcgZml4ZWQgb2YgbXQ4MTgzX2dldF9jdXJyZW50X2xldmVsLg0KKiBBZGQgbXV0ZXggcHJvdGVj
dGlvbiBmb3IgcHN0YXRlIG9wZXJhdGlvbiBvbiBkdmZzcmNfc2V0X3BlcmZvcm1hbmNlLg0KDQpD
aGFuZ2VzIGluIFYzOg0KKiBSZW1vdmUgUkZDIGZyb20gdGhlIHN1YmplY3QgcHJlZml4IG9mIHRo
ZSBzZXJpZXMNCiogQ29tYmluZSBkdC1iaW5kaW5nIHBhdGNoIGFuZCBtb3ZlIGludGVyY29ubmVj
dCBkdC1iaW5kaW5nIGRvY3VtZW50IGludG8NCmR2ZnNyYy4gKFJvYikNCiogUmVtb3ZlIHVudXNl
ZCBoZWFkZXIsIGFkZCB1bml0IGRlc2NpcnB0aW9uIHRvIHRoZSBiYW5kd2lkdGgsIHJlbmFtZSBj
b21wYXRpYmxlDQpuYW1lIG9uIGludGVyY29ubmVjdCBkcml2ZXIuIChHZW9yZ2kpDQoqIEZpeGVk
IHNvbWUgY29kaW5nIHN0eWxlOiBjaGVjayBmbG93LCBuYW1pbmcsIHVzZWQgcmVhZHhfcG9sbF90
aW1lb3V0DQpvbiBkdmZzcmMgZHJpdmVyLiAoUnlhbikNCiogUmVuYW1lIGludGVyY29ubmVjdCBk
cml2ZXIgbXQ4MTgzLmMgdG8gbXRrLWVtaS5jDQoqIFJlbmFtZSBpbnRlcmNvbm5lY3QgaGVhZGVy
IG10ayxtdDgxODMuaCB0byBtdGssZW1pLmgNCiogbXRrLXNjcHN5cy5jOiBBZGQgb3BwIHRhYmxl
IGNoZWNrIGZpcnN0IHRvIGF2b2lkIE9GIHJ1bnRpbWUgcGFyc2UgZmFpbGVkDQoNCkNoYW5nZXMg
aW4gUkZDIFYyOg0KKiBSZW1vdmUgdGhlIERUIHByb3BlcnR5IGRyYW1fdHlwZS4gKFJvYikNCiog
VXNlZCBnZW5lcmljIGR0cyBwcm9wZXJ0eSAnb3BwLWxldmVsJyB0byBnZXQgdGhlIHBlcmZvcm1h
Y2Ugc3RhdGUuIChTdGVwaGVuKQ0KKiBSZW1vdmUgdW5lY2Vzc2FyeSBkZXBlbmRlbmN5IGNvbmZp
ZyBvbiBLY29uZmlnLiAoU3RlcGhlbikNCiogUmVtb3ZlIHVudXNlZCBoZWFkZXIgZmlsZSwgZml4
ZWQgc29tZSBjb2Rpbmcgc3R5bGUgaXNzdWUsIHR5cG8sDQplcnJvciBoYW5kbGluZyBvbiBkdmZz
cmMgZHJpdmVyLiAoTmljb2xhcy9TdGVwaGVuKQ0KKiBSZW1vdmUgaXJxIGhhbmRsZXIgb24gZHZm
c3JjIGRyaXZlci4gKFN0ZXBoZW4pDQoqIFJlbW92ZSBpbml0IHRhYmxlIG9uIGR2ZnNyYyBkcml2
ZXIsIGNvbWJpbmUgaHcgaW5pdCBvbiB0cnVzdHpvbmUuDQoqIEFkZCBpbnRlcmNvbm5lY3Qgc3Vw
cG9ydCBvZiBtdDgxODMgdG8gYWdncmVnYXRlIHRoZSBlbWkgYmFuZHdpZHRoLg0KKEdlb3JnaSkN
Cg0KVjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9jb3Zlci8xMjA5Mjg0Lw0K
VjM6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTExMTg4NjcvDQpSRkMgVjI6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDY4MTEzLw0KUkZDIFYx
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvY292ZXIvMTAyODUzNS8NCg==

