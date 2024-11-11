Return-Path: <linux-pm+bounces-17357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C469C48EA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B0284E09
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714D1C6F6C;
	Mon, 11 Nov 2024 22:13:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDF1C68BE;
	Mon, 11 Nov 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363219; cv=none; b=TXIf3fZqLDYOovA+v5RTylKAqOT5TxlPvKmLljbUGlw6F2mTmiPzitnygmGJhjBr0qYCUFj0PzVNIKHwdoFnTXylKZOGx5gB5G03yz3H0d+OsJuHcjmJrB4zWSpVd6m0AODTcoej9BJz+XVT22hjuE0npeccwR0eoGNcFdqDEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363219; c=relaxed/simple;
	bh=97nWfcAIU0VqIBIdgOWurwIr1Yk+zNUVdbmATKkNE0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T9txYL4O+6zY7cP/dDDknDslSCI8FGatgyuZvPo2/JGcmWUqYwLMxy4EQB0jbcHiTjbzosYZ3aUmtWv8p0buyRzNhokUqCZPyX5wv26S5p47bENkGYryCvuxINNVnjqtpBT9px9tP7ne3hkPKl9XLvmFpyAtXx5CYX1T6j2hX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC0C4CED8;
	Mon, 11 Nov 2024 22:13:38 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5E20810604CF; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
Subject: Re: (subset) [PATCH v8 0/6] Implement vendor resets for PSCI
 SYSTEM_RESET2
Message-Id: <173136321437.772650.9632330958815794111.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 15:38:24 -0800, Elliot Berman wrote:
> The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> reset types which could be mapped to the reboot argument.
> 
> Setting up reboot on Qualcomm devices can be inconsistent from chipset
> to chipset. Generally, there is a PMIC register that gets written to
> decide the reboot type. There is also sometimes a cookie that can be
> written to indicate that the bootloader should behave differently than a
> regular boot. These knobs evolve over product generations and require
> more drivers. Qualcomm firmwares are beginning to expose vendor
> SYSTEM_RESET2 types to simplify driver requirements from Linux.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: power: reset: Convert mode-.* properties to array
      commit: 05d9044177c3e910921522e0209640d3b825a6ae

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


