Return-Path: <linux-pm+bounces-31298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ABB0E328
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AAE1C82EB1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EA28032F;
	Tue, 22 Jul 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOdqGkm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B58280317
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207169; cv=none; b=p8CSoPnrfIi3Zh1h0U8cfas459sIndc9NyeHE2nlV3qL6ZQEw3j+ye4i9hMfJc7Hp8O+uVM09rTucjqcVsAzuJ7BOTVySimO7a8y3PoAghhwfSbMS++4OzZC8+lZd+s1gFiHF7v0TRwdPrVB7KHXbRFVXjskRT2h4vlPe6ayIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207169; c=relaxed/simple;
	bh=JiX+WUAcLJXpo4QerqRjpVTvbXXolkhGNQpOPlELs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D85kG7RXrtWu8v/GzVnim/R+EmbTSGn4/jiFlja/v1snMKIRcVkPETl80L5JxZnGYSQ0RUJMnaCxPQFYTJ+lJu7zbiySHaxVi6jn8XZ6cZwCpxZ/uWY9VuTlb2XO/RVMT6ZIYFflJpfOdjfxUB0psBO6SLEION+hof7XUoJ3LXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOdqGkm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753207166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3RxMWKI0vx/8E9XE0zit4VRevVC1NeFnlkYll0kJM=;
	b=TOdqGkm2mEDVAnhbprGj/HPUa+uxTdRgZwv4xqkocVWB5hB24YLQ5O2TjJamaBBR6H4v/C
	71jwbevcZH4DO59gMXeqUIQKODWj6u7yyuQ0f7nincx/0R/3IANLAE7q5sL5rgw3V+SQrt
	gi3tjEgTstKpPEW/RrJ0BEwuB4eq4rY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-iRZDzHidNE-SnCuKmaECtw-1; Tue, 22 Jul 2025 13:59:25 -0400
X-MC-Unique: iRZDzHidNE-SnCuKmaECtw-1
X-Mimecast-MFC-AGG-ID: iRZDzHidNE-SnCuKmaECtw_1753207165
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb520a74c8so95902576d6.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207164; x=1753811964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh3RxMWKI0vx/8E9XE0zit4VRevVC1NeFnlkYll0kJM=;
        b=fBEDknYrno9gJXfHpe3Q6VL83LlEtJklzWyYPFdtH0nNcmv0yVSzh6VRGwFKK8afV2
         UPbsKQSUBJ3bfCj0sf3znEkUkjhZc7kpoaQ1CkqtFCQC90+ZuwEdNkWThqtrm8wOxcxq
         om1b8Mo7nqszMo2W6SvRIAU1SUQkiDVy3KcgHnjP77aEQivLJMd6doz6tVA7kDXAYxXd
         ixJzFmhNTduw8JEXjPMGDfmVO9C92khE7/Vk4Y57lL1kEhMuN60xHCOZ1LoyDw1POpRc
         OOFhK77w2UsUV4EVljgXbdkLT44j4GyshwjMZ4DeCqKcMGzddmiMjZJlGxdtDnjrGSvH
         AoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdAJNXlS5caONAlp0FadWfLWONaZKM6/SRjbAOwD4klcwGO8etORrJuCSM7KyZvn0PGWlTMbU4BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBTUJKd+lbDXHCGnP1N+SyFYMMqY4HV0+gQn0T0ba5/Aq3w6o
	CGSTJBSdzelk6DHzRxsqlG2USTqlaxCy7Im0SuM8EsjlUZaxjwaDBsIZovkPnHsZgoiPt2qoCVc
	nYrVvd4Xsv3F3WCu0evTVSwtCVNjKtFnSzu/nzOgRKWMp0ckk4ilcCTBVvSLsZ9ZKUBN3nOQ=
X-Gm-Gg: ASbGncsF2hMOs1G11slAnRw46pMMCvLw7Q/yZgwyuOef6bFNzXb2dUqhXUN5sy1/ovH
	rG7Q+9rFM7cTkHGjKPRShQg86KE04ZdW/jZQz8dGtPnHZNE9HIUgb80zoCAEB50gdUKVEBXSoLi
	p6QOMb8QiKefvNq7Oi74A/blZeDezq7fVrNEaZC5oxhHIGeR7qnsQ6Vq/rDNU9xh7FJH5IN9Y30
	NA8FIvW1Bf8pTDZWHu2zILJ41pQeC5qsIeOUMWXt1P/0ArWfCJsk6dvwIbGxRRN5fxlB7XEm14T
	LNHJtLf7ejTcaQfbjkWSqwm6wEhbf/53G5zS
X-Received: by 2002:ad4:4eee:0:b0:6fb:5f97:510f with SMTP id 6a1803df08f44-7070087533bmr173256d6.44.1753207164555;
        Tue, 22 Jul 2025 10:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeND15EoY0kc7n9IteeVLBb4rW6kvwLwTt2goaOdVkAt7hhA9cKMxKBefg1R6RRXfZP7oCYA==
X-Received: by 2002:ad4:4eee:0:b0:6fb:5f97:510f with SMTP id 6a1803df08f44-7070087533bmr173036d6.44.1753207164206;
        Tue, 22 Jul 2025 10:59:24 -0700 (PDT)
Received: from thinkpad2024 ([71.217.76.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-706e09879a8sm24041736d6.72.2025.07.22.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:59:23 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:59:21 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Message-ID: <aH_RecWNuC_UqUlx@thinkpad2024>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
 <aFWZyPs4eBwGcKPu@thinkpad2024>
 <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>

On Tue, Jul 22, 2025 at 07:30:27AM +0000, Shinji Nomoto (Fujitsu) wrote:
> Hi, John and Shuah
> 
> Regarding the subject, I submitted patches to cpupower, but so far I haven't received confirmation that the content has been approved, nor does it appear to have been merged into the shuah/linux.git master branch.
> Could you please inform me about the current status of the patches?
> 
> Thank you for your time and consideration.

I do not see any issues with the answer Shinji gave on testing.

I am fine with it being merged.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


