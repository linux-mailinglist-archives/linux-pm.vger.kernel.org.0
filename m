Return-Path: <linux-pm+bounces-33028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF6B340D4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128397B041F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4E277C98;
	Mon, 25 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRYJrdOw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CD19AD8B;
	Mon, 25 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128767; cv=none; b=JO2SlY8D7+0pxAXXKUaAvOwX71eK70ruwfhNNNhvfl77RlSRCchdp1sfGzxQ7GgnI5JRKfzQ9iqKq1/4CsH7Fq5TVaHYVpRxh+bMz3kHbcB0kp66PZjZVx1YCoMEuCvl5B8CdMkai8kUH0iHlEMD/FnEB1ueLCD4ZLNyc2J0YfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128767; c=relaxed/simple;
	bh=THq6w3PKjfr56m2eQDDRBsBsd3GMJLNPQZxWHUtUNi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJ4ktYQKX+G6thiH0Nf1biqMrwe8Iwbad3OVAU/OqdUE1yxFVeNrhSRKAHcjteZL7iRuiYOameFnKNaXAZ3uzTN/hdTJk8v6er+hPDIti3Iiwd7HOrPIFgVtEsy8haoQThVBfSZ9EQOvoy47qVZGvN7gKlzab1/MAIUauELogB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRYJrdOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B9BC4CEED;
	Mon, 25 Aug 2025 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128767;
	bh=THq6w3PKjfr56m2eQDDRBsBsd3GMJLNPQZxWHUtUNi4=;
	h=From:To:Cc:Subject:Date:From;
	b=vRYJrdOwCKtlokNYH0dbLFDtJCMICR12WTxE94Y6dI+8k8hCPggZLuQiIYjyNCTvc
	 AfqfDpyeQLJvIvn6ajk5IDdBMZCc1bkQI0aDVZzNKPWKcidn2BDC1lQvzLh02wVa8y
	 dQ8fFzTCbTCmrzCNZBIpWkyNBAZLOBx8dOezTNNg/k3ajgg1koO8r1HeaFTCyJb3Yq
	 0g/NjlEX2Rfej99WsNNFue/AOM36W5m8uyOBs67nzDDSV8ns6ua8ii29WpMpztxBnZ
	 TNb4JhdXZz7kaF7kLxw6m1XXFf3NKO4OEjerGYVQ0+wE64U+ADuU9VoPGhfZH//nZP
	 LeROGBo6VCbFw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 0/3] thermal: gov_step_wise: Two cleanups and small adjustment
Date: Mon, 25 Aug 2025 15:26:51 +0200
Message-ID: <12745610.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series makes a straightforward code cleanup in the Step-wise thermal
governor, clarifies a slightly ambiguous comment in it, and adjusts its
behavior to be consistent with another throttling logic description
comment and possibly reduce undesirable performance oscillations between
high and low levels due to cooling in some cases.

Thanks!




