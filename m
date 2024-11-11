Return-Path: <linux-pm+bounces-17355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3519C48E3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404301F22A85
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A71C1F13;
	Mon, 11 Nov 2024 22:13:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC31C1AB3;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363217; cv=none; b=my8WYR2b6li9K+8NWlQfwI3hYHCBHbkaXZpHDjL7V87oUtMcuyiRVUvS8fLSjD1iU9YjLZn2BxEoyKdwKCmrsrOpQyKcPUepuiE6cuQ1uXYMmoDjV5uGPLpBm4qqy6v6K6YgxwIaTBh//xzR1Ijh9lF9Ythd1cRAUNTKd557xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363217; c=relaxed/simple;
	bh=+7im0tskn1DzuhFQoK4yd9NE1oGNi4Q3McpYioL+P00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lQy+6VDZ+W7mVki7/MR9qlmYawwCzGo0ARJxuUEfZ9Gxwmh2rvszIEnqIzIFZD+FXpYvrnnocr9Zm0cIGNa+564RBdOot3p9QjfS1l0TKMBowfTDs43nobIhmNunKlYZHSD256LjwLrX3j0Yp2nUTL7K3gj+PWBZf4ZTyLvwBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACBDC4AF0B;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4BD9B10604C7; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: ssantosh@kernel.org, Ba Jing <bajing@cmss.chinamobile.com>
Cc: sre@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20241025090659.33458-1-bajing@cmss.chinamobile.com>
References: <20241025090659.33458-1-bajing@cmss.chinamobile.com>
Subject: Re: [PATCH] reset: keystone-reset: remove unused macros
Message-Id: <173136321430.772650.12511690217528216433.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 25 Oct 2024 17:06:59 +0800, Ba Jing wrote:
> After reviewing the code, it was found that these macros are never
> referenced in the code. Just remove them.
> 
> 

Applied, thanks!

[1/1] reset: keystone-reset: remove unused macros
      commit: 7263d7df054e8b7759727d8fde62eca648189cc5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


