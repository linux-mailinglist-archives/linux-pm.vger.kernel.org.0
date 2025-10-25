Return-Path: <linux-pm+bounces-36820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71CC08B26
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 07:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6DA1B2354F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 05:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF29246BC7;
	Sat, 25 Oct 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIVsuAuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B1221FCC
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761368907; cv=none; b=q9Y+r641JwnEAjA2L/nvCaZvC+Jpc4Pv7Igcpxbtj2tFeirhLRHsGLHLB2qaFp/Gw/P0JoTlyEIdS281QDtT15wWtwKUF9cdyK4ZtzOub5yQkf3mJC7wrAgnWBI4NPshz2uBrsF0gKRZGZtTcNngGZG8lZqIgPd3AQzm97KTeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761368907; c=relaxed/simple;
	bh=9sj97WqdM5/emB5ZezWNh1O1KphVBD/fj3cCp/SxgbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SItKnhCGwWwhF2xhDBOoPUBh8d9m5PLrwM5/lCLeR8dlj08v0r7sM8y4TgvagIuUtXY0+euEUgvL6VG+BrzyXLoufwiiLvkSpMPVFvZPPL2qkLJTkaaHW4c6s9udW4s61G0t4RM68Cd06xifcNCVDa2GA3jQhX3iqsk/JLJ5+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIVsuAuX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d78062424so326129466b.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761368904; x=1761973704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wyvOizFeamc5J5XjDLMeHypdnVLhvC3mQKcXmMz7GA=;
        b=BIVsuAuXHP/62HK33Z2I3MG7kIcUmr2V+K2OsBUChOl5LizA5zkWZzud2TDCCuODFS
         Zt6e7NHH898J78AJPxsvV18Uaz426hgkG0EtVn/d8MJYTNdX5n5NKEnb+J5OzuRCkBcI
         zriJkJTXnGD97x3KtvDIEcu/RYsnxBk4etbfCgAKajUEcb+raXdt9HdHynggM7qH1AGI
         h3Nlo1qvm81QUJsqKYFdC2U3U2kE12KyYKsQCCA7RMFc4wg/64uiA5h8NhX7O9goZgzs
         J8bpDylP1tXW8lXAkmikBwhcZ73vzmXDpB8xpokW0hYyuR02CHtiuLOB8vg7Rp5ikdOt
         +50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761368904; x=1761973704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wyvOizFeamc5J5XjDLMeHypdnVLhvC3mQKcXmMz7GA=;
        b=O/VVj+TbdMkA2lg4lxCWOVaZAXBIU+2D9CDU5ar3SLp6uHLYby0f3fhYMRBwlNe+i1
         t9V6gRUtrTnmUHq6UvcXD7EoepfTXv+kw1zmcjcErfMntW9jHPgX2sj8RV8kXJ8SijX7
         YVJZyT6Z2b7UCwRl3CxaudWgSZxNVtzJ0frcqrn5FtRgajvbFDDj2MoYmrKpg0H+giW+
         toOaTnm2VgQM44EgyzEQFDXvOf0bgzQv24mMC5mZ+boYbbuZHrhqrH4T0B/ea7R4XJwC
         2GROc8Cx1AxLavLTwiwlUj84DO5hY5SJeBZzGhwx8jrSmT6Ii2G4WFwZqUAcBWtaxCji
         WWRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKzPYWnK34tbb6DAXncMYc08RcvQKFfkMbTGq03Rk8AXs0OCvDhhlpWm4NQ6LFGYgtUui3nCOW2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Gbf44nMl6HCRLQbj2zPHVAtSIdxC0Vehb+iK44lhWQ83ns6B
	Xwgiumai2PZe6oNwMDKaDGC/tjcWDZBEpNOjm0hTpurkpgd6mLo+cj6vU5Hu67/P
X-Gm-Gg: ASbGncteRKQ7UL+hHyP11C95u99OFZec43jpuMO3S7929P1QFTu2FZGOz2Nx+HIOdgR
	PgcYyYET58XDIkaHOvuAblGiOYIGcxnG1slXfJHbhQE0jfpxOV74HplKhRy0mJbS7q/Hjl6A5rl
	pksitqa61hjrNMAulEOuzRHCPlykXUPYP9oytHjE488cDJOwXKuTR4TYVyEi6EDponW5xwUtLe1
	NCZoIIhit6ZAFipQQPJ4Ty62nYxYW/j8uWEBRYAFz41hmhQD2z3I35F8slHxD8XICScNJA/5yXG
	NLJdVVyBHQtNgjz0/3c91LCp7nIQ6bUkteFOgbHHOpxnVkkyjaZh+uRtCNz0M4mIJ/VDGUUuRx3
	YpuChNV9IFZn8eHpJpbMBsGfxHBZfghxhkwfJQLdAvl7PUtLn+CvPMhnz5rr+jliOqELq7pkqHR
	jx
X-Google-Smtp-Source: AGHT+IGED30i/rKdoHj02khe2qIDFQObvhJ3a36vUQHMrmoCrPRoG3pb3BVWX1cfcmX/8CsErsWK4g==
X-Received: by 2002:a17:907:9615:b0:b6d:7859:61eb with SMTP id a640c23a62f3a-b6d7859620fmr371817166b.29.1761368903851;
        Fri, 24 Oct 2025 22:08:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853077e8sm102873866b.14.2025.10.24.22.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:08:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: rafael@kernel.org
Cc: gregkh@linuxfoundation.org,
	guoqing.zhang@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	todd.e.brandt@linux.intel.com,
	torvalds@linuxfoundation.org,
	"regressions" <regressions@lists.linux.dev>
Subject: [REGRESSION][BISECTED] Hibernation: WARNING at kernel/power/main.c:48 pm_restrict_gfp_mask (was: "[PATCH v1] PM: hibernate: Restrict GFP mask in hibernation_snapshot()")
Date: Sat, 25 Oct 2025 08:08:12 +0300
Message-ID: <20251025050812.421905-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5924662.DvuYhMxLoT@rafael.j.wysocki>
References: <5924662.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Rafael J. Wysocki" <rafael@kernel.org>:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
> sequence") incorrectly removed a pm_restrict_gfp_mask() call from
> hibernation_snapshot(), so memory allocations involving swap are not
> prevented from being carried out in this code path any more which may
> lead to serious breakage.

#regzbot introduced: 449c9c02537a146ac97ef962327a221e21c9cab3

This commit introduced regression: now I see WARNING every time when
I hibernate. The bug reproduces both on real hardware and in Qemu.

Here is script I used to reproduce this bug in Qemu:
https://zerobin.net/?aadae7117a208c0a#Xh8aI5+u3pyk+vKwET7j+yXolLeoSLe/AedcvnNeCLs=

Here is resulting log (dmesg) on current master (43e9ad0c55a3):
https://zerobin.net/?471d17d0632e7f85#uYne0yUu+rP4KnDbOFFqtCrcDIi6UpQz2uIQw85lcdQ=

Here is the most interesting part:

[    1.735001] PM: Image saving progress:  90%
[    1.746611] PM: Image saving progress: 100%
[    1.747208] PM: Image saving done
[    1.747403] PM: hibernation: Wrote 30164 kbytes in 0.13 seconds (232.03 MB/s)
[    1.747837] PM: Image size after compression: 8908 kbytes
[    1.748190] PM: S|
[    1.750351] ------------[ cut here ]------------
[    1.750627] WARNING: CPU: 0 PID: 1 at kernel/power/main.c:48 pm_restrict_gfp_mask+0x3b/0x40

On real hardware exactly same thing happens (i. e. WARNING at kernel/power/main.c:48 pm_restrict_gfp_mask).

-- 
Askar Safin

