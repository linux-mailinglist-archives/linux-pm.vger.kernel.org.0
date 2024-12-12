Return-Path: <linux-pm+bounces-19159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFB9EFFD4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4879A286C44
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8E1DE3AC;
	Thu, 12 Dec 2024 23:09:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A51D7E5F
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044951; cv=none; b=Yy0LxApfkWxbjWlJu/NKZAMsULvcJQSfM/VCp1LOBhmHZVxIVg5lqFXhJrdpQgLXobM2LSylfBThZeQWKHDnQAWuDovfKZUEhg1VkFBoK88rfc8OKceUnhoI6ocITX+DCcGBNi0zShl6Cl27LZvhQPA1+PngQJo509nWqL/pWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044951; c=relaxed/simple;
	bh=g+06jDCHq9L1qJrmQOcEJWQaSI9V0Ynda6q+KNvCmYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=InqYJIqX6gXXTVBVsoFYRqh8mxCocZVrFnnjwKByDHdlHl0QJ86cfPcX4/dzglZbTgFg9OGNPLnl6n/sxIBxvxcH5pNMN0/YsJ3dqJtsf/AcQ+Jem3SIN55CV0yEBWidIjJPml32T3++LdKVwpHnbXK6RAgInBfrFMD4Ojl9gqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE90C4CECE;
	Thu, 12 Dec 2024 23:09:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A7A4B10604D3; Fri, 13 Dec 2024 00:09:08 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20241212130456.580197-1-festevam@gmail.com>
References: <20241212130456.580197-1-festevam@gmail.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: Clarify the warning
 message
Message-Id: <173404494863.2565720.16754478958437933185.b4-ty@collabora.com>
Date: Fri, 13 Dec 2024 00:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 12 Dec 2024 10:04:56 -0300, Fabio Estevam wrote:
> When gpio-poweroff fails, a WARN_ON() is triggered without
> an explanation to the user about the failure.
> 
> Add some comments explaining that the attempt to poweroff the system
> via gpio-poweroff failed and convert it to a WARN() message with a
> bit of context to provide some hint to the user.
> 
> [...]

Applied, thanks!

[1/1] power: reset: gpio-poweroff: Clarify the warning message
      commit: 8a1c099f36b256c8203319313f65666ce0043fe5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


