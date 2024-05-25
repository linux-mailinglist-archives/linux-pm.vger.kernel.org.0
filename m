Return-Path: <linux-pm+bounces-8118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A68CF07D
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 19:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB57281C32
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2986126F11;
	Sat, 25 May 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q41ndA5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0033A29F;
	Sat, 25 May 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659042; cv=none; b=VmYkuloCEsu4LlOe93BPL86vz8CCWn+SiKWhO/RO2EL13fzdgvVB617jS5pG0vnlyFMTdaUGGXvj47RfFL/5vBS6n3wxCKz3uMBI/T80S7vqYz5FMiDmTtKdsDMaFM3DuFE8aKWaLKc2H1fh5+Am8Y9KGhgVUwoMY7tYGVAYQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659042; c=relaxed/simple;
	bh=7fEBcBjsW4Wc0wk8NeBzK6jYtH4x5qqffjXR7Y2F8cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBf9V0uZGujONC0VWR1TqciHLiyNJReAs1T+CZdIcy9zzUIh4f4+Guj/gEYmhE7qYm3I6eCntAW/9TQbQcH4Emd3DvGyoAhGqzPiQwuPE1Bn9RNJZ7h07gQBQMrY4VlVaQdZJa9PKaSdXdEnU+msitgvBvSC81QCNmlA0O8kk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q41ndA5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3966AC2BD11;
	Sat, 25 May 2024 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659042;
	bh=7fEBcBjsW4Wc0wk8NeBzK6jYtH4x5qqffjXR7Y2F8cg=;
	h=From:Subject:Date:To:Cc:From;
	b=q41ndA5pAs4ZEw18sOoAy7C5bJLbowy/mhuY8v8NrTl30Dk12K754xsAFMExyxQ7W
	 a4+sqh+E266JnHbjgyq7G2qzGM2N9Ol/E6ebt9KcLoDm+I/XBI7R5v1BUpElfzRid8
	 4fgEZrFeU6PsuDfwnmOxMzpdUUdWaYGiS6+/KxoGKT9AZOKjwRAspCpkYml4efq/xp
	 YZnuFxTddhinZdOm2I/cBWyFNl4x4f8itdcCaL32pRWSt+VQqh14/rI51KxU0axa6H
	 uqV33tZzaDKoMwUjbiTKQb0/7LL1vzQJjSok/b1peXJL+rVt9aDZ+cuzplKBdgwNHQ
	 aVoahyuCW96sQ==
From: Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sc8180x: Fix CPUfreq compatible
Date: Sat, 25 May 2024 10:48:49 -0700
Message-Id: <20240525-sc8180x-cpufreq-compatible-v1-0-febf0f17909c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEkUmYC/x3MQQqDMBAAwK/Inl2IiZHoV8SDbjftQtWY2CJI/
 t7Q41zmhsRROMFQ3RD5K0n2raCpK6DXvD0Z5VEMWulWWW0xkWucupDCx0c+kPY1zKcsb8bOGGr
 t0hvnOihBiOzl+ufjlPMPrLr+GmwAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=600;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=7fEBcBjsW4Wc0wk8NeBzK6jYtH4x5qqffjXR7Y2F8cg=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmUiSC9S3DkydJiZWzLzoXANykY/bRID0Yog9fk
 B4Bw/JKKEmJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZlIkghUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcV4ThAAtKUde/TdjPdVVrhmP1yLZ2lwMpKlEFWko9y3xBR
 TZrzStsyeMSq2LCk1COA8Bb49Ys0n6fLTgwZempqqyTan2uQnOdchYhwmUPNIxEyH3KNN8R6ClZ
 jw/rE/JrNzs2p4EQEAy7PBZu10UQKEwmvONq63liNQg9PYPBy1GJtpfH8dnLdVi9BiAYiBYp4w8
 d7UXokbcFJnVhIc3zm++4AQJvofoZrcrMjiA7usByf8q8U47S2XDDeIPbwcYBujxySNevvALVet
 PJ7QUsTKGfcMBJwoNh6L6gMFtBtMLOfxfu0txmTa9fdu7VEZM6Q78GUb4tTosYn1vSceIKsIqWi
 +QyQkInbuAbLTGIHbXDBMCYkeu2DeiOIINf3LIoxtnPLYsVVKv8GGqfK+VllQiQsytibztKZ0lc
 zfAiC8whKRqOIua6ObyAIqw3zuDDyDaHkLhQ3tJwbt+f3uSFu6dqHHxOCb0qcCNxoPIjcee/V19
 ODpN8uZJuiD2Ok8V4J+zB58VvnnVE/PwXBBU8dbjagE81G7fJXry4ExX1rHAgcrIlV7NOFxkxdx
 ph5eInxmBlHQ6t0fCDCv24IZ8M/roXeF3klCWK/7b9PDR64RsPZj6j/+JFgVd1NMELr3SuIpPOv
 meYoJRA4CeX49pYpJMcF6EE5jYqc4NQPh8Y5/EF30Du8=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (2):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add sc8180x compatible
      arm64: dts: qcom: sc8180x: Correct cpufreq compatible

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20240525-sc8180x-cpufreq-compatible-633c45b93886

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


