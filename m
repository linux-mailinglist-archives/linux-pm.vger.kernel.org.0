Return-Path: <linux-pm+bounces-19468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00EF9F711B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A17B18845E6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF531FD7B3;
	Wed, 18 Dec 2024 23:45:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510831FD787;
	Wed, 18 Dec 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565545; cv=none; b=V4TqxGaJeOTen7FyVmH5tiHW0O/XwOKvF0jjW/fCOQ+1J+eIwpNTcJgXa3RTTexUW9aPFhJXE+DbRfVG+/OhPqL4gB64Pmz6RHtTYKbOpMqUwM4VhP0/lPiwMCDfcZya5BLr/9LukEK9POFyKEbJhcjwxXrAlCapL2oT5pSS1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565545; c=relaxed/simple;
	bh=lCzHtCOjtwY0XTrpCAWnnyssXMmi3Y+oL+pyleU8/d8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JnMcqDRAQ0P3FYL0yWsh7tEbv/spQVxeDPABYPRnFKcnqjnro8hdYnoPxNUFkqf43e9+VxFQwu5dNVn8ve1om/3irRWsCO39iW0L78pFiA8KkqzoNAGcOi3vD8lM0sAiV6YDu6yplWUjjapccJmD3zHY16Gh1i+8fszU3GuBrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB974C4CECD;
	Wed, 18 Dec 2024 23:45:44 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 220451060346; Thu, 19 Dec 2024 00:45:42 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: pali@kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org, 
 maemo-leste@lists.dyne.org
In-Reply-To: <20241125151321.45440-1-absicsz@gmail.com>
References: <20241125151321.45440-1-absicsz@gmail.com>
Subject: Re: [PATCH] bq27xxx: add voltage min design for bq27000 and
 bq27200
Message-Id: <173456554212.3125554.3346437097769274205.b4-ty@collabora.com>
Date: Thu, 19 Dec 2024 00:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 25 Nov 2024 17:12:58 +0200, Sicelo A. Mhlongo wrote:
> The bq27x00 gauges have an EEPROM register which contains the value of
> the voltage that should be considered to be zero battery capacity. Expose
> this to userspace using the VOLTAGE_MIN_DESIGN property.
> 
> Tested on Nokia N900 with bq27200.
> 
> 
> [...]

Applied, thanks!

[1/1] bq27xxx: add voltage min design for bq27000 and bq27200
      commit: 525f6a2c63e0958c25080e108a0cb7f8a3a23719

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


