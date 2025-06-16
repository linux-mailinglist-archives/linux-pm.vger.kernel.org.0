Return-Path: <linux-pm+bounces-28819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D577BADAE47
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA63B7A6EDE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DF2D879F;
	Mon, 16 Jun 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B8am0wsv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7722BDC37
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073063; cv=none; b=oGHxLs4R+kUnJnSk3qmmePfct/K7iEFCm1pBb7VMPg3WBRImVOJ6Y9OqdaIaXUkaE1xe/Cpp193zSAKpcC9bnVh6NMMANMOj+Az6+3779b+r5cbFpnueqJ+8DE3JE1nx0pbqzEjLQM76s+DvzprIIm1X7j6Srk4M0VASLri8LJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073063; c=relaxed/simple;
	bh=RYGk8+VVg+FG2sEDJqIBppxtJnPISJADFzhkbeDohxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKSkMFp8QvfcXnFm+vS+dhT+coQfBnxvxEPThYf/q+k2XO/fcmwgJv0VB2O6DGup5OziGiSRBqkYPDMOdfLmtIx+0/aNMZX73EGMPsCVRY5pODLVSuAEid1L8oSnkEVJsdr+X5G4bBCS1kYZibfLW3eBKk/03DyyYh0iM3R1eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B8am0wsv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so25164125e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750073059; x=1750677859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y633kjMIRrtaH8XsmtUuiW2CJNzynwkqzm256+V0uoc=;
        b=B8am0wsvHQAJPDYo26kSpHvE50zlaFhgaEcdbGuqJplSywLkPENnG1s0Zx2Je8XVRo
         ihc6g3qqBJqYOzqH/0YC13fCzB3Oh/kabfoVUgSbzubDTBZgear0YuAsH5WIAqR/9pD0
         oIURx4uLnkPvZ66IvvdfAQBNv7/5yk+b8IXoZDgGdZ23VRUhB8gOKGFOfOyn+zp+0iel
         zna2cmBIZ4pQCI9IaniRpk3Ms6j/tuBT89x6ruokeYgNHGx4a54Q/hp7yzVwMHUXXkl0
         uw32cX1xj6kFm3gORwJv4kjLNTAmPFeLgCCWZzak9EjotX3L1awAFd2vz4G9Cnt6YeX6
         LmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750073059; x=1750677859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y633kjMIRrtaH8XsmtUuiW2CJNzynwkqzm256+V0uoc=;
        b=Y8Z4+VjLovLgvAPzLIcXoZE7OjBEMMiIEnpT9IwHnjj78pym0ClqpmZvqO0a8oa9Du
         Gf5rA0lws/lFRu+zObWHlaU//AcIYbA7t0d5PTA7AHamO+pUPCC4WMGaAXUIztIHKYFb
         j4hxWQ5RD/OSymSiXNthltJOKtwnOQVR3S27yButtsZIGWEZY9syxXo0TIdztlD0bfYl
         lxwNe32i22GSC0/u48qIRy+VmsJ69b7d4KzMivva6/DXl1/tB4jQ0pcA5h6yDf6AExVW
         imwQBz9nbxqXWjm4kb/TMpsalP00qg2Ae6HW4eeHoeN1guSKZbVC1efsk3Rkbzpo32Jw
         a5ew==
X-Forwarded-Encrypted: i=1; AJvYcCVeH+cLu9fZGhF+lq1VdYXQd/BbstYuCou0hHtoQXWMkRil829qytuBTBmO2bB1B+BxFcqqREkDhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvYHNNxn7M9pKychvnQnmhRbysDwWuuq+zfN6yY9lEZm8AmMY
	8zA9AYGNWKVlW5jFRax+ir7Dt7orSrEepKUp6hxcr4QmUoBP3dN4XZZ3BWJz4brxg/k=
X-Gm-Gg: ASbGncuACicaT7Wc7ba4sKOK4YkRLtT+jUYW7Bi7yQHtukq6h4opc03F0i1u2FbSeFb
	cOYY6kjOYmJN0eDCZDg5x10oMwR+DUj2Inbi951lsWd2bYdg6xUw6B81KR20zi1ZSmP9QMRZ4JM
	udy8pamD26mHCNMJJ7P+JZ7eRs15tehN4aJsLEcL1VDCZ+3fgJW59s7+ui+MXty7sIhNjBlAceA
	Uu/hXGi0UKNwh+7LcoZuX8GB1Fqq2LY5SkyioU9VACZSXHAG8XWD84G8tnl5UaknJRfJ1Rb9ptu
	OGfFKhwcJKZncG94f+38EFKvhlwgBxkfvFTxfRr636XNRSUO8dcseY2E35cqlg4=
X-Google-Smtp-Source: AGHT+IHtfazRSuYsyft8MUUE/xCVsnjhRlEfdqxQjJFcgVmcPTPpE27KR12sx+SwGyuiRh7fkpsvtw==
X-Received: by 2002:a05:600c:4e14:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-4533ca572f5mr87804695e9.14.1750073059287;
        Mon, 16 Jun 2025 04:24:19 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e16a097sm146045855e9.33.2025.06.16.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:24:18 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:24:18 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>,
	Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
	len.brown@intel.com, pavel@kernel.org, kees@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
Message-ID: <aE_-4nMTvx3m9lmY@tiehlicka>
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
 <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
 <aEvNqY5piB02l20T@tiehlicka>
 <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
 <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>

On Mon 16-06-25 09:45:59, David Hildenbrand wrote:
> 
> > > [...]
> > In our test scenario, although new processes can indeed be created
> > during the usleep_range() intervals between freeze iterations, it’s
> > actually difficult to make the freezer fail outright. This is because
> > user processes are forcibly frozen: when they return to user space and
> > check for pending signals, they enter try_to_freeze() and transition
> > into the refrigerator.
> > 
> > However, since the scheduler is fair by design, it gives both newly
> > forked tasks and yet-to-be-frozen tasks a chance to run. This
> > competition for CPU time can slightly delay the overall freeze process.
> > While this typically doesn’t lead to failure, it does cause more retries
> > than necessary, especially under CPU pressure.
> 
> I think that goes back to my original comment: why are we even allowing fork
> children to run at all when we are currently freezing all tasks?

The same should be the case for cgroup freezer as well.
-- 
Michal Hocko
SUSE Labs

