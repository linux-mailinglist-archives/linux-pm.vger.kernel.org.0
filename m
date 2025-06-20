Return-Path: <linux-pm+bounces-29165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5FEAE1FD4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D717F657
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D282DF3CF;
	Fri, 20 Jun 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NI6Skgtf"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A92E6139;
	Fri, 20 Jun 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435774; cv=pass; b=KdxwvsbE/YVWWdQ/vDav+pebI9hp7stW5OWajgrwGiw30FvTRcOpd0DkLhHgI5+qoodHYvH7FnuZhmxhg9ggcPYyWvQlpAWWYgzFwc6fBj4Rw7ajbu75yCStAw3PPuTBPGYgciyBqYDqtezHfbxwFczFR5LC1nMM4d4P9ftsmNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435774; c=relaxed/simple;
	bh=hmJtwJNTZLpQbvrFRwSOuCQChyCQaWLPyXx3u2ML98M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlEZ/w3jbyE0cmgrenCdsPK7QXPOXKognkwwBzjQgNFJM91Gf1wkqZgv6KQ9OOgy2LwC5SePlAApvsd5y/NZG7mt8SGK0585brRfYhAY2R/9ZjSRQU2nCObyYlWzVW8ikQiW5e8VSI143O3Yq5gZyMFrKVVZ5iIdFfO/orAGXaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=NI6Skgtf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750435740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PRHhROmhmYIWX9VQQTxybnvoc6qtwZl5IIv2lrQyU98SI8PSQRx3OjmL+nHgHnNS8rTURwoaRXTh+vxHmIaDy8fRSwylDuLVuZVs4LIdelQ3u6q54VthaJuNQHNYjtLjqC07mL8d50No7OH95WaHgWlaHrET0wFhPLDDJ6twZ6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750435740; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SexsvDtdFHy59LCXhZgboYD+J7kOX3/xH1GfCS5qJ70=; 
	b=h9oyyW/ShfW+J2W6xs46kQAwkHnoOUIwW2XBIBgUnCkQKyn7Sr2HJ54u+P+67V7+3KbxMSkO0xw87YpZdv3W2OF9waXajHC6XjmMMn9hADzgWWRHNwFF80fTWa5S7JPjpX68Pc09rHS2Ac7BpWLVefhp+6GPDiFYr9DcGRwX324=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750435740;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=SexsvDtdFHy59LCXhZgboYD+J7kOX3/xH1GfCS5qJ70=;
	b=NI6Skgtfq0cL37ispMMDCYE5YRle5rAWCFeZ+7d0YB8+csnfhvzI2pmpKzi7NAd5
	+oJpfITXVKuhQYJ0oqbIKmMPAJIzaccGQzqlylF2Aghsy29G8FgFRrzb1iMS5kOlCOL
	ErgAgrQqu4yrkemovl4e/k3+8bIlb0kfLjXCP0LU=
Received: by mx.zohomail.com with SMTPS id 1750435737953532.631082223741;
	Fri, 20 Jun 2025 09:08:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] RK3588 rockchip-dfi enhancements
Date: Fri, 20 Jun 2025 18:08:53 +0200
Message-ID: <2422670.VLH7GnMWUR@workhorse>
In-Reply-To:
 <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 30 May 2025 15:38:07 Central European Summer Time Nicolas Frattaroli wrote:
> This series consists of two related patches. The first fixes the memory
> cycle counter on RK3588, which read half of what it should've been
> reading. You can easily verify this with
> 
>   perf stat -a -e rockchip_ddr/cycles/ sleep 1
> 
> and then dividing the result by the number of Hertz the ddr init settles
> on, which for LPDDR4X on RK3588 appears to be 2112MHz.
> 
> The second adds support for measuring memory bandwidth with LPDDR5
> memory. Results have been validated by comparing its reported bandwidth
> with that reported by stress-ng --stream 8 --timeout 15, which line up
> almost perfectly.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Nicolas Frattaroli (2):
>       PM / devfreq: rockchip-dfi: double count on RK3588
>       PM / devfreq: rockchip-dfi: add support for LPDDR5
> 
>  drivers/devfreq/event/rockchip-dfi.c | 91 ++++++++++++++++++++++++++++--------
>  include/soc/rockchip/rk3588_grf.h    |  8 +++-
>  include/soc/rockchip/rockchip_grf.h  |  1 +
>  3 files changed, 79 insertions(+), 21 deletions(-)
> ---
> base-commit: ba2b2250bbaf005016ba85e345add6e19116a1ea
> change-id: 20250530-rk3588-dfi-improvements-f646424715d2
> 
> Best regards,
> 

I see someone has merged patch 1 into -next without leaving a message,
but patch 2 was not picked.

Could this mysterious patron saint of PM / devfreq make themselves
heard and let me know whether they would like to see a second revision
of patch 2, and if so, what said revision should address?

I am asking specifically as I would like to continue working on the
driver in a follow-up series, and BYEWORD_UPDATE already complicates
the situation by being another in-flight patch.

Kind regards,
Nicolas Frattaroli



