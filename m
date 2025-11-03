Return-Path: <linux-pm+bounces-37276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65BFC29BA5
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54322188F76F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4CC2264CC;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FE221FAC;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130920; cv=none; b=SZI5HUVGr9W0ooUDfr16iYyjLSFo91D3lHQYyyYJcEqLpSqbDh6OFjRH9h9lNIZgXEvJkOQWQ1zx3KQDj1Qr0Joyf0GJHcK1Xdo0T3bCIefX7Fvm07RDlPWX+vXh6WdjWh4QeiP53EEX6WLq601gSJWANFcWvItsO/w9h1CLPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130920; c=relaxed/simple;
	bh=DABp0fKEMg+lSEv60zNnxUCwpuY3JzvS9U8KBv6eSVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A3CppbhlZ6n3x/j2Mq0Ib2b/VzxL4X74gcz2sCX71MzKV+nYZFDakRdhQSoeuuZ0fLhIU02TudjBM/Kl+OSpH4kjtgLbTCeMXo9RaJzrF2ttOvscl/K9WSQcNMaLkVr1NaZBs0MBIIo1kmxYKZpGCYDbhC9d7cTC+yUil23B4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F30EC4CEFB;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 477301811F7; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Iskren Chernev <me@iskren.info>, 
 Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, 
 Sebastian Reichel <sre@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20251008133648.559286-1-i.abramov@mt-integration.ru>
References: <20251008133648.559286-1-i.abramov@mt-integration.ru>
Subject: Re: [PATCH 1/1] power: supply: max17040: Check
 iio_read_channel_processed() return code
Message-Id: <176213091328.301408.17011168216759468685.b4-ty@collabora.com>
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


On Wed, 08 Oct 2025 16:36:47 +0300, Ivan Abramov wrote:
> Since iio_read_channel_processed() may fail, return its exit code on error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] power: supply: max17040: Check iio_read_channel_processed() return code
      commit: 2c68ac48c52ad146523f32b01d70009622bf81aa

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


