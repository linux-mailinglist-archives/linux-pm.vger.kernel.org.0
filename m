Return-Path: <linux-pm+bounces-6978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7618B05AE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E25D2895F8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CD158DCC;
	Wed, 24 Apr 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x93+mF6v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7C158DAB
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950102; cv=none; b=RWxa9ZvK9N8Wzj7kWLSVcz365LNz93ZwV1A3wAETb1zV3WAOUdvWIlQ9CNUJzXbUOy2XGYZQJBtQDttoOPAH6QRUDdq//Xjtfy13+Q/FlzhkpN6nwVoajedNyCuiUZXQCkqxbx98jTsuIdEmflZx3vKVn5c/T8mpO83KDFphkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950102; c=relaxed/simple;
	bh=r8/8rUljBFL5uy21qYnpw+9WCvbmX6HKzPwVvP5HhE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ8aFhY+HvMcV8P7K79EX95VTWynmRn2I/gGA2VRf5Ipl2nTNmlfUj/yA+hLUWLm+W8JABTX+LJP/+9W99+di5qrCvb3JaXpdICULyRUo4D2DI5gUxAuY0lZg5nMKWJ27ad7p2V7EZlt/PIwNfcfOYzcyGDunaPogyHiushSoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x93+mF6v; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db101c11beso76502931fa.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950098; x=1714554898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NooyyRf4E8zJBxfzPXqF1R/V22BGn4ie5pOTp1AGeg8=;
        b=x93+mF6vAOUryHz8PFWITdeeXyoQ57JLRq7nQWgu6nX2y5FI8I5muX3Zs+1cc96dMN
         Q2JmW+KGSgNVqb5W+Q3D044JXSnkNSuACnz7AsfCAi/ZYPQiXqwWst6crNHAq4RRiFGA
         k3oS4ATtVd/xM9vc6b5p1867O2MPuPFGnq/0z8HIepyBPbbtS0XlGWMqChuJGfmBrF2a
         Jzja8tEf7QsA539P+38YVIEQ6eVrzyCtdtK/mfysfyEGmkF+fQ27HRwNIUsXpY6u5SvL
         grBleQPLJ322fZAwxOkSkC35ektd3sOdANUouk64T9vfdFw8BjbjP4vPH1Hy5yaj14tL
         VcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950098; x=1714554898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NooyyRf4E8zJBxfzPXqF1R/V22BGn4ie5pOTp1AGeg8=;
        b=tf1Ez08pyO4jAvtZpBX91pIKNuZBu6Rol1u9/Cl+sC8QviZh8hzEbZlqJ/If7B8EjK
         CSEVGl3H+b/HF6AZ/Scnh9K86OQFDqLxj5X63/QroxeyAQU5jPL067WK2OYdezJT8kNZ
         YegXbOdH6ywh2+HZGtpOB32jIdpzWuejFu72KUjDBYNDfWYvmRoxvu2FBdRHy1sf3Sxw
         MzhSF+zg/kUDdeYVrpMqPafvWLm/gV9W8Ub9lcrgyg98WwgbrZqmOK/cG7rWlSlo0RZI
         fAV6tCE3ZmwhWtrVCiUCab2KqGKcwMt2DmVFMniwGlBpjjEQqN68P9vQOmXgvIsmA+9z
         w39g==
X-Gm-Message-State: AOJu0Yyxj+FTouDsvhxJ8U6ysDJJqQGx+CwiccLxQb+XhTSJAkUMlmiu
	OVIkbH3BMTW17Bnmjw95A/HooVAbEv5qxpD2GRCoavl1VHT1pDykGs5YKWBuTz3vwmaZB5svs70
	A
X-Google-Smtp-Source: AGHT+IHPjVkFD1fyW4SC/czA4LlNzOrQt3ZbtnCgnujN2A091L774ba/AnGg3Pj5wvDYnAl86nSCgw==
X-Received: by 2002:a05:651c:1043:b0:2d4:54f2:c409 with SMTP id x3-20020a05651c104300b002d454f2c409mr1089507ljm.38.1713950097610;
        Wed, 24 Apr 2024 02:14:57 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm21018608wmq.18.2024.04.24.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:14:56 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:14:55 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
Message-ID: <ZijNj7DzL9e01Vnt@mai.linaro.org>
References: <13515747.uLZWGnKmhe@kreacher>
 <15186663.tv2OnDr8pf@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15186663.tv2OnDr8pf@kreacher>

On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notifying user space about trip points that have not been crossed is
> not particuarly useful, so modity the User Space governor to use the
> .trip_crossed() callback, which is only invoked for trips that have been
> crossed, instead of .throttle() that is invoked for all trips in a
> thermal zone every time the zone is updated.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I would also consider removing this governor which is pointless now that we
have the netlink notification mechanism


