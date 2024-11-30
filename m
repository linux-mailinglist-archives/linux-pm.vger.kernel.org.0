Return-Path: <linux-pm+bounces-18299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC39DF203
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5285B214FC
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1681A4F01;
	Sat, 30 Nov 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMxm1Dt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE01E884;
	Sat, 30 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984790; cv=none; b=D7Cwl29v4OqO9TC+nuBnoKj9lnSZTdD3obgzzU3tKuUovMnsEM/XnNkrghxxlVISrnrrmNJ/2J77fjwjUbKJYxc3YC7rplUkiuZmgR/N3Zhcv5VpGOrVj6thIw9TQZe7Wo26JEy2nZFGAA7Bo1zgQ3AGpAvaDQzCBXqraXxh61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984790; c=relaxed/simple;
	bh=XG4Tuu0tc1bwT2b6fJl7qoNMDQsqyjSebI/5+tZaOK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+DeWD/fKdpx7x/GlqtQO7vKW8/17J0hw+E56TzNLxc0WaV9kxXnm1mRTolam/asWAEmOtTbh23ktbZWeYTFth/nr3uPdQHQlRnqdTI54v7WJ8JAAGVlZtX07N0Xym86P66cSQGv321YgL6QeieWnVttFv6AJebq0NKW9+PSPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMxm1Dt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234F8C4CECC;
	Sat, 30 Nov 2024 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732984789;
	bh=XG4Tuu0tc1bwT2b6fJl7qoNMDQsqyjSebI/5+tZaOK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eMxm1Dt0+WOYvH7t8i5CPm5yh9r2stzX1xyeD6C9fOZE10zpmrnCzPi+qSLQ+nf8j
	 eLbkkp3fU8KeMhu7AZEyYiOcF9oRroYYN8RBtOJOtVsOHovyTS9njGeDphvwum/hXk
	 4LLoh+KHQ0XYL5VqixtDL02qqlu+42stThtqjY3Tw7WQqEZpmBb8MybyZN8Bblp6ra
	 D5clBwp4LvYkD6DHcuD7nJou1F071SwF0PeAQ27l41oe/eO3T9lkd0GmwO/avleR+J
	 joJE86XVDtyosJ7MV7eeeeic0g4MOOMuPAQY3NAeuAmthG0Xvuo6vKWYkBUWDRfr/7
	 U0syTElKWJq4Q==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 30 Nov 2024 17:39:36 +0100
Subject: [PATCH 1/2] dt-bindings: power: domain-idle-state: Allow
 idle-state-name
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-topic-idle_state_name-v1-1-d0ff67b0c8e9@oss.qualcomm.com>
References: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
In-Reply-To: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732984781; l=1070;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=8kfXvaVq7Y3C1ujH0UYk3GamLfvEvQQpE+vDZPL0nhA=;
 b=xhiEdwL9ZYE/LxD4Nclcan2QZJFOf71r4fkEVb3vTGlcRpL3jEQuUZXr+jZXVqnMveUrDV6LM
 cww2gXssKKhCk7xImD3UCJvGSTKRXSS2+v5D28uLVSG8qaOeH2UbkMS
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Allow specifying a name for idle states, similar to CPU idle states
in cpu/idle-states.yaml

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/domain-idle-state.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
index ec1f6f669e50b2e7b0756cb6a737c685ad81045b..4dd4f59bbbec3058cf20f064aeec4c9602a99eb7 100644
--- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
+++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
@@ -54,6 +54,11 @@ patternProperties:
           (i.e. idle states node with entry-method property is set to "psci")
           must specify this property.
 
+      idle-state-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A string used as a descriptive name for the idle state.
+
     required:
       - compatible
       - entry-latency-us

-- 
2.47.1


