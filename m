Return-Path: <linux-pm+bounces-37710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D3C460CA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9894E875D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B33054C2;
	Mon, 10 Nov 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VBd3EL5U"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4B211A14;
	Mon, 10 Nov 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771783; cv=pass; b=hkYcjMDAIYh8V/vwRYVGo0FAwHgOKFpuqo6OWwkcGnSKycPZlYZN9xiC+aZ/gjhx+t3bnCOk1eUxz6DLKS16QjOwfm7LvU7kQhZALO86F+9a16t+u3Lx7DcxBHKGW5s9JAFSa8Lf+Gi2/XiR3Cu6HvpF20sshX41RKwV65vQLDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771783; c=relaxed/simple;
	bh=k+cIHb+jF4FREuVisxyDxGDBVMofZ9kYHaWf5eH17h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNtY9SSRM7uSBzJ1RWv+1ExC0n+YTYKsvhBEyukyKiJIKSMs2iZ2vtreJb6qCEuz7QjIkmdBuSDJV22rF9iC5meUGof2gmEGkJQaB5jhhRB3hGGdmkITp2LXPG1vm0sZlmZhszcvE93kAlyy5+KnNWXIklm71GZYTqbdU5kX7DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=VBd3EL5U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762771764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NxkxrJemZezmKrnWKU50oEyuQ0oCj/UUy1xO5JA0Gxn9hFcL8TKfLyZ9KjZK0Oj0JuaQfXVLrz/fLTRYpOpa1ehrccY4PZYSvu95xVpyoEGqHKNJIZKqZ7noyjFhJlISRGOCeVfVMTkvYNqRmBdvc90If/92GDVfoy+n2dsECTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762771764; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M3hjjQw506YKhgHdFR2a57hcN/smdx/JNOkEsmfHHZk=; 
	b=aCxRLagrCIk8Z4COBk6g3josoNmO+MGUHDltmbPTzTdDmTTOuLRTxMiCLvRy08HwLsFgO/iVdI8mbNOub7r8jKGDGkaiAXxIMppwWE+6LP5tU/US9jl2dpE1vhWqavByHylZXFprTtLYSFIOsvHnZ0zslYFLvQvBllhzpcZcTJw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762771764;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=M3hjjQw506YKhgHdFR2a57hcN/smdx/JNOkEsmfHHZk=;
	b=VBd3EL5UPfRGd3kOCmotU8adSTTmnNAgPJhL85RfMUAYwnFFqt1sQGScQeXfHtnq
	5MtVhSlfd1As0In11QZQr2rKRZoGz7fe2XwrKIIJHeGcFyT8+8fXOywCIdVrBqO0CSh
	qjJGAlCu1mMEDhsVV8VXSqvTB6HnfBOAwkRMWe/A=
Received: by mx.zohomail.com with SMTPS id 1762771762436795.5055126772169;
	Mon, 10 Nov 2025 02:49:22 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH] pmdomain: mediatek: convert from clk round_rate() to
 determine_rate()
Date: Mon, 10 Nov 2025 11:49:17 +0100
Message-ID: <9531607.CDJkKcVGEf@workhorse>
In-Reply-To:
 <20251106-clk-pmdomain-mediatek-round-rate-v1-1-49441ea27f84@redhat.com>
References:
 <20251106-clk-pmdomain-mediatek-round-rate-v1-1-49441ea27f84@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 7 November 2025 00:40:43 Central European Standard Time Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's convert this driver so that
> round_rate() can be removed from the clk core.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> index af20111067c02a5f9a0d6d751e9e0dc32c1a4d90..9bad577b3ae4bf1b83d4f782bb52f56f779a8974 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -309,11 +309,11 @@ static unsigned long mtk_mfg_recalc_rate_gpu(struct clk_hw *hw,
>  	return readl(mfg->shared_mem + GF_REG_FREQ_OUT_GPU) * HZ_PER_KHZ;
>  }
>  
> -static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
> -			       unsigned long *parent_rate)
> +static int mtk_mfg_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
>  {
>  	/*
> -	 * The round_rate callback needs to be implemented to avoid returning
> +	 * The determine_rate callback needs to be implemented to avoid returning
>  	 * the current clock frequency, rather than something even remotely
>  	 * close to the frequency that was asked for.
>  	 *
> @@ -325,7 +325,7 @@ static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
>  	 * high current frequency, breaking the powersave governor in the process.
>  	 */
>  
> -	return rate;
> +	return 0;
>  }
>  
>  static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
> @@ -338,12 +338,12 @@ static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
>  
>  static const struct clk_ops mtk_mfg_clk_gpu_ops = {
>  	.recalc_rate = mtk_mfg_recalc_rate_gpu,
> -	.round_rate = mtk_mfg_round_rate,
> +	.determine_rate = mtk_mfg_determine_rate,
>  };
>  
>  static const struct clk_ops mtk_mfg_clk_stack_ops = {
>  	.recalc_rate = mtk_mfg_recalc_rate_stack,
> -	.round_rate = mtk_mfg_round_rate,
> +	.determine_rate = mtk_mfg_determine_rate,
>  };
>  
>  static const struct clk_init_data mtk_mfg_clk_gpu_init = {
> 
> ---
> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> change-id: 20251106-clk-pmdomain-mediatek-round-rate-649a9bf7d30a
> 
> Best regards,
> 

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I didn't test boot this, but it should be fine, as I've checked
and all the places where the clk core checks for round_rate, it
also checks for determine_rate. So this is likely correct.

I've also made sure the adjusted op implementation is correct,
in that simply returning 0 leaves the requested rate as-is and
preserves the existing behaviour.

Kind regards,
Nicolas Frattaroli



