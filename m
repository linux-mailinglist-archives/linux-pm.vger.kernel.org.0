Return-Path: <linux-pm+bounces-4580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E186D8C9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 02:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24167281AF8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003ED2B9B6;
	Fri,  1 Mar 2024 01:31:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4598480
	for <linux-pm@vger.kernel.org>; Fri,  1 Mar 2024 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256716; cv=none; b=VXuoAa2zDaVOcccHF017aVbAPELO6wg3w82AkgCpXVh4VuyDKa7p0WhwRiTYNVmmQsto6kxYqOL54+cmq4gdEDB5uN7UQJr+/DYIHs4dk6fXso5YJO7NnXWd0WGUwjluQTHNES5uT/U4mB3bt9RLM4DU0/xORWGgreaTrBAh9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256716; c=relaxed/simple;
	bh=pyXcmSZsJKR9gkU0kEWgIu5N/VM48QtZG8lKVx90SZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l7d9rwOU5CMEJpZ8Q1HWWI+MShVkEY3SWYMIFd6BVqj4Q5MpkCPb86ZZ74jFiw1mlzEF8OqoEa8ZhH3MEsH1K19reXPFUWZnR02fxmIv0ARSGW85pVGpiF3gubAmfEKnR/HG7aoMB0U5rVx0l429QqJBagmJE9t8UuOmL3XgDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D0C433C7;
	Fri,  1 Mar 2024 01:31:56 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E98C610671DA; Fri,  1 Mar 2024 02:31:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: maemo-leste@lists.dyne.org, pali@kernel.org
In-Reply-To: <20240229063721.2592069-2-absicsz@gmail.com>
References: <20240229063721.2592069-2-absicsz@gmail.com>
Subject: Re: [PATCH v3] power: supply: bq2415x_charger: report online
 status
Message-Id: <170925671293.137755.6098201415575159258.b4-ty@collabora.com>
Date: Fri, 01 Mar 2024 02:31:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 29 Feb 2024 08:37:21 +0200, Sicelo A. Mhlongo wrote:
> Provide the Online property. This chip does not have specific flags to
> indicate the presence of an input voltage, but this is implied by all valid
> charging states. Fault states also only occur when VBUS is present, so set
> Online true for those as well.
> 
> 

Applied, thanks!

[1/1] power: supply: bq2415x_charger: report online status
      commit: 9a451f1b028e116d037a93bf13eb8f8620994205

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


