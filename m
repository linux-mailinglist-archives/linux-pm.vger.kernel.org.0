Return-Path: <linux-pm+bounces-8223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD888D145B
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7F1F21EFA
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60F5027F;
	Tue, 28 May 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIxuLzCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38231A8F
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877402; cv=none; b=H2cbUyqgNxaTB1MsP5hBokh6CHaG4/SjQlZsTEYioEe0VFPFncn831uarv9k7F/4lxnIFOP4bZAmJDG1ofzlSTLPj66uLOLzJbgRL/c0iRRpOgKkfqsZJnKKHbUtwqjk4klIqdsDss81xk8Ace6SlXQiSSmsZy/XJl4BmdO6Cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877402; c=relaxed/simple;
	bh=l2mgolt80XQ34VwyWw4JN/6mQSIjqbSCPqROaNf+67s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2+s7WgIe9uUrI+cYzTpXz831f/W018z78U5VICmu1Z9Wf/718fuGfI1J15e0kPBGkJCrTltQgrZAnrM6wHXCehSlZ1TDp/Z58trbKjNEnI8IoNCbZY/pKerRSP5hUVEh88vEsBui9Gad6XHtxT9bWndQn9sza4UCYr4zWf1+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rIxuLzCv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f449f09476so21166825ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716877400; x=1717482200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOntPxGeo1PZeEVE8urr6q5OxtnYy9l167prLlGp+oQ=;
        b=rIxuLzCvqyrsqBC8CU2g4B2zvfhTyVaIOgQDkWmpIj8iIBjpAbPpMY8qOfyMNMzhk4
         KLR0+A8gyfU5+9ApsE84HK974zNSvcBxT+ii9vsPq/HnvtbLpPuzUAlKBUu/Pm8v3aUz
         VHop2NdOGQP+zwyl6DwgtaVWRilg6oWSmlZrHDPCVAydHNTkiICom2i02mE6DEX8ObCr
         dkoo/2NOKcF0yDWn4NYgBSNGAn+FRUyQ9mAQTaaqi+qiCmAdDR2rVxPALD1UKRBcVqkL
         0cMs2IWsAsvCguvkKn8F7UvOR1vwTZK5enPzxZ7yiT4F51I9qA5HzjvmJM62x3+azLwj
         6Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877400; x=1717482200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOntPxGeo1PZeEVE8urr6q5OxtnYy9l167prLlGp+oQ=;
        b=ItF77rVzkRBCVOUW2npWd5RM3M34qA34P8frYT+1WKkLr8WDyOujghkADylXbYwjw/
         /FBUySChQdIWCOS+CcZH8vPWd+hfroasLRl3zmX2S/Zc5pzaE11TkjJxQkVi7CXKDFDe
         iqbb0meThY0vadV3TxjNR5xIx9D0QVGiVvo8ejlu8eh7wehPqAOVa9rjlMTBkvi5C6Co
         5mmRcvStv5XFONQHJhZqo8zbsK5uYvIChHTK9XNSjvyGXAgVBsuPYWlLEtsy4g2y4iuS
         mbWIArfS7K/RzdwE/vktLI6DdlYCMWskRPwvnfl//nuv+J9yvKqdj1MJMVtegzAfFsZ6
         bUyw==
X-Gm-Message-State: AOJu0Yx9kspI1W4kROO46gyKbTm7vQ5whEDCatggRd62vnwsYVliLSy7
	VRzijGffwlSLF3sKYnUspDMDAvGqxrF5fUUycXEgI9adAzqY+VC1g3HcPGbuwKs=
X-Google-Smtp-Source: AGHT+IEJMNUgcL6rFt3SJav0KVtu5LxxIl6wP+NnalHpbXPujSIaphnZ3eM0r8/VbNkMDE7EgGudmw==
X-Received: by 2002:a17:902:f650:b0:1f4:8500:9f6f with SMTP id d9443c01a7336-1f48500a077mr83350605ad.11.1716877400467;
        Mon, 27 May 2024 23:23:20 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f471f127c2sm52061275ad.13.2024.05.27.23.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:23:20 -0700 (PDT)
Date: Tue, 28 May 2024 11:53:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pm@vger.kernel.org, lkp@intel.com, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH] OPP: Fix missing cleanup on error in _opp_attach_genpd()
Message-ID: <20240528062317.hfxxbiphaop5u5ag@vireshk-i7>
References: <b1378c474427edae9c17a6e84b628c1f1cc59d6c.1716874256.git.viresh.kumar@linaro.org>
 <9842d369-0031-49d8-85da-c60dc39d22c3@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9842d369-0031-49d8-85da-c60dc39d22c3@web.de>

On 28-05-24, 08:20, Markus Elfring wrote:
> > The commit 2a56c462fe5a updated the code mistakenly …
> 
> Is there a need to reconsider data for such a commit reference?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc1#n99

I didn't add it as it was already there as part of Fixes thing. I will
just drop the commit id from subject while applying to avoid the
duplication.

-- 
viresh

