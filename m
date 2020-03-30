Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93D197819
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC3Jz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 05:55:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:39181 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgC3Jz7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 05:55:59 -0400
IronPort-SDR: FvnJtyr/RAAiLylN0YcWMFJh9LfTIsE1dUY+9nD1vEKHAVOVJ0l4uvSD805zmQlTkmkXBAWTik
 0nqDO0XP9ofA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 02:55:58 -0700
IronPort-SDR: lD6nmQAjHR3xTM/q2XCw6dZ0gbs4L4F6PIMlI74bTOYIc0u7gidKXclstRN2384I2/2Bj0lbae
 9A1XUTPj9EbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; 
   d="scan'208,223";a="421877155"
Received: from yongxinj-mobl.ccr.corp.intel.com ([10.249.172.44])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2020 02:55:56 -0700
Message-ID: <b772ca4f2c08cca65da9cf09b4a61157854669af.camel@intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Liang, Kan" <kan.liang@intel.com>
Date:   Mon, 30 Mar 2020 17:55:55 +0800
In-Reply-To: <alpine.DEB.2.21.2003260311030.2844@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>
          <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>
          <alpine.DEB.2.21.2003252353370.2971@xps-7390>
          <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>
         <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
         <alpine.DEB.2.21.2003260237130.26874@xps-7390>
         <alpine.DEB.2.21.2003260311030.2844@xps-7390>
Content-Type: multipart/mixed; boundary="=-pfcN7GSNiH0ohNpEuG43"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-pfcN7GSNiH0ohNpEuG43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

CC Kan.

By checking the RAPL PMU code, it is possible that rdmsr_safe fails
when reading MSR_PLATFORM_ENERGY_STATUS.
But we don't have any debug message showing the exact failure reason.

can you please apply the patch attached and see why psys probe fails?

thanks,
rui

On Thu, 2020-03-26 at 03:15 -0700, Kenneth R. Crudup wrote:
> So I just tested a few shutdown vs. reboot cycles, and if I reboot, I
> only
> get three counters. If I shutdown, then restart, I get 4 counters
> (including
> the "psys domain" one).
> 
> I tried it on a few kernels, including the oldest one that comes with
> my
> distro (5.3.0-40-generic) where all the RAPL stuff is made as
> modules.
> 
> So, maybe we're not "clearing" (wild guess here) the "psys" RAPL on a
> reboot,
> something that would happen on a cold boot? (I'm afraid to say the
> "B-word",
> as that would mean it's a Dell issue so I won't hold my breath
> waiting for
> a fix).
> 
> 	-Kenny
> 

--=-pfcN7GSNiH0ohNpEuG43
Content-Disposition: attachment;
	filename="0001-Debug-patch-to-check-psys-RAPL-DOMAIN-registration.patch"
Content-Type: text/x-patch;
	name="0001-Debug-patch-to-check-psys-RAPL-DOMAIN-registration.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA1NjJiZDRlNzI4NGViYzU2YWM2MDQzNDY2Y2NmMWM1N2RmZjMzMDAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+CkRhdGU6
IFN1biwgMjkgTWFyIDIwMjAgMTQ6MjY6MTggKzA4MDAKU3ViamVjdDogW1BBVENIXSBEZWJ1ZyBw
YXRjaCB0byBjaGVjayBwc3lzIFJBUEwgRE9NQUlOIHJlZ2lzdHJhdGlvbi4KClNpZ25lZC1vZmYt
Ynk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3Bvd2VyY2Fw
L2ludGVsX3JhcGxfY29tbW9uLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyBi
L2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYwppbmRleCA3MzI1N2NmMTA3ZDku
LmI4M2I4MDMxNTQ4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2Nv
bW1vbi5jCisrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYwpAQCAtMTA5
NiwxMiArMTA5NiwxNCBAQCBpbnQgcmFwbF9hZGRfcGxhdGZvcm1fZG9tYWluKHN0cnVjdCByYXBs
X2lmX3ByaXYgKnByaXYpCiAJcmEucmVnID0gcHJpdi0+cmVnc1tSQVBMX0RPTUFJTl9QTEFURk9S
TV1bUkFQTF9ET01BSU5fUkVHX1NUQVRVU107CiAJcmEubWFzayA9IH4wOwogCXJldCA9IHByaXYt
PnJlYWRfcmF3KDAsICZyYSk7CisJcHJpbnRrKCJwbGF0Zm9ybV9kb21haW46IHJlYWQgcmVnIDB4
JXgsIHJldHVybiAweCV4LCByZXQgJWRcbiIsIHJhLnJlZywgcmEudmFsdWUsIHJldCk7CiAJaWYg
KHJldCB8fCAhcmEudmFsdWUpCiAJCXJldHVybiAtRU5PREVWOwogCiAJcmEucmVnID0gcHJpdi0+
cmVnc1tSQVBMX0RPTUFJTl9QTEFURk9STV1bUkFQTF9ET01BSU5fUkVHX0xJTUlUXTsKIAlyYS5t
YXNrID0gfjA7CiAJcmV0ID0gcHJpdi0+cmVhZF9yYXcoMCwgJnJhKTsKKwlwcmludGsoInBsYXRm
b3JtX2RvbWFpbjogcmVhZCByZWcgMHgleCwgcmV0dXJuIDB4JXgsIHJldCAlZFxuIiwgcmEucmVn
LCByYS52YWx1ZSwgcmV0KTsKIAlpZiAocmV0IHx8ICFyYS52YWx1ZSkKIAkJcmV0dXJuIC1FTk9E
RVY7CiAKQEAgLTExMjgsNiArMTEzMCw3IEBAIGludCByYXBsX2FkZF9wbGF0Zm9ybV9kb21haW4o
c3RydWN0IHJhcGxfaWZfcHJpdiAqcHJpdikKIAogCWlmIChJU19FUlIocG93ZXJfem9uZSkpIHsK
IAkJa2ZyZWUocmQpOworCQlwcmludGsoImZhaWxlZCB0byByZWdpc3RlciBwbGF0Zm9ybSBkb21h
aW5cbiIpOwogCQlyZXR1cm4gUFRSX0VSUihwb3dlcl96b25lKTsKIAl9CiAKLS0gCjIuMTcuMQoK



--=-pfcN7GSNiH0ohNpEuG43--

