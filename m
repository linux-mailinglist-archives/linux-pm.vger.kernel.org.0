Return-Path: <linux-pm+bounces-34931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFDFB823A6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5844A7A34DE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D642831065B;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8E2820DA;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150220; cv=none; b=R8AlTSu5hWXlWQ3Z4LapmL7LaTdDtDtWlIcGaQJkc+P63vUyEHMVBHPmJVn6WPboBTIjAlriFJnsYh/vnfJ4luqRflJkqJq90SSK+6+4Jq5YEQwN1MyParysiOSn3XtvviDeUfLIvYTN+gn/DQFac1233fU2Hy44eew3RLPGVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150220; c=relaxed/simple;
	bh=Zo/Ay+2cH68lkGb1JUgQaKyyVRAeZxJc/f6BDBEWERM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pC4pHCc+luxfPlPEdq/n+/q4IVhWVe4buE9dWMAxzgsOwdRFiG0sX2guN9RS0GT845DKYA868+jlJ98b9OCnPfLMSOmIJQT+9LbuiOCNDoAo+yeqxAR2wFZThK8e9iBMa3iGbMeRMBD0w9cLkGHkFij375oY//rMCRU3mxXGlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344B9C4CEF5;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 62C0B18067F; Thu, 18 Sep 2025 01:03:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/9] power: supply: Add several features
 support in qcom-battmgr driver
Message-Id: <175815021839.129824.15553934022652541389.b4-ty@collabora.com>
Date: Thu, 18 Sep 2025 01:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 17 Sep 2025 18:15:13 +0800, Fenglin Wu wrote:
> Add following features in qcom-battmgr drivers as the battery management
> firmware has provided such capabilities:
>  - Add resistance power supply property in core driver and qcom-battmgr
>    driver to get battery resistance
>  - Add state_of_health power supply property in core driver and
>    qcom-battmgr driver to get battery health percentage
>  - Add charge control start/end threshold control by using
>    charge_control_start_threshold and charge_control_end_threshold power
>    supply properties
> 
> [...]

Applied, thanks!

[1/9] power: supply: core: Add resistance power supply property
      commit: d69ae81efbc95c94a2760fc82d27cdab4c26fe76
[2/9] power: supply: core: Add state_of_health power supply property
      commit: cd93fbdce5981c947f22015ded3ac6bd1939b0ad
[3/9] power: supply: qcom_battmgr: Add resistance power supply property
      commit: 45e57e6a213448f0b372f9cbd3f90f301f675c9b
[4/9] power: supply: qcom_battmgr: Add state_of_health property
      commit: b8e5030e09c11a47b7dadd28b492ec00b40a1b8c
[5/9] power: supply: qcom_battmgr: update compats for SM8550 and X1E80100
      commit: b3c0f651b3cf4dfaf2e8210d7bb9b79471f6403b
[6/9] dt-bindings: soc: qcom,pmic-glink: Add charge limit nvmem properties
      commit: 7f8624af8e8c2c1a0169b46a23729a4cc614635c
[7/9] power: supply: qcom_battmgr: Add charge control support
      commit: cc3e883a06251ba835f15672dbe8724f2687971b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


