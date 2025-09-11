Return-Path: <linux-pm+bounces-34497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8AFB539EB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248977A4415
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0135AAB2;
	Thu, 11 Sep 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HhYl/MSG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FC19C566;
	Thu, 11 Sep 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610341; cv=none; b=O4ellv2Q94iga2OtpHoIWHIa9W1gEO/jFtRLLVpirdSZR58UkTrrs9qNmvtzjjwEZz6URZZyB7C3ATHgIAjWpU5OnOFm2v8pAv9Gi9vUoawqImx2hAz0QcaWLToSrh5SkpzRNH/PxtaJGAle+2NWdDSBfA2/+ehEx6u295sBTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610341; c=relaxed/simple;
	bh=zUZhlfvionExk+RR/6xdmLFXpn1HjC8PwQn3oii3KI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E7VAv4oU0A+Y1QFfFUPqBACofiBy6NEkS5d5cyqxkXaeLpZEW5HKpxNaaxD099vm29sYmgVZmluO9iFLuhpgYgW+Bk0i4L1bvHPefAHF25/qCtz0zbusQaHsYOos8bb/1eB/EzWk9ZqFGmpQDdabJBQgMYRq0TTPuADKBQiPSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HhYl/MSG; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id wkaxubI0xda52wkaxux1Al; Thu, 11 Sep 2025 18:56:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757609789;
	bh=Ih8AiVLgRmkp8r9BuWnTlOVC9avu2z0yhPMRRyFowLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HhYl/MSG7J9wGw4sk3cDSP8RR5E/8J1Vlffd2Cv6dWqMMKjs5OnK768uyVPGijqtt
	 mBbMjs2+BdTZAjGWnF4EOcPA1hOmOkiD6A0yOkVqGHZasUE3v8xHQWxIWXYQM28PBO
	 QecuVtbvu22OX6aGZ0b/xYFCIvFKKgx31ytZY4awxVuNS1/w/+Zcc+5atiX5sUUCJp
	 fSL28nUqLUwEIeQ0EpHGROolixwUJNxMGiOsqn1VIqC5X2yxRIz4cnrpYzk5tg0xvw
	 L4x5ywFezEFUAgRAWNYvXOoY4ON2j6l17pS1aAD40QO/OoK+oaRxIPPo2I1rCM8fmm
	 tD/Y+Y4ZYJQ4Q==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 11 Sep 2025 18:56:29 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <888ce9cc-787b-4deb-87a6-d69cb7e04593@wanadoo.fr>
Date: Thu, 11 Sep 2025 18:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PM: hibernate: dynamically allocate
 crc->unc_len/unc for configurable threads
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org, pavel@kernel.org,
 lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1757577879.git.luoxueqin@kylinos.cn>
 <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2025 à 10:09, Xueqin Luo a écrit :
> The current implementation uses fixed-size arrays for crc->unc_len and
> crc->unc, which limits the number of compression threads to a compile-time
> constant (CMP_THREADS). This patch converts them to dynamically allocated
> arrays, sized according to the actual number of threads selected at runtime.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>   kernel/power/swap.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 0beff7eeaaba..bd149a54c081 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -585,8 +585,8 @@ struct crc_data {
>   	wait_queue_head_t go;                     /* start crc update */
>   	wait_queue_head_t done;                   /* crc update done */
>   	u32 *crc32;                               /* points to handle's crc32 */
> -	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
> -	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
> +	size_t **unc_len;			              /* uncompressed lengths */
> +	unsigned char **unc;			          /* uncompressed data */

spaces and tabulations now make things look unaligned.

>   };
>   
>   /*
> @@ -721,7 +721,21 @@ static int save_compressed_image(struct swap_map_handle *handle,
>   
>   	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
>   	if (!crc) {
> -		pr_err("Failed to allocate crc\n");
> +		pr_err("Failed to allocate crc structure\n");

Usually, it is not needed to log messages for memory allocation 
failures, because such failures are already verbose.

checkpatch.pl should complain about it.

CJ

> +		ret = -ENOMEM;
> +		goto out_clean;
> +	}
> +
> +	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
> +	if (!crc->unc_len) {
> +		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
> +		ret = -ENOMEM;
> +		goto out_clean;
> +	}
> +
> +	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
> +	if (!crc->unc) {
> +		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
>   		ret = -ENOMEM;
>   		goto out_clean;
>   	}
> @@ -886,6 +900,10 @@ static int save_compressed_image(struct swap_map_handle *handle,
>   out_clean:
>   	hib_finish_batch(&hb);
>   	if (crc) {
> +		if (crc->unc)
> +			kfree(crc->unc);
> +		if (crc->unc_len)
> +			kfree(crc->unc_len);
>   		if (crc->thr)
>   			kthread_stop(crc->thr);
>   		kfree(crc);
> @@ -1241,7 +1259,21 @@ static int load_compressed_image(struct swap_map_handle *handle,
>   
>   	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
>   	if (!crc) {
> -		pr_err("Failed to allocate crc\n");
> +		pr_err("Failed to allocate crc structure\n");
> +		ret = -ENOMEM;
> +		goto out_clean;
> +	}
> +
> +	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
> +	if (!crc->unc_len) {
> +		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
> +		ret = -ENOMEM;
> +		goto out_clean;
> +	}
> +
> +	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
> +	if (!crc->unc) {
> +		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
>   		ret = -ENOMEM;
>   		goto out_clean;
>   	}
> @@ -1507,6 +1539,10 @@ static int load_compressed_image(struct swap_map_handle *handle,
>   	for (i = 0; i < ring_size; i++)
>   		free_page((unsigned long)page[i]);
>   	if (crc) {
> +		if (crc->unc)
> +			kfree(crc->unc);
> +		if (crc->unc_len)
> +			kfree(crc->unc_len);
>   		if (crc->thr)
>   			kthread_stop(crc->thr);
>   		kfree(crc);


