Return-Path: <linux-pm+bounces-32455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A0B28842
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6B33BC9D4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE0232785;
	Fri, 15 Aug 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWBWnFow"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA32036F3
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296349; cv=none; b=XaLeBKI09g98Da2z8UJHXxz9NQTAwyo5Gz4Et9iWCgnPVHODM2HS/M153kE+KZpUDvpQQ8bg/R9zgebBETs0/5YjqwbwM18nGEvKo1grFdmJwh1Gga0PybyyZV0UN8vjUCfn60+s/rZeUY336WszUOAtP7nEDGyidQLIxdfXKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296349; c=relaxed/simple;
	bh=kHzSkA5FM6hRslx//42OJL8Y82FYhca2Wlx3bXr0D9w=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=p+TI3Jm2t3PhkCNpFsBqqmlt2Ar7pCIymjjEVJFZJh2pSeHP0igRqVtj8xous29cbcOVjV7bZ1/Kdsko6i+910nuvgKuVXJfRZKVilxGoCtT28VGVqYTJmEczQSzxPRF25E4aHvfrV9HuAWoAXSeE9ms5Or3LutTbG4P70h7yQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TWBWnFow; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e57376f638so6358775ab.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755296346; x=1755901146; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bPGmgshpAXTrBTTbufUuKZRIWzywWPA7eUsSoCtRUWA=;
        b=TWBWnFowsSo+NIq0yWgFHR31NtncUndCMEkIIPrXosumwcjhpNVO6M3PZ2eAXcz/R/
         /FoFh1MFFEGSCt3gWX3NTvWpAoX0MgwiudmxuIv/6mY2HLOOrN+he0/iEW4ErPehJjy4
         yvHlkzUv8wCM/XRz+j8B3RylURLRr5UaTR5w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755296346; x=1755901146;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPGmgshpAXTrBTTbufUuKZRIWzywWPA7eUsSoCtRUWA=;
        b=shC6UJ9VuvfZ7SZah/orwRQpWiZ9skMvHo7ZZiLVaDVzhW5ps+3UY89ik53+CUjQH8
         tgUHmmPKS4+JKYadcfrWvaF1JM5yH4yGdtyZYFa3YaqNMCQ0VTvZQcvvsIw/L8F5PNrj
         uwmMo2CVyXZGTp2zdoeK5pEMZqzmZ6uwOi1tkiMZ5PGM3lxw27ILTog2iTDWIIEBKcZq
         IPITE0mvK2m91wpfMyIMwaNlB8BMUVahQcCeVZOfjhJLb3eEvqwDt7CSgF9MlzQRDQWw
         7qAf1nimhvg05biBvNWpUmb0oZ1Ik0YnNw+hairqBy42kL/rGPdSpLLY3MFxYU0x+Uer
         7dNg==
X-Forwarded-Encrypted: i=1; AJvYcCVLTA66vWBDV7vXwjahcYSI3nfNmRTE7HnrUH+f583m32PaM6o2qax7JWPGhO14meW5NAczUSkIcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EOZf7n4oIAryQ74kV3Oef/Pp94ulJN2Ff8fqGAnuASCDBfpr
	xXbZ3IfgAdBHmBco12sp35ZZ/60FKnxbhFOjSaYhvq9QUdonJcThMJPNfYgAUTIhEhQ=
X-Gm-Gg: ASbGncu70mbf8GskSlVZePAIvNgrBaO7UCLq4HEG7mr65CkY4vgdePVjVySdY3RAwQZ
	qDyUR9OCg38Hh8xbq4nk3icqE+YRzggFhNA4HjO2L59zrLXIjqsUAoNZxUkGMnqv7fhGHelXeiG
	oyXRAknn8OZHTrziPhFpz68MNxGsttSzdGKZ1oO1A8rVaiok7meJY9p0Fl+qr6oY8lW8GIa4NZx
	FUkQrev54eG2ewG2LYRQV6PIVftpPLDDF06kS1f29XN+mXvx2pFVvmKHA+VUHzuiHb7N1nP/uP6
	AKxIh0Cw0om5yIypwcwiBxZUiliL2tWeP6glZnPTeWNMnObo9WwGseKRMuyXS+u3Apdb1KACtEE
	DmYdllE7Rn1dL2p2Z+5ETh1AOYUyk3bwuZ6E=
X-Google-Smtp-Source: AGHT+IGeLnQ8FQnwDj2r6Ri0X6sH3ATHGd8x3pqg2Tkt84rplEad2pPk3XjW1mxJYJ50c3ItUr7oXg==
X-Received: by 2002:a05:6e02:1987:b0:3e5:29a3:b552 with SMTP id e9e14a558f8ab-3e57e7d8cc4mr83804445ab.3.1755296346037;
        Fri, 15 Aug 2025 15:19:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94998c35sm664549173.66.2025.08.15.15.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 15:19:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dBJLR6b7HMPvvwt5QOIDWlhI"
Message-ID: <fab8f3d9-5ce7-4969-b499-488d50235c8f@linuxfoundation.org>
Date: Fri, 15 Aug 2025 16:19:04 -0600
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
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.17-rc2

This is a multi-part message in MIME format.
--------------dBJLR6b7HMPvvwt5QOIDWlhI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.17-rc2 or
in your next pr to Linus.

Fixes set subcommand -t option and enables boost control feature on
non-x86 platforms that support boot control.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.17-rc2

for you to fetch changes up to 357d1fc38aad2cf4ea6626138cbf68299d20170c:

   cpupower: Allow control of boost feature on non-x86 based systems with boost support. (2025-08-15 10:49:14 -0600)

----------------------------------------------------------------
linux-cpupower-6.17-rc2

Fixes set subcommand -t option and enables boost control feature on
non-x86 platforms that support boot control.

----------------------------------------------------------------
Shinji Nomoto (2):
       cpupower: Fix a bug where the -t option of the set subcommand was not working.
       cpupower: Allow control of boost feature on non-x86 based systems with boost support.

  tools/power/cpupower/man/cpupower-set.1      |  7 +--
  tools/power/cpupower/utils/cpufreq-info.c    | 16 +++++-
  tools/power/cpupower/utils/cpupower-set.c    |  5 +-
  tools/power/cpupower/utils/helpers/helpers.h | 14 ++---
  tools/power/cpupower/utils/helpers/misc.c    | 76 ++++++++++++++++++++--------
  5 files changed, 83 insertions(+), 35 deletions(-)
----------------------------------------------------------------
--------------dBJLR6b7HMPvvwt5QOIDWlhI
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.17-rc2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.17-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1zZXQuMSBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1zZXQuMQppbmRleCA1MDA2NTNl
Zjk4YzcuLjhhYzgyYjZmOTE4OSAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIv
bWFuL2NwdXBvd2VyLXNldC4xCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVw
b3dlci1zZXQuMQpAQCAtODEsMTAgKzgxLDExIEBAIFJlZmVyIHRvIHRoZSBBTUQgUC1TdGF0
ZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiBmb3IgZnVydGhlciBpbmZvcm1hdGlvbi4KIC5SRQog
CiAuUFAKLVwtXC10dXJib1wtYm9vc3QsIFwtdAorXC1cLXR1cmJvXC1ib29zdCwgXC1cLWJv
b3N0LCBcLXQKIC5SUyA0Ci1UaGlzIG9wdGlvbiBpcyB1c2VkIHRvIGVuYWJsZSBvciBkaXNh
YmxlIHRoZSB0dXJibyBib29zdCBmZWF0dXJlIG9uCi1zdXBwb3J0ZWQgSW50ZWwgYW5kIEFN
RCBwcm9jZXNzb3JzLgorVGhpcyBvcHRpb24gaXMgdXNlZCB0byBlbmFibGUgb3IgZGlzYWJs
ZSB0aGUgYm9vc3QgZmVhdHVyZSBvbgorc3VwcG9ydGVkIEludGVsIGFuZCBBTUQgcHJvY2Vz
c29ycywgYW5kIG90aGVyIGJvb3N0IHN1cHBvcnRlZCBzeXN0ZW1zLgorKFRoZSAtLWJvb3N0
IG9wdGlvbiBpcyBhbiBhbGlhcyBmb3IgdGhlIC0tdHVyYm8tYm9vc3Qgb3B0aW9uKQogCiBU
aGlzIG9wdGlvbiB0YWtlcyBhcyBwYXJhbWV0ZXIgZWl0aGVyIFxmQjFcZlAgdG8gZW5hYmxl
LCBvciBcZkIwXGZQIHRvIGRpc2FibGUgdGhlIGZlYXR1cmUuCiAKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWZyZXEtaW5mby5jIGIvdG9vbHMvcG93ZXIv
Y3B1cG93ZXIvdXRpbHMvY3B1ZnJlcS1pbmZvLmMKaW5kZXggZmM3NTBlMTI3NDA0Li43ZDM3
MzJmNWYyZjYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWZy
ZXEtaW5mby5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWZyZXEtaW5m
by5jCkBAIC0xMjgsNyArMTI4LDcgQEAgc3RhdGljIGludCBnZXRfYm9vc3RfbW9kZV94ODYo
dW5zaWduZWQgaW50IGNwdSkKIAkvKiBUb0RvOiBNYWtlIHRoaXMgbW9yZSBnbG9iYWwgKi8K
IAl1bnNpZ25lZCBsb25nIHBzdGF0ZXNbTUFYX0hXX1BTVEFURVNdID0gezAsfTsKIAotCXJl
dCA9IGNwdWZyZXFfaGFzX2Jvb3N0X3N1cHBvcnQoY3B1LCAmc3VwcG9ydCwgJmFjdGl2ZSwg
JmJfc3RhdGVzKTsKKwlyZXQgPSBjcHVmcmVxX2hhc194ODZfYm9vc3Rfc3VwcG9ydChjcHUs
ICZzdXBwb3J0LCAmYWN0aXZlLCAmYl9zdGF0ZXMpOwogCWlmIChyZXQpIHsKIAkJcHJpbnRm
KF8oIkVycm9yIHdoaWxlIGV2YWx1YXRpbmcgQm9vc3QgQ2FwYWJpbGl0aWVzIgogCQkJCSIg
b24gQ1BVICVkIC0tIGFyZSB5b3Ugcm9vdD9cbiIpLCBjcHUpOwpAQCAtMjA0LDYgKzIwNCwx
OCBAQCBzdGF0aWMgaW50IGdldF9ib29zdF9tb2RlX3g4Nih1bnNpZ25lZCBpbnQgY3B1KQog
CXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGdldF9ib29zdF9tb2RlX2dlbmVyaWModW5z
aWduZWQgaW50IGNwdSkKK3sKKwlib29sIGFjdGl2ZTsKKworCWlmICghY3B1ZnJlcV9oYXNf
Z2VuZXJpY19ib29zdF9zdXBwb3J0KCZhY3RpdmUpKSB7CisJCXByaW50ZihfKCIgIGJvb3N0
IHN0YXRlIHN1cHBvcnQ6XG4iKSk7CisJCXByaW50ZihfKCIgICAgQWN0aXZlOiAlc1xuIiks
IGFjdGl2ZSA/IF8oInllcyIpIDogXygibm8iKSk7CisJfQorCisJcmV0dXJuIDA7Cit9CisK
IC8qIC0tYm9vc3QgLyAtYiAqLwogCiBzdGF0aWMgaW50IGdldF9ib29zdF9tb2RlKHVuc2ln
bmVkIGludCBjcHUpCkBAIC0yMTQsNiArMjI2LDggQEAgc3RhdGljIGludCBnZXRfYm9vc3Rf
bW9kZSh1bnNpZ25lZCBpbnQgY3B1KQogCSAgICBjcHVwb3dlcl9jcHVfaW5mby52ZW5kb3Ig
PT0gWDg2X1ZFTkRPUl9IWUdPTiB8fAogCSAgICBjcHVwb3dlcl9jcHVfaW5mby52ZW5kb3Ig
PT0gWDg2X1ZFTkRPUl9JTlRFTCkKIAkJcmV0dXJuIGdldF9ib29zdF9tb2RlX3g4NihjcHUp
OworCWVsc2UKKwkJZ2V0X2Jvb3N0X21vZGVfZ2VuZXJpYyhjcHUpOwogCiAJZnJlcXMgPSBj
cHVmcmVxX2dldF9ib29zdF9mcmVxdWVuY2llcyhjcHUpOwogCWlmIChmcmVxcykgewpkaWZm
IC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1cG93ZXItc2V0LmMgYi90
b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQuYwppbmRleCAwNjc3YjU4
Mzc0YWIuLmMyMTE3ZTU2NTBkZCAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIv
dXRpbHMvY3B1cG93ZXItc2V0LmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMv
Y3B1cG93ZXItc2V0LmMKQEAgLTIxLDYgKzIxLDcgQEAgc3RhdGljIHN0cnVjdCBvcHRpb24g
c2V0X29wdHNbXSA9IHsKIAl7ImVwcCIsIHJlcXVpcmVkX2FyZ3VtZW50LCBOVUxMLCAnZSd9
LAogCXsiYW1kLXBzdGF0ZS1tb2RlIiwgcmVxdWlyZWRfYXJndW1lbnQsIE5VTEwsICdtJ30s
CiAJeyJ0dXJiby1ib29zdCIsIHJlcXVpcmVkX2FyZ3VtZW50LCBOVUxMLCAndCd9LAorCXsi
Ym9vc3QiLCByZXF1aXJlZF9hcmd1bWVudCwgTlVMTCwgJ3QnfSwKIAl7IH0sCiB9OwogCkBA
IC02Miw4ICs2Myw4IEBAIGludCBjbWRfc2V0KGludCBhcmdjLCBjaGFyICoqYXJndikKIAog
CXBhcmFtcy5wYXJhbXMgPSAwOwogCS8qIHBhcmFtZXRlciBwYXJzaW5nICovCi0Jd2hpbGUg
KChyZXQgPSBnZXRvcHRfbG9uZyhhcmdjLCBhcmd2LCAiYjplOm06IiwKLQkJCQkJCXNldF9v
cHRzLCBOVUxMKSkgIT0gLTEpIHsKKwl3aGlsZSAoKHJldCA9IGdldG9wdF9sb25nKGFyZ2Ms
IGFyZ3YsICJiOmU6bTp0OiIsCisJCQkJICBzZXRfb3B0cywgTlVMTCkpICE9IC0xKSB7CiAJ
CXN3aXRjaCAocmV0KSB7CiAJCWNhc2UgJ2InOgogCQkJaWYgKHBhcmFtcy5wZXJmX2JpYXMp
CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2hlbHBl
cnMuaCBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvaGVscGVycy5oCmlu
ZGV4IDk1NzQ5YjhlZTQ3NS4uODJlYTYyYmRmNWEyIDEwMDY0NAotLS0gYS90b29scy9wb3dl
ci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2hlbHBlcnMuaAorKysgYi90b29scy9wb3dlci9j
cHVwb3dlci91dGlscy9oZWxwZXJzL2hlbHBlcnMuaApAQCAtMTAzLDYgKzEwMyw5IEBAIGV4
dGVybiBzdHJ1Y3QgY3B1cG93ZXJfY3B1X2luZm8gY3B1cG93ZXJfY3B1X2luZm87CiAKIC8q
IGNwdWlkIGFuZCBjcHVpbmZvIGhlbHBlcnMgICoqKioqKioqKioqKioqKioqKioqKioqKioq
LwogCitpbnQgY3B1ZnJlcV9oYXNfZ2VuZXJpY19ib29zdF9zdXBwb3J0KGJvb2wgKmFjdGl2
ZSk7CitpbnQgY3B1cG93ZXJfc2V0X3R1cmJvX2Jvb3N0KGludCB0dXJib19ib29zdCk7CisK
IC8qIFg4NiBPTkxZICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
CiAjaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChfX3g4Nl82NF9fKQogCkBAIC0x
MTgsNyArMTIxLDYgQEAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgbG9uZyBtc3JfaW50ZWxfZ2V0
X3R1cmJvX3JhdGlvKHVuc2lnbmVkIGludCBjcHUpOwogCiBleHRlcm4gaW50IGNwdXBvd2Vy
X3NldF9lcHAodW5zaWduZWQgaW50IGNwdSwgY2hhciAqZXBwKTsKIGV4dGVybiBpbnQgY3B1
cG93ZXJfc2V0X2FtZF9wc3RhdGVfbW9kZShjaGFyICptb2RlKTsKLWV4dGVybiBpbnQgY3B1
cG93ZXJfc2V0X3R1cmJvX2Jvb3N0KGludCB0dXJib19ib29zdCk7CiAKIC8qIFJlYWQvV3Jp
dGUgbXNyICoqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAKQEAgLTEzOSw4ICsxNDEs
OCBAQCBleHRlcm4gaW50IGRlY29kZV9wc3RhdGVzKHVuc2lnbmVkIGludCBjcHUsIGludCBi
b29zdF9zdGF0ZXMsCiAKIC8qIEFNRCBIVyBwc3RhdGUgZGVjb2RpbmcgKioqKioqKioqKioq
KioqKioqKioqKioqKiovCiAKLWV4dGVybiBpbnQgY3B1ZnJlcV9oYXNfYm9vc3Rfc3VwcG9y
dCh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgKnN1cHBvcnQsCi0JCQkJICAgICBpbnQgKmFjdGl2
ZSwgaW50ICogc3RhdGVzKTsKK2ludCBjcHVmcmVxX2hhc194ODZfYm9vc3Rfc3VwcG9ydCh1
bnNpZ25lZCBpbnQgY3B1LCBpbnQgKnN1cHBvcnQsCisJCQkJICBpbnQgKmFjdGl2ZSwgaW50
ICpzdGF0ZXMpOwogCiAvKiBBTUQgUC1TdGF0ZSBzdHVmZiAqKioqKioqKioqKioqKioqKioq
KioqKioqKi8KIGJvb2wgY3B1cG93ZXJfYW1kX3BzdGF0ZV9lbmFibGVkKHZvaWQpOwpAQCAt
MTgxLDEzICsxODMsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfc2V0X2VwcCh1
bnNpZ25lZCBpbnQgY3B1LCBjaGFyICplcHApCiB7IHJldHVybiAtMTsgfTsKIHN0YXRpYyBp
bmxpbmUgaW50IGNwdXBvd2VyX3NldF9hbWRfcHN0YXRlX21vZGUoY2hhciAqbW9kZSkKIHsg
cmV0dXJuIC0xOyB9Owotc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfc2V0X3R1cmJvX2Jv
b3N0KGludCB0dXJib19ib29zdCkKLXsgcmV0dXJuIC0xOyB9OwogCiAvKiBSZWFkL1dyaXRl
IG1zciAqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCi1zdGF0aWMgaW5saW5lIGlu
dCBjcHVmcmVxX2hhc19ib29zdF9zdXBwb3J0KHVuc2lnbmVkIGludCBjcHUsIGludCAqc3Vw
cG9ydCwKLQkJCQkJICAgIGludCAqYWN0aXZlLCBpbnQgKiBzdGF0ZXMpCitzdGF0aWMgaW5s
aW5lIGludCBjcHVmcmVxX2hhc194ODZfYm9vc3Rfc3VwcG9ydCh1bnNpZ25lZCBpbnQgY3B1
LCBpbnQgKnN1cHBvcnQsCisJCQkJCQlpbnQgKmFjdGl2ZSwgaW50ICpzdGF0ZXMpCiB7IHJl
dHVybiAtMTsgfQogCiBzdGF0aWMgaW5saW5lIGJvb2wgY3B1cG93ZXJfYW1kX3BzdGF0ZV9l
bmFibGVkKHZvaWQpCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9o
ZWxwZXJzL21pc2MuYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlz
Yy5jCmluZGV4IDc2ZTQ2MWZmNGY3NC4uMTY2ZGMxZTQ3MGVhIDEwMDY0NAotLS0gYS90b29s
cy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL21pc2MuYworKysgYi90b29scy9wb3dl
ci9jcHVwb3dlci91dGlscy9oZWxwZXJzL21pc2MuYwpAQCAtOCwxNSArOCwxNCBAQAogI2lu
Y2x1ZGUgImhlbHBlcnMvaGVscGVycy5oIgogI2luY2x1ZGUgImhlbHBlcnMvc3lzZnMuaCIK
ICNpbmNsdWRlICJjcHVmcmVxLmgiCisjaW5jbHVkZSAiY3B1cG93ZXJfaW50ZXJuLmgiCiAK
ICNpZiBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pCiAKLSNpbmNs
dWRlICJjcHVwb3dlcl9pbnRlcm4uaCIKLQogI2RlZmluZSBNU1JfQU1EX0hXQ1IJMHhjMDAx
MDAxNQogCi1pbnQgY3B1ZnJlcV9oYXNfYm9vc3Rfc3VwcG9ydCh1bnNpZ25lZCBpbnQgY3B1
LCBpbnQgKnN1cHBvcnQsIGludCAqYWN0aXZlLAotCQkJaW50ICpzdGF0ZXMpCitpbnQgY3B1
ZnJlcV9oYXNfeDg2X2Jvb3N0X3N1cHBvcnQodW5zaWduZWQgaW50IGNwdSwgaW50ICpzdXBw
b3J0LCBpbnQgKmFjdGl2ZSwKKwkJCQkgIGludCAqc3RhdGVzKQogewogCWludCByZXQ7CiAJ
dW5zaWduZWQgbG9uZyBsb25nIHZhbDsKQEAgLTEyNCwyNCArMTIzLDYgQEAgaW50IGNwdXBv
d2VyX3NldF9hbWRfcHN0YXRlX21vZGUoY2hhciAqbW9kZSkKIAlyZXR1cm4gMDsKIH0KIAot
aW50IGNwdXBvd2VyX3NldF90dXJib19ib29zdChpbnQgdHVyYm9fYm9vc3QpCi17Ci0JY2hh
ciBwYXRoW1NZU0ZTX1BBVEhfTUFYXTsKLQljaGFyIGxpbmVidWZbMl0gPSB7fTsKLQotCXNu
cHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgUEFUSF9UT19DUFUgImNwdWZyZXEvYm9vc3Qi
KTsKLQotCWlmICghaXNfdmFsaWRfcGF0aChwYXRoKSkKLQkJcmV0dXJuIC0xOwotCi0Jc25w
cmludGYobGluZWJ1Ziwgc2l6ZW9mKGxpbmVidWYpLCAiJWQiLCB0dXJib19ib29zdCk7Ci0K
LQlpZiAoY3B1cG93ZXJfd3JpdGVfc3lzZnMocGF0aCwgbGluZWJ1ZiwgMikgPD0gMCkKLQkJ
cmV0dXJuIC0xOwotCi0JcmV0dXJuIDA7Ci19Ci0KIGJvb2wgY3B1cG93ZXJfYW1kX3BzdGF0
ZV9lbmFibGVkKHZvaWQpCiB7CiAJY2hhciAqZHJpdmVyID0gY3B1ZnJlcV9nZXRfZHJpdmVy
KDApOwpAQCAtMTYwLDYgKzE0MSwzOSBAQCBib29sIGNwdXBvd2VyX2FtZF9wc3RhdGVfZW5h
YmxlZCh2b2lkKQogCiAjZW5kaWYgLyogI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmlu
ZWQoX194ODZfNjRfXykgKi8KIAoraW50IGNwdWZyZXFfaGFzX2dlbmVyaWNfYm9vc3Rfc3Vw
cG9ydChib29sICphY3RpdmUpCit7CisJY2hhciBwYXRoW1NZU0ZTX1BBVEhfTUFYXTsKKwlj
aGFyIGxpbmVidWZbMl0gPSB7fTsKKwl1bnNpZ25lZCBsb25nIHZhbDsKKwljaGFyICplbmRw
OworCisJc25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCBQQVRIX1RPX0NQVSAiY3B1ZnJl
cS9ib29zdCIpOworCisJaWYgKCFpc192YWxpZF9wYXRoKHBhdGgpKQorCQlyZXR1cm4gLUVB
Q0NFUzsKKworCWlmIChjcHVwb3dlcl9yZWFkX3N5c2ZzKHBhdGgsIGxpbmVidWYsIDIpIDw9
IDApCisJCXJldHVybiAtRUlOVkFMOworCisJdmFsID0gc3RydG91bChsaW5lYnVmLCAmZW5k
cCwgMCk7CisJaWYgKGVuZHAgPT0gbGluZWJ1ZiB8fCBlcnJubyA9PSBFUkFOR0UpCisJCXJl
dHVybiAtRUlOVkFMOworCisJc3dpdGNoICh2YWwpIHsKKwljYXNlIDA6CisJCSphY3RpdmUg
PSBmYWxzZTsKKwkJYnJlYWs7CisJY2FzZSAxOgorCQkqYWN0aXZlID0gdHJ1ZTsKKwkJYnJl
YWs7CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJcmV0dXJuIDA7Cit9
CisKIC8qIGdldF9jcHVzdGF0ZQogICoKICAqIEdhdGhlciB0aGUgaW5mb3JtYXRpb24gb2Yg
YWxsIG9ubGluZSBDUFVzIGludG8gYml0bWFzayBzdHJ1Y3QKQEAgLTI1OSwzICsyNzMsMjEg
QEAgdm9pZCBwcmludF9zcGVlZCh1bnNpZ25lZCBsb25nIHNwZWVkLCBpbnQgbm9fcm91bmRp
bmcpCiAJCX0KIAl9CiB9CisKK2ludCBjcHVwb3dlcl9zZXRfdHVyYm9fYm9vc3QoaW50IHR1
cmJvX2Jvb3N0KQoreworCWNoYXIgcGF0aFtTWVNGU19QQVRIX01BWF07CisJY2hhciBsaW5l
YnVmWzJdID0ge307CisKKwlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksIFBBVEhfVE9f
Q1BVICJjcHVmcmVxL2Jvb3N0Iik7CisKKwlpZiAoIWlzX3ZhbGlkX3BhdGgocGF0aCkpCisJ
CXJldHVybiAtMTsKKworCXNucHJpbnRmKGxpbmVidWYsIHNpemVvZihsaW5lYnVmKSwgIiVk
IiwgdHVyYm9fYm9vc3QpOworCisJaWYgKGNwdXBvd2VyX3dyaXRlX3N5c2ZzKHBhdGgsIGxp
bmVidWYsIDIpIDw9IDApCisJCXJldHVybiAtMTsKKworCXJldHVybiAwOworfQo=

--------------dBJLR6b7HMPvvwt5QOIDWlhI--

