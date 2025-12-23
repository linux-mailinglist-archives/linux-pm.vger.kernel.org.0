Return-Path: <linux-pm+bounces-39838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A369CD91BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8EB3034A2D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB28330B29;
	Tue, 23 Dec 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfaVu8by"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886B32ED50;
	Tue, 23 Dec 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489295; cv=none; b=TcW6js1Iw83Xd9c/yKK8Dv4uQBOsBSmM/yuvY3c15n6bDZVTL/LBaJO2PRqj3UWkjKG4zj+4zmmHrDL6PjsvKkMWtjDi/pGYAo9TDdSSAGZdsI4QAgguWAPVQHYnQKyho0Tt+hhJQvCGui80Wz677H6IiXNxL4S4FCpff0mExAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489295; c=relaxed/simple;
	bh=rdyBmgwaG/qEmPVoOSmwIO0N2ecEQV7lL40s7NnmKi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=noKZoUoVDQuxdhCBGexjEvCMTGhzloS7VberYzw6tCbW0/dMav8KaKmA1Cy3sC698PBTKEU4kDESZvdBrqfXt7p81aO7WelqhLX/3sbcmvTT2qAGee5jpkqqMV01ooiIHC+MhiPeG/WO6L0vsWJ3FVdnyiiG4a+A5GfoxileOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfaVu8by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BC6C113D0;
	Tue, 23 Dec 2025 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489295;
	bh=rdyBmgwaG/qEmPVoOSmwIO0N2ecEQV7lL40s7NnmKi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KfaVu8byt0YzmwiPotEf2wnkhAaM52jN3z9YEFRZ+QC2eczG0fH/RYCfQ3w/or04O
	 WCrOLOhVnXK8TKtMej/aWV1EO1bsh5MoE0a6k+GNYkzVU4wCnF9l4FaD+mpdaUkYng
	 DBslroDFPUYJiTIJimKyLg5KVUCTc+30wSbgmKp6oF5YeHyhj99bXri10gMiTh81CD
	 XtRMV0yOwneWtrkznTOZg7a4qlKzQ3YAG00rfKg5Gj2vm4xKHXVYV7JHIMEyYHP8rK
	 y7UeR6iF/HLG2uG9PINtnjlGymMDCx8ykvxV6qqZaYzx0ym60Z9s+2vckEctwzOhQe
	 HHNjYDkltA5Dg==
From: Vinod Koul <vkoul@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Brian Norris <briannorris@chromium.org>
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Subject: Re: (subset) [PATCH v1 00/23] PM: runtime: Convert
 pm_runtime_put() to a void function
Message-Id: <176648929390.697163.17518732693625217339.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:13 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 22 Dec 2025 20:48:11 +0100, Rafael J. Wysocki wrote:
> This is something I have had on my todo list for some time, but it is
> kind of tricky because the return value of pm_runtime_put() is used in
> some places all over the tree.
> 
> Nevertheless, I think that it is worth doing because the majority of
> users of the pm_runtime_put() return value are at least somewhat
> questionable (in fact, IMV the only legitimate use of it is in the
> USB core where it is included in a debug message).
> 
> [...]

Applied, thanks!

[21/23] dmaengine: sh: Discard pm_runtime_put() return value
        commit: b442377c0ea2044a8f50ffa3fe59448f9ed922c9

Best regards,
-- 
~Vinod



