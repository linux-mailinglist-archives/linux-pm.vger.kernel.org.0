Return-Path: <linux-pm+bounces-37267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51075C29B72
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4F91885FF2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C717C211;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9486329;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130918; cv=none; b=SD3CxX5e+aSFl+7N/YdqXNebe/i2sKULLzI2ut0rZfQW0ogo/EXipiJxOgvaMUzqYsHoGnqxbKr55fuiVczESdCkjkedrpdVM+9LlRc87AUDj0Aq+2ErF9zwMLzaK8jvQw5WKllPI5pls1OCfoIgnDVbNWMgI6dxrEs+1cc8UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130918; c=relaxed/simple;
	bh=lRmNRXW79BJacRZiBSLo6rgqKBbUGx6eh1YWYDJmvUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d26yK2y8w4j0pGRLC6RFn7EmBq4R8fUZYf1YqfB+BCnY6BnzLhoidCGMiMfBj1swFPZL8TR0epZrh7U5whBUx2EjCUDhRHog3NYmtzHgN/V2ZW/grujTM9vVkkGgrwlimiGDoMRO+j3ESEImNnmxqrRaHsyF0r4Pu5tlL7h3uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D415BC4AF0B;
	Mon,  3 Nov 2025 00:48:37 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3F434180CC5; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250929113234.1726-1-vulab@iscas.ac.cn>
References: <20250929031536.2274-1-vulab@iscas.ac.cn>
 <20250929113234.1726-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] power: supply: rt5033_charger: Fix device node
 reference leaks
Message-Id: <176213091325.301408.8119254276502287887.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 29 Sep 2025 19:32:34 +0800, Haotian Zhang wrote:
> The device node pointers `np_conn` and `np_edev`, obtained from
> of_parse_phandle() and of_get_parent() respectively, are not released.
> This results in a reference count leak.
> 
> Add of_node_put() calls after the last use of these device nodes to
> properly release their references and fix the leaks.
> 
> [...]

Applied, thanks!

[1/1] power: supply: rt5033_charger: Fix device node reference leaks
      commit: 6cdc4d488c2f3a61174bfba4e8cc4ac92c219258

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


