Return-Path: <linux-pm+bounces-37273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB59C29B9F
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323CB18888DA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0622127A;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098F1465B4;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130920; cv=none; b=eGzjXYNHvMSzNEWmJJYmZ0274ebULNpCPQpyH5i+bWfg91ZbYMmvqbRE/Akrv9cWT13W5NrwJKECdp2ewMLqWWxqQvsFu2IPkxKfMSlWPuIVH21tgAlkwPWhEzFObWQ3QWm6DEPoL4zEromVniBkLSJs1A55OPMe88ZF4jABYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130920; c=relaxed/simple;
	bh=isE0bKuO2Ii2vUvPtrr2FUJLwfn0vdNCcKeYkFJGRpI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XXSGYEf7JjZfzdbX+bKS+/HG7/uU9l91ruWHS87fKTDYSbP4G/3zrOCTFmmSznTuI0wvNdWk30+YbVrOFkjOrr8XawI1rs4DYFWgBUOOGAicvKsR3dfh1kZYZnISeuo0jKENTZDCGYaat9a/K58rg8jNPFurTPqWM4iIu/furY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82214C4CEF7;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 61ACE1822D7; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Dhruva Gole <d-gole@ti.com>, Sebastian Reichel <sre@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20251014182008.823980-1-rdunlap@infradead.org>
References: <20251014182008.823980-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] docs: power: clean up power_supply_class.rst
Message-Id: <176213091339.301408.16694127979004667154.b4-ty@collabora.com>
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


On Tue, 14 Oct 2025 11:20:07 -0700, Randy Dunlap wrote:
> Clean up grammar, punctuation, etc., in the power supply class
> documentation.
> 
> Add article adjectives where needed.
> Hyphenate some adjectives.
> Fix punctuation.
> Fix some verb usage (singular/plural).
> Fix run-on sentences.
> Add "is" in a few places.
> Change "QA" to "Q&A".
> 
> [...]

Applied, thanks!

[1/1] docs: power: clean up power_supply_class.rst
      commit: 06b54f2d741b63e215bc941af4dcfafde3b1b327

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


