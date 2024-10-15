Return-Path: <linux-pm+bounces-15690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CBE99F872
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6572861BA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B21CBE8A;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3941F80DD;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026086; cv=none; b=Xe1kmqZl1EE3V3jrau1HK97PMxoVHV59JH6W5wqMPtiXCD/OKBin/uJS4zyMDmYS38H40H6Ap4AGgBMoPvPptUmXfPz3o4mhk1gcnjUiWdCewhJkasXeUGWE9cqtWa58Ee17DL4k9nFw3yS6Pb/IZzqeGNj3jiidjvO7xpjGlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026086; c=relaxed/simple;
	bh=xarUmdbVzPfkkVn8qJpxRr/f8UXtfltD/Zh9VR4i2qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxSK0CnmsS04KM26yuBvDf/GVkn83eKQfmYC+AJ4tCaKD/2CbQ2L6QCkY84aIPHlsVIemhaJeH8s5GkMBkcDXDhpGb7Bej6Zoc5Tl14pgC/x3MGZ26URGnzrkb7usB+GA5hSZktIxsWKvwpqkpVAe1sPfPEBLEvuYEk5vdepYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C979DC4CEC7;
	Tue, 15 Oct 2024 21:01:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7851D1060447; Tue, 15 Oct 2024 23:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Kreimer <algonell@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20240912125303.44118-1-algonell@gmail.com>
References: <20240912125303.44118-1-algonell@gmail.com>
Subject: Re: [PATCH] power: supply: Fix a typo
Message-Id: <172902608348.467915.17200257005038972619.b4-ty@collabora.com>
Date: Tue, 15 Oct 2024 23:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 12 Sep 2024 15:52:51 +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> 

Applied, thanks!

[1/1] power: supply: Fix a typo
      commit: 24227455dd089b965e82cc5d2142c83f40529534

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


