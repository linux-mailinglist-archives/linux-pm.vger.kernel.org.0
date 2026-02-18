Return-Path: <linux-pm+bounces-42825-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLoHMYcClmnQYAIAu9opvQ
	(envelope-from <linux-pm+bounces-42825-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:18:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DBF158A5B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9476B301E3CC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35A345CB0;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpK+O2+Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBF2FFDDE;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438581; cv=none; b=TNur021NT4ShFdEW85K7jaYxmiNVFVjRsMWXACtMVzdKeo1NmvtCOzC2S5Lr9p4rj24SS0+rd0UXtgNWfPpa0WxYM1ALUbblQnLBgPbwG098LhT4cKYSbJMVSvNnaoqv6+yBsaLtWtXy41arGJe/CT9Jk7jeD30Prs+hXnRv8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438581; c=relaxed/simple;
	bh=Gcm4qVHExOEVMXPGeceeOhHrV8lE0lvyc/lJzKXr9KE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wgl3W/NbGPqMYNy2SDVZqcAvb/qMT9Xh2/TQTjyKfGDGN6U/fI8/egJRjWJSCw+0QNoIX8C4+quUnipnJtl1nqDCRcTTW2lqBWwfI7Y5HE8VRCjx0DSr6j8ihEHNNsXyaOEeW8rEkmVBsGg14DTR7jwboAbDMzCmvAe62y+0KPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpK+O2+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AD2C116D0;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771438581;
	bh=Gcm4qVHExOEVMXPGeceeOhHrV8lE0lvyc/lJzKXr9KE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RpK+O2+Qn2qOKH1w4vmhjOsXCxQCJHceEFZnmwD2f2L9a8OQqG+3SwTMSbTC6bIIO
	 5LqzOD6LYA+9ZF11X6FQXNiuxYJtNt7v+E3gjdzFv+qDAhgJLtPGmp4sxrXrN3dtRR
	 VBk+Q2V751++EArb0cesvnsVOAdKHn6FBfgfwc1LT5gkdmsvqi8Tc2E5Qrqje/AIt5
	 0QHkJndq9+oLTD60ngwa/0D9iexgHXgXy8vM5sp2HODsbZbs/b0mh1KBbZHoCoGKcZ
	 DyhufY+8aWLbj2Rf0ofGF0d0J3xrcel4l7yDoAMeOH+276c7gyrNlt9jDeegf2QXdc
	 eWt++79XgL+PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA3E9A03E;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] arm64: qcom: sm8550: add DDR, LLCC & L3 CPU
 bandwidth scaling
Date: Wed, 18 Feb 2026 12:16:17 -0600
Message-Id: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBRFt0Le2GdK+TtyH4ZBf8BLaEtaUzWEv
 VvZgMNzcj87RBPIRLgVOwSTKJJ3GfilALUINxsknRk44y3jrMNo+6ZhqHVA+cKoxEpuRlk2vO5
 5N+UI5O4WzETvc/cxZl4oPn34nDep/Nl/i6nE7IZWVVM1CFXL+2wFrVflLYzHcXwB0XFx0boAA
 AA=
X-Change-ID: 20260207-sm8550-ddr-bw-scaling-b1524827f207
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771438580; l=1135;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Gcm4qVHExOEVMXPGeceeOhHrV8lE0lvyc/lJzKXr9KE=;
 b=C0HAxvfbORFTufxT5rgl1D1byfeP3nL2nahiROonuwq8HhU+DsdwxGWAjHXR4Kuq4Qy14BCit
 uP03bwJo/RWA13hOEmn4myjiZaCKehyv0DUCM1m0+CLrIPh4pH5Djsb
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42825-lists,linux-pm=lfdr.de,webgeek1234.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[webgeek1234@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13DBF158A5B
X-Rspamd-Action: no action

Add the OSM L3 controller node then add the necessary interconnect
properties with the appropriate OPP table for each CPU cluster to
allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
cluster operating point.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Squash first two patches
- Update opp tables in last patch to match how the downstream driver
  parses those tables
- Link to v1: https://lore.kernel.org/r/20260207-sm8550-ddr-bw-scaling-v1-0-d96c3f39ac4b@gmail.com

---
Aaron Kling (3):
      dt-bindings: interconnect: OSM L3: Document sm8550 OSM L3 compatible
      arm64: dts: qcom: sm8550: add OSM L3 node and cpu interconnect nodes
      arm64: dts: qcom: sm8550: add cpu OPP table with DDR, LLCC & L3 bandwidths

 .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 367 +++++++++++++++++++++
 2 files changed, 368 insertions(+)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260207-sm8550-ddr-bw-scaling-b1524827f207

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



