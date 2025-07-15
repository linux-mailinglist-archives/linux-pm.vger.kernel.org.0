Return-Path: <linux-pm+bounces-30864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E552B05C28
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DA3BBA2E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCB2E6104;
	Tue, 15 Jul 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCLxxMxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD52E54C1
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585851; cv=none; b=WieS5+9C9CAqrdZ+XXz5AUm+osERLwaAlI531XlIR3mWMGvmtXz07jQh5Bwb/prd+TIy8ag68PBkPWhbPisNApVU/avelyjeb611UL28lwaZDfvFV/GpmX4khtNGng/xhP5bQ1OgtoFwgNqz01DniGzzSOCL93WIwbFw5+ml6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585851; c=relaxed/simple;
	bh=xu71qnr1VwTZ4+bd4q94HN3+XBjexaGP2P8tok7p9Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7MUodLex09bF4bWHqEQt86XX8vXiqxah9RgCK3YYrU5P5/Jt5UBDVHF0n/7QYtetk4oE/3RaZdBdI6Q6Ashe1DPsUUY93sQigC1hkhLhD8UMEONa+6/686+xpc9q4g/J5LjEqhECAeVCVI+Vzf3D8oAmSJ2oS5QkbWeAjzbCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BCLxxMxj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561607166aso18096525e9.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585847; x=1753190647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOiczrZQ07TlImzuWhdRA1uRrJzdt3bEMH2PMY2Z0lI=;
        b=BCLxxMxjX+BsYdczI2PSq8IW0/VxPm9g3jC5+pqWRmgUjdRP+BLP6LYDgp0E78Nljp
         byjdEKxUXnvWU8+P6DWfEUdHqodCUGL8Gu3qMzNzB53m4TmuqkIEE3wqcS6qmpxGL4Wr
         Ytek1ahFCpIGgOVKyDkLDhrh+LeY97hT61qBZiWWDmY20RKZlzHrg86+BkrusHkEWZVe
         7qlhLwd21OlluYotwk2v3tN8+8P1Xlhfc+V3ItXJ0XqI0maX+RWxZeRaXUbDm3rGf1PF
         fl+L/4a7dxO9VVGv5GJ1tz90QAs9n9IIstZjI0YwofAki6KVeAaSR+FWQq5HUdpnFU2T
         +eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585847; x=1753190647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOiczrZQ07TlImzuWhdRA1uRrJzdt3bEMH2PMY2Z0lI=;
        b=YxX+6enRXp9xGVNxWZ0i3sneQ18h6i8qRCQeyB4rFfATBxfr3jE55qPKoWep10RTq+
         +Rg6De+g0NwOO5W6S8gm9o7xObXVccgr77S2boOLSggubwG5YTv2yuO9lgMBRH/0dE7k
         vfOEXYj2SFmIohPtQHstIZX3LZza7b+Id4cXS4sq1e4raX7voyNqqfZ5ZbZrtbfibh1P
         sTYJO5fI83BanHJSWD6xd4uBl40C/kJZ2LH5ZOqdZxrpGaxXwlCv/TNKQ6foIA2Ru7e3
         qX6MlmTNos6OrU5xnD+GPGjDNpmPKQqx0uMsvZmCVqyyTog24Hth7EfByyKW9FJE7g+6
         7Yaw==
X-Forwarded-Encrypted: i=1; AJvYcCU590Psun51d4oU6gNoNimjrrf6bz8hFVI/e9ZehIadjzXlh7aMwjzwQGlMYtBGiKWcizprNdsjBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHhfbSILAtmSIKPaHXlR5zxmGODGzmFGtullZCT2Zy6qxxRRl
	3qmUsA/GYmIEBrE4S5oQNI3GDOGqDTuIkmNMlV+kubzKdB/cbfA+u1pUwAAYEA/s4K8=
X-Gm-Gg: ASbGnctMzK6RzLcxYG9ESpJwDF7Jd8lpbgI/CBLlgLEP8gR8wsNsjjVKDe4X4vwzVXH
	O+ZEcPS7I4Ec2FeGtxPzyCWWT/qF7LofRnPMjaaXl4PMiSUGhBktahDQvCgKEB7uW7U1rcg7cIl
	V934nToTZdpOdkRYcR/7l/hq7+6TnaREKHifAZ/nUzXgMdZVOMeSXUeveD2C/637Gj7of4m8ChE
	0PRCgqaH5+/44QeynLU5899dgE+gN8dQXrr9rSzjA29wgoCxmai5pPEfzi5ZZEP6v3P6Bd3ZeqM
	wt+HG+0hLWBeTk0M6qaXUg2fIeSEDGPKVouCse1JSI5BCpRFmhEcqgjVY2uKmqKs6c6rl8EwP/Z
	9Us9pIrmIrZmHVrfGCfJ+tdOce42xoTIKRKbrCZWGYhYHUxHknIG4izAoGqXh
X-Google-Smtp-Source: AGHT+IEs+ScYaBoPod0KS92i4ye+McpE9jOei8lbZ41OgzZYALXJoP1+s9eQ2gbL76aM01wUZbMIAw==
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr71744425e9.13.1752585847534;
        Tue, 15 Jul 2025 06:24:07 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561dd91072sm49780995e9.14.2025.07.15.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:24:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:24:04 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/loongson2: Constify struct
 thermal_zone_device_ops
Message-ID: <aHZWdMSYDsjebRh-@mai.linaro.org>
References: <5f5f815f85a9450bca7848c6d47a1fee840f47e5.1748176328.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f5f815f85a9450bca7848c6d47a1fee840f47e5.1748176328.git.christophe.jaillet@wanadoo.fr>

On Sun, May 25, 2025 at 02:32:30PM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' could be left unmodified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> This partly reverts commit 734b5def91b5 ("thermal/drivers/loongson2: Add
> Loongson-2K2000 support") which removed the const qualifier. Instead,
> define two different structures.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    5089	   1160	      0	   6249	   1869	drivers/thermal/loongson2_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5464	   1128	      0	   6592	   19c0	drivers/thermal/loongson2_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

