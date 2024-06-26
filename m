Return-Path: <linux-pm+bounces-9982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19A91762F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C11F22A89
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50B2B9C0;
	Wed, 26 Jun 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4D4pbU4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9471117727
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369174; cv=none; b=W5NuOi70kwnkpgpCodJfB1TXRKWWNKG8Tc+9xmIE7PyHqo0sd4M3neOHldk9yjOn0bfALF/C5LW/gg3ARbzx4Cgy9laxqsNez47fDxTHijVJhxJHoWtzLkznUNZlnsXWEYYf+Dxqd92PXvFv+7VNOvan8lDKatE75UTBTLOyQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369174; c=relaxed/simple;
	bh=wYLtnbnY2NNkZzxViIokOnau6BfM3jzZSdTVyAUN65U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrlqvXPcsASlr9Kan2EUY3nJroC78H2eMcL7h+puRYSNcTB8OubY1Jx3vYSLx+S81rF+IGD6nCHlXpy0mDoNjv74XLMDU0m54QzTRQLT4Vjpnn8EEnYr6ye0oCJ05vH+dGeeKzKQoiFhMsl86T88nDW8ktZqthBJHgfrzPOnxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4D4pbU4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9cc681e4fso3293005b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719369171; x=1719973971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7svuScRKnlywk77bE54H55WY+OOGbn6LuxGj4BpG4uk=;
        b=W4D4pbU4VRwkYqPf9yZ218G7NLfFCJKpjpjUnGB/2FWaqoZ5EUE4NsuJ+QtAdXv1dA
         nlgxqO3fWFnhk0V2qXTrTY9egz8UlkuaSYoF+vdQzZc3HuMNBjrDGXX5tYT4yfLqEVEn
         9KHcrRHvdJsye7olcymKLRkbRzqW5QgqzolpPHG8jb3WQoe0TeKmxsbmTqsakKqG4w9X
         LRzHlRYYQmGBSV9iqWdoTO5b8xBog3oUUmorPZhGNDVqpvLoiecmeFNqPwnyJ9PdzeeX
         RFCGarxFO2ByBG1PqPg+t4Y7BP1sHaTjx5Qxb60m09M3/gsH/k/QUSJwwRdUJLCIUxbn
         dPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719369171; x=1719973971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7svuScRKnlywk77bE54H55WY+OOGbn6LuxGj4BpG4uk=;
        b=oOi+EwLE6qQSrWlcqa2/KqSmkFc9ITXIXf5Giuch2eDLwNSRWAlX/TiMK6EtsG/gVy
         G0cQn8NRJ44s4Y19ndoDlEj8AR4/X2ukcFa9BtdecekuIeQiqmYhR2aairZdMsPAnfGb
         +6UzQ2VDvYayqKvIeTll0hW9Z7ZImvtXa4XgWgqs0FGxrbv+xVxL+OSILJJ3MJz5uUiT
         DwnuBPnU0evaPsKm0MRuxiMtlGGwgXAoXe4uhTIykiQGup3C53drsXljYLs4VaNpZWv8
         6guI8LsCJmdgIYnzMqaJTYOHFayzWJ9glFZPiTljlWUiOkcFn0jSxbK2f7En9kyJ/ITu
         dCQg==
X-Forwarded-Encrypted: i=1; AJvYcCUCeREz0YkHwCkjpScOBlneh+7LH5PushdwUC4t90merxfnOiTZG+QeIGG9iwubWctFYp1rzTz+8/weP6hDcibCW4gVc+Ki56E=
X-Gm-Message-State: AOJu0YzLuZJlDYzdZBApUMwLB9Zac17qsHN1fbobgrTPoj7SUUfVTGEs
	d7uRewv9+fLoooU1sZak/GYm9OvBVWJF7sfhv/JBpd2fkyHx4yN2QhGhqUcDhyI=
X-Google-Smtp-Source: AGHT+IGSZgielOQ+Q/l+FxeqPFApSbxY8xldQDt14i1PgZfy/ZzOeS4mycbqgd/BPGqUzp6qGjSZKA==
X-Received: by 2002:a05:6808:144e:b0:3d5:5c77:fc2f with SMTP id 5614622812f47-3d55c78016amr3602949b6e.48.1719369171279;
        Tue, 25 Jun 2024 19:32:51 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70666de7bc0sm7084253b3a.74.2024.06.25.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:32:50 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:02:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for
 stih418
Message-ID: <20240626023246.pfpdosvde332c3ue@vireshk-i7>
References: <20240625220056.111913-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625220056.111913-1-rgallaispou@gmail.com>

On 26-06-24, 00:00, Raphael Gallais-Pou wrote:
> 'st,stih418' is missing in the compatible list.
> Add it in order to use the driver with stih418 platform.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 9c542e723a15..1ffa23dd8907 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -293,6 +293,7 @@ module_init(sti_cpufreq_init);
>  static const struct of_device_id __maybe_unused sti_cpufreq_of_match[] = {
>  	{ .compatible = "st,stih407" },
>  	{ .compatible = "st,stih410" },
> +	{ .compatible = "st,stih418" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);

Applied. Thanks.

-- 
viresh

