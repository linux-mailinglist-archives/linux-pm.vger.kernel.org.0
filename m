Return-Path: <linux-pm+bounces-37855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 631A2C53783
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDCDD357190
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4099F342527;
	Wed, 12 Nov 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAQ5iKSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756F33E368;
	Wed, 12 Nov 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964786; cv=none; b=rQLB1A4ZYfQAe3cwuo7VFNbi0fLPCF280BxS+S1T2FBeF9g3IPfq//aaV2FAX4VAe2zF7/xHU0RQ28Lrx5NYPVjHf/dsMs1DHFHZW2dHhMPaxMBLj+bFRMkKF1ImGF4YLNJ6A/OiVoKI23AqC8PoEUFlM9hmVyeGvK+20tp/lPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964786; c=relaxed/simple;
	bh=uCBxALbNUhXQ4oQ9mCkAXPtvLHVevsNx0VEs1jaILwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qv8/i9gMGa0yhDV0Uwofi2mgjEJQKnlAOeOaomWRzB/IpTt29222TQO0PnDPZipsuVnv0NuzjszGejoXqRYtb+7tcY10ijob8gbyP9rJgNrNai/AJRYAj6Ww/88Xg8ew5wbAq28TkiZlC7csZbfL363pnxnZHKBS//oQcHaIrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAQ5iKSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2662CC4CEF5;
	Wed, 12 Nov 2025 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964786;
	bh=uCBxALbNUhXQ4oQ9mCkAXPtvLHVevsNx0VEs1jaILwo=;
	h=From:To:Cc:Subject:Date:From;
	b=hAQ5iKSqy6mWZFe5a7NBoj3uxQP/veL2+Q6Abr6aJ7Qq7RsTYlj8BDIvTvOc7NXTg
	 CACUE1wS1j8xXdU2Q2dDkIW08zglbGPw1HpXHhXTIFm45ZcC7mKmEy/3jRxUZd33i/
	 5phWYPP56AfyT4oypO7uPSAEYPt4X0+nJf73K7iyN5HA7VGntGfqzF3x+FP7gNGK7I
	 9ksrGXYpMB9K1mjyGNrNeW161665eaXyEE+YpfYv1Xg5at/d4zrT78HMAhDqfYEg+Q
	 55dDQHd2vD/QFm/ucNGX+fHwryxApWHL9fWyTNvSCtUO+BjfyGoRKlvuOapxAjib6K
	 6PB/MeNhmIDDA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
Date: Wed, 12 Nov 2025 17:21:36 +0100
Message-ID: <4701737.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi,

This is a bunch of teo cpuidle governor improvements, some of which are related
to a bug report discussed recently:

https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com/

The first patch fixes a bug that may cause an overly deep idle state
to be selected when the scheduler tick has been already stopped.

Patch [2/4] removes an unnecessary function argument.

Patch [3/4] makes teo_update() to use s64 as the data type for its local
variables more consistently.

The last patch reworks the governor's decay implementation to also decay
metric values lower than 8.

Thanks!




