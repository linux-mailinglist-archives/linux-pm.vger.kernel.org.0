Return-Path: <linux-pm+bounces-3721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D409784FBD7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD0B2819B8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221D7F468;
	Fri,  9 Feb 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AygMFGNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3A7B3D2;
	Fri,  9 Feb 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503340; cv=none; b=WYAyc6Abd7f0USi6EYuGulqbMtx7UYxpKOTMmsMjPwuTitjohXczAzshrjfHd2PlvFeDPCwquIY2Ui1ZKcfbkuWNzz7EXFKiSH2daZpZqMN1z3Nymznr7S9bqiCm1vS7RHifLHctPnalDrcq/7wlhmcNpIoFHyO8l1M4gMaN/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503340; c=relaxed/simple;
	bh=jp1pGFRJQF96Bq2cQTm7TefoLYu14ighWJyrvV+4dMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUrYDgv+ehSEeQtZjegPU4nN8TiX3wETHwA/IjixGw+jcXMAqQ49Nv8H2kZQdD4nVi6lBP5CDyo7bogHa4hq41u8fHy0q6nqT82mihzjv8YKEhR6Iwvi1AWk6BUXZahFrcBCdefgC2aNgc0CxKNh4YZXwPNiqNvdzbjOXwn0NGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AygMFGNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF15C433C7;
	Fri,  9 Feb 2024 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503340;
	bh=jp1pGFRJQF96Bq2cQTm7TefoLYu14ighWJyrvV+4dMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AygMFGNvNITT3nKABJMb7Fl9O2wHh3Y2+jafHra6v8Ki1IHA2IxJiImg+OTDHcvGe
	 w0GTctPtXb9LvJqR7NUjCOVjIDO5wvT1TiVkO5wVEMn5ngCejMyPeUfZZy5bNfgMNZ
	 Iv/Mz9WjVNTojAnVCHX2BTm1TmNj81tpE+VSygtQt5OzYIMeiOJGeJ1exv6w3xlDmv
	 zeIDVByXtT5+Us9SVY0ImiG2e67fdIsCGnSpZ0apBizQriMK2+bu/7sw3/ugHplJyb
	 kVCX1HJQIK9qAKFydyvG0mokB0l1RhLRvU0GcWDzOVNioQSxcxTrxlDpTHNRadC1qw
	 8S8TZ2QPdt4Kw==
Date: Fri, 9 Feb 2024 10:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/3] thermal: netlink: Add genetlink bind/unbind
 notifications
Message-ID: <20240209102858.51b06efc@kernel.org>
In-Reply-To: <20240209120625.1775017-3-stanislaw.gruszka@linux.intel.com>
References: <20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com>
	<20240209120625.1775017-3-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 13:06:24 +0100 Stanislaw Gruszka wrote:
> @@ -48,6 +64,15 @@ static inline int thermal_notify_tz_create(const struct thermal_zone_device *tz)
>  	return 0;
>  }
>  
> +int thermal_genl_register_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +int thermal_genl_unregister_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}

static inline :)
-- 
pw-bot: cr

