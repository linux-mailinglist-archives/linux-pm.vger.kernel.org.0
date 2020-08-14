Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28D244B3F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgHNOeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 10:34:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:51886 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNOeG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Aug 2020 10:34:06 -0400
IronPort-SDR: C5gWgV4PRCGItDAdVwmOB+y3KXWAhYO1a2tmdvll0xQRyU6gTmqDgUDKqDQbtpQEXJb4WFGbxJ
 ONE+C3UabA1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="215934347"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="215934347"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 07:34:05 -0700
IronPort-SDR: hEwMxEqTQbCj+KcldmgCK79wj1LbFOMrjXXsFy3yKi93ocZBUIeh7cyedW0QqbF8QMFPKnxNFO
 OPBdG3KpO1ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="291748905"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2020 07:34:05 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 07:34:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 07:34:04 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 07:34:04 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.23]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.153]) with mapi id 14.03.0439.000;
 Fri, 14 Aug 2020 22:34:02 +0800
From:   "Chen, Yu C" <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
CC:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 2/2][RFC] tools/power turbostat: Introduce reliable RAPL
 display
Thread-Topic: [PATCH 2/2][RFC] tools/power turbostat: Introduce reliable
 RAPL display
Thread-Index: AQHWcbvesZTef024kEWykIjRcnKuMak3qdMw
Date:   Fri, 14 Aug 2020 14:34:01 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6405F3966F2@SHSMSX103.ccr.corp.intel.com>
References: <cover.1585679838.git.yu.c.chen@intel.com>
 <3e5aa6e7b34827c0245e10c14ca9457512ae8586.1585679838.git.yu.c.chen@intel.com>
 <CAJvTdK=niWaTjwPwXaxr6EGfH8vxzJS01e+k5TgknEMPSDYLvQ@mail.gmail.com>
In-Reply-To: <CAJvTdK=niWaTjwPwXaxr6EGfH8vxzJS01e+k5TgknEMPSDYLvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTGVuLA0KPiBGcm9tOiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4NCj4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMTQsIDIwMjAgNTo1MSBBTQ0KPiBUbzogQ2hlbiwgWXUgQyA8eXUuYy5jaGVu
QGludGVsLmNvbT4NCj4gQ2M6IExpbnV4IFBNIGxpc3QgPGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgWmhhbmcsIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAyLzJdW1JGQ10gdG9vbHMvcG93ZXIgdHVyYm9zdGF0OiBJbnRyb2R1Y2UgcmVsaWFi
bGUgUkFQTA0KPiBkaXNwbGF5DQo+IA0KPiB3aHkgbm90IHNpbXBseSB1c2UgbmFub3NsZWVwKDIp
DQo+IA0KPiANCkRvIHlvdSBtZWFuLCB1c2UgbmFub3NsZWVwIHJhdGhlciB0aGFuIHRoZSB0aW1l
ciB0byBhY2N1bXVsYXRlIHRoZSBSQVBMIGRhdGE/DQpBZnRlciB0aGlua2luZyBmb3IgYSB3aGls
ZSwgaXQgbG9va3MgbGlrZSBpZiB3ZSB1c2UgbmFub3NsZWVwIHdlIG1pZ2h0DQogbmVlZCB0byBj
cmVhdGUgYSBuZXcgdGhyZWFkIHdpdGhpbiB0aGUgdHVyYm9zdGF0ICBhbmQgc2xlZXAgZXZlcnkg
ZmV3IHNlY29uZHMNCiAoYWNjb3JkaW5nIHRvIHRoZSBSQVBMIHJlZ2lzdGVyIHRpbWVvdXQpIHRv
IGFjY3VtdWxhdGUgdGhlIHJ1bm5pbmcgUkFQTC4gQW5kIG1pZ2h0DQpuZWVkIHRvIGRlYWwgd2l0
aCBzb21lIHJhY2UgY29uZGl0aW9ucyBiZXR3ZWVuIG5ldyB0aHJlYWQgYW5kIHRoZSBtYWluIHR1
cmJvc3RhdA0KdGhyZWFkLiBCdXQgeWVzLCBpdCBjYW4gYmUgc3dpdGNoZWQgdG8gbmFub3NsZWVw
KCkgdG8gY2hlY2sgaWYgdGhlIGNvZGUgd291bGQgbG9vaw0Kc2ltcGxlci4NCg0KQlRXLCB3ZSBo
YXZlIGEgdjMgb2YgdGhlIHBhdGNoIGF0DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdv
cmsvcHJvamVjdC9sa21sL2xpc3QvP3Nlcmllcz00MzkzMzANCg0KDQpUaGFua3MsDQpDaGVueXUN
Cg0KPiAtLQ0KPiBMZW4gQnJvd24sIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVy
DQo=
