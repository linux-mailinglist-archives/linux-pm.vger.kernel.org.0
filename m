Return-Path: <linux-pm+bounces-41258-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNFODLmGcWk1IAAAu9opvQ
	(envelope-from <linux-pm+bounces-41258-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 03:08:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131360B7E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC95A8268AE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956C31960A;
	Thu, 22 Jan 2026 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek/RC051"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2830C615
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047587; cv=none; b=cH6G6ZOASu3mIaHLW6/cMyYiQ9jxA0+NDgLZ8eDQ1qH/rwo/HTszrZQEeZyEp+NfqNjkw6G5dDDWDcZejSIjDGlW37p336xr8O6N7CJRHgjIC2tppMQuPPNduN+PlVcnCjJVomFHVb4NF6CSF/L3UI0hjL7mcqQSg76ox1MnnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047587; c=relaxed/simple;
	bh=U+dvsWtDZv50Oz4kWfPVIu70ozgI5yQ4sMPjpZG3iBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqrpDXv7x8NZ04Jj75lZeIJdfS8ex7qjbdmKYJp247PdgLMGhxppfdp31H12qWJvlCS8XaES/8p9N7oWQhMbntBwUsnkMFSqVXZTt0Y1R6R+tUPufd/Q3+05B92RaNjL6f/s/Irvs1D9YzjPHOy8W8OBu6FKuEyIjB86gNfV56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek/RC051; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11f36012fb2so862827c88.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 18:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769047584; x=1769652384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1aetEum6/U73Ku2v3eVebk2UGZPppByGVWbKAtEnsY=;
        b=ek/RC051nbknkJE9D8rX7RmceR/BjaWh4iisbyieGca43Z9nt66b6Tie7GqxNUp3RM
         gYLBRhJCfzzampawBYAFZJE48eswjVqTI0bu/4GmNKMZ/6xxvBsKl9LWmR5N6tf6FCYx
         EYgZxjuXofgzrqui5lZfBlzYw+IMaAeaMsH5d9cRf4+cjtKMSSNOl/OunOEQvYStFgNk
         eyxVoJaLtvz8Q2GD+SxlZ6j2VEhhXK9a3BKHgIVp5gjTrujtA09FyhUJREQJ0HXrvsBB
         jq2eP3IsOn5QP9SdWAIMpEuB17itH72Ir9xu406779MUHDpfHX19R/SSnWgLaOBhV6v7
         bi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047584; x=1769652384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1aetEum6/U73Ku2v3eVebk2UGZPppByGVWbKAtEnsY=;
        b=cfLlnPRKa+s6cLVmGm/Aw7jyg2sZANoUXExOTFZYQMFZ/kVA5plk6La27g4G5IKGig
         8zvUziiZGQeI1BvXAbqpunc9BtXW+i6uUiDCjmLgenKir10VNrdagt9G3azC1uyXaqRZ
         1NNmxXHPBkYk7HPTWyZWg3ieZRpUQzrgkY1k+n7sH8SIkxWtUXNpxC87knT/y6xXxVy9
         X1q3avfK04gEPjoXYIYNxHc9qYdipLojvkDzY3+Xp9skdFCupWE5IadJxxIxd4bBgkab
         XfQvzj1O+rkXDb528ZKEvXfUVBKXx1nhxzqYyPozA9uWl9jb8MC+1chhE9/Y3CFbQJhT
         XrCw==
X-Forwarded-Encrypted: i=1; AJvYcCWn1M3/zLBnPgl+tUJ4dd6qWBsc7Uyz6BNL7YBjhd4PuxKz7T70RQea9ANtf+g9vqCBQa1n1lzuEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1mesFG8zTM7cf0XTxdkNmJmoYeJFztwCROOtCK/OxTeu/b7S
	RfIM/RInrVLTWJqMCWm20UeGHdPU/ZO3OJBffS34+aeNtdqeI42aVOtJ
X-Gm-Gg: AZuq6aKcxAJFl8Zus3/1ovvq6eX0nxALPjdLWNLY4JCywc/NzkZbrmRpUxNqW5sMXNf
	Yp8Wt+/7hSIxVbRKRr/pRujEm7LxIGFJ9tZBG2jyNa7H8OqNE0Vowt30oe7ZpHUL4WOFmymhklq
	S8OvKBvQag0OMmmvoLiwzPj4TMQKLRXLzEPZ00wPULTax7swLBXGBK0VWIw7F9fJJ69cKXLHMhu
	peCIJov7B+Yef+RTmeAQ37B2FZdaynh8JeBDrSgdvVxacFs55RcJ21kl48L7u+srLGUyivYSXxL
	FI7eCEvLx4v64/e3mZXAe4bUB2XspAMFe6iWyhtDz+kdjmqmPqFybafXCJhgKAeE3na3kwM5Z9Z
	YYrsTZJRpsYsfXgCB39SVj6eOuOfMeD6xF8DuzUX73tfbU9NBTq+T0Azp4uPy4yU7oH7QJ+5biZ
	o5qJrCufIQyxN+AEeY4sNTr+3w7LesEkVVxzqAZVy/3J7xBTd+6rEm
X-Received: by 2002:a05:7022:6b8b:b0:123:3345:810e with SMTP id a92af1059eb24-1244b35fb92mr12923849c88.31.1769047584138;
        Wed, 21 Jan 2026 18:06:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm25248140c88.4.2026.01.21.18.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:06:23 -0800 (PST)
Date: Wed, 21 Jan 2026 18:06:20 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: PM: Adjust messages regarding postponed ACPI PM
Message-ID: <fzcmlu2iew2sc7dvooig43c6kkzk74rj5gkseenyvhjesakepu@qn2256b4i6zw>
References: <5969819.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5969819.DvuYhMxLoT@rafael.j.wysocki>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41258-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 8131360B7E
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 02:38:41PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The debug messages added by commit f7599be2bb76 ("ACPI: PM: postpone
> bringing devices to D0 unless we need them") in acpi_subsys_resume_early()
> and acpi_subsys_resume() are not quite accurate because what is postponed
> is not just a transition to D0, but also an adjustment of the device's
> wakeup setting (which may involve disabling a GPE among other things).
> Moreover, these messages don't even mention ACPI.
> 
> Rephrase them and adjust the style to match other messages in device_pm.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense to me.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/acpi/device_pm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1251,7 +1251,7 @@ static int acpi_subsys_resume_early(stru
>  		return 0;
>  
>  	if (pm && !pm->resume_early) {
> -		dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
> +		dev_dbg(dev, "Postponing ACPI PM to normal resume stage\n");
>  		return 0;
>  	}
>  
> @@ -1273,7 +1273,7 @@ static int acpi_subsys_resume(struct dev
>  	int ret = 0;
>  
>  	if (!dev_pm_skip_resume(dev) && pm && !pm->resume_early) {
> -		dev_dbg(dev, "executing postponed D0 transition\n");
> +		dev_dbg(dev, "Applying postponed ACPI PM\n");
>  		ret = acpi_dev_resume(dev);
>  	}
>  

Thanks.

-- 
Dmitry

