Return-Path: <linux-pm+bounces-37539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850ABC3CAB8
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 18:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25C61883D26
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968134CFDC;
	Thu,  6 Nov 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9EEW1+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087C2BEFFD;
	Thu,  6 Nov 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448490; cv=none; b=aSWWphdOGEQAiXHsb+oB/uEbWOl8r0pPV7v0yVl8RCdgYQO6nTcfQHM0PlCmGAMdNJRLOgvUdyhSnbGcaziBlSUlxmS9TSJcSMkvaECHibdTvE8ues+OF1ss/5Oubr4g8EzmmPgQV8YYIUg0xzj7/WVsD8GHoIl8D2kLENgwkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448490; c=relaxed/simple;
	bh=J7xO/f4kJLNRCPcotB9OeBJW6lh9aFBrk8x0FbgwUjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UOKpXSJSLPz+gZ0ATG+BnbfGtewWfmy5avSgPhLYp9elESST3U+qmnuOgXTvm2Qg2FNBKkR2p2z5uWWWF5j42gxY9pxkIHvMXNROev0D1UJjHbV68NkZx4GZiJbVTVJmMy2wIwaHiphHdZhLbac6py9cCv4Ve/Eqrt0VHHlcqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9EEW1+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54163C116C6;
	Thu,  6 Nov 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448490;
	bh=J7xO/f4kJLNRCPcotB9OeBJW6lh9aFBrk8x0FbgwUjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E9EEW1+M0I62A5N5SNnFRx5LP7H5lCHyXtKMkd4bao/9oqiX63Q+8rDhHCWb8NaFz
	 fJwPtvNDqGCPxNhYg3IRTBdqPz4ucMFEkPqqdkbr9vhbAvBd19oVXP9lRY7lOuZT64
	 vva7cLHfh/jw+NUvCo+OM4w0VNChD0G3AYuLQ5ikfvEgI46sff6iYYH+0ugbpopD9R
	 FCCpms3e7ccYv3KTxGIbineLPvrPwGMC456/Wx+CRr5QpZkCGIENzp+/8SWqCW853r
	 tj0wtC2gPPc9s0fKNv6B4A0YjygtUNm2gZS3aCFpgnBtEkyuoVwFDcH55g/ganIYvs
	 QlYY0ZXqe3hAA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-pm@vger.kernel.org, Stanimir Varbanov <svarbanov@suse.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Willow Cunningham <willow.e.cunningham@gmail.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Jonathan Bell <jonathan@raspberrypi.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
In-Reply-To: <20250917063233.1270-4-svarbanov@suse.de>
References: <20250917063233.1270-4-svarbanov@suse.de>
Subject: Re: (subset) [PATCH 3/4] mfd: bcm2835-pm: Add support for BCM2712
Message-Id: <176244848608.1964097.10492891348357972327.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 17:01:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 17 Sep 2025 09:32:32 +0300, Stanimir Varbanov wrote:
> The BCM2712 SoC has PM block but lacks the "asb" and "rpivid_asb"
> register spaces, and doesn't need clock(s).  Add a compatible
> string for bcm2712 to allow probe of bcm2835-wdt and
> bcm2835-power drivers.
> 
> 

Applied, thanks!

[3/4] mfd: bcm2835-pm: Add support for BCM2712
      commit: 30ed024fb0768e9353f21d1d9e6960b7028acdfa

--
Lee Jones [李琼斯]


