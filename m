Return-Path: <linux-pm+bounces-37494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD72C391EA
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 05:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE51F4F603F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1A2D12E7;
	Thu,  6 Nov 2025 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si9DLIfj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0E23BF9F
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404733; cv=none; b=fAbqy4RiQrSlrZ3XrCnK7CZ6LynRr7Z3PLegF7wsHbOw5SeqRzTr4vwhSs4VABGRhECvd5XSeW1RejDXMIzrIxMmSsccKNat5r2MWmex7AaOTsbB8LcGQFlqcvoRlmjlBBebLk0OdbEaVcYW1ReH02JyWRYQ9NM8oFyAaD/rBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404733; c=relaxed/simple;
	bh=pAJU7/mpk9s0LnyU24VOsL31Os+NOxipsY2uHT0h4us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozdqd9PiFGEOJWjPTLlditki8+U4l24sNJxhAyBPU8KKRb9vKiMsLbieSDyyXTiWGUPDDQcDIuhsGFKkbCm1uaWu1OgeRAUnafazYjV7vS5iBplOBHp1hikSWptJpcqLIyDh8Pl0CROdA8emstfgc69lY0gVOqa+itH5Xh/ljcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si9DLIfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3736DC4CEF7;
	Thu,  6 Nov 2025 04:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404733;
	bh=pAJU7/mpk9s0LnyU24VOsL31Os+NOxipsY2uHT0h4us=;
	h=From:To:Cc:Subject:Date:From;
	b=si9DLIfjAFBOsu9IpK/RdEgZXO4vCor8nlAM3peS1k8X8deNXwdm65vhZ/WpAdFoC
	 6zPeRoGDJvKxCpT+y/P5hltpi2zbmME282K/59pH1Ejs1K5uRPTcOglTvkCnUIOVVM
	 2u+tYv5k4kGO1cI8Z+o+fpIPlJbHAve5QRH1R9rJQHB8PIEENQRhBUOFLjpTLvYJyN
	 QX7nl+ATVMkHM6+caTM/Iu5hmH9bmJfW+Ym5V2xaNZA4nqkRA+Mn4EMKgn3ZSNcV2J
	 ycvbD1mgqrOe1Pae3+R1aUZMZxQUg9GV1TH4ixcijybe9z4eP7s6kV7oZcitjGaAzB
	 nSYBcLd83pI7A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Askar Safin <safinaskar@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Fixups for hibernate issues reported by Askar Safin
Date: Wed,  5 Nov 2025 22:51:04 -0600
Message-ID: <20251106045158.3198061-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin reported some usability issues with hibernate messageing in
some failure cases.  This series fixes those issues as well as some style
issues I noticed while touching the function.

Cc: Askar Safin <safinaskar@gmail.com>

Mario Limonciello (AMD) (3):
  PM: hibernate: Emit an error when image writing fails
  PM: hibernate: Use atomic64_t for compressed_size variable
  PM: hibernate: Fix style issues in save_compressed_image()

 kernel/power/swap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.43.0


