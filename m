Return-Path: <linux-pm+bounces-41220-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKJ6CVencGlyYgAAu9opvQ
	(envelope-from <linux-pm+bounces-41220-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:15:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE234550E1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFD8E894A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8C47ECCE;
	Wed, 21 Jan 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2KHseI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273C3EFD37
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989778; cv=none; b=kbWH6fwIGjYdCpE3jMYBBitCoyHuZi7ZPZI1IGIsGwtcqIogcnKTnEIsNAzkkf7KRdNnieqYq2KUX06Y1mhUFLhyV1XPzNoPB0EJ1ax8eMF3110TklVA5zhDeT1bR48jgC28qJ2m3oU8o4WIwfFDZGGgOO9vSXL8eLmcjkmRMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989778; c=relaxed/simple;
	bh=SE9NRw5qn4ZOyano8h2GyzTfssbrg40c8zGbR5S2fYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om6yJp3jWa6MOED8yWNs/g9c26w9wOrNJeM3xyN+zfZhYyO3arN/sl5Lq46qM2BciUleU/p6EiKx4aBvsK7UOtZMr7PifIoEXOtIQA11EzreIWdkBk0yVW4iwW+FAPduzn47kvm5zINzXx1aOfSyMGyLrQoPMdQRUZVoQoNeHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y2KHseI2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so5742898b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768989777; x=1769594577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfcZoohs48Dbdj7CYeMxzczv3GEJMGcMAgggRcHBwj4=;
        b=Y2KHseI26BIXucogEaIjLh1UVyjXibvWp21xm/yI49x3XENQrD1OcMrsfvduaPr87N
         S33sAEtD3pZd8NgL80+gAtzzygPu4dA6a8lD342CfpBZWMcUa5Kc2DrNIL3uiRdPMdci
         y2V8rOY7j0zajksrf7dEBMEz2weqj+e4ZI6MBummHxD+IhNEiy64H6pxP24zZ4GwYKPQ
         QsZmpY0kGrkpZa9FvGk10KFUiTK+dQn8UXHZ2rLrG5rz0A1ApmdsHR4IVibhSYGuVK2y
         p9jzhGqrdkRJGOVK3z7LeqkwdqJOK5lSCjW7/UaZf7XymZG7ayJRO8buT+UHKBS1q+Wf
         PiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989777; x=1769594577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfcZoohs48Dbdj7CYeMxzczv3GEJMGcMAgggRcHBwj4=;
        b=RnKtjfvcXVqjx2Q6SmAKIh0HIqkX6A7J4/SLFviuYGeruDo3wtoWQzDKO//D39pRDE
         Op3G7q7di1PPhI5zI3m/LX4n7XpcG0V1FModHgxMB8KdUyydorKNPorjGMbpdElV2a5F
         LPBI5yTYlx5dgSQMK1ZGqKK1N60II+Q1pcsNAk+o3i7qXOUBdP8rEG6cCHaU43yGYB1L
         5rSxi/2b6rQ4+6pl2N0sua+1QkSvtCqrKPEgCDdCwbwnQxM/lR3VbhQ8abDvJYIu62Ws
         h1nejbNTDoG6TZ5BjiYxtONX1GB+WriNhJIkX/3hItVkjYFEGqIHAJgxbfzlsNMI6T5S
         QvTw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcVkKKlyFnogLGABaameSDwsEwrW9E/cbxulOSxLKyTeUfNJRdSpUkE816bcMQ+xukADM92HMNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE35fh/0wPv021HLLlSCSSUGOUyw3amhiUkS4b9gvtlaBn2Pc0
	XtxRGmjyr8kGTUued50NNAt8ordy9Mv3CVdZgB2tjybL5wMmZ/FNpmdGJ74anwJjt60=
X-Gm-Gg: AZuq6aJp32DENO2g9suhXhBU7fA6h90VXMzq8dCYPSP/L03gYE7MBIGtMJTFpKBZOgr
	lwF3MQfcKK9jrUFQWbd/7otZ8sADNrsc3oWHhSuvGUtK/pX034S9Ea94rOzoRPkt2pAxsYcFQYl
	l1IKq41edfYaVAm9vjmAvOwU6sP0t3Mj4HiqnACMRRf7DK3LsRdRs+A4HOhfqSrIVPOCOkXCDrw
	O09wZEUpNKFaDyD9s2lF7ZOFepAcEW4OZDnYR65sK/uoyQmXZsW406bRL15oFJG1cWfaqcu9TEy
	il5jPmW9ETEQjFoUo0NnwLAta5Cn+bIXx08OUonZUxKvTXZEhsJ4WKYRdErWTxwzJ0VVx0DGbut
	uOFxjsdvpRJsUuclurb57x3TJDNnQZSrH0SgyE60HXoFjXcR5eecPK3wjnDh8JDM3SJiUhyL9WN
	rZkMnGjwXeiyg=
X-Received: by 2002:a05:6a00:1804:b0:81e:c91c:70c5 with SMTP id d2e1a72fcca58-81fa01e109fmr16707368b3a.29.1768989776639;
        Wed, 21 Jan 2026 02:02:56 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291facsm14639783b3a.57.2026.01.21.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:02:55 -0800 (PST)
Date: Wed, 21 Jan 2026 15:32:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, 
	LindaChai@zhaoxin.com
Subject: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
Message-ID: <qlcwa27dujkhxdyeminfzc3435xdz6z7bc627hd4fukr5qbhiw@anrsyspxw4mz>
References: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
 <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
 <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-41220-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linaro.org:dkim]
X-Rspamd-Queue-Id: BE234550E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21-01-26, 16:37, Tony W Wang-oc wrote:
> The expectation is to register a notifier of type CPUFREQ_POLICY_NOTIFIER
> via cpufreq_register_notifier in one of our drivers. The notifier callback
> will configure Zhaoxin registers to different values based on the different
> cpufreq governors when the event is CPUFREQ_GOVERNOR_CHANGE, thereby
> allowing the Zhaoxin hardware to adopt different power management
> strategies.

Firstly, for this change to be acceptable, we would need your upstream
platform specific changes as well.

And then I am still not sure if this it the right way to solve this
problem.

-- 
viresh

