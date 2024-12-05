Return-Path: <linux-pm+bounces-18591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337999E4BE1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 02:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E02516A8F1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17255154C00;
	Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CE13774B;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362615; cv=none; b=KKIrN5fVaPlekEjQ7vdXb+42sRUTZJ1w+2q1jjKyx0JghFb5ERniHWfPuVtoU6K5RohZijj63qyq8x89CAQBgGCzyLmNYS/uBTuXIQRaZ6XAWjy/T3pr6tXbGRJyai8LnzZBn56P36VX2WsWL2Y/TrJjsBefEIuWNE8tirqvq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362615; c=relaxed/simple;
	bh=8tssuylfPLPmr02Q+MVs43IA9KdONYdAu9ILMHx2j2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUH/CXuPxlHwXC6Z3ICmiliF2AMZPtN4lqX1vW594OoylExbmW402ImqWsd/TG+IL4E1FsRFYLj0PyVGu44+Smkyjqpr7TyHR4LYdtTPx/C9kBSEAQ2CbXzuTxo1TpWcqSBWwQRqDHc36/dCEfAWP5FSkImkF2Mfd2laB+QS7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7174AC4CED2;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 825781060501; Thu, 05 Dec 2024 02:36:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Thomas Antoine <t.antoine@uclouvain.be>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203-max1720x-charge-full-prop-v1-1-b02776b43f17@liebherr.com>
References: <20241203-max1720x-charge-full-prop-v1-1-b02776b43f17@liebherr.com>
Subject: Re: [PATCH] power: supply: max1720x: add charge full property
Message-Id: <173336261251.1429662.11650897169804550042.b4-ty@collabora.com>
Date: Thu, 05 Dec 2024 02:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 03 Dec 2024 09:04:36 +0100, Dimitri Fedrau wrote:
> Charge full holds the calculated full capacity of the cell based on all
> inputs from the ModelGauge m5 algorithm including empty compensation. A
> new full-capacity value is calculated continuously as application
> conditions change.
> 
> 

Applied, thanks!

[1/1] power: supply: max1720x: add charge full property
      commit: dc90aa3a72e624a3eb30e61d47c4c501006dfb8b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


