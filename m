Return-Path: <linux-pm+bounces-10892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789892C1E7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889B21C239EF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1D1A2548;
	Tue,  9 Jul 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRzqR8lY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134351A0B08;
	Tue,  9 Jul 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543390; cv=none; b=ho98FZwWyOxxSBHSmI4CPqHv+XZCA0j0wsQXcHFds0tvaQq918+NJWCflpfr+vFIpvDA8FkJLmm4n+/CA3lSKjtyIGvY/JIJjm8d8/DKLvKuvMl89me/bIw1S3c+6oyd2hMpuyJl7F2XrAywFomkJCxVV95gJ4EnpaJtUIjdCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543390; c=relaxed/simple;
	bh=TR/Wk2Ymr6zDUzD7O1MpwJZ0xD/MFZm2lFpes5G9uQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndGxRp4IdL6tJdagB0nBjQ75XENW7K6xB+IoKr5BrP0IgIY4wEit6mscyAlPscyEpTRUjUlQauxupfTIyxPGVrX/f23eEzHKl/zo3VUH/dCV6rPig0LVPs/ZEE93mkB8WP5kK/CqODm0UvDlzeUkPcycuHjzECh1D0uv9rTRzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRzqR8lY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb4a807708so43384935ad.2;
        Tue, 09 Jul 2024 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543388; x=1721148188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBbX8tDZ7wvrhTn6w+jVbtIAVSqJY+KS0LoQEJJnWmc=;
        b=dRzqR8lYZDdKD7BYWK/cSrljNFHZwTa6iOIwW9P0tXvGFNv88jWTAXXfxnWNU8JKIe
         xUih2fUkuvp4uzPFdi6qptxDl4PsjhV7oNvaRJ6sma92wzuY7ccLq8ILVTTzK+OZRMyT
         R44Nki7n0jstWhUP9VCHL9HFvLgwWGFwlO9zZxunQsZWTIMh6lTiM9uKoUY+hPxz3syy
         MtuV2jINpyqmTm5z7CXhx9tWU+7S9NEf4ZlvIHYJRy2Bh20cG1VSBiaVgSmwVKvw6Din
         l/RfYX0m57m10CedDtE6sIFtt/Qs7Px664vtlemSMNaV5LSqf1FRz743AYFZ9jQ6ErJa
         f/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543388; x=1721148188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBbX8tDZ7wvrhTn6w+jVbtIAVSqJY+KS0LoQEJJnWmc=;
        b=I1kxtPAqvpWAm8aj9teHmXAizXQgO/fBS0KgLQCnNEljKoDAvAg2XzRyg1iPRWOfpC
         SHMdqgFgQL24za+2p89PDV6kq+VUNhcWECbLZSGtoXClAH2ETapNXeFdgi8/WY7XQ6ny
         xgd6s0jD+bpYEdfld0QeJJ5QrqK7EMUNcDVN6mZ47YZBRVMLGL1f+y0xYvhJ4M7c0HRq
         O2woIiX0kMiD0ptQ/5di4FMGTzsxDSMf9OmZLJ6fitcIlHc1KfiSYWNGVkjIefgeESSV
         tJujdPpGvIE2Oasi5vGAIBRQlvfVYZv6frntTx3PtEPCAfx3OOUhu1L3HCSVmGe8xLe/
         de7g==
X-Forwarded-Encrypted: i=1; AJvYcCW/1Wnk7Arymcthsxne2lqOyQUWd3mI5iA7WuZFw7R5EDNxbkr9AuFY3/5paddD9Z+qR1kHpJ3ckVbTYh+EacveQxNFUcU1mhzs8MmrzYSFixtKIninJ5tKB8Y1rfdmfoT4CyUre7E=
X-Gm-Message-State: AOJu0YyShK9ERk30S0F75q/zGDjIEzh/Ytpl/7SyKK2WxFkAjfLWf+KB
	T3Q4BVeTRALTK7OJmQ4FGdQNU6LcS9nqEeVDUXkoj85GqB2ZbraN
X-Google-Smtp-Source: AGHT+IHBTX/4c9UYQRBjXQFJ7gQkXlQP1VuUaUWp4EdisUCDxLg3G/8K7IIElOFr5TGQmQ7JhnZ+mw==
X-Received: by 2002:a17:903:41c3:b0:1fb:72ed:4207 with SMTP id d9443c01a7336-1fbb6d5ae42mr31536625ad.40.1720543388298;
        Tue, 09 Jul 2024 09:43:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75besm18174215ad.148.2024.07.09.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:43:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jul 2024 06:43:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <Zo1omq73-ESGsVVg@slm.duckdns.org>
References: <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
 <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
 <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org>
 <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org>
 <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
 <ZoxVZPCrWokjfmFY@slm.duckdns.org>
 <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>

Hello,

On Tue, Jul 09, 2024 at 03:36:34PM +0200, Vincent Guittot wrote:
> > I tried this and it's a bit problematic. Migrating out all the tasks do
> > bring the numbers pretty close to zero but the math doesn't work out exactly
> > and it often leaves 1 in the averages. While the fair class is in use, they
> 
> hmm interesting, such remaining small value could be expected for
> load_avg but not with util_avg which is normally a direct propagation.
> Do you have a sequence in particular ?

Oh, I thought it was a byproduct of decay calculations not exactly matching
up between the sum and the components but I haven't really checked. It's
really easy to reproduce. Just boot a kernel with sched_ext enabled (with
some instrumentations added to monitor the util calculation), run some
stress workload to be sure and run a sched_ext scheduler (make -C
tools/sched_ext && tools/sched_ext/build/bin/scx_simple).

Thanks.

-- 
tejun

