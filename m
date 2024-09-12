Return-Path: <linux-pm+bounces-14103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F9976F9C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61674285BC3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049441B375F;
	Thu, 12 Sep 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6H/i9pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F2188592
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162607; cv=none; b=Dw4AI/PED3J6ZQeXcLDMAzdtXwjbtyPybL2pYASDtRyN07TsXYaRxtzd3gox9zrFcjnyg4qddn/hX+stnq40EMrLdQQXKAR7cOxnF6SN62rFa0HHdNJ1E5alJ1nXn7j7HIoQ6CCpHQy2OibfbnY0U01Tlk40EGbL5w62X9YV3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162607; c=relaxed/simple;
	bh=LMJ1MzhL6Gl4uKG96gQhRjx+1mejnwtkSR/vqoQDdpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKYEQ3cUkMJC8YXi5pTEzyuRT8pZcMEA3QfefHpLKgjQzbgxQ6ZseUse32Xsmx2gQQe/l27aE7G1ekY4rybs2rkhKRgU2plESQAbAIFgnGbkTtKhFeO3HW6W6MyFZDT+koMiyApG8y017OzW8VX2Gk9IlScAt4XEtlMg+xZGYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6H/i9pp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726162605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QtpB8TExNQVM6YWGVwyJGzRs7f3WAeIOtC1C2GaYK8=;
	b=e6H/i9pp/ZYS7YueA2ZnwZyeWN1vru7qetQ5GM5WzkJEzMGBXU+QbGUyOL+5FD1ETQWfGI
	Enup1sxS1QhvINdvejZyNefDXCp46JWLl+Gfk2kLb2qhJ2OfslzD67wIt70nh/t/cElb0+
	KXdOpwXA7Q8y6NbejZeR8Vz2KTIHzRM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-0t2x_MUlNYO9aNIA5iZrDQ-1; Thu, 12 Sep 2024 13:36:43 -0400
X-MC-Unique: 0t2x_MUlNYO9aNIA5iZrDQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c3643faf9dso19145876d6.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 10:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162603; x=1726767403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QtpB8TExNQVM6YWGVwyJGzRs7f3WAeIOtC1C2GaYK8=;
        b=YI3lwJTvehYRMe6ATJWRo84v/KlGtqeigqoteFy3j9cuHrDzB+r1aZ6vsgRTZPJJ0c
         JyO6GqgVvEoehkwpxqpV18fcNrArZTz/+vMF2Ph5LyPzDMW8jJFaTMN43qN1Muo6d0r3
         HX8z0lGYq8wvPikXrbGc17QHXIuN5noUZ2EoPks3yozF9pCT7rtI8w0g2JdBF3e0b6Zf
         XOs6FhE9E6UdS2kd03w6K7rksAj4PaexZJMMjZG6tnLu7L8OHAVEZJ3qjrIFrpoU/1s9
         88fboiag6B1Uy2F8LBLwgsLvN6NnoYqoMQpjCchfVyFhkPH/2rg23GBSKnZVFjPFKVl/
         Nl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi3F+2tURLdXk509J1BkQHQsRw2NkUEI4miD1YNGBfuQ+jqGmQGwvqXDFsPzfj8FclBbKJebT2gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa1FhLMQjJdPyre2JzrzhKRokEkiqpJBRnbvQ0ytwhniT7CYw
	QHCGW37Mj5unB6uNXtXzADuJpgTM7kiOTkK18iYtiQ/S1quWu/+0f2tqR58DKJO+1XsSFeP3DnI
	CeZSoJGuVmWiIAr7shVGl8pLvDXlz27v/3q5CyxiZkLsMMioH/ScQorx5
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id 6a1803df08f44-6c57355a292mr54233296d6.20.1726162603330;
        Thu, 12 Sep 2024 10:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd+uhL0xCsfLz3jXDEoezjNV9J87Fao/aUhC/IKXjnpIh+QkTZ4m6eoCWG9MsxhUfCcKlrqw==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id 6a1803df08f44-6c57355a292mr54232956d6.20.1726162602984;
        Thu, 12 Sep 2024 10:36:42 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dfb8sm55947696d6.24.2024.09.12.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:36:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:36:40 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Message-ID: <ZuMmqAmr62ErjqHc@rhfedora>
References: <20240912125030.19809-1-minhuadotchen@gmail.com>
 <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>

On Thu, Sep 12, 2024 at 10:31:19AM -0600, Shuah Khan wrote:
> On 9/12/24 06:50, Min-Hua Chen wrote:
> > This RFC patch is actually bug report. All *.i file will be
> > removed by 'make mrproper', including raw_pylibcpupower.i, added
> > by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
> > 
> > We can reproduce the error by performing the following command:
> > cd linux-next
> > make mrproper
> > cd tools/power/cpupower/bindings/python
> > make
> > 
> > We will get an error message:
> > make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
> > 
> > Renaming the raw_pylibcpupower.i is just a workaround to fix the
> > issue above.
> 
> I need a non-rfc patch for this. Please send a proper patch
> I can pull in once John has a chance to review this.

I have reviewed and tested and this. I am good with it being a stopgap.

Please send the non-rfc patch.

Thank you for reporting and sending a patch for this Min-Hua.

Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


