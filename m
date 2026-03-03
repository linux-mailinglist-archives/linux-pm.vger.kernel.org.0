Return-Path: <linux-pm+bounces-43476-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K72vDqxhpmlBPAAAu9opvQ
	(envelope-from <linux-pm+bounces-43476-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:21:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCB1E8C49
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0EF430342B9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 04:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110473750D3;
	Tue,  3 Mar 2026 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7iDdk/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BB285C8B
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511656; cv=none; b=nZTT9sxviYxwHsQ8v5wvD2ZzWnQysfiSUSZugwdgupvHPWroOGHJcnZ3Y2LqSqdzUTSr6tpCIMOwwWqcq4aNyDyZgYUyZYeFlwbedNAE40KCa4N0dgKWWabiX76nc1kgCXWlzwFwwkyVJa2mPEPwmHvBYWpXKjYB76TBUWHBiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511656; c=relaxed/simple;
	bh=ZlweBBkTC0OCv962O061FeSDYVEi9pTQcwxBEDylOc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se8dOd0d3cwhA9dlmulakmh9z6pJKmkOivjo6SUqkfwds8R5IYj0nt3QT+2PPQhx8QpGVnyU/S95Zi501jzfi+agXHq6l/JvDOkdas7unaAsuC1XGX7e/SHzQwOXLcgW993p/+va/Y8Fz/WkRaDLoC8ULgFHA5shJI3kWK7WvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7iDdk/k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8272a56b91cso4458230b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 20:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772511654; x=1773116454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjlYlr+TitWbiFWv5AnEceJILSm/y3zmJ+HZjyFCTd0=;
        b=V7iDdk/kExmwTCM53YXPZBPilfHAy28voolH6ZeOXrkI0rmAnprgmf/Adh2eMgs0MP
         WlsPeXer3GjifrZ0/nRjMlNlcFrR1r+aYptMw+iv2sx2uxor+y5prgDeTyZchU+HdY92
         SK2S6Zu0PeG3fujmBlpPSkpFb54VR0PYTZarI9gku8tFfCVx1G94Ql+97VPEkVmPXyev
         p/g4+7QqzbpGnCsQt/RhXQoNisUJdBwvFRgzzj8MzTTxuNtyHOm7EGd68LiGeLL00SeT
         pSqQcLw7wG07axfvzjLEmvbg9e8rdl1VHf1MqrOpOVyTEyLPikOrpSHJWnzRmewPdvik
         i5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772511654; x=1773116454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjlYlr+TitWbiFWv5AnEceJILSm/y3zmJ+HZjyFCTd0=;
        b=o7I4RHTEUU4DI+RoONdTi+RuHDm6CwYsmwSk+5BbmmhWL3kgqRG5mJ3SSVg80CBJKn
         KQKpHx6BRG0gUXOjmIYyBGA5D2mdCPupUnxb87cL+1BMslrp2C5C04QnBF0QAB2Ffao1
         t2cdL0fM1NM63TPORmLYS9lE6oAcCT5wtf00qjmGIdk4zYWsh/tfiwKgMnAvnvezMq9i
         wAebu7tPWISHip9cwxM7NdC3zckStFMwLDYlHgRMs/JrPn+bOhJ9u4gIyVqsg0YULax1
         Q7oWeU9aw/b6Tj0nLbWOFXSYQLfa1hMyBKUGSOZX1ZUz18PQKj54GuKC+YGIDBb6/b3v
         iA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYuSNQECbng+oDe6E/uxtSMEIeCvvkM10vWwhOq+AjECTfk9USEJTdlZmn+MmvbpeOAfL4Bodnwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7hx0IGru9C0fs2hh2M5rVj7+duh5RzmLwiG5QfJ03r91Hbv6
	itgOLtz9rLfVVc3pUdNp/EsJfG6aiAH6enNVqpowUO5Q+MxadfiMcXXiP8Mfc9120Ns=
X-Gm-Gg: ATEYQzxSx8mktBhBP27i5GarS8v4+h/CLejfd3HFnaWOC/NVRpXOwrYRUhDBefXPur/
	ktIRCzJw1EYt6DAJTlWU1ShVVUXsUb9E9NAv7NL1OlUSpzHFx5XRD6O6MDRozDrjuQJqzE4Zm3l
	5MwaM7KZhtpXAwZe54cklJJeiqRwkAyrSFOAbX8s8Zi39a9umZrpFgdWYgZiYIL/AJh3JpcJ6NB
	ypH+ByAqSon5ak17XguDGOrBrD6MgBjiluNeWV/fA0KlR9Q+VMpt1QJbYpH5ZYmFqejLD/xkQjQ
	RAnSaHg0gxOLNfcuRn7Q2b71BO0raswEMoSmE+gG0CJm/mNL5rsJaztDhs9OyFcPUA7fopsMOTn
	rD/iKlHMpq/y3QRD/Vd0Ww0upO3Rc15PtvZm9M3JP1UDvfjoD+lwiY/ZLqlTqtEo9CO0O7TFDkO
	ZNFbsd5AtDvqyV3+DJ9NASl1F1
X-Received: by 2002:a05:6a00:2ea5:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-8274d7927ffmr14626637b3a.0.1772511654084;
        Mon, 02 Mar 2026 20:20:54 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8805esm15330809b3a.16.2026.03.02.20.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:20:52 -0800 (PST)
Date: Tue, 3 Mar 2026 09:50:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: sudeep.holla@kernel.org, rafael@kernel.org, cristian.marussi@arm.com, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix of_node use-after-free in
 scmi_dev_used_by_cpus()
Message-ID: <4lbgs3xszh75i4nucdhkbi2j33xvu6y3qfkilrshswbn73kpo4@kp36dhmrpogk>
References: <20260302155348.26374-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302155348.26374-1-18255117159@163.com>
X-Rspamd-Queue-Id: 82BCB1E8C49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43476-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim]
X-Rspamd-Action: no action

On 02-03-26, 23:53, Hans Zhang wrote:
> In scmi_dev_used_by_cpus(), the code previously released the of_node
> reference via of_node_put(np) before checking whether np equals scmi_np.
> This could lead to a use-after-free if the node pointer was accessed
> after being freed. Reorder the logic to perform the comparison first
> and only put the node after the check, or immediately return if they
> match. This ensures safe reference counting and avoids potential kernel
> crashes.

It shouldn't lead to a use-after-free problem as we aren't using the `np` for
anything apart from simple comparison of value.

-- 
viresh

