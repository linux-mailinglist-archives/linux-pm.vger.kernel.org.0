Return-Path: <linux-pm+bounces-22891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99FA44092
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FFB17F076
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE9269898;
	Tue, 25 Feb 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPD1daZp"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A03269B11
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489389; cv=none; b=dZyiqPUsjjTeMoOExbSJey/kGo+R31fAI8sswAF5vHL3kQ7jTt78NcyuA921UMiyfWF7lmLbTbW9MkNM90RtzZmXsf9mUltw126IayR/8pCjGOgVnwI01w19hYfFru2w4rJGMicOq+lVR2D7S2CDYerW8NGKdx6649KGkMH0qPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489389; c=relaxed/simple;
	bh=qOXC1JCfflloHvFEyhnlYF5k9jijq3i5BPgiH4ZFlUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8YjsI6PaVdejk3aAguQnxLZ/58fAPJwnGhAT72F1/CP6rea4IUDrOvNifng6WNVgcM91q7EPox3ywDlPQN9cKQuxBSM4D5EoPFKCjD54uytw+YIuN1PjF7dwc/nNCijKQ7yQeJokE3W3yD1qGNUX6x2BSIbfdUY3RIvK1C3ATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPD1daZp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740489386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDdQ5865PcUkpASowBEaf7MEBhJrkqmHB1ewBf2p/X4=;
	b=PPD1daZpMXDSAh1jBDvfOVMTnZfDdDslg7huxR1l4VFzPitey4eI1iOnvnraDzHFi/FAzq
	IA+69+lysDFaLcL3fN30XHMxTnz9TMjkFpJZ6aiCV0ani1HiU0CR0uIqLl6nGPqatZIjoj
	8jmkL0op/R0FC/RLeqo3HRD2dsncm28=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-aWdODwrKPZOmjXmhkH8HUw-1; Tue, 25 Feb 2025 08:16:15 -0500
X-MC-Unique: aWdODwrKPZOmjXmhkH8HUw-1
X-Mimecast-MFC-AGG-ID: aWdODwrKPZOmjXmhkH8HUw_1740489374
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb86503062so858684266b.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 05:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489374; x=1741094174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDdQ5865PcUkpASowBEaf7MEBhJrkqmHB1ewBf2p/X4=;
        b=Y5ZOjZp3qADvezpbNfERrk5MzDabITpj3DuaagNpB8JuMBC6r78E/ow+0erDKOTzM2
         pghvBNP3tX/UCmrWzIj0hYCa1RMA05QVxLdP04k7nBrxz0QNNVZQmHF7VHX/JpMXtrKu
         F4Mt3ELc18y6qgHDgXO89pPjX/lzhxkmW6f3CdAUbJiyUpY28C9tgCnoICzgPTI5a+7W
         vdXhOFV1GGYLYnHyIrCCydIjXaE0ETkQlBNjuC2xv7aBOst1J3mYOALln39714CsTEXo
         /xOUUtyHEX1yh6byQB69222oMvveWwihTb+gALhkVu0ec0BJAtb37AAkGRYpynC8zog+
         tH/w==
X-Forwarded-Encrypted: i=1; AJvYcCWybEj1a9RHb32yJk+nH0jdEDjdX8gCBNt0YhAfFntkUZ32qgtjJ8CbKmHv744753hwfWw/fintyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw219gXfB65KQlAUVegRkaS3UiI6Ny47IxEmVxFodP+K5z+bZsX
	S7OiJ9JgmTFLxrT5c3U+j45KMXgSX+JSyixH958m5jV1NcER/h7vu3EcWluwULheEnSwsABSvNl
	HmyOGd20Ul/3RO2Eiuf2mi4+SNVdZpanQRJfEhT0fdGrUMNea7RTvY29T
X-Gm-Gg: ASbGncsi52RKdKNxj5VmyBONkiV+CjkZxNyVVzONimGQZ0PWcFN1GiAhkKdM7k29CHD
	Yr5TmmNv3GYwODZjvehszBGnf5laupHYlKHyUPglCulk6GFBgXZV5QEUsXik5rzG7pOQWHSiF7e
	mDB66CZCG9DrQX0cv2siK//ZWX3rNqCsUdeRxqwwJFKjYukqEWUNc49vjv3YcGN0CVMXDiwzojY
	th7OQoJoQiQ/REwyG7/RhyCsmdy8sRiUy3eE6TIk2eVqbbAWY0E9AQW0H4HgJ6eLjoKo9qYQBdl
	1OV5OGMvK9eaG5djMK/gO6yHjCAIrp7htJiEV9cO63HhguZL5MJNqIRd2fXUDIG9dAUmhNNWXPa
	qWEsqgXata6VKd++L+rtXwa2tpQtnfJc1V7tJ7+ahO9QJou5wOfOvnS4b8mRMIsJXmg==
X-Received: by 2002:a17:907:96a5:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-abc09ab0c3cmr1650991166b.23.1740489374196;
        Tue, 25 Feb 2025 05:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Huvoo7UhuX++Bwcz+4yYSyekZGfuo2owJoX/ZLlbS2CDtchThnK8UMzHdJHp9qhhK5TgUQ==
X-Received: by 2002:a17:907:96a5:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-abc09ab0c3cmr1650987466b.23.1740489373819;
        Tue, 25 Feb 2025 05:16:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d5529dsm143348466b.53.2025.02.25.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:16:13 -0800 (PST)
Message-ID: <a98547f0-f125-45dc-8bb6-a154ad78f672@redhat.com>
Date: Tue, 25 Feb 2025 14:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] power: supply: core: convert to fwnnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

Thank you for your work on this.

A few small remarks inline / below.

On 25-Feb-25 12:21 AM, Sebastian Reichel wrote:

<snip>

> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a785742f97721e7e70d0e4c17a1ded7b985acb6d..9afde8c04efc72691c81a373d8dd03477b4efd7e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -805,7 +805,7 @@ static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }
>  #endif
>  #ifdef CONFIG_OF
> -extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
> +extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
>  							const char *property);

this function now no longer is DT/OF/open-firmware specific, so I think it should be moved
outside of the #ifdef CONFIG_OF block now ?  The same goes for the devm variant I think
and the implementations of course also should no longer be "#ifdef CONFIG_OF" .

>  extern struct power_supply *devm_power_supply_get_by_phandle(
>  				    struct device *dev, const char *property);

Regards,

Hans



