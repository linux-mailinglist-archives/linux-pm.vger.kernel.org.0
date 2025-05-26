Return-Path: <linux-pm+bounces-27635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C7AC3A01
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 08:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187DD1894117
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F81DE4DB;
	Mon, 26 May 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XId/7r9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0B1DDC15
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241412; cv=none; b=EldmPNVQR1YlZhWW9U5ow7Jw4DxwpVz8/g3+Ez9il/en+dy1kyMr9Uf6oOtfVTCWkqr8590bS9N8EI0CfcQw1kLWfaQujzc7couMwuopoWwLed5tfjK2OUfwI5jdaf0ErWB1to70azQ78ITQBVI+rTKmTIOIuddn57forMw5eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241412; c=relaxed/simple;
	bh=X2OOs6s10Gs5ErOKkMQqN3mvJJDpDGuaTwSXr9QX100=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R1thRTyuzK3IX+y96BWZHAs4VsAn3MIBGhEkdVFyxR0Mc2b6/ivE7ZDSxpjuCoDhppmtLkWzEtewNOdB7m6QqViasL/HgnFR5AOse4NvkEaHsu0oYtRyLPSRzDyYDE7/oF3g59QCfHGJuFbZrQh/whR5roNrotvuQ1um9UhDJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XId/7r9E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234549aed3cso6104955ad.1
        for <linux-pm@vger.kernel.org>; Sun, 25 May 2025 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748241410; x=1748846210; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZPltjG5SvwVjWya2TV7fEz5DnOlg2tbFAzmA5YnBrg=;
        b=XId/7r9EjEU0l0EFU+4a7fpTS5h+7OZK/MozFapAKDhXPazMSQIo+eDyeAq4A8SpEG
         hS/ma7ko5ckmmGfzY4tOS0t/zHkGJDm+Ane1utoCWnI+iT9cpxm6P1WkEaFMh+Lw26Ru
         xSLoch9ALeBwrCf0s6SG0wVUcllXc4tnBtGTq86i6oDYcGjIAlKqyFrQjSmjPOE/K7FW
         /WzFLfYDXJ9cQTOdqDIyIiebyPNUsJwyglUMIqMcMqtuW4wKHGCZBKco/u6VgOkxJrhj
         XBhvmD2ugGXwL2HjMZ9BwljEBWj4FgQiySSvhN/b6EoQJHZAqV3xFk21//m+ik8a54Ls
         tcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748241410; x=1748846210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZPltjG5SvwVjWya2TV7fEz5DnOlg2tbFAzmA5YnBrg=;
        b=ISK/NnsyrLQQVDmGq0Xb8Uirzyr6s4Q8uh1fx6kmLtJMxlvn1Sa54QJWEnS4RxlRXY
         gvQL4Z5ukwuJ+ao1mFcotome6205GijTUHlJq/h5y1G89HhJrE4L8yXGf0bVX20qseJn
         p0oeOKncOByNac/9Pa5XBh0KdPbWioCuBjf6MBuK5k+zDKorjz4m7MmRSfss7xlVUbZk
         UeD6pPldOJ+Qhi2g11TVtBiSMhu/x68OG2ptl5oNsL/nkIBwqHN9wnkJRr7LTwjyYINc
         ZJnZZBkQMTUh5hDqpDoroy7GNzbJWAlJcZJsYgHJu4Kfi5GdnNBL+yRjVnNBgO/9lpTj
         lp5w==
X-Gm-Message-State: AOJu0YySbmJn+fZshjUPORgS2LL4gzKlIBoJy4Hmj8UN6A3SyxY3aOkJ
	Mrzf32vfzjh41HMuSSKmC4k6KztgQqdW6w+aDJuQkFD/+Uuwbig2Hn3u/VBSskHZnHQ=
X-Gm-Gg: ASbGncsqR80bZTo30pUGjFFB/GrX6b6XUQRoPS2GOC5yG/yftxMraavj06fWOA3bY31
	bBr5t+FLeNHAW1FePBna+pfNtQWvzpbavgZw/zDBpJDTmq+xsJ2YrXfbhXmFdoYXunMC+uDUh0P
	ueukPcqoMlHp3lT7QQ8B5OLNt6D4cE28zHbPO5BGnTi47jKJNLgNq3h9ExH/nvOJheS1YID+6sB
	A/yllSjh2prZEvYMCNiByUlNq5cdMR5qdyjkUiJt93hdV2FL2eVD7+7YM8YY7VFbMiRYsG0dRSl
	Cp4izZ1lECWd8F4Pnf5N2oqZs/HRoPmi335I18aUItdTlaiX3j4g
X-Google-Smtp-Source: AGHT+IFW6ph/NvT237B4CkjRNsZrBg5Ak8Y+oT0ZUYcZh4aktEUHNIBjBQShSRMTh1MBa/gLwOT/ZQ==
X-Received: by 2002:a17:902:d2d1:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-23414f7d131mr120332135ad.30.1748241409969;
        Sun, 25 May 2025 23:36:49 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23424bf7293sm30726645ad.151.2025.05.25.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 23:36:49 -0700 (PDT)
Date: Mon, 26 May 2025 12:06:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.16
Message-ID: <20250526063647.ydi7vlqdiguf7cof@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.16

for you to fetch changes up to 03eadcbd981b4c9b10ec89a046deeccb115c98b3:

  OPP: switch to use kmemdup_array() (2025-05-19 15:37:53 +0530)

----------------------------------------------------------------
OPP Updates for 6.16

- OPP: Add dev_pm_opp_set_level() (Praveen Talari).

- Introduce scope-based cleanup headers and mutex locking guards in OPP
  core (Viresh Kumar).

- switch to use kmemdup_array() (Zhang Enpei).

----------------------------------------------------------------
Praveen Talari (1):
      OPP: Add dev_pm_opp_set_level()

Viresh Kumar (6):
      OPP: Remove _get_opp_table_kref()
      OPP: Return opp from dev_pm_opp_get()
      OPP: Return opp_table from dev_pm_opp_get_opp_table_ref()
      OPP: Use scope-based OF cleanup helpers
      OPP: Define and use scope-based cleanup helpers
      OPP: Use mutex locking guards

Zhang Enpei (1):
      OPP: switch to use kmemdup_array()

 drivers/opp/core.c     | 428 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------------------
 drivers/opp/cpu.c      |  30 ++++--------
 drivers/opp/of.c       | 205 +++++++++++++++++++++++++++-------------------------------------------------
 drivers/opp/opp.h      |   1 -
 include/linux/pm_opp.h |  32 ++++++++++--
 5 files changed, 262 insertions(+), 434 deletions(-)

-- 
viresh

