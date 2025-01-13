Return-Path: <linux-pm+bounces-20337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20917A0B900
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 15:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A22E18828C7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5FF2397B3;
	Mon, 13 Jan 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQKzZZiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F3237A4A
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777057; cv=none; b=rB9n7Sv8CltGnn9lZtiMyEtF13P5nKlM58h9GwTAQ9EK3zxOt4voJoblEV4byKyNPRvPXASqwpAt273UMr0CpKxJZbZIjzhk1DkqZXib4sC4UHZiSkZ5NUCpRa9MKzFjaV7t82ngLaiX5tROJvi8cGQdFfqgoX23tmNCM8pUeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777057; c=relaxed/simple;
	bh=y7i9yK6uqPSjht73r/iR+aYc5L6hwOUIN5gJlfHlwqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpK2YKJXL1cByoXmhwaSIHf7tmFuvXcxCN1wssd3kFNncSXfuRA8+/MLn3eY5p040nTTAEjjTUUTmEe2wQLwkKRHTelZBZ27UK373tqI0i0Gxs5kAfyJPRcOyGDA4wZ6UPkJTP2lyy5ABYPlB6Hum22C3YljGXCabW5xgQ1WyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQKzZZiP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736777055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1W27EkcgH33VK3/pO6eap5hK2Jc5r+DsZDrPLLdoo6o=;
	b=cQKzZZiP8N/rP4zNQhqtWpIeyCP4r7fIk6UGOKz5901vP+4ulqj3d55ixzsuBvdhiIWZu1
	RII8rsaOQq/heYnHo6GUqa31fcfkNJSJM4+sBmgjx8gdi29+1xuEqDZdh2sMt/O7NYM+qf
	KH3b9Go60MneQFA+O8FqI7HCR+GXZ1U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-1kzc_TlKNearswsKsSBbSA-1; Mon, 13 Jan 2025 09:04:13 -0500
X-MC-Unique: 1kzc_TlKNearswsKsSBbSA-1
X-Mimecast-MFC-AGG-ID: 1kzc_TlKNearswsKsSBbSA
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d92efa9ff4so67339906d6.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 06:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777053; x=1737381853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W27EkcgH33VK3/pO6eap5hK2Jc5r+DsZDrPLLdoo6o=;
        b=CE30QURaFlgkeV06aZCR/2/pbgHf1ZKxiwvjcSIWP8zVTjRFalBNcgrEtamG1nZ4s5
         z17gj/NrOEGyKwKw/N21WoIqe+mbxgJsO3HQXUYtHkdwnSMbfyEms7iIKdWIkYSWWxkN
         JulmBjVKgcJy0RP/J6J31UkqCk54L4LbpuVrtWbuyrQgHPim/d8zy7xDD3xnsl7g704K
         KlBnngxFoCUCaNLBCVcWxU3cNqQscl4CLyU/J+dz00lbpulzl3WFyllSr8WoVrCdjejb
         DtrFuR2ufP11+N4q8M+gHKBR7Qfys6SMSFI6i1NKySmLeUyo6lC+HP75lkgsAfPMa8vv
         5NLA==
X-Gm-Message-State: AOJu0Yx6n0W7ifuYRAt0epU7wYCne6j5WIRa1Nu4wsK2JbXhl+o47iFS
	515jbd0YnaYB7Uu3+1JduJizryk5dVxL/06BGb1h2RICTnPdhtpgDQIYkzKtFCxnzyV35FYnpuo
	8EGj9BMbxKw2qXiK7eK/E99UefldaDtLmhAwpZOTVPnzg6y04pIPVXrUh
X-Gm-Gg: ASbGnctZRe48nBRCDOq7omi08C+/jKkMQOStFe65aPqR0iE3kdJOY7Itk7Oth5m5R2q
	uwPItsvM+QptE8HdNYxays3Of3VR1J4m40pnRxwZEbgcb8NS2V9HyW7bPpknBAKlYxLvg8Lu08s
	9pCB47Z9FbLSQvK/k5UfrH2Bri6SEr12YXuKQhkhhTppW0oJWYL6nJJ/DFTS8OPilDXSuk1rE+J
	mtD+n22CC6T/iGwXsFITIdNowqZryQHJ23NuN0gdJembBvozuFvEA==
X-Received: by 2002:a05:6214:29ca:b0:6d8:876e:ef41 with SMTP id 6a1803df08f44-6df9b1f6ae4mr350865836d6.21.1736777053403;
        Mon, 13 Jan 2025 06:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk+PtcnPdhiObeNF+7uD32TiJaqFknjxqb1eImvlFc8X0ikjLskW2bSnvDlGKEvNI9cxmwfg==
X-Received: by 2002:a05:6214:29ca:b0:6d8:876e:ef41 with SMTP id 6a1803df08f44-6df9b1f6ae4mr350865306d6.21.1736777053087;
        Mon, 13 Jan 2025 06:04:13 -0800 (PST)
Received: from thinkpad2024 ([71.217.66.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73b8fsm41528816d6.72.2025.01.13.06.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:04:12 -0800 (PST)
Date: Mon, 13 Jan 2025 09:04:10 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pm: cpupower: Add missing residency header changes in
 cpuidle.h to SWIG
Message-ID: <Z4UdWpRie1ZsJ4tk@thinkpad2024>
References: <20250108221852.30771-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108221852.30771-1-jwyatt@redhat.com>

Hello Shuah,

Did you have a chance to look at this? This is the second header change
that was missing from the bindings.

On Wed, Jan 08, 2025 at 05:18:44PM -0500, John B. Wyatt IV wrote:
> "tools/cpupower: display residency value in idle-info" added a new
> function to cpuidle.h. This patch adds them to the bindings.
> 
> Link: https://lore.kernel.org/linux-pm/20240809083728.266697-1-aboorvad@linux.ibm.com/
> 
> Tested by compiling both libcpupower and the headers; running the test
> script that does not use the functions as a basic sanity test.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>  tools/power/cpupower/bindings/python/raw_pylibcpupower.swg | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
> index a8226c79cfea..d82af6fa93c3 100644
> --- a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
> +++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
> @@ -163,6 +163,8 @@ int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
>  				   unsigned int disable);
>  unsigned long cpuidle_state_latency(unsigned int cpu,
>  						unsigned int idlestate);
> +unsigned long cpuidle_state_residency(unsigned int cpu,
> +						unsigned int idlestate);
>  unsigned long cpuidle_state_usage(unsigned int cpu,
>  					unsigned int idlestate);
>  unsigned long long cpuidle_state_time(unsigned int cpu,
> -- 
> 2.47.1
> 

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


