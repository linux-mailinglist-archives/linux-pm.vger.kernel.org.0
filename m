Return-Path: <linux-pm+bounces-33194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595FB37F24
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD167C04A6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CD2D97AF;
	Wed, 27 Aug 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPtdGno7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF52989B7;
	Wed, 27 Aug 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287966; cv=none; b=kxcUoMVsSMFe6CFCdAEvfVw8hZqvhmBATU1SZa/gPowM77cyG1hdo6ntau/uqdtNp9WuR6JtFUVRRty7Xw1k46sxnbe0oYSO+hh3xSC5HXeiUqEef0gJikPTqFCRqXtYZ4vU0456JcbQrww9K/wGlNwn//CVsHhl24d3DLY07Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287966; c=relaxed/simple;
	bh=u9w+QyKfs4d6GbI4eKQgVeNDXR2KS703PWN7laxmAHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RzVVRqw8jii70JAGwB2BVRHIfReKz0RG6EDRCDe2WaawrcupRzNsziHs2eBeCVtJf8C93Ni6TqoHTCRbchC+xy/VOXvGuqSvpelMRodKRNHNmXk/tcGFV/AI4p1XsyUjMkTOSTMJnVZJZ9h4YRdxJLwGe8mnIx5P3eB/Em8Gcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPtdGno7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 360DBC4CEEB;
	Wed, 27 Aug 2025 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756287966;
	bh=u9w+QyKfs4d6GbI4eKQgVeNDXR2KS703PWN7laxmAHs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DPtdGno7rn2UMayPEjN0ybxuEJ35q7Fce6ysG0HyrVAmvuLMWzUZKDBPGmR3oGQFK
	 PJlRvcTFHi7QoUk3gwDrz9e6UFoLVt5+b2t6CJhmE5QZUHiRZk3+jJWVtxPokYUEwG
	 MjbaqA248AWscU3ukiZmKJBdUUTypX9On9QUfa5hrNOQr2zgBAnwkwuooJMBqUrPnb
	 ZUToIJv40YlwpTv3VGGqfDJvFnKkQ79qEoDs/ox8rnuNoT51iS0baThfqlcNFlND8A
	 WuBXCYmhhx+ucYNrszUpEgsnLWPqxF3Ode2ZbKYYLIFxFLxAuh1gWmbsrSFMNvUyb+
	 Oh/C8oZkz56bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15262CA0FED;
	Wed, 27 Aug 2025 09:46:06 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 27 Aug 2025 17:46:04 +0800
Subject: [PATCH] cpupower: fix memory leak in print_{on,off}line_cpus()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com>
X-B4-Tracking: v=1; b=H4sIANvTrmgC/x2MSQqAMAwAvyI5W9CAVv2KeJAaNWhbScEF6d8tH
 gdm5oVAwhSgy14QOjmwdwnKPAOzjm4hxVNiwAKrokGtDn+RKEvWy7PTuCldmbpFTILWkLJDaOb
 7X/ZDjB80im1xYgAAAA==
X-Change-ID: 20250827-power-memoryleak-75c692220277
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 niecheng1@uniontech.com, zhanjun@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756287965; l=1207;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=CIlvBttpFzObEhZv2UVHoutl1JwPsF3bnPu6l999qkU=;
 b=UkmkUmpkLJ8MK37NBRy+YepHCVbC0uEGXSWXdSsHmU48X4tg2mUFA/0caUeiIZmmhCQDT/90Z
 h+n0QUp/qJXBB3a9KD/P5kwrUyM7Z3dAMu7YMmmCqJIWXJlSkBUPEzm
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

{on,off}online_cpus_str not free after use

Suggested-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 166dc1e470ea6d70079fea6570750885d549603a..f3b4fe95520ff96a1be8b1ba8e7be1ec116b1bc0 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -213,6 +213,8 @@ void print_online_cpus(void)
 		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
 		printf(_("Following CPUs are online:\n%s\n"), online_cpus_str);
 	}
+
+	free(online_cpus_str);
 }
 
 /* print_offline_cpus
@@ -232,6 +234,8 @@ void print_offline_cpus(void)
 		printf(_("Following CPUs are offline:\n%s\n"), offline_cpus_str);
 		printf(_("cpupower set operation was not performed on them\n"));
 	}
+
+	free(offline_cpus_str);
 }
 
 /*

---
base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
change-id: 20250827-power-memoryleak-75c692220277

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



