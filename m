Return-Path: <linux-pm+bounces-35885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8BBCAFC2
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72A044F4380
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE97283140;
	Thu,  9 Oct 2025 21:54:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF852820A4
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046860; cv=none; b=u9VuGPP+136j916ry+asPNtIFWYHhJX6MDk/rAUzcQ9wU6tABFcAwduutrhwAiRUH9gfSSSzMv8vS/Himz3wF961obScNH+xZSVtiTNQjx4GvoVk5fQTnJKByBt45v8OSd075R6zf3gVvoIpv8MM/VmT9I/ID/aFRXYl9PZXSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046860; c=relaxed/simple;
	bh=j+8cMbDNxklCbCV4sxFCT7EnrE127VbBQwccd1APhfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ihh4E4vuwgmNNF9/r61LrzTjx+8e/K0ljZFDv87Yh5+OBlBoIZAdPhhoY1RB5CxinyNTH7BRBMg3J3FyxIPZsqtsd+LBXR7O1oZZSk0Yd1oXIoJq44Ed8Qy4IGhli9wLawYOT3ZFjqjh/+8kIMHZph0PcrJW8wWLd1xLxeq3vWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1383134a91.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 14:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046858; x=1760651658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+8cMbDNxklCbCV4sxFCT7EnrE127VbBQwccd1APhfc=;
        b=HAs7VfN/ko3f9Mk2t+wtuGvRn9ZamXLw3F0J1rYeFYOZWtmUWyh7wX56NpAwpTp1xV
         8N3UHzDVzBNwkmYK14vGk3cuBXO/r8rf4A4GsvNVaPxRmoIv+CXV2L4dNTEDbZ9thVld
         +mRvQWIyou2U08oDxt4V8CbNDyAeTocMe4RaLSlEhjslgz6JfLv8HyIEUjDydaekQfE8
         y1g5bWb3foqVq/kI3UTdqhURmhNn+xwVdAwN2/t+ag0ErgqZIxM7judD4MA9CnKPtBUE
         I/XsO7mw3kX71wlWTxCjZo15BLWlXUUTtwSZHilqyVVbPbDpWbcNFYfaREIGs8uuf4SA
         drBg==
X-Forwarded-Encrypted: i=1; AJvYcCWKH4btvxlfVnF8HGI8Lm5zUm4ZMugh6GR10G3qMh8qECZs2+H0OiZ7rHA7B1olgRSjfcFKAXak8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPtNExViV1BGhzutPKDc8fLeorzbpbOgN7usFD2ork6NZh4vV
	Gq59kgBlGISjAXKd5mY9P4e7R+6dPN86yB0267RbzxI/CTDcyj55Cc3I6WKAXYWqlVM=
X-Gm-Gg: ASbGncuqFcJ9icRoyKHLioi6ns+YPIxcLY9Yp+IP3oxe4t3ij4hy0riruvkmscZTNsL
	3eDam3Dg+NxEQSK6Xi4sUeQWUECNZ2OL+QKgSHYhsvlX7wsyvGmEsDrY88ngsCFjOGQFmB9UwWq
	aXtSv9mkVzjhI+Jb9pT4OYSoFuIBtAkg10XlWSVi7nsO5KVw2TT57gvhNm7W1MRH9+S+jYZSjEW
	2oTGsUrXLTeTecDkiLVFUyU+CNkEtuKlsNBFOEmBSLjBxxvMlDOl4lBTgbc+D2kvuSqoEirlIIe
	6Xz9UckGG2hDAj5ITstvHwB5BV+A8ScduTUiy7uAmvwARm9pfmZLuLgfcsTMKXhmR5+XNYY8qmH
	c3sd+eWoFInoBBA3yKNQ1rFbDPRe0B4ap0GFpApzfvkynYkWRQ6K9En0=
X-Google-Smtp-Source: AGHT+IHNJd9z3jsIW8ArDj5mAZGmK88KLPxR1ZRHy8f1OQIbnvz7GwmoWU71oPFD25bkRDCull6/og==
X-Received: by 2002:a17:90b:3e83:b0:330:797a:f4ea with SMTP id 98e67ed59e1d1-33b513a2006mr12119692a91.29.1760046857536;
        Thu, 09 Oct 2025 14:54:17 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aabbe8sm885584a91.12.2025.10.09.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:54:17 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan
 <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis
 <sebin.francis@ti.com>, Diederik de Haas <didi.debian@cknow.org>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter
 <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about
 sync_state() pending
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
Date: Thu, 09 Oct 2025 14:54:16 -0700
Message-ID: <7hms5zlp13.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the sync_state() pending
> message that is being logged in fw_devlink_dev_sync_state(). In particular
> as it's printed at the warning level, which is questionable.
>
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driver
> may be built as module and are still waiting to be initialized/probed. For
> this reason let's move to the info level for now.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

