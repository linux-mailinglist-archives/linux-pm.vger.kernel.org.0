Return-Path: <linux-pm+bounces-11786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4109441BC
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3274C1C210EF
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179DF1494C1;
	Thu,  1 Aug 2024 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLaPU8qx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB745149012;
	Thu,  1 Aug 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482403; cv=none; b=EZjyQReZH95sEjb7KcSFwvDgfiLMCjf8OYCsV2eJheR7MZ7gk+fHsG8WYj4Nk7bnCAHXYicLizf0UqJLW9tKTtacbwZ6wV/DlHOIHEKWgYX/IDShDGbcMoqWATm41di83qfq8IadHasoNRrXVyPaHk4JvHyJ8xzEWkxtMkPLX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482403; c=relaxed/simple;
	bh=BvIdfDclaFLw7RpmEnVouQK1tmMNfr0+G9FNeexH9b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ0qNiIKTm8PlBA1vrqVqiIt5RA6g4mr7D4BJbiJF4OayNGRkGKLquxq3ie5TtV7V9bg1c5LKePSakQScof+2u8vOfYeOapfdoTJ58ce4romu4txTF8470roT6hcInvp8nYClyUDXLZ9KSowUvJYXk6zzUQjhUuvCvamAAReEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLaPU8qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0CC4AF0F;
	Thu,  1 Aug 2024 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722482402;
	bh=BvIdfDclaFLw7RpmEnVouQK1tmMNfr0+G9FNeexH9b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLaPU8qxHA3u+fzhT1R0k2gU2WZyt8+l7tTrivnC7aKHacBi/sT0132YIzncQoTAR
	 QZ3d11/n2WGaBq/Nf4kqOckVOUe97gOu85haofWwQ4MtqzbM2SUGKGgC9z7y6+eG0s
	 URdkX+86/PKiMhDiyUYBob9ol88UncUzHiE8zub2QMvR0P2TPCzJjFy4Of4WRWWIdc
	 d6y3NHKb1hrj+ciA78+aK2JUZH7qXcwvhwRKoRGEUTPkJ5SQl2j7UkrZxTj2DPXXxH
	 iWfkCEPuI2/BPRKzuGlm6bu6D9cjYSTxgAt0QnXVrChgx5HCNdWMVnKtasslAqXEuV
	 vPX3Hj26ZqIsA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Update Konrad Dybcio's email addresses
Date: Wed, 31 Jul 2024 22:19:45 -0500
Message-ID: <172248238591.319692.676661290519182446.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jul 2024 13:18:22 +0200, Konrad Dybcio wrote:
> Patch 3 should probably go straight to Rob's dt-bindings tree
> 
> 

Applied, thanks!

[1/3] mailmap: Add an entry for Konrad Dybcio
      commit: 72c93f3e0dcdc05fceafcb32e79352a45716d181
[2/3] MAINTAINERS: Update Konrad Dybcio's email address
      commit: fce6a1eefb2a1db706fa17ca21e3e7107811d2e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

