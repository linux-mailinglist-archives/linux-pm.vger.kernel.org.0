Return-Path: <linux-pm+bounces-15907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6169A2F09
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 22:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FD51C21D16
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D021D31A0;
	Thu, 17 Oct 2024 20:51:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B28168BD;
	Thu, 17 Oct 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198302; cv=none; b=b0DePkAatBZpjXrrafLc3HqHWrySNCKh5B1E7SZZxvXDnkqtLoe3Q55l8/ZosJCWyy5XZ0/Q11U7q1+ijnhV5/pupDwnWug0kUyqIFTZgzHbVUZ+Xalgoy99JOGmVjNwncDWHMp/SlDZO4/asa67F4fH/3Ta6ef1WQ5PARB/pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198302; c=relaxed/simple;
	bh=atfW0BEM2RuDumcpgirlpBGZbgfhvp5s/rRBb8ZaW3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l6UeTVxBrYRGrlnXnxjp5JA63yTqjhPsvlE813rcGmiFfx+JueisC7wVUJpoiQn2J4ZXkiTsL0sices8ok3JUCJvddh4+zVZYhcs30b4rXxC3sIkDPsuWjIN+FAnS9u9sLZFBwatlnpv144JbJESVkjSX8GjtTIGKgSEdJ2JmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF162C4CEC3;
	Thu, 17 Oct 2024 20:51:41 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 573931060455; Thu, 17 Oct 2024 22:51:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241017-power-supply-cleanups-v2-1-cb0f5deab088@weissschuh.net>
References: <20241017-power-supply-cleanups-v2-1-cb0f5deab088@weissschuh.net>
Subject: Re: [PATCH v2] power: supply: hwmon: move interface to private
 header
Message-Id: <172919829929.724644.17917626159091636122.b4-ty@collabora.com>
Date: Thu, 17 Oct 2024 22:51:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 17 Oct 2024 06:37:33 +0200, Thomas Weißschuh wrote:
> The interface of power_supply_hwmon.c is only meant to be used by the
> psy core. Remove it from the public header file and use the private one
> instead.
> 
> 

Applied, thanks!

[1/1] power: supply: hwmon: move interface to private header
      commit: 44fcc479a574a4055fb6aed1f786d39999466383

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


