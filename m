Return-Path: <linux-pm+bounces-3374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22910849580
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A3A1C22F7A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90411184;
	Mon,  5 Feb 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+cXlPZd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734561170A
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122314; cv=none; b=CURrhpa9PedQNiTCYWy0g/mUU1UO0brRx7Xz5/rLd3SWyYPHYBNnaXbVXjOdMxKAa4S+Iy6azuRv1W4OMIOazUimAe5mSbQO+r/rUorEfH8gACiPT6UNyEY7bm5RC9eafvuHiFWiZpdG6fRecHQRSN3J6jovHsLXQn5l4jpjYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122314; c=relaxed/simple;
	bh=3LmgSibEXomUKPO63HkaRhVDpYnceZtyNFTYsQfKJns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0ATT0du2SRNa0L4IDBxVlAAkedj7ClADf8A70TyHRZwsOdws/uBmCerEHxZGnxYGHNqlAPpy1K+H0saRt4OHQaFsASQnPQlplzvYA29gMmcxoi/7VdBUY9Ccl0ZNRIOgfie/eRvS3yxUm4CxRhKsSVIRXLoMPcjFcDZBhEE/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+cXlPZd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71cb97937so36460805ad.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707122313; x=1707727113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzUq0QU1iLhov+1WYKZ5iVgod62Dx1DjglJhN8m0PAE=;
        b=T+cXlPZd367U7+rLzfZlkoCBnSkX3j5R/RrgiVeGJgG8C/w43zhoKETYv2aOSPbpUR
         fuAkSK0nhpc/tSA92w9+qQGCuWmNY4xelwxxrIZl8Y1BJiv/FySG3xd+bC0MQTDlKPo5
         4a3hUMeIwAbNOWggeBW3n58+kYi/xC/31yZPY1gfpomSKtYvg/sSFSIIkqgBw5OXlvqj
         FKdl3UUJ0Qudk3KRplXnnUMvMziSrF9/NwWq6FmgyyY1f949Zt2VVRPrhCLit6N5ld1s
         EWqigldIcCxBQ0r3vMFER8gnHFvQet6b0Zc4wLBT1izPvYis0jbJB5y/7snL7h+LjA8T
         mS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707122313; x=1707727113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzUq0QU1iLhov+1WYKZ5iVgod62Dx1DjglJhN8m0PAE=;
        b=MtSpT9noh2SYuGPp+coG9GliWsjMMMdhQI9RhC6PNAgIi6b7QRkee7zpN1Bqo4O6qr
         L8mt1n1xWUzawAlWzRkz/U7YHHcTKlgnwbN2ZM1zWGLqGg0mV9VmltS3eH1MVPsMFqLB
         Rg68StqEmo+96M82Jv9SMldJEMYRvHrXo3hMYnUv/6CkUVabpTxfwrG0DTC7ZVWCGOpB
         amftGYXqRbY4tr0Nb8ID1V5fDzpMMCyoXRVN3GvOlOFmtpsCX8UO7ZJAVCCjfYnTBVIX
         nR2b6KKSpFIAdOewfzg+GFHRoD+fYfhMAjBssAzCXb0XiE2v3e+X0z1rUNXuhezhLojb
         amWA==
X-Gm-Message-State: AOJu0YySa3OlFIc6mTLL8NUCBPdAd228laMuh70XE84LdOPwwSMCcTJt
	7XLOwyZGx4/amU9hOZ+LPR7FnEE/nilMGibAdq4NOgn/Qm30A9350LdHpNea76Y=
X-Google-Smtp-Source: AGHT+IFlHMcwipPv/5fS9RA0N7CHAoHC9ENOUI7UQ64mLeAdNBX232vnbn/8H284Q02YLTeeS+jlhw==
X-Received: by 2002:a17:902:e5c7:b0:1d9:7a7a:3d01 with SMTP id u7-20020a170902e5c700b001d97a7a3d01mr7580530plf.23.1707122312801;
        Mon, 05 Feb 2024 00:38:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXfI2w+6dUAdaog5bJtoPlJM3p3ukBSikiWgzTm8BAqW0h7zGRqU7hx3UCGq7cTibBB8HARSP/XisA0uN+w9+FqdvqdeHJcVO0mfGc7ziQoQyXOZ7grsTx10xaypoxwpyExjkSzrysipLtwsKTy/DbFHWb/pjQ/VaDQNP54POfBXXfc50N8c0dSeCQnnZDV1rQl/GwCcqymS4cy0e+KMRoATbWVS7VNFUoxcTxHrbbl/iJAtaQsCjIaisPJnVzlyGemCHDWDX+U0bniwkNxCWC6gkHYWuSZyKtEMLtsXupZnvMhqwFiXpzivjLHsAd9eAj71NRm/mAc32aaParxZPwNgj6b36hqk6Rd+MaDSLQtzEAjoChdChpKMUkafF8b+2Kd6vQ85HUy8XN6hBQMWrEH9hLIUeY9osriah/T3E2rh5eyHYWHezWPu9gpgkmMdbR3ZteEpUbi3l3AIe4XCcCdNLQgS2msiz/gCyf1/ugvQQLXJHzcA9h/mlNPxgdIzNNUqfRPV1a1hQ46+WgKwIskB+QDnn047Ob6XWdb1Y7zgHlFQU7xr/ipwWjZzunXXHEX2S8lZFGOXlWpI1F/cWzUXZAnprTHQ5/nNf6MUd97ty8YnKrrEpD8adDaa0Z8eps8kNajrf8F46HOl2qu05YBjty2nRwOK4Pm5BIh/OQJAKYudC5xAor0TzHqgedJpd1c66sWfdshOdQ=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d60a70809bsm5782825plb.168.2024.02.05.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:38:32 -0800 (PST)
Date: Mon, 5 Feb 2024 14:08:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, David Dai <davidai@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20240205083830.4werub5e76kudjq4@vireshk-i7>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
 <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202155352.GA37864-robh@kernel.org>

On 02-02-24, 09:53, Rob Herring wrote:
> On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > We also need the OPP tables to indicate which CPUs are part of the
> > same cluster, etc. Don't want to invent a new "protocol" and just use
> > existing DT bindings.
> 
> Topology binding is for that.

This one, right ?

Documentation/devicetree/bindings/dvfs/performance-domain.yaml

> You need per CPU Fmax, sure. But all the frequencies? I don't follow why 
> you don't just have a max available capacity and then request the 
> desired capacity. Then the host maps that to an underlying OPP. Why have 
> an intermediate set of fake frequencies?

+1

> As these are normalized, I guess you are normalizing for capacity as 
> well? Or you are using "capacity-dmips-mhz"? 
> 
> I'm also lost how this would work when you migrate and the underlying 
> CPU changes. The DT is fixed.
> 
> > > Also, we have "opp-level" for opaque values that aren't Hz.
> > 
> > Still want to keep it Hz to be compatible with arch_freq_scale and
> > when virtualized CPU perf counters are available.

These are all specific to a driver only, that can be handled easily I guess. I
don't see a value to using Hz for this to be honest.

-- 
viresh

