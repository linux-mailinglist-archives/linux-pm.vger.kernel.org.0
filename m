Return-Path: <linux-pm+bounces-6979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DE8B05E2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFDE284DA2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B85158A39;
	Wed, 24 Apr 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoed2c3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE093158A31
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950259; cv=none; b=RhqPyqR9JHaZ3Lfx+GzD6DwOZy3DjviZKv8L6OP17bJmZMCbBfBacpWIv2ywweW3oynthnOD7D5S+pIhflWqMpFQ4Mqgn2YtVPIZyLzXHJpOEcwOxJz3egqpIOufAtoIJBJ93xLNoGEw9Gz/hIPzLPgvRQfpKkgA6/yJLdVqyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950259; c=relaxed/simple;
	bh=6v6pmpTVgPnI69pOfFGBY/7JqehyACnXXZ0pMSagnQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE8Mkj77gQezluUC0EZ192ij/Ro0sy7JpkGDS2dl2n9qEANz7W1yY7HuLEHAhNe+aSAsDXSW6A26O3O/OIYsskm4CAjcGi75lxMY9M+64gtHJUTv50Glzy17Q+P9LzeeLFwWRI/9Qmv/XzOandf7I6WIlRiQ8RiQzU9/PLqp41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoed2c3h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b09fb205dso2097635e9.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950256; x=1714555056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvNYwGwejd/vmVQ4glqR5CH2PWp5Gxwed8vZAqZp1Hg=;
        b=zoed2c3h0xMzyt9zrL4iIYxwpVShNECzfE1WZnOqufirHjLIDARNIHGb6AJ0uwbmNz
         ED7jSiIdZsaPku9YeY/wiIL03xiY8yEZiqc/EK1P5Cnx9cvTvMYjnhJcftvxvi73K4d0
         g30oR3e5/HWcHn9HeIF1WrHlJJ7ujQZ2Pf/7NfFlX493aAz9ASjWDgPZ90WMsikKs1NL
         WXYumESkVxu39Ved948ynXbS7DMj1a3z6+DvqLon16QL3Om4RfuKl4EqZNpLBI32M53W
         XcyfgXFOmbtdbHLXXssAAYGImnj3EkvvDNcEH0kfhQ6B4B8E7UHfhXWjg7pwr9aReRd9
         nnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950256; x=1714555056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNYwGwejd/vmVQ4glqR5CH2PWp5Gxwed8vZAqZp1Hg=;
        b=Y2EmO0Sr+pdqNPPZhBdsdMPWuqScAc9Fhl9JN/5efVvK3TgTeDFPB73cPP5leJxwOg
         cUMWRTaXndH4Xfh2dHZfwg7FYIpURjfKF6Kwx1dE40piKQNye2RbKQOCWuhXFViUrs/H
         Q9UJ+2Lh6B3Q6/xOrG+yUwrxKlhBOrCx7Hmu+OwHQI26tw1poXe4eOTB4fIxF/9A8Hbb
         gSP6AyjzeXBaKPZ3GFrEXPCYcqovd2Qw0fEFPm7MJ41T3MXfhozEfZfm3+jVBwvhdSCy
         b8qrJIJ0By1OBoFOXTDsxsD9FlrIzm2FjNTFyvQqf1LOr2wKCTeGFuxBodfh9zJe5G8k
         +86g==
X-Gm-Message-State: AOJu0YxoCmRGSCdE8wBEEwCxvUHDlHh3kzHHa/5fjXHKpWVgkKZEcTaC
	9Ht5ljEPnUNmwzchi5jhUZDw36qCpLHRtKvP8u6dWsOdA1rqLW+OOTvRpdhtTAjZhjooOYBo2vg
	Q
X-Google-Smtp-Source: AGHT+IETBR5NRDJvnmT+4jufXRV4MUnA6U+OX77MdwUghv6OF8LCeQsDz2Q0f1bV/GCLa2wnLyjtQg==
X-Received: by 2002:a05:600c:35d4:b0:418:f184:53f8 with SMTP id r20-20020a05600c35d400b00418f18453f8mr1605318wmq.36.1713950256284;
        Wed, 24 Apr 2024 02:17:36 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm6491155wmo.20.2024.04.24.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:17:35 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:17:33 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 16/16] thermal: core: Relocate critical and hot trip
 handling
Message-ID: <ZijOLZfQgQYTBzVl@mai.linaro.org>
References: <13515747.uLZWGnKmhe@kreacher>
 <9337957.rMLUfLXkoz@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9337957.rMLUfLXkoz@kreacher>

On Wed, Apr 10, 2024 at 07:44:34PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] 
> 
> Modify handle_thermal_trip() to call handle_critical_trips() only after
> finding that the trip temperature has been crossed on the way up and
> remove the redundant temperature check from the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

