Return-Path: <linux-pm+bounces-21303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE895A25DFD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 16:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D381882F34
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144220896B;
	Mon,  3 Feb 2025 15:08:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168932045B9;
	Mon,  3 Feb 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595308; cv=none; b=adQTvWcjb8nF+IHf2SCsAHgulTiBZ0Az12sx9w/Ef9RaWcv8j7ipH6PKhZ2csXT4g4x8npf+mr1mIVUHVZPJN3aaSpmGE7QCDxriYVHoYGQSi7vk6IH9KfW1AuV6EGx59FLth0qASX4UpN2zc5IXmc7DyBLGYlS5qSWnXAkY5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595308; c=relaxed/simple;
	bh=hlSMwfXy7A2+SPz1/wooREjB1oNT+yXRln1lGbCW/g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G/rmxYitSLe62gKoPcg8+rZhv++UZpnHCSXU51yqp9JQFVDdr0cpOiG5/Yt9nmJwykQWI9rB7SGOZaMKrINw755BVOy2wO32+V7dslQHn7gdoz+TmmOs++Cj9RfxADV6m0kwxj1Zk0to18Up2b56FefcVR8GP0PXc4xSTDjs+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4872FC4CED2;
	Mon,  3 Feb 2025 15:08:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3C2211807D3; Mon, 03 Feb 2025 16:08:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 =?utf-8?q?=D0=92=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BF=D0=B8=D0=BD_=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9?= <a.vatoropin@crpt.ru>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20250130090030.53422-1-a.vatoropin@crpt.ru>
References: <20250130090030.53422-1-a.vatoropin@crpt.ru>
Subject: Re: [PATCH] power: supply: da9150-fg: fix potential overflow
Message-Id: <173859530421.32012.2111021401031509145.b4-ty@collabora.com>
Date: Mon, 03 Feb 2025 16:08:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 30 Jan 2025 09:00:34 +0000, Ваторопин Андрей wrote:
> Size of variable sd_gain equals four bytes - DA9150_QIF_SD_GAIN_SIZE.
> Size of variable shunt_val equals two bytes - DA9150_QIF_SHUNT_VAL_SIZE.
> 
> The expression sd_gain * shunt_val is currently being evaluated using
> 32-bit arithmetic. So during the multiplication an overflow may occur.
> 
> As the value of type 'u64' is used as storage for the eventual result, put
> ULL variable at the first position of each expression in order to give the
> compiler complete information about the proper arithmetic to use. According
> to C99 the guaranteed width for a variable of type 'unsigned long long' >=
> 64 bits.
> 
> [...]

Applied, thanks!

[1/1] power: supply: da9150-fg: fix potential overflow
      commit: 3fb3cb4350befc4f901c54e0cb4a2a47b1302e08

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


