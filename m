Return-Path: <linux-pm+bounces-23781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AEA59D41
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21EE188CEBA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E0230BE7;
	Mon, 10 Mar 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rnalm4ve"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5517C225
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627157; cv=none; b=mc4ykM3Qm8tKvGeYx0VRt5o7wH/qLovO6No4jsdZvzi5EUThQ6s5HNzCyVzisQ8ZZtb9Dc1nqx1f19ZitznY9x0cQNsDzpLwMaHv9P8mFe9fgX6bFNtwZKOzAsiW+0Z/Mjn9HY39raN8p0BGQMw9a7uL7MzQKY4uFRSlmozvTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627157; c=relaxed/simple;
	bh=YFlJYLeJ6RZUABa8RhmNikuTLtNI+gtuEkrjT8XBcUE=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=dUpCviGCPYcKQHcm/mnMrYQugYhkR2I0k/znXqu3HVyY34cI4GVx2Q+dSYFacD0rb+kwob/YF/r26yr5BthUb4V0WJcZLyYD0XIz0MgUwrAZDGEE1+BwCYx6CNmKy4HH1KBzWYLwbNjdJhc/OFnbrNk9EHDZ27mu8WTeFKH6rIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rnalm4ve; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso34864265ab.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741627154; x=1742231954; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=whk/7neCN9gwKwzYytw5P08v6ZbgevrD/pRo+lEEuBw=;
        b=Rnalm4ve3CYOY5/NWIwcB6g0BVkI3FjftBMYnOGPAZ4d+HnBJh1eNC7baS3slREJWz
         vEtpR133/i59sUbS/Vs8nKbQfE3PvKWKcdfz18JCMAaAOe3B1u05MrDQmsrm8eSf+D0+
         5vnT1Png18zcaf+zmXzf5/wac9bQNjBNn4aDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627154; x=1742231954;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whk/7neCN9gwKwzYytw5P08v6ZbgevrD/pRo+lEEuBw=;
        b=V3sJZ6qxJ/QvKZkF10+U6Idef8qLUDjyvS/RH8z8uDO0N58Tt+fLMN45ieWemNyDry
         a1X8IHnJ8iI1XBpIaq06iRRcZFv9uOtKENLTozom3HzUCFmYrejoKIB7IEXgwRJPvq2t
         hjfJJVVdPZt5N3dthykNdP+6dWS3UyWKQIg1EQpArAUKXJXC8JbFiH2siOabt3ZwToHu
         lW6J8AvGEQiZc9dOzgfs87n06nZZzJhad19U6bEYsrru8ebLGT0hWbKVYGBgEbUeW+Nr
         31dSz9lVAoptE6E8YAqexKHWXAJBYL5whC7q3nJiseO2r66JO9fOl0FHypPS+F5xojpl
         XLzA==
X-Forwarded-Encrypted: i=1; AJvYcCUnT2r358789ahlm7ziCKlyx9cihVxh2WfLXOtNrqQlIh4tfTPbsccvwXDJ7m6K8RWv+B79nXe6lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCS7sCcb3o/twG3Al0jrASELLzk2zdui+vlplYXi7KtLFO75/
	PTKJV0p8SsQATEJaIrdsHvx5Gg1A+SsTMmtpsltd2x9Q2V12Ea+mARfO0HWYCiE=
X-Gm-Gg: ASbGncvg2Vvn1Pf98unmR6+HM50maRXUm3wHtXshdeF8GYAXqo8Yu8s7Y8kIUkZV0ex
	tIcrT1vsBW9sQRy98KlYnQu8M7RuNCqYuxFac4CchSqcouWyv67I+bLVoybEaKujsIj/yXsqPS8
	CVn+Yw0Tn2KMju1zj0TVZXql1vTbUoaBdQiX0pUXjbBqWQeUm9N0YGMwKZBoG3mX5+rFOR2fxHP
	gQrR8X/CKFixhOl1P6jlglOwwT77hZ4IjILkJWvVpia5dt3R74qkvYVAzPjnmMeU692yEXLx/N8
	DVw+MWY/2idgdV5AoZXs5DtHk0Z4ECrVG+mwAc48xkh9cXqGWUi7s1k=
X-Google-Smtp-Source: AGHT+IFlubCUMTKk60R0aEoZRhOa6NDaApgVW8P8j3T/OzTf8ODHcXEU7wtr4IJTsg2l0aG9D1P/rA==
X-Received: by 2002:a05:6e02:184e:b0:3d1:92fc:fb45 with SMTP id e9e14a558f8ab-3d44187c0demr186407365ab.5.1741627153916;
        Mon, 10 Mar 2025 10:19:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22b9bf883sm1148689173.92.2025.03.10.10.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 10:19:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------c4z2ro8VFqCfYeu7uqjTuMSp"
Message-ID: <826ecff6-5b43-4cf8-ba8e-3d5a44e5a318@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:19:12 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 skhan@linuxfoundation.org, shuah <shuah@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.15-rc1

This is a multi-part message in MIME format.
--------------c4z2ro8VFqCfYeu7uqjTuMSp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower  update for Linux 6.15-rc1.

Fixes lib version-ing, memory leaks in error legs, removes hard-coded
values, and implements CPU physical core querying.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.15-rc1

for you to fetch changes up to fffadbdd6b5acdb6390d6d0bc3ad6d3da5d2bd53:

   cpupower: Make lib versioning scheme more obvious and fix version link (2025-03-07 13:58:10 -0700)

----------------------------------------------------------------
linux-cpupower-6.15-rc1

Fixes lib version-ing, memory leaks in error legs, removes hard-coded
values, and implements CPU physical core querying.

----------------------------------------------------------------
John B. Wyatt IV (1):
       cpupower: Implement CPU physical core querying

Shuah Khan (2):
       pm: cpupower: Fix cmd_monitor() error legs to free cpu_topology
       pm: cpupower: remove hard-coded topology depth values

Thomas Renninger (1):
       cpupower: Make lib versioning scheme more obvious and fix version link

Yiwei Lin (1):
       cpupower: monitor: Exit with error status if execvp() fail

Zhongqiu Han (1):
       pm: cpupower: bench: Prevent NULL dereference on malloc failure

  tools/power/cpupower/Makefile                      | 19 +++++----
  tools/power/cpupower/bench/parse.c                 |  4 ++
  tools/power/cpupower/lib/cpupower.c                | 48 ++++++++++++++++++----
  tools/power/cpupower/lib/cpupower.h                |  3 ++
  .../cpupower/utils/idle_monitor/cpupower-monitor.c | 48 ++++++++++++++++------
  5 files changed, 94 insertions(+), 28 deletions(-)
----------------------------------------------------------------
--------------c4z2ro8VFqCfYeu7uqjTuMSp
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.15-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.15-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggNTFhOTUyMzlmZTA2Li44MzUxMjNhZGQwZWQg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC01Miw4ICs1MiwxMSBAQCBERVNURElSID89
CiAjIGFuZCBfc2hvdWxkXyBtb2RpZnkgdGhlIFBBQ0tBR0VfQlVHUkVQT1JUIGRlZmluaXRp
b24KIAogVkVSU0lPTjo9CQkJJChzaGVsbCAuL3V0aWxzL3ZlcnNpb24tZ2VuLnNoKQotTElC
X01BSj0JCQkwLjAuMQotTElCX01JTj0JCQkxCitMSUJfRklYPQkJCTEKK0xJQl9NSU49CQkJ
MAorTElCX01BSj0JCQkxCitMSUJfVkVSPQkJCSQoTElCX01BSikuJChMSUJfTUlOKS4kKExJ
Ql9GSVgpCisKIAogUEFDS0FHRSA9CQkJY3B1cG93ZXIKIFBBQ0tBR0VfQlVHUkVQT1JUID0J
CWxpbnV4LXBtQHZnZXIua2VybmVsLm9yZwpAQCAtMjAwLDE0ICsyMDMsMTQgQEAgJChPVVRQ
VVQpbGliLyUubzogJChMSUJfU1JDKSAkKExJQl9IRUFERVJTKQogCSQoRUNITykgIiAgQ0Mg
ICAgICAiICRACiAJJChRVUlFVCkgJChDQykgJChDRkxBR1MpIC1mUElDIC1vICRAIC1jIGxp
Yi8kKi5jCiAKLSQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElCX01BSik6ICQoTElCX09C
SlMpCiskKE9VVFBVVClsaWJjcHVwb3dlci5zby4kKExJQl9WRVIpOiAkKExJQl9PQkpTKQog
CSQoRUNITykgIiAgTEQgICAgICAiICRACiAJJChRVUlFVCkgJChDQykgLXNoYXJlZCAkKENG
TEFHUykgJChMREZMQUdTKSAtbyAkQCBcCi0JCS1XbCwtc29uYW1lLGxpYmNwdXBvd2VyLnNv
LiQoTElCX01JTikgJChMSUJfT0JKUykKKwkJLVdsLC1zb25hbWUsbGliY3B1cG93ZXIuc28u
JChMSUJfTUFKKSAkKExJQl9PQkpTKQogCUBsbiAtc2YgJChARikgJChPVVRQVVQpbGliY3B1
cG93ZXIuc28KLQlAbG4gLXNmICQoQEYpICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElC
X01JTikKKwlAbG4gLXNmICQoQEYpICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElCX01B
SikKIAotbGliY3B1cG93ZXI6ICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElCX01BSikK
K2xpYmNwdXBvd2VyOiAkKE9VVFBVVClsaWJjcHVwb3dlci5zby4kKExJQl9WRVIpCiAKICMg
TGV0IGFsbCAubyBmaWxlcyBkZXBlbmQgb24gaXRzIC5jIGZpbGUgYW5kIGFsbCBoZWFkZXJz
CiAjIE1pZ2h0IGJlIHdvcnRoIHRvIHB1dCB0aGlzIGludG8gdXRpbHMvTWFrZWZpbGUgYXQg
c29tZSBwb2ludCBvZiB0aW1lCkBAIC0yMTcsNyArMjIwLDcgQEAgJChPVVRQVVQpJS5vOiAl
LmMKIAkkKEVDSE8pICIgIENDICAgICAgIiAkQAogCSQoUVVJRVQpICQoQ0MpICQoQ0ZMQUdT
KSAtSS4vbGliIC1JIC4vdXRpbHMgLW8gJEAgLWMgJCouYwogCi0kKE9VVFBVVCljcHVwb3dl
cjogJChVVElMX09CSlMpICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElCX01BSikKKyQo
T1VUUFVUKWNwdXBvd2VyOiAkKFVUSUxfT0JKUykgJChPVVRQVVQpbGliY3B1cG93ZXIuc28u
JChMSUJfVkVSKQogCSQoRUNITykgIiAgQ0MgICAgICAiICRACiBpZmVxICgkKHN0cmlwICQo
U1RBVElDKSksdHJ1ZSkKIAkkKFFVSUVUKSAkKENDKSAkKENGTEFHUykgJChMREZMQUdTKSAk
KFVUSUxfT0JKUykgLWxydCAtbHBjaSAtTCQoT1VUUFVUKSAtbyAkQApAQCAtMjYyLDcgKzI2
NSw3IEBAIHVwZGF0ZS1wbzogJChPVVRQVVQpcG8vJChQQUNLQUdFKS5wb3QKIAlkb25lOwog
ZW5kaWYKIAotY29tcGlsZS1iZW5jaDogJChPVVRQVVQpbGliY3B1cG93ZXIuc28uJChMSUJf
TUFKKQorY29tcGlsZS1iZW5jaDogJChPVVRQVVQpbGliY3B1cG93ZXIuc28uJChMSUJfVkVS
KQogCUBWPSQoVikgY29uZmRpcj0kKGNvbmZkaXIpICQoTUFLRSkgLUMgYmVuY2ggTz0kKE9V
VFBVVCkKIAogIyB3ZSBjb21waWxlIGludG8gc3ViZGlyZWN0b3JpZXMuIGlmIHRoZSB0YXJn
ZXQgZGlyZWN0b3J5IGlzIG5vdCB0aGUKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL2JlbmNoL3BhcnNlLmMgYi90b29scy9wb3dlci9jcHVwb3dlci9iZW5jaC9wYXJzZS5j
CmluZGV4IDA4MDY3OGQ5ZDc0ZS4uYmQ2N2M3NThiMzNhIDEwMDY0NAotLS0gYS90b29scy9w
b3dlci9jcHVwb3dlci9iZW5jaC9wYXJzZS5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L2JlbmNoL3BhcnNlLmMKQEAgLTEyMSw2ICsxMjEsMTAgQEAgRklMRSAqcHJlcGFyZV9vdXRw
dXQoY29uc3QgY2hhciAqZGlybmFtZSkKIHN0cnVjdCBjb25maWcgKnByZXBhcmVfZGVmYXVs
dF9jb25maWcoKQogewogCXN0cnVjdCBjb25maWcgKmNvbmZpZyA9IG1hbGxvYyhzaXplb2Yo
c3RydWN0IGNvbmZpZykpOworCWlmICghY29uZmlnKSB7CisJCXBlcnJvcigibWFsbG9jIik7
CisJCXJldHVybiBOVUxMOworCX0KIAogCWRwcmludGYoImxvYWRpbmcgZGVmYXVsdHNcbiIp
OwogCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuYyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVwb3dlci5jCmluZGV4IDdhMmVmNjkxYjIw
ZS4uY2U4ZGZiOGU0NmFiIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIv
Y3B1cG93ZXIuYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuYwpA
QCAtMTAsNiArMTAsNyBAQAogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8ZXJybm8u
aD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KIAogI2luY2x1
ZGUgImNwdXBvd2VyLmgiCiAjaW5jbHVkZSAiY3B1cG93ZXJfaW50ZXJuLmgiCkBAIC0xNTAs
MTUgKzE1MSwyNSBAQCBzdGF0aWMgaW50IF9fY29tcGFyZShjb25zdCB2b2lkICp0MSwgY29u
c3Qgdm9pZCAqdDIpCiAJCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IF9fY29tcGFyZV9j
b3JlX2NwdV9saXN0KGNvbnN0IHZvaWQgKnQxLCBjb25zdCB2b2lkICp0MikKK3sKKwlzdHJ1
Y3QgY3B1aWRfY29yZV9pbmZvICp0b3AxID0gKHN0cnVjdCBjcHVpZF9jb3JlX2luZm8gKil0
MTsKKwlzdHJ1Y3QgY3B1aWRfY29yZV9pbmZvICp0b3AyID0gKHN0cnVjdCBjcHVpZF9jb3Jl
X2luZm8gKil0MjsKKworCXJldHVybiBzdHJjbXAodG9wMS0+Y29yZV9jcHVfbGlzdCwgdG9w
Mi0+Y29yZV9jcHVfbGlzdCk7Cit9CisKIC8qCiAgKiBSZXR1cm5zIGFtb3VudCBvZiBjcHVz
LCBuZWdhdGl2ZSBvbiBlcnJvciwgY3B1X3RvcCBtdXN0IGJlCiAgKiBwYXNzZWQgdG8gY3B1
X3RvcG9sb2d5X3JlbGVhc2UgdG8gZnJlZSByZXNvdXJjZXMKICAqCi0gKiBBcnJheSBpcyBz
b3J0ZWQgYWZ0ZXIgLT5wa2csIC0+Y29yZSwgdGhlbiAtPmNwdQorICogQXJyYXkgaXMgc29y
dGVkIGFmdGVyIC0+Y3B1X3NtdF9saXN0IC0+cGtnLCAtPmNvcmUKICAqLwogaW50IGdldF9j
cHVfdG9wb2xvZ3koc3RydWN0IGNwdXBvd2VyX3RvcG9sb2d5ICpjcHVfdG9wKQogewogCWlu
dCBjcHUsIGxhc3RfcGtnLCBjcHVzID0gc3lzY29uZihfU0NfTlBST0NFU1NPUlNfQ09ORik7
CisJY2hhciBwYXRoW1NZU0ZTX1BBVEhfTUFYXTsKKwljaGFyICpsYXN0X2NwdV9saXN0Owog
CiAJY3B1X3RvcC0+Y29yZV9pbmZvID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgY3B1aWRfY29y
ZV9pbmZvKSAqIGNwdXMpOwogCWlmIChjcHVfdG9wLT5jb3JlX2luZm8gPT0gTlVMTCkKQEAg
LTE4Myw2ICsxOTQsMzQgQEAgaW50IGdldF9jcHVfdG9wb2xvZ3koc3RydWN0IGNwdXBvd2Vy
X3RvcG9sb2d5ICpjcHVfdG9wKQogCQkJY3B1X3RvcC0+Y29yZV9pbmZvW2NwdV0uY29yZSA9
IC0xOwogCQkJY29udGludWU7CiAJCX0KKwkJaWYgKGNwdV90b3AtPmNvcmVfaW5mb1tjcHVd
LmNvcmUgPT0gLTEpIHsKKwkJCXN0cm5jcHkoY3B1X3RvcC0+Y29yZV9pbmZvW2NwdV0uY29y
ZV9jcHVfbGlzdCwgIi0xIiwgQ1BVTElTVF9CVUZGRVIpOworCQkJY29udGludWU7CisJCX0K
KwkJc25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCBQQVRIX1RPX0NQVSAiY3B1JXUvdG9w
b2xvZ3kvJXMiLAorCQkJIGNwdSwgImNvcmVfY3B1c19saXN0Iik7CisJCWlmIChjcHVwb3dl
cl9yZWFkX3N5c2ZzKAorCQkJcGF0aCwKKwkJCWNwdV90b3AtPmNvcmVfaW5mb1tjcHVdLmNv
cmVfY3B1X2xpc3QsCisJCQlDUFVMSVNUX0JVRkZFUikgPCAxKSB7CisJCQlwcmludGYoIldh
cm5pbmcgQ1BVJXUgaGFzIGEgMCBzaXplIGNvcmVfY3B1c19saXN0IHN0cmluZyIsIGNwdSk7
CisJCX0KKwl9CisKKwkvKiBDb3VudCB0aGUgbnVtYmVyIG9mIGRpc3RpbmN0IGNwdSBsaXN0
cyB0byBnZXQgdGhlIHBoeXNpY2FsIGNvcmUKKwkgKiBjb3VudC4KKwkgKi8KKwlxc29ydChj
cHVfdG9wLT5jb3JlX2luZm8sIGNwdXMsIHNpemVvZihzdHJ1Y3QgY3B1aWRfY29yZV9pbmZv
KSwKKwkgICAgICBfX2NvbXBhcmVfY29yZV9jcHVfbGlzdCk7CisKKwlsYXN0X2NwdV9saXN0
ID0gY3B1X3RvcC0+Y29yZV9pbmZvWzBdLmNvcmVfY3B1X2xpc3Q7CisJY3B1X3RvcC0+Y29y
ZXMgPSAxOworCWZvciAoY3B1ID0gMTsgY3B1IDwgY3B1czsgY3B1KyspIHsKKwkJaWYgKHN0
cmNtcChjcHVfdG9wLT5jb3JlX2luZm9bY3B1XS5jb3JlX2NwdV9saXN0LCBsYXN0X2NwdV9s
aXN0KSAhPSAwICYmCisJCSAgICBjcHVfdG9wLT5jb3JlX2luZm9bY3B1XS5wa2cgIT0gLTEp
IHsKKwkJCWxhc3RfY3B1X2xpc3QgPSBjcHVfdG9wLT5jb3JlX2luZm9bY3B1XS5jb3JlX2Nw
dV9saXN0OworCQkJY3B1X3RvcC0+Y29yZXMrKzsKKwkJfQogCX0KIAogCXFzb3J0KGNwdV90
b3AtPmNvcmVfaW5mbywgY3B1cywgc2l6ZW9mKHN0cnVjdCBjcHVpZF9jb3JlX2luZm8pLApA
QCAtMjAzLDEzICsyNDIsNiBAQCBpbnQgZ2V0X2NwdV90b3BvbG9neShzdHJ1Y3QgY3B1cG93
ZXJfdG9wb2xvZ3kgKmNwdV90b3ApCiAJaWYgKCEoY3B1X3RvcC0+Y29yZV9pbmZvWzBdLnBr
ZyA9PSAtMSkpCiAJCWNwdV90b3AtPnBrZ3MrKzsKIAotCS8qIEludGVsJ3MgY29yZXMgY291
bnQgaXMgbm90IGNvbnNlY3V0aXZlbHkgbnVtYmVyZWQsIHRoZXJlIG1heQotCSAqIGJlIGEg
Y29yZV9pZCBvZiAzLCBidXQgbm9uZSBvZiAyLiBBc3N1bWUgdGhlcmUgYWx3YXlzIGlzIDAK
LQkgKiBHZXQgYW1vdW50IG9mIGNvcmVzIGJ5IGNvdW50aW5nIGR1cGxpY2F0ZXMgaW4gYSBw
YWNrYWdlCi0JZm9yIChjcHUgPSAwOyBjcHVfdG9wLT5jb3JlX2luZm9bY3B1XS5wa2cgPSAw
ICYmIGNwdSA8IGNwdXM7IGNwdSsrKSB7Ci0JCWlmIChjcHVfdG9wLT5jb3JlX2luZm9bY3B1
XS5jb3JlID09IDApCi0JY3B1X3RvcC0+Y29yZXMrKzsKLQkqLwogCXJldHVybiBjcHVzOwog
fQogCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuaCBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVwb3dlci5oCmluZGV4IGU0ZTQyOTJlYWNl
Yy4uMmU2N2EwODBmMjAzIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIv
Y3B1cG93ZXIuaAorKysgYi90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuaApA
QCAtMiw2ICsyLDggQEAKICNpZm5kZWYgX19DUFVQT1dFUl9DUFVQT1dFUl9IX18KICNkZWZp
bmUgX19DUFVQT1dFUl9DUFVQT1dFUl9IX18KIAorI2RlZmluZSBDUFVMSVNUX0JVRkZFUiA1
CisKIHN0cnVjdCBjcHVwb3dlcl90b3BvbG9neSB7CiAJLyogQW1vdW50IG9mIENQVSBjb3Jl
cywgcGFja2FnZXMgYW5kIHRocmVhZHMgcGVyIGNvcmUgaW4gdGhlIHN5c3RlbSAqLwogCXVu
c2lnbmVkIGludCBjb3JlczsKQEAgLTE2LDYgKzE4LDcgQEAgc3RydWN0IGNwdWlkX2NvcmVf
aW5mbyB7CiAJaW50IHBrZzsKIAlpbnQgY29yZTsKIAlpbnQgY3B1OworCWNoYXIgY29yZV9j
cHVfbGlzdFtDUFVMSVNUX0JVRkZFUl07CiAKIAkvKiBmbGFncyAqLwogCXVuc2lnbmVkIGlu
dCBpc19vbmxpbmU6MTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxz
L2lkbGVfbW9uaXRvci9jcHVwb3dlci1tb25pdG9yLmMgYi90b29scy9wb3dlci9jcHVwb3dl
ci91dGlscy9pZGxlX21vbml0b3IvY3B1cG93ZXItbW9uaXRvci5jCmluZGV4IGY3NDYwOTli
NWRhYy4uYWQ0OTMxNTdmODI2IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9pZGxlX21vbml0b3IvY3B1cG93ZXItbW9uaXRvci5jCisrKyBiL3Rvb2xzL3Bvd2Vy
L2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9jcHVwb3dlci1tb25pdG9yLmMKQEAgLTYs
NiArNiw3IEBACiAgKi8KIAogCisjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDxzdGRp
by5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPHN0ZGxpYi5oPgpAQCAtOTEs
NyArOTIsMTEgQEAgaW50IGZpbGxfc3RyaW5nX3dpdGhfc3BhY2VzKGNoYXIgKnMsIGludCBu
KQogCXJldHVybiAwOwogfQogCi0jZGVmaW5lIE1BWF9DT0xfV0lEVEggNgorI2RlZmluZSBN
QVhfQ09MX1dJRFRICQk2CisjZGVmaW5lIFRPUE9MT0dZX0RFUFRIX1BLRwkzCisjZGVmaW5l
IFRPUE9MT0dZX0RFUFRIX0NPUkUJMgorI2RlZmluZSBUT1BPTE9HWV9ERVBUSF9DUFUJMQor
CiB2b2lkIHByaW50X2hlYWRlcihpbnQgdG9wb2xvZ3lfZGVwdGgpCiB7CiAJaW50IHVuc2ln
bmVkIG1vbjsKQEAgLTExMywxMiArMTE4LDE5IEBAIHZvaWQgcHJpbnRfaGVhZGVyKGludCB0
b3BvbG9neV9kZXB0aCkKIAl9CiAJcHJpbnRmKCJcbiIpOwogCi0JaWYgKHRvcG9sb2d5X2Rl
cHRoID4gMikKKwlzd2l0Y2ggKHRvcG9sb2d5X2RlcHRoKSB7CisJY2FzZSBUT1BPTE9HWV9E
RVBUSF9QS0c6CiAJCXByaW50ZigiIFBLR3wiKTsKLQlpZiAodG9wb2xvZ3lfZGVwdGggPiAx
KQorCQlicmVhazsKKwljYXNlIFRPUE9MT0dZX0RFUFRIX0NPUkU6CiAJCXByaW50ZigiQ09S
RXwiKTsKLQlpZiAodG9wb2xvZ3lfZGVwdGggPiAwKQorCQlicmVhazsKKwljYXNlCVRPUE9M
T0dZX0RFUFRIX0NQVToKIAkJcHJpbnRmKCIgQ1BVfCIpOworCQlicmVhazsKKwlkZWZhdWx0
OgorCQlyZXR1cm47CisJfQogCiAJZm9yIChtb24gPSAwOyBtb24gPCBhdmFpbF9tb25pdG9y
czsgbW9uKyspIHsKIAkJaWYgKG1vbiAhPSAwKQpAQCAtMTUyLDEyICsxNjQsMTkgQEAgdm9p
ZCBwcmludF9yZXN1bHRzKGludCB0b3BvbG9neV9kZXB0aCwgaW50IGNwdSkKIAkgICAgY3B1
X3RvcC5jb3JlX2luZm9bY3B1XS5wa2cgPT0gLTEpCiAJCXJldHVybjsKIAotCWlmICh0b3Bv
bG9neV9kZXB0aCA+IDIpCisJc3dpdGNoICh0b3BvbG9neV9kZXB0aCkgeworCWNhc2UgVE9Q
T0xPR1lfREVQVEhfUEtHOgogCQlwcmludGYoIiU0ZHwiLCBjcHVfdG9wLmNvcmVfaW5mb1tj
cHVdLnBrZyk7Ci0JaWYgKHRvcG9sb2d5X2RlcHRoID4gMSkKKwkJYnJlYWs7CisJY2FzZSBU
T1BPTE9HWV9ERVBUSF9DT1JFOgogCQlwcmludGYoIiU0ZHwiLCBjcHVfdG9wLmNvcmVfaW5m
b1tjcHVdLmNvcmUpOwotCWlmICh0b3BvbG9neV9kZXB0aCA+IDApCisJCWJyZWFrOworCWNh
c2UgVE9QT0xPR1lfREVQVEhfQ1BVOgogCQlwcmludGYoIiU0ZHwiLCBjcHVfdG9wLmNvcmVf
aW5mb1tjcHVdLmNwdSk7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJldHVybjsKKwl9CiAK
IAlmb3IgKG1vbiA9IDA7IG1vbiA8IGF2YWlsX21vbml0b3JzOyBtb24rKykgewogCQlpZiAo
bW9uICE9IDApCkBAIC0yOTQsNyArMzEzLDEwIEBAIGludCBmb3JrX2l0KGNoYXIgKiphcmd2
KQogCiAJaWYgKCFjaGlsZF9waWQpIHsKIAkJLyogY2hpbGQgKi8KLQkJZXhlY3ZwKGFyZ3Zb
MF0sIGFyZ3YpOworCQlpZiAoZXhlY3ZwKGFyZ3ZbMF0sIGFyZ3YpID09IC0xKSB7CisJCQlw
cmludGYoIkludmFsaWQgbW9uaXRvciBjb21tYW5kICVzXG4iLCBhcmd2WzBdKTsKKwkJCWV4
aXQoZXJybm8pOworCQl9CiAJfSBlbHNlIHsKIAkJLyogcGFyZW50ICovCiAJCWlmIChjaGls
ZF9waWQgPT0gLTEpIHsKQEAgLTQyMywxMSArNDQ1LDEzIEBAIGludCBjbWRfbW9uaXRvcihp
bnQgYXJnYywgY2hhciAqKmFyZ3YpCiAKIAlpZiAoYXZhaWxfbW9uaXRvcnMgPT0gMCkgewog
CQlwcmludGYoXygiTm8gSFcgQ3N0YXRlIG1vbml0b3JzIGZvdW5kXG4iKSk7CisJCWNwdV90
b3BvbG9neV9yZWxlYXNlKGNwdV90b3ApOwogCQlyZXR1cm4gMTsKIAl9CiAKIAlpZiAobW9k
ZSA9PSBsaXN0KSB7CiAJCWxpc3RfbW9uaXRvcnMoKTsKKwkJY3B1X3RvcG9sb2d5X3JlbGVh
c2UoY3B1X3RvcCk7CiAJCWV4aXQoRVhJVF9TVUNDRVNTKTsKIAl9CiAKQEAgLTQ0OCwxNSAr
NDcyLDE1IEBAIGludCBjbWRfbW9uaXRvcihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJLyog
VG9EbzogVG9wb2xvZ3kgcGFyc2luZyBuZWVkcyBmaXhpbmcgZmlyc3QgdG8gZG8KIAkgICB0
aGlzIG1vcmUgZ2VuZXJpY2FsbHkgKi8KIAlpZiAoY3B1X3RvcC5wa2dzID4gMSkKLQkJcHJp
bnRfaGVhZGVyKDMpOworCQlwcmludF9oZWFkZXIoVE9QT0xPR1lfREVQVEhfUEtHKTsKIAll
bHNlCi0JCXByaW50X2hlYWRlcigxKTsKKwkJcHJpbnRfaGVhZGVyKFRPUE9MT0dZX0RFUFRI
X0NQVSk7CiAKIAlmb3IgKGNwdSA9IDA7IGNwdSA8IGNwdV9jb3VudDsgY3B1KyspIHsKIAkJ
aWYgKGNwdV90b3AucGtncyA+IDEpCi0JCQlwcmludF9yZXN1bHRzKDMsIGNwdSk7CisJCQlw
cmludF9yZXN1bHRzKFRPUE9MT0dZX0RFUFRIX1BLRywgY3B1KTsKIAkJZWxzZQotCQkJcHJp
bnRfcmVzdWx0cygxLCBjcHUpOworCQkJcHJpbnRfcmVzdWx0cyhUT1BPTE9HWV9ERVBUSF9D
UFUsIGNwdSk7CiAJfQogCiAJZm9yIChudW0gPSAwOyBudW0gPCBhdmFpbF9tb25pdG9yczsg
bnVtKyspIHsK

--------------c4z2ro8VFqCfYeu7uqjTuMSp--

