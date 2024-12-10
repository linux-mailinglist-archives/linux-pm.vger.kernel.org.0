Return-Path: <linux-pm+bounces-18881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439F9EA489
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 02:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FA2282900
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDC74BED;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792241C64;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795697; cv=none; b=KKIoQpqrj046Yy0XsCKCj74ljw8HQ1aED/l+0wLjA1khCr1rycoZ0Fc8jHt1ghaeQjNq4+UhPV1/BL4TumwgpqlD3vPmpnr2I7sdTazmuoE92e8CG9D8HnZL+Kkfgj4rOMxnH8MgmTDx62izjp6VxOVPTSmvMB6zZmz2HQqVc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795697; c=relaxed/simple;
	bh=sXYSKIhuOY9ZOjFEn5L9V3d9sijcrMz82B+9AM5fY44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fvXCFd+0bGAaMAqUKeIByyF93tTrNk/2T8VyNXraILzfXZFatqPwMglLEvXh/ughIG5dCxeOW1Ijr2za3RoaA4HW6DA9VvmYwqWgzvxYIrf23etafPJK3sx8s0IuKJ6EEBCva1JaOcrS9qHMLgA+OLAz70lCqRnBZubmmFzW2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC5C4CEDE;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4F89A10604D3; Tue, 10 Dec 2024 02:54:54 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Thomas Koch <linrunner@gmx.net>, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
References: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
Subject: Re: [PATCH 0/3] power: supply: cros_charge-control: three fixes
Message-Id: <173379569430.1843885.17567948668257115971.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 02:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sun, 08 Dec 2024 15:59:25 +0100, Thomas Weißschuh wrote:
> Three fixes I'd like to get into stable.
> These conflict with my psy extensions series [0],
> I'd like to apply the fixes first.
> 
> [0] https://lore.kernel.org/lkml/20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net/
> 
> 
> [...]

Applied, thanks!

[1/3] power: supply: cros_charge-control: add mutex for driver data
      commit: e5f84d1cf562f7b45e28d6e5f6490626f870f81c
[2/3] power: supply: cros_charge-control: allow start_threshold == end_threshold
      commit: e65a1b7fad0e112573eea7d64d4ab4fc513b8695
[3/3] power: supply: cros_charge-control: hide start threshold on v2 cmd
      commit: c28dc9fc24f5fa802d44ef7620a511035bdd803e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


