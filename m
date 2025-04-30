Return-Path: <linux-pm+bounces-26497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A79AA580A
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D091B679B8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F0225A3C;
	Wed, 30 Apr 2025 22:43:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B7225A2C;
	Wed, 30 Apr 2025 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746052996; cv=none; b=uqobfXvMN2OUQEIn9RQAJ+Rit+Rd3pZ6B4Kak8llPZUXZ60LhngI9gHEKOgCRxwf+/xjJYDQsJGZsf889jLPQAmFDdrNIETUyp2NzBetpbwUSxg5s5EKfrtx5cgXj3XAuPiUGrH59wOhKpLJCDUvuk1RzZs6uBw1JcNYWmCKKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746052996; c=relaxed/simple;
	bh=SK2RTSSfYtSO/2020H+TsGTL2elMuGrrGYZGbJOK5pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FyE8//FS6BOEPbcGn4/9jNMUevdqQ8uL3eXjSOiMcfmmfDWSv2TlwVtpB1EDFyRZ+pkcLghJbwzKExsJBZOUQwtK0/ExnZWLeaOQF+RNUlOpQ308ucjDjMWkb33LFM8IvF7FTFndM9BMteT/5mNOURlVE93WE/munJD8UhwFgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71B4C4CEE7;
	Wed, 30 Apr 2025 22:43:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C7B3D180F68; Thu, 01 May 2025 00:43:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313103437.108772-1-mitltlatltl@gmail.com>
References: <20250313103437.108772-1-mitltlatltl@gmail.com>
Subject: Re: [PATCH v8] power: supply: add Huawei Matebook E Go psy driver
Message-Id: <174605299379.111219.8938968253291292335.b4-ty@collabora.com>
Date: Thu, 01 May 2025 00:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 13 Mar 2025 18:34:35 +0800, Pengyu Luo wrote:
> On the Huawei Matebook E Go tablet the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> tablet.
> 
> This driver is inspired by the following drivers:
>         drivers/power/supply/lenovo_yoga_c630_battery.c
>         drivers/platform/arm64/acer-aspire1-ec.c
>         drivers/acpi/battery.c
>         drivers/acpi/ac.c
> 
> [...]

Applied, thanks!

[1/1] power: supply: add Huawei Matebook E Go psy driver
      commit: cfe769670e82c2bdd1cd8b6e4dbe8614b6429211

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


