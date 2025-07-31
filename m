Return-Path: <linux-pm+bounces-31679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D0B16F4B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9461188EF59
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262192BDC1B;
	Thu, 31 Jul 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="njKKHKIz"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189C746E;
	Thu, 31 Jul 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956952; cv=none; b=klhxDCihRbAB2uiml9ecbE1MtZ0X/0GBVmvZfTJB4yrn5l//2NJuuSINihhxIuOysUjuYVTYWZiL3Ow0fdsTiR67l/L0+i8tfnYhmFMIUoyOcMHkTq9VCILVfifX2SeaHzPq/eDqSayAFMkcIe0gag8ESX5htSVavZePzGiEdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956952; c=relaxed/simple;
	bh=RJiuaDp9mWdvOO/DBR0WGEM4OUuHTFOlawmLNB3P+G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORZgAnofMzTXlw8KcJAZY+0PT8HTe9XCqqRdJI7zDjY17x0EviZkpUm6lk4dWNNRzTfAxZwbim3CY14caA+sL//mFr17Wz+FjPwk4C9n9hkKGCBb11p+XkzKmzGuOAuB6q3azf5hSvKRiWUNI66pmradVvq1GGQJsg+YtdMgJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=njKKHKIz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753956948;
	bh=RJiuaDp9mWdvOO/DBR0WGEM4OUuHTFOlawmLNB3P+G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njKKHKIzlvWFgIIXcjpz+iskyPm9MiUUMKAUvxUtiG1R1CgxIxZBHbJjZBHW5uq3u
	 jiKMiAau9Fc3+HFgb86VauHp12rel7f8aFYebPkZHci0x0Q4agt18ckSKOTwDUSiXb
	 naWk8UpG8LvfB6reJg+U+S8i3x6yNwU06vqxE3Kyj96t372JvbxtEv/FS4iQrpm52A
	 vdIHItdj2KWjh0XbwNH5BTVLH4H5lanquQcnsqIyYj2ZbiVAP0rTJRA1kwIUkRMD4m
	 Q1HrtCVCOmc4oY9mqSYISE9uT3ccecOvDRfl1rFvwg8v0pC2d75f+fEShZd3VCvuCk
	 ohEj4DvNj4y8A==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e229:d0be:3141:7dd2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8432E17E05F0;
	Thu, 31 Jul 2025 12:15:38 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: fshao@chromium.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
Date: Thu, 31 Jul 2025 12:14:41 +0200
Message-Id: <20250731101441.142132-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
References: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fei,

On 7/31/25 06:25, Fei Shao wrote:
> On Wed, Jul 30, 2025 at 11:40 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
>> abnormal temperature conditions, which involves reading temperature data
>> from a dedicated set of registers separate from the ones used for
>> immediate and filtered modes.
>>
>> Add support for ATP mode and its relative registers to ensure accurate
>> temperature readings and proper thermal management on MT8196/MT6991
>> devices.
>>
>> While at it, convert mode defines to enum.
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>
> It's not visible in this patch, but a heads-up that I see
> lvts_ctrl_start() also depends on whether lvts is in immediate mode. I
> wonder if anything is needed there for ATP mode e.g. a new
> sensor_atp_bitmap.
> Feel free to ignore if this is a false alarm.
>

Thanks for the heads up - the bitmap for ATP mode is the same as 
sensor_filt_bitmap, so the function is already working as intended.

Best,

Laura

> Regards,
> Fei


