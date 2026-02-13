Return-Path: <linux-pm+bounces-42615-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBAgETMxj2mhLwEAu9opvQ
	(envelope-from <linux-pm+bounces-42615-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 15:12:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B150136F8B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 15:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A55A30E45A9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84635F8DE;
	Fri, 13 Feb 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="opSMYtr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F435F8DD
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991495; cv=none; b=Ob31kgDY1jyGm+Vfra2NPW1K6yPyx3qtj7YhY7J3n7M9RoMMKrl2p2OJaGoDckLu2gbjtTsq5RB4DAsS3ACe33ip/WkYR40Yov5XpLKZeSboA1C7JhFR20NgKQMntkiVMXDFTTyojsedcGq+AcNNW/pHz0ZCyuDllJLnZbrpVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991495; c=relaxed/simple;
	bh=UNLPzY8JFs3m+p/4K1jQF1/vnb71y/aulIlYtpFcVHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1yd1eKo89MX0Xu5kpRWd97eOuYUYGaoRltmoUoQ2gS2YT0EhYecKg43neG+Xsgd0ZScQxEXDHs1jU1GFty8zxY2Bg+QaTjGz6DsduSmmxCv6+ZEl4UBZApudNqT/EORwrtmWzJPTNMgMqcYq3dTmaagSbhZQkVqtQxR4mICnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=opSMYtr5; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb420fbb5dso43529885a.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770991492; x=1771596292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=opSMYtr5U9pthmrYKeiGERIP/xyFxclEAcaP1OI8KLpcfOM6szpqW1coA8vMiJOFD/
         06n7VfmcaJMpILAbM6KOJyvEDw9bTfX4sItyI62UfhxXxji4MXJTYpuHkoqqyoHZBOpj
         xprpqIY6aBSZCzU3h2b5HGqCqyoIkC5LU3ijglct/+++ppA0juDNakAhPO9+n5eNDvkK
         j4EoDbcCzsOsqq99SPBdUal2kMZBoDbiDA4ot9Xi2nSZVWXnyXfp9Dm+tygZ+5TTpN0L
         99vU+OSW4W+F1rTEVhqhSaVql7UI6e1dRNL3QT4A00qcWz9kTtUC5M0ac5CE8yMJQFdd
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991492; x=1771596292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=iqF8pzsxqZhMeenT2N0j2Rg/OtKppqLlnJL00owQGh39GE+7lTwpPhAAufUnnvMk6G
         P2cg+/cg0jTavubQZPdTkWlriJ33t/Sken+4oCsqAb/1TfeW/Zw935obktwHuNYWoCmU
         Gs2zXQjldPYDGLnlLv/EKZ3Ze74x3eDEbYghl1Nd3kNOLLtEjVwVFrd474E55GFOG5cv
         rPPDQXkShBCwPM2vQIFsTWZa+Mt/+RO/Vivdgjonrd2jLBLrKRQxg0p6QrF8CZ4CGvBp
         v18tht9Fwi4uee48F8HZVFUkPAKWjD78LGcnR95qGTgmHFG2b3Kl92gXQCdeHB+PA9Au
         jjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPH1QfL4L/AIZVbu0sQNGbWZ0YvPengZUwU+cPjE9goxTFby73cFoaAnAlwCmNRW//2N3z9/lYgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SPLkLq/e9FZyR/zSRO1feYSDy3IdkXKcV/8gbXv6ZvafMKwZ
	aGZWiPqseUUbO/BUKLb9b5BO7TYRH/nO/Rs5KIP5DLnF689awasbIW1PP0q/nnrkKLY=
X-Gm-Gg: AZuq6aJaetARDQlvQpCN4r62QqXkfJDIkdh3/xWW0Dw4TstZKv507GI2D5ZGYnMiS6h
	8pourFRCADa8NiUclJLXZiH86jXamzrAOxff/mxFRtLgjJ7poJ/wgSodKGgONARfSHljr1q3zgA
	3U8n0jgIbtzRKWJAb/SsCXAvsKww7IXIhHr3+fh6dx+W7p6hz5tDONykwGKHTPnSw+0GNkElHco
	ZvjtZd+Y2XWZMbukFGiR7sPH2L8Pn9J/0Qn+47uwU5fgWovtOlm79PppT2XVrsF6BJrmqM2Fx0L
	rIQ42nrDHHj2q5XaydQeLJ6WRYQYpFDxTk+P2stevvW5oPpKFFfZvDHHZ7FVKrHPjsrmlTrR5Nm
	W2nEkFibOOGK48vjQmpdlNdfQ9ZGLNhUs5rcFnNNcmb4phJzE4kFr1zQADDdcAt9i1Vujd2MYPX
	EpKRbsnYlMiVNnXNoaeuBVydH4F6Vmnylcpcbz9YNm4pBIfq+miAVlgMichBMEqB8DpPV5kZouO
	b7lI/O51A==
X-Received: by 2002:a05:622a:204:b0:4f1:ac12:b01c with SMTP id d75a77b69052e-506a825a264mr22509531cf.3.1770991491488;
        Fri, 13 Feb 2026 06:04:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b94e9fsm60689721cf.24.2026.02.13.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:04:50 -0800 (PST)
Date: Fri, 13 Feb 2026 09:04:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY8vf75vVQ-poVBN@gourry-fedora-PF4VCD3F>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42615-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B150136F8B
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>

Link is broken: bad commit reference

