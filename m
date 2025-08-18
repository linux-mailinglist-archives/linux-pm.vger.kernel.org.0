Return-Path: <linux-pm+bounces-32532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F6B2A09A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13B44E10B2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B8147C9B;
	Mon, 18 Aug 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLltt4OX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE32E22A5;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516831; cv=none; b=V11OBgjPP97LGKJQ8XgUPQNzA2ujJxhBsb5OWExMCPJ3M0lqsTCrnkYUd2qXTGq/qA8eBKYU8094IF0YlFhL64jMvRpM8SwT6lhvxhP48ricb7q1xFI2A1CKnQcu87rg7EMCHFKBiqdy6NrF7Rgpk5RODMdCKzmp5YDMzXlG18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516831; c=relaxed/simple;
	bh=0qvPUlus7r6Zs9KuwNFJGjOWcSZWTtIx7LyRA1j0WC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDY8BX000UQS+dM0y8RcVIcclwd1rmQ+k22l0mck6QoYRUEM0uIKzk3u3njCno5E1WAj2hOpkgcnVneFgeDb7JWl6iN7z1gIeNLUJv6m0cRH1XtIs+3byfot4BtGvpEIVJ9izAOFMtTe91Sz7wbkWw9kqg5G71VfpQC3X6lFUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLltt4OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6009BC4CEEB;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516831;
	bh=0qvPUlus7r6Zs9KuwNFJGjOWcSZWTtIx7LyRA1j0WC4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WLltt4OXakKIZgqbaEuZhXPcZoQrDQXGbWcJHEI9vR1xzxQK2Uq+N7t4/dckVy+VP
	 gKG3ZB8V06HIfnGK6GIl8EFwDbGEcDkecvacMObtD4m3T++UDd70xAP5ZleFhs67lZ
	 xpybIY+gTHPvsAWWxiD/Az9jSp/b59VO47bZxH+pmbfsEF+A57FsQGqvIKb4tpatWq
	 JIOxIHrcmiXIR1UHE94FhUdFG24sYwi/CLc3qJbT+wRlgbwGTnxydSoNwfMKTwdPSN
	 LgU7SgxHxL/9U/UfdjeG4lO738xpi3LurRKyrmYou2tnOE6yJdN/mHu+0YcUZW01id
	 L4GdAhggEyJDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC0ACA0ED1;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH 0/2] Make standalone compatible for IPQ5018 tsens v1
 without RPM
Date: Mon, 18 Aug 2025 15:33:45 +0400
Message-Id: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkPo2gC/x2MQQqAIBBFrxKzTtBCk64SLSKnmo2ZExGId29o9
 XgP/i/AmAkZxqZAxoeYzihi2gbWY4k7Kgri0OnOam+8onRZLbwZI6uNXrU5HWyPDsMygOxSRsn
 /5zTX+gHQ7wF9YwAAAA==
X-Change-ID: 20250818-ipq5018-tsens-fix-f60d53e6eda7
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755516829; l=1421;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=0qvPUlus7r6Zs9KuwNFJGjOWcSZWTtIx7LyRA1j0WC4=;
 b=03TTmvYoMn9nFI1mQELD4NphPbJs+2XpT+x7zS14oVRnEQTArMGcmxD0tJsXSc3DHEBNFjDVl
 +6Iq6ZCfMCaD9ldazluYAnQtN7DTlrSwEu7eB/9Ew6WmYQjf8h3uc6K
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
fallback since it has no RPM and, as such, must deviate from the
standard v1 init routine as this version of tsens needs to be explicitly
reset and enabled in the driver.

Accordingly, update the tsens node in the IPQ5018 dts and remove the
fallback compatible.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Additional background: this was already incorporated in the patch series
which added support for IPQ5018 tsens initially. V9 was applied while
v13 had already been sent for review. In agreement with Bjorn Andersson,
I've submitted this new patch set to correct the issue.

I have taken the liberty to re-apply RB tags provided by Krzysztof,
Konrad, and Dmitry from:
https://lore.kernel.org/r/20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com

---
George Moussalem (2):
      dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone compatible
      arm64: dts: qcom: ipq5018: Remove tsens v1 fallback compatible

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 ++++++-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                     | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
change-id: 20250818-ipq5018-tsens-fix-f60d53e6eda7

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



