Return-Path: <linux-pm+bounces-13585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F196BFC3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7331F2341E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3F1DA61C;
	Wed,  4 Sep 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYacdMKE"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53C1DA611
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459209; cv=none; b=UZIliBUBFjokaG6fx0gNmxxOGPr4fNbqgBtTlzPaEChGZdVG43xFoSh1yk9neUc42yW+NxCPnQL1usR+2gjfXwabALrepkKsPcQ1lbZ1KWlNTfMTTRqla7Rn343WjHRBxSOZGg7cQ9WmL2GElVCWjEB8HjTRS3aDsqVu5WoOkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459209; c=relaxed/simple;
	bh=5xKG9dUoUvd0qDJX3TjOCR5+MZElhYKjcb+r9REaF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIeIU7bPCxhy+eQEfkIyqPNQiNjDyQ5YB0Q/jDKDQ7joz2Aw6o5wSUAqlziZTh5NNGDTujrw2GMaU/ZxF+WxIo/IwbOo8m9VSHGzfZC/W9qpaFORPVTvGQeu0NL0HM27Oy9y9BHrw31O5xicoOK37BTjkIUGs/BfgIuL0jAQ5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYacdMKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725459206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvj3AN7zyknADIaLck5/j7KvAlIf60hFEtRftLIs24w=;
	b=KYacdMKEXVaoouZ72YXLD16teU7uP0shCoAsP6dG/+EjLP4ASko0yuxRnFcOh5PJsAkEZL
	CZvwOmJ7jQOzBlG7SjKKKGl37Wn6q/jAWDieCYU+8ZisIJDmrO7szrtZEtAWJm2iDtH1fY
	YvhDbEcZsvruG2dYcDGzPuwu0SRkffI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Lm9CyAJUNa-Yivvi0UpmsA-1; Wed, 04 Sep 2024 10:13:25 -0400
X-MC-Unique: Lm9CyAJUNa-Yivvi0UpmsA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-457c418ddb4so20527641cf.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 07:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459205; x=1726064005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvj3AN7zyknADIaLck5/j7KvAlIf60hFEtRftLIs24w=;
        b=a64LK8/D7JswNIRYEHp0nFHMOF2oDTPp+4u8FQl2808odWlKQN7ED84XRBlUPB6ssR
         3w8xg7+5O4hMgZ1EIZKhexlzfr4ppA9YgTCanT5xaiVZUUboNdkodtmHDQgSChuEL4F8
         LFKqf3A+RpNUM54+jwnl9N4Kd7wODl9g9VsjklQX+VWB6BKyhKf69JPM4u4zt/QDBZJw
         ClrtMRZ5x/739HXQGeOtxY9XxyLjeNBQBLx0ht2NHK1sCZ83OKH4NcdheSb114tkLLko
         wPpKicLFopk9M/sZ7EKpQ8EKyC+khw2M0GGK/mruo5kVe2vi71tRBq/ssfuwqzufzpN9
         yusw==
X-Gm-Message-State: AOJu0YyzTlMYtKn943ikqz6NZ2u+xMhEnHihneHsWWMgppykZ+h6weR7
	0s+fxQTjNmjIPRY2c6XqMORFeNbAI76bTvyaTOGBy5j4dJ3Ruplw03Y8UgIIFFKe+MXCqDZ+mVt
	XLa7FkSuJQNW/CxKXNGyWEDlP2BAz6R+w3WxSZ6iOidXAleQF2J1Vvz+7
X-Received: by 2002:a05:622a:1ba4:b0:456:807e:bb0a with SMTP id d75a77b69052e-457f8aa52c3mr37658261cf.0.1725459204939;
        Wed, 04 Sep 2024 07:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOZ1JaPo+DrG6Y529RQ+jyH1FfZXAYD19tt7yXNnnI7753nPKd6+YZHs0/iKJt6Wc7jzOT+g==
X-Received: by 2002:a05:622a:1ba4:b0:456:807e:bb0a with SMTP id d75a77b69052e-457f8aa52c3mr37657501cf.0.1725459204308;
        Wed, 04 Sep 2024 07:13:24 -0700 (PDT)
Received: from rhfedora ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d99299sm58766531cf.90.2024.09.04.07.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:13:24 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:13:22 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
Message-ID: <ZthrAiB2j-l-V2wu@rhfedora>
References: <20240827062438.71809-1-jwyatt@redhat.com>
 <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>

On Wed, Sep 04, 2024 at 06:41:14AM -0600, Shuah Khan wrote:
> On 8/27/24 00:24, John B. Wyatt IV wrote:
>> [snipped]
> 
> Couple of things to address:
> 
> 1. I noticed none of the patches have the subsystem prefix:
>   pm:cpupower is the right prefix for patch subject for all
>   the patches except the MAINTAINERS file
> 
> I will pull the fix  "Implement dummy function for SWIG to accept
> the full library" Patch 2 in your series.
> 
> I want this subject changed to just fix as it is a problem irrespective
> of SWIG - we have a missing function. Subject would be as follows:
> 
> ""pm:cpupower: Add missing powercap_set_enabled() stub function"
> 
> Make this the first patch in the series. I will send this up for
> Linux 6.11-rc7 or Linux 6.12-rc1

Understood.

> Depending on how the timelines for merge window work, expect the
> series to land in Linux 6.13-rc1. I would prefer to delay it anyway
> so we can get some soaking in next.

Thank you, I appreciate it.

What kind of soaking are you looking for? Is there anything I can do to
help?

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


