Return-Path: <linux-pm+bounces-36485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35BBF2931
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BAE462AF3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A602330301;
	Mon, 20 Oct 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WWyajdZj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D84330317
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979553; cv=none; b=dwIKDM4l6TTBScpkggSfCQ58blZhlNgqkwXHGIdck6h+l8Lo3q0AqVDAvs5rqVnhQg/Vg0ZYjHRceZBFkzmu0UUZnwLFLNi8RzZTIzsITRVu7yMrCtSyggveDnlEvDIFVh8WqwbaEjkjhT8A2C3suM5/Q7sCPqDduaL3VKXBl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979553; c=relaxed/simple;
	bh=G7iQGFTjElvxnf59cDItFHSMkPqz6A/NDmQwvq/okdc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RvMDrtRZ6QARH+E9fmFZGnbxLwNtaov3qAH+kw0KmXVv76VvLL0nVQvcnuBGNhAMejkem6Ww69Kx14YAH+Jz0GffKN6jN4kQtBTBc4a3UvkwXEQrjVRGDi2ifYEr6zJ5GkTde2AwpgivzGk0tlKNiDgXaI2rmQWc7Bct+VzMZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WWyajdZj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760979549;
	bh=G7iQGFTjElvxnf59cDItFHSMkPqz6A/NDmQwvq/okdc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WWyajdZjmxz/WBOuB14W78E+DuNtJEYQjwW2ymcmVIObxjugvSigBuZF3CBG2NKto
	 MVNzlzgfauJbhoxyMI1dXGR4cgZIORC+K4uX4bhFBmk/GvcWKmeqwbCvs5siB1GAG1
	 Dmb7/RLRvabYkGBzqNl3Dld2wpMNEk4Qdkl+oESkwyKBmEs0f05KwLjmi/9SqwjALT
	 xiIbI9+oLe8ap3YY5A1gdPnd6JGFHNcm6y5JrD8ATh9fXNfGtA+zc4JoFiIoSDnvaM
	 8ooqduBQmVJ4hsS4p2W2+TfOt4cDTzamSxw0mOK319XzofBViCx8dVgERATlkFg9GI
	 gDBvxlC28bMFQ==
Received: from [192.168.200.105] (unknown [182.181.201.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5935617E127F;
	Mon, 20 Oct 2025 18:59:01 +0200 (CEST)
Message-ID: <73a9da49-1513-4eda-bfaa-c89160ed709e@collabora.com>
Date: Mon, 20 Oct 2025 21:58:57 +0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 2/3] PM: Don't pass up device_resume() -EBUSY errors
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-3-superm1@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20251020165317.3992933-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 9:50 PM, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a device resume returns -EBUSY the device resume sequence has
> been skipped. Don't show errors for this or pass it up to async
> resume.  If resume is run again in another stage the device should
> try again.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/base/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index bf9c3d79c455f..f6bc7ef9a8371 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1112,7 +1112,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>  
>  	TRACE_RESUME(error);
>  
> -	if (error) {
> +	if (error == -EBUSY)
> +		pm_dev_dbg(dev, state, async ? " async" : "");
> +	else if (error) {
>  		WRITE_ONCE(async_error, error);
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async" : "", error);


-- 
---
Thanks,
Usama

