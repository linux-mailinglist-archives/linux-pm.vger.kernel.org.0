Return-Path: <linux-pm+bounces-9968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6089170A7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18884B27905
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F217D897;
	Tue, 25 Jun 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF+oGYul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8D17D88A;
	Tue, 25 Jun 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341640; cv=none; b=oV0agqFug4CzsTGQNLY+oJTvWhoGpzONmjdSgff+fQXZO+K9+HfpaLdLp2NhQKER+gicb8HDH/menu6gNiHNntyy8oG6dDSrCQYrwvVxdJ+ke2mzalPZCYSdPQx8JhF5FsAWu1TY9fDQLkTtIuL9ioWhruo54dSvS+giCXfw6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341640; c=relaxed/simple;
	bh=JziFewVRnc/o18bHywCWsPfptesYMGm67bLCKHE+ocI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PkFpDv95PCTfnHMCROSWOC4/40nkKOayksPIlyvmKmXbs39FP7y2HLX/b09p2A8dTxNR445RDT1xIaGlVpE8gsz3BlHffH4GUso1Ft3SBvsSelMizqvlToSPTF0YeZoXUHfo97u/anTYcfK+U0hzL77lw0j0hB7QH/cxHiOUg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF+oGYul; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so833081a12.1;
        Tue, 25 Jun 2024 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719341637; x=1719946437; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YDprlTG8geNOTc8IzqxxC6gz6+SyA4zIwEHPlVhbEI=;
        b=EF+oGYulusNUhKt9GZJ8S5sV0tB/6XNo5dxNmXf2UdVZPaj7rBnEmVafgQicUAjjAv
         nXpohanAAm9u7Tg6waRIESyuCYeelHJ61qcr53B0wUtibyDhTanE8u0KhnLHi6Phvcfi
         63fmtDaujXlrTVyuZqbmsmGcOWRNMSHjwQeLNFd57pOgP0Rk6ayogzmYpe3oVn6gQfc6
         BQeIXRmCB+rVcsBYNxVkjEq+sJWQUK5AKtdhCEFHpcgzfw1RurqLhC22Fi5i4d2NzufP
         egNVKmK3+NPZmmVYd1OQPN4dQ/hwTNjh9zTV7/O3vBPtSjshAR73C3Go53ecsc7xq02L
         F/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341637; x=1719946437;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YDprlTG8geNOTc8IzqxxC6gz6+SyA4zIwEHPlVhbEI=;
        b=DOr9XWeeDMusALzXafbRsR5Ez/340W53qj6yS52UKbSmfIgpnPe6UR+h9SyCq9a6/j
         IjQXPZLjWtUvi/z0RT2JvSGsSBBt55cpBJ29o7wlWZ9buv6aUyzTzShdhFXG5ZtzbGP+
         mG2QfpPR96klKy//RHLrL3stBp7QWcdrDcXgKXC06KIqEVeoGL0ZX1terkk5bs0hDhKw
         SDD+dGQK8F3l689Lsepp1bJb9UPD+Fjfya3QGxVoRKphcJObBD+F7AeYjKvrHj3LZ4Li
         lAmLWEjEIeJ0ZANkP8u9mDVs0kTHb0SQZnE5tfvMiQUSj9RSGK/9347Xvc/+1ZEGG7xl
         3OCg==
X-Forwarded-Encrypted: i=1; AJvYcCVSrsmPYYzv/gjsc/B3PcCE+XwXhTVbTDmtaTXWOQ3kifEs+Y7UG+KW8+/DGpaSaMaEH6QL+BqzwtdxVaCdXMj0xiNE+N0leArbKQIX
X-Gm-Message-State: AOJu0Yz1FAdsI1OUYoMbySPzqI8IMVmkmOSKc6sg5+ZcgADKPFJkt+EO
	8G2BRZnD8QRE/czksXjXpYfrvVMZoT1aNWueQ3fInUYnGYRtSWqb5mjHRQ==
X-Google-Smtp-Source: AGHT+IFoOyLCHxYZP8A3wfYekZExcgfevtj17eJD76/UiUFTm5mpSDmOfmUeTquiKZHOfxQIA6xFcA==
X-Received: by 2002:a05:6402:31a5:b0:57d:4a0d:d597 with SMTP id 4fb4d7f45d1cf-57d701f4eb6mr2853650a12.12.1719341637022;
        Tue, 25 Jun 2024 11:53:57 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562ef3sm6201650a12.91.2024.06.25.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:53:56 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Subject: [PATCH 0/2] cpupower: Add 'uninstall' targers for arch-related
 debug subprojects
Date: Tue, 25 Jun 2024 20:53:54 +0200
Message-Id: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEISe2YC/x3MQQqAIBBA0avIrBNUTKirRIToVANioRWBePek5
 Vv8XyBjIswwsgIJH8p0xAbZMXC7jRty8s2ghNLCqJ5b75c7UsyXDYFLrbRBRGcGC605E670/r9
 prvUDPoYtuV8AAAA=
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-kernel@vger.kernel.org, Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

This patch series adds 'uninstall' targets to the makefiles of
'debug/i386' and 'debug/x86_64' architecture-specifics debug subprojects

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Roman Storozhenko (2):
      cpupower: Add 'uninstall' target for 'debug/i386' subproject
      cpupower: Add 'uninstall' target for 'debug/x86_64' subproject

 tools/power/cpupower/debug/i386/Makefile   | 8 +++++++-
 tools/power/cpupower/debug/x86_64/Makefile | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)
---
base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
change-id: 20240625-add_uninstall-14246eeec69a

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


