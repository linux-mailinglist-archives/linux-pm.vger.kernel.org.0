Return-Path: <linux-pm+bounces-37532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0FCC3BBF5
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B451AA609B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40333FE33;
	Thu,  6 Nov 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njlhqbCc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE533FE36
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439143; cv=none; b=SyGfvSmLXOGSUXichJpIjAV1e7XQu6jrvs2553BNJrIUIYZljpMTKS7b3nokIUcoakKxsN93L9/m//8mVTrt8lq5xQCFYJJ9lR5AU/0VtS1qLTJktu3DbAuOEbwj5+l0sP7CIs0ucnboyqma0MurGEAuFzaoi3VJZWZ5w1urCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439143; c=relaxed/simple;
	bh=Zm/KMX3+P+spDchlDgWJfOpb9rGK3VkO/1JFhlmuIY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNCtXDCNsF6mOD1enxYBcJtmlalEkjQY0CAGvLjE95kvwciX9RSlLJNkioxH0OBQ308lQI3ET4do0cVItAdNGBTnCLEOAPpJbNxwQJiAn0+IfTwhRad2ilYwa3NnRG+d2XRZoKIPvXeEnn2WMf3LClZztrWbvyo+Uf1gMetY6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njlhqbCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8898C4CEF7;
	Thu,  6 Nov 2025 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439142;
	bh=Zm/KMX3+P+spDchlDgWJfOpb9rGK3VkO/1JFhlmuIY0=;
	h=From:To:Cc:Subject:Date:From;
	b=njlhqbCcttfKTq47d4eaUat0AlfrYuwBnbBqFnGEsUN9bgSuh6l8sMdr0L7Q/j3ju
	 YBkvEzEfG5yzHOyAbNrzvn3Y64s4BBZyuedf0uCR3Q1qaMgcQPFj4/+Sq6FJcuVpnS
	 PSxuRD0YGWH6LZmMmOKtlm81venTVG1XE9YKrRsfA9twA/IpM9ia16KRb6yzVyjJ/C
	 l+ht1RCJy85txtF44w4tSYJp0K9MBUMfj9POlN+Y7kG+nsoD7HAuRRgwvlGsu72G1C
	 ir1ixfsOfpmYes9vLWwwv0WWmMQxXNBv8GkPEJk21D2LFZQxLwZD2VR+aOYMghcjt7
	 llPhqtpNBhkhA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] Documentation: power: Correct a mistaken configuration option
Date: Thu,  6 Nov 2025 08:25:10 -0600
Message-ID: <20251106142524.3841343-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Somehow CONFIG_PSTORE_FIRMWARE ended up in this document when I intended
it to be CONFIG_CHROMEOS_PSTORE.  Correct the configuration option and
make it clear that not all options are required.

Reported-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 Documentation/power/shutdown-debugging.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/shutdown-debugging.rst b/Documentation/power/shutdown-debugging.rst
index cdfa2cd90e5c6..c510122e0bbc2 100644
--- a/Documentation/power/shutdown-debugging.rst
+++ b/Documentation/power/shutdown-debugging.rst
@@ -24,11 +24,11 @@ following kernel configuration options:
 * ``CONFIG_PSTORE_CONSOLE=y``
 
 Additionally, enable a backend to store the data. Depending upon your platform
-some options include:
+some potential options include:
 
 * ``CONFIG_EFI_VARS_PSTORE=y``
 * ``CONFIG_PSTORE_RAM=y``
-* ``CONFIG_PSTORE_FIRMWARE=y``
+* ``CONFIG_CHROMEOS_PSTORE=y``
 * ``CONFIG_PSTORE_BLK=y``
 
 Kernel Command-line Parameters
-- 
2.43.0


