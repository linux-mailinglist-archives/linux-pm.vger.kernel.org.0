Return-Path: <linux-pm+bounces-33689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89AB416DE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD07564F7A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C42DE6F2;
	Wed,  3 Sep 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmofkps/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE012DAFDB
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885036; cv=none; b=YvnuhB5a/MUZ279OB6xZLKxRdCcfA8cOrlHcm/BiXI0kj7d/2h/I3r1lGch0TXGGKmlo6xrE97H2hVIp3z+uIAewUqw9c66anQMYCvgjpn7SGNEx2C95vx7JHGDBQa/QZS4UZXH7ekn2nLb5nnJ5XoQ0o3PJ02CxDr4K0WengoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885036; c=relaxed/simple;
	bh=5/z87dqJONhRttw2oqyDaG2i79PBkosP9EhsOOLmELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3wfnbNDC3cRIE3wrnuMSgWp1FYVjrGocFSYwG7wRznMzE0K2om9KIcf+lK954pddQGuOHZHoCM/q7XXrT7X84DGSSWeRGm84/Q+5RErS4IVCdsmSEPBt20qdkpR2HPCr2E7HiOUI9lLufFXh7U5kxmW4qdmbXIUVSpSVNwdirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmofkps/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-327aa47c928so5275394a91.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756885034; x=1757489834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeEr6faqcu2IUu37d/6zjI7aex7l+0Y0LxEBdw8Qllc=;
        b=qmofkps/deI7dbnZkYGSiqjCWwJjM2QmBBObpHXnTflSiSUTXXG27CvSnRiYivqqAj
         iZtDBcu9gkP0WugxCyovGRswJgu7WRJVfThc36JbzRjRpGFhGIhEKJW1MRjkmaz6/H7X
         Pr+j8qCmhSD7OkoAYLEOcNYh0uzD/POd1+t5AzgoCHV6gbycg9GPn7QncA4aj5AWSECd
         d+5DoKX2v7AeGWozk35xtviPnrpDfpdlJC8CQIOobyr1OmU+YoTUgHJW101AdqFEsoLd
         TZTYxC7MP0LM26xj2OzjxbU/cAbYOAl3df0Vky19HGIXLRKh5ZMFZS/4FIzCNcbEi5og
         e4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885034; x=1757489834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeEr6faqcu2IUu37d/6zjI7aex7l+0Y0LxEBdw8Qllc=;
        b=NESZrMAQoADSu1msXPD81mNPuh0JlW3gDmrmg1oLcob42Kk1NgqwQL1T5A/VpY29k2
         v17YYoCPaC9B83l7dRn52IC7qyhWL7NvplBLP1RuERv3f8s6+mGIqlCpqE8dFJ5UFDYv
         V9InRRkBLOd/cK4ENWgVX048YZ6saI0s2Piu3gC7fAcIEDuAxOm7RXciAU7KeKey+IcB
         mrRj9sdADr79lUfZ9WN3h3rZQvqYnXAp10ciTPtSW3oMdUMxhiSt9bT41zUaK9PM/ZJG
         Kykwk5xISkh/BzFoolqEKHFtINEteUPTgkd/qEPaxx1Z/Xp8c6EXnJtZHAYtM8X5Eqz5
         gveg==
X-Forwarded-Encrypted: i=1; AJvYcCXnzXHrY6wNnt8DcKVsE/bo1kKQbo5e+3niqgyByzUe6hWSgJATbO7VMT0xcyQ+PuWF4w+2x+3Mrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXAav0xhjvDeyOJMRU5/iKWQfWNgqwR5J7LBJc2VC9lJSgR/G
	Eh9vjlqXApCXvReUKHf0ncP0JGIOHEKsr+MEAaQzWnRud1hy5JfGDHmJHKixmaLwRNRMRRrv39N
	IEs8/
X-Gm-Gg: ASbGncuzDP911FOWIbdxYLfnjPdh+xAGtJ/EAHi+Hefbp0bVB10BMZOJk1t88Zc+pwe
	jCF44NuFToIR3D+oTGj3cVDfEAINdaHQRzYuikGHaYVFz6PTIC9kMVG/I8MCbCPctKvchHhQ+Ta
	dUt1kMvdFJMmykU+we+f/kN2EjwUd2OM20rLzobCmeRmalp6R7g51360I/0hxZ1+vW4xqu5EyCL
	4uMGekLUfn478BDdBeGx1q46QAwgghhB3IWr5q8adTzw+u0rVjFOEeJblgv/amT5F9g+n5kaQeg
	G7fZHggWoVYrYVMY0Qw0n4AYluW6fKNQRb89T8Pqh5+VZ9BGR43mOI47FPETKU4DfJIEWFiAho5
	a9ATC0Ll2NlrU3CabkPSDSYN5kaLiZWCkuraoGSQYMbJSXg==
X-Google-Smtp-Source: AGHT+IG+IgOCqCBBK/GSnV+LZc4Ay0J5k/OAV2zXx4a12mbjTf+uc4/DXdi/dVLFfCCSMBHcAmtO4g==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr15081588a91.5.1756885033765;
        Wed, 03 Sep 2025 00:37:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329b3e28a10sm7622534a91.18.2025.09.03.00.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:37:12 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:07:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in
 powernow_decode_bios()
Message-ID: <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
References: <20250903072936.4067-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903072936.4067-1-rongqianfeng@vivo.com>

This should have been marked as V4 with details of what changed.
Sending it separately is fine (though wasn't really required), but you
still need to maintain the versions.

On 03-09-25, 15:29, Qianfeng Rong wrote:
> Remove the unnecessary 'ret' variable from the powernow_decode_bios()
> function. It is only used once to store the return value of get_ranges(p)
> before immediately returning it. Simplify the code by directly returning
> the result of get_ranges(p) instead.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

