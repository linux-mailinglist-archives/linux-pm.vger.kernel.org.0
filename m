Return-Path: <linux-pm+bounces-22590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C1EA3E9D8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489B9179D81
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D1288B1;
	Fri, 21 Feb 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7TZK1bm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84AA94A;
	Fri, 21 Feb 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100956; cv=none; b=okQ/hiSlmAtro1/rTz3p7krOJYbFi88Ktu8lQZWi1FVpxwVIfEtgB6dLOuZBQnOo4hgiKRHvv3IoxEs3SHRiPedwqtk+9E/WIMdkWfC7rsyFVWhZoUdYN2wpViqWSsZThMzw0iH3dMFLihLOUXgHjEmAD1WIQbsZK+sjdCqjwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100956; c=relaxed/simple;
	bh=K5kHSNUnjTSDcgVrbtlRl82jom5eu/PGvD0+oVoekOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmKBYODgktfvYz6ThSG0ZQvVwYd0P2HlRGZCZH5CCCg5HxCBkvB66cHTsbM2UZOccIMfvL+ER7vSUUhqxt7U+Ye+LTzuWUm5IhGObces9Q0vm85Ivc4qLHJnzT7W2sCz/cnh6ncwFsXFzgT0LgQV9YZH7I5L55uSpghuOX0RseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7TZK1bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40929C4CED1;
	Fri, 21 Feb 2025 01:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740100955;
	bh=K5kHSNUnjTSDcgVrbtlRl82jom5eu/PGvD0+oVoekOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7TZK1bma1m0pJkMlj4NeJhhf/+a9vYyeo09ekQQcJEAKmrwXTCI8Gfr9rN1TCjJa
	 G9cH9J3Sw6K9xKeZCx9PulcJKMQvd5WnDcJBtJvy29yMyQ1cOxrmwa6X1VPIcqHO9c
	 QmEZiF0WVn1TeV0Pov5BrWBAn9ASqdtVC95JDqEkZxg8EmmI/heAYfJKz8+XdpsVxl
	 q6Y+MFolzkfN3S/5wqAYTMr9ahN88x8r3r3SGUNtSOX0WImGL1PeSqauTXuMypAL1+
	 vsXb+Z3odlAmnIDNLaFMhWfHXZiDZOdcjncLNg0RauBd/3ADZQDp8azQYpbmkiWnV5
	 5CDCkBb7wyjpA==
Received: by venus (Postfix, from userid 1000)
	id 1FC151835EA; Fri, 21 Feb 2025 02:22:33 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: linux-pm@vger.kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	pali@kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org
Subject: Re: [PATCH] power: supply: bq27xxx_battery: do not update cached flags prematurely
Date: Fri, 21 Feb 2025 02:21:55 +0100
Message-ID: <174010090150.20358.11892224771206092730.b4-ty@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241125152945.47937-1-absicsz@gmail.com>
References: <20241125152945.47937-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>


On Mon, 25 Nov 2024 17:29:30 +0200, Sicelo A. Mhlongo wrote:
> Commit 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about
> status changes") intended to notify userspace when the status changes,
> based on the flags register. However, the cached state is updated too
> early, before the flags are tested for any changes. Remove the premature
> update.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx_battery: do not update cached flags prematurely
      commit: 45291874a762dbb12a619dc2efaf84598859007a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

