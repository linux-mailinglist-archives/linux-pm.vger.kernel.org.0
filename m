Return-Path: <linux-pm+bounces-40348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533EBCFC21B
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 06:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918F830141E5
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D62641E3;
	Wed,  7 Jan 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWywaJas"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E96235358
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765467; cv=none; b=Y8CDIyiUPpwJjbF+Tii+NC8mjKZJzgpDZjSPjsaBd9Q4N/P5XjxVgUNhVs8hnfj2QKMGhL3pFRnoozhPlbuzFBRvPfCrGTG2x/YWFfYxp5TsYPjhbmPP/HP5Qai8jnQRFRa9QBxnswsubLVrWtJxUzOuHO6SbZPHxlh0+StNiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765467; c=relaxed/simple;
	bh=iOvdWPELyx+skLN7UXWLkA+/bXZVeSPWgX2ioqSAssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCzbHyThmhX0LXuTpBE3f7DcZpMaMQ0GyL5RP8AzyfUgp49Olv8ZB+JoBPzY6jfczbWfRof4cjN4B+8eDZmyWFRxGlS57zMn65inq5y4VUYZXdTHj/FkB6M6gEyUKatI7t1spM/cgNQQaFWOQ9y9o9qegQ7YBmDXNtwalDh5Zx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWywaJas; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c1e7cdf0905so941300a12.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767765466; x=1768370266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LC0H7XXkEOYKc23QOgFpX3RRHegQ2qJKsip88CL9K2Q=;
        b=sWywaJasLS0e25dnLyTHRyLKKNw/GbbpcHZjHXsQtmWlL2D2mPJscklhT8TNgv4x70
         NW4dtQd/N5uGbgm2WpXWmmvQPIgKz6cRelmm2hLfKT6EX+CgfJwkEL3kHwSRcHLywlSi
         YvLmZe9RUIeNu6je3R/VhYp4WsJS54xWq4Qjj6jLUSf5om57IP3CJWOdxbFX8KkX3L41
         aWk8ss69lN/kM/m0lk8g7MzMhwCm932F4UmZvck6j6jV28np3LxfUUkovqSQhge6J9m5
         jgd5o2RXUSs2Svf/JSrKTna7tmXscpCj4SWiIEqjsJ9QPRrd6YfD5FEkwPagzL3aa8yq
         gZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767765466; x=1768370266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC0H7XXkEOYKc23QOgFpX3RRHegQ2qJKsip88CL9K2Q=;
        b=AzaoFSCCJ2luBLDrczBr8P9ZAIdYGidAN/Y4pAOuFrQBVhLOdOjGhiR1/iJE2OTzUX
         9b0qx0wDkEpLoyDJljNtVab/jTDFTNeojKvORW1i3H6SLGlh6PCEm0OY8CfXcRcL5w06
         omkzf1/ygH8JHgmBHC1JUoTqWvAN8Lr1obfYU2iHs3/4qn4khlVavv/i2JeQ3DGM48rd
         bqOiXvsZ+b6zTR7iuNQs2oQ8PbIbhaJexvgFdUPa6j/6tIfi6wHtGUAreIEclKAhozWL
         49Ii4dpv0s5EBwz+74wi/2OLcj77wFSsroMuoPPcY3ixD5AxhDINxQDRamPJPQ8Vqm9D
         HgAA==
X-Forwarded-Encrypted: i=1; AJvYcCXIJe60mbi0+w/7lm9aPtBNlbN9HQhwS8B1OBRQx+iKtDjXkFD+ae6XeYsN7jihsq60Q9XJeZYJMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwupSNhMUzA47F45otBzvL27fAbR7HFjXmGtCT4kPn4u7q5Zo4D
	AuEjzurG3RGwGWzsXTv8Id8Koo3DWn9ynMLmiRJPColNHj/Usxeeloen9GlZCV9m0DI=
X-Gm-Gg: AY/fxX5rSuL/qYh6L8bXJX7yTAQ4ihwBSVmGzxE3P4DEyOoIXM400R9qS/D7JpsYIqB
	RnV2U8NTQocynpMG8ZengbNMyI7aomUuN7VWaZVFeb117kUccp0bdbphn4WeIsU2UeEMf+7r7ar
	pryiDpeMWLYJqs+7MbxG1i8mZPS1Ht72AremlrmLipAc/QlYCWhef4Pl6WF8Hja8qa1VI2ArFCR
	eFrKNCwEafBwiUOmY5rjDroLv4CCu57X9tXz5jgVy7lKFkDdZcAkBIDO6pT3fGOLokUXVXGRIZ5
	NTfpCc79kQ0bJFR79b/c363JX3FQYjwbU9lkhy4cEdyk6t3cQtzcXFHDHdtJtIXMtO1g7l8lARw
	lMVkcsfY2KD1pqDdpIEu3LEovKM7HYHVVfpRj8DJ0I2Ffeln8RCjEgxSf7slyBa5seTuZeMqTun
	qAonfBs226iTkMnanJPXeYGQ==
X-Google-Smtp-Source: AGHT+IHbKbuUiaGFKdL4diTpNeLR/j5eosCfbHWdAQ8rrrg+/KnQsIV8kE3nI8jz4VVgZv3B/kEBbQ==
X-Received: by 2002:a05:6a20:7355:b0:361:4f82:e545 with SMTP id adf61e73a8af0-3898fa1f824mr1336775637.53.1767765465528;
        Tue, 06 Jan 2026 21:57:45 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8d76sm38106705ad.84.2026.01.06.21.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 21:57:44 -0800 (PST)
Date: Wed, 7 Jan 2026 11:27:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, 
	Kevin Hilman <khilman@kernel.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Message-ID: <y2xyyyyhdoxflj4doa4y3a7prjqulcw63bdkor3fo3qsbmxvzy@dvhmfxkkzdqs>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
 <20260105101412.0ac7baa7@kemnade.info>
 <pjmwnxp6wae3bbmzmzys4r5szw6ywxphi4qtmpmg7jsqadc5fm@fvozoujr4mi5>
 <20260106182946.1c54d769@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106182946.1c54d769@kemnade.info>

On 06-01-26, 18:29, Andreas Kemnade wrote:
> hmm, it is performed when the device is removed/unbound, which does not necessarily
> mean the driver is removed.

For the cpufreq drivers, the device is normally never removed. It either gets
created from DT or some platform specific code creates the device for ever. But
anyway, we were both talking about unbound being called, doesn't matter if it is
the device or driver which is removed.

> But that does not prevent trouble if something
> is still trying to access stuff here after driver removal. So it is not really
> helpful.

It is not possible for something to still be using the resources from this
driver (like the global variables) after remove() is called. If there is a bug
in there, then that needs to be fixed instead.

> Hmm, how does a device gets bound to this driver?

Nice catch.

Tried to look at history.

commit cb6675d6a868 ("ARM: OMAP2+: Remove legacy PM init")

This commit removed the platform device being created and mentions that stuff
happens via DT, which AFAIU, creates the cpufreq-dt device instead.

So no one should be using this driver since year 2016.

Kevin, Nishanth, can you please confirm ? We should remove this driver.

> But the fix is good for stable. So I would propose to add this
> fix (to let it propagate to stable) and deorbit this driver.

I don't think it is worth adding to stable when there are no users.

-- 
viresh

