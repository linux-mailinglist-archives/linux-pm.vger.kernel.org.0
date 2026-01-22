Return-Path: <linux-pm+bounces-41269-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCQqGCK1cWkzLgAAu9opvQ
	(envelope-from <linux-pm+bounces-41269-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 06:26:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8D61FC8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 06:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BD34469C8C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 05:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85EA478863;
	Thu, 22 Jan 2026 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXhPQTAi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418B42EEDF
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769059611; cv=none; b=oyza9EBLs4YbTD5gZ8dmFB+NzkYDEbnMNEALwzHwk8hbxO/XRr0wgeHvwA90AgrS+ErUvDW6CES3Xg/kzjXKKhOTS3SqnJf66ZxqNsecrNDMn+rdy2kcKhHskndQ4fz/fY7eULJ6k092ozF/qZk6J5deGzMO16JlD8dkr4+az7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769059611; c=relaxed/simple;
	bh=Ktf4RvhrfJaX8tsHb1m4YqyrzwjiHiWcYE4GGIe3jWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUGdwoh2/6MFSfuhbz6FI0d+rhHf1Y+WJNHT3Vu8Z6D2N10fNwUtnlnaIXtu9AjH9nvxOGN8MW2YU/vyDKkv+EGAgoCTlrea5UPeunVGwxu9rcHooBKxuhuQ6HTd5n+VSDP905vvnmaBRWsl2LKAMkq+ct1Xioo/kQq8CHue/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXhPQTAi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-352e2c59264so428372a91.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 21:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769059609; x=1769664409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsRe3EWczE1nu34x1Zbmf41SX4+7fZa9pQAxrojU6wU=;
        b=vXhPQTAiDGM79sOqYe/XhmwutN2LVLYP+u+ZdYJ0HhuF5XuTOpDwL01r+Waa9h6SoC
         Jb179H4qiXb4A55kG4wyCEzBWOPiaIUH5klifyA+ea/zc/B7z2ACq4t00KSw5s8G/Gdd
         tIQ7tLDZ3WsPg0Sr9K9+iUUyk5A6hTZiXGreCIv6ufPelClMr8/2KInS4iLMi68hWoqE
         skgY9SLzmd92QKWFAPpxnRhzWP5fTIGPQBFz31BlYhosYl11SXFgvRs+HvHQfz39xKs2
         0RLy0syZh6stNHQWvv1weIg3Dy8XWF0b3ERjotN5zUcoLGMe1HFMhp+Totq5pHGe+GZ3
         cMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769059609; x=1769664409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsRe3EWczE1nu34x1Zbmf41SX4+7fZa9pQAxrojU6wU=;
        b=Nzc1iw2M2b3kCd4674t5h9uw2jQn1rHaaUJljPaweyn+6wJaHhMj2oWcQFb5BnR7Co
         v+xS0lWxAPPMOiA6dt5PqVoVJHYImZuB1vnaLUKEzOrbhJzxJMWDZeQ07cdchjuzvB1s
         ++ESFmHHyingwUjYZZq3KC++JRBsoxQHSAFmUfwFU9zGSNuhec0zYiQv8d/26Jfw0vNf
         SBCOkYCNRE/FWYe2AcuC+HOVTo6drVeBRAY4GsUGMIYLXl14L0mrt9Qr+5drhA2QRHuk
         TtW2WhEUVscIzVBnoGiQHkdZq7kelb5A/j87K8bIWSA20Ij0DWUGg35D5CBdwHMzJzVI
         eU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnTd5ARXjsDmOh+oE9k8/cL2eke1B5pj2ExsldTAFqF0yZoDdfj0JrIeC0SbcyfOuV7T2o6hEKnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznPF8TjmA00yonGjeFPXQvPwsOohnI6eMZxoLxocD0+7hJtUds
	FOwkOsFJ7dgy2O5zsiK4OgibtBHvMb0lsXFW2vFQvgHHbDschGsRdmvdn9ugkN6u/sE=
X-Gm-Gg: AZuq6aKBl12OXYAGYaWMiuzM76BOW4BP1mm+i1HiwZJcYA8MvdWONDK+LusfhMS1Tat
	RKQArt7aa85TirJnnFLM3khCRmPLDK73p/4cY+52o9vor7ASCE8hq9Xh6SC+Bl9qDZs01ip38ku
	06lC4sAXYIi/gD0M6Et3tn+tMX/g5jZe1U/CkK8oUgxEtycYHAuQsrWWPidrFKn/5E36PW/H1Py
	kkLLhH1RcKAmU98W/y8cvitjtoAoz0hfhEv/ungxZ1VFi4/WRBXU+EdLckf/7od2hRkpI4wtdic
	gvQyMAFV7Q70HLY3oiRCNmhiAHerJdtyxrKUG2v/oaAl2gy8tIchWYZZciv8ijixx7jJmm0DlpW
	1JvSxKsKdDL/HQ1RhU1vawHeZmf/NEiM/FXLMpk8IDq/qmmL63FqMD8xRl+hkJUkSfD+vTp8Ukl
	vCSMykKD9eetQ=
X-Received: by 2002:a17:90b:3ec6:b0:343:6d82:9278 with SMTP id 98e67ed59e1d1-35272fb1029mr18338103a91.30.1769059609040;
        Wed, 21 Jan 2026 21:26:49 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35303820dfesm1463299a91.12.2026.01.21.21.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 21:26:48 -0800 (PST)
Date: Thu, 22 Jan 2026 10:56:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, 
	LindaChai@zhaoxin.com
Subject: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
Message-ID: <5saz7opvq3bslycn53ebhtkmhhzmqos6x4it5v3bgayss6nmin@vbel3msho2sy>
References: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
 <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
 <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
 <qlcwa27dujkhxdyeminfzc3435xdz6z7bc627hd4fukr5qbhiw@anrsyspxw4mz>
 <c138c3dc-14ab-4daa-bbed-3cbe5d7c33e4@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c138c3dc-14ab-4daa-bbed-3cbe5d7c33e4@zhaoxin.com>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-41269-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E8E8D61FC8
X-Rspamd-Action: no action

On 22-01-26, 10:13, Tony W Wang-oc wrote:
> The driver for Zhaoxin using this patch still needs further verification on
> actual platforms; it cannot yet be submitted to the mainline. However, we
> have already verified that this patch itself has no issues with Zhaoxin's
> driver.

Upstream features are only allowed if we have an upstream user of the
same. Can't take this without a user.

-- 
viresh

