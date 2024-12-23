Return-Path: <linux-pm+bounces-19655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24BA9FA95A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 03:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484B9164A7D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2418052;
	Mon, 23 Dec 2024 02:28:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E217BA0;
	Mon, 23 Dec 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734920898; cv=none; b=SlzKMeSe0nsIY6XpLSC2tlu/N5Kt+h8QnrdlSHY1P2/HdSOQRlGWzln3ibBpvLw36L2cEA5FBqebbOXCjePKw8j9RYsralMFygoEiFKeIL/mVhSfmzoR4lEcKoHAJudMLJvgXIimGU812aBA0CjCLB+XQBxDJEXVTNWqs/Rvm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734920898; c=relaxed/simple;
	bh=2JBmvsW8lP2Yp1SrsquYnBlMcck8k862/OzKGpWuH5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f4aVhV8Z3jSoUS53z2YRhwzT0rOMEGZLVHb+Y0guBPLW7XWsINl9/I+rlPYx9iIj0m+CyUbH4Z9qcT4eVBBF+8ml6t3G7mu+jKkfETuJCopTn3lJ6A+41h5QCa8RK0f2fLbdh4ojTAWIbYvnath6ygJMW+pU4hi7rT+oUdnpI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2621BC4CECD;
	Mon, 23 Dec 2024 02:28:17 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 44C9A1060349; Mon, 23 Dec 2024 03:28:14 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: pali@kernel.org, linux-kernel@vger.kernel.org, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241221161124.114989-1-absicsz@gmail.com>
References: <20241221161124.114989-1-absicsz@gmail.com>
Subject: Re: [PATCH v2] power: supply: bq2415x_charger: Immediately
 reschedule delayed work on notifier events
Message-Id: <173492089422.3439488.12502109449683759046.b4-ty@collabora.com>
Date: Mon, 23 Dec 2024 03:28:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 21 Dec 2024 18:10:23 +0200, Sicelo A. Mhlongo wrote:
> When the notifier is called we want to schedule the worker as
> soon as possible. Thus it makes sense to reschedule any waiting
> work and only queue a new one if there is none.
> 
> 

Applied, thanks!

[1/1] power: supply: bq2415x_charger: Immediately reschedule delayed work on notifier events
      commit: f6945d52ee5346900fb7251ec23d34822a06918e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


