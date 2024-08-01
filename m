Return-Path: <linux-pm+bounces-11798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FE9446A2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967D7B20A70
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A6130E4A;
	Thu,  1 Aug 2024 08:32:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B61396;
	Thu,  1 Aug 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501130; cv=none; b=ff8yVi7RpY+715nnhGWMDKG4Im8brPIt1TCSfwIGhfb2UhyQMyrI8oeHOq+9JtjsPE4SmnnUjnjPksudyUkrApmFnAmrP/O9JneQmhTMWLbbC929c5IkPYXE/LkmVToZ0q2r5HV4Fq5wlE65fWVUrPQLrb/uSpJiWfh2HycIE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501130; c=relaxed/simple;
	bh=5DF00A86DtqI+j37zPliETfWTcSDdvNGrsV3XzEftek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vcs5KKNmwR93FZh85sNj1tZf5SqAzcjexO0AUNIICFjOn2x1KbgkhMz/L1xQGeKqVZRpz6xtQVlmEDgeNZ0iGZY63rEnJbay0UnDX7k16kNAdPOcwcAC+DfgB/4oxSqvIGXvFj4mt3nYjAI8qxx8v6KVjxytrv94XepWDyHFFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-70ef732ff95so3041909b3a.0;
        Thu, 01 Aug 2024 01:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501127; x=1723105927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEmG0yKT7y9HYsHSRxaV7CvMPdYMbDJpw0moGEyDL4U=;
        b=CBfhA1OplxDJsWLbiZnnCs9rn5xxVeL6DTuoMzzhisEANAAAi/VC00jGuJa/4HdNAl
         ZuVbreJGUlS+U3GxmpRz2U4Uk2C8RL77AJA1WMqQo5kvqdFbvLqIysC1G+pedjR2hGIj
         nKWRzu0COHjrA1t5cy//hQGwxrN51XS+f96VGZuHC2bODh2nDXeTXMHrD4fqVueBOC2p
         xnFNALEPkAEgS/YnwyLdI1VaQSyPtZnbGsNhjZ3bRGSuMLJ+z40dPjLZfF5QGGQokFWp
         WR/mRHj1CdcDFFexfCdtGDg9wM+AAc35I4tWzZhifxsHPsIMhh75YZBjItArlDoHw5dI
         u67Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4aLWaVecGz/joKwRWFenA9vrLI8rJTS4+xRvkYOHTn8V3tNyQrSOJHI30IiqEqTK3OPmsJq74ajFr30ZiZrAcP06EZMmzuX9JwFFZ
X-Gm-Message-State: AOJu0Yyt3naSBWlizOogg4tGJlyDgHkGi1xGzv2PEg0POrxmChNudBzU
	I/o+iymb697Pd1i+ggpLeF0BNq5zQGCHh3WssyoCTgHg3eqhaWfO
X-Google-Smtp-Source: AGHT+IHBCe48b2h5+B4g+krzOInONM8QH6Ul+2os+l0wvsjLTp0P4ISjwjby79GXpBvxJBPvIK4jvw==
X-Received: by 2002:a05:6a20:9155:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c68cf6608dmr2591724637.32.1722501126613;
        Thu, 01 Aug 2024 01:32:06 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fb0fsm133288365ad.7.2024.08.01.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:32:06 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 0/2] Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Thu,  1 Aug 2024 16:31:54 +0800
Message-Id: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

v3: Changed code style as suggested by Rafael J. Wysockid, thanks!

v2: Adopted Christophe's suggestions as follows:
- Fixed some formatting
- Fixed logic errors in mem_sleep_show, pm_test_show, state_show functions
Thanks!

Xueqin Luo (2):
  PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show"
    functions
  PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions

 kernel/power/hibernate.c | 22 +++++------
 kernel/power/main.c      | 82 ++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 48 deletions(-)

-- 
2.25.1


