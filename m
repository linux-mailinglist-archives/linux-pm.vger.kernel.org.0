Return-Path: <linux-pm+bounces-34696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DBB5868D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8214920307D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923027BF93;
	Mon, 15 Sep 2025 21:17:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C331D432D
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971036; cv=none; b=W2kMpZH82mbgh9YK6ZwzS93voSgmNcWxrq8T7CmGgCzJAooQ5wC97BAd9IowE5O2aLChXwhWEeQnPQIHg2wnlgcqzg+qzTVi6Bmr/ifQZj4DyD+JgI7YArQAPUVRd6YEskmyvR/2X11YlBubsmYcwubgzSMMz9EZY+HWlr9Jjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971036; c=relaxed/simple;
	bh=gXCWyByCp24Eoi15PufGVJKP5wUCPY5Xis+epuol0xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VsapNTL9n55gNS5sr1x87XStbyOtEp/40bnflL0541Eg6V0BR1ffA/ZLS4R+XlgpUTlGfcShLVZJcutz0x9ImuqxZc5OU0DWDZo6I2L4ankAbfqRMkuRAn+OG/BWV+ShIOTYl0Wj9ifmhO8LwYZZe4v2juNCcdaZ8UvaqjDawis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31523C4CEF1;
	Mon, 15 Sep 2025 21:17:14 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 12FB6180BBC; Mon, 15 Sep 2025 23:17:12 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20250910140754.334597-1-hansg@kernel.org>
References: <20250910140754.334597-1-hansg@kernel.org>
Subject: Re: [PATCH] power: supply: intel_dc_ti_battery: Drop no longer
 relevant comment
Message-Id: <175797103206.366484.8046359560298967480.b4-ty@collabora.com>
Date: Mon, 15 Sep 2025 23:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 10 Sep 2025 16:07:54 +0200, Hans de Goede wrote:
> Drop the comment about not being able to use devm_iio_channel_get().
> The code has actually already successfully been switched over to
> devm_iio_channel_get(). This is just a no longer applicable left-over
> comment, drop it.
> 
> 

Applied, thanks!

[1/1] power: supply: intel_dc_ti_battery: Drop no longer relevant comment
      commit: b8cac8c98e85e977369a4c07b5eccd73fbc30cb9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


