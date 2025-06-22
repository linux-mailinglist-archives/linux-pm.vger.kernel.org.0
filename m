Return-Path: <linux-pm+bounces-29213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68181AE2DAD
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE747A8AE5
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CC1B95B;
	Sun, 22 Jun 2025 00:55:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1DA29;
	Sun, 22 Jun 2025 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750553732; cv=none; b=PNLDriozeWuFHnbd3ENWiQssgc6nqGH6KIs/ar30DFP7ttjkqG+fcxg0bfp8lyfBlcl8BrKgHdjKO81ghlv59F4BnMkv1Im5Jx1L69tlOBAot48qT5dWrfDQjZQ+XXPDVx56ran4T7vryEvGxrukBOhAa13cqJr5LusvSNCcMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750553732; c=relaxed/simple;
	bh=KplRt0tMJoJUNdPg4WLjGzLZr4pGYvefd5cuHvarw/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4DC60m+hw1bsc6dXRpDNf4JhbQYvY9tf6yADKhdnnMUJhrJjZxDKhuySrAdFvLwWy1FLy+2AYeBFO5gym5/0KHvV1TwbS2CLDaf+AALMffND6xZTSBDaLkqe3coJB9xWFR9eZwr7rs26OrAhRw8Sjx/nGMXVy6VJBsDxmFk0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1E8C4CEE7;
	Sun, 22 Jun 2025 00:55:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 6FE351806CD; Sun, 22 Jun 2025 02:55:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <korneld@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528112328.1640743-2-korneld@google.com>
References: <20250528112328.1640743-2-korneld@google.com>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Report battery
 capacity
Message-Id: <175055372943.231368.2275498684959005372.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 02:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Wed, 28 May 2025 11:23:29 +0000, Kornel Dulęba wrote:
> Battery charge can be reported in several different ways. One of them is
> is charge percentage referred to as POWER_SUPPLY_PROP_CAPACITY in the
> power supply API. Currently the driver reports the capacity in this way
> on SM8350, but not on the newer variants referred to as SC8280XP in the
> driver. Although this is not a bug in itself, not reporting the
> percentage can confuse some userspace consumers.
> Mimic what is done in the ACPI driver (drivers/acpi/battery.c) and
> calculate the percentage capacity by dividing the current charge value
> by the full charge.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Report battery capacity
      commit: 3f87baacea4d185071655f9b0baf07abb6237fcd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


