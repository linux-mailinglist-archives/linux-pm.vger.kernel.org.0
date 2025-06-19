Return-Path: <linux-pm+bounces-29082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C16AE095D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BA1C20797
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144A28B4F0;
	Thu, 19 Jun 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiRIjnJz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12627874F
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344922; cv=none; b=dUf1j4BiTFQa28hS6YYPuczx7lXjglZGLGD6EL7PBzZqmObxQqGU8ywHkLf4RLBr9Bsf5Z+Wr/3OCbQCQMnwhb9rYR1tcKBTTqF4+t51N+2/yUak5n2B079GoVDMFQOtbigYJngzeEZDEtUpCAZLccrZ2zv2X/mvMwgvvyX1VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344922; c=relaxed/simple;
	bh=qYAZCfZCRBki6rEwNto82MyVYrF2GEVO45R3Q08g/IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceh+fsUyBZIGhpKz/1W1R5lDrtC9/2URlzTyRgsvfQAR2/tNoKDw3WOojOkKCrzOj0dOJNkPGL1PYHMlDWtvU65lwYFDr0SKOU9p/kqhh333wrPBFPMF0AgpDYmrPbnL95TzkzvfkzL99C4ZXEDMxWE/OohQ4fXc9jvrg9V71v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiRIjnJz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so7857775e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344918; x=1750949718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6CcoGZqjD9+K1M8PYMMCHFJXIehGW4t5wpSeTmgCi8=;
        b=GiRIjnJzhPZYfgHcZwpnz89qiKvoMQrB2yAurdDj7rDgg33XvrOCFXIO9QFDYL2wEV
         N6KkwpYi+AtVZAh7NRXXw42faiHbmPZ8ecHdaoHsEGxcZGo4aMTE3ptQ0QhPM9ktX+rA
         aVCQSguZeKDD8EVUVNcuQ+ZWWYqN7MPO6llVi486H7VITLEJ46q7oU0aIYOz70I5ePmA
         aQ0N0+YaQuLTZGnIE7DRxEk7qxuNO6q9v8tFZOoxEDILoUM33yxoSHd4vGbui7x7y+L0
         jdDXCCoB6nkO9OZtE/u7gVOfihI331pAw3zC2Gb2IbvD3jhc27VgVlC25wDW66KGe27J
         ZKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344918; x=1750949718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6CcoGZqjD9+K1M8PYMMCHFJXIehGW4t5wpSeTmgCi8=;
        b=Fhcq83byDzOLNP6qSWeoiXMEj5XtCGC2oGhGqAdKr2M+vzkLQTKd+9pZuAqsggudFD
         U+L64GbZMDrNt2Bwyi2zbxpAI2/Mu+SmFGxOxeHpQh8jmLrG3KWRk3GwQ9J4FC+DLh1C
         94XTRsqYrFeB0rF19GkegZKqxSBBrba9atrtBPoRbdzbPxvJ9wcDZEtYryDQfqyfRAQh
         YTdQOwWlxudhue8j/7az4+dto2dLeHaAv+8OOEFIce33iOZMU9XFR4lVK8QRFAczR71H
         cKHfkie+1tODj8ZS10cj0DZo1VePbHeUFH/ftlJf2pdI1DDYdr31G5lXlWVExQ52YD3H
         q+bA==
X-Forwarded-Encrypted: i=1; AJvYcCX2cVBtWlEc/JUbXqDPxQAt3IFJA0LIEfX0Zl2hFuMG+nBN6L3o9bUebTFmRlyzjjZmbhpVqZo2pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvLkiSJ2ij1/fWm63R1wB4hawv6OeOq3rc+wkMNWQ10KAeBw3
	PebXv7m0blL7vqrJD2xk/L8e9YiPYBacpdd8JhsGBs9iq/E5oNj+iFqsl0pxU5hl2Fk=
X-Gm-Gg: ASbGncvT30LMpXgLO30ilzek+GcMZHqwz1SjrMeRFmIbRzl1fBwcbIQ32CVxW8dy8XI
	2d2dSr6o2X8w5zB7GaG+TXt4+FO7loHLLJhZnDuhQh2YVZgzdGoKCJ63a0qOYuMj0lPmgn4e0bb
	EgNKVTLddkQLT1zJoyH9IGpP8PGUsCHz0LD9OmjTljCMHUlDdbnKhvuaRAm9dXfb4CWqLtG+SRE
	AJqGR8+uiX6k5WLgVaqxf3orxMPapokkqSNgUEt3qlfV+MMHu8zGDRpmBGguqNDXPRNGOJyTG7v
	v5gZrBJr3j03a55wWkJ4y/Zx9fmuU/r+sufX1l7V8tY4mTjgKGnrKpIMEi+8TujkNYg+Lz6b83i
	9FlnHyJGS702dAj0XEMRvwA==
X-Google-Smtp-Source: AGHT+IHqn4tAEPgYc+nW6NOVxVDdxt9Vx+UOQZkFC9cJaTvzxaVLk2lXNPEErPPHH3ALfmNFXQfnFw==
X-Received: by 2002:a05:600c:5185:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-45359c2e6f1mr60408825e9.1.1750344918502;
        Thu, 19 Jun 2025 07:55:18 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:10 +0200
Subject: [PATCH 02/11] arm64: dts: qcom: sdm845-oneplus-*: set
 constant-charge-current-max-microamp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-2-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qYAZCfZCRBki6rEwNto82MyVYrF2GEVO45R3Q08g/IA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTRdzCeOVoOYYIZoWDgVhy/ZEc/+H7vHO3hk
 9+coi1FjLqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 tgjFEACJoBqzSyVmNA7Zpg0bF2fnP3tcsYhpkpKhB+GRT6LikucPsFc4ySsBumxIks0HruvV5ym
 XBTm07V2xs+PTsMWjllFWTGsObMoPxYJXR081gxtDlhCL0Ng/A5vFdsFHiYU0zn2vK+bqtZgemt
 oia+SFbIUf5a+/MB1cwJUrsjodgY+OUE3iR6nVvuqlz7CnVpI0TvXxqqSzpneGfC0zxHUMjrfSy
 f8aR1Cc7+iLLp6VqAV6AaIS1aGQkQPQYUFB77t2gk2sTs8ByeIm2fWP0UnxbaV7vd52naJnmi4r
 jfcbyvihE53AY7F0RYLzl644mwnj32/INi3C/qZsfaHJYRXFyQjsaxi0DV2eZQmn3Mqq8bbc5O1
 OqN8GqoHqT+N5BOhkEn/b+UAp0d4tHCW21o4FyqMsvlfAH+9GiPAZpMCfFLxdup8FHTn7cW4QMf
 Y8XOicvxAQentqPPUVhhOaZyB4mP0faVWN0IeA8tQHx4kQ6trbi6qeWb1fgNNJIFPwMPLBDDOCu
 R4c4jpKQIPEuxc2r7CYJe5jc+V77svrd454tJnurx2rlWNMFmONymTxnXftnaV3FYx/5Zr/uhBl
 Ha8Iv5nLMRjqDGEHTuFBDXLxDExoNqGOIaMTssY9bo9Em52vZCFs11E1HYXdcQ6TKiKFAo1/+qa
 GIVjesETp5LyJFg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Set the maximum constant charge current to use for this battery. While
the battery is likely comfortably capable of 4A or so, OnePlus didn't
include a secondary charger IC for parallel charging (instead they have
their proprietary Dash Charging). It's possible that this value could be
safely increased after some testing (and when we have support for
modelling the charger as a cooling device properly), but for now this
value is acceptable.

This is references from qcom,usb-icl-ua property in the downstream
vendor devicetree.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index 4005e04d998a40d25a64d652a526bf93efc20332..9ab5ddc1f6cbbdcfbf793b959d199b20256be9ed 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -19,8 +19,16 @@ battery: battery {
 
 		charge-full-design-microamp-hours = <3300000>;
 		voltage-min-design-microvolt = <3400000>;
 		voltage-max-design-microvolt = <4400000>;
+
+		/*
+		 * Typical designs have multiple charger ICs which can handle more
+		 * current but the OnePlus 6/T do not, hence the lower limit. This
+		 * does not apply when using the Dash Charger, however this is not
+		 * yet supported.
+		 */
+		constant-charge-current-max-microamp = <1800000>;
 	};
 };
 
 &display_panel {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 9471ada0d6ad8bd44cc58a6efa07f7eb27921af9..1644648fb8800934e4a8a9b54380bb019dcd0059 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -19,8 +19,16 @@ battery: battery {
 
 		charge-full-design-microamp-hours = <3700000>;
 		voltage-min-design-microvolt = <3400000>;
 		voltage-max-design-microvolt = <4400000>;
+
+		/*
+		 * Typical designs have multiple charger ICs which can handle more
+		 * current but the OnePlus 6/T do not, hence the lower limit. This
+		 * does not apply when using the Dash Charger, however this is not
+		 * yet supported.
+		 */
+		constant-charge-current-max-microamp = <1800000>;
 	};
 };
 
 &display_panel {

-- 
2.49.0


