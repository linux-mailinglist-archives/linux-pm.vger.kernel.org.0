Return-Path: <linux-pm+bounces-29869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E3AEEE8C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3572E3B81DA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D423BD1D;
	Tue,  1 Jul 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec0cx7zG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5E24503E
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350999; cv=none; b=YTIqu2Fm6UlL+fVn5L+dCX7Hmi/wu3NQoHfqU/rIL8y2QLoLjwPR9K4c3/+dSqHLGlQ9odXpyeVGzhkgtGFeBGsuN9a38xwViy0jRdQrYUSGyWotNmoamUmj1VxJx76s6BFZB+3Lmoxfm1JtOfyd7JNECKmSd314bMUnE8nyn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350999; c=relaxed/simple;
	bh=Pkm5eBG02tWRKAdbUim2tyIzOe7R5n0k12DcqymuK0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzBICxUFaZEMHFGzAV3xF3xIndRZZS1cZBiQpgqXqkw4BVWVCa810pXMp4r1SLKb94RQS9SENp8iv2A1s4BICjcz7W8pFvQ6DEo8dgJN2INd0nFr7wqk5iGQ9naRqnmkNa+diWl1JFdUv70bQY21PC/1yJB/x2cZ3NH7+Y9MxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ec0cx7zG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b440afa7so52773855ad.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751350997; x=1751955797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW4h4Azwa9b41U/MJ+0olhYYxjHSpz1IrlhZfFrXOVY=;
        b=ec0cx7zGbBOa23C0PtT1hQaVLmY2Yrz5uzWzNP12IcHcknoJAHsaW8sQ7LqYzMMg7p
         oDDoEIYvLinIdHiK7EZwv2FS2YE5Z4Y8a8yJAY9ggw3J1L1nK+vknPlWHQNOVZjJyIIW
         4ns/McMFbQkQ44Nyi0b1C4CgnTDZ3iOfYUaoW/P6H/RrhMUt3yZg3e2qWBPBe77GIQnV
         DR6tKIf8bCCpm37yUjjhCA/0veiX5dPYTCVxq3KvuYvIgr3onJWNKSGSABmB204x+XeK
         4KGIrGBiTj1v6eO7wf1qF1JKNN3DOimL6lWTUuz92FEZrOhw/qmWK+fz7GQZpZvxCh8U
         G7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751350997; x=1751955797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW4h4Azwa9b41U/MJ+0olhYYxjHSpz1IrlhZfFrXOVY=;
        b=iSyWmers86ej72tBMCWol9gHdpq0bjDIIa7/b+51m8JAasqmFBAQ8Cu8+A2Oa3BJ9q
         0afnW19fqR3mM2vIwUOUxw1YK9kkNWah5XMSMPA3dr0yBnaButA3+lGzi1YKuETkozSW
         CpydE/0tXqschRzjNojpwvU5B8JQ6hJXdUau01V+whdaGqtNwZJNqps8Pt0AbVcyXGlJ
         izJlq708Kc8HsGzMu0H6jUZMTbj7fRJ3fwCAh2NMHItgIY8n99k56Wf7aCe1bjebJ42a
         m5k8p2ykF5ErFh1sND1KE+VzMRk0zwomrlDai7AuMJjrIDEgLpYgmlOlbJ1JqaIogBA2
         636g==
X-Forwarded-Encrypted: i=1; AJvYcCUnV+xZkby3Y2FyLKZjzIoTgOhA2tT89NN9ZCPsqjXhZYG66agptJB/NCLkAfB0zUztIcTgHf2HQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhiE3BgYPVQVAMrM3XPihfxbYt08ZyY2EKMuNBqm9e1nhugPR
	4qTToruEkMk6Kcy0qNo8ULcy6uDAa3SpxP7bt+w8TnKAfWfPkKK47zkYdAEFpdoy9a4=
X-Gm-Gg: ASbGncsdXF9fUijwHn2VOGiL+1Ni6xsRi5Kp96gzvepvPCRItXHcUhumD4TR9/zSKOx
	WeAzfeEoP8FWwUoKPhAbSx/SsILkQutXrs7yjkjB0AbmF6Cu1mvKLVme2puvMlhcWgcC7aQOIxW
	dOM04oMppxXCf8goOIy0zfQEa4II1HJln4w0Mp0LXnJ61bi/wFes/jg2FywFzX1nLOHGDnZ189b
	jTaVPCBFxZ16rJ9drxoeH7E3Gj78RpGnaGTCCBTTYiTiT0d/+qL4nlOqa4YbcPHkI6ijYJn2Gxs
	jCthzGi0cYuSkBY74oVnTKVKZTIYe1ZllCu6vV2zacekfF2jDGqv8fBX6+AdaFw=
X-Google-Smtp-Source: AGHT+IGanyq+1JfKGAQVUmGzDCF/NOtl/SVC9FC+zmGFUYpqyIfc1oMAT6U/DUOWZXgu5l+4XMVi3g==
X-Received: by 2002:a17:903:4b24:b0:234:ed31:fcb1 with SMTP id d9443c01a7336-23b330c6876mr34741925ad.20.1751350996743;
        Mon, 30 Jun 2025 23:23:16 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm105884895ad.109.2025.06.30.23.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:23:16 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:53:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Message-ID: <20250701062314.42hudnylecbrta4f@vireshk-i7>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
 <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7>
 <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
 <9826e66a-3474-4a00-967d-b7784ff60be4@nvidia.com>
 <20250605105151.5s6eblr472mbhunt@vireshk-i7>
 <CALHNRZ-uA6vHYbb5UdDvhRrNy5j2jyds4iTsiOxc6O=2nnedbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHNRZ-uA6vHYbb5UdDvhRrNy5j2jyds4iTsiOxc6O=2nnedbg@mail.gmail.com>

On 30-06-25, 13:43, Aaron Kling wrote:
> In my opinion, I'm thinking the original flow makes more sense. If
> resume fails, disable cpufreq. Then the subsystem doesn't keep trying
> and failing and causing who knows what kind of havoc.

Lets do this and move ahead since we aren't able to conclude for a while.

-- 
viresh

