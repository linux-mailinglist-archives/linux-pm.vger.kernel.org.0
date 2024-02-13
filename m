Return-Path: <linux-pm+bounces-3864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5978852C01
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 10:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F4B281BF4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB81BDC2;
	Tue, 13 Feb 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tXCiCE5C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D2208CB
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815489; cv=none; b=jdUh4qGYvEeQyZqGOMDN+bJvolsJSRJjKaAOt/sq4hLeAp80uhP9HzgP6FEAhphjjOK3QAsYfQ3UramOhIFWc6UQuZStZ9n3SYO4xbWESAXJh084qiXzmZZfmxJP+vi6/mlWw4+h9Zux0QdYqrG5guk+4QLbCvLDlzGqDYV09QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815489; c=relaxed/simple;
	bh=QYQiyRsTrGWOHtI1okoVZVMd1Kpke6P/ScBdN+2bOXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVE3DeJzHL9d/xUtOCPf1t/xBMlVm+h6DgbZQkfq5p3I89neC29qwfnnZJPxpE9SalBPX+EuQy6hJrDo/vcLU3R+BvU+u2vG1582DHJYRP/DdRixLYmEpEKl3aQxhirRAsoJZna2G2VVzrIBvBhiV3MegjGe+HzmhbHq/1+Fubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tXCiCE5C; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0c7e6b240so55711471fa.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707815486; x=1708420286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYQiyRsTrGWOHtI1okoVZVMd1Kpke6P/ScBdN+2bOXk=;
        b=tXCiCE5CxLEqZR2eZrN6tl3WEiqK0qt8wglzsoM1EU92aM4Jv3bcrBrYHtLtfXfH4/
         Kr4Iz3AbFIHX7BPV5R5/rapLUCpUhUO9EvTkHWVEbsDf3joxeeFyUSaZRQgXvXGn3EwT
         33LpXK/vG6WoeAS2JIDobhFHZQ0X/mVt7jGHennBpnSEBNGxRlduBUBECeNcli4Nviqc
         IUgNnU6RYA4OZmxRghlnSN+zyjCx3WNTkScdU72ZDt9i/6uwBH1v+qI4ndR+4PHq+prr
         MdiSfGxNeJX36T31T+WR3Qh4vMciKH/uA/KC8ATWAd/9Dssbqa2mZ5VVY8S3NI3pygo6
         bxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815486; x=1708420286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYQiyRsTrGWOHtI1okoVZVMd1Kpke6P/ScBdN+2bOXk=;
        b=mjKe82kNYWXtOdcXUr34hk1eY97MQ0qy5+nGafWgp+36qy1w7gPAIDxEGOFsBpLkFD
         sJ/Ee1BW8dbQrtwPoOy6M6cs3uZqsxLhkKQnJbrsk6U8cooi2bRszjGlrvK37KRJcBq5
         pC6/k/plfyVGk0YcyHFYZveGZO7To0Bi9IZwCrb3BuwNoc/2EbeC9LVjgOxbcYILmdQB
         2QdV3t+uLPBo2pg/Ab2CAgQ6MZX8e96Y/LiZHlgyTFPHN+BL7qPDQ9QvuHWTqmtamd+D
         1UhRh9aeyTGpjcNa2LCO9Ktj/7ZdKNzToTpAHB/9OaWgIgh57/oEM218TJ4PPHviJRc5
         EJsg==
X-Gm-Message-State: AOJu0YyqpcdR3xCmxS2CnuQBBTnmt0bKfIDaeBZr5ELudaQ3lvjOOelM
	u7DExzRv/Dnfh2SPQrvO4QL2cRDzPwS3kpjpkk+sFwIt0fwHkFBjuLDvWk8HsXQ=
X-Google-Smtp-Source: AGHT+IEfOhZGwfbkOsKwwmBLCugxWKcTX42O26FHcM6XU6U4oyjFx8gMroMfq5usbHqV4jj7XP5Ohw==
X-Received: by 2002:a2e:b0d7:0:b0:2d0:cc80:dc94 with SMTP id g23-20020a2eb0d7000000b002d0cc80dc94mr5561352ljl.19.1707815485776;
        Tue, 13 Feb 2024 01:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmoc8ptvo5DnaIeq7BFh1RBW5os2uzwZVwwuUiQGS7mMi+t9gMXhiYebabQgcw9C13HIcU30A54JVKeBVLX/uDmy+b8CPEDHiDg8KMj/C9NesA0wk47k3nW9B4wZT7iSc2G22aDqOe80cnRh3Q+yZyWqjdRr9yRuCV7ZyEb5LfHT+a0func71szcpWob+hPfOxLY6tQp0gaYG27/Fb3g/y1IlVen+XzuKY976WRq3ytTGVaMuEcx7OeJksxM0aIIxZxT33gOI+iQNOlcvIsXZFCVwf6QF23eWPpCq9Z0qM+FE19xcla0FSpwbYMkYx1l8Rb+uC4+Mkpww2mccG66nMadZON6Fa7sc0gK9NtrTT7kW3FzpBuc9YjCLrqSQnD9tHti+9Deq80Sb1T6bE+kR3Vipi9PI6LKfnJp8o2QxQDAvLNyM8d9+HcQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b0040fb44a9288sm11022334wmo.48.2024.02.13.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:11:25 -0800 (PST)
Date: Tue, 13 Feb 2024 10:11:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] genetlink: Add per family bind/unbind callbacks
Message-ID: <ZcsyOsALeuPEwk0T@nanopsycho>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>

Mon, Feb 12, 2024 at 05:16:13PM CET, stanislaw.gruszka@linux.intel.com wrote:
>Add genetlink family bind()/unbind() callbacks when adding/removing
>multicast group to/from netlink client socket via setsockopt() or
>bind() syscall.
>
>They can be used to track if consumers of netlink multicast messages
>emerge or disappear. Thus, a client implementing callbacks, can now
>send events only when there are active consumers, preventing unnecessary
>work when none exist.
>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

