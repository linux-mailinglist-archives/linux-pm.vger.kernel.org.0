Return-Path: <linux-pm+bounces-32880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308CB30E4A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EBE5C83E0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C62E2DC7;
	Fri, 22 Aug 2025 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCvJBf5H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A272E2DCE
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841958; cv=none; b=R+9unHBKA/yv1eFhX3qngBtE/ViaLnkiUe3mgZbNvqJYsntOoJ78iwSp3/6iAY5s/WDFex4admJj8KcxCxwMoV9CIZghO6Z+U+LMG65iIK5Ky9EdlSYj6X+B/+PE0xiMX+tz3mb7F1iFyGmx3Ki2e94diSGsHPvFekbu4v7fK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841958; c=relaxed/simple;
	bh=7uX8JWTac+f6ksh/wu4QfEa5tteH904VkAXQGClcFe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1LIJ2jpKVu86O7cO/SWcbV3tx2JkR+ELZlQuCD3lNb8FStzaNz9rAEUO7pUD/bpenYWKhFv1ASXvIX1/u2mfZB7VqIcVwL+jexcXe0n2UeD974k9two8bh1MbJT1APCOQfxnzEWuDxegS4cZWv6tb6lP21lsdaa01QO81KaTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCvJBf5H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso2372172b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755841956; x=1756446756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YovWw4m77QAU1eZq6mNcpwZ3XWg61x3JgwqV7QjcnZU=;
        b=ZCvJBf5HSr33KUAxPzvWxalVdOcbjDmhI82eR08WZiDG8/Fd36sdv25cFcCu8lGJcT
         VLKkaCj/PPUX0nYm3uvzjT9LwouuUusb8R5QiEAHOREAww67piw1LPSGhCd7Ze5w662y
         gF3ZC57qBTQyVZWMn5GsOT84dbhwOQmRugboLw7xcHzQXESxhNEZYUeYEz3zEpyFz5LR
         1z892wHx3qTT0EUq6rGZFWPx8An20n3iSa/5R8svtl4++LWyK0bHvfOEXkQs52NMdWBz
         GxYV06tlhSrsU9veg/5bAJHpI1P6Mq3y5lQpXop7BAvE+d3HfX012Sgs2W+0sl65KcIq
         bvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755841956; x=1756446756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YovWw4m77QAU1eZq6mNcpwZ3XWg61x3JgwqV7QjcnZU=;
        b=XCYY1TVMpmhzZj0dmZVdErnSnw6rYmglgLOAfKpIDhJ6Mtb9K9EwNBy/Jp6cAdA42X
         704ZqETruGo0vGUd0Gs38WgRCRJdnOl0wo17QZApYyMHNAfiLjeezx1cr14uu6h/6Neb
         xBnwk0m+AEKv/ZkdjPDZaFZKmRWvkbj3F9vkpi6yxx7E6ybl8QtDc8omJxQ37HD16PyP
         AIfnHj92c9lUSOzTVvLaPvphATjKeLmXLxZx+MBg8wJzCIfMK/Z+g/f4G7o2Glny0Ypl
         Ma38BxdL0NpAKZVK4zS5ivvNDcpPNHr6bVAUzFirXg9YF+/qt0Pzcet58eddudjw5I0u
         Giug==
X-Forwarded-Encrypted: i=1; AJvYcCXl9vftk0V+pqtjPisdlqYDQLc/XMOoCSTdjsTHe6H05G9ws3Vw98gSjBIZijoHOeR9enLYY9J6pA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SaWt+HsC0m/uzTYZhzWwrwesBnhGoM0yzFSMiJGRbFSuqxYW
	vqHRdvH3/gHPSc8WYoXp7DcYJlx30tQLInwGGoprBBqKgt9ecfc+cyWbPZCjs11hjO0=
X-Gm-Gg: ASbGncvA37PY6FkgJGTVmrBbcg3s8oVCms5aRb+/LYKi/GfWeSFasDRRoV3WiS0m6/y
	dbSr16N9mP3wHGgAbn1CFAMCcUfEkivYFSxbw9CoBMaTUXzoGcNZ9YTdsMeU/6G2Ri96N2t3CDM
	MkGb4harpgY8g5EtQ9puO1lAvfs9MI6Y0GtI+4LfZBXQDizm9SYmx+amCDiEeLiKilqNqt8MrJ5
	VVSu+KN7u6IEtI2Ze6s5FYyugtstqPsbV07sI8wbc5sVGeCqMxj4iBOjX5WiDNGqv3Tee2mGEV8
	TnudAvsU7UvaDOvmuSLuQwzq1T/3BYTAEP6Z1v2L9LadHl8/5+xClbYdjef5p7LTLA82aIp2JhT
	cFp5+oNR2hquKNp63mtY6NG/n4VDhstHN2xY=
X-Google-Smtp-Source: AGHT+IERMmQ5QIMLdzGNTUZWTWABVarbRh+hsNdg9Eto0PuDHGxQR+AsczHzwOmYsK59MW3cwZ9ykw==
X-Received: by 2002:a05:6a21:3299:b0:232:fcfc:7209 with SMTP id adf61e73a8af0-24340e197afmr2543328637.35.1755841956381;
        Thu, 21 Aug 2025 22:52:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77037ae065dsm199357b3a.4.2025.08.21.22.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 22:52:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:22:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250822055233.otexzvta35jjnqrb@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
 <20250821092137.wttiixhiidt27hnq@vireshk-i7>
 <20250822081343.4041a3d5@nimda.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822081343.4041a3d5@nimda.home>

On 22-08-25, 08:13, Onur Özkan wrote:
> `ret` is returned at the end unlike other `to_result` usages in other
> functions.

Ahh, I missed that to_result() doesn't return `ret` at all.

-- 
viresh

