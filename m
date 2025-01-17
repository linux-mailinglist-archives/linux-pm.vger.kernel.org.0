Return-Path: <linux-pm+bounces-20642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE39A158A0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 21:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23BE3A23AD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB561AA786;
	Fri, 17 Jan 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxEzfhTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F61531C0
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145921; cv=none; b=Bb9sfj80lWC3rHX9Fi4ddCpyvum83lsPwH1BGYbOyicwzonHegu2DeLmfQkMRUMKTRy55AcJbKhmMkmu3nTIxYEzwXYboo81ajItCeljC8jMbS+QgM/maGDWGBRzfZueG8oGrQgltx3dDvR4EKY6yCkNEhTxwVWM15TAXj7INyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145921; c=relaxed/simple;
	bh=Se2sUw4ElTSkljHetq2EqdIncebZWP75xuvh2RL4jk0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=UsZwoD21kBNCkLShg6RAxjz0+z3uiU71oegacpyNinzqp4uFEuFS8wp1U1ckZoysULx2kTnAPvtuc2SC/jWKddc13L/ZL015Sqt4a096EtVKv9vJIBHtwe3+O/rINxSYgYU6Ty6fOj7nmoUQrEY3ziKDE7MSWV8Iuvs0q/U6ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxEzfhTs; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2dee7d218so1086557eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 12:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737145917; x=1737750717; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QC+kU0J1t/1q4qYoMktSUQFfnuvo9qjWWdVZhic3GBE=;
        b=LxEzfhTsdlK8go7TxcNCGFKJoHJNc76xK0nz1VIIAOgjyF8/kkLOn7wV/rCHxZYi09
         PbdCZ6cu9330d9GgIR2LrjCFoGi4vahtzERYkY/fwnJ+Z7bmYvdoqxdnjMxqARZXiEDH
         iLuoj43cSn7x3X5Fe0zwqvhr1GvqFcyHrDcOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737145917; x=1737750717;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC+kU0J1t/1q4qYoMktSUQFfnuvo9qjWWdVZhic3GBE=;
        b=NoRynbp2vE+c4p6B/SlJFcsnJIHE1luZygKgcOliwv7DlEALGXJPIkj77k7sJ1qqqv
         p745VNp6lZZ1B8Qxon/XbkZGLWjlNNjLbYc2KV2IJ0t/2Xt56Yii4ZLnc1RrAauEV/In
         shjPY+8Fb6bGZlYR2QQ9buAaRU18YhsRPp1loQ8xFYQf91jQceUgI+/P6U//t13+YoTJ
         T/lJuqbzGf0toxapB50VbFu2MZZp5UJHScUrj+iWddkTaoAw/ILy7Uf9zpdsn2wZcRYw
         l3NRiWzPnEU6cI/cuW8KvohvV0QPWC2zwWxw4sB2XJO7pCIHnutBevrSgrzxpP6WixnA
         s1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVkPBXRbMaLR9CwWmZZq9r6Y/83BzoBIZbJDbHSb2OkRbHiJ4mUXQ+uoycQ0gQfsT0YVM02KLPDAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxgI1TJa58E33bsSq/zNh4ZllLeFmmdwEe4ZUD9QR4QiXCStr
	e+4XU29PxwzIDd9LSf6aAReeHVFwI6HNBDlZ3DQvrqwFeUT/QbcuIYUFoDHHwJxA9QqtL3jFQ8T
	5
X-Gm-Gg: ASbGncthGtlSb4O2Bvh5hMEpti3xn0ePm6n3tAHVDpHtcyPfea2pmUNjt9YFoK025eq
	HJNfMNkt8fLOWmH7JTYd9xsRdMZT1CzqrcgBQuNoyrp8xigrZ4l1Lmsx92/frbGkcqgkkUx5KSb
	8t1RtogQfwcfhMfqwFwKXG17ADlIVJADzkoF/xjYDBiHf0rGsW0KQTQbgn1j5YHUPFBSI3Th5Hm
	/YmkwgzUEfVd1M3996mzi/ofaNEL9a1944N6f3H2WTYLhwqRMfMBSuKv678CmAzEU8=
X-Google-Smtp-Source: AGHT+IFxHBcSPK0c3t+XEDyxroI+Q4YYVxVH//jG0eSEXC7x1WHB50F5xM/rTyf2EU9dwi10nliYIg==
X-Received: by 2002:a05:6820:178e:b0:5f8:91b0:6c0f with SMTP id 006d021491bc7-5fa3888abb1mr2867169eaf.6.1737145917246;
        Fri, 17 Jan 2025 12:31:57 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa35f2985asm989793eaf.20.2025.01.17.12.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 12:31:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------dbbjIzbbwjD5tBpoV6yED1xm"
Message-ID: <bb8faeef-d79f-4156-9a4d-5a0dbbcad7a1@linuxfoundation.org>
Date: Fri, 17 Jan 2025 13:31:56 -0700
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
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower second update for Linux 6.14-rc1

This is a multi-part message in MIME format.
--------------dbbjIzbbwjD5tBpoV6yED1xm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower second update for Linux 6.14-rc1.

- Add missing residency header changes in cpuidle.h to SWIG

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8d097444982d7b23a5396169dc9d2923a59b5a79:

   pm: cpupower: Add header changes for cpufreq.h to SWIG bindings (2024-12-27 08:11:51 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.14-rc1-second

for you to fetch changes up to 3d6f25870d172e2b5f27dd829bbe567d5fe8ea31:

   pm: cpupower: Add missing residency header changes in cpuidle.h to SWIG (2025-01-13 16:13:49 -0700)

----------------------------------------------------------------
linux-cpupower-6.14-rc1-second

- Add missing residency header changes in cpuidle.h to SWIG

----------------------------------------------------------------
John B. Wyatt IV (1):
       pm: cpupower: Add missing residency header changes in cpuidle.h to SWIG

  tools/power/cpupower/bindings/python/raw_pylibcpupower.swg | 2 ++
  1 file changed, 2 insertions(+)
----------------------------------------------------------------
--------------dbbjIzbbwjD5tBpoV6yED1xm
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.14-rc1-second.diff"
Content-Disposition: attachment;
 filename="linux-cpupower-6.14-rc1-second.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9yYXdf
cHlsaWJjcHVwb3dlci5zd2cgYi90b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5ncy9weXRo
b24vcmF3X3B5bGliY3B1cG93ZXIuc3dnCmluZGV4IGE4MjI2Yzc5Y2ZlYS4uZDgyYWY2ZmE5
M2MzIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5ncy9weXRob24v
cmF3X3B5bGliY3B1cG93ZXIuc3dnCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRp
bmdzL3B5dGhvbi9yYXdfcHlsaWJjcHVwb3dlci5zd2cKQEAgLTE2Myw2ICsxNjMsOCBAQCBp
bnQgY3B1aWRsZV9zdGF0ZV9kaXNhYmxlKHVuc2lnbmVkIGludCBjcHUsIHVuc2lnbmVkIGlu
dCBpZGxlc3RhdGUsCiAJCQkJICAgdW5zaWduZWQgaW50IGRpc2FibGUpOwogdW5zaWduZWQg
bG9uZyBjcHVpZGxlX3N0YXRlX2xhdGVuY3kodW5zaWduZWQgaW50IGNwdSwKIAkJCQkJCXVu
c2lnbmVkIGludCBpZGxlc3RhdGUpOwordW5zaWduZWQgbG9uZyBjcHVpZGxlX3N0YXRlX3Jl
c2lkZW5jeSh1bnNpZ25lZCBpbnQgY3B1LAorCQkJCQkJdW5zaWduZWQgaW50IGlkbGVzdGF0
ZSk7CiB1bnNpZ25lZCBsb25nIGNwdWlkbGVfc3RhdGVfdXNhZ2UodW5zaWduZWQgaW50IGNw
dSwKIAkJCQkJdW5zaWduZWQgaW50IGlkbGVzdGF0ZSk7CiB1bnNpZ25lZCBsb25nIGxvbmcg
Y3B1aWRsZV9zdGF0ZV90aW1lKHVuc2lnbmVkIGludCBjcHUsCg==

--------------dbbjIzbbwjD5tBpoV6yED1xm--

