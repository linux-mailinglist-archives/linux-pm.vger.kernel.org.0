Return-Path: <linux-pm+bounces-10589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1A9271F6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722FE2859BE
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00B1A4F22;
	Thu,  4 Jul 2024 08:44:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E821A4F18;
	Thu,  4 Jul 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082642; cv=none; b=cCX8ScPDOKx4aLLTXZxToC8HE/u5lqP+3bW2VganBOA9GmjnBJouuY6tdKimzs/W6hncrcrhm4MWk2n1Z5NjTrVq0Ekt2vnoF24Loc/v+KCxPEOq3gC7UCjk95lC90QEWKALvSmBYjw9FXubngymg2PzLb0ambI6Dohg92WdFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082642; c=relaxed/simple;
	bh=ml8Ph9tcpxzO2gOeFF6ZniSip1ZGbuU31/37mtfxOfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OAlF1fI7Uii+M7oF4o9C/FPZz1XZgLffx1ZXYR/9l7lKNnJiBPzDzI1UDo2mmi3pP8E1iF51auOzfJfh7bN7Rlpg5DvP3iD9MD+Ct89irokLltBTeRFxQ/dX+A3RT8c0amxzLPA+dTYBBHdNpQ0yEmgIsKpx9MrxZkNustCJmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F3C32786;
	Thu,  4 Jul 2024 08:44:01 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4FE4010605DE; Thu, 04 Jul 2024 10:43:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>
References: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Enable battery support on
 x1e80100
Message-Id: <172008263831.67267.16225018456120387684.b4-ty@collabora.com>
Date: Thu, 04 Jul 2024 10:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 21 Jun 2024 10:16:35 +0300, Abel Vesa wrote:
> The x1e80100, being a compute platform, provides functionality for the
> exact same power supplies as sc8280xp. Add the compatible and assign
> the sc8280xp match data.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Enable battery support on x1e80100
      commit: 29832adac01a1057e89579c977ef4776623ee463

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


