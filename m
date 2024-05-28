Return-Path: <linux-pm+bounces-8259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1C8D2079
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB63285541
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96D171088;
	Tue, 28 May 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFC7nai3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB513AD3E
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910492; cv=none; b=pIzBN/98iTfy84QQKWtmmsPXPOt2yWdD5bKPpiAoN5+pdONRnEvj2xbPP7rSBsdIW50QXH9KpsfPyfFnpQME1yY+bWwJy6SOW9taO41TcOsx7G7WOktpRHi5rOTE6j/DAs7SDi89F0Lan53IJ1Om1zi8vTQX3qk9sfdUEf3tO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910492; c=relaxed/simple;
	bh=vC0w40MGN2WIUDZQtOSvRbjdb/Y8c0Z7+zFOK9yKr8I=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=ZXYlJhsIgKWNKZ4pvkaZaPURcUZTyHiztYkieyrV+g8fZoLSQh/ZqWTw16J/R9Vfw0vnt8jBcBAchKgBWgR/83BIiSXb8DMGRtq0aEqpE/g9rPEwiMdAVnA6sSCRO4+IX69beLvx24OXKd/z9UWReZEgX5so1wHSoMKbiHlYqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFC7nai3; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso609575ab.1
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716910489; x=1717515289; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TxH2CEzWTNvurLJ95G+sh7WKWtr5xdhPqcXGZ3Cn6xg=;
        b=CFC7nai3soD6DJLGqICdxJeMGlQbqjDfY/Dm4bgNDHu98HuhsZOR5a5o8/2X3pR56N
         Kmb421hAPRBPqt+30PEVdNMQ0serZ7JPVApImbvoPa09w9X2Iia+aDh14Kxa+3npyqmK
         oSS5UyyQi7ZYfA/3ryZcjg/Brw5tv29dl49J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910489; x=1717515289;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxH2CEzWTNvurLJ95G+sh7WKWtr5xdhPqcXGZ3Cn6xg=;
        b=OfgDlzTt6h4ZA3l6wvXv9jAf6CekDLKmFG5YJZMy+1P9uQto6x76wxtEcGOPThICb2
         uHUkwfQtOh+PAwdWtigEoEJoSRk5A4YbViZAhMIGBm2oDMMq07XK6ZbmsJ6eusFRJgyM
         m+l2+I/hZAlahAp0HR+vOAQaVwKa1gHLj2zLgw3vyO8iVXd25zdj3O8IxJRmqAzqtHv7
         d5maqqqOZuhwfdro/oBZDm+DIpRngBCVkkkVyisGhvx9QSgsaQw2XMnDqBoEYN6wQirm
         pMFTWvshqIFK+v3l8rsnct0beBh8OdQkbqXT7FoVBF/sI9OorOGgdkXYKXcBbExWmy/2
         HIOg==
X-Forwarded-Encrypted: i=1; AJvYcCWXHtE5pP9kz/NILss5DqVUZDhe1cYMpJAAVH5qf4YKJuJ7MAE9BXvbrQT3nO7An0PbPLUuwAz5sLJ47PGgWy+CzYsI+fkA+aU=
X-Gm-Message-State: AOJu0Ywwsz7+28lBIrAuk4s7HgpJ5OgxR5AR42XQi8ezm+jhM9G3IrJX
	4Tvge/RyF80fAFFhbJjeCtcC4zDEIJlXNNbYuHcKYppYX5vxJg+kkbIXAkFKh6o=
X-Google-Smtp-Source: AGHT+IGKblHKqjZqVeSXuMBNjoXyv02VV7eUy0mqVbJikccfABIah4gX7N0Lf1QhvNWDD4UNGgti/A==
X-Received: by 2002:a05:6e02:138e:b0:36c:c599:698a with SMTP id e9e14a558f8ab-3737b3607a5mr127316935ab.2.1716910489169;
        Tue, 28 May 2024 08:34:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737c29e251sm21046455ab.2.2024.05.28.08.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:34:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------oyRVwyezVr6EWEqTt4nB0zUS"
Message-ID: <9ff1faf8-eec4-4776-a590-4efbc141fe93@linuxfoundation.org>
Date: Tue, 28 May 2024 09:34:47 -0600
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
 Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.10-rc2

This is a multi-part message in MIME format.
--------------oyRVwyezVr6EWEqTt4nB0zUS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower fixes update for Linux 6.10-rc2.

This cpupower fixes update for Linux 6.10-rc2 consists of one single
fix to cpupower's P-State frequency calculation and reporting with
AMD Family 1Ah+ processors, when using the acpi-cpufreq driver.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.10-rc2

for you to fetch changes up to 43cad521c6d228ea0c51e248f8e5b3a6295a2849:

   tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs (2024-05-28 09:22:57 -0600)

----------------------------------------------------------------
linux-cpupower-6.10-rc2

This cpupower fixes update for Linux 6.10-rc2 consists of one single
fix to cpupower's P-State frequency calculation and reporting with
AMD Family 1Ah+ processors, when using the acpi-cpufreq driver.

----------------------------------------------------------------
Dhananjay Ugwekar (1):
       tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs

  tools/power/cpupower/utils/helpers/amd.c | 26 +++++++++++++++++++++++---
  1 file changed, 23 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------oyRVwyezVr6EWEqTt4nB0zUS
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.10-rc2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.10-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvYW1kLmMg
Yi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2FtZC5jCmluZGV4IGM1MTlj
Yzg5Yzk3Zi4uMGE1NmUyMjI0MGZjIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dl
ci91dGlscy9oZWxwZXJzL2FtZC5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxz
L2hlbHBlcnMvYW1kLmMKQEAgLTQxLDYgKzQxLDE2IEBAIHVuaW9uIGNvcmVfcHN0YXRlIHsK
IAkJdW5zaWduZWQgcmVzMTozMTsKIAkJdW5zaWduZWQgZW46MTsKIAl9IHBzdGF0ZWRlZjsK
KwkvKiBzaW5jZSBmYW0gMUFoOiAqLworCXN0cnVjdCB7CisJCXVuc2lnbmVkIGZpZDoxMjsK
KwkJdW5zaWduZWQgcmVzMToyOworCQl1bnNpZ25lZCB2aWQ6ODsKKwkJdW5zaWduZWQgaWRk
dmFsOjg7CisJCXVuc2lnbmVkIGlkZGRpdjoyOworCQl1bnNpZ25lZCByZXMyOjMxOworCQl1
bnNpZ25lZCBlbjoxOworCX0gcHN0YXRlZGVmMjsKIAl1bnNpZ25lZCBsb25nIGxvbmcgdmFs
OwogfTsKIApAQCAtNDgsNiArNTgsMTAgQEAgc3RhdGljIGludCBnZXRfZGlkKHVuaW9uIGNv
cmVfcHN0YXRlIHBzdGF0ZSkKIHsKIAlpbnQgdDsKIAorCS8qIEZhbSAxQWggb253YXJkIGRv
IG5vdCB1c2UgZGlkICovCisJaWYgKGNwdXBvd2VyX2NwdV9pbmZvLmZhbWlseSA+PSAweDFB
KQorCQlyZXR1cm4gMDsKKwogCWlmIChjcHVwb3dlcl9jcHVfaW5mby5jYXBzICYgQ1BVUE9X
RVJfQ0FQX0FNRF9QU1RBVEVERUYpCiAJCXQgPSBwc3RhdGUucHN0YXRlZGVmLmRpZDsKIAll
bHNlIGlmIChjcHVwb3dlcl9jcHVfaW5mby5mYW1pbHkgPT0gMHgxMikKQEAgLTYxLDEyICs3
NSwxOCBAQCBzdGF0aWMgaW50IGdldF9kaWQodW5pb24gY29yZV9wc3RhdGUgcHN0YXRlKQog
c3RhdGljIGludCBnZXRfY29mKHVuaW9uIGNvcmVfcHN0YXRlIHBzdGF0ZSkKIHsKIAlpbnQg
dDsKLQlpbnQgZmlkLCBkaWQsIGNvZjsKKwlpbnQgZmlkLCBkaWQsIGNvZiA9IDA7CiAKIAlk
aWQgPSBnZXRfZGlkKHBzdGF0ZSk7CiAJaWYgKGNwdXBvd2VyX2NwdV9pbmZvLmNhcHMgJiBD
UFVQT1dFUl9DQVBfQU1EX1BTVEFURURFRikgewotCQlmaWQgPSBwc3RhdGUucHN0YXRlZGVm
LmZpZDsKLQkJY29mID0gMjAwICogZmlkIC8gZGlkOworCQlpZiAoY3B1cG93ZXJfY3B1X2lu
Zm8uZmFtaWx5ID49IDB4MUEpIHsKKwkJCWZpZCA9IHBzdGF0ZS5wc3RhdGVkZWYyLmZpZDsK
KwkJCWlmIChmaWQgPiAweDBmKQorCQkJCWNvZiA9IChmaWQgKiA1KTsKKwkJfSBlbHNlIHsK
KwkJCWZpZCA9IHBzdGF0ZS5wc3RhdGVkZWYuZmlkOworCQkJY29mID0gMjAwICogZmlkIC8g
ZGlkOworCQl9CiAJfSBlbHNlIHsKIAkJdCA9IDB4MTA7CiAJCWZpZCA9IHBzdGF0ZS5wc3Rh
dGUuZmlkOwo=

--------------oyRVwyezVr6EWEqTt4nB0zUS--

