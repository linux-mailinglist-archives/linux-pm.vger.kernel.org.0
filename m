Return-Path: <linux-pm+bounces-26395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9EAA3AEE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FB47A776E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0026E145;
	Tue, 29 Apr 2025 22:04:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175CE25A2AC;
	Tue, 29 Apr 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964258; cv=none; b=MbVPoLucNhsKgJdal3VcmvE6zqdpxZ9hnUV1FKQBt8LO01RYZTJTFs1efV5RqzJRxfsaQyqNqYmKvdC5ldRLnluNdqi5yleEqihJdDLQEcAOVpScYisflKGeGYXwz2EZ6iVyinoc8Pkyulwj1uZMvw2ETREF7p9mX19SCp+jy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964258; c=relaxed/simple;
	bh=LMuwr0xPyFA3XbFlwFbJlYUUXbpeiaqwUvjjZy5yf4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NF02jriAmqXGasYoZLZqwZMk1WWl63d1SWe0qYeaUWqjzI9wyvhKlSBw64zM/zAcs/hFezNXqydx+G/S8eOjBeI9ZOs1iabgC/qFGo+1AXrO6zC1SMaIz6wVc0Kr5gfCNVc392fmSGzBbrVjb+WS9D0RMsFe8ABkE6REXV7gB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66482C4CEE3;
	Tue, 29 Apr 2025 22:04:17 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9C22D180D2B; Wed, 30 Apr 2025 00:04:15 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <aBEwnKtUOTYzS7C3@kspp>
References: <aBEwnKtUOTYzS7C3@kspp>
Subject: Re: [PATCH v2][next] power: supply: cros_charge-control: Avoid
 -Wflex-array-member-not-at-end warning
Message-Id: <174596425561.12920.2070259425381880409.b4-ty@collabora.com>
Date: Wed, 30 Apr 2025 00:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 29 Apr 2025 14:03:40 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Replace an on-stack definition of a flexible structure with a call
> to utility function cros_ec_cmd().
> 
> So, with these changes, fix the following warning:
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_charge-control: Avoid -Wflex-array-member-not-at-end warning
      commit: d4d2dc1b590c7416e1cf5fb6750fff2fa841690b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


