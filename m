Return-Path: <linux-pm+bounces-14189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1F9785F0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D3F1F25CED
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB16BB5B;
	Fri, 13 Sep 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDOFmdE9"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2778C75
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245527; cv=none; b=pHE8WVYJ273k7ADhhJcq1D2ipFetzS6acrIsXRIM3MYbRtchdQE0l04zqC32SU/85h8XXgsHNQ0WSYPbBd5zjtlp+CzmceHdDri9zyKoWoN36ntXYJLZoKMt3IBprYn7tGBYyMqBIh09lfOATrYX6KTS+4wyIiKcQ86Ow4p6nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245527; c=relaxed/simple;
	bh=eKRWbCrqp4Hi3KZ1gin7DIWDPLN6BS4r3sT0Wq7+39M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeTxoJCoSUroQrvedhhnkbVYZmIZ2bxGJ59gxpf57QKZoUbOvqJdGdezR948NVT5uEptm5rpjwN6m9tHeASIK//LmP8Sv2ovXxvb8mcgCWWs4IGT5d86asxiv7x5zRlBspKE4g10o/UOOXM4WxuovKSq2QpOJ8Lk+L3eslaillE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDOFmdE9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726245525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaZvsF0KpssXiytVEqsYTDYy7O6eYu1DovquR/AjGh0=;
	b=TDOFmdE94IB1mhy7bNFbcJ29qdMKoAd+oMA3xkS7OZ9kU4wlN95EXdbWryIDU2wxJqoeIa
	cUSE0kdpmmRnyo+eSht080xOeTbE6+txp0k92G43DX4KtCXSanYTxjjpf+KrfseQrNWq4T
	9HNJHg0k/A/++NLOYNMIGZqki7Cp9AI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ZP6k5mOmNneNCOjNrqdZhQ-1; Fri, 13 Sep 2024 12:38:43 -0400
X-MC-Unique: ZP6k5mOmNneNCOjNrqdZhQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a99d13f086so259078785a.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726245523; x=1726850323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaZvsF0KpssXiytVEqsYTDYy7O6eYu1DovquR/AjGh0=;
        b=miMxp0Jyx8tG/iAZ3chYGM+ARhGuReDo9Ry3F1b5Ri5Ci6N8PgNg67OKQInOdOXFaO
         O5d2tzlNcH6DOjxq1RBGvSgoIrPmOgCwP35fKLwu9Ti58NTTmTu1KOBOYXmb3XwoW4OL
         wdyLukQD6ek2Sll7+Ztk3dgj/r5+b63oBd2Bx3KfqscSRLII1v/ZyfyBlYUSrJFudzp/
         iBPhww94+qDZuO+BD0+vdtHUimXd/wv8B5X8SWffr5CBk+J6JQKsy0ZhUg2ziALGi46+
         o4xiSlPKN2WQFZhyNXZyQrLjxqUU6tmu/YsCYXr0JmsDmSCUPNpFZAT7dbDNzUNH0Zov
         FVCA==
X-Forwarded-Encrypted: i=1; AJvYcCUA82wg4dfWJiZ839z4GWXpEKgOc8WwvTD85FnBRI5Dt+t1aOdVVReoTu3ZkewXCDyL4U090ppjQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNkj4PU1D+p9lr+/c6tVrJZKcoOyZOUwDBs6+YKxKVbOh1JMU
	TMNAYnR4TfwqAo723zmOmxvnF++qQ9hvz9ImEGi4zBMUypHeklL4YT4NmdtVROADZO7hxW+d7ep
	BWybkfnukyFljS7s3z4mWPLbmizrJBuLxschiNCTNGJJvTEEycRkZcQni
X-Received: by 2002:a05:620a:1789:b0:7a9:d0ec:2d99 with SMTP id af79cd13be357-7ab30dc40ccmr472290885a.60.1726245523423;
        Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCWFymOpygZPYJIdqdGAzh5LWofNDVQvIv+azfhWI0wpBA+ObnwQLFnynF0xMguXytDYqU1w==
X-Received: by 2002:a05:620a:1789:b0:7a9:d0ec:2d99 with SMTP id af79cd13be357-7ab30dc40ccmr472288385a.60.1726245523073;
        Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1dc91sm683815585a.106.2024.09.13.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:38:42 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:38:41 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
Message-ID: <ZuRqkbJixRQEScYA@rhfedora>
References: <20240912230102.157534-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912230102.157534-1-minhuadotchen@gmail.com>

On Fri, Sep 13, 2024 at 07:01:00AM +0800, Min-Hua Chen wrote:

> To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.

Would you please rename this to .swg instead?

'''
5.1.1 Input format

As input, SWIG expects a file containing ISO C/C++ declarations and special
SWIG directives. More often than not, this is a special SWIG interface file
which is usually denoted with a special .i or .swg suffix.
'''

https://www.swig.org/Doc4.2/SWIG.html

I tested it and .swg is not removed by 'make clean' or 'make mrproper'.

My apologies for the extra work Min-Hua. I can send a quick patch
instead if you wish.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


