Return-Path: <linux-pm+bounces-11817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8794541C
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 23:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53251286198
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009114AD29;
	Thu,  1 Aug 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0OFA/Ym"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FA1494DD
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547468; cv=none; b=I0xCIMUPjs/s7AK2lpcGfOQ3fcbcUciHuo6tfAQrwXm5k77ZUBU/JSjUNx4TnyuKZEMaVM5rSRygmLP7oVxM3kiQZoJ74B8QDRiyu74NAgOtH4BagpjoAEcGX8l6KLceJEDtfItui11fU5Kn7SjOufICkeKTJwOZKY1bGNT0lLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547468; c=relaxed/simple;
	bh=xdtpeRge9Vfdbp5i8Q/XmAN/i3Pwj2D4vqQwJevSHV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGsxhhKneDkdjHj3RLtk5VDty9ru3TqnV2xJatU2oq4LBya/GhqXSB7x3YesOr7x0zQHBSLxfMiZjwakxgPRHFIGbJ0RiG/2rOvj5eFq4O/XgVrSfBD5ra247xup+54w2gJXw3Z3BWFnWr8ZphDZqgl8yRfXE2/+0ax2Hh+ssMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0OFA/Ym; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722547466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpsa6WqlLQ24gIkydnwFVlMjHjsVBUqic+yLt9q1x1g=;
	b=E0OFA/Ymg0Fj374WIIzpPtvQVcsdpyVRbD5Tyw+div3ClEEamGVfqVIeFwT9jyjmKPGwrN
	naYvIiH3ujEZzi7jBO95WbzzWIIBhwaMo9p4C36pR6VjLneCRpLxGi6MmMSPhNGjFzV4+H
	X5p1Lr36RGNzKIVwKXBzUSa82F0JQfs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-S-uiHIpGPU28baQoyVRuXw-1; Thu, 01 Aug 2024 17:24:24 -0400
X-MC-Unique: S-uiHIpGPU28baQoyVRuXw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a34e9c8945so70531785a.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2024 14:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722547463; x=1723152263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpsa6WqlLQ24gIkydnwFVlMjHjsVBUqic+yLt9q1x1g=;
        b=p37urNwrpejKpitt+ipunpUf50kueJ6Sq+LAyYcNvTP7iHsnnQ9Foac5fC6/7cnXIV
         YKPXqPbOGUm+LmkJtRS6r0iV0HE2Na7qvph0PE58wy5nLl1Im6AN0M6zqOBwyrvPD/NX
         BA5htxXldHWdCU5UsrF2QpoFe2au2gg/+lIkkkEdO/1RCUE8sJKVmqbvsmda31GqO/VB
         /m6+x0a50dWOCXKFtQG9SdFcNZMI/eo+D+GQUe9tWTHRAThPxU90D0OnUYftY/19AQxP
         YT6XDIzeVHRtkDVAotO6/Cikxu+18hyC8H8rEai5zebMXStuQRJr540k4wu6E9if1+JS
         4liw==
X-Gm-Message-State: AOJu0Yw7vfpaVqeJeie8RiWGhWoe9PgRq44bzfYgVvEOxMF9AxC/lxCA
	ShbJG+FmElNFOEfCeX8cv2FHjVIrYYjaT06GKIlI/6awwBXxtQ2TnsS7DoO+orrY62mAAKkM8Ok
	L9AfAHB0FQ6mvXtQK1S+Qq90syKF9fhzm36HBJOTrrbpPAIc0jYi4CZzQ
X-Received: by 2002:a05:620a:470b:b0:79f:741:5d56 with SMTP id af79cd13be357-7a34eebf514mr189418785a.6.1722547463397;
        Thu, 01 Aug 2024 14:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLgxIKUl5hSuXWMg7RVBRx6acPxrsxiknMrKRHCXjMf9jYmXXtYzRDUbZg22fqVMPNEcdFqg==
X-Received: by 2002:a05:620a:470b:b0:79f:741:5d56 with SMTP id af79cd13be357-7a34eebf514mr189414985a.6.1722547462948;
        Thu, 01 Aug 2024 14:24:22 -0700 (PDT)
Received: from hatbackup ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6d8024sm29397185a.10.2024.08.01.14.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 14:24:22 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:24:20 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <Zqv9BOjxLAgyNP5B@hatbackup>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>

Addressing the licensing first:

> On Tue, Jul 30, 2024 at 02:48:41PM -0600, Shuah Khan wrote:
> > On 7/24/24 16:11, John B. Wyatt IV wrote:
> > Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
> > bindings code, is permissively licensed. Please see
> > https://swig.org/legal.html for more details.
> 
> Adding Linus and Greg for their feedback and input on this proposal.
> 
> What does it mean by "the resulting output, the bindings code is
> permissively licensed."
> 
> I would like to get a better understanding of the licensing angle
> since this code adds dependency on SWIG which is GPL v3+ to build
> the proposed python bindings.

Copying and pasting from the link above:

/begin

The intention of the SWIG license is to ensure that the SWIG source code (the
code that is compiled into the SWIG executable) remains free software by using
the GPL license on the SWIG source code. SWIG is a code generator and
the intention of the SWIG license is also to enable distribution of the output
code under license terms of the user's choice/requirements. 

[snip html license links]

When SWIG is used as it is distributed by the SWIG developers, its output is
not governed by SWIG's license (including the GPL). SWIG's output contains
code from three sources:

* code generated by SWIG, which is not governed by copyright;
* code copied from the SWIG library which is permissively licensed to be
redistributed without restriction;
* code derived from the user's input, which may be governed by the license of 
he code supplied by the user.

So, while the input supplied to SWIG may affect the license of SWIG's output
(e.g. if the input code is licensed under a copyleft or proprietary license),
SWIG's license does not affect the license of the output. This is consistent
with the FSF's FAQ entries on this subject (GPLOutput and 
WhatCaseIsOutputGPL), because the SWIG code copied into the output by 
SWIG is not GPL-licensed. 

/end

The output of SWIG depends on SWIG's library which is permissively
licensed + the license of the .o files used, which is libcpupower, which is
GPLv2 licensed. Therefore, any bindings generated from libcpupower is GPL v2.

SWIG Library and Examples license:

 The SWIG library and examples, under the Lib and Examples top level 
 directories, are distributed under the following terms:

  You may copy, modify, distribute, and make derivative works based on
  this software, in source code or object code form, without
  restriction. If you distribute the software to others, you may do
  so according to the terms of your choice. This software is offered as
  is, without warranty of any kind.

The snipped license links link to the GPL v3, SWIG's declaration of the GPL 3 or
a later version with the above permissive declaration for output, and a link
to four university licenses that all look permissive.

https://swig.org/Release/LICENSE-UNIVERSITIES

The resulting generated code can be linked and distributed with GPL v2
binaries. I am not a lawyer, but this is my understanding of what they
declare on their website above.

Please let me know if this clarifies this.

>
> On 7/24/24 16:11, John B. Wyatt IV wrote:
> > SWIG is a tool packaged in Fedora and other distros that can generate
> > bindings from C and C++ code for several languages including Python,
> > Perl, and Go. We at Red Hat are interested in adding binding support to
> > libcpupower so Python tools like rteval or tuned can make easy use of it.
> > 
> 
> Can you elaborate on the use-case and what rteval currently does and
> how it could benefit from using libcpupower with the bindings?

rteval is a Python program used to measure realtime performance. We wanted to
test the effect of enabling some levels of idle-stat to see how it affects
latency, and didn't want to reinvent the wheel. We thought that the Python
bindings could be useful to other people as well who might want to call
cpupower too from Python. I did some testing and was able to achieve this with
SWIG. We sent the patchset to see what folks thought about this.

> 
> > 
> > Another question is do you want more test files like the .py example? Would
> > this be used as part of a greater test suite?
> 
> I would like to see document outlining the dependencies and examples of how
> this would be used. I see the README which says that
> 
> "Next you will need to install SWIG. Using Fedora:"
> 
> The document will have to include more than Fedora instructions. Instead
> of a README I would like to see a document.

Understood. I wanted to get an idea of how we would structure the makefile
first.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


