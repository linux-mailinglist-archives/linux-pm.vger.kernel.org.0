Return-Path: <linux-pm+bounces-41515-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HEbMOJheGmrpgEAu9opvQ
	(envelope-from <linux-pm+bounces-41515-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 07:57:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F4908B6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BB43010512
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEDA32C301;
	Tue, 27 Jan 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAQnvcj9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F38F5B
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497054; cv=none; b=lWoO+TkmQaCfqlWyGWMvlnSKQzDVyg2Gf3aKGRcImylywfW26Q8WH6DuE0WK9cnxQ1rKC11CAPy/7x02Dz5ssRFjUDwtIuBhDuZ/aZpMUgXTc4i8PH4nv97ij6kml1x4wHrcmbPA1vjtZKHJolXzbzCqq/YDbMC5ZgBNbrC3bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497054; c=relaxed/simple;
	bh=KH5ScfjcjTf2UX5zOut7vI2OSZp/1zeGGqRp6l8j9hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sb2V2FEH/7bH+5YvmNliOixNbKFgfZTSqnr3tG1JnhsrS+Au5t+gDsJlkUEUX5HvZFaC6vEH4a+oKtrXIdhFi6H1YI9YXoPMr4oMgbLr2HS+p/gsgDBw/1GTbhErYRYfjfL5nUL+SWsMjF0ywAH94yVNNqo9ltCCIRXKG0P75/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PAQnvcj9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso3326900a12.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 22:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769497052; x=1770101852; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNjBcv8QAwiuLhA6T32deKhgjlzFqF0KYj3KJv6SIN0=;
        b=PAQnvcj9WOJr1idz/eia+tP5954N0pIa1KoKQibE+lhUG4yO140Fs5RigDIk8t+/nQ
         UkBC5nLhJ97CO8pSAlaIV3Rv6r4FBGwmU4aeh0Cg7lGqQUQGzsvv8qNP7C2d/ANBhUPG
         fz/8E3S8HDfz95wqD8LK1eI2PuNidqZeNo66yNag23qECFE6G1am5CY36ePyrW48wZsO
         6t126NE4uz0LOE89IZQLH8FOBdrzXb03DvpPG4Y5qZVNCRp1P5f786J8AQLQO6o83USQ
         swm9dZrOuXe24mZxbywDty94rYuqu5lqePFOGXfSmAooI7n6HlwL2ptI8VIdBzGXTkLB
         7ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769497052; x=1770101852;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNjBcv8QAwiuLhA6T32deKhgjlzFqF0KYj3KJv6SIN0=;
        b=GII4M9dC6OipMD0s+t98jXD7jLsgI88uNdSvHABSZJ4LDiSaOUF00PAKbqav5CKCDM
         XTXEunUeEo4W+8CM0Iw/vH7/aNYnyKYbve9tmGYcGNXrW6ZfNhV9eX8nnCVviQlXcP1S
         3D6E4yKrLs2JUcxDd+s+19455HolCXzSUpMoJOB51G1wtn0x0MnjlyH4DVCJKcnZU0iA
         A+zPS6SWejw/grWaKJCSUFOhV1zN/zIMIq/k/fq9pohJFILoyV1pZTg4UxFONLgummiw
         Qm5DNoiDu21nz0E82RbMz+HEq1im3lFhwMQm/rexNbvAJry7MiZqYEhm96zkKKxBI6c8
         tDtQ==
X-Gm-Message-State: AOJu0YwruQi7gsl4+MlCr3199JVsPFd2z0YkIXT/0AsLfOy3DIHAYZj+
	CYpWFWm9FMwI3gxLE6Nv2gHF7vzY+j/Lyn0V2X9rbdGgZRBI/ICPweGUGnZtJs20zNk=
X-Gm-Gg: AZuq6aIFGVxJf0cPZCV1P1VVBr5E02vMcm4ZmyPlz2t4VMyC7cj0DbmR2y5MDzZr3Oa
	f4+XFZXp4+3C5rRP7FoAkdFMEZkJP3MK4gfcw3kFXfgkJAXeynXr17CgovjIAjWUl/hYepY16NA
	JZmDQuf7lo0w2hvTCuUAJbxRQYzOoxhP+Z3zUgffB6qin1gXArmk+NC4lL1zMohKLWCUr4fYocU
	njuk7/s78bYr6WOfjlR6mmRMdgoKa88K8twixb4/CkFas7VCQqZSqmHsXmFyCf4PPoVlvFI9c0j
	Dpyb5JgBdep0wWE8vqIYo0k/ZNyYfxvt/HfRg1oZrx4aPrr15RrusbYxtqr5PCGt/1xra65+6nM
	L0Imuprqwkz+nS4i7MsVGu3Y0ksTJfSlsnrqlXHTO5+gQ9hNLki0sDXaXrfJw7bggRYdRm+Uaok
	ATM9oZyhxfYtc=
X-Received: by 2002:a05:6a21:6e01:b0:38e:9d3b:470b with SMTP id adf61e73a8af0-38ec63ca2dfmr659233637.42.1769497052194;
        Mon, 26 Jan 2026 22:57:32 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a3f2df5sm10029857a12.20.2026.01.26.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:57:31 -0800 (PST)
Date: Tue, 27 Jan 2026 12:27:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.0
Message-ID: <wf7r3yfa3gywn7r7cl5yl43c2r5627nyrkqjc2y4nl3ng2savf@koymn3rhll7b>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-41515-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 117F4908B6
X-Rspamd-Action: no action

Hi Rafael,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.0-rc1

for you to fetch changes up to 0b7277e02dabba2a9921a7f4761ae6e627e7297a:

  OPP: Return correct value in dev_pm_opp_get_level (2026-01-27 10:58:50 +0530)

----------------------------------------------------------------
OPP updates for 7.0

- Return correct value in dev_pm_opp_get_level (Aleks Todorov).

- Use scoped for each OF child loop (Krzysztof Kozlowski).

----------------------------------------------------------------
Aleks Todorov (1):
      OPP: Return correct value in dev_pm_opp_get_level

Krzysztof Kozlowski (1):
      OPP: of: Simplify with scoped for each OF child loop

 drivers/opp/core.c | 2 +-
 drivers/opp/of.c   | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
viresh

