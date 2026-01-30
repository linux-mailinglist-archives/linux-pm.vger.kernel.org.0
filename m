Return-Path: <linux-pm+bounces-41748-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ofp/ClJQfGmcLwIAu9opvQ
	(envelope-from <linux-pm+bounces-41748-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:31:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C72B7A1D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D5BF30107E0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C02ED15D;
	Fri, 30 Jan 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnhysWgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF022DF6E3
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754703; cv=none; b=F6g2Fy8qGesl1K6pCFkCzKvH161C84G5DzL1yveaFKm8BLKlToy51EV0u5krUxw+I8k5PiudHbH58Bw+oIVAbOouQOlgK7LaTRlbhg4ttpWkGxzZrTjlP/xxB+6HSnzPWE8L0ct13ZD+ZBlwAAryVlHbOvc1sU6dn8SGNTlFNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754703; c=relaxed/simple;
	bh=Vdk/utrnEqCy4HNjw/A4xBfoTYKZuVk0pF5TjUhi8H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa5Oqip1/wXrNQrJVj7tg6ASrFkpRXCfyMHBHAhl7FkIKgv+24dJSuLN4R161PDLCPi8C+76xRf7VfAqpggfKUtGazR0yE6W43+DxY3ourD1dr/725GiHRtDsZZje6TJgbXqP27twAdbFQhjf0d/XOpaH+LW1hE/btSkv16dzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnhysWgk; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82311f4070cso1226626b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 22:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769754701; x=1770359501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpfBDLLOe6/Cj7JeIHmNv+sR+B/kQKyDgvozA1NLP6I=;
        b=xnhysWgkPfeLHKMW/wZtm51rBt8zMuCoKpjKL/eNNIHHgxnohNlfR1e05wU2iRW9sh
         gws5YrjhXydfuSlxdZ0rViHVzu+hZyhzj9R+qf0qAYbsAQJc2dNDVlol0gRQAMu+4Evq
         jDT4Iw6pw8xU+JL2AqTFsDLbjv5IANUOHa9k14ZqywrVMGsy47MmFCEHxtdDOwp3VynC
         QrJNzT/P6r73I6jiAZYokd4+k6Fswjcp81ysuP0pjqH1HM07bl7gwG/XDR8SxjMP0iqz
         MpUZQuMu3FACxgABm5pKnx1a7zLfy+1QtzI690DReWNWhqjSHZ2uo/T+QaL1wEI1VWd6
         yvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769754701; x=1770359501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpfBDLLOe6/Cj7JeIHmNv+sR+B/kQKyDgvozA1NLP6I=;
        b=lDEDjBioPptbxDr2hbO8z3zxfAucnTfi7OFqAZzpewFI42EYlJTStTZvZsuxbyKyFI
         0HjEVl0/RjBRnH+UBP1cEoUNVXB0USO115iczitagklfZtIAtiTZyrjuZmT9GvS3A2Vc
         B3PQNTaSq0VOkO7iC1jVAAhnC9kFsORVJkkLgoHwFjjH9qaxVUaTO76exbbQXflShxQg
         1wDFog+ROyhHSOj5pL+IDJe8cBZloAlqgmf9y26odnSLDXR6EcayagrNxQwluS3ES4qK
         6rGcReBDNaah+7N9RH3k+cWLh9UcSFSnO8YJNvDCSLIT4gh+NoUZI3aZkYCKm/5QeTY5
         r5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWxSAR/BF8hfIXUKlF8nRupe9W22EE0Ny4TL4V1J5Y0E95/xGDINjI8D0G6cLT/6gf+pD5DLgilug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdScEY4oYk80XQzr1TWNcBo4MhmjRpfQbl9k+BeYyzoCgCnOa
	DsXspYKNfXynCzlvFBhRhwclJpHRdO7kbHn9zY8EeoC34fHeJ4paE0OqSrSS1MYgZdk=
X-Gm-Gg: AZuq6aLXflL/xS239Gr/bHmIieYRoYX3pJ6kPUShWL0st8q+kLObJDNQ93k2ZCZmVQ5
	zmB8CDeYWasaT6GehRm3eMY5WPPNERKdeCZT94SklrlYEEjysLeTuOlf6/Sb6UaAtD1HfVxbjOf
	VwMka1REMnRDMZPTg4JgmqLrLcYvmIrdbOyuCceCLzyGNDKJu24vPmxaBl9zvXuJuXs6v9udwve
	igcV0XOBWIWRdB6IG7NOZr1j6iOiDtRdNYiRxNA1++2+m70CecYU/zANQavGE/6kdXoOsTcxeY5
	NuVD/PRGIPWeUmKAUHmDGhUdB9IWNkmQ6KfwLvrabPu1dg4FAgNzv6UPvJHw1EtwdCRNAFX6DPq
	S2l/o9EGVN83HqJYh1q0MiT8HVWTCpVCgEWMUbZ7xotz0ouVlXkQXf1tKCowG4Q8r1irwU2zHvr
	l7N7cntoYEly8=
X-Received: by 2002:a05:6a00:6c94:b0:81f:32cc:b1fc with SMTP id d2e1a72fcca58-8239201ca3fmr5106850b3a.3.1769754701105;
        Thu, 29 Jan 2026 22:31:41 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm7573944b3a.24.2026.01.29.22.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 22:31:40 -0800 (PST)
Date: Fri, 30 Jan 2026 12:01:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] OPP: debugfs: Use performance level to distinguish
 between rates
Message-ID: <caqrguaqd4zvtxscnvptcdevftmml6w4g3xtaypwyzybziv4td@gdofbpdd7b4b>
References: <20260129173310.7241-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129173310.7241-1-manivannan.sadhasivam@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-41748-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75C72B7A1D
X-Rspamd-Action: no action

On 29-01-26, 23:03, Manivannan Sadhasivam wrote:
> Some OPP tables have entries with same rate and different performance
> level. For these entries, using only the rate as the debugfs directory name
> causes below error:
> 
> debugfs: 'opp:5000000' already exists in 'soc@0-1c00000.pci'
> 
> Fix it by appending the performance level to the dir name.
> 
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/75lzykd37zdvrks5i2bb4zb2yzjtm25kv3hegmikndkbr772mz@w2ykff3ny45u/
> Fixes: 05db35963eef ("OPP: Add support to find OPP for a set of keys")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/opp/debugfs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 8fc6238b1728..7c912bae2a5a 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -131,21 +131,24 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>  	struct dentry *pdentry = opp_table->dentry;
>  	struct dentry *d;
>  	unsigned long id;
> -	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
> +	char name[36];	/* "opp:"(4) + u64(20) + "-" (1) + u32(10) + NULL(1) */
>  
>  	/*
>  	 * Get directory name for OPP.
>  	 *
> -	 * - Normally rate is unique to each OPP, use it to get unique opp-name.
> +	 * - Normally rate is unique to each OPP, use it to get unique opp-name,
> +	 *   together with performance level.
>  	 * - For some devices rate isn't available or there are multiple, use
>  	 *   index instead for them.
>  	 */
> -	if (likely(opp_table->clk_count == 1 && opp->rates[0]))
> +	if (likely(opp_table->clk_count == 1 && opp->rates[0])) {
>  		id = opp->rates[0];
> -	else
> +		snprintf(name, sizeof(name), "opp:%lu-%u", id, opp->level);

This would be confusing for devices that don't have the level
property. Maybe add the second part only if level is used.

-- 
viresh

