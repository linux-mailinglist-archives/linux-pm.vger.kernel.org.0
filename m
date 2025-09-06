Return-Path: <linux-pm+bounces-34040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19821B4678A
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 02:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BFC5C2865
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F52557A;
	Sat,  6 Sep 2025 00:32:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D74C85;
	Sat,  6 Sep 2025 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118738; cv=none; b=QPzYhT1d7kMYFu/B3005W82HvU81LeOJ5IR/QwzHj8oLWySk/s69v0qghrAaoaVryPJ5RMTsCNDiSn/VobHNY0bBuErNgj5Yy3lKiE62znp3cdewfMTzSW4b33nNyKmqOMIBt5JW2BX0q25E6LcEeI73qSGdA2nM6EcsFG1i2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118738; c=relaxed/simple;
	bh=lcVjKSF6IcFbX9EhaMk/oI+e7enSsODOZFdLS41L8kI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VUwtG8sWNGxPzreBDYAM4FTulFNUcPn90YuvKUBhd/UH81Cy4GPF4tTjMzVPQscZyUTX5lMWRCaAWDMjisXWsWfX49cxdUtHmtdOUvDMuO1DNoLuJQ9U/kbmo7/ezQc8TqWj3oRQI6jxGZSanpfWr1tMbNJtU+UFFZ0hLeYC6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65BDC4CEF5;
	Sat,  6 Sep 2025 00:32:17 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E9AA8180B21; Sat, 06 Sep 2025 02:32:14 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
 stable@vger.kernel.org, kernel@pyra-handheld.com, andreas@kemnade.info
In-Reply-To: <cover.1755945297.git.hns@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] power: supply: bq27xxx: bug fixes
Message-Id: <175711873493.221416.40145614789398522.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 02:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 23 Aug 2025 12:34:55 +0200, H. Nikolaus Schaller wrote:
> PATCH V2 2025-08-23 12:33:18:
> Changes:
> * improved commit description of main fix
> * new patch: adds a restriction of historical no-battery-detection logic to the bq27000 chip
> 
> PATCH V1 2025-07-21 14:46:09:
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      commit: 2c334d038466ac509468fbe06905a32d202117db
[2/2] power: supply: bq27xxx: restrict no-battery detection to bq27000
      commit: 1e451977e1703b6db072719b37cd1b8e250b9cc9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


