Return-Path: <linux-pm+bounces-32755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F59B2E982
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 02:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27685C6842
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698F1D63E6;
	Thu, 21 Aug 2025 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+XLA6eq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EF78F5D
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736972; cv=none; b=JxmSQ84bxURE0TzBALJmi4BbqJrvd3Se3HmDLNfRiGozvmlVBwbkBLPTyM3Yn0n8atWuEUoWhST9P+EQzian1d6JTzW58qDxkLZn1WCzp6iHdb/Sgz/8eqDShOHTn3bfnLd7QPK++0uC85N98scnxy7wJGFU5oTNj1L5xhf+Ap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736972; c=relaxed/simple;
	bh=pgVl+ewjqrSKKmMdjybS8QYBtZt9k61QLGRAt6yECcE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PzDGow8b+r+uJJsoK72rKTEvSKuY41cdBE9GiRFtKdWUQDL3UryZY3VkpyzlREQTcXUQbazpInnLLy3wbJcH9EmFD0ycD6PDKxRdSY6ejSr/wrvx6gc4cdXblhdi/S0rpuAMng3gBKm7XNNHAFKYkxRBNvt4UOp2ss51KJ1ngLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+XLA6eq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso9289865ad.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755736970; x=1756341770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHeWPYDcK+WovsGDfb6zMC/40Q6oxqnQuS8R8OCxR3g=;
        b=m+XLA6eqP5eubjoYP4rzrMJNNLsOTcDYALkO5XkVh5uvAA/nWdKvQ6RC/QLLg6Fp4a
         c0FQsD4K5EdsfHwrJYxCfPrdL8sy5TedXdtIs6WXzaJthOdZ4Y2KKGi5gCAXkNup2V3h
         bZDXo0h7V5TIfxz+gm1uiPS4YZwhqihKury/cXYUOsSflJkMi5yMBZ/OlRJxD8Hnx78V
         ZKH7XAF9Mbuu2XmwhhW2AMD7oplDW0Rk0Nriag4aKYjjS5oRJNNsOSng8xCccuB/4GHj
         rwNlAWD9ymkVfT7pyB2fMA0gc1ye1/DZZigzbHccClmWmzwJQSUltwror3B0SwwVmNbQ
         Gqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736970; x=1756341770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHeWPYDcK+WovsGDfb6zMC/40Q6oxqnQuS8R8OCxR3g=;
        b=cSow0z+JjREeB2dRASzsNLFUPHuIPqn1dalULOKzKkMt9+BwLwqmsB4TI8Sai3rvHl
         XzX2fjqJRdXgiAZW3aSDa2eKU+anYkcKu2nAdlxspEP+qFf0gQsYiJeHOYvotRkOgZWp
         +GcnP841tjYlpCbcoH0o726+Ify9DwoAdto5+NfQ7PrxrDkZ6A542OVPzrlJjDLVvKrj
         vfhGYYpKo0BAlWllJTnIJaS3pO3lp9quf4PEpjNLxmHd60RD/kgHiZRk8ulzGrEuFdot
         NXYH5kNSzQqDR59eRopERF4oYk6y30ND4hjdnhRl+3BKg57iP4wb2bJZiH4gkUj+ciEr
         rX2w==
X-Forwarded-Encrypted: i=1; AJvYcCXl+NHwsxA2BCZEAAEOJ3qdBBAR3B95MITkuENsjNfrxB6JvgzsJV7XpP0jcnPPGFngSgOopEwycw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQOAPzl2eBJQivVf/ge5Ld5Fh1xTgMC4yPtNAFBXzdQKi9efz
	Q/tvmWJB/xUW0q5wmjyTJ3NUe+OszAVbFBqe3YVdmS1B1lqLE2sRrD6QMwAMcbtQPoPzc6Nr5Ca
	h1rDIYTS+VX3/mA==
X-Google-Smtp-Source: AGHT+IGHRM1ZQHssQ6o5RYh5ciBdPVLn+jmpDTzt85I0/XP6GWd6AavhLaSZiYC3UfXD0w5pnzvv253djCfrDw==
X-Received: from pjbpt16.prod.google.com ([2002:a17:90b:3d10:b0:31f:2a78:943])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c8:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245feddd902mr8683325ad.47.1755736970047;
 Wed, 20 Aug 2025 17:42:50 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:42:32 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821004237.2712312-1-wusamuel@google.com>
Subject: [PATCH v3 0/3] PM: Support aborting suspend during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds functionality to handle a wakeup event in the filesystem
sync phase of suspend. This topic was first discussed by Saravana Kannan at
LPC 2024 [1], where the general consensus was to allow filesystem sync on a
parallel thread.

1/3: Moves pm_wakeup_clear() to be with similar functions that do the
     prerequisite bookkeeping prior to suspend_prepare(), making the intent
     of the function clearer. Additionally, this sets up patch2 in the
     series, which requires pm_wakeup_clear() to be called before abort
     functionality during suspend can be enabled.
2/3: Add support for abort during filesystem sync phase of suspend. This
     requires detecting a wakeup event or a filesystem sync finishing,
     whichever comes first.
3/3: Adding onto abort during filesystem sync, handle cases of back-to-back
     suspends and their respective filesystem syncs. Extra care is needed
     to ensure filesystem syncs happen serially while still honoring
     wakeup events that lead to early aborts.

[1]: https://lpc.events/event/18/contributions/1845/

Changes in v3:
- Split v2 patch into 3 patches
- Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condition
- Updated documentation and comments within kernel/power/suspend.c
- v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamuel@google.com/

Changes in v2:
- Added documentation for suspend_abort_fs_sync()
- Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static
- v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamuel@google.com

Samuel Wu (3):
  PM: Make pm_wakeup_clear() call more clear
  PM: Support aborting suspend during filesystem sync
  PM: Support abort during fs_sync of back-to-back suspends

 drivers/base/power/wakeup.c |  8 ++++
 include/linux/suspend.h     |  3 ++
 kernel/power/process.c      |  1 -
 kernel/power/suspend.c      | 75 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 2 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


