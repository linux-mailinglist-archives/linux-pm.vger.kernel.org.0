Return-Path: <linux-pm+bounces-11953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A99499AD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F911F239EE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639C15B147;
	Tue,  6 Aug 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKj/n/r4"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFF158DDC
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977808; cv=none; b=AUrHry39N0V4r/fcJ0imNHtLd2gR5Sr40cs33q4L4NtWtJ1NsR7cKjPW5CTMLjxPwHRueZ2eoOQtNShvutd3wt8JwpgbKKUg7iLLA7ZFl5zz4c/Y2LzCqP3uy8A9FBjJGXaRza5PATbQSE0LmQtT4UJK38cqT2qJaw2q1shqd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977808; c=relaxed/simple;
	bh=pGi/uxcZi3YrvGaOOaaM8bWfjMaJ4H2RPHu7rzO5+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvD3YJp3lLYKAJOGRnU9pmI9Oz/2GecN+qDlVarCtsfwVMtFzDb88+ppdboLngkMlolC9mbLDvmGAuC+Oi6RgB+GHG4PzILK8MmoG22RvwYNoghKch0M+MrvUmLGEs1sG1IM2uhGwszeQB7z03VRGbkxXra5LwjQqh4H3zs/45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKj/n/r4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722977805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe6VBZJRiQp4qF9WjYWrAkKgoBmgqYQ+VXQlPMeplEU=;
	b=SKj/n/r49cyjdTh9mb62cNYdxSxaRVq1rajAZbZIRk001qiZE3p1GbPda19NC5vdoLY0Xi
	yNd5xrN+pfWe8TlxFNOEKUdi23iK24bvmJAvzDNIC8usAZ25RqESozjpEjOMvuQKG1C4CJ
	JyMxsdVdyVnPsHkNgbW/ivzZ12q1bHc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-6Er3X6z7Mj2GHFh1L52Gzg-1; Tue, 06 Aug 2024 16:56:44 -0400
X-MC-Unique: 6Er3X6z7Mj2GHFh1L52Gzg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-709561cbf29so1202377a34.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 13:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977803; x=1723582603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe6VBZJRiQp4qF9WjYWrAkKgoBmgqYQ+VXQlPMeplEU=;
        b=jDx3NMctBiArQJWMJrCl7qsZ0XcJdeDNPhzAwJXhoToatopliMt8uzdghTXeTvcBBw
         iJMen3M+tMRNDawEdmKh0h08XItDj88Uz6DiCaswDZoyAm2R6noqsNkMPugKCbMhCsL/
         dbic/7ICn5I3g6EIR707YCNk6bDRXVDxBpryXRheceR9QhvoQ3NukrMmnnhKAvwCQGQ7
         +0rkBG3Itpg50qv/CUDTSsGnx2zPvaxasHu2kwxfIrbkj//hor5Vw649rLmwHN2LOLkO
         EbqEkGOpOnnjiZywIyxOo7FRFOLSxMPNBMfQrrCfMi03ssGf+qgqrWkJ+3g1BuxA0L3J
         XD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcu8svcnIOJKNElic6fLhQzbwc3miQjbuvvjzS0xRyx8yztoBtnvQi5GL1Btm0OiSMEw+l0vFU7sQLOXqomEVdA8dV8p4AsLM=
X-Gm-Message-State: AOJu0YxE6AKtqA7PRUdvAmAWRfkS7DSeZQuKFgvxCs5PII02tg3sJhMR
	00tNoRGFALVZrfXM3SFZn0lzdG/sgNsYCNfzSnX6cX4TH1UsX1Y3VfEDrI1BKGFFHYCvjs01ye3
	odcWif9QI54LmBq9VEIvS0/bEFQlY1QMgFeJIFRBhuOMn3IHmzfX5yDoM
X-Received: by 2002:a05:6358:5906:b0:1af:4626:7e42 with SMTP id e5c5f4694b2df-1af46267f7fmr1799887255d.25.1722977803161;
        Tue, 06 Aug 2024 13:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGX6vrc5VZiBrLXAafPPUxZlhxnFoJm9EJsMe8SfamL2QQezK4MKx7rVKRflXSY3iRwu4Eg==
X-Received: by 2002:a05:6358:5906:b0:1af:4626:7e42 with SMTP id e5c5f4694b2df-1af46267f7fmr1799885155d.25.1722977802724;
        Tue, 06 Aug 2024 13:56:42 -0700 (PDT)
Received: from fedora.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c864c87sm50208546d6.115.2024.08.06.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:56:42 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:56:40 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <ZrKOCLYvYklsPg1K@fedora.redhat.com>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024080405-roundish-casket-2474@gregkh>

Adding Arnaldo to the CC list.

On Sun, Aug 04, 2024 at 10:54:10AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2024 at 05:24:20PM -0400, John B. Wyatt IV wrote:
> > > On 7/24/24 16:11, John B. Wyatt IV wrote:
> > > > SWIG is a tool packaged in Fedora and other distros that can generate
> > > > bindings from C and C++ code for several languages including Python,
> > > > Perl, and Go. We at Red Hat are interested in adding binding support to
> > > > libcpupower so Python tools like rteval or tuned can make easy use of it.
> > > > 
> > > 
> > > Can you elaborate on the use-case and what rteval currently does and
> > > how it could benefit from using libcpupower with the bindings?
> > 
> > rteval is a Python program used to measure realtime performance. We wanted to
> > test the effect of enabling some levels of idle-stat to see how it affects
> > latency, and didn't want to reinvent the wheel. We thought that the Python
> > bindings could be useful to other people as well who might want to call
> > cpupower too from Python. I did some testing and was able to achieve this with
> > SWIG. We sent the patchset to see what folks thought about this.
> 
> Is this going to require a built-time dependency on SWIG?  If not, when
> would it be run

It is optional, and based on my conversation with Shuah; the bindings will be
in a seperate makefile. It would be ran after running cpupower's
makefile, seperately. (But one can call the other.)

> and who will be in charge of running it and updating the bindings?

That would be myself. If I no longer wish to continue I would reassign it to
another person here on the real-time team at Red Hat. John Kacur (whom I am
working with on rteval) is fine with being listed as a backup contact.

The bindings would need to be updated every time one of the functions or data
structures listed in the .i file changes. But it can be as simple as copying the
changed declaration from the header file to the .i file to resolve.

> And finally, why do we need these at all?

To provide bindings for Python programs like rteval to easily interface with
libcpupower. It is very common for userspace programs to include bindings to
scripting languages.

> You are saying these are new
> tests that external tools will be using, but why, if external tools are
> required to run them, are they needed in the kernel tree at all?  Why
> isn't this just another external test-suite that people who care about
> measuring this type of thing going to just run on their own if desired?

SWIG the tool requires the .o files compiled from libcpupower to generate
bindings. Since we need these artifacts from a packaging and usability perspective
it makes sense to include the bindings source code along in a seperate directory
with the cpupower source code to generate the builds for them at the same time.
The source code is: the .i definitions file, any future Python wrapper helpers
around the bindings needed by SWIG, and the documentation.

Why SWIG? It was chosen for this project because of:

1) Many Python bindings generators are strickly Apache2 or GPL v3 licensed; and
they may inject code into the bindings binary that will create a license conflict
with the GPL v2. Swig was far more clear about the license status of the
generated bindings. As described above:
https://lore.kernel.org/linux-pm/1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org/T/#mb7170232fb429fc242bb45c8d3d4d5ed47f0c59f

2) It's extensive documentation. This is the Python section:
https://www.swig.org/Doc4.2/Python.html#Python

3) Support: SWIG has been around since 1996 and had a release 5 months ago. It's
length of time and the acitvity in it's community makes it unlikely SWIG will
lose support by it's developers anytime soon.

4) This RFC demonstrates how quickly and with little work you can generate
bindings for an existing C project with no code changes to that project. :-)
There were issues getting other Python bindings generators to work as
described in their documentation.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


