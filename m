Return-Path: <linux-pm+bounces-36822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48852C08B4E
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 07:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5142A3A1F9F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 05:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001532BDC27;
	Sat, 25 Oct 2025 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjvfa8SE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA21DDC07
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370008; cv=none; b=M/ak1LhjyWv+xCyn+nkemVG12wX4a4OPNjeYPTCt+/NL67zRAzos91nq8wwM3VPURNa3jYvJWiRE9RluZVycztIkxvqmIwkIZUAcNhCZfR96tnvdFSg7mLiPdIx6HP/+w/TkQYDP7wBqT+aZTN732S7R1G3Chk6cxSDZvPAYijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370008; c=relaxed/simple;
	bh=/zQwfhMEJhTOa5/FV1euV1Dku1nFTDlTsbnBQjlqjDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtO/NLMGHzvXqAruYTjMXfrJP/xzT2AXafzYAT4u/pVfXsiTWqIiTvt6VZJ7uebGuIiBU1ixR4ft5LCWpUIUD4upGAkaBU1Psq4i5h/UGWzCq/lfncz3Yuzmxf1k97DBtW0fQQPihuN6rTY1MzPuUVXktwjHGMD4MUuDqc4t5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjvfa8SE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso4506445a12.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761370005; x=1761974805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=Pjvfa8SEZbxsM/zJR4PQ+NRDcthojbCwES9h0rerasc6DuX+QlbPq3ReB7mSmCwZzk
         G+RaYizITPByzjqWgNZCCdnHaJaARqKNOXhortmhpG6uojE+a0urH8nCO97GrZMm6zuO
         DdvtNpTMeHn5rWMFFQ7Ju4peQwzCN+8hsCog0MMBRSxOQ39Bv9ts+qL7kuXrPafx2mDp
         gsIImPcmgn6dRmfYObiegOz3nu/ZxylQPh2GOg8+npFQgjOqF89CdQqJEmYiltz2lDST
         DmfDH2jHtwgINimt1F9lgcm6fSLUUT2WEstjXw4+XuAN4I8VbQ5sjQS+kAyiVJ8caOWb
         zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761370005; x=1761974805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=U/hfKMMtsZ/HM0ACosOIiNrU36jnNg/mUV+h4y1+m45jhOHzZ2OEUb6cjZBmOdSvWG
         WWFvC8qMrcmWYtMXXnrNnouFKqwMB6Y4rY1liH0IUcS1sz6sHrOqQdiUSpJRthmOkWWy
         2J8n3hNj0PS22MQbPcR4If6yNP4HvODZEevQv01x9vCR2MD2vcWGmMV86uJ5i+7jSPrA
         etoI5Rme9RnUSxHXBaH9Mv3jpcqCdlHj76RFrLcCimBXe09/QOoeIcfJ22QzOYlyFrll
         Jc5eGOFORTG+Gjj5DeQRuBYlKOnh/eWNUklscPYIp1IG2Zq0JyZjpEv4gWSkeAoZ/pq1
         LCrA==
X-Forwarded-Encrypted: i=1; AJvYcCVyPPj3A032SBgc1DtFNmucs+aR9pjPHUXQsksxq2wwffHLEqj2olNpanPabT/34yMcY4FeGN2TVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1wgKcQv9hReyJDmEXI4h+AUgE4wnVndBcQqCwrFP/4wdIFlV
	27BwTwWyWrs8Yb3SyQ1B9so981ovvMY3+aCVAC+Qsrpf+SzGriMdCOJR
X-Gm-Gg: ASbGnctEOant+KSddLO/8lyiN0/aAWutI2dR13kocJ7zBHYdC9KEulauSCgjjvvzvOZ
	hgY3iTSWqoOjtdkwdmXDv9klIcKt+wjnUnUViJQTcFkWDoMkRS5JbIyIfyTLJ+8K31e3jlhiJqN
	g30GaHFt9LfxML2nE2dYsqMvis4knchf/vYDAb7srs9JKZg3+GrfJvo8NXndyrKqm0JEN4F01fV
	HUA6/iW6Ev6TtoF7H6UeLqLdMZfz/DzLyAnoxD/q79Vti6AP13uXyKZYaU7MvBBfP4Eg9Pt4msH
	DL90BDNnLGXsILS85Y6zV953yKLYt2RncJrxjEkS2lX90Mf0QUfheKkJf3k75DYzltttOtFC8ac
	mgepfFvh9qhLvMPvKmYw1gQLGR50iaq4pJHxAN1LPkULNcNmvEvol7xkzvFl9jA5tuNuOBaIcKk
	T7JCvkeKtJMGE=
X-Google-Smtp-Source: AGHT+IHk4JGeekekahtUg2k/EhAC9kyrxVTGjCsIExfHrDtgIcN62P8FCtHZWZXypDamfyJkpyvf/Q==
X-Received: by 2002:a05:6402:40d5:b0:628:5b8c:64b7 with SMTP id 4fb4d7f45d1cf-63c1f64ec00mr33191598a12.6.1761370005212;
        Fri, 24 Oct 2025 22:26:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef96105sm880960a12.19.2025.10.24.22.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:26:44 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	gmazyland@gmail.com,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Sat, 25 Oct 2025 08:26:37 +0300
Message-ID: <20251025052637.422902-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024163142.376903-1-safinaskar@gmail.com>
References: <20251024163142.376903-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> Here is output of this script on master:
> https://zerobin.net/?68ef6601ab203a11#7zBZ44AaVKmvRq161MJaOXIXY/5Hiv+hRUxWoqyZ7uE=
[...]
> Also, you will find backtrace in logs above. Disregard it. I think this
> is just some master bug, which is unrelated to our dm-integrity bug.

That WARNING in logs is unrelated bug, which happens always when I hibernate.
I reported it here: https://lore.kernel.org/regressions/20251025050812.421905-1-safinaskar@gmail.com/

-- 
Askar Safin

