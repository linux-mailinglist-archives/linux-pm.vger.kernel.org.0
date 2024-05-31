Return-Path: <linux-pm+bounces-8485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13938D6613
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F00B1C23341
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EC155C8B;
	Fri, 31 May 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roE13c5z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9B5381A;
	Fri, 31 May 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170640; cv=none; b=cAOzhj0fY9ImaG4iIUkUtTcjqAA88aDZ+B6jcFrZ6chetCox5OEn/BXJK0Ik35IQmgellG6NhMwvkZ7d54zYxOYPABzojALUvfES0b5G6lMa6xQzTIG1nzbu4XXdIIrJIrscEM3uKpoC71m4KV9XnQzQXaWhgYM5FqPgsXl1NUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170640; c=relaxed/simple;
	bh=MCmwVa1wcRv3eofxqF/lCaIC6Z1beutYiATzgaWsP7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IL6c6pcpIx2j98eanHU4WqoDP/TANUeR8u+qn0l5qpOaJDXOOoO/I3+GAYBy6pwEd2R5wPZ5BlLplwYhfegxqvNYxyYo0e6anRC/nhf67fZhGuqwtK6xpfo9lDI8C+ZQaEc70VJBIqxJYF4bzXBiIU243Kz9vX6rgpsxjX45iZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roE13c5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E48C32786;
	Fri, 31 May 2024 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717170639;
	bh=MCmwVa1wcRv3eofxqF/lCaIC6Z1beutYiATzgaWsP7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=roE13c5zKidz7JA32h6NnOSGXadzwndixMytDbnIlsZYwyG2buQS7tU8CVpUuCe+o
	 Js0oc534jYjfV7iNaMeh2Ximg8tWr69f4hescSbVphaWpz6T50msPLteIw2wZQKfqh
	 7yc1JDlBSd0yaqXMTKLmsep62A9dzX/Xdbbj5QESTzpCKBW6zq5II61QoX/BRsom+l
	 8F/reVZJz1Nf0BVM7kvGaoQ5RV8KxJs8UjunyMPltKrbt9iRmPR2BkJSNONCDcJtDJ
	 wBwJVWRDX3K8lPIASFPvh+wFxD2riO39IxpktO6C1JTkMnP+e6JES76/squCbczVlB
	 m1xub55KVR3bw==
From: Lee Jones <lee@kernel.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>
In-Reply-To: <20240528-cros_ec-charge-control-v2-3-81fb27e1cff4@weissschuh.net>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <20240528-cros_ec-charge-control-v2-3-81fb27e1cff4@weissschuh.net>
Subject: Re: (subset) [PATCH v2 3/3] mfd: cros_ec: Register charge control
 subdevice
Message-Id: <171717063707.1171279.13401169161963190551.b4-ty@kernel.org>
Date: Fri, 31 May 2024 16:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 28 May 2024 22:04:12 +0200, Thomas Weißschuh wrote:
> Add ChromeOS EC-based charge control as EC subdevice.
> 
> 

Applied, thanks!

[3/3] mfd: cros_ec: Register charge control subdevice
      commit: 08dbad2c7c3275e0e79190dca139bc65ce775a92

--
Lee Jones [李琼斯]


