Return-Path: <linux-pm+bounces-35814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D0BC5262
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B72D4F6714
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7E27B345;
	Wed,  8 Oct 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWBqOXDz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A162777E1
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929202; cv=none; b=alxQ5Y0Bcx0dAtvc76ArUrXsv+bbHsPQs/KdaVA5e7RxAGRFrriXbuBNEjIqii0jZKrXmb6j+tA1jkW4HRKB3EBzqoZ98NZYtpymDarH2Z388kZvpLHguzKn7jqnOWnPaExlPTdU6UTy967hTCNeu9ykgUUqtrtgL0RQwfAnG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929202; c=relaxed/simple;
	bh=qdqX9jLMYGejaeiyk6FmUcIC5rmoUQxx8dbODQQWUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btL5dtMMdIRJ88Y1CwI3+SnCGZvtNifwuOYERerjuyMHdk1Ke5tmeuE+1etX5x4uTxUPZJltfke2TxWbtQC/uEdc+fwDwVlHL1y3G8g2MdiGU/M380Kor1zs75Ot4UaTxnNlkkAyVdP0b1mzfK/+uKyRz93wcyKrIZeomz0jryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NWBqOXDz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so9497708b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759929200; x=1760534000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhirsJUANkMy26KcoRueNjsC5oBNI6RBwD+2LVkuC8E=;
        b=NWBqOXDzfumhglTVy2WJadtXAz0e/wAq+c66jaQcjSBqV4knmVJRF9q83AVAHT1xtv
         B8S4T+35jcQfuGRnd/9Fb8pTNDtkdtezwn2RXZXUQ9izPjZorLp1MXDHLIMW4/tjIm4m
         vPejQ6VmfNYcVazbYtcpfqL+Q237V3vxfJw1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929200; x=1760534000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhirsJUANkMy26KcoRueNjsC5oBNI6RBwD+2LVkuC8E=;
        b=G34WugukUfmLqvOCPhFVGLJKQf1h/TT5eJ4wzCt4omxqB1EEj9IAu5UuP/k2Nqe6NW
         Wrc3X9Ea8jJHy63KeL1VFJOXcok4tgh/zKsTjt5aPNdduIVYeytlsu/N5iqqxIqTx+UY
         TKyiN2N6Oso+a320CQUbwYuVxWazeieGKr6VjCcOBvN21piWjpJv4Ldlt1lNTT0lCfik
         7+Dwv+geChB3Vje+jFqzIwSYPK+NACGMsYA8/S4ZjJLnncCJspIjVpk4Pxk1ktY25Owt
         MAlUDSw7/4gIVJcByl703yAiGj9OtnRbhjUX2e8mauwCQwkBdv1HCWjxT0SzhTBxYdvb
         zZmA==
X-Forwarded-Encrypted: i=1; AJvYcCWEr+rdmN0WrYb1DuuFB4xrhfoKzYXIqZGAwsjX0IgNcgpwU76KykKkaoLt0rqkmuTbDhcSEV+9Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWczz4wCzS5eidWOwDBcrbhOlxCwuyWA8rbzPfwBVE3UN8DJcm
	TqhqsfyIJ5rDy9x5mRocmyVNWxQLd+FQrejd6TwKOa9qgxqCBdBv4yDPv5iEtLd0T6QjS2V9jLu
	ofLM=
X-Gm-Gg: ASbGnctwFEm3z6uYbAFUK2setcwPIpkb40LR6rA2FYDcp7qFhAznk5sM49chm2g8ivY
	9RTbU+iaHycbcrJCen1TAxj8ko6CL4ZVJTM1b9xv+RjUDHdxWI4uTdo9eKWVvs4Cnk2CO/nG9qN
	Y+1p9Jo6hJWLCEhMvY45YvtrEkH72uYqaMY2V3ylW/Qob7VS+YqNZLSbt0j0oeIREy1guMyXUZX
	674gBmFWGuTFHVMPY63HewjtJu+us8aFvD+dfaZpT3EMv5d1I1NxKSi1D0PQXj+s3v42++Z/l52
	3NxBdt6Hz93GLyDRSWYLXYyddNA2rqgQ8/Ex4ZT5aPG86fY9S2KMU4Ti+4l8LsAThaRsOjXgPju
	kwC01DUw8kc527vLtTMdUInAAm+g+kQ8r7vladr3GSlOMXCu98g==
X-Google-Smtp-Source: AGHT+IEjV9K7Hiy+RpgvzEdGQO4CYiP7IP82yjQEQSkRFO4uHcWCY9san8fxpr1MwP0RF/E0cceMIg==
X-Received: by 2002:a05:6a20:7353:b0:2e2:9575:3a32 with SMTP id adf61e73a8af0-32da80db40fmr4538147637.7.1759929199831;
        Wed, 08 Oct 2025 06:13:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ea0758b5sm12777442a12.20.2025.10.08.06.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:13:19 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:13:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Message-ID: <4dsz6s3zfwvfz5iv2labiycqeuu6klry2af4sgzuykpxbzwopg@lulgn7ubg2vu>
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008101408.dj46r66gcfo26sgl@lcpd911>

On (25/10/08 15:44), Dhruva Gole wrote:
[..]
> >  		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> >  		show_stack(wd->tsk, NULL, KERN_EMERG);
> > +		if (dpm_watchdog_all_cpu_backtrace)
> > +			trigger_allbutcpu_cpu_backtrace(this_cpu);
> 
> IMO it would be useful to check the ret val of this as well, I mean just
> incase this silently returns false it maybe confusing to figure out what
> hapenned in the system inspite of setting the mod param.

Honestly, I haven't seen a system that constantly modifies
its modules' params at runtime.  It's usually a pretty static
configuration, so I'm not sure if this will address any real
world problem.

