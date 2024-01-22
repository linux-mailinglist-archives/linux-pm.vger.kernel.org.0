Return-Path: <linux-pm+bounces-2520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02F837667
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 23:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724711F23204
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B35FBFF;
	Mon, 22 Jan 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AklnglrP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC49101C5
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962962; cv=none; b=QXVSC3LWTYbZQOLfKqjLldU2dae77v+Wly/j+sLcTyLrcH7JZieY/0icRgM0JF6fI58IpvMjRFrS6fwM5zd3JfPbuskACX0ZGsV1Ny2W5PquTrK65rsLBmCxvHq/sDlSu1sqZweK8mDSHrkmyzS3pmejB1r72bj16mZnBYaFwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962962; c=relaxed/simple;
	bh=EDnffVj670tufQZB/leVc1RVQzh2T1+dX5NyDNg79n0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=mwWjQbtZdu6LyW3Q2AmzyI+r4GEM4kFZ+KmXSWZqunviy/v9MU4edTTHggmPFDHFSunzOEDL252RgdyCSQEQi3BID1VGJRvT4axe5mrH9NziTuzXa85VkBlA0mg4mtCK3x6TQzMb+CgvSgf974i4z2obvE0pc7X2kUPM7d6kRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AklnglrP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d722740622so4298125ad.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705962960; x=1706567760; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B2ISsZauDJj8ftWQkSr86ZqHP1A6Vo2AzdjFZZoMXuA=;
        b=AklnglrPWqfQHBcgOlK5MLG/CsMNmkoIpzaJGCICPkCI4Md4VTFWjIugo+TBqbp7iv
         wwYrZrA5XfaEVZB8fwdtLxsF+KiQpik2qmczUCzQBP+do6iMEZOZ/7IovmXjOJV9uwNR
         BOwKcpPnQ07rxzOzihZsbPmlnCmdz9ETb3fWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705962960; x=1706567760;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2ISsZauDJj8ftWQkSr86ZqHP1A6Vo2AzdjFZZoMXuA=;
        b=PRVmh/6FDFZy6W955MBB9HkqwI4VsDGfGqVcB29zf5bQDQD6MlKGpY5VCZgjtCc9+l
         AsvwhtPNu0J16/QKmXqWTxCqdA6L3POabuk5JwBh70Up7cvbLEaaw0aTZhyuXRcJ9uE7
         2fOjmZ/rfyaZoOuQ7moNI936LqegnvF0jC8FDE0UsgE9cqK2ySOXR0+2P5HTeP1t0UJi
         dbo4S5+UifXsgVRd9DbC8EzzvkWKmJO1b1yq5PGqaNp0oCkMcu2fPMfhIidLRxo+nhPs
         prIk/v0EFyOGW4VMudDY0NXwYNkjq8uBCaZuB1sl4EdWG+KqNDdJq4HRwziOzHAftF8h
         V+Qg==
X-Gm-Message-State: AOJu0YxhjkMoTybUvKuibEIafc1SGCN8Ftdmbxxqbb9kNDN3m1UTCK7F
	3Bxh2uMVhYzGXZ8/O/aXOx2c0xeZpsRDTuW05K40ETHhCws137vBFxNPcA4gPKnRxmioUeIaA+E
	x
X-Google-Smtp-Source: AGHT+IFCYlzpFULo7E1kOkoW0q8phE7aavWUJ+QJAEk1nvb2uQMkiV3GQL8ByhKz7IaK8rGm7p2RqQ==
X-Received: by 2002:a17:902:db0b:b0:1d7:3ea0:e6e5 with SMTP id m11-20020a170902db0b00b001d73ea0e6e5mr6958810plx.6.1705962959898;
        Mon, 22 Jan 2024 14:35:59 -0800 (PST)
Received: from [128.240.1.152] (rbi200e.jcresorts.com. [206.170.126.10])
        by smtp.gmail.com with ESMTPSA id le11-20020a170902fb0b00b001d75da799b5sm1420595plb.17.2024.01.22.14.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:35:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------D250Hvu7WV8LvLqLahrtF8ru"
Message-ID: <35a3b410-4486-433b-9996-4dcf6c00612d@linuxfoundation.org>
Date: Mon, 22 Jan 2024 15:35:56 -0700
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
 Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.8-rc2

This is a multi-part message in MIME format.
--------------D250Hvu7WV8LvLqLahrtF8ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower fixes update for Linux 6.8-rc2.

Please include it in your next pull if you already sent your
PR.

This cpupower fixes update for Linux 6.8-rc2 consists of one single fix
to an issue where CFLAGS is passed as a make argument for cpupower, but
bench makefile does not inherit and append to them.

This fixes the problem so the user specified CFLAGS are honored.

diff is attached.

----------------------------------------------------------------

--The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.8-rc2

for you to fetch changes up to 0086ffec768bec6f5d61fc7e406af640eb912a24:

   tools cpupower bench: Override CFLAGS assignments (2024-01-21 16:57:51 -0700)

----------------------------------------------------------------
linux-cpupower-6.8-rc2

This cpupower fixes update for Linux 6.8-rc2 consists of one single fix
to an issue where CFLAGS is passed as a make argument for cpupower, but
bench makefile does not inherit and append to them.

This fixes the problem so the user specified CFLAGS are honored.

----------------------------------------------------------------
Stanley Chan (1):
       tools cpupower bench: Override CFLAGS assignments

  tools/power/cpupower/bench/Makefile | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
--------------------------------------------------------------
--------------D250Hvu7WV8LvLqLahrtF8ru
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.8-rc2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.8-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01ha2VmaWxlIGIvdG9v
bHMvcG93ZXIvY3B1cG93ZXIvYmVuY2gvTWFrZWZpbGUKaW5kZXggZDlkOTkyM2FmODVjLi5h
NGI5MDJmOWUxYzQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01h
a2VmaWxlCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01ha2VmaWxlCkBAIC0x
NSw3ICsxNSw3IEBAIExJQlMgPSAtTC4uLyAtTCQoT1VUUFVUKSAtbG0gLWxjcHVwb3dlcgog
T0JKUyA9ICQoT1VUUFVUKW1haW4ubyAkKE9VVFBVVClwYXJzZS5vICQoT1VUUFVUKXN5c3Rl
bS5vICQoT1VUUFVUKWJlbmNobWFyay5vCiBlbmRpZgogCi1DRkxBR1MgKz0gLURfR05VX1NP
VVJDRSAtSS4uL2xpYiAtRERFRkFVTFRfQ09ORklHX0ZJTEU9XCIkKGNvbmZkaXIpL2NwdWZy
ZXEtYmVuY2guY29uZlwiCitvdmVycmlkZSBDRkxBR1MgKz0gLURfR05VX1NPVVJDRSAtSS4u
L2xpYiAtRERFRkFVTFRfQ09ORklHX0ZJTEU9XCIkKGNvbmZkaXIpL2NwdWZyZXEtYmVuY2gu
Y29uZlwiCiAKICQoT1VUUFVUKSUubyA6ICUuYwogCSQoRUNITykgIiAgQ0MgICAgICAiICRA
Cg==

--------------D250Hvu7WV8LvLqLahrtF8ru--

