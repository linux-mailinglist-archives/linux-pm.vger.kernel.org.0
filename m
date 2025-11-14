Return-Path: <linux-pm+bounces-38025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B8C5C4CF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23353AE752
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4D309F1B;
	Fri, 14 Nov 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1hM7L/cT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288553081D2
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112680; cv=none; b=YrjMthI0gAELtVLV5LR7v+L05VGl4KVPBNf6xY2xm0hJKXpiez4ea2c6Nw93PlMljwFP4ypT+0nP/5hg5hHCzSilTOHl6h8GlwcGYpggSIMRVSn2Ns2ltoOfFT9BoDTCJQVM9m46vvAw2RpLmJ8gMtnh1fQFkj3cCCStLI354mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112680; c=relaxed/simple;
	bh=Fokp6DI3ZgvMfeV4tDWIu8AT5pAwNorUHQtwcVcIzSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCRZ/ojxXh/homZzlwuEa/vlgiVaWVR/kc35kncdqIqlf6b2ivPbJdk18nNFFGCeyxvFqiAPMa4EHwfhaJqNCdiCtsEs+W8pFocehz7mSfbdC3fPFweXuY5ZOHfJYoyK9HduvOGgriKCXabfiUYF1rIxfFFvBOsW6YxIevCckuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1hM7L/cT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so2724832a12.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1763112676; x=1763717476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lie/xa7qc7Ek8fm8wHatiECh3EUIgF2lTTajZ10Sa0=;
        b=1hM7L/cTDFahu47ciwkvt0/0DiBw7z+u4kFQeo/IjznMF0SKT5OodGjl+6IP0sthnv
         RidrO9i6rip7ReUFH+O0wz93v2PreHlgKlBUPqIkFuFvGbMHCSSQXYM5TAMk63wm7GK2
         2CQOlJtR62K0E2zlhDfk2S8RTWPa92bt1z0MSF9KiP2/8aYS/acRKqXk+a/06NZCM7jZ
         9pjIJltlu7Q0nNIF+ViNNlG4JW6o9q03Z2w9GcSpVqyMC4jI0+BLmgXkM+Yb2ef8crRI
         3//xepRH8g8qpriND/MEpPG+0Zsrf3l9B5kS5A/l7RP5uMErAf7toNXAj/BBYvWWY82H
         bGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112676; x=1763717476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2lie/xa7qc7Ek8fm8wHatiECh3EUIgF2lTTajZ10Sa0=;
        b=AaCy4SGee5imzcctnmlbtPutzC2mOXfRa181e2t47EUdu7BzlAmtnXuX5JdWLe8XfU
         3Ds8UspMa976RYQ2UKCfcOPNrcjWywFjDPgrbXJVO2eizC3HQay2agn+knYbD0E7u/zg
         OxvJQPWCsW3Y/lGroqWH613IoFfvByLofX5cKswMg04OGCyDnBrckqNdJBOK8MRmjSZe
         w3h7JpZIuwJB1WbHRUvp13/bFI89WBtdcVIIakEMfAf+UANsllOQernEHESWU6Ibqj7g
         F18XU9Wmpc3e0qvQsHtbL6lf/wbj6t5Ci7pyCvFv2AySDW/WUcEvit3M8TwnGhzVHG0T
         USsg==
X-Forwarded-Encrypted: i=1; AJvYcCUXd9T+owfBkzBcPxhtINo1Xu9z8Okfl1dumzv5j8SxXlu6VjB3TeswuBy35/RpcRbGch+hBFn0RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJs14H9BuQBazDr1exCdwfyuJ3Z3w1NPeDcaC7ainbH03K3dm
	j9+JY4SC+LZHpLIudhYaTAanUdUbhHh0vobiP59M+uZCFl6hsl2Mhbu27wiTSxPLN7I=
X-Gm-Gg: ASbGnctnxWNR9tMOtXSjteMGK8eUHlQncIA4miDAhYpBQ9WZ+IRJpK5wzNCv6cReKC9
	VIFfKglIho7D9ZQgadtV+5SXoOX4j5L+F+c2biIXOhplmcGNqYg8DTg+KofcVgDcMdtz/baMaPG
	3NIO/X9yDEr3AD0xvDNiWAaoQ89CPPPCWyeEhdwg0gGpqkeNOQ8lpOYqk0qd49mcqKONkE1vDQg
	DlLiq61Hr3iZPoWAbL04DuTWr1VzwWUNhp2bEdi0gfqkugZTMnhQZGElmYFz+C2qq609Ib9zPQW
	eEM7KwgZRgOGFCsZuJwseivnQwz+frTWGo0ks8y4+Ii01Ybh7vAqmH+dehubHKMuwWGw3pLjrpP
	JPmuucQT0U4g+wg0uOcMH0pd1jdsXaQtmPFdnBjjYc0+M4JJW52bTcz+yt0ApPcCyV7BczIVBma
	QwaEXXc4sGhzNSqts05UF8Jch6oL5d8m2byVlR+eY5M47+i0TRqFMRLQuRa0TKTvWsqRPCzqXRF
	+TojLzpWRix1sbnryTtpiyRlPo3eB4K8qhZYw9rI5RQ
X-Google-Smtp-Source: AGHT+IGv7NzlJ8vcISP1RXt6QWGiueuxhZk8jTm6UtlmVL0nCoXWqv7iPPstalaD6MWfX/FUBpuUMA==
X-Received: by 2002:a17:907:98a:b0:b6d:67b0:ca0b with SMTP id a640c23a62f3a-b736796b4c9mr211603066b.61.1763112676330;
        Fri, 14 Nov 2025 01:31:16 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0509-ec01-156d-fa6e-7f19-0b67.cable.dynamic.v6.ziggo.nl. [2001:1c04:509:ec01:156d:fa6e:7f19:b67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80841sm352104366b.41.2025.11.14.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:31:15 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Nov 2025 10:31:11 +0100
Subject: [PATCH v2 3/5] interconnect: qcom: sm6350: Remove empty BCM arrays
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-sm6350-icc-qos-v2-3-6af348cb9c69@fairphone.com>
References: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
In-Reply-To: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763112672; l=1834;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Fokp6DI3ZgvMfeV4tDWIu8AT5pAwNorUHQtwcVcIzSE=;
 b=Zi/RaiK5Rfu1T6AZfcvzDgwPKqVZcrP/SBZ0CWT/bpweCDnz9ti/5N7ygoCFGj0V7Q52oSIhD
 btR+yiyAVF4A23j2WQl7J5dsfrpEoucXUuG5xGZyWAh1oKCvcmxpg3E
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Clean up the code by removing empty BCM arrays to save some lines.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/qcom/sm6350.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 99c435a5968f..246549cb761e 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1526,9 +1526,6 @@ static const struct qcom_icc_desc sm6350_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm * const dc_noc_bcms[] = {
-};
-
 static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
 	[SLAVE_GEM_NOC_CFG] = &qhs_gemnoc,
@@ -1538,8 +1535,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 static const struct qcom_icc_desc sm6350_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
-	.bcms = dc_noc_bcms,
-	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
@@ -1600,9 +1595,6 @@ static const struct qcom_icc_desc sm6350_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm * const npu_noc_bcms[] = {
-};
-
 static struct qcom_icc_node * const npu_noc_nodes[] = {
 	[MASTER_NPU_SYS] = &amm_npu_sys,
 	[MASTER_NPU_NOC_CFG] = &qhm_npu_cfg,
@@ -1620,8 +1612,6 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 static const struct qcom_icc_desc sm6350_npu_noc = {
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
-	.bcms = npu_noc_bcms,
-	.num_bcms = ARRAY_SIZE(npu_noc_bcms),
 };
 
 static struct qcom_icc_bcm * const system_noc_bcms[] = {

-- 
2.51.2


