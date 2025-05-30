Return-Path: <linux-pm+bounces-27837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41322AC8916
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742BA3AAB34
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DB21ABDD;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j47fnGaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D4218593;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590541; cv=none; b=taHeXPhszon55YvRHvGAtS7/qdX5o94hNQKNbbR5MP/Lj92Mu4Uisuq5+XRKxA711FzFa+JCM4jtJ3bep0RCoAXd4UfEv7zAd6NV/iauH73WFN7uDhB2LhjFvCIbdV/dDdUPB9Bsi9xzIFMjcrkYXx7VhE3q8q8cCy5fYGMTQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590541; c=relaxed/simple;
	bh=afGsXEqvsvUx6dNiyYpACh3eo2vwjeQjj8YJlik3MOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ali2UQcoGxaLABgnwEus6q2pqtwV/69NAS2s0ja1mku+BqN9SQxdfKcR6Or9hgEppXqgEMh4uMEDzxJw0gFNVdbtGDiisXx7bLypy4aqQmschyfII2mPYqBjb/H2ekKjFqzFQtAhDlAc4gb+z5uFWp0EUIOHNB/d4zdHfhi6UVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j47fnGaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B3F7C116D0;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=afGsXEqvsvUx6dNiyYpACh3eo2vwjeQjj8YJlik3MOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j47fnGaIUH+DmWbVKztvE/aXSd0NIaX+K5BAg+0pNv3MEU27WC1CYtXJFyxbQNxG8
	 MLQkxUI1POYBbSNDGuhc8TC5NgxK89ecpnZNdbcUWCQVOZpCKiSxFwKHAKE0rGEPYW
	 aV01EIT2ey4uFn59inlstYJfFiC52JoA8y9j6lPHkb4QBF899ygBRafJvkmuvzAZkW
	 g+32hO6cvbUUknT9UgVahhdeY9N1MQ5BQrG+gr9h2zntHuoGYgPTHzntwIITAzzblH
	 ae8X/7tbOW8ZNyRCxOh1XAOshPFd9CC2nsSn5JJqF9e+t87cJuo1ZhPjStgfKEJzex
	 Sd+dvnsJe2pEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CBC3ABB2;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:12 +0800
Subject: [PATCH v2 7/8] usb: typec: ucsi_glink: Add UCSI quirk for X1E80100
 platform
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-7-9e377193a656@oss.qualcomm.com>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
In-Reply-To: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=1276;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=dQg6k1rH9JeZXOd77cdrsXXp+gDn3BfTbsH0eA2Fx0g=;
 b=+o52O9eawEr1KHvmULpL518x3uwspPR7DvcCFxkditKBT9yEqBpOgmpddijryjSaQaI42Y3LB
 BiUARQyzPpoCa+Z+QChCpTW9IFtdCmlW/ZUJQj/vHkn1c2MFMb7ccWy
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Currently, the Qualcomm X1E80100 is treated as a fallback of SM8550
in pmic-glink support. However, the battmgr driver, which uses the
same pmic-glink compatible strings, has implemented charge control
functionality differently between SM8550 and X1E80100. As a result,
X1E80100 is no longer a fallback of SM8550 in pmic-glink support.

Therefore, add match data for X1E80100 separately in ucsi_glink driver
but keep the UCSI quirk the same as SM8550.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 8af79101a2fc75ae17be1d119b25a9c862e010b3..b10c3161fd577f672d15602023c1aa71a1ab4fe6 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -319,6 +319,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
+	{ .compatible = "qcom,x1e80100-pmic-glink", .data = &quirk_sm8450, },
 	{}
 };
 

-- 
2.34.1



