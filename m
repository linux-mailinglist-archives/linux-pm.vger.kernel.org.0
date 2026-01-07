Return-Path: <linux-pm+bounces-40342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF13CFB6F7
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 01:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B89C30695F9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 00:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60990168BD;
	Wed,  7 Jan 2026 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLrs9JOK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373538DF9
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744541; cv=none; b=EA4Vj1yFQhLNFKcdIHUhrQnd0lR7HWJie++ddbLEkQ98HDHasDhmxRdUZFYWIi5w/ehxBZqhXKr9YMb0iGH0pyY+h1gUs76Yau99+7wtEM1l6Ir1koERFtEq0RpZGM8ykfarZukttpIjioJdiVENpHq5zRYooiJESX1zw32aRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744541; c=relaxed/simple;
	bh=j2AgVQNXe1rl7ZHIEbbDwNU3Z3MfkMbhsviVR2q7Ed0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=rZIsgO3PfuHA6lBfEQB2FmOMjSCFeaJx9amozuq3sQdHxvm3u2uX3AczoE6eefgr7EewyJM248hN7GT5csXG2gzavzoxjw/XOXEZGMFLtRTN7+uzeISVYhO8+8mur/u+2JUXh0rXctJSEM/6bs5ullGE3tJagKn2qDsh7uujBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLrs9JOK; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4510974a8cdso854742b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 16:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767744537; x=1768349337; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhdZ0RGoFZ+3XX4u8oUqOUM7xkRMGfqD/l0Tj5CP2M=;
        b=QLrs9JOKjwFCP7Uo5Ddbsg98Qa9jlpGrRjanhHFgXHR2xWIAPQTW1OWV+SdN49vhy3
         3xkfNeccA9p14W+iTHz21pbNN9gcVF4+pQYrHyZ0Nx/XGEvxJ5NpW01OQ1nO5n92KIiT
         +RaNnQGoqA3PwL1RTXMN5Apr4aWDXTPJlDhlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767744537; x=1768349337;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZhdZ0RGoFZ+3XX4u8oUqOUM7xkRMGfqD/l0Tj5CP2M=;
        b=G4n1eJMcQIjh5+jdXF7qPs9k7gCSey8SkDoesLR57nTdYy0RkpH+HcTooH/DtHt/nM
         Q1X2Gvq2NxKNvklqxCQ8tbXFx+OVWrs82hGMVEx5yTxrSRYIvG8Mz2L14GWiUuZWhZaf
         cP0doIBum8ZFtLE8JqNfDhjYOXKuLYJXJEhPDr0J9cyZTeF91nLg8vgTPTrbysTCMzV1
         ACrz9KtIhTkBSNcWvJ4++iCU6AvXJvfRTIgab5vIOmJTHdOYVvvM32LleL2fsxH2OAGM
         LTXoUTtT34sTjjMdK/tmdwHP7V5qMgLeVXtxP5H20VrZEh061tMkPQ4KS95EL/qdo/FK
         TdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV0Gv1+F4tsCqKj7/0BrHanzoQCUDAnkQd1OIlc/U9yUawWElxcPdCn+f7y4eRf9A4YEEkx4q6Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0K4iIybEROdmUmUucPihcmflMhTtN7JGSQhU9mgfb+OnNU4cE
	7J/ZINbbHoZjREixgPIiHLAueROy3bc6O0tGQMhddfUGWUAllFgZsxb05FR0DKjxcfk=
X-Gm-Gg: AY/fxX7ZAjtZJiU7F14bKx0ypfOm2MRLOjaelOMBmIV2W5tQViiX8dE45Ake1gyMjgI
	1qGtfSZbxRaMvvJnWB0nwszjFJ6avS1inms0Cd4+WE8lX+fWQuKhSKlvKrjSqFvaSVwCyO2yBo4
	ecPf3n7iLFAXSQtfeoZCxmUFnrx2p8bU4kFCX8CBDSFzD+01vVhMDeXXJ70AbD++O6wqjPV1B8G
	bQFRxav84y1Xf9TtQ9c0wF44xHHPlZmiX3G4DnA/XzNV2jEdhVV2+iPgbDArMfJJ4nLoP9p24vV
	FqFdNr+E3UnDtMxv+CsCr7ej25ND7LTASR4ODFZeIUyyHVgSwfNYn5lnd0Sn7fUq5jRsyGUuEbh
	fOjlUvcJz78O8J7SDrYZrITI95E/VzN/cNYN9zQnfq64tDSMK9IcrtILouc/i5swCo0lryoiDAL
	9+2llr7Mvjwy3jFfFXGverpNw=
X-Google-Smtp-Source: AGHT+IEEwVUk/qLVa8S2I37uWew8RA4MnmuYiPGpjvqCYsE/PcuKjpUdTJfqIW4512f5IuHdb0P9vg==
X-Received: by 2002:a05:6808:3848:b0:441:8f74:fce with SMTP id 5614622812f47-45a6bef1eb7mr413208b6e.59.1767744537378;
        Tue, 06 Jan 2026 16:08:57 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm1649874b6e.4.2026.01.06.16.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 16:08:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------fO9izJnQt0UjIlI4WuKaHpJd"
Message-ID: <0e2424d2-7fd1-488d-901c-ba154cbfcd44@linuxfoundation.org>
Date: Tue, 6 Jan 2026 17:08:55 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.20-rc1

This is a multi-part message in MIME format.
--------------fO9izJnQt0UjIlI4WuKaHpJd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.20-rc1.

Fixes to miscellaneous problems in cpupower tool:

- idle_monitor: fix incorrect value logged after stop
- Fix inverted APERF capability check
- Use strcspn() to strip trailing newline
- Reset errno before strtoull()
- Show C0 in idle-info dump

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.20-rc1

for you to fetch changes up to ff72619e11348ab189e232c59515dd5c33780d7c:

   tools/power cpupower: Show C0 in idle-info dump (2025-12-15 12:33:29 -0700)

----------------------------------------------------------------
cpupower update for Linux 6.20-rc1

Fixes to miscellaneous problems in cpupower tool:

- idle_monitor: fix incorrect value logged after stop
- Fix inverted APERF capability check
- Use strcspn() to strip trailing newline
- Reset errno before strtoull()
- Show C0 in idle-info dump

----------------------------------------------------------------
Kaushlendra Kumar (5):
       cpupower: idle_monitor: fix incorrect value logged after stop
       tools/cpupower: Fix inverted APERF capability check
       tools/cpupower: Use strcspn() to strip trailing newline
       tools/power cpupower: Reset errno before strtoull()
       tools/power cpupower: Show C0 in idle-info dump

  tools/power/cpupower/lib/cpuidle.c                      | 7 +++----
  tools/power/cpupower/utils/cpufreq-info.c               | 2 +-
  tools/power/cpupower/utils/cpuidle-info.c               | 2 +-
  tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 2 +-
  4 files changed, 6 insertions(+), 7 deletions(-)
----------------------------------------------------------------
--------------fO9izJnQt0UjIlI4WuKaHpJd
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.20-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.20-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMgYi90b29s
cy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRsZS5jCmluZGV4IGYyYzExMzlhZGY3MS4uMmZj
YjM0M2Q4ZTc1IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRs
ZS5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMKQEAgLTE1MCw2
ICsxNTAsNyBAQCB1bnNpZ25lZCBsb25nIGxvbmcgY3B1aWRsZV9zdGF0ZV9nZXRfb25lX3Zh
bHVlKHVuc2lnbmVkIGludCBjcHUsCiAJaWYgKGxlbiA9PSAwKQogCQlyZXR1cm4gMDsKIAor
CWVycm5vID0gMDsKIAl2YWx1ZSA9IHN0cnRvdWxsKGxpbmVidWYsICZlbmRwLCAwKTsKIAog
CWlmIChlbmRwID09IGxpbmVidWYgfHwgZXJybm8gPT0gRVJBTkdFKQpAQCAtMTkzLDggKzE5
NCw3IEBAIHN0YXRpYyBjaGFyICpjcHVpZGxlX3N0YXRlX2dldF9vbmVfc3RyaW5nKHVuc2ln
bmVkIGludCBjcHUsCiAJaWYgKHJlc3VsdCA9PSBOVUxMKQogCQlyZXR1cm4gTlVMTDsKIAot
CWlmIChyZXN1bHRbc3RybGVuKHJlc3VsdCkgLSAxXSA9PSAnXG4nKQotCQlyZXN1bHRbc3Ry
bGVuKHJlc3VsdCkgLSAxXSA9ICdcMCc7CisJcmVzdWx0W3N0cmNzcG4ocmVzdWx0LCAiXG4i
KV0gPSAnXDAnOwogCiAJcmV0dXJuIHJlc3VsdDsKIH0KQEAgLTM2Niw4ICszNjYsNyBAQCBz
dGF0aWMgY2hhciAqc3lzZnNfY3B1aWRsZV9nZXRfb25lX3N0cmluZyhlbnVtIGNwdWlkbGVf
c3RyaW5nIHdoaWNoKQogCWlmIChyZXN1bHQgPT0gTlVMTCkKIAkJcmV0dXJuIE5VTEw7CiAK
LQlpZiAocmVzdWx0W3N0cmxlbihyZXN1bHQpIC0gMV0gPT0gJ1xuJykKLQkJcmVzdWx0W3N0
cmxlbihyZXN1bHQpIC0gMV0gPSAnXDAnOworCXJlc3VsdFtzdHJjc3BuKHJlc3VsdCwgIlxu
IildID0gJ1wwJzsKIAogCXJldHVybiByZXN1bHQ7CiB9CmRpZmYgLS1naXQgYS90b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL3V0aWxzL2NwdWZyZXEtaW5mby5jCmluZGV4IDdkMzczMmY1ZjJmNi4uNWZlMDFlNTE2
ODE3IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWlu
Zm8uYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYwpA
QCAtMjcwLDcgKzI3MCw3IEBAIHN0YXRpYyBpbnQgZ2V0X2ZyZXFfaGFyZHdhcmUodW5zaWdu
ZWQgaW50IGNwdSwgdW5zaWduZWQgaW50IGh1bWFuKQogewogCXVuc2lnbmVkIGxvbmcgZnJl
cTsKIAotCWlmIChjcHVwb3dlcl9jcHVfaW5mby5jYXBzICYgQ1BVUE9XRVJfQ0FQX0FQRVJG
KQorCWlmICghKGNwdXBvd2VyX2NwdV9pbmZvLmNhcHMgJiBDUFVQT1dFUl9DQVBfQVBFUkYp
KQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCWZyZXEgPSBjcHVmcmVxX2dldF9mcmVxX2hhcmR3
YXJlKGNwdSk7CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVp
ZGxlLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWlkbGUtaW5mby5j
CmluZGV4IGUwZDE3ZjBkZTNmZS4uODFiNDc2M2E5N2Q2IDEwMDY0NAotLS0gYS90b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYworKysgYi90b29scy9wb3dlci9j
cHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYwpAQCAtMTExLDcgKzExMSw3IEBAIHN0YXRp
YyB2b2lkIHByb2NfY3B1aWRsZV9jcHVfb3V0cHV0KHVuc2lnbmVkIGludCBjcHUpCiAJcHJp
bnRmKF8oIm1heF9jc3RhdGU6ICAgICAgICAgICAgICBDJXVcbiIpLCBjc3RhdGVzLTEpOwog
CXByaW50ZihfKCJtYXhpbXVtIGFsbG93ZWQgbGF0ZW5jeTogJWx1IHVzZWNcbiIpLCBtYXhf
YWxsb3dlZF9jc3RhdGUpOwogCXByaW50ZihfKCJzdGF0ZXM6XHRcbiIpKTsKLQlmb3IgKGNz
dGF0ZSA9IDE7IGNzdGF0ZSA8IGNzdGF0ZXM7IGNzdGF0ZSsrKSB7CisJZm9yIChjc3RhdGUg
PSAwOyBjc3RhdGUgPCBjc3RhdGVzOyBjc3RhdGUrKykgewogCQlwcmludGYoXygiICAgIEMl
ZDogICAgICAgICAgICAgICAgICAiCiAJCQkgInR5cGVbQyVkXSAiKSwgY3N0YXRlLCBjc3Rh
dGUpOwogCQlwcmludGYoXygicHJvbW90aW9uWy0tXSBkZW1vdGlvblstLV0gIikpOwpkaWZm
IC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaWRsZV9tb25pdG9yL2NwdWlk
bGVfc3lzZnMuYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9j
cHVpZGxlX3N5c2ZzLmMKaW5kZXggOGI0MmMyZjBhNWIwLi40MjI1ZWZmOTgzM2QgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9jcHVpZGxl
X3N5c2ZzLmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaWRsZV9tb25pdG9y
L2NwdWlkbGVfc3lzZnMuYwpAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMgaW50IGNwdWlkbGVf
c3RvcCh2b2lkKQogCQkJY3VycmVudF9jb3VudFtjcHVdW3N0YXRlXSA9CiAJCQkJY3B1aWRs
ZV9zdGF0ZV90aW1lKGNwdSwgc3RhdGUpOwogCQkJZHByaW50KCJDUFUgJWQgLSBTdGF0ZTog
JWQgLSBWYWw6ICVsbHVcbiIsCi0JCQkgICAgICAgY3B1LCBzdGF0ZSwgcHJldmlvdXNfY291
bnRbY3B1XVtzdGF0ZV0pOworCQkJICAgICAgIGNwdSwgc3RhdGUsIGN1cnJlbnRfY291bnRb
Y3B1XVtzdGF0ZV0pOwogCQl9CiAJfQogCXJldHVybiAwOwo=

--------------fO9izJnQt0UjIlI4WuKaHpJd--

