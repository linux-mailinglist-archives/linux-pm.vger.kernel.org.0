Return-Path: <linux-pm+bounces-24851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CCA7CFD2
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5327A380D
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FC19D882;
	Sun,  6 Apr 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYiMUDoH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957B1624F7
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965904; cv=none; b=TysOpUv5gO5nv3exz6jK1YRkdbs8mxDQ7AxWNZu4ifTUR2zfjoRE5y4DLKDTbv5tJZbmc6kCdSrLkUFihoAr+SpfexepKsw61ctSnVZLaMGls5RLUAiO58xjgf7EBrtR/At04jMsw42lXAdxYg1ea67oMQdP8cg5ZWuFyo7Egsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965904; c=relaxed/simple;
	bh=NVCRQsoPQ7kvwmbcN/OAawRzYHH4mict9P1bYVM7+b4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XAlErVfsQEoLjkFtCdQHeNr6lRx2i3gMJMcYPV87I5BSM7pr9U93Xk3eTYCsc6C4XOYxUv59Yf4QRHIgKKNBpMyr79DBGTO/fu1KHibU/2nJkLfNZde1VNHxWAAtCKOIBup7bAMpCk6wKgQZBUaiSWHtflkxkOW7k9mb5PL/T68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYiMUDoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6E9C4CEE3
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965904;
	bh=NVCRQsoPQ7kvwmbcN/OAawRzYHH4mict9P1bYVM7+b4=;
	h=From:To:Subject:Date:From;
	b=oYiMUDoHA1asus9nEaPE11bRulhZc5THD/z54GYvBJ/t3/Ak7N+M2LvmffE8Rawx8
	 gXdRaEQL22cEKLiipSYi1JXk53fPsp/VE1w1g4AHHwgim0orCh/pjk0JkF5sF/wEQp
	 kz0gmV3kWnXTepowfWGdT+U5j4IfePuy4UH12UsHhEtuB/yNYZY9WM0Qy1XCqwz9zq
	 aFYJBO4i2cAdKrrlg4cEQchH+Xh2Cis8j2veXGyp85dVDzPAOP2tngszE5voqn91v2
	 TtDXYUgQs+cDR9DtjJFmudiA/faFpxqjJ1xcRwYI5Q5yCg8eQquCFo81uOQMU5/s2o
	 rFvdTLHA50NEQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/10] turbostat 2025.05.06 for Linux-6.15 merge
Date: Sun,  6 Apr 2025 14:57:09 -0400
Message-ID: <20250406185820.765991-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support up to 8192 processors
Add cpuidle governor debug telemetry, disabled by default
Update default output to exclude cpuidle invocation counts
Bug fixes

Please let me know if you have any troubles with turbostat.

thanks!
-Len



