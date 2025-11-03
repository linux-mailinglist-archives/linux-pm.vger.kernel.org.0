Return-Path: <linux-pm+bounces-37279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BBC29B8D
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832413AE180
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB62367AD;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A92248BE;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130921; cv=none; b=aTwP3WkdCqhgG5fp0vT55kF89W3f+tyk3QOwgo4YMoLmiPQFAzUkkfFNEx+UAVjAJSQPire6Ilnr0nipDdDVmNTbxebNmDRAfLAzNfxuunP59rSG87j93nX5qs4PXu3Z3TitzLqLVQSTkI1wasJxSxmU1EKDu2TYjtkhl7udsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130921; c=relaxed/simple;
	bh=EFJ2AFXJrCDVQFWhIyCOr+o/n0I5wJxHqPSflH+/EC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvrvMBa/UprURDW7Ji+k94mG48EhNMZvzSqO4sEoYPmRmBOY1+MciuUbWQcviVyUxMz4FqZhb8C1TRWHz3AnSLdUAPvjgBMvKLl+TTnd0wOjPJybu+roVX7D3JFF+uOov0EMR7MUFifm79Q6yKk+xqL6L3d+dE+bNKs1IoxIywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBB0C19425;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4B6171811F8; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Ivan Abramov <i.abramov@mt-integration.ru>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>, ChiYuan Huang <cy_huang@richtek.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20251009144725.562278-1-i.abramov@mt-integration.ru>
References: <20251009144725.562278-1-i.abramov@mt-integration.ru>
Subject: Re: [PATCH v2 1/1] power: supply: rt9467: Return error on failure
 in rt9467_set_value_from_ranges()
Message-Id: <176213091329.301408.1063635478051970242.b4-ty@collabora.com>
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


On Thu, 09 Oct 2025 17:47:24 +0300, Ivan Abramov wrote:
> The return value of rt9467_set_value_from_ranges() when setting AICL VTH is
> not checked, even though it may fail.
> 
> Log error and return from rt9467_run_aicl() on fail.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
      commit: 8b27fe2d8d2380118c343629175385ff587e2fe4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


