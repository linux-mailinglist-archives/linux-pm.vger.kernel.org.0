Return-Path: <linux-pm+bounces-10219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9291C733
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302EB1C250C1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A678C73;
	Fri, 28 Jun 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Sv6zLPwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EE7710F;
	Fri, 28 Jun 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605643; cv=none; b=FinF3JKKrO/EN3b1T4UZzyhoRNr09Ech5043a2u5rNoRp38HC0j6Ck4Y8kojPABLDAc2f0vaO1qw7uitCEYebZqYqs8Gf3LELIsMsigVV3fy335eGC69Ws6sgYAqyj/Bes+/O7hrEDpqyTOsUY66MEvfY8CI7lOgndDga2+1A94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605643; c=relaxed/simple;
	bh=T8//v0zrCVBlj/ERhM24CcKW6GItp7iQCOoqySVLGsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJF0TPTHrHAfTtdmq+8Op/OLBd4EGj8tuUVOxF8tZWnys3Oq3wY3u+SoDlrPnLkDDPrsDcL9A8VJv15/jj8/G7//UCLwO0F2K9oc0RRxa7nfGWRgKP+SsOXtzbQPvN1n6/kSTmV0Ar63MexVQi92vk190srieiLwkHP/7EVaFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Sv6zLPwL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719605636; bh=T8//v0zrCVBlj/ERhM24CcKW6GItp7iQCOoqySVLGsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sv6zLPwLMsyuXki5EbGrzVAjpqZtQbgkquAvWGiH/0rYUh+LMOJUoZjCbSogFmvNC
	 vzWuV77OhDnXWqDdDuCCXmzoS8hFrU1lapskg+Q73860IZGqf/j8HTv67TruHYholI
	 heUB/ExuHaZBZLnwPvmHXDSoXlzCfq781OHpt/nfIghwjonPIQgaFiau8glvh5+Ep0
	 SbhMLxENhtO5N7YJcHerKXHbqiaUC4WcDeie96bkvZrADmCAb9ZI3qezGYVe7SidVx
	 ZoIN0FGOvbAEUNgMhjmJToOuBNEj9a1kLcq9nipUh8StFMQkx5YSsQDzabAajAclw/
	 54Mofh5awGuhw==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 0/3] Updating maintainer and correcting Czech translation in cpupower
Date: Fri, 28 Jun 2024 22:13:22 +0200
Message-ID: <20240628201321.1657-2-danielhejduk@disroot.org>
In-Reply-To: <74e09bb5-6226-4c6c-8694-7f4235dbb9f9@linuxfoundation.org>
References: <74e09bb5-6226-4c6c-8694-7f4235dbb9f9@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is series that fixes a lot of strings in Czech translation of cpupower.

1st patch is updating maintainer of the translation to me.
2nd patch is correcting the strings of the translation and adding new
one.
3rd patch is adding changelog.

Daniel Hejduk (3):
  Updating cpupower's Czech translation maintainer
  Correcting needs work strings and adding new to cpupower's Czech
    translation
  Adding changelog for cpupower

 tools/power/cpupower/ChangeLog |   3 +
 tools/power/cpupower/po/cs.po  | 174 +++++++++++++++++----------------
 2 files changed, 95 insertions(+), 82 deletions(-)
 create mode 100644 tools/power/cpupower/ChangeLog

-- 
2.45.2


