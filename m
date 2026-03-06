Return-Path: <linux-pm+bounces-43881-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dqosLpw8q2n7bQEAu9opvQ
	(envelope-from <linux-pm+bounces-43881-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:44:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2C22798A
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359CA301E3CB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D7480345;
	Fri,  6 Mar 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="arkqp5+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F936EAA3
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829848; cv=none; b=TnqWEUDkwZr7Jh+vD7yhdYcAbWgLAWu3wuUE2Bk9HvnjdRbr/VouUje6sG73/A+Yc31OnmxcmE0xZZIMwdLR/CO7rmLXi0Xovsrhy03e/PBFu1ap7tQ4mcYM6MbGPzsg2fSiw5pifvuWgCBkr3l2984Y/ykUduKJcE57zWogQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829848; c=relaxed/simple;
	bh=0dSnJg2XZQ0wFLX2eymzhbK95b0yIXUpq1ZEnGMrBoU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=h7w0liByKzwUCpawQJU2AOgXA5hiE8zH3Isxr5bxKb+/IV2jKsdS02TBhJrLqm7sxAesDgyXhb4BY1Dd9DrcmTwk7PrmXI7ebWYRwUcKNgEt3E7QU0oe1ti5TAuPYHTFgZCOzES8Gfh4nUPW0UUUkGepZx7PQSjvRlEErafUBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=arkqp5+o; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40974bf7781so3262623fac.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772829846; x=1773434646; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UYMmfc+QZsi5s5tHURjJ8XlsealpEFlJ0jVptmYboDg=;
        b=arkqp5+oEGPwJkQkoMilsWuK7X6lwnTr7u83GIACFljdzcABhr9m+bWebCF9eMIt+B
         dj/IHbC8qI6LPDNnnpvXyXwSFCgz47UglSyXLlQaB8ajOsWogaXY3mbcltQZ5QSMl2LL
         S8PhWCwEt7rpDZDYTB22IpNQGnHcEFZ2kwpio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772829846; x=1773434646;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYMmfc+QZsi5s5tHURjJ8XlsealpEFlJ0jVptmYboDg=;
        b=aDUON7+vUwNevFdncABLtaozmNdt+GaPQ0t2qpOAbPW21p5e5vCiNjUamXcGikre2Z
         N4E3kA0rSuhSp85WgLD5ZTIO7WCHG7yZB2MKp5bV84fR1/G1OWGdCXCqkPQKT/zjCvTo
         tZUO+K2iLMNRlAXZuxQxHwWqmbcet+nhD5/ylizD/Ld6VL7AmVX7JtSgqYcLq6Pw7HQO
         0464145D3jmgrzxorwFArHMHGfcwlQa6HZOAb/Qg+Y7iaCD5Smw7XR6ESC57wouYrBdg
         4dgz5jZaBYOeTFq+bEy1WRZI33Z/VyEOW258Q2Nq+sfI6tBEYsRmXxybbsE4gmIn79Tr
         j/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6a0V9mwhevtB5gQMME0xFgYOFXFT1tW1YfcSzLS7sbYN4zEHhsfxjUJ7pqXbFftCpqg1oFaO5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYDZ7Ym/u1DaRswv43RwZ1cn3Vv0HhT7EScqFPBJuleKI9Tmk
	9tFO8OaOWxtU1ahRkgL0hI5VSeDj4PqwgJm2nnWrQzPXVuPXezPu+IUft+knRxZJbF4=
X-Gm-Gg: ATEYQzwlBq+zBV55T5gfG9VZb6gbZMx2NejHky/N08ozSZfQ+aKo8N+KLb9fSiZ+SRN
	6fi2YM6DDda4CM1x4Fehptz+Hds9zcFJydyKLsspi6EYFoUrHj3k5fHy89PNwnEehJs/6C2KqCq
	ln4+JM1rZyi2L1SOHEfPIHsX5OK69EN2K/pARsdrO8tT9xMbOyMszNqi/ChKsIlA/Jdw1MLZZni
	Gleo7ZLm4+rhbWOS8BkwRA93c/vr/Q7P9loCm4EtU2S/++GZilaipVVDSkKTaI5XnSWU+kl6ziU
	RhA0b1jil/nHmCa2WJxZ6jPR9H6k+ypoUjTtYRyn9bAZ5Ebt1OsUsvlpoFmCLDdLkroBrMEVWeM
	Ls4DTFzfU63EHHbHjDTP1mgDwC3/2mV23SxfhHr8dQEA7x020wSCUk+cdqY+EnucmLZ9UkhYK+s
	btsblsK07uVhwFH7j++cWxanLbaC2kyTu+ShM=
X-Received: by 2002:a05:6820:8185:b0:661:1bee:284a with SMTP id 006d021491bc7-67b9c41acafmr1547890eaf.28.1772829845934;
        Fri, 06 Mar 2026 12:44:05 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67b9d5287a2sm1387393eaf.16.2026.03.06.12.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:44:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ulpg6u0nSDpI0HqvrEN4A6fF"
Message-ID: <3ac44758-822b-4a7d-94ce-23826e6cb30c@linuxfoundation.org>
Date: Fri, 6 Mar 2026 13:44:04 -0700
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
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower fixes update for Linux 7.0-rc4
X-Rspamd-Queue-Id: 0BB2C22798A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43881-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------ulpg6u0nSDpI0HqvrEN4A6fF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower fixes update for Linux 7.0-rc4.

- Adds support for setting EPP via systemd service
- Fixes swapped power/energy unit labels
- Adds intel_pstate turbo boost support for Intel platforms

diff is attached. These aren't very critical. Please send them
when you send your next PR.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-7.0-rc4

for you to fetch changes up to 3817b1d34432d3d83a61576719570d04c341b7cd:

   cpupower: Add intel_pstate turbo boost support for Intel platforms (2026-03-03 11:18:53 -0700)

----------------------------------------------------------------
linux-cpupower-7.0-rc4

- Adds support for setting EPP via systemd service
- Fixes swapped power/energy unit labels
- Adds intel_pstate turbo boost support for Intel platforms

----------------------------------------------------------------
Jan Kiszka (1):
       cpupower: Add support for setting EPP via systemd service

Kaushlendra Kumar (1):
       cpupower: fix swapped power/energy unit labels

Zhang Rui (1):
       cpupower: Add intel_pstate turbo boost support for Intel platforms

  tools/power/cpupower/cpupower-service.conf   |  5 ++++
  tools/power/cpupower/cpupower.sh             |  6 ++++
  tools/power/cpupower/utils/cpupower-set.c    |  6 +++-
  tools/power/cpupower/utils/helpers/helpers.h |  5 +++-
  tools/power/cpupower/utils/helpers/misc.c    | 41 ++++++++++++++++++++++++++--
  tools/power/cpupower/utils/powercap-info.c   |  4 +--
  6 files changed, 61 insertions(+), 6 deletions(-)

----------------------------------------------------------------
--------------ulpg6u0nSDpI0HqvrEN4A6fF
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-7.0-rc4.diff"
Content-Disposition: attachment; filename="linux-cpupower-7.0-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2NwdXBvd2VyLXNlcnZpY2UuY29u
ZiBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2NwdXBvd2VyLXNlcnZpY2UuY29uZgppbmRleCAw
MmVhYmU4ZTM2MTQuLmFiYmI0Njk2NzU2NSAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1
cG93ZXIvY3B1cG93ZXItc2VydmljZS5jb25mCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L2NwdXBvd2VyLXNlcnZpY2UuY29uZgpAQCAtMzAsMyArMzAsOCBAQAogIyBpdHMgcG9saWN5
IGZvciB0aGUgcmVsYXRpdmUgaW1wb3J0YW5jZSBvZiBwZXJmb3JtYW5jZSB2ZXJzdXMgZW5l
cmd5IHNhdmluZ3MgdG8KICMgdGhlIHByb2Nlc3Nvci4gU2VlIG1hbiBDUFVQT1dFUi1TRVQo
MSkgZm9yIGFkZGl0aW9uYWwgZGV0YWlscwogI1BFUkZfQklBUz0KKworIyBTZXQgdGhlIEVu
ZXJneSBQZXJmb3JtYW5jZSBQcmVmZXJlbmNlCisjIEF2YWlsYWJsZSBvcHRpb25zIGNhbiBi
ZSByZWFkIGZyb20KKyMgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kw
L2VuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXMKKyNFUFA9CmRpZmYg
LS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9jcHVwb3dlci5zaCBiL3Rvb2xzL3Bvd2Vy
L2NwdXBvd2VyL2NwdXBvd2VyLnNoCmluZGV4IGEzN2RkNGNmZGIyYi4uNjI4M2U4YmYyNzVk
IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9jcHVwb3dlci5zaAorKysgYi90
b29scy9wb3dlci9jcHVwb3dlci9jcHVwb3dlci5zaApAQCAtMjMsNCArMjMsMTAgQEAgdGhl
bgogICAgIGNwdXBvd2VyIHNldCAtYiAiJFBFUkZfQklBUyIgPiAvZGV2L251bGwgfHwgRVNU
QVRVUz0xCiBmaQogCisjIGFwcGx5IEVuZXJneSBQZXJmb3JtYW5jZSBQcmVmZXJlbmNlCitp
ZiB0ZXN0IC1uICIkRVBQIgordGhlbgorICAgIGNwdXBvd2VyIHNldCAtZSAiJEVQUCIgPiAv
ZGV2L251bGwgfHwgRVNUQVRVUz0xCitmaQorCiBleGl0ICRFU1RBVFVTCmRpZmYgLS1naXQg
YS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQuYyBiL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL3V0aWxzL2NwdXBvd2VyLXNldC5jCmluZGV4IGMyMTE3ZTU2NTBkZC4u
NTUwYTk0MmU3MmNlIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9j
cHVwb3dlci1zZXQuYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dl
ci1zZXQuYwpAQCAtMTI0LDcgKzEyNCwxMSBAQCBpbnQgY21kX3NldChpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCiAJfQogCiAJaWYgKHBhcmFtcy50dXJib19ib29zdCkgewotCQlyZXQgPSBj
cHVwb3dlcl9zZXRfdHVyYm9fYm9vc3QodHVyYm9fYm9vc3QpOworCQlpZiAoY3B1cG93ZXJf
Y3B1X2luZm8udmVuZG9yID09IFg4Nl9WRU5ET1JfSU5URUwpCisJCQlyZXQgPSBjcHVwb3dl
cl9zZXRfaW50ZWxfdHVyYm9fYm9vc3QodHVyYm9fYm9vc3QpOworCQllbHNlCisJCQlyZXQg
PSBjcHVwb3dlcl9zZXRfZ2VuZXJpY190dXJib19ib29zdCh0dXJib19ib29zdCk7CisKIAkJ
aWYgKHJldCkKIAkJCWZwcmludGYoc3RkZXJyLCAiRXJyb3Igc2V0dGluZyB0dXJiby1ib29z
dFxuIik7CiAJfQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVs
cGVycy9oZWxwZXJzLmggYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2hl
bHBlcnMuaAppbmRleCA4MmVhNjJiZGY1YTIuLmEzYWQ4MGI5YzJjMiAxMDA2NDQKLS0tIGEv
dG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9oZWxwZXJzLmgKKysrIGIvdG9v
bHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9oZWxwZXJzLmgKQEAgLTEwNCw3ICsx
MDQsNyBAQCBleHRlcm4gc3RydWN0IGNwdXBvd2VyX2NwdV9pbmZvIGNwdXBvd2VyX2NwdV9p
bmZvOwogLyogY3B1aWQgYW5kIGNwdWluZm8gaGVscGVycyAgKioqKioqKioqKioqKioqKioq
KioqKioqKiovCiAKIGludCBjcHVmcmVxX2hhc19nZW5lcmljX2Jvb3N0X3N1cHBvcnQoYm9v
bCAqYWN0aXZlKTsKLWludCBjcHVwb3dlcl9zZXRfdHVyYm9fYm9vc3QoaW50IHR1cmJvX2Jv
b3N0KTsKK2ludCBjcHVwb3dlcl9zZXRfZ2VuZXJpY190dXJib19ib29zdChpbnQgdHVyYm9f
Ym9vc3QpOwogCiAvKiBYODYgT05MWSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqLwogI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRf
XykKQEAgLTE0Myw2ICsxNDMsNyBAQCBleHRlcm4gaW50IGRlY29kZV9wc3RhdGVzKHVuc2ln
bmVkIGludCBjcHUsIGludCBib29zdF9zdGF0ZXMsCiAKIGludCBjcHVmcmVxX2hhc194ODZf
Ym9vc3Rfc3VwcG9ydCh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgKnN1cHBvcnQsCiAJCQkJICBp
bnQgKmFjdGl2ZSwgaW50ICpzdGF0ZXMpOworaW50IGNwdXBvd2VyX3NldF9pbnRlbF90dXJi
b19ib29zdChpbnQgdHVyYm9fYm9vc3QpOwogCiAvKiBBTUQgUC1TdGF0ZSBzdHVmZiAqKioq
KioqKioqKioqKioqKioqKioqKioqKi8KIGJvb2wgY3B1cG93ZXJfYW1kX3BzdGF0ZV9lbmFi
bGVkKHZvaWQpOwpAQCAtMTg5LDYgKzE5MCw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNwdXBv
d2VyX3NldF9hbWRfcHN0YXRlX21vZGUoY2hhciAqbW9kZSkKIHN0YXRpYyBpbmxpbmUgaW50
IGNwdWZyZXFfaGFzX3g4Nl9ib29zdF9zdXBwb3J0KHVuc2lnbmVkIGludCBjcHUsIGludCAq
c3VwcG9ydCwKIAkJCQkJCWludCAqYWN0aXZlLCBpbnQgKnN0YXRlcykKIHsgcmV0dXJuIC0x
OyB9CitzdGF0aWMgaW5saW5lIGludCBjcHVwb3dlcl9zZXRfaW50ZWxfdHVyYm9fYm9vc3Qo
aW50IHR1cmJvX2Jvb3N0KQoreyByZXR1cm4gLTE7IH0KIAogc3RhdGljIGlubGluZSBib29s
IGNwdXBvd2VyX2FtZF9wc3RhdGVfZW5hYmxlZCh2b2lkKQogeyByZXR1cm4gZmFsc2U7IH0K
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5j
IGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9taXNjLmMKaW5kZXggMTY2
ZGMxZTQ3MGVhLi5lZWJmYzc5YTQ4ODkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0
aWxzL2hlbHBlcnMvbWlzYy5jCkBAIC0xOSw2ICsxOSw5IEBAIGludCBjcHVmcmVxX2hhc194
ODZfYm9vc3Rfc3VwcG9ydCh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgKnN1cHBvcnQsIGludCAq
YWN0aXZlLAogewogCWludCByZXQ7CiAJdW5zaWduZWQgbG9uZyBsb25nIHZhbDsKKwljaGFy
IGxpbmVidWZbTUFYX0xJTkVfTEVOXTsKKwljaGFyIHBhdGhbU1lTRlNfUEFUSF9NQVhdOwor
CWNoYXIgKmVuZHA7CiAKIAkqc3VwcG9ydCA9ICphY3RpdmUgPSAqc3RhdGVzID0gMDsKIApA
QCAtNDIsOCArNDUsNDIgQEAgaW50IGNwdWZyZXFfaGFzX3g4Nl9ib29zdF9zdXBwb3J0KHVu
c2lnbmVkIGludCBjcHUsIGludCAqc3VwcG9ydCwgaW50ICphY3RpdmUsCiAJCX0KIAl9IGVs
c2UgaWYgKGNwdXBvd2VyX2NwdV9pbmZvLmNhcHMgJiBDUFVQT1dFUl9DQVBfQU1EX1BTVEFU
RSkgewogCQlhbWRfcHN0YXRlX2Jvb3N0X2luaXQoY3B1LCBzdXBwb3J0LCBhY3RpdmUpOwot
CX0gZWxzZSBpZiAoY3B1cG93ZXJfY3B1X2luZm8uY2FwcyAmIENQVVBPV0VSX0NBUF9JTlRF
TF9JREEpCisJfSBlbHNlIGlmIChjcHVwb3dlcl9jcHVfaW5mby5jYXBzICYgQ1BVUE9XRVJf
Q0FQX0lOVEVMX0lEQSkgewogCQkqc3VwcG9ydCA9ICphY3RpdmUgPSAxOworCisJCXNucHJp
bnRmKHBhdGgsIHNpemVvZihwYXRoKSwgUEFUSF9UT19DUFUgImludGVsX3BzdGF0ZS9ub190
dXJibyIpOworCisJCWlmICghaXNfdmFsaWRfcGF0aChwYXRoKSkKKwkJCXJldHVybiAwOwor
CisJCWlmIChjcHVwb3dlcl9yZWFkX3N5c2ZzKHBhdGgsIGxpbmVidWYsIE1BWF9MSU5FX0xF
TikgPT0gMCkKKwkJCXJldHVybiAtMTsKKworCQl2YWwgPSBzdHJ0b2wobGluZWJ1ZiwgJmVu
ZHAsIDApOworCQlpZiAoZW5kcCA9PSBsaW5lYnVmIHx8IGVycm5vID09IEVSQU5HRSkKKwkJ
CXJldHVybiAtMTsKKworCQkqYWN0aXZlID0gIXZhbDsKKwl9CisJcmV0dXJuIDA7Cit9CisK
K2ludCBjcHVwb3dlcl9zZXRfaW50ZWxfdHVyYm9fYm9vc3QoaW50IHR1cmJvX2Jvb3N0KQor
eworCWNoYXIgcGF0aFtTWVNGU19QQVRIX01BWF07CisJY2hhciBsaW5lYnVmWzJdID0ge307
CisKKwlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksIFBBVEhfVE9fQ1BVICJpbnRlbF9w
c3RhdGUvbm9fdHVyYm8iKTsKKworCS8qIEZhbGxiYWNrIHRvIGdlbmVyaWMgc29sdXRpb24g
d2hlbiBpbnRlbF9wc3RhdGUgZHJpdmVyIG5vdCBydW5uaW5nICovCisJaWYgKCFpc192YWxp
ZF9wYXRoKHBhdGgpKQorCQlyZXR1cm4gY3B1cG93ZXJfc2V0X2dlbmVyaWNfdHVyYm9fYm9v
c3QodHVyYm9fYm9vc3QpOworCisJc25wcmludGYobGluZWJ1Ziwgc2l6ZW9mKGxpbmVidWYp
LCAiJWQiLCAhdHVyYm9fYm9vc3QpOworCisJaWYgKGNwdXBvd2VyX3dyaXRlX3N5c2ZzKHBh
dGgsIGxpbmVidWYsIDIpIDw9IDApCisJCXJldHVybiAtMTsKKwogCXJldHVybiAwOwogfQog
CkBAIC0yNzQsNyArMzExLDcgQEAgdm9pZCBwcmludF9zcGVlZCh1bnNpZ25lZCBsb25nIHNw
ZWVkLCBpbnQgbm9fcm91bmRpbmcpCiAJfQogfQogCi1pbnQgY3B1cG93ZXJfc2V0X3R1cmJv
X2Jvb3N0KGludCB0dXJib19ib29zdCkKK2ludCBjcHVwb3dlcl9zZXRfZ2VuZXJpY190dXJi
b19ib29zdChpbnQgdHVyYm9fYm9vc3QpCiB7CiAJY2hhciBwYXRoW1NZU0ZTX1BBVEhfTUFY
XTsKIAljaGFyIGxpbmVidWZbMl0gPSB7fTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL3V0aWxzL3Bvd2VyY2FwLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0
aWxzL3Bvd2VyY2FwLWluZm8uYwppbmRleCAzZWE0NDg2ZjFhMGUuLmU1MzAzMzQ4ODIxOCAx
MDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvcG93ZXJjYXAtaW5mby5j
CisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL3Bvd2VyY2FwLWluZm8uYwpAQCAt
MzgsMTEgKzM4LDExIEBAIHN0YXRpYyBpbnQgcG93ZXJjYXBfcHJpbnRfb25lX3pvbmUoc3Ry
dWN0IHBvd2VyY2FwX3pvbmUgKnpvbmUpCiAJcHJpbnRmKCIgKCVzKVxuIiwgbW9kZSA/ICJl
bmFibGVkIiA6ICJkaXNhYmxlZCIpOwogCiAJaWYgKHpvbmUtPmhhc19wb3dlcl91dykKLQkJ
cHJpbnRmKF8oIiVzUG93ZXIgY2FuIGJlIG1vbml0b3JlZCBpbiBtaWNybyBKdWxlc1xuIiks
CisJCXByaW50ZihfKCIlc1Bvd2VyIGNhbiBiZSBtb25pdG9yZWQgaW4gbWljcm8gV2F0dHNc
biIpLAogCQkgICAgICAgcHJfcHJlZml4KTsKIAogCWlmICh6b25lLT5oYXNfZW5lcmd5X3Vq
KQotCQlwcmludGYoXygiJXNQb3dlciBjYW4gYmUgbW9uaXRvcmVkIGluIG1pY3JvIFdhdHRz
XG4iKSwKKwkJcHJpbnRmKF8oIiVzUG93ZXIgY2FuIGJlIG1vbml0b3JlZCBpbiBtaWNybyBK
dWxlc1xuIiksCiAJCSAgICAgICBwcl9wcmVmaXgpOwogCiAJcHJpbnRmKCJcbiIpOwo=

--------------ulpg6u0nSDpI0HqvrEN4A6fF--

