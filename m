Return-Path: <linux-pm+bounces-34089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4FBB477B0
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CF1B20F4F
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3527E1DC;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AB2882A6;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195110; cv=none; b=DRBnNXJ3GhdsXwXxW60hH952BBQd5DbxnlnS0SQx2Doz6OrNsbwPALjh6kDPAL3r/yu4ANG0xUhmIsN7LtCxr+uts/SV7tVFYqgzO3wBTr4ICtNnNR4XBZuUFkhQdH4s9GAoBnx9EBiOk504g6iHTi6j22PtknZnXtJaAkFaDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195110; c=relaxed/simple;
	bh=tEgLBDiugmDFzM8ru4MrsalYfA+8pFDUJRN7nQBXje4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e8+Gwg0eu5zvzJWAZL3U4PRxuiDDZhzfPeUGtY1Ozt9wPlC2f+j6f/RSMba9wPF6rs0+jxxCdDIP+fA5Z+nmIJWRCFC7oOUn1J32tTpsw1Z3boJktIrWvj8OHNB1cBBcuyO2ZQsqRpZMq9PBsMYfGtSxJHFRr/kcER6Y9RbPpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C486DC4CEE7;
	Sat,  6 Sep 2025 21:45:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C392C180B21; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, 
 =?utf-8?q?Miguel_Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Cc: linux-kernel@vger.kernel.org, sre@kernel.org, pali@kernel.org, 
 skhan@linuxfoundation.org
In-Reply-To: <20250724074133.33637-1-miguelgarciaroman8@gmail.com>
References: <20250724074133.33637-1-miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH] power: supply: bq2415x: replace deprecated strcpy()
 with strscpy()
Message-Id: <175719510778.45380.346556436821312161.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 24 Jul 2025 09:41:33 +0200, Miguel García wrote:
> strcpy() is deprecated for NUL-terminated strings. Replace it with
> strscpy() for revstr (local fixed-size buffer).
> 
> 

Applied, thanks!

[1/1] power: supply: bq2415x: replace deprecated strcpy() with strscpy()
      commit: 5afce048a9fa6de350110c7078e69b59f5cb3eb6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


