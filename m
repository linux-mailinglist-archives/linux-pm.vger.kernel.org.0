Return-Path: <linux-pm+bounces-36785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580BEC070F8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C06F1C013DA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6C3101BF;
	Fri, 24 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2DGf8WL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97C1DC994
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320802; cv=none; b=iZ3nvS/Y3BTQU5YWyo/5eTRYUfnNkw/DdBrHsP24SsCLt/PlcUKGS8nDmdGN6QIZCV+nuCvLs3LEFQWOvUF2cphTPqHStxoerHBd2sulqgkrrkequQF5N0uAdGjTi9b8V2cM+BgrrxD8ungztHOFaGchw3mpl5gxxAv/ltOGo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320802; c=relaxed/simple;
	bh=JVzALkBAhM7FXG2zWikFIiO9N0itQ5L1kkaDi+Cs5as=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sTb7YFCmo+tT9cPkTagZOVRcCoyPKNejdp23ruYhIwCj9PqlWnlX3hOrRinflKUuy5vyxAzMhleKhTKAWsalCnUDuWSRV3wKxFqc0BAtgt2Cri66KbeNq26nwH0ji9r5kJaKVGgDlOjenyygkyRaBEuYwddvDG6I3haFfQ3S0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2DGf8WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79677C4CEF1;
	Fri, 24 Oct 2025 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320801;
	bh=JVzALkBAhM7FXG2zWikFIiO9N0itQ5L1kkaDi+Cs5as=;
	h=From:To:Subject:Date:From;
	b=S2DGf8WLIOKrt80hU+SO72mW78XA120ueuwj8uZwRqVk4QnxTmot4rvHPnhy23aKh
	 /J4PEvCBI7HVC5dpFcmJOHho31xZyD4ZsKgyzJmluMaN9D1DLvf7lAV/pomDtT/oVx
	 behbhXgu0gssAf6MKByqoeoOEThNBCez+2yC6C8UsDLgfCxNEdxlutbdCYviLKEVzf
	 eeos4sCFFRVzLqcy8wcdT6HPZw01CJz3nxQx5DvCVlNgwVIe0ne+iY84XvP7MMfiBy
	 X5300d1XPxvnNvCXlj/oHwk9grs1ibmBQkQYvjv9fzPYQFYEclNSa0IlOrZnvj0JKh
	 B+RlUPe4Fmrag==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: PATCH[0/8] turbostat updates through 2025.10.24
Date: Fri, 24 Oct 2025 12:38:10 -0300
Message-ID: <20251024154630.18359-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rafael, can you pick up 1/8? It is regression fix.

[PATCH 1/8] tools/power turbostat: Regression fix Uncore MHz printed

2/8 is ready for upstream, though technically a feature...

[PATCH 2/8] tools/power turbostat: Add Wildcat Lake and Nova Lake

3-7 are random cleanups.

[PATCH 3/8] tools/power turbostat: Refactor added column header
[PATCH 4/8] tools/power turbostat: Refactor added-counter value
[PATCH 5/8] tools/power turbostat.8: Update example
[PATCH 6/8] tools/power turbostat: Refactor floating point printout
[PATCH 7/8] tools/power turbostat: Remove dead code

8/8 is a new feature to show LLC statistics.
It "works for me", and I'd be delighted to
receive feedback on it!

[PATCH 8/8] tools/power turbostat: Add LLC stats

These patches can be pulled altogether here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

thanks!
-Len Brown
Intel Open Source Technology Center

