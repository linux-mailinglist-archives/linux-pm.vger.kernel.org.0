Return-Path: <linux-pm+bounces-30395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA2AFD73B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8E77B0C3D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923122126C;
	Tue,  8 Jul 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JeSfSNiE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1521CA0E
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003632; cv=none; b=qlDKcbPJ5zGNpgTscTw6BnZn3MEHuCURkyGoAwEtTMc2SGkGLKidaFyYK6QBL8bHXKzDukK3CfRvKLGVJv4G0einVLnJiZv6eOmh8fFbER0MvUiLGTcb8J5DPJLH99irGSbQGsUBnFurNFweu/DGLUK+BaoCGBAROcJW7tLtVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003632; c=relaxed/simple;
	bh=dB0CumTGWtJGkpBYar++Rj0PACqzVwrkyMsciBSXkLs=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=KxsD+zSKI2htlHnmOaXKg1zPiIqEJxHJ/7/fz5sqOeP0FpArGcYvmFZB35P0Zcsi0KetJ1NTtOmbG2m1As5Yiql0d/+2P/rat1PwnUJ/9rMByp4gix/NdcEKV35pWsFyLp9EXu6F/nWos6G5G9uIXQ3Wz892fN8OVHjK3uriJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JeSfSNiE; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-875f28fde67so453035839f.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752003629; x=1752608429; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2aT+wselAJy48WsFwg2kxwprmngL6RERUExxyAIax9A=;
        b=JeSfSNiEtiSTXn1CTW+T9kCCDlwbkt5n43TnecMMWKqvmHw3+B9xzI4pCDhVshizST
         lab7e7iDD2rP+BI09Ue0JVrAh/oN//3WoPshLOUT8ZyH4vWiLkpmI8b8ZtwfdttsxxKx
         uT9g0AUFRWjJzFZz2hwESV0w/EEcUDitb4Hnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003629; x=1752608429;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aT+wselAJy48WsFwg2kxwprmngL6RERUExxyAIax9A=;
        b=QmYgaslaVw2LtNhkZlAZhcE68fj70jHcpO16/IEsV7z86ETDpCt+HauHITSmnkFwSF
         WflCZ8emPTQBXJTem6m7LflYbZoX4p6spTQKxLPjfHwRagpu966pdYBL/rkLEDrHp9ZU
         G2CfLJh+peBUdtkbMAWf+D5s0vRy8T05m4z9gB7JBhpncSEgbuplrnBNwCmyWTyFuPP+
         b+p/vz9oKd+nvk8xOGYTL+CMufihBuOOqB4giZkhHz8y3td6GrbzOafat67f0dMm1quJ
         4NiiqBk67YkIXdub+spMxyCBPO1Cj3F07yG4PccaZVvAN91Kv98Pvcd7Q/BfRoQ1SSy1
         CpGg==
X-Forwarded-Encrypted: i=1; AJvYcCU4wjbE3esr5pEeZBM6NFE5KnIqrMbsXL2FLHboBEsue1APdAY8PpYAc0jFqC3csyRDf0geCUEekQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAY8vilcNY+se6hcDzDBdE19z/hQ9BlSEjPTnGPpgnE9ZWz5oE
	Dq/NtUagjJKCPYJZgSDZ+AkH5mK9aOxQqHEZqCLOGC/7WQ2zZ7B16YfaCsR7UO011Ig=
X-Gm-Gg: ASbGncs6dRSlndesAu3sT8XhZTse57hW1eMwVCrl614UqggOm12ei8GlL/w0yUawS7X
	0iU/eWexQbi8VXmxmw+JziwTUSO1k2jg/xrasuSyZR/CI/ZxUsir6OZtS3I8lyuDakGOhKnMCmy
	hmxpGPy1mysoyx45zAIwVLsZdE9GyVNknH0D4y6nWRv+iV+7XlSglF/mCp1Blxvzt20HtQ6YWNY
	8Bk/isMTKg0S8mOOzAvAxsD7LFW6gB6yGkGHtLuWpPkzMkMLc9q6TgqYFacMnM/Z4v4yb8iOPY8
	sNzb07dvxmCpAVMZ25X0N4RJUn9woUhpGX4ev0fIoaBvKnfCH3Ry0W8l4tF/0SdE8QcG+z7qug=
	=
X-Google-Smtp-Source: AGHT+IEjj39711rTkfOAsDLT8KEkdMOlxGB1B1vXgPqa+jmbk6jS6kTHoRYbAn3Ymb/KtmaWNOLnww==
X-Received: by 2002:a05:6602:2d96:b0:86a:256e:12df with SMTP id ca18e2360f4ac-8794b432c1cmr551069039f.2.1752003629195;
        Tue, 08 Jul 2025 12:40:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c8f7f2sm2338426173.145.2025.07.08.12.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 12:40:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1GPtmu3oopRfGuZOvTz2t2bY"
Message-ID: <ebbb6534-5968-4530-b9c8-0f6b21a96992@linuxfoundation.org>
Date: Tue, 8 Jul 2025 13:40:28 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.17-rc1

This is a multi-part message in MIME format.
--------------1GPtmu3oopRfGuZOvTz2t2bY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.17-rc1.

Fixes
  - snapshot-order of tsc ,mperf, clock in mperf_stop()
  - printing of CORE, CPU fields in cpupower-monitor

Improves Python binding's Makefile

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e044b8a9545cd8265c7110c179aeec2624c16455:

   cpupower: split unitdir from libdir in Makefile (2025-06-09 10:17:46 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.17-rc1-fixed

for you to fetch changes up to b74710eaff314d6afe4fb0bbe9bc7657bf226fd4:

   cpupower: Improve Python binding's Makefile (2025-07-01 10:58:00 -0600)

----------------------------------------------------------------
linux-cpupower-6.17-rc1-fixed

Fixes
  - snapshot-order of tsc,mperf, clock in mperf_stop()
  - printing of CORE, CPU fields in cpupower-monitor

Improves Python binding's Makefile

----------------------------------------------------------------
Gautham R. Shenoy (2):
       pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()
       pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor

John B. Wyatt IV (1):
       cpupower: Improve Python binding's Makefile

  tools/power/cpupower/bindings/python/Makefile              | 12 +++++++-----
  tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c |  4 ----
  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    |  4 ++--
  3 files changed, 9 insertions(+), 11 deletions(-)
----------------------------------------------------------------
--------------1GPtmu3oopRfGuZOvTz2t2bY
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.17-rc1-fixed.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.17-rc1-fixed.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtl
ZmlsZSBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpp
bmRleCA4MWRiMzlhMDNlZmIuLjQ1MjdjZDczMmI0MiAxMDA2NDQKLS0tIGEvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Bvd2Vy
L2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpAQCAtNCwyMCArNCwyMiBAQAog
IyBUaGlzIE1ha2VmaWxlIGV4cGVjdHMgeW91IGhhdmUgYWxyZWFkeSBydW4gYG1ha2UgaW5z
dGFsbC1saWJgIGluIHRoZSBsaWIKICMgZGlyZWN0b3J5IGZvciB0aGUgYmluZGluZ3MgdG8g
YmUgY3JlYXRlZC4KIAotQ0MgOj0gZ2NjCitDQyA/PSBnY2MKKyMgQ0ZMQUdTID89CitMREZM
QUdTID89IC1sY3B1cG93ZXIKIEhBVkVfU1dJRyA6PSAkKHNoZWxsIGlmIHdoaWNoIHN3aWcg
Pi9kZXYvbnVsbCAyPiYxOyB0aGVuIGVjaG8gMTsgZWxzZSBlY2hvIDA7IGZpKQogSEFWRV9Q
WUNPTkZJRyA6PSAkKHNoZWxsIGlmIHdoaWNoIHB5dGhvbi1jb25maWcgPi9kZXYvbnVsbCAy
PiYxOyB0aGVuIGVjaG8gMTsgZWxzZSBlY2hvIDA7IGZpKQogCi1QWV9JTkNMVURFID0gJChm
aXJzdHdvcmQgJChzaGVsbCBweXRob24tY29uZmlnIC0taW5jbHVkZXMpKQotSU5TVEFMTF9E
SVIgPSAkKHNoZWxsIHB5dGhvbjMgLWMgImltcG9ydCBzaXRlOyBwcmludChzaXRlLmdldHNp
dGVwYWNrYWdlcygpWzBdKSIpCitQWV9JTkNMVURFID89ICQoZmlyc3R3b3JkICQoc2hlbGwg
cHl0aG9uLWNvbmZpZyAtLWluY2x1ZGVzKSkKK0lOU1RBTExfRElSID89ICQoc2hlbGwgcHl0
aG9uMyAtYyAiaW1wb3J0IHNpdGU7IHByaW50KHNpdGUuZ2V0c2l0ZXBhY2thZ2VzKClbMF0p
IikKIAogYWxsOiBfcmF3X3B5bGliY3B1cG93ZXIuc28KIAogX3Jhd19weWxpYmNwdXBvd2Vy
LnNvOiByYXdfcHlsaWJjcHVwb3dlcl93cmFwLm8KLQkkKENDKSAtc2hhcmVkIC1sY3B1cG93
ZXIgcmF3X3B5bGliY3B1cG93ZXJfd3JhcC5vIC1vIF9yYXdfcHlsaWJjcHVwb3dlci5zbwor
CSQoQ0MpIC1zaGFyZWQgJChMREZMQUdTKSByYXdfcHlsaWJjcHVwb3dlcl93cmFwLm8gLW8g
X3Jhd19weWxpYmNwdXBvd2VyLnNvCiAKIHJhd19weWxpYmNwdXBvd2VyX3dyYXAubzogcmF3
X3B5bGliY3B1cG93ZXJfd3JhcC5jCi0JJChDQykgLWZQSUMgLWMgcmF3X3B5bGliY3B1cG93
ZXJfd3JhcC5jICQoUFlfSU5DTFVERSkKKwkkKENDKSAkKENGTEFHUykgJChQWV9JTkNMVURF
KSAtZlBJQyAtYyByYXdfcHlsaWJjcHVwb3dlcl93cmFwLmMKIAogcmF3X3B5bGliY3B1cG93
ZXJfd3JhcC5jOiByYXdfcHlsaWJjcHVwb3dlci5zd2cKIGlmZXEgKCQoSEFWRV9TV0lHKSww
KQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaWRsZV9tb25pdG9y
L2NwdXBvd2VyLW1vbml0b3IuYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVf
bW9uaXRvci9jcHVwb3dlci1tb25pdG9yLmMKaW5kZXggYWQ0OTMxNTdmODI2Li5lOGIzODQx
ZDVjMGYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9u
aXRvci9jcHVwb3dlci1tb25pdG9yLmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRp
bHMvaWRsZV9tb25pdG9yL2NwdXBvd2VyLW1vbml0b3IuYwpAQCAtMTIxLDEwICsxMjEsOCBA
QCB2b2lkIHByaW50X2hlYWRlcihpbnQgdG9wb2xvZ3lfZGVwdGgpCiAJc3dpdGNoICh0b3Bv
bG9neV9kZXB0aCkgewogCWNhc2UgVE9QT0xPR1lfREVQVEhfUEtHOgogCQlwcmludGYoIiBQ
S0d8Iik7Ci0JCWJyZWFrOwogCWNhc2UgVE9QT0xPR1lfREVQVEhfQ09SRToKIAkJcHJpbnRm
KCJDT1JFfCIpOwotCQlicmVhazsKIAljYXNlCVRPUE9MT0dZX0RFUFRIX0NQVToKIAkJcHJp
bnRmKCIgQ1BVfCIpOwogCQlicmVhazsKQEAgLTE2NywxMCArMTY1LDggQEAgdm9pZCBwcmlu
dF9yZXN1bHRzKGludCB0b3BvbG9neV9kZXB0aCwgaW50IGNwdSkKIAlzd2l0Y2ggKHRvcG9s
b2d5X2RlcHRoKSB7CiAJY2FzZSBUT1BPTE9HWV9ERVBUSF9QS0c6CiAJCXByaW50ZigiJTRk
fCIsIGNwdV90b3AuY29yZV9pbmZvW2NwdV0ucGtnKTsKLQkJYnJlYWs7CiAJY2FzZSBUT1BP
TE9HWV9ERVBUSF9DT1JFOgogCQlwcmludGYoIiU0ZHwiLCBjcHVfdG9wLmNvcmVfaW5mb1tj
cHVdLmNvcmUpOwotCQlicmVhazsKIAljYXNlIFRPUE9MT0dZX0RFUFRIX0NQVToKIAkJcHJp
bnRmKCIlNGR8IiwgY3B1X3RvcC5jb3JlX2luZm9bY3B1XS5jcHUpOwogCQlicmVhazsKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9tcGVy
Zl9tb25pdG9yLmMgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9pZGxlX21vbml0b3Iv
bXBlcmZfbW9uaXRvci5jCmluZGV4IDczYjZiMTBjYmRkMi4uNWFlMDJjM2Q1YjY0IDEwMDY0
NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9pZGxlX21vbml0b3IvbXBlcmZf
bW9uaXRvci5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRv
ci9tcGVyZl9tb25pdG9yLmMKQEAgLTI0MCw5ICsyNDAsOSBAQCBzdGF0aWMgaW50IG1wZXJm
X3N0b3Aodm9pZCkKIAlpbnQgY3B1OwogCiAJZm9yIChjcHUgPSAwOyBjcHUgPCBjcHVfY291
bnQ7IGNwdSsrKSB7Ci0JCW1wZXJmX21lYXN1cmVfc3RhdHMoY3B1KTsKLQkJbXBlcmZfZ2V0
X3RzYygmdHNjX2F0X21lYXN1cmVfZW5kW2NwdV0pOwogCQljbG9ja19nZXR0aW1lKENMT0NL
X1JFQUxUSU1FLCAmdGltZV9lbmRbY3B1XSk7CisJCW1wZXJmX2dldF90c2MoJnRzY19hdF9t
ZWFzdXJlX2VuZFtjcHVdKTsKKwkJbXBlcmZfbWVhc3VyZV9zdGF0cyhjcHUpOwogCX0KIAog
CXJldHVybiAwOwo=

--------------1GPtmu3oopRfGuZOvTz2t2bY--

