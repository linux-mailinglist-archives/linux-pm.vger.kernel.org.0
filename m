Return-Path: <linux-pm+bounces-3236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3684706D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E9AB21DF1
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439F15C3;
	Fri,  2 Feb 2024 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BecGpAEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211615B1
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877376; cv=none; b=Ez5y8t7yd9PA/fFvRLqYeIGLBkZvOwLhoWMpPWltA+ZpOK5xlF1HJ8BtRcxHdIRkNhiJd4da+JnXTdMw9BBiyZXSj+WoKvWW+e8/LttgoczdAgyWN1Gju2Srn5bQ5pTHq9VhpVdATchDcMRShtOdX0vdgXZmaGGMTjQbMHxVqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877376; c=relaxed/simple;
	bh=zHSbvZKIpwpf+vEsdUTmuAB9R0qXTT6qlxNFk21V6NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCo188Vj2HBH+cRoOeN8JJz/eK6NHvgCMWZP4BFjwsAqGss69+Vxisyr0B3ibUoRggHCNSY/kUm2m23Dr6mVxkD9S8UlH1EeHWLX3G66UVAbWM3yyFDaJkdkGUq96o9VytSKCTTxrzlipPUXK+X0wGc4NzzZqAKJON/b4b13FFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BecGpAEs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fb804e330so18183415e9.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2024 04:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706877373; x=1707482173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcYX27e2Ty3hZASTAGqJg5ra4tR8k7k4vqaPFn1J56c=;
        b=BecGpAEs2QBahB1CkgkG0Twk5Xy1bNrYEuW/stqz5Xt2bo3lMyTyCnCryATHrTEvRQ
         rDrFt/IJ3wmVaQyNmxfbz5ZrlCLJSbciHGIVGcMvemJNUNPI5OiTimuGV03jLDXuzxos
         swWXcIEcV29n19T8KRBqlMYjKQGBynwnaXFC4DvUIhMEyse5iecZDyFQfMQaNj01zO/L
         Iu804Fr4/W4AJfxY2ls0GQnQ/ie+fKDsExPX+zXD3fWKEMMJAgBNv2n3AOjHGJpW63+r
         KGQZtGajYoebX8RkbdX/Q4fVb1btzXKB4JjECHWNrfLptGuRRcLVWLuWlkEbMKDVSdp7
         Ao+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877373; x=1707482173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcYX27e2Ty3hZASTAGqJg5ra4tR8k7k4vqaPFn1J56c=;
        b=udVYR2NcfOK8WlsXo4aBCAwonJQqWgzSwIfCpzRgOlr8DEj1QfXFxtZxphgAdP9vhw
         EY4u6pmppwmH+Gf8LFvsnEvOP/3QhJv8Fu+l4BGZ5vv5/B1DuaORFLYlAg0OJ/v3Vj8q
         gpZEOO8VgzYxOCmrksvPXmrR7cX8OF14a6e66IllBY/w3dX9zi+8KTiNjZcUEqoYKLKh
         Jn6EahLTSzdIlnY+/ewEss+plBgsjowfNIuFouEuzFHhPh+7ZrkqLKQEd9a1x/XDAiqG
         bUiGAoSfpWrJD+FOp56iAqJ/xP2Du7z67pyOCKcxOJdjoz0DOd2HPVG2l/dYxfh9wq4G
         f76A==
X-Gm-Message-State: AOJu0Yz1ALUWmcVU0DC30t5eLhvnlFw5J5LVNKk9BaQKe/kS7bHHZIsh
	8vxa9DQ1O0LKYRTFzBDmDQFYT38Yf5phFP2lGqE3nwJoCQBCemmmkriVRm+TO3E=
X-Google-Smtp-Source: AGHT+IEZw+6FWBNNFcCZ0ZuO0WzU8vuHItXhjVOimP1DfU1K4DGI5WpbkcuCpeBHF1NMiGxaQW2CEw==
X-Received: by 2002:a05:600c:a384:b0:40e:a479:fed1 with SMTP id hn4-20020a05600ca38400b0040ea479fed1mr6498342wmb.7.1706877373027;
        Fri, 02 Feb 2024 04:36:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6o11LWyjlAwHhpuvySp2THs4eLj+FMyAcxTkag0xUgwaMIijwAJqrtvzDr4T4bwn8XVyx9SwmuIiulvyxTsnxbEzwjarAsEHrpgm0fYsbFIy+iPJgW+6x7qDqeoPC/CZyLup8YQLgmzx+zbzx05fFkotFWPHFdYcdqTJh/sMVeesN5WMbqG6B5YHwTzUZDlSCH8FkSHm7oypw5B5Hx300uSRJu95+W7SJbj8HJo4rm4aM86J50+Yn6cnpL1saUj78/ISs0Az3Elk0nMn+XpUXZ2ZXcj4Kmh15tSWq6y/6F8PyZFfJyurkCCCTE13oS7LGH0Bz0VCVXBn8aui/VumfdjRI3S2LaWrBNV7tBh3XvFqlN9X9aiH+4DNq8+VjtHQ=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c021700b0040efb8f7158sm7209816wmi.15.2024.02.02.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:36:12 -0800 (PST)
Date: Fri, 2 Feb 2024 13:36:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <ZbzhuXbuejM1VLE3@nanopsycho>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>

Wed, Jan 31, 2024 at 01:05:35PM CET, stanislaw.gruszka@linux.intel.com wrote:

[...]


>+static int hfi_netlink_notify(struct notifier_block *nb, unsigned long state,
>+			      void *_notify)
>+{
>+	struct netlink_notify *notify = _notify;
>+	struct hfi_instance *hfi_instance;
>+	smp_call_func_t func;
>+	unsigned int cpu;
>+	int i;
>+
>+	if (notify->protocol != NETLINK_GENERIC)
>+		return NOTIFY_DONE;
>+
>+	switch (state) {
>+	case NETLINK_CHANGE:
>+	case NETLINK_URELEASE:
>+		mutex_lock(&hfi_instance_lock);
>+

What's stopping other thread from mangling the listeners here?


>+		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
>+			func = hfi_do_enable;
>+		else
>+			func = hfi_do_disable;
>+
>+		for (i = 0; i < max_hfi_instances; i++) {
>+			hfi_instance = &hfi_instances[i];
>+			if (cpumask_empty(hfi_instance->cpus))
>+				continue;
>+
>+			cpu = cpumask_any(hfi_instance->cpus);
>+			smp_call_function_single(cpu, func, hfi_instance, true);
>+		}
>+
>+		mutex_unlock(&hfi_instance_lock);
>+		return NOTIFY_OK;
>+	}
>+
>+	return NOTIFY_DONE;
>+}

[...]

