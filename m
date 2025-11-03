Return-Path: <linux-pm+bounces-37268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC1C29B5C
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA983ABC04
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856717A316;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0D2C187;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130918; cv=none; b=JHHxW1fDnN4cw75i1XlgZJ8unKA0hLHn0Wv/PGecszLZh/BQxtOrNsKyDutQCeyK8GUUw+5d3ETYNZFNuKe1TeLcNOsVLUsHDwkGBXP3BA2x1kaSJ4edPa72nij/dT8wg6g/LYHOlQ7+1nEUVtl9BFWIh8ic3J6yofamB1DDrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130918; c=relaxed/simple;
	bh=dWSrW8rsyoXYyyqIHBm9yF+aYpTV0w+WPAqHop8hPI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eQjIu9mp4/Nt/ccaopvQMKogjo7BUD8qDbuHl+smZPtQk/r6I0pgj4RcXnF5OKltX6hI6RBNQvFn2cnQ0ZmHhwdCdIIUI0BLZONsB9IZoWm1yuLB8B8dcXKupHB47vV/dQKuP7JBW+C4CwYaay8S+1MMPXBGgfSrhjdfh9cK+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5AEC4CEF7;
	Mon,  3 Nov 2025 00:48:37 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3A8BC180CB7; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250925-max77705_77976_charger_improvement-v6-1-972c716c17d1@gmail.com>
References: <20250925-max77705_77976_charger_improvement-v6-1-972c716c17d1@gmail.com>
Subject: Re: [PATCH v6] power: supply: max77705_charger: implement aicl
 feature
Message-Id: <176213091323.301408.11212778239075884714.b4-ty@collabora.com>
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


On Thu, 25 Sep 2025 22:09:56 +0300, Dzmitry Sankouski wrote:
> Adaptive input current allows charger to reduce it's current
> consumption, when source is not able to provide enough power.
> 
> 

Applied, thanks!

[1/1] power: supply: max77705_charger: implement aicl feature
      commit: 8ed6b8842c44a4a716dfd536e7f13aff77039a02

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


