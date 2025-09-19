Return-Path: <linux-pm+bounces-35023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB6B892FA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77D8586415
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC473093A8;
	Fri, 19 Sep 2025 11:06:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9F19755B;
	Fri, 19 Sep 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279973; cv=none; b=MzefXoX0uAEYkBVazbZkNtibbHn0rZZgc7ZjShfEwGK2zEwZlMgDSAM8ObcsOGe8B6N/Tg1YTN4JkPRi7S/ujM5ipAC1M+mAY55rM+8oU0tydHWDddhYvgGr/O8NcmbM4DmYhuRklOju8OjAO6Vfk3S5pN3HgIeZmcxVa0T59o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279973; c=relaxed/simple;
	bh=y1cOiK5WYv4FOuw4lu59oKTNO+GXg7K9GS8y/iGGcaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YtMfvo2ScQWd53xt7vrt3zzR4rEBslVOyF2WtTCsyrJLixX62PIuZMRAo4J/lHdLwG/Zgt00qZI3NY6t21kZAzQXzWSnOarmbG/qix3hAS57XFEy/+Uq+bS07rRUuNLQ70M4M6YN/ke0BcnWK+7DZ7a648KQ3Vbi6U2FN126IwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D944EC4CEF0;
	Fri, 19 Sep 2025 11:06:11 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 836011805C9; Fri, 19 Sep 2025 13:06:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: kernel@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
References: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/2] power: supply: Add several features
 support in qcom-battmgr driver
Message-Id: <175827996951.33558.9078630116788204768.b4-ty@collabora.com>
Date: Fri, 19 Sep 2025 13:06:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 19 Sep 2025 11:18:49 +0800, Fenglin Wu wrote:
> This continues the effort of updating changes which haven't been accepted
> in patch v5. Including:
>   1. Add nvmem cells for x1-crd device to enable reading back charger
>      control threshold.
>   2. Add handling for notification 0x83 to avoid unexpected error messages.
> 
> Rebase the changes on linux-power-supply.git@for-next
> 
> [...]

Applied, thanks!

[2/2] power: supply: qcom_battmgr: handle charging state change notifications
      commit: 41307ec7df057239aae3d0f089cc35a0d735cdf8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


