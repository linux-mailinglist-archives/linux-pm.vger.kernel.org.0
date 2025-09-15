Return-Path: <linux-pm+bounces-34649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10EB57375
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC9E7A1969
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01D2F1FEE;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdo0Ux+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D22F0C5B;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926214; cv=none; b=eGezbd/yPqoXEF1bebWdLAdmQsRWBqrMQ/QzKOxc/IUWY+l5jfaRcgJSuev95Sak0s/kTg7U+3/PzVBHd5HgdlnBM4jyyoR6Z+9R/p6a7Qyxn9W948wrcUj7OskS5v5ICBG970FQ3CK9+z0FUTwwMLqa0ZkTn6b1VCde+yP42GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926214; c=relaxed/simple;
	bh=Yr+RgLN3Vap9mjogsRQGWKdmsM2xbbmuwitsD5UlBqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOmmR2Wk444Ri+4grZynQqubH6Rrz5TJPgea5FGSVAwfCYmKdzSe0RI5cd5p2sCmZCH5g2j9YKhYL4Sxb3eetODY2UUTVN1narXVHLJdWoyHccFcvfmqpEaQTpBMpG9DdywwdCvoYRVpmccF1L47+sWedhdMSkSvQ0pf+rNRPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdo0Ux+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08D13C4CEF9;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926214;
	bh=Yr+RgLN3Vap9mjogsRQGWKdmsM2xbbmuwitsD5UlBqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tdo0Ux+taQme3/yFpM4sPQkcWlQe9krUfsyNrDQf5iPGLYhASxre/qi/J/5t2Tmb0
	 B2A9lofOmonkSY/m0BmTOCybwCbhgrA6X/2Bqv1VhuudwRIbT7CyvGWBzJ9oZ6khfS
	 a6KbBdLdSsQO6vdxqC/M6nLOMnSpmWLiOY7/WA+n6nANVf+Na8Cu7Xn8sBFxFBnVCZ
	 vCtb5hA0WYwS9dmmQiOx8rnQM7/3QOmmHUoItqR2N6ez9g45iZdfZWBb9BKOL5epcd
	 3URF7QJV+3xCDNfCXAAkkSlyLYuej1fo0OBrAc9miG5zZzWHIqApDR0uOWVHJfFIy5
	 yK7Xpe21uj6uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D78CAC597;
	Mon, 15 Sep 2025 08:50:13 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Mon, 15 Sep 2025 16:49:53 +0800
Subject: [PATCH v4 1/8] power: supply: core: Add resistance power supply
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qcom_battmgr_update-v4-1-6f6464a41afe@oss.qualcomm.com>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
In-Reply-To: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
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
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757926212; l=2917;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=yLQp6yJehiZBpFT5IxDtU3pReZwpxFlv7BCVLt8iMb8=;
 b=LJsm57i6alMaYbJDGVtZlO8QXWyrUFYgdK16Fgaxp16LLryYwTupxARcUe9gxWSMDVewwjZQB
 kTmE4nLhA+YCAnRpkMUOVkN0voyaptJHzDvOAegda/bP3x74LXwy6fV
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

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
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



