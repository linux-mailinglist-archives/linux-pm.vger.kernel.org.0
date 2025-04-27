Return-Path: <linux-pm+bounces-26306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F3A9E51D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC5C189205A
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D620C02E;
	Sun, 27 Apr 2025 23:27:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147001E9B06;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745796448; cv=none; b=t/Jx1TyyJ2jqWVZSAZhLiMzjswVFa2doNIaX0w5w037sCrAda4AxYNv22O9Nv71SmlrwPUGQHFhOuCnR+gPomJ1fgkvsOkH68xjJ4ieWw7HurRzL7GWu3Aj8WGXnWmD4IAaXa/SrMTXUudPyCGHgtMlg4uhVC6iFOzbkL3wETdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745796448; c=relaxed/simple;
	bh=D/dJ6yPFDK5tY8JrHM5ZOkMgJyHCRtnyS201gkIeU1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nTEzBTmfJG7nOSGZGzCaik3IKsxaPn++PhqSSdC4D4ZHAUn8nimZwqzeiHuOztVshaZveTc7PdZQPg2rwjerUbmUl0QjNlHRqTWs+t2oZ7rUx2Qsf3i9y5StKaXWv/UGEa/eCzrXDZqwaj6Fb2MRLv81yGROLieUysoL5kRD9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEDDC4CEEC;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 87C7F180F9C; Mon, 28 Apr 2025 01:27:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
References: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
Subject: Re: [PATCH 0/2] power: bq24190: Add BQ24193 support
Message-Id: <174579644555.306236.15284743421675195488.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 01:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Apr 2025 23:27:32 -0500, Aaron Kling wrote:
> 


Applied, thanks!

[1/2] dt-bindings: power: supply: bq24190: Add BQ24193 compatible
      commit: 6133b98d39e8bdb7c4d9211e9f00e9580a7d2d11
[2/2] power: bq24190: Add BQ24193 support
      commit: afe5301bfbaa0692811da3ba5f8769f599f7ff3f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


