Return-Path: <linux-pm+bounces-29941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8965AF0600
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F21C20B7B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144462701C8;
	Tue,  1 Jul 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9d+PrmE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B726A0B3;
	Tue,  1 Jul 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407019; cv=none; b=H163zjTGNuCxh/wIBEjQN+h9rWa6Ox+ubIobKqf/tRxLY0wkPRzsdAwsulIh1aP0+cxuOfRWe+TIMetaZlagHYtLOyLUZ8M39WOkgsFec60nApDrurU0kTmqnCmczyQfr6AHHPDpq1UhgsvCoIBHSdEdKdY8COUiiOUz4NxJGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407019; c=relaxed/simple;
	bh=C8lLoCZLb9NOz2fXqycY7xy1dT01ZnrX/ae5CzPdLs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7GYF2VmGdeCnXNOez3XFfbln0lmPF7drn1a04CmY1ApDVSt364Ze3jKOu4ieQBI5KzgX8Ol6tBjdRE02QSGfVRIzlgFWUvyef+odIRe8sx+iPCY/lUpBHxu140utnvOFm/XOWjW1PSreVGixqRQ259FLMY4bTPaeiaj3WANR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9d+PrmE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso36239395e9.0;
        Tue, 01 Jul 2025 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407016; x=1752011816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IP9jbTrnB+dBCbXbGUHJtoAAOQr6sB5g1NEP/C6nMg=;
        b=G9d+PrmEEZ1KhqrKCUuRSxWZWb9iWxB6elFw8y4OraQsRb93jC2u02h/4GVhxCW7Fw
         NQHJide8+zlOEZU02tlxLmjNMKM81GAVUTeb6k6YprF2xb4pQ65gZ16V3dOOaIz0ZQyv
         sSAWTyd1kQEatsgg3cem4eE3O4GKb6YReaUmtAgDM2wJzYR8qRt9nzYP9kfyYeLgA9D/
         WFPj60s8+ktPxLIybgB0MqRiPeqp+LxTtroZkDY9uYL6+1gJtZjE4WZqPXuUGSxtyGOj
         aCUYGibRPqVi8FOiZEQWhtE1nJcHi6HQoCEoy+iLKhKXkvKMzC00xeHC4DWA67jkprPL
         Xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407016; x=1752011816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IP9jbTrnB+dBCbXbGUHJtoAAOQr6sB5g1NEP/C6nMg=;
        b=f7t3Vczhq+PUwWIj57T2gT5SpgoBC9oAzv0qwr5H58ulmK/gLC4AJm/xdL7dYmCEeq
         DvTHYFXtpSaSjH82pqdCjqS5k82xt9R/C0DXc9jkgdXAeDZGHl0zwukjoNtGj24QLF5A
         hcTGMrXqtXD9KyAMJm5rpv3GLjQ3gi0O4MK7o346JUywYxbbjXoObDoXxcnoLpIi3VJH
         7SrxSlC3SeNIr98skpzKvfelAuTZXfOmldksKCR0cC7Si8dK3MlbOu4qPzuIGZINETZt
         w7ih104S3J488zj8kZ52kmp89lKg5SV6+4J1aqB21mxALi9wul9rybM7t4KrBVzQgghq
         QOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWve8Pa5Y8TLZfNyBLFb6VvNvE2vsPQEIrtQruAUU1p2wmLU3SIZZ6XnweOe+saHD+6WzeC5QeOFnjhxic=@vger.kernel.org, AJvYcCX2vsNjiy9F2htA5xuPYjgvOWhBKBCl0lzxxIDawj+1VukwPPz8WpiU0pE7IQTg8dL5gx/77nqmEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjBU3Ytg1ms5aXFNPhfLv1NDfCpW17Ee/zEhSBhmxjiXeOkTM
	Jv0NSfAUhcofcNfBZOJ2XQUGoBO7vL5j1Cdtre7sX0Z87mp0VPuO+DctrR3chV3O
X-Gm-Gg: ASbGnctwfLJWEV02a5fdku2U/amIOHRYyk45Imy9fN7swSEjrtx6msJNlRGhB3OZzBW
	YeDCaBa5049s11hohQHwXCzInjk2tVv4HTavPw64tsdkmNqoathqr1sOQ87SEGO214V13fZ/+is
	bXTiSBsz4q3DmvefwhG1iuSzKmj6Tzry6FONcW3lXSqLjHkUCBbhy8UoVQWnC0marnNdsxQPhwk
	jB2SFZ2t1X4dUHgjVATATQjproQWuiqna31nIR0ldksGHR4cE5H2y4a0GytBJh3S0bvkIJzZvXB
	9Nfwif/dN42KXd/qN7tYLLTv009V+W7353ESNXD8HOjUhkyWlWa0MEbradWd/6PaTt8eF1u2R7x
	xo9SkWPFo4JSmNiun2/6Xobta7J0=
X-Google-Smtp-Source: AGHT+IEOU+/JUSJG95q1//jUTmWAlSr4ZaIg0YTWQA915OZ317T1rwQ/G2wcyl0DQXBSW5tctXA6gA==
X-Received: by 2002:a05:600c:3d95:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-454a36d7b08mr6213995e9.7.1751407015496;
        Tue, 01 Jul 2025 14:56:55 -0700 (PDT)
Received: from localhost.localdomain (89-139-4-59.bb.netvision.net.il. [89.139.4.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe592sm173751675e9.21.2025.07.01.14.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:56:55 -0700 (PDT)
From: Sivan Zohar-Kotzer <sivany32@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: elazarl@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] Linux 6.16-rc2
Date: Wed,  2 Jul 2025 00:56:48 +0300
Message-ID: <20250701215648.95912-1-sivany32@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 69c534982415..ba0827a1fccd 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 16
 SUBLEVEL = 0
-EXTRAVERSION = -rc1
+EXTRAVERSION = -rc2
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.45.2


