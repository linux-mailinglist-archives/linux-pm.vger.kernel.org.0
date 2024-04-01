Return-Path: <linux-pm+bounces-5748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505B8939B4
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2577D1F21057
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF310A25;
	Mon,  1 Apr 2024 09:45:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CD10A08;
	Mon,  1 Apr 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964746; cv=none; b=qQTdbNBCbFKkNermbpbJIe0jTw0F4+uO/fEjDCenJUSjnz5Ad+WP/EmsRrhqOM2RYVAafjBImYJSVdomyudIC28lnphjwreqSvdb0f7ymCr0ICTo036qvIQNvnWwn+CRyHOH6NYGOM11dIj6IRj/ZDkPmXxaUiXz/T7XXPEsoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964746; c=relaxed/simple;
	bh=HnxaRR8Qh6oIgPXtCGGkjdfE0SP1GkShwa/Ef3nlBeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lge2om1y2JYTEupxoN+JLWItZWcAYFHcq55SPZXxtnCKgy5b+raBw7AHzU/HK6xZ6yKncn5d1Gn9a81D0NBYtY0EWN4sPpXMyYvu0fF+rZGoWIoqZ2EkkmwLfLmBTyda/aX6MSE1jnhCtNtDpos2/fqS+9wCbd3Q+j79fzX0T6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71FFC433F1;
	Mon,  1 Apr 2024 09:45:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7473910608D9; Mon,  1 Apr 2024 11:45:43 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org, 
 brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org, 
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, pmalani@chromium.org, 
 linux-gpio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-pm@vger.kernel.org, krzk@kernel.org
In-Reply-To: <20240401030052.2887845-1-tzungbi@kernel.org>
References: <20240401030052.2887845-1-tzungbi@kernel.org>
Subject: Re: (subset) [PATCH v2 0/6] provide ID table for avoiding fallback
 match
Message-Id: <171196474344.569294.13803698083094246561.b4-ty@collabora.com>
Date: Mon, 01 Apr 2024 11:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 01 Apr 2024 11:00:46 +0800, Tzung-Bi Shih wrote:
> Inspired by [1].  Turn all MODULE_ALIAS() in ChromeOS EC platform drivers into
> proper platform_device_id table and MODULE_DEVICE_TABLE().
> 
> The series is basically looking for drivers from:
> - `struct mfd_cell` in drivers/mfd/cros_ec_dev.c.
> - grep -R MODULE_ALIAS drivers/platform/chrome/.
> 
> [...]

Applied, thanks!

[3/6] power: supply: cros_usbpd: provide ID table for avoiding fallback match
      commit: 0f8678c34cbfdc63569a9b0ede1fe235ec6ec693
[4/6] power: supply: cros_pchg: provide ID table for avoiding fallback match
      commit: d6486a13665e9df5b503a375e18226e1824f21d3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


