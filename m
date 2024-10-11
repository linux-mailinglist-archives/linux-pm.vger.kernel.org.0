Return-Path: <linux-pm+bounces-15560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B6899AEBF
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AD11F24754
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806B1D1745;
	Fri, 11 Oct 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSO5hoDQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F019C57B
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686735; cv=none; b=Z3q0MkLdn3xiQDT8IUri9dDymPiDAtQVLSBE102kDwnyXwHeygHXxlvZOSHdlnOtp01GlF2qFPINVPmTZeOywcpsgvLtV+WOBq8pWtQEKNJp8Zkw09dK2YR2xEgdeVikziVgP4vDsubPJp5RqO9VK+xAJ0Ie8l4B1L7zulT7/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686735; c=relaxed/simple;
	bh=/FCMJGhOBfP132WERQgPWBap1EBlAXz7hyzXJiCYGis=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=YoEulYdA8eF+IsDb+SSG6pNregNxPbK1GvNPDoYxsF5oG8ZWmr8pTk+0NSUxfN9RfIFLi31VGqYiPqK//QS+jnxvUZfLzfZiecJrAK77e4CdZqm/EUbG6P3j2eReVycTe6g/uxxRqfjzIasH5L8qS6VDHh/P1vZO5W37liM2yIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSO5hoDQ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8354845c5dcso108407439f.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728686732; x=1729291532; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=paqn3xTVQkV0dR0d3F3PxlflGx0zg9ykGS3xLNtyB1w=;
        b=GSO5hoDQ8wVEBKSb2FNiKJcgiGfu6UKTLpsFfyXtbLL4sC/wvkGtbuyVz5tKaOyjwu
         XQV0j2dJPuUPnX7FI/9eirXzvGwta7hfwwha6wklA/juLkyCDLQFLL0Q1u08of0lLlPF
         5zWJ4er53RX1n/zATNBgZgzFfDwpHjmnJ75cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686732; x=1729291532;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paqn3xTVQkV0dR0d3F3PxlflGx0zg9ykGS3xLNtyB1w=;
        b=LAqEAYQ2KgLKMUMqAKJpoOzgthvWoDO2bCusqQCJ7GfVshLsLgO4EG2rq+SWZvrdPE
         1FUH/mzFefISx1gLgT3kAobzdW62/ilSUrMtGBeIEAjqGaum/T8GkAA+Q+eT/rQ0lqSZ
         bWJNBtwRQU0X4S8f7GZL5gbgJ0QiUDO7NxxmGwFLcalgjRMnQBGcs0FjGM6qhvLGPy85
         8gKsUkwpAcR/Dn19diuORS44BtNG8Mq+cTlL5Ly+FLLZzCY4ygcFLkuq1jY+n5t1twM7
         Ddw9QnIaT5zhM7Bc2xWm2VTpNBhTqe9+47K0uUXhD8LVr9MtA0QcMck1vm0ILNkHGCYy
         HSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+dv6f19JVJ3/jvUHNy/k2qQbsjMUv/cY20ILFC8gz+gxbOdVPVA967pHlDLnsphQKxA2q5suEUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysfgnzSLDNfhmokkaPBTiRxqygNBmKB6HJ+YSzByYE7ycc0MpG
	MCfBQ0wSRhpWS8jWe/B4y59ihXjmi+kvOryKd7qDdROFlTIvS07mBzx4ObmpTr0=
X-Google-Smtp-Source: AGHT+IF7PSfdpqbIiRfpxg6gV+wwdRwz/dWnWtMDLBn7hMhq8bKUWJh4Og56tdMNtLsFa7j2abtBOQ==
X-Received: by 2002:a92:cda1:0:b0:3a3:a7bf:7f85 with SMTP id e9e14a558f8ab-3a3b5f1b9c5mr27561195ab.5.1728686731866;
        Fri, 11 Oct 2024 15:45:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdae18esm9097875ab.6.2024.10.11.15.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 15:45:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------cLL5ubgQKr70I09Ji0hLxSSU"
Message-ID: <c9e75c82-77c5-4f10-972f-14dbc2b70843@linuxfoundation.org>
Date: Fri, 11 Oct 2024 16:45:30 -0600
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.13-rc1

This is a multi-part message in MIME format.
--------------cLL5ubgQKr70I09Ji0hLxSSU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.13-rc1.

This cpupower update for Linux 6.13-rc1 consists of changes to:

-- bindings:
    - add generated files to gitignore
    - improve disable c_state block
    - new test to confirm cpu state is disabled

-- bench:
    - print config file path when open cpufreq-bench.conf fails

-- Makefile
    - override cross-compiling env params to make it easier for builds
      in Yocto environment.

-- add documentation for new EPP value change, amd_pstate mode change,
    and turbo-boost features.

diff is attached.

Sending it early to get the Yacto build available in next.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.13-rc1

for you to fetch changes up to b6a2dbf88aa793a288f77e0eddb395f79594908f:

   pm: cpupower: bindings: Add test to confirm cpu state is disabled (2024-10-02 14:50:23 -0600)

----------------------------------------------------------------
linux-cpupower-6.13-rc1

This cpupower update for Linux 6.13-rc1 consists of changes to:

-- bindings:
    - add generated files to gitignore
    - improve disable c_state block
    - new test to confirm cpu state is disabled

-- bench:
    - print config file path when open cpufreq-bench.conf fails

-- Makefile
    - override cross-compiling env params to make it easier for builds
      in Yocto environment.

-- add documentation for new EPP value change, amd_pstate mode change,
    and turbo-boost features.

----------------------------------------------------------------
John B. Wyatt IV (3):
       pm: cpupower: gitignore: Add compile_commands.json
       pm: cpupower: bindings: Improve disable c_state block
       pm: cpupower: bindings: Add test to confirm cpu state is disabled

Peng Fan (2):
       pm: cpupower: bench: print config file path when open cpufreq-bench.conf fails
       pm: cpupower: Makefile: Allow overriding cross-compiling env params

Tor Vic (1):
       tools/power/cpupower: Add documentation for some recently introduced options

  tools/power/cpupower/.gitignore                    |  3 ++
  tools/power/cpupower/Makefile                      | 12 +++----
  tools/power/cpupower/bench/parse.c                 |  5 +--
  .../bindings/python/test_raw_pylibcpupower.py      | 28 ++++++++++++----
  tools/power/cpupower/man/cpupower-set.1            | 38 ++++++++++++++++++++--
  5 files changed, 70 insertions(+), 16 deletions(-)
----------------------------------------------------------------
--------------cLL5ubgQKr70I09Ji0hLxSSU
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.13-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.13-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyLy5naXRpZ25vcmUgYi90b29scy9w
b3dlci9jcHVwb3dlci8uZ2l0aWdub3JlCmluZGV4IDc2NzczMjljNDJhNi4uNTExM2Q1YTdh
ZWUwIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci8uZ2l0aWdub3JlCisrKyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyLy5naXRpZ25vcmUKQEAgLTI3LDMgKzI3LDYgQEAgZGVi
dWcvaTM4Ni9pbnRlbF9nc2ljCiBkZWJ1Zy9pMzg2L3Bvd2Vybm93LWs4LWRlY29kZQogZGVi
dWcveDg2XzY0L2NlbnRyaW5vLWRlY29kZQogZGVidWcveDg2XzY0L3Bvd2Vybm93LWs4LWRl
Y29kZQorCisjIENsYW5nJ3MgY29tcGlsYXRpb24gZGF0YWJhc2UgZmlsZQorY29tcGlsZV9j
b21tYW5kcy5qc29uCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9NYWtlZmls
ZSBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCmluZGV4IDZjMDJmNDAxMDY5ZS4u
ZTJhNDhhZjZmYTJhIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9NYWtlZmls
ZQorKysgYi90b29scy9wb3dlci9jcHVwb3dlci9NYWtlZmlsZQpAQCAtODYsMTIgKzg2LDEy
IEBAIElOU1RBTExfU0NSSVBUID0gJHtJTlNUQUxMfSAtbSA2NDQKICMgSWYgeW91IGFyZSBy
dW5uaW5nIGEgY3Jvc3MgY29tcGlsZXIsIHlvdSBtYXkgd2FudCB0byBzZXQgdGhpcwogIyB0
byBzb21ldGhpbmcgbW9yZSBpbnRlcmVzdGluZywgbGlrZSAiYXJtLWxpbnV4LSIuICBJZiB5
b3Ugd2FudAogIyB0byBjb21waWxlIHZzIHVDbGliYywgdGhhdCBjYW4gYmUgZG9uZSBoZXJl
IGFzIHdlbGwuCi1DUk9TUyA9ICMvdXNyL2kzODYtbGludXgtdWNsaWJjL3Vzci9iaW4vaTM4
Ni11Y2xpYmMtCi1DQyA9ICQoQ1JPU1MpZ2NjCi1MRCA9ICQoQ1JPU1MpZ2NjCi1BUiA9ICQo
Q1JPU1MpYXIKLVNUUklQID0gJChDUk9TUylzdHJpcAotUkFOTElCID0gJChDUk9TUylyYW5s
aWIKK0NST1NTID89ICMvdXNyL2kzODYtbGludXgtdWNsaWJjL3Vzci9iaW4vaTM4Ni11Y2xp
YmMtCitDQyA/PSAkKENST1NTKWdjYworTEQgPz0gJChDUk9TUylnY2MKK0FSID89ICQoQ1JP
U1MpYXIKK1NUUklQID89ICQoQ1JPU1Mpc3RyaXAKK1JBTkxJQiA/PSAkKENST1NTKXJhbmxp
YgogSE9TVENDID0gZ2NjCiBNS0RJUiA9IG1rZGlyCiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL2JlbmNoL3BhcnNlLmMgYi90b29scy9wb3dlci9jcHVwb3dlci9iZW5j
aC9wYXJzZS5jCmluZGV4IGU2M2RjMTFmYTNhNS4uMDgwNjc4ZDlkNzRlIDEwMDY0NAotLS0g
YS90b29scy9wb3dlci9jcHVwb3dlci9iZW5jaC9wYXJzZS5jCisrKyBiL3Rvb2xzL3Bvd2Vy
L2NwdXBvd2VyL2JlbmNoL3BhcnNlLmMKQEAgLTQsNiArNCw3IEBACiAgKiAgQ29weXJpZ2h0
IChDKSAyMDA4IENocmlzdGlhbiBLb3JuYWNrZXIgPGNrb3JuYWNrZXJAc3VzZS5kZT4KICAq
LwogCisjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUg
PHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0ZGFyZy5oPgpAQCAtMTY1LDggKzE2Niw4IEBAIGlu
dCBwcmVwYXJlX2NvbmZpZyhjb25zdCBjaGFyICpwYXRoLCBzdHJ1Y3QgY29uZmlnICpjb25m
aWcpCiAKIAljb25maWdmaWxlID0gZm9wZW4ocGF0aCwgInIiKTsKIAlpZiAoY29uZmlnZmls
ZSA9PSBOVUxMKSB7Ci0JCXBlcnJvcigiZm9wZW4iKTsKLQkJZnByaW50ZihzdGRlcnIsICJl
cnJvcjogdW5hYmxlIHRvIHJlYWQgY29uZmlnZmlsZVxuIik7CisJCWZwcmludGYoc3RkZXJy
LCAiZXJyb3I6IHVuYWJsZSB0byByZWFkIGNvbmZpZ2ZpbGU6ICVzLCAlc1xuIiwKKwkJCXBh
dGgsIHN0cmVycm9yKGVycm5vKSk7CiAJCWZyZWUoY29uZmlnKTsKIAkJcmV0dXJuIDE7CiAJ
fQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL3Rl
c3RfcmF3X3B5bGliY3B1cG93ZXIucHkgYi90b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5n
cy9weXRob24vdGVzdF9yYXdfcHlsaWJjcHVwb3dlci5weQppbmRleCAzZDZmNjJiOTU1NmEu
LmNhNWFhNDZjOWIyMCAxMDA3NTUKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGlu
Z3MvcHl0aG9uL3Rlc3RfcmF3X3B5bGliY3B1cG93ZXIucHkKKysrIGIvdG9vbHMvcG93ZXIv
Y3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL3Rlc3RfcmF3X3B5bGliY3B1cG93ZXIucHkKQEAg
LTE1LDIyICsxNSwzOCBAQCBlbHNlOgogICAgIHByaW50KGYiY3N0YXRlIGNvdW50IGVycm9y
OiByZXR1cm4gY29kZToge2NwdV9jc3RhdGVzX2NvdW50fSIpCiAKICIiIgotRGlzYWJsZSBj
c3RhdGUgKHdpbGwgZmFpbCBpZiB0aGUgYWJvdmUgaXMgMCwgZXg6IGEgdmlydHVhbCBtYWNo
aW5lKQorRGlzYWJsZSBjc3RhdGUgKHdpbGwgZmFpbCBpZiB0aGUgYWJvdmUgcmV0dXJucyBp
cyB1bmRlciAxLCBleDogYSB2aXJ0dWFsIG1hY2hpbmUpCiAiIiIKIGNzdGF0ZV9kaXNhYmxl
ZCA9IHAuY3B1aWRsZV9zdGF0ZV9kaXNhYmxlKDAsIDAsIDEpCi1pZiBjcHVfY3N0YXRlc19j
b3VudCA9PSAwOgotICAgIHByaW50KGYiQ1BVIDAgaGFzIHtjcHVfY3N0YXRlc19jb3VudH0g
Yy1zdGF0ZXMiKQotZWxzZToKLSAgICBwcmludChmImNzdGF0ZSBjb3VudCBlcnJvcjogcmV0
dXJuIGNvZGU6IHtjcHVfY3N0YXRlc19jb3VudH0iKQogCiBtYXRjaCBjc3RhdGVfZGlzYWJs
ZWQ6CiAgICAgY2FzZSAwOgogICAgICAgICBwcmludChmIkNQVSBzdGF0ZSBkaXNhYmxlZCIp
CiAgICAgY2FzZSAtMToKICAgICAgICAgcHJpbnQoZiJJZGxlc3RhdGUgbm90IGF2YWlsYWJs
ZSIpCisgICAgY2FzZSAtMjoKKyAgICAgICAgcHJpbnQoZiJEaXNhYmxpbmcgaXMgbm90IHN1
cHBvcnRlZCBieSB0aGUga2VybmVsIikKKyAgICBjYXNlIC0zOgorICAgICAgICBwcmludChm
Ik5vIHdyaXRlIGFjY2VzcyB0byBkaXNhYmxlL2VuYWJsZSBDLXN0YXRlczogdHJ5IHVzaW5n
IHN1ZG8iKQogICAgIGNhc2UgXzoKLSAgICAgICAgcHJpbnQoZiJOb3QgZG9jdW1lbnRlZCIp
CisgICAgICAgIHByaW50KGYiTm90IGRvY3VtZW50ZWQ6IHtjc3RhdGVfZGlzYWJsZWR9IikK
KworIiIiCitUZXN0IGNzdGF0ZSBpcyBkaXNhYmxlZAorIiIiCitpc19jc3RhdGVfZGlzYWJs
ZWQgPSBwLmNwdWlkbGVfaXNfc3RhdGVfZGlzYWJsZWQoMCwgMCkKIAorbWF0Y2ggaXNfY3N0
YXRlX2Rpc2FibGVkOgorICAgIGNhc2UgMToKKyAgICAgICAgcHJpbnQoZiJDUFUgaXMgZGlz
YWJsZWQiKQorICAgIGNhc2UgMDoKKyAgICAgICAgcHJpbnQoZiJDUFUgaXMgZW5hYmxlZCIp
CisgICAgY2FzZSAtMToKKyAgICAgICAgcHJpbnQoZiJJZGxlc3RhdGUgbm90IGF2YWlsYWJs
ZSIpCisgICAgY2FzZSAtMjoKKyAgICAgICAgcHJpbnQoZiJEaXNhYmxpbmcgaXMgbm90IHN1
cHBvcnRlZCBieSBrZXJuZWwiKQorICAgIGNhc2UgXzoKKyAgICAgICAgcHJpbnQoZiJOb3Qg
ZG9jdW1lbnRlZDoge2lzX2NzdGF0ZV9kaXNhYmxlZH0iKQogCiAjIFBvaW50ZXIgZXhhbXBs
ZQogCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9tYW4vY3B1cG93ZXItc2V0
LjEgYi90b29scy9wb3dlci9jcHVwb3dlci9tYW4vY3B1cG93ZXItc2V0LjEKaW5kZXggMmJj
YzY5NmY0NDk2Li41MDA2NTNlZjk4YzcgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL21hbi9jcHVwb3dlci1zZXQuMQorKysgYi90b29scy9wb3dlci9jcHVwb3dlci9tYW4v
Y3B1cG93ZXItc2V0LjEKQEAgLTMsNyArMyw3IEBACiBjcHVwb3dlclwtc2V0IFwtIFNldCBw
cm9jZXNzb3IgcG93ZXIgcmVsYXRlZCBrZXJuZWwgb3IgaGFyZHdhcmUgY29uZmlndXJhdGlv
bnMKIC5TSCBTWU5PUFNJUwogLmZ0IEIKLS5CIGNwdXBvd2VyIHNldCBbIFwtYiBWQUwgXQor
LkIgY3B1cG93ZXIgc2V0IFsgXC1iIFZBTCB8IFwtZSBQT0xJQ1kgfCBcLW0gTU9ERSB8IFwt
dCBCT09MIF0KIAogCiAuU0ggREVTQ1JJUFRJT04KQEAgLTE5LDcgKzE5LDcgQEAgZGVzY3Jp
YmVkIGluIHRoZSBPcHRpb25zIHNlY3Rpb25zLgogVXNlIFxmQmNwdXBvd2VyIGluZm8gXGZQ
IHRvIHJlYWQgb3V0IGN1cnJlbnQgc2V0dGluZ3MgYW5kIHdoZXRoZXIgdGhleSBhcmUKIHN1
cHBvcnRlZCBvbiB0aGUgc3lzdGVtIGF0IGFsbC4KIAotLlNIIE9wdGlvbnMKKy5TSCBPUFRJ
T05TCiAuUFAKIFwtXC1wZXJmLWJpYXMsIFwtYgogLlJTIDQKQEAgLTU2LDYgKzU2LDQwIEBA
IFVzZSBcZkJjcHVwb3dlciAtYyBhbGwgaW5mbyAtYlxmUCB0byB2ZXJpZnkuCiBUaGlzIG9w
dGlvbnMgbmVlZHMgdGhlIG1zciBrZXJuZWwgZHJpdmVyIChDT05GSUdfWDg2X01TUikgbG9h
ZGVkLgogLlJFCiAKKy5QUAorXC1cLWVwcCwgXC1lCisuUlMgNAorU2V0cyB0aGUgZW5lcmd5
IHBlcmZvcm1hbmNlIHBvbGljeSBwcmVmZXJlbmNlIG9uIHN1cHBvcnRlZCBJbnRlbCBvciBB
TUQKK3Byb2Nlc3NvcnMgd2hpY2ggdXNlIHRoZSBJbnRlbCBvciBBTUQgUC1TdGF0ZSBjcHVm
cmVxIGRyaXZlciByZXNwZWN0aXZlbHkuCisKK0F2YWlsYWJsZSBwb2xpY2llcyBjYW4gYmUg
Zm91bmQgd2l0aAorXGZCY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9s
aWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfYXZhaWxhYmxlX3ByZWZlcmVuY2VzXGZQIDoKKy5S
UyA0CitkZWZhdWx0IHBlcmZvcm1hbmNlIGJhbGFuY2VfcGVyZm9ybWFuY2UgYmFsYW5jZV9w
b3dlciBwb3dlcgorLlJFCisKKy5SRQorCisuUFAKK1wtXC1hbWRcLXBzdGF0ZVwtbW9kZSwg
XC1tCisuUlMgNAorU2V0cyB0aGUgQU1EIFAtU3RhdGUgbW9kZSBmb3Igc3VwcG9ydGVkIEFN
RCBwcm9jZXNzb3JzLgorQXZhaWxhYmxlIG1vZGVzIGFyZSAiYWN0aXZlIiwgImd1aWRlZCIg
b3IgInBhc3NpdmUiLgorCitSZWZlciB0byB0aGUgQU1EIFAtU3RhdGUga2VybmVsIGRvY3Vt
ZW50YXRpb24gZm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24uCisKKy5SRQorCisuUFAKK1wtXC10
dXJib1wtYm9vc3QsIFwtdAorLlJTIDQKK1RoaXMgb3B0aW9uIGlzIHVzZWQgdG8gZW5hYmxl
IG9yIGRpc2FibGUgdGhlIHR1cmJvIGJvb3N0IGZlYXR1cmUgb24KK3N1cHBvcnRlZCBJbnRl
bCBhbmQgQU1EIHByb2Nlc3NvcnMuCisKK1RoaXMgb3B0aW9uIHRha2VzIGFzIHBhcmFtZXRl
ciBlaXRoZXIgXGZCMVxmUCB0byBlbmFibGUsIG9yIFxmQjBcZlAgdG8gZGlzYWJsZSB0aGUg
ZmVhdHVyZS4KKworLlJFCisKIC5TSCAiU0VFIEFMU08iCiBjcHVwb3dlci1pbmZvKDEpLCBj
cHVwb3dlci1tb25pdG9yKDEpLCBwb3dlcnRvcCgxKQogLlBQCg==

--------------cLL5ubgQKr70I09Ji0hLxSSU--

