Return-Path: <linux-pm+bounces-17354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCA9C48E2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF688284EB5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4411C1741;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B71BCA1B;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363216; cv=none; b=L4zTfCe8iUTMC+Z234KiF/BHsMIPctx+ChYlZtx0gWOcn7HtT8RSF1VxiOIJjkGapM+rp2QAVMQSi/idwGebxjqRCycPwYRG9sDmzyDDamlW0+K+o7K31P/oqfXpNRUfoUT5jsRZQeEh6kn7foor6CEcfeA8VXL9CzX5i4w8Edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363216; c=relaxed/simple;
	bh=G0IP/1mBHjwgIHglhgzCLdLRgrcOSY4gpelWcv3ZPrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=laSzghZFNeoGrlslRiB2dZ9ZuoleqLaAApscEyfwpyT36t1VpIq+EwQkOubdgM5Ou+AFjkVTAQxs0YfgomGRy8Ed1p59KU9K1FI5It8vBgbMra+e/zzqFHXf4pJSzp20XJIqhSGls91ykySb0Lc5Bx/ItivcHtj2lYWppI5h/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F4FC4CECF;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 44C0E10604B0; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20241023061126.7896-1-yesanishhere@gmail.com>
References: <20241023061126.7896-1-yesanishhere@gmail.com>
Subject: Re: [PATCH] power: supply: generic-adc-battery: change my gmail
Message-Id: <173136321427.772650.10722733892870416418.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 22 Oct 2024 23:11:26 -0700, anish kumar wrote:
> change my contact in this driver.
> 
> 

Applied, thanks!

[1/1] power: supply: generic-adc-battery: change my gmail
      commit: c0f3a0124d3f1dfed700d2871f9d37f418999af2

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


