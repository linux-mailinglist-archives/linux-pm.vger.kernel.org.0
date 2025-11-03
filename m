Return-Path: <linux-pm+bounces-37272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A7C29B81
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784313AB3FE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34F22068B;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094A86329;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130920; cv=none; b=VpqI1WSjJhaHGgnOyNbG8KEObA9zB3ou5QLwTjDJmE4KMgaCHhi/Cn907q73zUOQEYzvAvJISell/dZWRQv6EJe7PbAxbAfdRedjkCQFamtvobNMLKWAqXnuxaY5u22IHGZyXcv6+dIbCdZmMFXPF67C2R7GsJOoONfyDLggXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130920; c=relaxed/simple;
	bh=BZsrRdPraUWXnOVX6LT0rZV7p4D0gXlmeCc65dsR0Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lSqSaEhhL1snfHiLTpRHm1JHEwYXy5sPv3iBjYvdpAe2eXgo4Y5ed29KVKZitPEIV+UB/M0GxuhkdTKHgys4DhCJ7TnK9zGEsvJn6h5XgLUA87vFvMgp7EwBOFL/G3YdSk1yV/tiKmzB8pqX9TT76z4ta6AKkLycQ39f+hAtX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D02C116D0;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 53AE818157C; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Lee Jones <lee@kernel.org>, Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, patches@opensource.cirrus.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20251009170553.566561-1-i.abramov@mt-integration.ru>
References: <20251009170553.566561-1-i.abramov@mt-integration.ru>
Subject: Re: [PATCH 1/1] power: supply: wm831x: Check wm831x_set_bits()
 return value
Message-Id: <176213091333.301408.13978622275399193894.b4-ty@collabora.com>
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


On Thu, 09 Oct 2025 20:05:52 +0300, Ivan Abramov wrote:
> Since wm831x_set_bits() may return error, log failure and exit from
> wm831x_usb_limit_change() in such case.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] power: supply: wm831x: Check wm831x_set_bits() return value
      commit: ea14bae6df18942bccb467fcf5ff33ca677b8253

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


