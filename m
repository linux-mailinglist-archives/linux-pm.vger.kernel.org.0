Return-Path: <linux-pm+bounces-13640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D596CA07
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 00:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A283E1C25246
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27514F9CF;
	Wed,  4 Sep 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATDnluL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD913A869
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487330; cv=none; b=cw7yIpukLG2tu+FMw6L9ZY/bXeTXrE0W2+gviI/Uv97QTaOs6I8Y4jQhqSs2G9EiSxoBLyWjzHmq/sxEs3BfzLqTnILWiJNzlBBE5ZcCQ0/kegfT99vEUXMX3VK7aOoBKyFxMhqtlUrtWgJhEyLOyAr5V3y2ndN6WkLZjZ1mM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487330; c=relaxed/simple;
	bh=mfP2MugdJrOVES2m26Q+kF/3uOuj6ILICQIOU4++hZA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=Qvel5OMhhoZDysxtCR6DXdJYrD6Oab5LOcXEIqZS+mn+Nlp8u/ON0W2muw4AVTOeixbWYYTaMGJop7seL85LH+mO2SW5uAqE9Jke1ez+GSyKncHV40k7bPeptliWcwRhWo+NTuAercJMtWC55YUcoomhkWf0gNG2fd0w+zhtIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATDnluL3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a205810ccso2030039f.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725487327; x=1726092127; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A7fWh6Nr535svbXE8LjWgX0vFySt81kemsy1ZoWE5KQ=;
        b=ATDnluL3w8jg7PV7V4agqmU+XAe3fkwG+66BryH/V2xBtlsKEykhx+4WvGViuHTtvA
         W7ert9lOd802k7k6orgmRta9hmw0f6z5K3W4avPv2ulXKiBPAOWrA3Tj2NCqiXRPBpMV
         jxQIxX4rwhwA+HBAW3UYvpjG+IRmP00obRVTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725487327; x=1726092127;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7fWh6Nr535svbXE8LjWgX0vFySt81kemsy1ZoWE5KQ=;
        b=DyKIPJglW/Gbd796m22JGt9sgnipMFcprJ/1FphHX86XgbWF1n7ze9wSo/kwbxDnY1
         wn8f+bGruBcPGRmIXe3zP94jKVEp2k1Z8my32XiXcxgYcenZLJlpEDnrRQM+3tG7b1Nm
         2l7ct9gQ7yaF4vdzcLQPqHVpayo/cOhEQil8Ag1Cefgz7/Vy+zifBrOAi+Lq4EKkInJz
         g0pOXb8phYqiqUYBkFIi+mTnFFqCHhUirub9eYHAbsXusx+7IR0cm6OoFpUOdcoIrjUg
         htVCTvyCxx7Jk36N/VhyK6F11KuOqgfSyLbr5f1iCZzBp7Rhg7Va7N89IDBuVpg2onH7
         wczA==
X-Forwarded-Encrypted: i=1; AJvYcCVui4xkM8c2m9XgOgo68kFH/NW4DDxj085OuB6/9G4bK4zF20OLdJaZqBaAl8wFbguqwkOKdsVhSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/ssPcBTrbWnl6pl85z5EEOyqtyn1irMmnXsu+Vrlb/0MJNhF
	yhotY4UDAGfJWOunCs2GoutM1fChIxPZSECk+w/GJ9zfZfizmc0TemQu2iK02o4=
X-Google-Smtp-Source: AGHT+IExA2/nC/kqatN5O9Jm1D0CL+IoUAf1shwfQkUHmNXOLmUB9Waz4VdhSGlmlSlaN8UhNkTFWg==
X-Received: by 2002:a05:6602:6410:b0:82a:2053:e715 with SMTP id ca18e2360f4ac-82a36f448c5mr1755806339f.14.1725487327445;
        Wed, 04 Sep 2024 15:02:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e17177sm3269449173.78.2024.09.04.15.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 15:02:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------OnVhVSukisMPZgdyzfBtoDqk"
Message-ID: <a226a5ab-b30f-47a8-825b-2ee073cbe28a@linuxfoundation.org>
Date: Wed, 4 Sep 2024 16:02:06 -0600
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.12-rc1

This is a multi-part message in MIME format.
--------------OnVhVSukisMPZgdyzfBtoDqk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.12-rc1.

This cpupower update for Linux 6.12-rc1 consists of an enhancement
to cpuidle tool to display the residency value of cpuidle states.
This addition provides a clearer and more detailed view of idle
state information when using cpuidle-info.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.12-rc1

for you to fetch changes up to 76fb981ad6774b82f06703c896b492c8659b543b:

   tools/cpupower: display residency value in idle-info (2024-08-09 10:32:33 -0600)

----------------------------------------------------------------
linux-cpupower-6.12-rc1

This cpupower update for Linux 6.12-rc1 consists of an enhancement
to cpuidle tool to display the residency value of cpuidle states.
This addition provides a clearer and more detailed view of idle
state information when using cpuidle-info.

----------------------------------------------------------------
Aboorva Devarajan (1):
       tools/cpupower: display residency value in idle-info

  tools/power/cpupower/lib/cpuidle.c        | 8 ++++++++
  tools/power/cpupower/lib/cpuidle.h        | 2 ++
  tools/power/cpupower/utils/cpuidle-info.c | 4 ++++
  3 files changed, 14 insertions(+)
----------------------------------------------------------------
--------------OnVhVSukisMPZgdyzfBtoDqk
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.12-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.12-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMgYi90b29s
cy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRsZS5jCmluZGV4IDQ3OWM1OTcxYWE2ZC4uMGVj
YWMwMDkyNzNjIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRs
ZS5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMKQEAgLTExNiw2
ICsxMTYsNyBAQCBlbnVtIGlkbGVzdGF0ZV92YWx1ZSB7CiAJSURMRVNUQVRFX1VTQUdFLAog
CUlETEVTVEFURV9QT1dFUiwKIAlJRExFU1RBVEVfTEFURU5DWSwKKwlJRExFU1RBVEVfUkVT
SURFTkNZLAogCUlETEVTVEFURV9USU1FLAogCUlETEVTVEFURV9ESVNBQkxFLAogCU1BWF9J
RExFU1RBVEVfVkFMVUVfRklMRVMKQEAgLTEyNSw2ICsxMjYsNyBAQCBzdGF0aWMgY29uc3Qg
Y2hhciAqaWRsZXN0YXRlX3ZhbHVlX2ZpbGVzW01BWF9JRExFU1RBVEVfVkFMVUVfRklMRVNd
ID0gewogCVtJRExFU1RBVEVfVVNBR0VdID0gInVzYWdlIiwKIAlbSURMRVNUQVRFX1BPV0VS
XSA9ICJwb3dlciIsCiAJW0lETEVTVEFURV9MQVRFTkNZXSA9ICJsYXRlbmN5IiwKKwlbSURM
RVNUQVRFX1JFU0lERU5DWV0gPSAicmVzaWRlbmN5IiwKIAlbSURMRVNUQVRFX1RJTUVdICA9
ICJ0aW1lIiwKIAlbSURMRVNUQVRFX0RJU0FCTEVdICA9ICJkaXNhYmxlIiwKIH07CkBAIC0y
NTQsNiArMjU2LDEyIEBAIHVuc2lnbmVkIGxvbmcgY3B1aWRsZV9zdGF0ZV9sYXRlbmN5KHVu
c2lnbmVkIGludCBjcHUsCiAJcmV0dXJuIGNwdWlkbGVfc3RhdGVfZ2V0X29uZV92YWx1ZShj
cHUsIGlkbGVzdGF0ZSwgSURMRVNUQVRFX0xBVEVOQ1kpOwogfQogCit1bnNpZ25lZCBsb25n
IGNwdWlkbGVfc3RhdGVfcmVzaWRlbmN5KHVuc2lnbmVkIGludCBjcHUsCisJCQkJCSAgdW5z
aWduZWQgaW50IGlkbGVzdGF0ZSkKK3sKKwlyZXR1cm4gY3B1aWRsZV9zdGF0ZV9nZXRfb25l
X3ZhbHVlKGNwdSwgaWRsZXN0YXRlLCBJRExFU1RBVEVfUkVTSURFTkNZKTsKK30KKwogdW5z
aWduZWQgbG9uZyBjcHVpZGxlX3N0YXRlX3VzYWdlKHVuc2lnbmVkIGludCBjcHUsCiAJCQkJ
CXVuc2lnbmVkIGludCBpZGxlc3RhdGUpCiB7CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9j
cHVwb3dlci9saWIvY3B1aWRsZS5oIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL2NwdWlk
bGUuaAppbmRleCAyZTEwZmVhZDJlMWUuLjJhYjQwNGQ0MDI1OSAxMDA2NDQKLS0tIGEvdG9v
bHMvcG93ZXIvY3B1cG93ZXIvbGliL2NwdWlkbGUuaAorKysgYi90b29scy9wb3dlci9jcHVw
b3dlci9saWIvY3B1aWRsZS5oCkBAIC04LDYgKzgsOCBAQCBpbnQgY3B1aWRsZV9zdGF0ZV9k
aXNhYmxlKHVuc2lnbmVkIGludCBjcHUsIHVuc2lnbmVkIGludCBpZGxlc3RhdGUsCiAJCQkJ
ICAgdW5zaWduZWQgaW50IGRpc2FibGUpOwogdW5zaWduZWQgbG9uZyBjcHVpZGxlX3N0YXRl
X2xhdGVuY3kodW5zaWduZWQgaW50IGNwdSwKIAkJCQkJCXVuc2lnbmVkIGludCBpZGxlc3Rh
dGUpOwordW5zaWduZWQgbG9uZyBjcHVpZGxlX3N0YXRlX3Jlc2lkZW5jeSh1bnNpZ25lZCBp
bnQgY3B1LAorCQkJCQkJdW5zaWduZWQgaW50IGlkbGVzdGF0ZSk7CiB1bnNpZ25lZCBsb25n
IGNwdWlkbGVfc3RhdGVfdXNhZ2UodW5zaWduZWQgaW50IGNwdSwKIAkJCQkJdW5zaWduZWQg
aW50IGlkbGVzdGF0ZSk7CiB1bnNpZ25lZCBsb25nIGxvbmcgY3B1aWRsZV9zdGF0ZV90aW1l
KHVuc2lnbmVkIGludCBjcHUsCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9jcHVpZGxlLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWlk
bGUtaW5mby5jCmluZGV4IDQ0MTI2YTg3ZmE3YS4uZTBkMTdmMGRlM2ZlIDEwMDY0NAotLS0g
YS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYworKysgYi90b29s
cy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYwpAQCAtNjQsNiArNjQsOCBA
QCBzdGF0aWMgdm9pZCBjcHVpZGxlX2NwdV9vdXRwdXQodW5zaWduZWQgaW50IGNwdSwgaW50
IHZlcmJvc2UpCiAKIAkJcHJpbnRmKF8oIkxhdGVuY3k6ICVsdVxuIiksCiAJCSAgICAgICBj
cHVpZGxlX3N0YXRlX2xhdGVuY3koY3B1LCBpZGxlc3RhdGUpKTsKKwkJcHJpbnRmKF8oIlJl
c2lkZW5jeTogJWx1XG4iKSwKKwkJICAgICAgIGNwdWlkbGVfc3RhdGVfcmVzaWRlbmN5KGNw
dSwgaWRsZXN0YXRlKSk7CiAJCXByaW50ZihfKCJVc2FnZTogJWx1XG4iKSwKIAkJICAgICAg
IGNwdWlkbGVfc3RhdGVfdXNhZ2UoY3B1LCBpZGxlc3RhdGUpKTsKIAkJcHJpbnRmKF8oIkR1
cmF0aW9uOiAlbGx1XG4iKSwKQEAgLTExNSw2ICsxMTcsOCBAQCBzdGF0aWMgdm9pZCBwcm9j
X2NwdWlkbGVfY3B1X291dHB1dCh1bnNpZ25lZCBpbnQgY3B1KQogCQlwcmludGYoXygicHJv
bW90aW9uWy0tXSBkZW1vdGlvblstLV0gIikpOwogCQlwcmludGYoXygibGF0ZW5jeVslMDNs
dV0gIiksCiAJCSAgICAgICBjcHVpZGxlX3N0YXRlX2xhdGVuY3koY3B1LCBjc3RhdGUpKTsK
KwkJcHJpbnRmKF8oInJlc2lkZW5jeVslMDVsdV0gIiksCisJCSAgICAgICBjcHVpZGxlX3N0
YXRlX3Jlc2lkZW5jeShjcHUsIGNzdGF0ZSkpOwogCQlwcmludGYoXygidXNhZ2VbJTA4bHVd
ICIpLAogCQkgICAgICAgY3B1aWRsZV9zdGF0ZV91c2FnZShjcHUsIGNzdGF0ZSkpOwogCQlw
cmludGYoXygiZHVyYXRpb25bJTAyMEx1XSBcbiIpLAo=

--------------OnVhVSukisMPZgdyzfBtoDqk--

