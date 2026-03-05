Return-Path: <linux-pm+bounces-43693-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC/wChK1qWkZCwEAu9opvQ
	(envelope-from <linux-pm+bounces-43693-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:53:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720321596C
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B27B301105C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815543D7D9F;
	Thu,  5 Mar 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUKc1siy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFD3D6CDC
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729614; cv=none; b=n7RiGxUe/mBcmcq3lJkNB/BXC8yBS2pJZCOxNgE9KYCBd8nXXMIpZaojYrT2gT4taZFQJ1ghNlIIgCd/6EX+Q+ZTV6SzZZhIvzEwTLEFkFC5M7bgBvbCNRMLbE7Wb/dSR914L4Epd0jcninoPOhc34h/qyqeG/SJsz8zACvCF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729614; c=relaxed/simple;
	bh=ccrLeopJHqSj9fB/czJzBK7R6oyenuY1PQJemNMRKAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNVwY/oU0LwBtoryCF9exsO3/AUXDcCrb5LX8xRNf9eakFWqdfCicWTjSHE/ZLyEksrpNGNTgAedUj+dewCuJa9Y/xwGxr4kRVDZ8ghSWy18KCXyKV0dLLzJb5+3jDVdABdP0DY+c36DBXtApa6lXUMvlIUxfleoQQ53/hDJySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUKc1siy; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso9040696c88.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729612; x=1773334412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxhcSN+e9I7LXlQzxczwKkXMqtF+5L91CEl0/9U5qGw=;
        b=dUKc1siy91t0MKbm0Kkqo/XmASe5vCXaaW82TaPSMF8XXeZVOuBOi6jgtyMy8at51i
         E4Wnoj8zBGDS/Vjx0LaQqulB2Rkjkpa0f4gajq3O1tL7lWAjrdMDZtJLV/oBm7mCIBcx
         JEc2p2i5VKMIvxb7dwTymoawOCSbR94lowu3qLnvVKNZGnRdWk/FC3nNOVJvk71TLrRG
         liaYEay48TJtK7OqUXGjXgImuMm0bUFvIirBIWwW9rGa1O3mF1ZV6poBbugM3Ttrva9s
         X7eYMv2GucleHXvokA8wViA9KhwAVtcuOD3HFTVa31QpgE4pO7ENPaIyL0wYW25BkNAW
         LIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729612; x=1773334412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HxhcSN+e9I7LXlQzxczwKkXMqtF+5L91CEl0/9U5qGw=;
        b=jz6VE7F0Jk7X0bwq7F3svc+xINEOQforcCzzBWTIZD8riKG4AB8XoSCdnPtcRtjkXM
         mEj6zMIYNZQStJuKk4kmXkkcS5prZphMbqYF3xMVwjHbHeOXLxZXgkK0In+obEjynv3H
         HS0ZUa7fT6DKlH56maCn5NLgqf5gTSqX4JUDY9e8pfp6bFhRg09N0+TOvbTxiNnYVX4N
         yrI4WyYv1ulxwxwMJYTvetV3n/uErPzNKoXM8VS+kB6LUTnD/ewLny7fSvRjeXOUZnPm
         nlJMCmFbltkSb1jye1jO8HvhDiME/tjTaxzRIjQlsK8nBBZLXZoWDCfCcCIIyWVQJuN1
         qATg==
X-Forwarded-Encrypted: i=1; AJvYcCXldLwN0MijyIEzAY9xTCgRg7xKpb1CCKMWnN4lhUo67k7lvd2Xdpos6NPPDEcf6huXCBRbM3yiJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfM8vfBb+QxB5mFohGFXpFxQK+U6FpRqL6qc07BPUs2cVU5/Q
	GN7+tgj7l0Bh7+ks/eQZu53wqB7nSxenfM9ZD4F9CTuAHj7hITEy8fNh
X-Gm-Gg: ATEYQzwGiLb8bpkyVyHaFMJ2z2o1Gbe2x6Vg2uwTHkPNhAq0D3r+qFYwFYCTrZ3XTD7
	bxH1WP9Sl1h5XmcQww+DvSDjFRs/EiASBCtNgbd0Q9RHYGZ0ElrateF3brQFoMX28hF7n6cPwpW
	SYcTpYXcJK+hu3r5h680Wjegxu9JKtqKdaVg4QWbeKyAmgQSnTmkbzGrkr3Um358wF+wvozJu42
	4/huOsp0lwZY4z9+YYTfj+ePPH7oG642ezsY+3NP8dGMFSA0qkenJ78iwXi4Qp9UGn+eEho6fux
	m453svtowRjj+JLOFKrfrCMSHkhwr09T1GC0rAX9FD7PIHSukL4xgoqudZeVNH0Du/tdV2x/iLF
	tSnpFra99/wB4CIYuByA+FaDH7gbIhMesKSEOYbLFaAnM5VegbHElUvrgnTpoCVWCu/4QvNsgFi
	qUKG6g+OyBoZtjJ35Ww5G11E3jhtcnekCzcV0LCLJNbn6qRlQ=
X-Received: by 2002:a05:7022:6628:b0:128:ba6e:f87b with SMTP id a92af1059eb24-128c119417fmr206466c88.36.1772729612112;
        Thu, 05 Mar 2026 08:53:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm21429300c88.4.2026.03.05.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:53:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 08:53:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state
 is available
Message-ID: <37ab17cd-0488-44bd-9e03-1ba3c0757e8f@roeck-us.net>
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-2-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216185005.1131593-2-aboorvad@linux.ibm.com>
X-Rspamd-Queue-Id: 9720321596C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43693-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

On Tue, Feb 17, 2026 at 12:20:02AM +0530, Aboorva Devarajan wrote:
> On certain platforms (PowerNV systems without a power-mgt DT node),
> cpuidle may register only a single idle state. In cases where that
> single state is a polling state (state 0), the ladder governor may
> incorrectly treat state 1 as the first usable state and pass an
> out-of-bounds index. This can lead to a NULL enter callback being
> invoked, ultimately resulting in a system crash.
> 
> [   13.342636] cpuidle-powernv : Only Snooze is available
> [   13.351854] Faulting instruction address: 0x00000000
> [   13.376489] NIP [0000000000000000] 0x0
> [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
> 
> Fix this by adding a bail-out in cpuidle_select() that returns state 0
> directly when state_count <= 1, bypassing the governor and keeping the
> tick running.
> 
> Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f..65fbb8e807b9 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		   bool *stop_tick)
>  {
> +	/*
> +	 * If there is only a single idle state (or none), there is nothing
> +	 * meaningful for the governor to choose. Skip the governor and
> +	 * always use state 0 with the tick running.
> +	 */
> +	if (drv->state_count <= 1) {
> +		*stop_tick = false;
> +		return 0;
> +	}
> +

An experimental AI review agent provided the following feedback:

 Does this unconditionally keep the tick running on systems that only have a
 single non-polling idle state (like basic ARM systems that only support WFI)?

 Before this patch, governors like menu would check CPUIDLE_FLAG_POLLING before
 deciding to keep the tick running. Could this change effectively disable
 NO_HZ_IDLE on these systems, causing higher power consumption?

I don't know scheduling well enough to understand if this is a real problem,
but I thought it is worth mentioning it.

Please let me know if the problem is real or not so I can feed it back into
the agent.

Thanks,
Guenter

