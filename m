Return-Path: <linux-pm+bounces-12979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428E9613EE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312CC284A40
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2701CC150;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25491C0DF9;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775933; cv=none; b=O0UNsaod1dLyilnkLJN/g1JJckGB/3ib+7HivOcst1fZOQt7pojntKm05PG0suUAvEMYdS9ieRQuG8Cua4nWliZEVZu0FjgQu0GFNFcHgU3LOXRr0FADapZ+y2iE0joUXgpDzEjskdAnRooiszXd3jh5zaJ12jMAiNb7A81KVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775933; c=relaxed/simple;
	bh=4r4Mk9LVUABbaIqQckC5tl/SAoGXpVjIK37Vb+Tyvys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=duRIRQQOTlJEOVLJdzzQ8/e0OrUTZJCO/DODDkQ6sr7MOwFfWQJhRNrCc1LVZvaPW27yAGXakpmHzxtUkYlCSpmq/Xfs68AMW3hJMJYTXJHd/uT5gTQJMdY+xSDSVTS99evn61BymprPddHqagBBOama5yPabemV1EgnO03cnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8C7C8B7C3;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3150610604BD; Tue, 27 Aug 2024 18:25:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Andres Salomon <dilinger@queued.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
In-Reply-To: <20240820041942.30ed42f3@5400>
References: <20240820041942.30ed42f3@5400>
Subject: Re: [PATCH] ABI: testing: sysfs-class-power: clarify charge_type
 documentation
Message-Id: <172477593115.353499.16626853404367080768.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 20 Aug 2024 04:19:42 -0400, Andres Salomon wrote:
> The existing docs here are a bit vague. This reformats and rewords it,
> and is based upon the wording originally used by the dell-laptop driver
> battery documentation and also sysfs-class-power-wilco.
> 
> The wording for "Long Life" and "Bypass" remain the same, because I'm
> unfamiliar with hardware that use them.
> 
> [...]

Applied, thanks!

[1/1] ABI: testing: sysfs-class-power: clarify charge_type documentation
      commit: 919a4719026f68a9d6b5b87db2e935564cdf42a5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


