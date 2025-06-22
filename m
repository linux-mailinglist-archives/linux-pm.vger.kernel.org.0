Return-Path: <linux-pm+bounces-29235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7D9AE31B4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9361890C00
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDA213255;
	Sun, 22 Jun 2025 19:13:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4E211A23;
	Sun, 22 Jun 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619601; cv=none; b=HadZ5znWjDHCmC0rXENrISnROoBclUQE1a+XhhdC56JcsqyxKi2CvfaSaDKUX2QDiQnWPcnpZWzcvAqVTwqdOtnmxYpz2uv6W0lSfka1SggrsEIBijZIW7yXTxKm2Fbu/c6T9w1DEUoO560k2jfHUACDG1kB6m6S6vRvf+a8cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619601; c=relaxed/simple;
	bh=+MmkIyg3HjqAvJmqJ4dmJYPqZZf+2gvj9zFRecLWDRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q0aJ/aWP4dJ1elNat0z6pur7CfVmV5UzVUjcqaSx4s5wE4/Zdfm1vXqIaMXPgzoe/1m3QhROZ1g25opAw2ovJbTw7Fb5MNVYwAlMAW35bOwPL0dZoX6nxz7uYaViuJRo3ccL6JMF1FzynfxeYHcedpu8duD3c5XzNIZt1LihgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ED4C4AF0C;
	Sun, 22 Jun 2025 19:13:21 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 643A718095D; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
Subject: Re: (subset) [PATCH 00/11] power: supply: pmi8998 charger
 improvements and smb5 support
Message-Id: <175061959740.285737.4989879198495034118.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 19 Jun 2025 16:55:08 +0200, Casey Connolly wrote:
> This series contains fixes and cleanups for the pmi8998 charger driver,
> as well as introducing support for the newer smb5 charger found in the
> pm8150b and other newer Qualcomm PMICs..
> 
> A bug is fixed where wakeirq enable/disable refcounting wasn't respected
> when the driver was unloaded and reloaded.
> 
> [...]

Applied, thanks!

[03/11] power: supply: qcom_pmi8998_charger: fix wakeirq
        commit: 6c5393771c50fac30f08dfb6d2f65f4f2cfeb8c7
[04/11] power: supply: pmi8998_charger: rename to qcom_smbx
        commit: 5ec53bcc7fce6801977a0c125fb726d7b0e9102c
[05/11] power: supply: qcom_smbx: allow disabling charging
        (no commit info)
[10/11] MAINTAINERS: add myself as smbx charger driver maintainer
        commit: 4deeea4b07414e7dd766005d8e28b1ef878cd417

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


