Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81771967F0
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgC1RM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 13:12:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:1452 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgC1RM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 28 Mar 2020 13:12:29 -0400
IronPort-SDR: tKpjoKWF8QF0UlxPO4su3BobyXKNYzOk/s2aL55Mx4Pp+FRHvV+Iv46+7fZxSZq4TvzYxP/VyO
 QrcZflvB+ygA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 10:12:28 -0700
IronPort-SDR: l2qLCoZVo79Nv40mqmyeBvuQInvD62LVYbO6MY5SF+2AXukMbY/KbowImJsZ0RJZcfQIQ8aqah
 QIdb8lYQEifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="449346569"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2020 10:12:27 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Mar 2020 10:12:27 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.121]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.106]) with mapi id 14.03.0439.000;
 Sat, 28 Mar 2020 10:12:27 -0700
From:   "Brown, Len" <len.brown@intel.com>
To:     =?utf-8?B?T25kxZllaiBMeXNvbsSbaw==?= <olysonek@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: x86_energy_perf_policy fails with Input/output error in a VM
Thread-Topic: x86_energy_perf_policy fails with Input/output error in a VM
Thread-Index: AQHWBAkrgu7Leekdz0CsCGY/NSUrP6hePqdQ
Date:   Sat, 28 Mar 2020 17:12:26 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94881B93DF1@fmsmsx101.amr.corp.intel.com>
References: <flspncygsvj.fsf@redhat.com>
In-Reply-To: <flspncygsvj.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGZvciB0aGUgbm90ZSwNCg0KSSBhZ3JlZSB0aGF0IGlzIHVuZnJpZW5kbHkgaG93IHRo
ZSB0b29sIHRlbGxzIHRoZSB1c2VyIHRoYXQgaXQgaXMgbm90IHBvc3NpYmxlIGZvciBpdCB0byBy
dW4gaW4gYSBWTSBndWVzdC4NCklmIHBlb3BsZSBhcmUgcnVubmluZyBpbnRvIHRoYXQsIGFuZCB3
ZSBjYW4gbWFrZSBpdCBtb3JlIGdyYWNlZnVsLCB3ZSBzaG91bGQuDQoNCklzIHBhcnNpbmcgL3By
b2MvY3B1aW5mbyBhIHVuaXZlcnNhbC9yZWxpYWJsZSB3YXkgdG8gZGV0ZWN0IHRoaXMgc2l0dWF0
aW9uPw0KDQoNCg==
