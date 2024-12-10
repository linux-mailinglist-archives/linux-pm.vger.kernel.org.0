Return-Path: <linux-pm+bounces-18874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1959EA3B6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007F0165696
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E599F9E8;
	Tue, 10 Dec 2024 00:37:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078533EA;
	Tue, 10 Dec 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791027; cv=none; b=W6MDO1yhj0tdpxBxJtQ8zdGhljrPqGO3r4H/ngeDQT68AaUo5oL8iQiYPsjkzxTe845ZzER0nB0PML5Ei4FwbCj9lHiH+LI3wclx9uZB9gEpdKCRqLI75gCZdfSa5at6nNDTqP1WjWrRU7v78vIwrc59zqNQoj5P7fxQxv9DW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791027; c=relaxed/simple;
	bh=o7BIPFBeDFcFthkhPIPQiz8IhNjBAYStvC+iUSxB/4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GCFzAxAz0nNjupEyOz0HCARRzjXb3jcJ3zoDNnoHjvUYgwz2QJCQfEGAHHs+dXYUMIduxuN8h4FQgbX8o+SWlL0uY/yh0DUUM1dD8SpmtZHgpPz/QYispNGd9Qc1WbUpVzg2yPJHUGLXaNr1XIYHDeez84hSv8aLLy8p8hd4Heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B79C4CED1;
	Tue, 10 Dec 2024 00:37:06 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id D65A410604B1; Tue, 10 Dec 2024 01:37:03 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Kees Bakker <kees@ijzerbout.nl>, Samuel Holland <samuel@sholland.org>, 
 Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20241208131532.1028581-1-csokas.bence@prolan.hu>
References: <20241208131532.1028581-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] power: ip5xxx_power: Fix uninitialized variable read
Message-Id: <173379102383.1830962.8233966690071975448.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 01:37:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sun, 08 Dec 2024 14:15:31 +0100, Bence Csókás wrote:
> The check for whether a charger supports the requested
> battery voltage was incorrectly added to the
> `ip5xxx_battery_get_voltage_max()` function, instead of
> `set_voltage_max()`. This commit fixes it.
> 
> 

Applied, thanks!

[1/1] power: ip5xxx_power: Fix uninitialized variable read
      commit: 94ba531bf9cb3c4ef725ffc37b8ed09006533f25

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


