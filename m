Return-Path: <linux-pm+bounces-20645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A21CA15916
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9D1684AA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF21AA795;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB51A83F1;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149757; cv=none; b=GknPCjkKOPl3Lxi5M34hNqexCJker8lBuoB7FewtUxTfKAuTKnvEhoRSaF4msD72vubX3nzfj1/lfbALtj9JDNUZLyy43AELlrwSk9/pM8PIg/lYNHaBWE4zaa5gcFtx8q3Cm2Jt5EXyvCN2ywu4f9cp3X+rmdqhBwq3zb/RrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149757; c=relaxed/simple;
	bh=c9R98bXyfUKgtuuqyFHG0av5YwJk/tL3jLpoP+4EnII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n2ZPpmscPfPIHpaSplpsArnkrwGf6uTIwCeiGtKS5N5LmR080/hu33v+kZBgWC/xYw/zKihTELyUhu3W4alRHeuRyVt8n4k/YsyZY7zZalJLS9rJGepuhQ0ppRyyz8Q51I60LXT2o5bgtuxoSba8/8gShIHdZTvXzeZV9wLAzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331FCC4CEDD;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 864C51060350; Fri, 17 Jan 2025 22:35:54 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>
In-Reply-To: <20250117024307.4119-1-kimseer.paller@analog.com>
References: <20250117024307.4119-1-kimseer.paller@analog.com>
Subject: Re: [PATCH v2] power: supply: ltc4162l: Use GENMASK macro in
 bitmask operation
Message-Id: <173714975449.629224.3927234471683738424.b4-ty@collabora.com>
Date: Fri, 17 Jan 2025 22:35:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 17 Jan 2025 10:43:07 +0800, Kim Seer Paller wrote:
> Replace the bitmask operation BIT(6) - 1 with GENMASK(5, 0) to make the
> code clearer and readable.
> 
> 

Applied, thanks!

[1/1] power: supply: ltc4162l: Use GENMASK macro in bitmask operation
      commit: 92c71aa1a8942057e228c09d37f8513abbab5fea

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


