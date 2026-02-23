Return-Path: <linux-pm+bounces-42982-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KiJOe2Ym2k23AMAu9opvQ
	(envelope-from <linux-pm+bounces-42982-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 01:01:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E91170E16
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 01:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049DB302262C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C421799F;
	Mon, 23 Feb 2026 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ik7jGYFq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411F3EBF06
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771804894; cv=none; b=glkEZ+gG8LVUZKj2kTELc5CVYK8QwivzyV5qdoGKzqgNJ41AsjK3mpK31jHdo8k5eESR14akWbXehS8Z2NwBMAuLMKKRKvPk9gBFWYyIiGMLa+h7WvRObZWm8bwR2yQqZmmcwFKQlPjCGUqcmqbTW/aav6w+PVaJN2tcEenl+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771804894; c=relaxed/simple;
	bh=ZFV4pbi0wIK53693SAmlhLcWSmpe3LjzqEIO8JvTwJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP3Ex2bGBdEXRHym2tzyBNS0uaA8rxU8lrL8Krn/c80MZKBxMDRse2zx5BK3SND4rI/TJwMUE+dToB1QKr52oYYqO4++lcKV+FIhrzrFPgdWys0bqF/S4aX9BtIP6ixSurmviv2oHdfdZjfVlpnqK9tfdVkLyauctwChsxNtUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ik7jGYFq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c65d744cso2180632a34.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771804889; x=1772409689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf3cd3Ow7fpmhEaunFtWMxQ62yJiyFWj+ZVPMJhUhgs=;
        b=Ik7jGYFqTM4+khw6hpzqzXxtFwhZAA/ywCMgTyy7NDk+yywW0F1TCl9QwFMwI9OlO3
         pLbmX7CsKxadj9nnsJBn6MIxZYGi+rp9RhOgPMeauIB6TkDeJznCb5f5a1BIvk/kaK1d
         8qD9ebpWWwPWjEhry/hJAoMFyTC9+J6t57IVfmQUz8lVJ9i6TCPay8cyDMQZP9FXyJmH
         O9N0ugbrXOq3uZlfH0oKoD+NAbR4STO77FCxdJ/+MwXJwIEYuVHhCSThYJnjocnLvFWY
         k99ajGXZSgzS17WVyl/k2wr1gRNdnA8McKBTF8jgZQgMrmPbssKUXtT8VE7r1Zs8armD
         zktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771804889; x=1772409689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nf3cd3Ow7fpmhEaunFtWMxQ62yJiyFWj+ZVPMJhUhgs=;
        b=wACWuXAmO1o+cEfdCNNegYD8W1xQfhRHB8cQ0AJ+ClxSNorrbiiPIBf2oWXWiZjwc4
         hrKC+H8nCFDgbidqE6y2Yi7aXG1xEe1v/w/LHzFl9bNnxXKAnKVcsHh4T1dyGwzZjNxk
         2rFSqjdSb2ln+i6fA7ag0Cbw0ONeIpXe3n5BRLEy/2Uyj0MEQaxYg8EDWaYvWM01FSM3
         +Gf1Ds7VL/UHhcP0JM7M7pVF74pWeD33/1R+W4gtsx9Sg05ZSLiKLD+qlZVJSSbTDJ/S
         2rRxFDOBlkUQUlrsiflUNA6KoHyxtqx9jEWGP+em5yE8uNoHde7JvO3Yi/vHFWeJGTtK
         9pPA==
X-Gm-Message-State: AOJu0YwFQfHjqN3w7TU7eWe8dOxPwcY/Peix1jVbutQxDo/29s9zC96w
	BeL6DuZpeA1FhvE8q6L1MnGiaaVOMDuf4eH1vx/Y8xoBjpkq51HaWbdRVgLFezK3KIM=
X-Gm-Gg: AZuq6aJ/HCF/K6pia4bOSbjVYwLH14L6suZSxv4TCa3irZyPHBTwZj+Wm7jjk7nr2vc
	Ju5dNN6i6sK/zJfzP/UYTRYLr3fiaX47pC0KNWTrVn3on0tY+hiF9Q9qJceDZnKG8Uz89myy4cS
	ky5c1p7JY18e9H5V4f3fuinQfGWqS7u7gPD41duhqzi8UBrXi22TWRlcRbIRt0B65kAak0qhfEB
	G4vcoKuTzbCdIiBQTyJbF8gQ/bTqVrFi67asZ2TK2A5qxur8927c2Pobltd5NT9Wf3eqOrJIp/P
	zZRJZ8LWpNCYYXCQIwiGFu9dPe3X+1KEiC5njBFPW27ydDpsE4WQwTAGRCETMuARRFyDCMAUuEc
	4+Gj2bfLn0r8ZkFmNKNSVnR22vC1qWyAQc9fxvU2ujNCAQ6AXwNPWWlfup0V6MnZDVyaafD/WR9
	dX7dmc5mz/Dhx3zUyKfWn4Rvhc9I/sh2G52FkRjYPtc+jp3I+ITafILLc4lKlRdhhA1Y9PieQ=
X-Received: by 2002:a05:6830:82dc:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7d52bf5324bmr3724174a34.32.1771804889597;
        Sun, 22 Feb 2026 16:01:29 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d038804sm5803026a34.18.2026.02.22.16.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:01:29 -0800 (PST)
Message-ID: <b1d73d74-ab1c-4cb6-89c0-20444ac02c4c@baylibre.com>
Date: Sun, 22 Feb 2026 18:01:28 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] OPP: Use mutex locking guards
To: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1745490980.git.viresh.kumar@linaro.org>
 <cb4bdf07e512e39af4c9142679c1361ce76e9336.1745490980.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cb4bdf07e512e39af4c9142679c1361ce76e9336.1745490980.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-42982-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:mid,linaro.org:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 40E91170E16
X-Rspamd-Action: no action

On 4/24/25 5:36 AM, Viresh Kumar wrote:
> Use mutex locking guard in the OPP core.
> 
> No intentional functional impact.

There is an unintentional functional change here.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

...

> @@ -2660,17 +2632,16 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
>  		return ERR_PTR(-EBUSY);
>  
>  	for (i = 0; i < src_table->required_opp_count; i++) {
> -		if (src_table->required_opp_tables[i] == dst_table) {
> -			mutex_lock(&src_table->lock);
> +		if (src_table->required_opp_tables[i] != dst_table)
> +			continue;
>  
> +		scoped_guard(mutex, &src_table->lock) {
>  			list_for_each_entry(opp, &src_table->opp_list, node) {
>  				if (opp == src_opp) {
>  					dest_opp = dev_pm_opp_get(opp->required_opps[i]);
>  					break;
>  				}
>  			}
> -
> -			mutex_unlock(&src_table->lock);
>  			break;
>  		}
>  	}

scoped_guard() is implemented as a for loop. So now this break statement
breaks out out the scoped_guard() and not out of the outer for loop. Now
the outer loop always iterates to completion.

Assuming each item in src_table->required_opp_tables is unique, this doesn't
look like a bug. Rather it is just doing unnecessary extra iterations.

To preserve the logic, the break should be moved out of the scoped_guard().


