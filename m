Return-Path: <linux-pm+bounces-29171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42804AE20E7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 19:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757E816F49D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7622ECD14;
	Fri, 20 Jun 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARKDxy6a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD028C84B
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440400; cv=none; b=mMxq3Cp8BhL5gQIFpB78uVMv/QKWNX36KHbhcKRKrbfbuE6iAXABmckeJU3iNjG+pPSrCC+K4Y5vSW+k1qCtRPWdDu+SezjCp552p81BV7beDl9NxPjMpJwsFZlKQ7LDpvC38YMD4InU3HI/diuiCsZn7+svQlxHNTpSYQraJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440400; c=relaxed/simple;
	bh=OMbvB3+Bgh7ZH/dGCkrpzdqRe/AVt/TYCz0eQJ4uPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtQ2XtxIDUes0DyHLhWM4viw0THpRBl6D4p6fbtpgWA1x7DBNSD2yJNFJgdZR+CuWDC2Yvz7z+hRqK7n7YHgalG3bjjS/CkhfYO1DuqapEjheltG/NT6WZbxAMC+YSV6U+qo5PqXwr9RQPy+02atrJxCAb0WHTfTwDx953qVuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARKDxy6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750440397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oW1wB1FdrUHROAIYbkZS8OO3BReKXHOvb71P4QLKK10=;
	b=ARKDxy6aK0lpbNgCFyx5Gx47s324lLAPs/jft63blKuYSjYojDV4uD+bYCU/+ewOiH8Xc7
	j46LFqTS+lGP/GJB1N7j+t95joEhvlnWOssK03SYj1g6HffGx1mb4ciME8GoJtwVf/A045
	RbKlazY7AvmLrwmEQy6x/2pIRSmJEqw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-IZZuHIkhNSi7ygn-2cPFHA-1; Fri, 20 Jun 2025 13:26:36 -0400
X-MC-Unique: IZZuHIkhNSi7ygn-2cPFHA-1
X-Mimecast-MFC-AGG-ID: IZZuHIkhNSi7ygn-2cPFHA_1750440396
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7ceb5b5140eso315083485a.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750440396; x=1751045196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW1wB1FdrUHROAIYbkZS8OO3BReKXHOvb71P4QLKK10=;
        b=WUbLJN0lXf5OLikS/kqpzSlsZ92hqibYd4Yy1s3qmsop2P3tHA4h+YNDAvzsPU+9mr
         zfd3lQhKdYyiRsJM2wYmqFVcg60nEnnAQNUwWFCJFbWhHPxlHerjgK/AqTK94Rcyz1K3
         0eetvayVmyDA8LV+rddRR3VlPDKUy+TrkVNyjPEUbAIyHBmXezdIt/iUAygrTowqYmiZ
         YPzJq+3zTpdymfkkf7Mi55fqwa1L5L8JwH+duckrxFPyyySFL9Qdp06Ubru274RIxuwa
         O5UdpE853iCa1adpGOXMEoK52F+vny5s7QH0SXVFlSbWRCT7uoqr9zrRt4cXWvyfGLg7
         Dh4A==
X-Forwarded-Encrypted: i=1; AJvYcCV+lMNrJonue3Iwy8t4rP26Vl7y/1RMAflu+QA7GD4hIU8s3kk/beRuaDVBihS2zanPZHYqErR5oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0pTgYnazhuF6eM/i9MCxy3VEW2vTWlcHkSlB14KOIRjkRD9d
	NPRlQAHNgyLULyvzrfzAFGCZeypT/nZpDh40nPQTv9Zk1+MIdOIk2MGFALoQluLNzgb80Z1C40P
	IAM65J97DiA3NGBQ0jhMtCXFqrtewKyFzOKD3HSL/KfApiKU8uDIfHP0PT38y
X-Gm-Gg: ASbGnct4dw8yX0iO2fwqrycXRpb3h4rSf4K6HGXpF4N5KCvdgWqJYEYEQcgFmvOP1R0
	NSbLmcgBwsXC4ItuNF+FZTu11AfSWAvnHcJR2fq3C9+L+m7pS6j1QyQypPP7EcF2AZn5Y7pOCtu
	MH4tJMIzooTZHUO4DIYOhrXAvkwaq1L4l0viA9395BMLXviPx+CtRRBt8qMzXCrCJrxEUSHWG1t
	uEm3kgIYnpZoF3DoaxLjIFtzwyfCXgku5lAbpTFoIKaLMx43JbSDrMgSj/tRgqvB5LLsKU6vpQ3
	WSScgOVncYrm34GWO4c=
X-Received: by 2002:a05:620a:4508:b0:7ca:f2cf:eb8b with SMTP id af79cd13be357-7d3f9923e6bmr440263885a.34.1750440395704;
        Fri, 20 Jun 2025 10:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwn0FOYZdQIgzW0lIgog7qT3m0aCTEHJnIBNGa4hMVm/8ZQQ5oeBJdA+DeqKv13eQnIHQcNA==
X-Received: by 2002:a05:620a:4508:b0:7ca:f2cf:eb8b with SMTP id af79cd13be357-7d3f9923e6bmr440257685a.34.1750440394942;
        Fri, 20 Jun 2025 10:26:34 -0700 (PDT)
Received: from thinkpad2024 ([71.217.79.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999c1b6sm114174185a.6.2025.06.20.10.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:26:34 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:26:32 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Message-ID: <aFWZyPs4eBwGcKPu@thinkpad2024>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>

On Wed, Jun 18, 2025 at 03:54:56PM -0600, Shuah Khan wrote:
> On 6/3/25 01:16, Shinji Nomoto (Fujitsu) wrote:
> > John Wyatt wrote:
> > > Did you test this on non-x86 systems? If so, would you please provide details on those architectures and systems?
> > 
> > Hello,
> > 
> > This patch has been tested on Arm-based systems.
> > 
> > * It was tested on our internal simulator based on QEMU which supports boost.
> > * It was tested on the Nvidia grace system (which does not support boost).
> > * The cppc_cpufreq driver is working on both of the above systems.
> > 
> > We have also confirmed that it continues to work as expected on AMD systems.
> > 
> 
> John,
> 
> Let me know if you are good with this testing details.

I have not tested it, but I the testing details are fine.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


