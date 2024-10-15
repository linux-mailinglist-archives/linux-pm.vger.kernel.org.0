Return-Path: <linux-pm+bounces-15691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160699F873
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA531F22A84
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D11FAF02;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51B1F81AE
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026086; cv=none; b=tffUszvaJ0Z9p4idm/i4y9Oe5pRMCqwUeop1504Q6WSsIkB58L2DsvSONH8QgSLqJ+ubEPi05qbQsewMVsY0xmXxn2UhobNrA3TgX+IiDSzYljfyzyJCXCSU3CdAwYKeOYmTfwO/+hqSYglbwAeiHq77Vvh3wX3ILJ7bsX/qCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026086; c=relaxed/simple;
	bh=X8VxlrF95bHg1vXinTQLkCSFCRZx2w+VJvKpebozsiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nL98lzm9E9E4Stgv+vw2dZtF7Rb01EM6HFbo5VYYWEnMUssOyN9WvRD5KOwGiDHzjsOiqwlqPmBiQtakP12/Pn9oi2iJq9+iMz9IE9TagN0L8hfWzjhJHE51aWw/PK7xOEL5wfHj8CY+am4ZAf0XNOWkveyDZTab41at5nlbYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C1C4CED1;
	Tue, 15 Oct 2024 21:01:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 701BC106043A; Tue, 15 Oct 2024 23:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-pm@vger.kernel.org, Kyle Tso <kyletso@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240917193914.47566-1-bvanassche@acm.org>
References: <20240917193914.47566-1-bvanassche@acm.org>
Subject: Re: [PATCH] power: supply: core: Remove might_sleep() from
 power_supply_put()
Message-Id: <172902608344.467915.10870231038524401450.b4-ty@collabora.com>
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


On Tue, 17 Sep 2024 12:39:14 -0700, Bart Van Assche wrote:
> The put_device() call in power_supply_put() may call
> power_supply_dev_release(). The latter function does not sleep so
> power_supply_put() doesn't sleep either. Hence, remove the might_sleep()
> call from power_supply_put(). This patch suppresses false positive
> complaints about calling a sleeping function from atomic context if
> power_supply_put() is called from atomic context.
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: Remove might_sleep() from power_supply_put()
      commit: f6da4553ff24a5d1c959c9627c965323adc3d307

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


