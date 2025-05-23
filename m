Return-Path: <linux-pm+bounces-27593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E0AC26D4
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B40188309B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979E293730;
	Fri, 23 May 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFIEm10p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252E101DE;
	Fri, 23 May 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015503; cv=none; b=VhFWYy3xhL8SKuwQ6o4E86OJRa5vjGKVzstDe6GI+bFGivuGJwpL+WtWy7iRyolkjVYLmMGfn2xzp5oVvAqv6ycRuk2IYNJ/bxxYgczMZ+H7MS5qmwqrx5Eua4e9y9ZV/ade7L7ByQJbhVddcrUc9PrMkZNA+y82Or4G8KoQ1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015503; c=relaxed/simple;
	bh=+hLM+RFXD0+ODT1OpyAmc8syb4hj5BqPmZxSo7QJltY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l7MjVOifiBTIjKZEJRnylty8iWrccnuUtP7xGQsZKAJa2ThMGc7+yQUirtgHP1duhoMSWPGbxQ+AfxZkSEBNIkDSG5vCWs9bWrkypvDMQG53paWzb/vPk3SDDmW1aijjZLKm1TY5wmm3sBeSmS04LxIudrRlFZAQfrhmP27CoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFIEm10p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54583C4CEEF;
	Fri, 23 May 2025 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748015501;
	bh=+hLM+RFXD0+ODT1OpyAmc8syb4hj5BqPmZxSo7QJltY=;
	h=From:Date:Subject:To:Cc:From;
	b=tFIEm10pAFYcRSiJKOZrMOk896Rhdtw7ntSnKAnYto2j2x3r9U6841M32lop7y5z4
	 Uz7Z/BgHUf1GNRxFeNi+yXLTPnSybCFB4Yf3NTCJn+5vNiq1DNuOqXdvZDlNy0EfN2
	 1sVoPu/C1IaOKI9m97pDuSGKuanSbXiOqXuBKVrMvCGq/s6d0kMYHRpjKiQDTXDGGA
	 djX38f2QR2WwrfQBMctOClqrByZTbUjcmBRhD7f62pWHf3LD03y/lHg80qVLWOEtu3
	 pFUxJkxX+y4ToZ7ctjFg6HRzLf7dMPhkZeF3WmQ7Yk3dfIRFMRcLGpf3zCP4mIh5HD
	 KT+43Gut4jg7A==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b0626c785so8155421a34.2;
        Fri, 23 May 2025 08:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNRG0PZKDe/2/Td2pMmoOO3B6W9Q+H0U+JiOA8Qi1bu6HY5QiD7VyoDbkUiMURTQZ4cwLaw0TjwPLbtxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQAf+cpxqvkCDS49xE2+lM8dx8cHYE2QlobZjRIQN73Zv+tVO
	3oXGwrh2zg7B/wEK3JT+n0w0KQzQCo/anZ86Q0IbQImij9c/EkxRuMBgQcKFhuLALd32qkNyMtA
	VAcIcOhqXrhFuFJh/gTGy+qqutiBNyLQ=
X-Google-Smtp-Source: AGHT+IGLt476qkowxMyWt2tq0lbb99XwROPsIwy6JDILR05xlhvclEc9gzoSgsfb4+hJqFKmUyXErL7RLgipbQYTMPg=
X-Received: by 2002:a05:6830:3901:b0:72b:872f:efc8 with SMTP id
 46e09a7af769-7354d5cc6f2mr2729488a34.24.1748015500646; Fri, 23 May 2025
 08:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:51:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7MgC5SheA+8A-QiznuCyT9cRG6spXZS4d10OVGPmgfw@mail.gmail.com>
X-Gm-Features: AX0GCFvBjWk22AVF4jq3mRVlw4BPZImGTVnbvE9YGggn3z5gA78MtdS2-GzUonI
Message-ID: <CAJZ5v0j7MgC5SheA+8A-QiznuCyT9cRG6spXZS4d10OVGPmgfw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for final v6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.15-rc8

with top-most commit cf948c8e274e8b406e846cdf6cc48fe47f98cf57

 thermal: intel: x86_pkg_temp_thermal: Fix bogus trip temperature

on top of commit a5806cd506af5a7c19bcd596e4708b5c464bfd21

 Linux 6.15-rc7

to receive a thermal control fix for final 6.15.

This fixes a coding mistake in the x86_pkg_temp_thermal Intel thermal
driver that was introduced by an incorrect conflict resolution during
a merge (Zhang Rui).

Thanks!


---------------

Zhang Rui (1):
      thermal: intel: x86_pkg_temp_thermal: Fix bogus trip temperature

---------------

 drivers/thermal/intel/x86_pkg_temp_thermal.c | 1 +
 1 file changed, 1 insertion(+)

