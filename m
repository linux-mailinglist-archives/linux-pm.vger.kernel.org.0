Return-Path: <linux-pm+bounces-33083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A7B35529
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F0716648A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A9284678;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcq/DQT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E623C4FF;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192717; cv=none; b=k69/3IcPvOZYLtAoI2skLn7SAzAS0YpnSOblhqWmM74fc66ltFjvwtGFCPxRDq4eGpAEcahr937bafAj/T8KbzqRVMBD+M69NncVGCj6KC0/XX9C/hUIfn7k1YIw5ief2XJBIzaG/fgw+5DQUzwFOHckkC/sckggwofiYz3ZV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192717; c=relaxed/simple;
	bh=NUKM72dsQsPVocfi0VrAIryfe6vjKQ5F2Pt17V7EWkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JapDg/eHTWiZQK5rposCtHrAWT4aN58hep6XAqClKQYDXSvIndeTvwFBRNvzOnJV7eY3mYM+YEGe7sLhpOnwH53atxAYIgvdoUHykxMNfRnOUsOJ7nBx/bYWabSj6PJTWvLcmfz2YVpvYIOHo1UU0EvVmRxWH75vxU0no+GJCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcq/DQT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A2DCC116B1;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192717;
	bh=NUKM72dsQsPVocfi0VrAIryfe6vjKQ5F2Pt17V7EWkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bcq/DQT4XuOQ8neh50cO8X+10jM07CnY1pyhf03XWcRL+8EwQ9S+Ch96a64tRS+gp
	 laQmU96KAZJst7jYFyduJ1RRU7jmbU8lmZRWI872cnzz6KiKXpRS6lKeRrnsFQQPm6
	 NPuj2+1233Iegs99z/oJMTFM5g/XFwRznvccac7H+A7yq+am8tcnMXMlJBsgZIM2/M
	 33Yj3giT8I2Rsj5wUp2KPs9WxMPeQdtUapHprpxlAi1DV1EkGFhFWwsLed35U9ppO/
	 b3VcZjI367/V8/hqbVGsX71ojIMtuow3p3skj+SEWCTSbZZIjdlUKIgTYTMYAkJUiw
	 s7fINKNaGST1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F43CA0EFA;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Tue, 26 Aug 2025 15:18:28 +0800
Subject: [PATCH v3 1/8] power: supply: core: Add resistance power supply
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-qcom_battmgr_update-v3-1-74ea410ef146@oss.qualcomm.com>
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756192715; l=2838;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=PTxob4cVzRUR26yIMTWBec2QDLrpnnMTw9w6sqWmfeM=;
 b=vDJfRJYXvYAXw4lynpDhyRefJSwonykdYgRnQ2Q2FfWC0d4lKHKW2FI7M440YNbvibJsLRcoL
 lQEFnSpVfptAiMDlNbT0f4hqlQLfnjE4oMHxdWV4Zwdxj8H0uXpocJb
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Some battery drivers provide the ability to export internal resistance
as a parameter. Add internal_resistance power supply property for that
purpose.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-power | 16 ++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 560124cc31770cde03bcdbbba0d85a5bd78b15a0..cea1a38f5a8fb754d4e6323967ef6cf2e20a68ce 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -552,6 +552,22 @@ Description:
 			Integer > 0: representing full cycles
 			Integer = 0: cycle_count info is not available
 
+What:		/sys/class/power_supply/<supply_name>/internal_resistance
+Date:		August 2025
+Contact:	linux-arm-msm@vger.kernel.org
+Description:
+		Represent the battery's internal resistance, often referred
+		to as Equivalent Series Resistance (ESR). It is a dynamic
+		parameter that reflects the opposition to current flow within
+		the cell. It is not a fixed value but varies significantly
+		based on several operational conditions, including battery
+		state of charge (SoC), temperature, and whether the battery
+		is in a charging or discharging state.
+
+		Access: Read
+
+		Valid values: Represented in microohms
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a438f7983d4f6a832e9d479184c7c35453e1757c..cfa8f90a88ebc8fc1c7447198f138e5d2e699e5a 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
+	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c4cb854971f53a244ba7742a15ce7a5515da6199..8bc3b7a67eb5693a16db9b7d123e7881711c6bf4 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -174,6 +174,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.34.1



