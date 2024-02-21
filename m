Return-Path: <linux-pm+bounces-4218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B485EC82
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 00:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9617128349A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0F12B168;
	Wed, 21 Feb 2024 23:05:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2612AAF9;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556741; cv=none; b=DXeVwGrVN2WK9GSMRzJtVksGY6c16sja8taT2j9K37HLnmGqZZZv3jgmKKQPxi+pxgoaTE443pq5MeRnVl6lKgjJSw+3OG/tVCVpUeSqbsfs8Q2dwBV5qab6CZD7zpekzXJY7qMnUA0QhAsJJVRohKZLRPZXvc8IeCtfVcuxcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556741; c=relaxed/simple;
	bh=bASWmqvbEFBpJC1TyrY8VYF3sgdRmslxhzR7CW00gsU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P2Fb+wBukdqjoN/DpxuQ3LUn0he5u6KvSeJgfbRaH2kwBx+aNU3SvYwJ/YiAt0LqeFU7sfohokjWTg48GF0/i0/uSn/JN9Y1bSyH/onccv304MlhlIrrW5iOAx3dlXVq/Uj6KD6hGUxUw8nMtJCUVm3/uKJR6CNzJyeWbiYzPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04B1C43399;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id D3455106B79F; Thu, 22 Feb 2024 00:05:37 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, wens@csie.org, hdegoede@redhat.com, 
 Guoyi Zhang <kuoi@bioarchlinux.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221083425.440108-1-kuoi@bioarchlinux.org>
References: <20240221083425.440108-1-kuoi@bioarchlinux.org>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Deny ROCK Pi X
Message-Id: <170855673785.1674060.17523775239548340307.b4-ty@collabora.com>
Date: Thu, 22 Feb 2024 00:05:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Wed, 21 Feb 2024 16:34:25 +0800, Guoyi Zhang wrote:
> The ROCK Pi X is a single board computer without batteries using the
> AXP288 PMIC where the EFI code does not disable the charger part of
> the PMIC causing us to report a discharging battery with a continuously
> consumed battery charge to userspace.
> 
> Add it to the deny-list to avoid the bogus battery status reporting.
> 
> [...]

Applied, thanks!

[1/1] power: supply: axp288_fuel_gauge: Deny ROCK Pi X
      commit: 9e6047c01159697cfd2f9b7788af9fe90fc7f544

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


