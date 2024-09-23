Return-Path: <linux-pm+bounces-14594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0C97F1A0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B830F281804
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2251A0B1E;
	Mon, 23 Sep 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0rpA66u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5017BD6
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122747; cv=none; b=K3VfaXANtabTQAf4odRqi0bEUGbBz3xT+3w/Rlbd3ltUZCz84ERa7Atn3biNVTaHY652zFbPK9lizRRKEkkkZhSdQ7AoFRTWqVcgVtMwBzYvpkHz/u79p/PXiegUx2oaxJ2opONb8uPi1VLvV299YE1/3T9v8rEt+kY2uaT6XWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122747; c=relaxed/simple;
	bh=/eSZTXDrWxp8WU3PcAncNTF6Ub7hlLotegTJAsNx5NU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=r6CkrBCreDALRBqqb0o3ZVXJyzfvDPIb2maXznTQb1/z43D3R9LjHLaLOnTSRq+0h1t9unOYR7q95TOJY4rbyXABMTcddxxsRkfmAYpvQcMbhmJNQpj/D3oAM7uyhohsb04EokBLRvIGpmlMki6fvecWdF7FzmJe5SyicPsngRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0rpA66u; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a109bc459so206424739f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727122744; x=1727727544; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DWGul8N+EZy00peKKJT500hgW+GLPhHSqZNfkf+uAl8=;
        b=h0rpA66usVBN2vYmrxB77XTaXVwp84kx3DW0yu8BAu702bS+QndSXkaRZo4aKSK/z3
         0ajTUNjKUilzBhLIzJDbVMvh/65AEq5Bwb+BAhcp3NmNvIhzrzAkhWMohnhOPi4QBQkq
         nMi74n3TTdaOSqSmtvxy94ak82G9mrFnVzTjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122744; x=1727727544;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWGul8N+EZy00peKKJT500hgW+GLPhHSqZNfkf+uAl8=;
        b=GSmtT+pBAIO5A1L0+Po0LwVuoE1oohFc8uuhEvyfXXy47bRFRvwuSUGuF3PaBcpkqq
         CWHZYqJ08B2hWgvrDHuNWxeyw3kqmK81W0GAiTzyDwLvuQkvK4DbsHefjTi5Igjhg5OZ
         Lird0bQf8qgEk6QM48UPoFeaa9YjUW8G1F7b2mdJxVJ7/ABKJYPqV0Qir4WNlQotjPFk
         4qHp9itgcrUKrhP8zkMHfRv+XKFYp4DpvOiNpkQ4PhsxIX8SzMbuxtRjUctCwEwPNPi/
         Gv+oa7QSMhuhq+3x2dsKXHkuTvZOVkt5KDSDx4DSTsNLu5/aPY3t83rYINuXZCajWFDH
         1+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUMEEXz1I8hZBU2aSoDi+vAsTGIvYx5hT+IWHwiMG7Aqt0lEH51S/W5Ls+ZqMapm7sZYcUELe07Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLs3t/ahznP50DXWpw52xFoJgrZMyLgnnOqb12WPHZTIusDfO
	YeW8hIy+GTwNV/b7RQxAs2cHrOVGNE/Uxt4na0BLf5kLb4ns8my4ZPo30MuzurY=
X-Google-Smtp-Source: AGHT+IHAp0QTMm7T/66VhAN9fo2hkuaNPKT29AKjYiwTUac4Fpmd+C6TbAgSOlaKv5WqEeG+sLXybg==
X-Received: by 2002:a05:6e02:156c:b0:3a0:9030:e70b with SMTP id e9e14a558f8ab-3a1a2fec392mr9011545ab.4.1727122743800;
        Mon, 23 Sep 2024 13:19:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f2f6e2asm24140173.154.2024.09.23.13.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 13:19:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1JnQzwMA3Ss9TTIuQFjlnei6"
Message-ID: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
Date: Mon, 23 Sep 2024 14:19:01 -0600
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1

This is a multi-part message in MIME format.
--------------1JnQzwMA3Ss9TTIuQFjlnei6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower fixes update for Linux 6.12-rc1.
Please send this up to Linus if at all possible before the merge
window closes.

This cpupower fixes update consists fix to raw_pylibcpupower.i being
removed by "make mrproper". "*.i", "*.o" files are generated during
kernel compile and removed when the repo is cleaned by mrproper.

The file is renamed to use .swg extension instead to avoid the problem.
The second patch removes references to raw_pylibcpupower.i from .gitignore.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 80e67f1802d0fc21543216557a68320c71d7dbe1:

   pm:cpupower: Add error warning when SWIG is not installed (2024-09-06 10:58:35 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.12-rc1-fixes

for you to fetch changes up to 6c56fb4434f59df9c777eded5f77cc812882cef3:

   pm: cpupower: Clean up bindings gitignore (2024-09-23 09:06:03 -0600)

----------------------------------------------------------------
linux-cpupower-6.12-rc1-fixes

This cpupower fixes update consists fix to raw_pylibcpupower.i being
removed by "make mrproper". "*.i", "*.o" files are generated during
kernel compile and removed when the repo is cleaned by mrproper.

The file is renamed to use .swg extension instead to avoid the problem.
The second patch removes references to raw_pylibcpupower.i from .gitignore.

----------------------------------------------------------------
John B. Wyatt IV (1):
       pm: cpupower: Clean up bindings gitignore

Min-Hua Chen (1):
       pm: cpupower: rename raw_pylibcpupower.i

  tools/power/cpupower/bindings/python/.gitignore                       | 3 +--
  tools/power/cpupower/bindings/python/Makefile                         | 4 ++--
  .../bindings/python/{raw_pylibcpupower.i => raw_pylibcpupower.swg}    | 0
  3 files changed, 3 insertions(+), 4 deletions(-)
  rename tools/power/cpupower/bindings/python/{raw_pylibcpupower.i => raw_pylibcpupower.swg} (100%)
----------------------------------------------------------------
--------------1JnQzwMA3Ss9TTIuQFjlnei6
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.12-rc1-fixes.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.12-rc1-fixes.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi8uZ2l0
aWdub3JlIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uLy5naXRpZ25v
cmUKaW5kZXggNWM5YTFmMDIxMmRkLi41MWNiYjg3OTljNDQgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi8uZ2l0aWdub3JlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi8uZ2l0aWdub3JlCkBAIC0xLDggKzEs
NyBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CiBfX3B5Y2Fj
aGVfXy8KIHJhd19weWxpYmNwdXBvd2VyX3dyYXAuYwogKi5vCiAqLnNvCiAqLnB5CiAhdGVz
dF9yYXdfcHlsaWJjcHVwb3dlci5weQotIyBnaXQga2VlcHMgaWdub3JpbmcgdGhpcyBmaWxl
LCB1c2UgZ2l0IGFkZCAtZiByYXdfbGliY3B1cG93ZXIuaQotIXJhd19weWxpYmNwdXBvd2Vy
LmkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9N
YWtlZmlsZSBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmls
ZQppbmRleCBkYzA5YzViNjZlYWQuLmUxZWJiMWQ2MGNkNCAxMDA2NDQKLS0tIGEvdG9vbHMv
cG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpAQCAtMjAsMTMgKzIwLDEz
IEBAIF9yYXdfcHlsaWJjcHVwb3dlci5zbzogcmF3X3B5bGliY3B1cG93ZXJfd3JhcC5vCiBy
YXdfcHlsaWJjcHVwb3dlcl93cmFwLm86IHJhd19weWxpYmNwdXBvd2VyX3dyYXAuYwogCSQo
Q0MpIC1mUElDIC1jIHJhd19weWxpYmNwdXBvd2VyX3dyYXAuYyAkKFBZX0lOQ0xVREUpCiAK
LXJhd19weWxpYmNwdXBvd2VyX3dyYXAuYzogcmF3X3B5bGliY3B1cG93ZXIuaQorcmF3X3B5
bGliY3B1cG93ZXJfd3JhcC5jOiByYXdfcHlsaWJjcHVwb3dlci5zd2cKIGlmZXEgKCQoSEFW
RV9TV0lHKSwwKQogCSQoZXJyb3IgInN3aWcgd2FzIG5vdCBmb3VuZC4gTWFrZSBzdXJlIHlv
dSBoYXZlIGl0IGluc3RhbGxlZCBhbmQgaW4gdGhlIFBBVEggdG8gZ2VuZXJhdGUgdGhlIGJp
bmRpbmdzLiIpCiBlbHNlIGlmZXEgKCQoSEFWRV9QWUNPTkZJRyksMCkKIAkkKGVycm9yICJw
eXRob24tY29uZmlnIHdhcyBub3QgZm91bmQuIE1ha2Ugc3VyZSB5b3UgaGF2ZSBpdCBpbnN0
YWxsZWQgYW5kIGluIHRoZSBQQVRIIHRvIGdlbmVyYXRlIHRoZSBiaW5kaW5ncy4iKQogZW5k
aWYKLQlzd2lnIC1weXRob24gcmF3X3B5bGliY3B1cG93ZXIuaQorCXN3aWcgLXB5dGhvbiBy
YXdfcHlsaWJjcHVwb3dlci5zd2cKIAogIyBXaWxsIG9ubHkgY2xlYW4gdGhlIGJpbmRpbmdz
IGZvbGRlcjsgd2lsbCBub3QgY2xlYW4gdGhlIGFjdHVhbCBjcHVwb3dlciBmb2xkZXIKIGNs
ZWFuOgpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9u
L3Jhd19weWxpYmNwdXBvd2VyLmkgYi90b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5ncy9w
eXRob24vcmF3X3B5bGliY3B1cG93ZXIuc3dnCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5h
bWUgZnJvbSB0b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5ncy9weXRob24vcmF3X3B5bGli
Y3B1cG93ZXIuaQpyZW5hbWUgdG8gdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0
aG9uL3Jhd19weWxpYmNwdXBvd2VyLnN3Zwo=

--------------1JnQzwMA3Ss9TTIuQFjlnei6--

