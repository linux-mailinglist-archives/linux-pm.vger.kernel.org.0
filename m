Return-Path: <linux-pm+bounces-42901-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOLmFhzel2mo9gIAu9opvQ
	(envelope-from <linux-pm+bounces-42901-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C8164760
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B0903007516
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AF2F2910;
	Fri, 20 Feb 2026 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5dI/xaH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C718C03E;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560471; cv=none; b=AaKD/SBm2cnyWzDGAytU/ehfyS9If2m+VeGVvxlIj4DseLkn794IzF/kH/IvFEIiDKCrRVhcRP33ZYpLBbk/T6V3Neej/2kU3+LgZfP66dJAuXTdsgFQpEbbAEen7X/Zpj2KRczeBY3dNWT2YSKmZT6haH28LE7+CQXwDCBZizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560471; c=relaxed/simple;
	bh=2iCGULRraoRUNzZGJaTBhx5eh+74uNiuFCJjzd4M2Fg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dlzUcHUHjitO/7Acxqp5xxl20ACSYnDgw4W9VHxlAeaghhNyaRL41h5k8VgwV55sf9aGAZDbQDlshgBQ7uPx+RRHpC/V6Mi8EizeITUcPgiipJ5AhFvZOra67g3rNbcn6eO+0zud2atzh2E5sDHtvlyMaKRq8yrTQXS2h7IxUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5dI/xaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DEDAC116D0;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560470;
	bh=2iCGULRraoRUNzZGJaTBhx5eh+74uNiuFCJjzd4M2Fg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=o5dI/xaHrX2kQi3v9lFykrBlSPL4a6eZ3coY1vcrI3pSYjxQvoL3PP3/AdX4s+Mrv
	 thnROX63t8eYmzlM1cfCIXXvXVpZe3MZrgF5gem2E44FYVsIix8q5qhsdIFKjFtJsE
	 lONr4Ae5t9yIccLk8cS8GSN+0w5+ozE0V61nS2Fb0HQ9u2jnHF/bS9qo48RlVexyII
	 aR8CarYyMBGV+kpSpLGa0mbBD5MmLbmH2N9Leb+u/Kymq5QB8p+r9RE1B1UaW/lyH6
	 cW25vmpOgw7CKOjm9S+wvEjfnj9Fag7S3mzrX0itYtyU9BSJ4H+sEPyY63ik/o0zH6
	 DR0sWDKCLU9Xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC03C531F2;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] arm64: qcom: sm8550: add DDR, LLCC & L3 CPU
 bandwidth scaling
Date: Thu, 19 Feb 2026 22:07:38 -0600
Message-Id: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNyw6CMBAF0F8hXVvTTgsFV/6HcdEXMAkP05qqI
 fy7hRUb4/LezD2zkOgD+kguxUKCTxhxnnIQp4LYXk+dp+hyJsCgYsAUjWNdlow6F6h50Wj1gFN
 HDS9B1qDafELy9hF8i+/dvd1z7jE+5/DZ3yS+tf/ExGnumsqKVjTaSnPtRo3D2c4j2cQEB4XXv
 xTIihQaTOWk8oodlXVdv8o3uIsAAQAA
X-Change-ID: 20260207-sm8550-ddr-bw-scaling-b1524827f207
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771560469; l=1208;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=2iCGULRraoRUNzZGJaTBhx5eh+74uNiuFCJjzd4M2Fg=;
 b=QcmoZJV8o0SGOOXkq3FvvTls/WzFEv1HQs36lHVzHMaeH7cebhGzmLFCQK6IUgqSlGPaNYacG
 jmWmWnYT0UVCTw5kx07Hl23CIm19IoTRviKnRIuPgAMr/e9KgADvBmb
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42901-lists,linux-pm=lfdr.de,webgeek1234.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,oss.qualcomm.com,linaro.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[webgeek1234@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE5C8164760
X-Rspamd-Action: no action

Add the OSM L3 controller node then add the necessary interconnect
properties with the appropriate OPP table for each CPU cluster to
allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
cluster operating point.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v3:
- Squash the last two patches
- Link to v2: https://lore.kernel.org/r/20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com

Changes in v2:
- Squash first two patches
- Update opp tables in last patch to match how the downstream driver
  parses those tables
- Link to v1: https://lore.kernel.org/r/20260207-sm8550-ddr-bw-scaling-v1-0-d96c3f39ac4b@gmail.com

---
Aaron Kling (2):
      dt-bindings: interconnect: OSM L3: Document sm8550 OSM L3 compatible
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



