Return-Path: <linux-pm+bounces-14516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2897D5A2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E83F1F23E89
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332914EC59;
	Fri, 20 Sep 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU22EkQC"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C014E2D8
	for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836287; cv=none; b=TAySIaSkg3T96gEkh//PJICj9nR7NYD+RPU3jrUWFnsmaUDGA/zb2H+AODuY4wx/nx0RQ2Qcptt4exAMR6dRNr42/6b6v/E8w+PdvsA+IlS1aBmbavzfmqy0aqI+GCl4W9GmwriyXw3ceGZF7ro5A7R6gFuD9MzCHEiqJrp91YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836287; c=relaxed/simple;
	bh=1BxVcLr9T5akCUa67eGdALCWg8upJ7NHQmVMbvnzQt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob2t9uFWzEctJExBc7hKEYZl3/EpNE1oA1fXb3eu5X5N3sOSDNOGTr24NJSaVql8dsFllCP13ef7oRBr8VSQPUQRA6N204CUeVh9JJoN2MlMXpCcdkRjXMYoeVC8wF1NmL896I88LkxyFlBtd33KYKcB2DTRPQa8Fi8C8yJtpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU22EkQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726836284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34v2s0941spqI0sqw1O35lewMWE79s3/bYHocZBIF2o=;
	b=LU22EkQC4MXtJ4adSU/oFLxxVTdTiWDlrEmdAt26fZXiqNxF/8FUVzxcf+Bc6e6CRAuEis
	k7PhErYalpmd81NwN/L695HOSXp0vAAEGTXaqme9lLwk52uI6lOVTU9+GOQCFf5EBqrU4Q
	9t/7Fer/nagkW8bZB/gbIE5lXYAfw9E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-9j50VJn_MgGZmSCH6h3t1A-1; Fri, 20 Sep 2024 08:44:43 -0400
X-MC-Unique: 9j50VJn_MgGZmSCH6h3t1A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a9aae6728aso612101985a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836283; x=1727441083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34v2s0941spqI0sqw1O35lewMWE79s3/bYHocZBIF2o=;
        b=O7BFN+kpt28Wgcw6eqcPdtdf/I11jq3ath3sLBxldWHwYNXO98cLF3y2S98+Kii119
         p0wEOrM0tBgIDae8Pq1KQefcZv8jRUVpOh3Q/3WcS+FF75kRNlMhtjUJhcOdOs/ekiyF
         9axEzxXZqjIE+lqv984eaMauHye/3+1jXb2DFKLNLU7owPUMOCbom3mPO+d+4rWcGKsJ
         rRuNTlE9Xi6oIJBQVQ2G3m1pwu0uFzzcB8T6IZ+nfqekHiZLTK5Mvkgcid6diekUFMjJ
         82Xpi4iAQ5W9+RHzh/MseCZpE5WgLBWTDaSclNMfpfu65/DSdFtGRlyOVU3qsrvOT5WR
         CB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoXz3goD6WdYQ6dsp5X+BmLtYVTqbp9xzZKUFPkueJZwiW3qz5qMUVeqmtmTPXok98+uswxJ0b6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsr0/BXUYAq2eE6+hTSdbNqaApILBOiPi4/mAICBaJ0blRAkQQ
	yM0D/d3T9yDntCPx86luj9/5v6LWA/fIWnbhj61XjIhPQz7ZUZpO58UQSRaVZREJaL5mubAx93Q
	MYp5F6zxQAfx6XpP3ulwJV6b7A8N4QXvriGzMuCfwCYkC/Pnwfe+9Ocah
X-Received: by 2002:a05:620a:28d2:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7acaf53378cmr1041353085a.5.1726836283035;
        Fri, 20 Sep 2024 05:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGPjgwWDVf7c4pej8MrohxO1Rs0UK5CIECse5obYH6phbeEFFyOd025EGIcrgOUVrGbjolzw==
X-Received: by 2002:a05:620a:28d2:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7acaf53378cmr1041349985a.5.1726836282665;
        Fri, 20 Sep 2024 05:44:42 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d9098sm171843785a.111.2024.09.20.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:44:41 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:44:39 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Message-ID: <Zu1uNyTWDgot8cQY@rhfedora>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Fri, Sep 20, 2024 at 09:01:49AM +0000, Peng Fan wrote:
> > > Not sure you need 'tools: power: cpupower:' in the cover letter.
> > 
> > Will use "tools: power:" in v3.
> > >
> > > > pm: cpupower: bench: print config file path when open
> > > > cpufreq-bench.conf fails
> > >
> > > I do not think you need bench either.
> > 
> > Will drop "bench" in v3.

I do not think those alone are needed for a v3 since I was corrected on
the changelog; at least as far I am concerned.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


